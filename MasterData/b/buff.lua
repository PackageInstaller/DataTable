require "class"
---@class Buff:BaseClass
local Buff = class("Buff")
local ExtraAttributeController = require "ExtraAttributeController"
local ImmuneController = require "ImmuneController"
local battleCore = require "BattleCore"

---@class EffectAttribData
---@field _sourceAttrib integer 依赖的属性
---@field _attribOffsetValue number 变化系数

---@param data BuffData
function Buff:ctor(data)
    self.id = data.id --buffid

    self.sourceId = data.source.id
    self._remainRounds = data.rounds --剩余回合
    self._curLevel = 1               --当前层级

    self._effectActivationLimit = nil --效果生效次数限制

    ---@type table<integer, integer>
    self._replaceSkillList = {}
    ---@type table<integer, integer>
    self._replacePassiveSkillList = {}
    ---@type integer[]
    self._additionalPassiveSkillList = {}

    ---@type table<SkillRangeChangeType,integer> 技能覆盖范围
    self._skillConverRangeChangeList = {}
    ---@type table<SkillRangeChangeType,integer> 技能选择范围
    self._skillSelectRangeChangeList = {}
    ---@type table<integer,integer> 技能选择范围按技能标签
    self._skillSelectRangeChangeBySkillTag = nil

    ---@type number[] 舰种克制修正列表
    self._restarintRatio = nil
    ---@type number[] 地形修正列表
    self._terrainRatio = {}

    ---@type BuffTable
    local buffConfig = data.buffConfig
    self.configData = buffConfig
    self._maxLevel = buffConfig.maxLevel or 1 --最高层级
    self._tags = buffConfig.immuneType or {}  --标签
    self.groupId = buffConfig.groupId         --组id
    self.order = buffConfig.order             --优先级

    ---@type ExtraAttributeController
    self.exAttribController = ExtraAttributeController:new(self) --特殊属性
    ---@type ImmuneController
    self.immuneController = ImmuneController:new(self)           --免疫控制器

    self._needCheckAttrib = {}

    ---@type table<integer,integer>?
    self._moveCostOffsetDic = nil

    ---@type table<AttribType, EffectAttribData>? 受影响的属性
    self._effectAttribType = nil

    ---@type table<SkillAffixType,integer> buff类型字典，用于快速查找（如禁疗，眩晕等）
    self._buffTypeDic = {}
    ---额外参数1，辅助某些特殊buff使用
    self._exParam1 = nil
    ---额外参数2，辅助某些特殊buff使用
    self._exParam2 = nil
    local effectIds = self.configData.effectId
    if effectIds then
        for _, id in ipairs(effectIds) do
            local effectData = Config.GetEffectInfo(id)
            if effectData then
                local effectAttriType = effectData.effectAttriType
                self._buffTypeDic[effectAttriType] = 1

                ---TODO 特殊处理，后续有需要再扩展
                if effectAttriType == GE.SkillAffixType.MustLeftOneHp or effectAttriType == GE.SkillAffixType.CanNotBeDamage then
                    local param1 = effectData.otherParam2
                    local leftTime = (param1 and next(param1)) and param1[1] or 1
                    if leftTime == -1 then
                        leftTime = 99
                    end
                    self._effectActivationLimit = leftTime

                    self._exParam1 = effectData.otherParam1
                    self._exParam2 = effectData.otherParam2
                elseif effectAttriType == GE.SkillAffixType.TransferDamageToBuffSource then
                    self._exParam1 = effectData.otherParam1
                    self._exParam2 = effectData.otherParam2
                end
            end
        end
    end

    ---@type table<integer,integer>?
    self._addBuffRoundOffsetDic = nil
    ---@type table<integer,integer>?
    self._setBuffRoundOffsetDic = nil
    ---@type table<integer,integer>? 需要保持回合数不变的buff标签列表
    self._keepBuffRoundDic = nil

    self._isPassCondition = false
end

---@param roleID integer
function Buff:setOwner(roleID)
    self._ownerID = roleID
end

---@return BattleRole
function Buff:getOwner()
    local roleMgr = battleCore:getBattleMgr():getRoleManager()
    local role = roleMgr:getRole(self._ownerID, true)
    return role
end

---获取剩余回合数
---@return integer
function Buff:getRemainRounds()
    return self._remainRounds
end

function Buff:changeRemainRound(value)
    local afterValue = self._remainRounds + value
    if afterValue < 0 then
        afterValue = 0
    elseif afterValue > 99 then
        afterValue = 99
    end
    self._remainRounds = afterValue
end

---减少剩余回合数
function Buff:reduceRemainRounds()
    --99回合为永久生效
    if (self._remainRounds < 99) then
        self._remainRounds = self._remainRounds - 1
    end
end

---设置剩余回合数
---@param rounds integer 回合数
function Buff:refreshRemainRounds(rounds)
    self._remainRounds = rounds
end

---获取Buff等级
---@return integer
function Buff:getLevel()
    return self._curLevel
end

---是否达到顶级
---@return boolean
function Buff:isMaxLevel()
    return self._curLevel >= self._maxLevel
end

---增加Buff等级
---@param remainRounds integer 剩余回合数
function Buff:addLevel(remainRounds)
    if (self._curLevel < self._maxLevel) then
        self._curLevel = self._curLevel + 1
        self._remainRounds = remainRounds
    end
end

---获取标签
---@return table _tags 标签列表
function Buff:getTags()
    return self._tags
end

---检测标签是否存在
---@param tag integer 标签
---@return boolean
function Buff:isTagExist(tag)
    for _, t in ipairs(self._tags) do
        if (t == tag) then
            return true
        end
    end
    return false
end

---减少效果生效次数，归零时移除当前Buff
function Buff:reduceEffectLimit()
    if self._effectActivationLimit and self._effectActivationLimit < 99 then
        self._effectActivationLimit = self._effectActivationLimit - 1
    end
end

---获取效果生效次数，默认为1，归零时移除当前Buff
---@return integer
function Buff:getEffectLimit()
    return self._effectActivationLimit or 1
end

---获取是否通过条件检测
---@return boolean
function Buff:getIsPassCondition()
    return self._isPassCondition
end

---设置额外属性
---@param attribType string 属性类型
---@param value any 属性值
---@param periodType integer 持续类型
function Buff:setExAttrib(attribType, value, periodType)
    self.exAttribController:setExAttrib(attribType, value, periodType)
end

---检查buff是否通过检查
---@return boolean
function Buff:checkBuffCondition()
    local r = false
    local battleMgr = battleCore:getBattleMgr()
    local isSimpleVerify = battleMgr:isSimpleVerify()
    ---简易验证状态下不做条件检测
    if isSimpleVerify then
        r = true
    else
        if self._isChecking ~= true then
            self._isChecking = true
            local owner = self:getOwner()
            local conditionHandler = battleCore:getSkillConditionHandler()
            local isPass = conditionHandler:checkAllConditions(self.configData.effectCondition, owner, owner)
            local isImmuneList = false
            local immuneList = owner:getImmuneList(GE.SkillAffixType.ImmuneBuffEffect)
            for _, tag in ipairs(immuneList) do
                local hasTag = self:isTagExist(tag)
                if hasTag then
                    isImmuneList = true
                    break
                end
            end
            self._isChecking = false
            r = isPass and isImmuneList == false
        end
    end
    self._isPassCondition = r
    return r
end

---获取额外属性
---@param attribType string 属性类型
---@return any
function Buff:getExAttrib(attribType)
    local attributeValue = 0
    local r = self.exAttribController:getExAttrib(attribType)
    if r ~= 0 and self:checkBuffCondition() then
        attributeValue = r
    end
    return attributeValue
end

---设置受其它属性影响的额外属性，受影响的属性根据依赖属性的百分比加成
---@param effectAttrib AttribType 受影响的属性
---@param sourceAttrib AttribType 依赖的属性
---@param offsetNum number 变化系数
function Buff:setFormOtherAttribData(effectAttrib, sourceAttrib, offsetNum)
    if self._effectAttribType == nil then
        self._effectAttribType = {}
    end
    ---@type EffectAttribData
    local t = {
        _sourceAttrib = sourceAttrib,
        _attribOffsetValue = offsetNum
    }
    self._effectAttribType[effectAttrib] = t
end

---获取受其它属性影响的额外属性
---@param attribType AttribType 属性类型
---@return any
function Buff:getFromOtherAttrib(attribType)
    local attributeValue = 0
    local attribIds = self._effectAttribType
    local data = nil
    if attribIds then
        data = attribIds[attribType]
    end
    if data then
        if self:checkBuffCondition() then
            local owner = self:getOwner()
            local baseValue = owner:getAttributeBaseValue(data._sourceAttrib)
            attributeValue = baseValue * data._attribOffsetValue
        end
    end
    return attributeValue
end

function Buff:setReplaceActiveSkillList(list)
    self._replaceSkillList = list
end

function Buff:getReplaceActiveSkillList()
    local result = nil
    if next(self._replaceSkillList) ~= nil then
        if self:checkBuffCondition() then
            result = self._replaceSkillList
        end
    end
    return result
end

function Buff:setReplacePassiveSkillList(list)
    self._replacePassiveSkillList = list
end

function Buff:getReplacePassiveSkillList()
    local result = nil
    if next(self._replacePassiveSkillList) ~= nil then
        if self:checkBuffCondition() then
            result = self._replacePassiveSkillList
        end
    end
    return result
end

function Buff:setAdditionalPassiveSkillList(list)
    self._additionalPassiveSkillList = list
end

function Buff:getAdditionalPassiveSkillList()
    local result = nil
    if next(self._additionalPassiveSkillList) ~= nil then
        if self:checkBuffCondition() then
            result = self._additionalPassiveSkillList
        end
    end
    return result
end

function Buff:setRestraintRatioList(list)
    self._restarintRatio = list
end

function Buff:getRestraintRatioList(restraintType)
    local result = nil
    if self._restarintRatio and next(self._restarintRatio) ~= nil then
        if self:checkBuffCondition() then
            result = self._restarintRatio[restraintType] or 0
        end
    end
    return result
end

function Buff:setTerrainRatioList(tagList, value)
    for _, tag in ipairs(tagList) do
        self._terrainRatio[tag] = value
    end
end

function Buff:getTerrainRatioList(terrainTags)
    local result = 0
    if self._terrainRatio then
        if self:checkBuffCondition() then
            for _, tag in ipairs(terrainTags) do
                if self._terrainRatio[tag] then
                    result = self._terrainRatio[tag]
                    break
                end
            end
        end
    end
    return result
end

---@param key integer 地形id
---@param value integer?
function Buff:setMoveCostOffsetDic(key, value)
    if not self._moveCostOffsetDic then
        self._moveCostOffsetDic = {}
    end
    self._moveCostOffsetDic[key] = value
end

function Buff:getMoveCostOffset()
    local r = nil
    if self._moveCostOffsetDic and self:checkBuffCondition() then
        r = self._moveCostOffsetDic
    end
    return r
end

---设置免疫列表
---@param type SkillAffixType 效果类型
---@param list table 免疫效果列表
function Buff:setImmuneList(type, list)
    self.immuneController:setImmuneList(type, list)
end

---获取免疫列表
---@param type SkillAffixType 效果类型
function Buff:getImmuneList(type)
    return self.immuneController:getImmuneList(type)
end

---@param changeType SkillRangeChangeType
---@param changeValue integer
function Buff:setSkillCoverRangeChangeList(changeType, changeValue)
    self._skillConverRangeChangeList[changeType] = changeValue
end

---@param changeType SkillRangeChangeType
function Buff:getSkillCoverRangeChangeValue(changeType)
    local result = 0
    local value = self._skillConverRangeChangeList[changeType]
    if value ~= nil then
        if self:checkBuffCondition() then
            result = value
        end
    end
    return result
end

---@param changeType SkillRangeChangeType
---@param changeValue integer
function Buff:setSkillSelectRangeChangeList(changeType, changeValue)
    self._skillSelectRangeChangeList[changeType] = changeValue
end

---@param changeType SkillRangeChangeType
function Buff:getSkillSelectRangeChangeValue(changeType)
    local result = 0
    local value = self._skillSelectRangeChangeList[changeType]
    if value ~= nil then
        if self:checkBuffCondition() then
            result = value
        end
    end
    return result
end

---@param buffTag integer
---@param value integer
function Buff:setAddBuffRoundOffsetDic(buffTag, value)
    if not self._addBuffRoundOffsetDic then
        self._addBuffRoundOffsetDic = {}
    end
    self._addBuffRoundOffsetDic[buffTag] = value
end

function Buff:getAddBuffRoundOffset()
    local r = nil
    if self._addBuffRoundOffsetDic and self:checkBuffCondition() then
        r = self._addBuffRoundOffsetDic
    end
    return r
end

---@param buffTag integer
---@param value integer
function Buff:setSetBuffRoundOffsetDic(buffTag, value)
    if not self._setBuffRoundOffsetDic then
        self._setBuffRoundOffsetDic = {}
    end
    self._setBuffRoundOffsetDic[buffTag] = value
end

function Buff:getSetBuffRoundOffset()
    local r = nil
    if self._setBuffRoundOffsetDic and self:checkBuffCondition() then
        r = self._setBuffRoundOffsetDic
    end
    return r
end

function Buff:setKeepBuffRoundDic(buffTag)
    if not self._keepBuffRoundDic then
        self._keepBuffRoundDic = {}
    end
    self._keepBuffRoundDic[buffTag] = 1
end

---获取保持回合数不变的buff标签字典
function Buff:getHasKeepBuffRoundDic()
    return self._keepBuffRoundDic
end

---检测buff类型是否存在
---@param buffType SkillAffixType buff类型
function Buff:checkBuffTypeExist(buffType)
    if self._buffTypeDic[buffType] then
        return true
    end
    return false
end

function Buff:setSkillSelectRangeChangeBySkillTag(skillTag, changeValue)
    if not self._skillSelectRangeChangeBySkillTag then
        self._skillSelectRangeChangeBySkillTag = {}
    end
    self._skillSelectRangeChangeBySkillTag[skillTag] = changeValue
end

---@param skillTagList integer[] 技能标签
function Buff:getSkillSelectRangeChangeBySkillTag(skillTagList)
    local result = 0
    if self._skillSelectRangeChangeBySkillTag and skillTagList and tablex.next(skillTagList) then
        for _, skillTag in ipairs(skillTagList) do
            local value = self._skillSelectRangeChangeBySkillTag[skillTag]
            if value ~= nil then
                if self:checkBuffCondition() then
                    result = result + value
                end
            end
        end
    end
    return result
end

---获取额外参数1
function Buff:getExParam1()
    return self._exParam1
end

---获取额外参数2
function Buff:getExParam2()
    return self._exParam2
end

---回溯还原：恢复层级与剩余回合
---@param level integer
---@param remainRounds integer
function Buff:restoreLevel(level, remainRounds)
    self._curLevel = level
    self._remainRounds = remainRounds
end

---回溯还原：恢复效果生效次数限制
---@param limit integer?
function Buff:restoreEffectActivationLimit(limit)
    self._effectActivationLimit = limit
end

return Buff
