require "class"
local BaseRole = require "BaseRole"
---@class BattleRole:BaseRole
local BattleRole = class("BattleRole", BaseRole)
local BuffController = require "BuffController"
local ExtraAttributeController = require "ExtraAttributeController"
local ImmuneController = require "ImmuneController"
local BattleCore = require "BattleCore"


--战斗角色
---@param data LevelRoleData
---@param mgr BattleRoleManager
---@param isReset boolean?
function BattleRole:ctor(data, mgr, isReset)
    -- LuaLogger.ds("BattleRole ctor")
    BaseRole.ctor(self, data)
    ---@type BattleRoleManager
    self._roleMgr = mgr
    ---@type BattleBlock 所处地格，如果是被击败状态，则没有所处地格信息，需要在重置角色时判断
    self.block = data.block
    -- self.root = nil
    -- self.spine = nil
    ---@type BattleBlock?
    self.tmpBlock = nil

    self.level = 1  --等级
    self.showLevel = 1 --展示等级
    ---@type CharacterTable|MonsterTable
    self.roleConfig = nil
    self.serverData = nil
    ---@type boolean 确定角色配置是从配置表取还是从服务器数据取，并非判断是否为怪物
    self.isMonster = data.isMonster
    self.groupId = data.group or 0
    ---@type boolean
    self._active = true
    self.talentId = nil
    self.skillList = {}
    self.passiveSkillList = {}
    ---@type table<integer, RefreshEffectData>
    self._needRefreshEffectList = {}
    local battleMgr = BattleCore:getBattleMgr()
    if (self.isMonster) then
        self.roleConfig = Config.GetMonsterInfo(self.cid)
        self.skinConfig = Config.GetCharacterSkinInfo(self.roleConfig.baseSkinID)
        self.level = data.level
        self.showLevel = data.showLevel
        self.talentId = self.roleConfig.talentId
        self.skillList = self.roleConfig.baseSkill
        self.passiveSkillList = self.roleConfig.passiveSkill
        self.bulletModel = self.skinConfig.bulletModel --子弹模型
        self:_initBattleAttrib(self.roleConfig, data.level)
        if data.baseMaxHp then
            self.baseMaxHp = data.baseMaxHp
            self.maxHp = self.baseMaxHp
            self.hp = self.maxHp
        end
    else
        self.roleConfig = Config.GetCharacterInfo(self.cid)
        self.serverData = tablex.copy(battleMgr:getHeroServerData(self.cid))
        self.skinConfig = Config.GetCharacterSkinInfo(self.serverData.equipSkin)
        self.level = self.serverData.level
        self.showLevel = self.level
        self.talentId = self.roleConfig.talentId[self.serverData.star]
        self.skillList = self.serverData.EquippedSkillList
        local tbPassiveSkill = self.roleConfig.passiveSkill
        ---@type integer[]
        self.passiveSkillList = tablex.combine(tbPassiveSkill, self.serverData.effectiveSkill)
        -- LuaLogger.ds("self.roleConfig", tablex.dump(self.roleConfig))\

        self.bulletModel = self.skinConfig.bulletModel --子弹模型
        -- LuaLogger.ds("self.bulletModel", tablex.dump(self.bulletModel))
        local weaponList = self.serverData.carryWeapon
        local weaponId = weaponList and weaponList[1] or 0
        local weaponCid = battleMgr:getWeaponCidById(weaponId) or 0
        if weaponCid > 0 then
            local weaponConfig = Config.GetWeaponInfo(weaponCid)
            if (weaponConfig.bulletModel and weaponConfig.bulletModel[2]) then
                self.bulletModel[weaponConfig.bulletModel[1]] = weaponConfig.bulletModel[2]
            end
        end
        -- Me:setHeroAttribute(self.serverData)
        self:_initBattleAttrib(self.serverData)
    end
    self.airDefenseEff = self.skinConfig.airDefenseEff or 0
    ---@type integer  AI的行动状态
    self._aiState = 1
    self.movePower = self.roleConfig.movePowr --移动力
    self._remainMovePower = self.movePower --剩余移动力
    self.baseDamageRate = self.roleConfig.baseDamageRate
    self.normalSkill1 = self.roleConfig.normalSkill
    self.normalSkill2 = self.roleConfig.normalSkill2
    self.normalSkill = self.normalSkill1

    local charRestraintConfig = Config.GetCharacterRestraintInfo(self.roleConfig.attribute)
    self.restraintType = charRestraintConfig.restraintType --克制类型
    ---@type integer 移动方式
    self.moveType = self.roleConfig.moveType            --移动方式
    ------------------------------------------------------------

    self._initEffectsList = {}
    self.haloSkillList = {}
    self._skillCDList = {}
    ---@type table<integer,integer> 技能弹药使用数量
    self._skillAmmoUsedList = {}
    -- self._passiveEffectsList = {}
    ---@type BuffController
    self.buffController = BuffController:new(self)
    ---@type ExtraAttributeController
    self.exAttribController = ExtraAttributeController:new(self) --特殊属性
    ---@type ImmuneController
    self.immuneController = ImmuneController:new(self)        --免疫控制器

    self._isAlive = true
    self._isMyTurn = false
    self._isFreeMoveState = false
    self._actionFlowIndex = 0
    self._flowDelay = 0
    self._pauseActionFlow = false
    ---@type integer? 再移动类型
    self._moveAgainType = nil
    self._actionAgainType = nil --再行动类型
    ---@type integer? 效果传入的再移动或再行动的移动力
    self._againMovePower = nil
    self._flowTiming = {
        [1] = GE.BattleTiming.OnAction,
        [2] = GE.BattleTiming.ActionFeedback,
        [3] = GE.BattleTiming.OnActionFinish
    }
    self._flowTimingCount = #self._flowTiming
    self._waypointList = {}
    ---@type integer[]?
    self._movePathList = nil
    self._hasMoveDistance = nil
    self.skillTargetBlock = nil --技能目标地格

    ---@type BattleBlock[]?
    self.skillFilteredTargets = nil
    self.skillFindTarget = nil
    ---@type integer
    self.direction = data.direction --朝向
    self:setOrgDirection(self.direction)
    if self.block then
        self.block:setRoleId(self.id)           --roleId = self.id
        table.insert(self._waypointList, self.block.id)
    end
    self._curMoveRange = {}                 --当前移动范围
    self._curAtkRange = {}                  --当前攻击范围
    self._curAtkRangeKV = {}  --当前攻击范围，kvTable
    self._curMoveRangeKV = {}  --当前移动范围，kvTable
    ---@type integer[]? 技能选择释放的方向（仅限可选择释放方向的技能）
    self._skillDir = nil

    self:_initAttribEvent()
    self:_initBaseAttribEvent()
    self._attribBaseValue = {}
    self._attribTotalValue = {}
    self:UpdateAllBuff()

    self._skillSelectState = GE.SkillSelectType.None

    -- 行动标签列表，行动完成后清空
    self._actionTagList = {}
    -- 与自身产生过技能交互的人物列表，行动完成后清空
    self._roleActionList = {}
    ---当前回合造成的伤害
    self._curTurnDamageValue = 0
    -- 与自身产生过效果交互的列表，行动完成后清空
    self._effectActionList = {}

    ---当前回合收到的所有伤害
    self._curTurnBeDamagedValue = 0
    self._summonEffectId = 0
    -- self:_initEffects()
    if (not isReset and self.block) then
        self:createRole(self.block, data)
    end
end

function BattleRole:UpdateAllBuff()
    self:updateAttributeBaseValue()
    self:updateAttributeTotalValue()
    self.buffController:updateAllCacheFiled()
end

---开始战斗时，依据服务器发回的信息重置下角色的属性
---@param serverData BattleHeroInfo
function BattleRole:initServerData(serverData)
    self.serverData = tablex.copy(serverData)
    self.skillList = self.serverData.EquippedSkillList or {}
    self.passiveSkillList = tablex.combine(self.roleConfig.passiveSkill or {}, self.serverData.effectiveSkill or {})
    self:_initBattleAttrib(self.serverData)
    self:UpdateAllBuff()
end

---@param battleAttrib CharacterTable|MonsterTable|BattleHeroInfo
---@param levelValue integer?
function BattleRole:_initBattleAttrib(battleAttrib, levelValue)
    self.baseMaxHp = math.floor(battleAttrib.hp * (levelValue or 1))
    self.maxHp = self.baseMaxHp                                --最大血量
    self.hp = self.maxHp                                       --血量
    self.bombard = math.floor(battleAttrib.bombard * (levelValue or 1))     --炮击
    self.torpedo = math.floor(battleAttrib.torpedo * (levelValue or 1))    --雷击
    self.armor = math.floor(battleAttrib.armor * (levelValue or 1))        --装甲
    self.evade = math.floor(battleAttrib.evade * (levelValue or 1))        --机动
    self.airdefense = math.floor(battleAttrib.airdefense * (levelValue or 1)) --防空
    self.lucky = battleAttrib.lucky                            --幸运
end

---初始化属性事件
function BattleRole:_initAttribEvent()
    self._attribEvent = {
        [GE.AttribType.Hp] = function()
            return self.hp
        end,
        [GE.AttribType.MaxHp] = function()
            return math.floor(self:_calculateAttrib(self.baseMaxHp, "Hp"))
        end,
        [GE.AttribType.Bombard] = function()
            return math.max(0, math.floor(self:_calculateAttrib(self.bombard, "Bombard")))
        end,
        [GE.AttribType.Torpedo] = function()
            return math.max(0, math.floor(self:_calculateAttrib(self.torpedo, "Torpedo")))
        end,
        [GE.AttribType.Armor] = function()
            return math.max(0, math.floor(self:_calculateAttrib(self.armor, "Armor")))
        end,
        [GE.AttribType.Evade] = function()
            return math.max(0, math.floor(self:_calculateAttrib(self.evade, "Evade")))
        end,
        [GE.AttribType.AirDefense] = function()
            return math.max(0, math.floor(self:_calculateAttrib(self.airdefense, "AirDefense")))
        end,
        [GE.AttribType.Lucky] = function()
            return math.max(0, math.floor(self:_calculateAttrib(self.lucky, "Lucky")))
        end,
        [GE.AttribType.BaseDamageRate] = function()
            return self:_calculateAttrib(self.baseDamageRate, "BaseDamageRate")
        end,
        [GE.AttribType.MovePower] = function()
            return math.max(0, math.floor(self:_calculateAttrib(self.movePower, "MovePower")))
        end,
        [GE.AttribType.DamageRatio] = function()
            return self:_calculateAttrib(0, "DamageRatio")
        end,
        [GE.AttribType.DamageRatioB] = function()
            return self:_calculateAttrib(0, "DamageRatioB")
        end,
        [GE.AttribType.SkillAddRatio] = function()
            return self:_calculateAttrib(0, "SkillAddRatio")
        end,
        [GE.AttribType.CritRatio] = function()
            return self:_calculateAttrib(0, "CritRatio")
        end,
        [GE.AttribType.IntelHuntCut] = function()
            return self:_calculateAttrib(0, "IntelHuntCut")
        end,
        [GE.AttribType.RestraintBuffRatio] = function()
            return self:_calculateAttrib(0, "RestraintBuffRatio")
        end,
        [GE.AttribType.HealthRatio] = function()
            return self:_calculateAttrib(0, "HealthRatio")
        end,
        [GE.AttribType.BeHealthRatio] = function()
            return self:_calculateAttrib(0, "BeHealthRatio")
        end,
        [GE.AttribType.CritRateRatio] = function()
            return self:_calculateAttrib(0, "CritRateRatio")
        end,
        [GE.AttribType.AntiCritRateRatio] = function()
            return self:_calculateAttrib(0, "AntiCritRateRatio")
        end,
        [GE.AttribType.ModifyHpRatio] = function()
            return math.max(0.01, self:_calculateAttrib(1, "ModifyHpRatio"))
        end,
        [GE.AttribType.CurHpPercent] = function()
            local curHp = self:getAttrib(GE.AttribType.Hp)
            local maxHp = self:getAttrib(GE.AttribType.MaxHp)
            if maxHp <= 0 then
                return 0
            end
            return curHp / maxHp
        end,
        [GE.AttribType.CurLostHpPercent] = function()
            local curHp = self:getAttrib(GE.AttribType.Hp)
            local maxHp = self:getAttrib(GE.AttribType.MaxHp)
            if maxHp <= 0 then
                return 0
            end
            local hpPercent = curHp / maxHp
            local r = 1 - hpPercent
            return r
        end,
        default = function(attribType)
            BattleCore.ds("BattleRole getAttrib attribType", attribType)
            return self:getExAttrib(attribType) + self.buffController:getExAttrib(attribType)
        end
    }
    self._attribKeys = {}
    self._attribTotalKeys = {}
    self._attribBonusTypeCache = {}
    self._attribPercentageBonusTypeCache = {}
    local baseIndex = 1
    local totalIndex = 1
    for key, _ in pairs(self._attribEvent) do
        if type(key) == "number" then
            self._attribKeys[baseIndex] = key
            baseIndex = baseIndex + 1
            if key ~= GE.AttribType.Hp then
                self._attribTotalKeys[totalIndex] = key
                totalIndex = totalIndex + 1
            end
        end
    end
end

---初始化基础属性事件
function BattleRole:_initBaseAttribEvent()
    self._baseAttribEvent = {
        [GE.AttribType.Hp] = function()
            return self.hp
        end,
        [GE.AttribType.MaxHp] = function()
            return self.baseMaxHp
        end,
        [GE.AttribType.Bombard] = function()
            return self.bombard
        end,
        [GE.AttribType.Torpedo] = function()
            return self.torpedo
        end,
        [GE.AttribType.Armor] = function()
            return self.armor
        end,
        [GE.AttribType.Evade] = function()
            return self.evade
        end,
        [GE.AttribType.AirDefense] = function()
            return self.airdefense
        end,
        [GE.AttribType.Lucky] = function()
            return self.lucky
        end,
        [GE.AttribType.BaseDamageRate] = function()
            return self.baseDamageRate
        end,
        [GE.AttribType.MovePower] = function()
            return self.movePower
        end,
        default = function(attribType)
            BattleCore.ds("BattleRole getAttrib attribType", attribType)
            return 0
        end
    }
    ---召唤物刷新基础属性的方法
    self._baseAttribSetEvent = {
        [GE.AttribType.Hp] = function(value)
            self.hp = value
        end,
        [GE.AttribType.MaxHp] = function(value)
            self.baseMaxHp = value
            if self.maxHp ~= value then
                self:OnMaxHpChange(value)
            end
        end,
        [GE.AttribType.Bombard] = function(value)
            self.bombard = value
        end,
        [GE.AttribType.Torpedo] = function(value)
            self.torpedo = value
        end,
        [GE.AttribType.Armor] = function(value)
            self.armor = value
        end,
        [GE.AttribType.Evade] = function(value)
            self.evade = value
        end,
        [GE.AttribType.AirDefense] = function(value)
            self.airdefense = value
        end,
        [GE.AttribType.Lucky] = function(value)
            self.lucky = value
        end,
        [GE.AttribType.BaseDamageRate] = function(value)
            self.baseDamageRate = value
        end,
        [GE.AttribType.MovePower] = function(value)
            self.movePower = value
        end,
        default = function(attribType, value)
            BattleCore.es("BattleRole setAttrib attribType", attribType, "未设置set方法，检查是否有错误")
        end
    }
end

function BattleRole:OnMaxHpChange(maxHp)
    self.maxHp = maxHp
    if self.hp > self.maxHp then
        self.hp = self.maxHp
    end
    local battleMgr = BattleCore:getBattleMgr()
    local battleReporter = battleMgr:getReporter()
    battleReporter:addReport(GE.BattleReportType.RoleMaxHpChange, {roleId = self.id, maxHp = self.maxHp, hp = self.hp})
end

---简易验证时修改创建角色的hp值
---@param hp integer
function BattleRole:setHpValue(hp)
    self.hp = math.min(hp, self.maxHp)
end

function BattleRole:GetCurHPPrecent()
    local curHP = self:getAttrib(GE.AttribType.Hp)
    local maxHP = self:getAttrib(GE.AttribType.MaxHp)
    return curHP / maxHP
end

---@param baseAttrib integer
---@param attribType string
function BattleRole:_calculateAttrib(baseAttrib, attribType)
    local bonusType = self._attribBonusTypeCache[attribType]
    if not bonusType then
        bonusType = attribType .. "B"
        self._attribBonusTypeCache[attribType] = bonusType
    end
    local percentageBonusType = self._attribPercentageBonusTypeCache[attribType]
    if not percentageBonusType then
        percentageBonusType = attribType .. "PB"
        self._attribPercentageBonusTypeCache[attribType] = percentageBonusType
    end
    local attribB = self:getExAttrib(bonusType) + self.buffController:getExAttrib(bonusType)
    local exValue = self:getExAttrib(percentageBonusType)
    local buffValue = self.buffController:getExAttrib(percentageBonusType)
    -- LuaLogger.ds("BattleRole:getAttrib", self.roleConfig.name, attribType, exValue, buffValue)
    local attribPB = (1 + exValue) + buffValue
    attribPB = math.max(attribPB, 0)
    local attrib = baseAttrib * attribPB + attribB
    -- LuaLogger.ds("BattleRole:getAttrib", self.id, attribType, baseAttrib, attribPB, attribB)
    return attrib
end

---刷新属性基础数值，不包含受其他属性加成的影响
function BattleRole:updateAttributeBaseValue()
    local attribEvent = self._attribEvent
    local attribBaseValue = self._attribBaseValue
    local attribKeys = self._attribKeys
    for index = 1, #attribKeys do
        local key = attribKeys[index]
        attribBaseValue[key] = attribEvent[key]()
    end
end

---@param attributeType AttribType
function BattleRole:getAttributeBaseValue(attributeType)
    local v = self._attribBaseValue[attributeType] or 0
    return v
end

---@param attributeType AttribType
function BattleRole:getAttributeTotalValue(attributeType)
    return self._attribTotalValue[attributeType] or 0
end

---刷新属性总数值，包含受其他属性加成的影响
function BattleRole:updateAttributeTotalValue()
    local attribTotalValue = self._attribTotalValue
    local attribTotalKeys = self._attribTotalKeys
    for index = 1, #attribTotalKeys do
        local key = attribTotalKeys[index]
        local baseValue = self:getAttributeBaseValue(key)
        local additionValue = self.buffController:getFormOtherExAttrib(key)
        local totalValue = baseValue + additionValue
        attribTotalValue[key] = totalValue
        if key == GE.AttribType.MaxHp and self.maxHp ~= totalValue then
            self:OnMaxHpChange(totalValue)
        end
    end
end

---@param searchType SkillRangeChangeType
---@return integer
function BattleRole:getAdditionSkillSelectRangeNum(searchType)
    local attrib = self.buffController:getExSkillSelectRange(searchType)
    return attrib
end

---@param searchType SkillRangeChangeType
function BattleRole:getAdditionSkillCoverRangeNum(searchType)
    local attrib = self.buffController:getExSkillCoverRange(searchType)

    return attrib
end

---依据技能标签获取技能选择范围修正值
---@param tagList integer[] 技能标签
---@return integer
function BattleRole:getAdditionSkillSelectRangeChangeBySkillTag(tagList)
    local attrib = self.buffController:getSkillSelectRangeChangeBySkillTag(tagList)
    return attrib
end

---初始化技能效果，部分技能有战斗初始化状态时触发的效果
function BattleRole:_initEffects()
    self._initEffectsList = {}
    -- self._passiveEffectsList = {}

    -- if self.camp == GE.BattleCampType.Enemy then
    --     local buffList = { 44048012 }
    --     for _, buffId in ipairs(buffList) do
    --         local battleMgr = BattleCore:getBattleMgr()
    --         local buffHandler = battleMgr:getSkillManager():getBuffHandler()
    --         local buffConfig = Config.GetBuffInfo(buffId)
    --         local buff = buffHandler:createBuff(buffId, 2,
    --             {}, self, buffConfig)
    --         self:addBuff(buff, 0)
    --     end
    -- end
    local activeSkillList = self:getActiveSkillList()
    local passiveSkillList = self:getPassiveSkillList()
    local checkList = tablex.combine(activeSkillList, passiveSkillList)
    table.insert(checkList, self.talentId)

    for _, skillId in ipairs(checkList) do
        if skillId > 0 then
            local skillConfig = Config.GetSkillInfo(skillId)
            if (skillConfig) then
                if (skillConfig.effectInit) then
                    self._initEffectsList = tablex.combine(self._initEffectsList, skillConfig.effectInit)
                end
            end
        end
    end
end

---@class RoleCreateData
---@field cid integer 角色配置cid
---@field id integer
---@field blockId integer
---@field image string
---@field modelRate number
---@field modelOffset number
---@field hpBarOffset number
---@field direction RoleDirectionType
---@field hp number?
---@field maxHp number?
---@field camp BattleCampType
---@field attribute number
---@field buffList Buff[]?
---@field delay number?
---@field isFormationState boolean?
---@field moveShowType integer? 移动类型
---@field isShow boolean? 是否显示
---@field isShowEffect boolean? 是否播放粒子特效和声音

---创建角色
---@param block BattleBlock 锚点
---@param roleData LevelRoleData
function BattleRole:createRole(block, roleData)
    local isFormationState = roleData.isFormationState
    local delay = roleData.delay
    --角色朝向中心点
    local battleMgr = BattleCore:getBattleMgr()
    local showMgr = battleMgr:getShowManager()
    local centralBlock = battleMgr:getMap():getCentralBlock()
    if (not self.direction) and showMgr then
        self.direction = showMgr:getFaceToBlockDirection(block, centralBlock)
        self:setOrgDirection(self.direction)
    end
    -- self.direction = GE.RoleDirectionType.Right
    self:calculateActionRange()
    local skinConfig = {}
    if self.isMonster then
        skinConfig = Config.GetCharacterSkinInfo(self.roleConfig.baseSkinID)
    else
        skinConfig = Config.GetCharacterSkinInfo(self.serverData.equipSkin)
    end
    if (isFormationState) then
        local _isShow = true
        if roleData.isShowEffect ~= nil then
            _isShow = roleData.isShowEffect
        end
        ---@type RoleCreateData
        local reportData = {
            cid = self.cid,
            id = self.id,
            blockId = block.id,
            image = skinConfig.modelKey,
            modelRate = skinConfig.modelRate,
            modelOffset = skinConfig.modelOffset,
            hpBarOffset = skinConfig.HpBarOffset,
            direction = self.direction,
            hp = self:getAttrib(GE.AttribType.Hp),
            maxHp = self:getAttrib(GE.AttribType.MaxHp),
            camp = self.camp,
            attribute = self.roleConfig.attribute,
            buffList = self.buffController:getBuffList(),
            isShow = true,
            isShowEffect = _isShow,
            delay = delay,
            isFormationState = true,
            moveShowType = skinConfig.moveShowType
        }
        showMgr:roleCreate(reportData)
        return
    end

    self:roleCreateReport(block.id, roleData, skinConfig)
end

---重置基本角色信息
---@param roleData RoleBaseData
function BattleRole:resetBaseData(roleData)
    self.baseMaxHp = roleData.baseMaxHp
    self.maxHp = roleData.maxHp
    self.hp = roleData.hp
    self._isAlive = roleData.isAlive
    self.direction = roleData.direction
    self._waypointList = roleData.waypointList
    self.buffController:resetBuffList(roleData.buffList)
    self._skillSelectState = roleData.skillSelectState
    self.haloSkillList = roleData.haloSkillList
    self._needRefreshEffectList = roleData.needRefreshEffectList
    self._skillCDList = roleData.skillCDList
    self._skillAmmoUsedList = roleData.skillAmmoUsedList
    self._summonEffectId = roleData.summonEffectId
end

---@class RoleBaseData
---@field id integer
---@field cid integer
---@field blockId integer
---@field camp BattleCampType
---@field maxHp integer
---@field hp integer
---@field isMonster boolean
---@field isAlive boolean
---@field direction RoleDirectionType
---@field waypointList integer[] 地格的idList
---@field buffList BuffSnapshot[]
---@field skillSelectState SkillSelectType
---@field haloSkillList integer[]
---@field needRefreshEffectList table<integer, RefreshEffectData>
---@field skillCDList table<integer, integer>
---@field skillAmmoUsedList table<integer, integer>
---@field group integer
---@field isActive boolean
---@field summonEffectId integer
---@field baseMaxHp integer

---获取基本角色信息
---@return RoleBaseData
function BattleRole:getBaseData()
    local copyBuffList = {}
    local selfBuffList = self.buffController:getRawBuffList()
    local buffHandler = BattleCore.getBuffHandler()
    local count = 1
    for _, buff in ipairs(selfBuffList) do
        if buff.configData.buffType ~= GE.BuffType.Block then
            copyBuffList[count] = buffHandler:exportSnapshot(buff)
            count = count + 1
        end
    end
    local roleBlockId = self.block and self.block.id or -1
    ---@type RoleBaseData
    local data = {
        id = self.id,
        level = self.level,
        showLevel = self.showLevel,
		cid = self.cid,
        blockId = roleBlockId,
        camp = self.camp,
        maxHp = self.maxHp,
        hp = self.hp,
        isMonster = self.isMonster,
        isAlive = self._isAlive,
        direction = self.direction,
        waypointList = tablex.copy(self._waypointList),
        buffList = copyBuffList,
        skillSelectState = self._skillSelectState,
        haloSkillList = tablex.copy(self.haloSkillList),
        needRefreshEffectList = tablex.copy(self._needRefreshEffectList),
        skillCDList = tablex.clone(self._skillCDList),
        skillAmmoUsedList = tablex.clone(self._skillAmmoUsedList),
        group = self.groupId,
        isActive = self._active,
        summonEffectId = self._summonEffectId,
        baseMaxHp = self.baseMaxHp
    }
    return data
end

function BattleRole:resetPos()
    -- if (self.tmpBlock and self.tmpBlock ~= self.block) then
    --     self.tmpBlock.roleId = nil
    -- end
    if self.tmpBlock then
        self.tmpBlock:setTmpRoleId(nil)
    end
    self.tmpBlock = nil
    self.block:setTmpRoleId(nil)
    self.block:setRoleId(self.id) --roleId = self.id
    self.direction = self._orgDirection
    self:turnDirection(self.direction, false, 0)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:checkRoleMoveIsInBePrepareSkillTarget(self)
    self._roleMgr:calculateAllRolesActionRange({ GE.BattleCampType.Enemy })
    local d = {
        id = self.id,
        blockId = self.block.id,
        delay = 0
    }
    battleMgr:callClientShowEvent(GE.ClientBattleShowType.ResetPos, d)
end

---设置基础属性
---@param attribList table 属性列表 {{AttribType, AttribValueType, value}, ...} AttribValueType: 1-固定值 2-百分比
---@param source BattleRole? 角色数据源
---@return table<integer, number> attribValueList 设置后的属性列表
function BattleRole:SetBaseAttribByList(attribList, source)
    local attribValueList = {}
    for _, value in ipairs(attribList) do
        local attribId = value[1]
        local attribType = value[2]
        local attribValue = value[3]
        local r = 0
        if attribType == 1 then
            r = attribValue
        elseif source then
            local sourceAttribValue = source:getAttrib(attribId)
            r = math.floor(sourceAttribValue * attribValue)
        end
        attribValueList[attribId] = r
        self:setBaseAttrib(attribId, r)
    end
    return attribValueList
end

---设置角色基础属性
---@param attribType AttribType 属性类型
---@param value number 属性数据
function BattleRole:setBaseAttrib(attribType, value)
    if self._baseAttribSetEvent[attribType] then
        self._baseAttribSetEvent[attribType](value)
    else
        self._baseAttribSetEvent["default"](attribType, value)
    end
end

---获取角色基础属性
function BattleRole:getBaseAttrib(attribType)
    if self._baseAttribEvent[attribType] then
        return self._baseAttribEvent[attribType]()
    else
        return self._baseAttribEvent["default"](attribType)
    end
end

---获取角色属性
---@param attribType AttribType 属性类型
---@param exParam integer? 额外参数，目前仅舰种克制和地形修正使用
---@return integer attribValue 属性数据
function BattleRole:getAttrib(attribType, exParam)
    local r = 0
    if attribType == GE.AttribType.RestraintRatio and exParam then
        r = self.buffController:getRestraintRatio(exParam)
    elseif attribType == GE.AttribType.TerrainRatio and exParam then
        r = self.buffController:getTerrainRatio(exParam)
    elseif attribType == GE.AttribType.Hp then
        r = self._attribEvent[GE.AttribType.Hp]()
    else
        r = self:getAttributeTotalValue(attribType)
    end

    return r
end

---设置额外属性
---@param attribType string 属性类型
---@param value any 属性值
---@param periodType integer? 持续类型
function BattleRole:setExAttrib(attribType, value, periodType)
    self.exAttribController:setExAttrib(attribType, value, periodType)
end

---获取额外属性
---@param attribType AttribType 属性类型
---@return any
function BattleRole:getExAttrib(attribType)
    return self.exAttribController:getExAttrib(attribType)
end

---设置免疫列表
---@param type SkillAffixType 效果类型
---@param list table 免疫效果列表
function BattleRole:setImmuneList(type, list)
    self.immuneController:setImmuneList(type, list)
end

---获取免疫列表
---@param type SkillAffixType 效果类型
function BattleRole:getImmuneList(type)
    local list = tablex.combine(self.buffController:getImmuneList(type), self.immuneController:getImmuneList(type))
    return list
end

---计算行动范围
function BattleRole:calculateActionRange()
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    self._curMoveRange, self._curMoveRangeKV = mapMgr:getMoveRange(self, GE.MovePowerType.Normal)
    self._curAtkRange, self._curAtkRangeKV = mapMgr:getChooseRangeByMoveRange(self._curMoveRange, self.normalSkill, self)
end

---获取角色移动范围
---@return BlockData[] self._curMoveRange 移动范围
function BattleRole:getRoleMoveRange()
    return self._curMoveRange
end

---获取角色攻击范围
---@return BlockData[] self._curAtkRange 攻击范围
function BattleRole:getRoleAtkRange()
    return self._curAtkRange
end

---获取角色移动范围KVTable
---@return table<integer,BlockData> self._curMoveRange 移动范围
function BattleRole:getRoleKVMoveRange()
    return self._curMoveRangeKV
end

---获取角色攻击范围KVTable
---@return table<integer,BlockData> self._curAtkRange 攻击范围
function BattleRole:getRoleKVAtkRange()
    return self._curAtkRangeKV
end

function BattleRole:getBulletModel()
    return self.bulletModel
end

---获取角色防空配置
function BattleRole:getAirDefenseEff()
    return self.airDefenseEff
end

---角色是否是召唤物
function BattleRole:IsSummoned()
    return self._summonEffectId and self._summonEffectId > 0
end

---设置召唤自身的召唤效果ID（被召唤机制创建角色会设置该值）
---@param effectId integer
function BattleRole:SetSummonEffectId(effectId)
    self._summonEffectId = effectId
end

---@param block BattleBlock
---@param path integer[]?
---@param faceToBlock BattleBlock?
---@param isUseSkill boolean?
function BattleRole:preMove(block, path, faceToBlock, delay, isUseSkill)
    local battleMgr = BattleCore:getBattleMgr()
    local tmpBlock = self:getShowBlock()
    if tmpBlock.id ~= block.id then
        if (not path) then
            local moveRange = self:getRoleKVMoveRange()
            path = battleMgr:getMap():getShortestPath(self:getShowBlock().id, block.id, moveRange)
        end
    end
    ---防止因为上次预移动的格子与初始格子相同，导致无法设置上正确的tmpRoleId，导致无法移动
    if self.tmpBlock then
        self.tmpBlock:setTmpRoleId(nil)
    end
    self.block:setTmpRoleId(-1)
    self.tmpBlock = block
    self.tmpBlock:setTmpRoleId(self.id)

    battleMgr:checkRoleMoveIsInBePrepareSkillTarget(self)
    local d = {
        role = self,
        sourceBlock = block,
        chooseBlock = faceToBlock,
        path = path,
        isUseSkill = isUseSkill,
        delay = delay
    }
    battleMgr:callClientShowEvent(GE.ClientBattleShowType.PreMove, d)
end

---@param block BattleBlock
---@param path integer[]? 需注意，路径中第一个点需要包含自身格子id，否则会导致转向错误
---@param delay number?
function BattleRole:move(block, path, delay)
    local realPath = nil
    local battleMgr = BattleCore:getBattleMgr()
    local battleReporter = battleMgr:getReporter()
    local startBlockId = self.block.id
    local endBlockId = block.id
    if startBlockId ~= endBlockId then
        local moveRange = self._curMoveRangeKV --battleMgr:getMap():getMoveRange(self)
        realPath = battleMgr:getMap():getShortestPath(startBlockId, endBlockId, moveRange)
        if (not path) then
            path = realPath
        end
        -- LuaLogger.es("BattleRole:move", self.id, "blockId", block.id, "path", tablex.dump(path))
        self._movePathList = realPath
        self._hasMoveDistance = #realPath - 1
    end
    local tmpBlock = self:getShowBlock()
    local mapMgr = battleMgr:getMap()
    if realPath then
        local costDic = self:getMoveCostOffset()
        local selfBlockId = self.block.id
        local moveCost = mapMgr:getMoveCostByPath(self.roleConfig.moveType, realPath, costDic, selfBlockId)
        local maxMovePower = self:getAttrib(GE.AttribType.MovePower)
        self._remainMovePower = maxMovePower - moveCost
        ---防止预移动后再重新插入移动演出事件
        if tmpBlock.id ~= block.id then
            local reportData = {
                id = self.id,
                blockId = self.block.id,
                path = path,
                delay = delay
            }
            battleReporter:addReport(GE.BattleReportType.RoleMove, reportData)
            battleReporter:packStep()
        end
    end
    self.block:setTmpRoleId(nil)
    self:changeBlock(block)
    ---已经触发过地格效果
    self._isChangeBlock = true
    block:setTmpRoleId(nil)
    table.insert(self._waypointList, self.block.id)
    battleMgr:setTiming(GE.BattleTiming.AfterMove)
    -- battleMgr:playReport(battleReporter:getCurrentReports(true))
    if self.camp == self._roleMgr:getManualCamp() then
        local orderData = {
            roleId = self.id,
            blockId = self.block.id,
            path = realPath,
        }
        battleMgr:addBattleOrder(GE.BattleOrderType.RoleMove, orderData)
    end
    self._movePathList = nil
end

---@param checkBlock BattleBlock?
function BattleRole:checkBlockEffect(checkBlock)
    if self._startCheckBlockEffect then
        return
    end
    self._startCheckBlockEffect = true
    local block = checkBlock or self:getShowBlock()
    if (not block) then
        self._startCheckBlockEffect = false
        return
    end
    local idsList = block:getEffectGroup()
    local checkList = {}
    for effectId, effectData in pairs(idsList) do
        local d = {
            effectId = effectId,
            effectData = effectData
        }
        checkList[#checkList + 1] = d
    end
    table.sort(checkList, function(a, b)
        return a.effectId < b.effectId
    end)
    local battleMgr = BattleCore:getBattleMgr()
    local skillMgr = battleMgr:getSkillManager()
    for _, value in ipairs(checkList) do
        local effectData = value.effectData
        local effectId = value.effectId
        for _, roleId in ipairs(effectData) do
            local source = self._roleMgr:getRole(roleId)
            if source then
                local targets = {
                    [1] = self.block.id
                }
                skillMgr:checkEffect(effectId, source, targets)
            end
        end
    end
    self._startCheckBlockEffect = false
end

function BattleRole:removeBlockEffect()
    self.buffController:removeHaloTypeBuff()
end

function BattleRole:checkMove(block)
    if (not self.tmpBlock and not block) then
        return
    end
    self:move(block or self.tmpBlock, self._movePathList)
    if self.tmpBlock then
        self.tmpBlock:setTmpRoleId(nil)
    end
    self.tmpBlock = nil
    local battleMgr = BattleCore:getBattleMgr()
    local battleReporter = battleMgr:getReporter()
    battleReporter:packStep()
    -- battleReporter:switchCurrentReports()
end

---@param block BattleBlock
function BattleRole:changeBlock(block)
    -- self._isChangeBlock = block.id ~= self.block.id
    local battleMgr = BattleCore:getBattleMgr()
    if block.id ~= self.block.id then
        local mapMgr = battleMgr:getMap()
        mapMgr:removeAllBlockEffectGroupByRoleId(self.id, true)
        local skillMgr = battleMgr:getSkillManager()
        self.block:setRoleId(nil) --roleId = nil
        block:setRoleId(self.id)  --.roleId = self.id
        self.block = block
        self.buffController:checkHaloBuff(true)
        for _, triggerId in ipairs(self.haloSkillList) do
            skillMgr:checkEffect(triggerId, self, {self.block.id})
        end
        if self.camp == GE.BattleCampType.Friend then
            local roleAIMgr = battleMgr:getBattleRoleAIManager()
            roleAIMgr:CheckAIEvent(GE.MonsterActiveEventType.TargetInAtkRange, self)
        end
    end
    if self._isChangeBlockEffect == nil then
        self._isChangeBlockEffect = true
    end
    self:removeBlockEffect()
    self:checkBlockEffect()
    battleMgr:checkRoleMoveIsInBePrepareSkillTarget(self)
    local d = {
        role = self,
        playInReport = true,
    }
    battleMgr:callClientShowEvent(GE.ClientBattleShowType.PrepareSkill, d)
end

---被其他角色强制触发的移动，主要是击退效果
---@param block BattleBlock
---@param path integer[]
---@param delay number?
function BattleRole:moveByOther(block, path, delay)
    local battleMgr = BattleCore:getBattleMgr()
    local battleReporter = battleMgr:getReporter()
    local reportData = {
        id = self.id,
        blockId = self.block.id,
        path = path,
        delay = delay
    }
    battleReporter:addReport(GE.BattleReportType.RoleMove, reportData)
    self:changeBlock(block)
end

--行动流程-------------------------------------------------------------------------------

---进入行动状态
function BattleRole:enterActionState(isInit)
    ---@type integer 当前选中的技能
    self.selectedSkill = self.normalSkill
    self._actionFlowIndex = 0
    self._pauseActionFlow = false
    self.skillTarget = nil
    self:clearSkillTarget()
    self.skillFilteredTargets = nil
    self.skillFindTarget = nil
    -- local battleMgr = BattleCore:getBattleMgr()
    -- local showMgr = battleMgr:getShowManager()
    -- if showMgr then
    --     showMgr:showFullMask(false)
    -- end
    if (isInit) then
        local movePower = self:getAttrib(GE.AttribType.MovePower)
        self._remainMovePower = movePower
        local battleMgr = BattleCore:getBattleMgr()
        battleMgr:setBattleState(GE.BattleState.WaitInputOrder)
        local histroyMgr = battleMgr:getHistoryManager()
        if (self._roleMgr:isManualCamp() and histroyMgr) then
            histroyMgr:switchMainRoleInHistory(self.id)
        end
    end
end

---执行行动
---@param actionType ActionType
---@param delay number?
function BattleRole:doAction(actionType, delay)
    local showBlock = self:getShowBlock()
    local battleMgr = BattleCore:getBattleMgr()
    local showMgr = battleMgr:getShowManager()
    if self.camp == self._roleMgr:getManualCamp() then
        if self._roleMgr:isActionCompleted(self) then
            if showMgr then
                UICommonUtils.PopToast("已行动角色重复行动，打开日志检查")
            end
            BattleCore.es("BattleRole:doAction", "hasCompletedAction", self.id)
            battleMgr:NotAllowedOrderCallBack()
            return
        end
        local orderData = {
            roleId = self.id,
        }
        battleMgr:addBattleOrder(GE.BattleOrderType.SelectRole, orderData)
    end
    local report = battleMgr:getReporter()
    if actionType ~= GE.ActionType.Standby then
        -- self:LookAtBlockReport(showBlock.id, true)
        self:SmoothFollowTargetReport(showBlock.id, GE.FollowTargetType.BeforeAction, true)
        report:packStep()
    end
    local skillMgr = battleMgr:getSkillManager()
    if showMgr then
        showMgr:showFullMask(true)
    end
    local isMoveAgain = false
    if (self._moveAgainType) then
        isMoveAgain = true
    end

    self._pauseActionFlow = false
    self._isMyTurn = true
    self:SetRoleTag(GE.ActionTagType.MyTurn)
    ---防止因为再移动导致技能CD和Buff回合数多减少一次
    if isMoveAgain == false then
        self:dealSkillCD()
        self.buffController:refreshRemainRounds()
    end
    report:packStep()
    battleMgr:setCureentTurnActionRoleId(self.id)
    local moveBlock = self:getChooseMoveBlock()
    local chooseBlock = self:getSkillTargetBlock()
    self:checkMove(moveBlock)
    local curSkillTarget = nil
    if (actionType == GE.ActionType.DoSkill) then
        self.actionSkill = self.selectedSkill
        curSkillTarget = self:getSkillTarget()
        local skillConfig = Config.GetSkillInfo(self.selectedSkill)
        local skillType = skillConfig.skillType
        if skillType == GE.SkillType.Normal then
            self:SetRoleTag(GE.ActionTagType.UseNormalAttack)
        elseif skillType == GE.SkillType.Active then
            self:SetRoleTag(GE.ActionTagType.UseSkill)
        end
        local atkCalculateType = skillConfig.atkCalculateType
        local isBattle = atkCalculateType == GE.SkillCalculateType.Normal or
            atkCalculateType == GE.SkillCalculateType.AirDefense
        battleMgr:setEngagedInBattle(isBattle)
        if isBattle then
            self:SetRoleTag(GE.ActionTagType.HasInBattle)
        end
        if curSkillTarget then
            local targetsList = skillMgr:GetAllTarget(self, curSkillTarget, skillConfig)
            local isRepair = skillConfig.atkCalculateType == GE.SkillCalculateType.Repair
            if isRepair then
                self:SetRoleTag(GE.ActionTagType.HealOther)
            else
                self:SetRoleTag(GE.ActionTagType.HasHurtOther)
            end
            local damageType = skillConfig.attackDamageType
            local tagID = nil
            local damageTag = nil
            if damageType == GE.SkillDamageType.Bombard then
                tagID = GE.ActionTagType.DamageTypeBombard
                damageTag = GE.ActionTagType.DamageTypeNotAirAttack
            elseif damageType == GE.SkillDamageType.Torpedo then
                tagID = GE.ActionTagType.DamageTypeTorpedo
                damageTag = GE.ActionTagType.DamageTypeNotAirAttack
            elseif damageType == GE.SkillDamageType.AirBombard then
                tagID = GE.ActionTagType.DamageTypeAirBombard
                damageTag = GE.ActionTagType.DamageTypeAirAttack
            elseif damageType == GE.SkillDamageType.AirTorpedo then
                tagID = GE.ActionTagType.DamageTypeAirTorpedo
                damageTag = GE.ActionTagType.DamageTypeAirAttack
            end
            self.skillFilteredTargets = targetsList
            for _, block in ipairs(targetsList) do
                local target = block:tryGetRole()
                if target and target.id ~= self.id then
                    if tagID then
                        target:SetRoleTag(tagID)
                        target:SetRoleTag(damageTag)
                    end
                    self:SetRoleActionList(target.id)
                    target:SetRoleActionList(self.id)
                    battleMgr:setCureentTurnActionRoleId(target.id)
                    if isBattle then
                        target:SetRoleTag(GE.ActionTagType.HasInBattle)
                    end
                    if skillConfig.attackAttriType == 2 then
                        target:SetRoleTag(GE.ActionTagType.DamageTypeAOE)
                    end
                    if isRepair then
                        target:SetRoleTag(GE.ActionTagType.HasBeHeal)
                    else
                        target:SetRoleTag(GE.ActionTagType.HasBeHurt)
                    end
                end
            end
            if self.camp == GE.BattleCampType.Friend and skillConfig.skillType == GE.SkillType.Active then
                local selfLogData = battleMgr:GetBattleRoleLogData(self.id)
                if selfLogData then
                    selfLogData.activeSkillCount = selfLogData.activeSkillCount + 1
                end
            end
        end
    elseif actionType == GE.ActionType.Standby then
        if self:CheckHasTag(GE.ActionTagType.UseSkill) == false and
            self:CheckHasTag(GE.ActionTagType.UseNormalAttack) == false then
            self:SetRoleTag(GE.ActionTagType.OnlyStand)
        end
    end
    if chooseBlock then
        self:faceToBlock(chooseBlock, true, moveBlock)
    end
    if self._isAlive == false then
        self:afterAction(delay)
        return
    end
    --护卫开始
    self._recentProtectedId = skillMgr:checkProtectAction(self, self.skillFilteredTargets, true)
    if self._isChangeBlockEffect ~= true then
        self:removeBlockEffect()
        self:checkBlockEffect()
        self._isChangeBlockEffect = true
    end
    ---如果是再移动，则不需要执行行动前的流程
    if isMoveAgain == false then
        self:beforeAction(delay)
    end
    if self._isAlive == false then
        self:afterAction(delay)
        return
    end
    -- self.actionSkill = false
    if (actionType == GE.ActionType.DoSkill) then
        self:SmoothFollowTargetReport(self.skillTargetBlock.id, GE.FollowTargetType.Action, true)
        report:packStep()
        if self._recentProtectedId then
            ---被护卫的角色
            local protectedRole = self._roleMgr:getRole(self._recentProtectedId)
            if protectedRole then
                local protectedBlock = protectedRole:getShowBlock()
                local targetBlock = self.skillFilteredTargets[1]
                local guardRole = targetBlock:tryGetRole()
                if guardRole then
                    guardRole:refreshBlockByShowGuard(protectedBlock, true)
                end
            end
        end
        self:doSkill(self.selectedSkill, self.skillFilteredTargets, delay)
    elseif (actionType == GE.ActionType.Standby) then
        self:standby()
    else
        -- LuaLogger.ds("BattleRole:doAction wrong ActionType", actionType)
    end
    if self._isAlive == false then
        self:afterAction(delay)
        return
    end
    if (isMoveAgain) then
        self._moveAgainType = nil
        self._againMovePower = nil
        self:actionFlowFinish(delay)
    else
        self:startActionFlow(delay)
    end
end

---行动前
function BattleRole:beforeAction(delay)
    -- self:turnDirectionReport(delay)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:setTiming(GE.BattleTiming.BeforeAction)
    self._roleMgr:checkCurBattleTimeDefeatRole()
    self:checkAndRefreshEffectLimitNum()
    self:checkActionRelatedEffects(false, delay)
    self._roleMgr:checkAllRoleBuffChangeReport()
end

---开始行动流程
function BattleRole:startActionFlow(delay)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:getReporter():packStep()

    self._flowDelay = delay
    self:nextActionFlow()
end

---下一个行动流程
function BattleRole:nextActionFlow()
    if self._isAlive == false then
        self:afterAction()
        return
    end
    local battleMgr = BattleCore:getBattleMgr()
    self._actionFlowIndex = self._actionFlowIndex + 1
    if (self._actionFlowIndex <= self._flowTimingCount) and self._isAlive == true then
        local curTiming = self._flowTiming[self._actionFlowIndex]
        battleMgr:setTiming(curTiming)
        self._roleMgr:checkCurBattleTimeDefeatRole()
        self:checkActionRelatedEffects(self.actionSkill)
        if curTiming == GE.BattleTiming.OnActionFinish then
            self:checkGuardEnd()
        end
        self._roleMgr:checkAllRoleBuffChangeReport()
        if (not self._pauseActionFlow) then
            self:nextActionFlow()
        end
    else
        if self._moveAgainType == nil or (self._moveAgainType == GE.MovePowerType.Remain and self._remainMovePower <= 0) then
            self:actionFlowFinish(self.flowDelay)
        else
            if (battleMgr:checkWinLose()) == false then
                self._roleMgr:checkCurBattleTimeDefeatRole()
                battleMgr:setBattleState(GE.BattleState.AfterInputOrder)
                self:startMoveAgain(self._moveAgainType)
            else
                self:actionFlowFinish(self.flowDelay)
            end
        end
    end
end

---行动流程完成
function BattleRole:actionFlowFinish(delay)
    if (self.actionSkill) then
        local battleMgr = BattleCore:getBattleMgr()
        battleMgr:setTiming(GE.BattleTiming.AfterSkill)
        self._roleMgr:checkCurBattleTimeDefeatRole()
    end
    ---触发事件
    self:afterAction(delay)
end

---设置原始朝向
---@param direction integer 方向类型
function BattleRole:setOrgDirection(direction)
    self._orgDirection = direction
end

---行动后
function BattleRole:afterAction(delay)
    --护卫归位
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:setTiming(GE.BattleTiming.AfterAction)
    self:checkActionRelatedEffects(self.actionSkill)
    if self._isAlive then
        self:roleStandbyReport(delay)
        self._roleMgr:checkUsePrepareSkill(self)
    end
    self:checkGuardEnd()
    battleMgr:checkAllRoleBuffState()
    self._roleMgr:changeBlockInfo()
    self._roleMgr:clearAllRoleGuardID()
    self._roleMgr:updateAllRoleAllAttributeValue()
    ---重新计算所有角色行动范围
    battleMgr:checkActionRoleCalculateActionRange()
    self._roleMgr:checkAllRoleBuffChangeReport()
    self:setOrgDirection(self.direction)
    self._isMyTurn = false
    self.selectedSkill = nil
    self._curSkillID = nil
    self._skillDir = nil
    ---容错，防止再移动在行动完成后触发
    self._moveAgainType = nil
    self._movePathList = nil
    self._hasMoveDistance = nil
    self._chooseMoveBlock = nil
    self.skillTargetBlock = nil
    self._isChangeBlockEffect = nil
    self._buffChangeFlag = nil
    self._roleMgr:setLockRole(nil)
    self._roleMgr:clearAllRoleTagList()
    self._roleMgr:clearAllRoleActionList()
    self._roleMgr:setRoleInCompleteActionList(self)
    battleMgr:stopActionState(true)
    battleMgr:clearActionRoleList()
    self:clearDamageValue()
    self:clearBeDamagedValue()
    self._roleMgr:checkCurBattleTimeDefeatRole()
    battleMgr:setBattleState(GE.BattleState.AfterInputOrder)
    battleMgr:setTiming(GE.BattleTiming.BeforeChangeRole)
    battleMgr:checkAvgEndForVerify()
    if (self._actionAgainType) then
        if (battleMgr:checkWinLose()) then
            return
        end
        battleMgr:setEngagedInBattle(false)
        self:startActionAgain(self._actionAgainType)
        return
    else
        battleMgr:setBattleState(GE.BattleState.AfterRoleAction)
    end
end

---检查护卫相关数据
function BattleRole:checkGuardEnd()
    local battleMgr = BattleCore:getBattleMgr()
    local skillMgr = battleMgr:getSkillManager()
    if self._recentProtectedId then
        local targetBlock = self.skillFilteredTargets[1]
        local guardRole = targetBlock:tryGetRole(true)
        ---护卫角色死亡时，将所处临时格子的临时数据还原
        if guardRole:getIsAlive() then
            guardRole:refreshBlockByShowGuard(nil, false)
        else
            local tmpBlock = guardRole.tmpBlock
            if tmpBlock then
                tmpBlock:setTmpRoleId(nil)
            end
            guardRole.tmpBlock = nil
        end
    end
    skillMgr:checkProtectAction(self, self.skillFilteredTargets, false, self._recentProtectedId)
    self._recentProtectedId = nil
end

---------------------------------------------------------------------------------

---暂停行动流程
function BattleRole:pauseAction()
    self._pauseActionFlow = true
    -- self:roleStandbyReport(self._flowDelay)
    self._flowDelay = 0
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:stopActionState()
    -- battleMgr:playAllReports()
end

---待机
function BattleRole:standby()
    -- self:afterAction()
    self.selectedSkill = nil
    self.skillTarget = nil
    self:clearSkillTarget()

    local _allRoleBlockDic = {}
    local allRoleList = self._roleMgr:getRolesList()
    for _, role in ipairs(allRoleList) do
        _allRoleBlockDic[role.id] = role.block.id
    end
    if self.camp == self._roleMgr:getManualCamp() then
        local orderData = {
            roleId = self.id,
            result = {
                allRoleBlockDic = _allRoleBlockDic
            }
        }
        local battleMgr = BattleCore:getBattleMgr()
        battleMgr:addBattleOrder(GE.BattleOrderType.RoleStandby, orderData)
    end
end

---选中技能
function BattleRole:selectSkill(id)
    self.selectedSkill = id
    self:skillChooseTarget()
end

---选择目标
function BattleRole:skillChooseTarget()
    local battleMgr = BattleCore:getBattleMgr()
    local skillMgr = battleMgr:getSkillManager()
    battleMgr:setLastSkillSelectBlockId(nil)
    battleMgr:removeMoveRange()
    battleMgr:removeSkillRange()
    --移除目标选中特效
    local showMgr = BattleCore:getBattleMgr():getShowManager()
    if showMgr then
        showMgr:removeTargetEffect()
    end
    local skillConfig = Config.GetSkillInfo(self.selectedSkill)
    -- LuaLogger.ds("BattleRole:skillChooseTarget skillOperateType", skillConfig.skillOperateType)
    local chooseRangeIdList = self:_getSkillRange(false)
    if (skillConfig.skillOperateType == GE.SkillOperateType.SelfBlock) then
        ---原地释放
        local block = self:getShowBlock()
        local targets = {}
        local effectRange = skillMgr:GetSkillEffectRangeByRole(skillConfig, self)
        battleMgr._skillRangeIdList = battleMgr:getMap():getDiffuseRange(skillConfig.rangeSelectType, block,
            effectRange)
        for index, value in ipairs(battleMgr._skillRangeIdList) do
            targets[index] = value.blockId
        end
        self:setTarget(targets, block)
        battleMgr:SetIsInUseSelfSkill(block.id)
    else
        ---刷新技能范围
        battleMgr:refreshSkillRange(chooseRangeIdList)
        -- battleMgr:uiEnterChooseState()
        battleMgr:callClientShowEvent(GE.ClientBattleShowType.SelectSKillTarget)
    end
end

---@param needMoveList boolean?
---@return BlockData[], table<integer, BlockData>
function BattleRole:_getSkillRange(needMoveList)
    ---@type BlockData[]
    local list = {}
    ---@type table<integer, BlockData>
    local kvList = {}
    local block = self:getShowBlock()
    local skillConfig = Config.GetSkillInfo(self.selectedSkill)
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    if (skillConfig.skillOperateType == GE.SkillOperateType.SelfBlock) then
        ---原地释放
        ---@type BlockData
        local blockData = {
            blockId = block.id,
            lap = 0
        }
        list[1] = blockData
        kvList[block.id] = blockData
    elseif (skillConfig.skillOperateType == GE.SkillOperateType.Direction) then
        ---选择方向
        mapMgr.chooseRangeSourceBlockDic = {}
        mapMgr._chooseRangeMinDistanceDic = {}
        local blockList = mapMgr:getDiffuseRange(GE.SkillRangeType.Normal, block, {1, 0}, block)
        local needCheck = skillConfig.isTorpdeo == 1
        ---移除自身格子
        local count = #blockList
        for i = count, 1, -1 do
            local curData = blockList[i]
            local blockId = curData.blockId
            if blockId ~= block.id then
                local isPass = true
                if needCheck then
                    local curBlock = mapMgr:getBlockById(blockId)
                    ---鱼雷类技能需要检测当前地格是否阻挡鱼雷
                    if curBlock and curBlock:GetBlockCanBlockTorpedo() then
                        isPass = false
                    end
                end
                if isPass then
                    local curBlock = mapMgr:getBlockById(blockId)
                    local dir = self._roleMgr:getFaceToBlockDirection(block, curBlock, nil)
                    curData.direction = dir
                    kvList[blockId] = curData
                    table.insert(list, curData)
                end
            end
        end
    else
        ---@type BlockData
        local blockData = {
            blockId = block.id,
            lap = 0
        }
        if needMoveList == nil then
            needMoveList = true
        end
        list, kvList = mapMgr:getChooseRangeByMoveRange({ blockData }, self.selectedSkill, self, needMoveList)
    end

    return list, kvList
end

---设置目标
---@param target integer[]
---@param chooseBlock BattleBlock
function BattleRole:setTarget(target, chooseBlock)
    -- LuaLogger.ds("BattleRole:setTarget target", #target)
    self._roleMgr:clearAllRoleGuardID()
    local skillMgr = BattleCore:getSkillMgr()
    local skillConfig = Config.GetSkillInfo(self.selectedSkill)
    self.beforeCheckTargetList = target
    local hasIgnoreGuard, _buff = self:checkHasIgnoreGuard()
    if skillConfig.ignoreSupport > 0 or hasIgnoreGuard then
        self.afterCheckTargetList = target
    else
        self.afterCheckTargetList = skillMgr:checkGuardTarget(self.selectedSkill, target)
    end
    self.skillTargetBlock = chooseBlock
    local battleMgr = BattleCore:getBattleMgr()

    local rangeList, rangeKVList = self:_getSkillRange()
    --判断在攻击范围内就不移动
    local needMove = rangeKVList[chooseBlock.id] == nil

    local sourceBlock = self:getShowBlock()
    if (needMove) then
        local skillConfig = Config.GetSkillInfo(self.selectedSkill)
        local showBlock = self:getShowBlock()
        sourceBlock = battleMgr:getMap():getNearestBlockByAtkTarget(showBlock, chooseBlock, skillConfig,
            self._curMoveRangeKV)
        -- if sourceBlock == nil and LuaLogger.Enabled == true then
        --     LuaLogger.es("未能找到最近的攻击位置，移动列表：", tablex.dump(self._curMoveRangeKV), "自身位置", showBlock.id, "点击的地格：",
        --         chooseBlock.id)
        -- end
    end
    if sourceBlock then
        self:preMove(sourceBlock, nil, chooseBlock, 0, true)
    end
end

---AI使用的目标选择，目标格子已经提前找好，不需要再找一个最近的格子
---@param target integer[] 地格id的List
---@param chooseBlock BattleBlock
---@param moveBlock BattleBlock
---@param path integer[]? 移动路径
function BattleRole:setTargetAuto(target, chooseBlock, moveBlock, path)
    self._roleMgr:clearAllRoleGuardID()
    local skillMgr = BattleCore:getSkillMgr()
    local skillConfig = Config.GetSkillInfo(self.selectedSkill)
    self.beforeCheckTargetList = target
    local hasIgnoreGuard, _buff = self:checkHasIgnoreGuard()
    if skillConfig.ignoreSupport > 0 or hasIgnoreGuard then
        self.afterCheckTargetList = target
    else
        self.afterCheckTargetList = skillMgr:checkGuardTarget(self.selectedSkill, target)
    end
    self.skillTargetBlock = chooseBlock
    self:setChooseMoveBlock(moveBlock, path)
end

function BattleRole:getSkillTarget()
    local hasIgnoreGuard, _buff = self:checkHasIgnoreGuard()
    if hasIgnoreGuard then
        return self.beforeCheckTargetList
    else
        if self.afterCheckTargetList == nil then
            local skillMgr = BattleCore:getSkillMgr()
            self.afterCheckTargetList = skillMgr:checkGuardTarget(self.selectedSkill, self.beforeCheckTargetList)
        end
        return self.afterCheckTargetList
    end
end

function BattleRole:clearSkillTarget()
    ---@type integer[]?
    self.beforeCheckTargetList = nil
    ---@type integer[]?
    self.afterCheckTargetList = nil
end

---@param targetBlock BattleBlock
function BattleRole:setSkillDir(targetBlock)
    local sourceBlock = self:getShowBlock()
    local col = targetBlock.col - sourceBlock.col
    local row = targetBlock.row - sourceBlock.row
    local colDir, rowDir = 0, 0
    if col ~= 0 then
        colDir = col > 0 and 1 or -1
    elseif row ~= 0 then
        rowDir = row > 0 and 1 or -1
    end
    self._skillDir = {colDir, rowDir}
end

function BattleRole:getSkillDir()
    return self._skillDir
end

function BattleRole:SetActiveState(value)
    --print("BattleRole:SetActiveState", self.id,value,debug.traceback())
    self._active = value
end

function BattleRole:getActiveState()
    return self._active
end

---检查初始阶段效果(创建时需要检测)
function BattleRole:checkInitEffects()
    self:_initEffects()
    local skillMgr = BattleCore:getBattleMgr():getSkillManager()
    for _, triggerId in ipairs(self._initEffectsList) do
        skillMgr:checkEffect(triggerId, self, {self.block.id})
        local triggerConfig = Config.GetEffectTriggerInfo(triggerId)
        if triggerConfig then
            local effectList = triggerConfig.effectId
			if effectList then
                for _, effectId in ipairs(effectList) do
                    local effectConfig = Config.GetEffectInfo(effectId)
                    if effectConfig.effectAttriType == GE.SkillAffixType.HaloBuff then
                        self.haloSkillList[#self.haloSkillList + 1] = triggerId
                    end
                end
			end
        end
    end

    self.maxHp = self:getAttrib(GE.AttribType.MaxHp)
    self.hp = self.maxHp
    self:showHpReport()
end

---检查我方回合开始阶段效果
function BattleRole:checkInitMyCampActionEffects()
    ---@type integer[]
    local effectList = {}
    ---@type table<integer, integer>
    local checkList = {}
    local f = function(list)
        for _, skillId in ipairs(list) do
            if skillId ~= 0 then
                local config = Config.GetSkillInfo(skillId)
                if config and config.effectRound then
                    local roundEffect = config.effectRound
                    for _, value in ipairs(roundEffect) do
                        if not checkList[value] then
                            checkList[value] = 1
                            table.insert(effectList, value)
                        end
                    end
                end
            end
        end
    end
    local skillList = {}
    skillList[1] = self.talentId
    f(skillList)
    skillList = self:getPassiveSkillList()
    f(skillList)
    skillList = self:getActiveSkillList()
    f(skillList)
    local skillMgr = BattleCore:getSkillMgr()
    table.sort(effectList, function (a, b)
        return a < b
    end)
    for _, triggerId in ipairs(effectList) do
        skillMgr:checkEffect(triggerId, self, {self.block.id})
    end
end

---检查行动阶段效果
function BattleRole:checkActionRelatedEffects(actionSkill, delay)
    local battleMgr = BattleCore:getBattleMgr()
    local buffAffixes = self.buffController:getPendingBuffAffixes(battleMgr:getTiming(), delay)
    local pendingAffixes = buffAffixes
    self:doAffixes(pendingAffixes)
    self:checkSkills(delay)
    self._roleMgr:chcekAllPassiveEffects(self.id)
    battleMgr:getReporter():packStep()
end

---检查技能
function BattleRole:checkSkills(delay)
    local battleMgr = BattleCore:getBattleMgr()
    local activeSkillList = self:getActiveSkillList()
    local nowPassiveSkillList = self:getPassiveSkillList()
    local checkList = tablex.combine(activeSkillList, nowPassiveSkillList)
    if self.talentId and self.talentId ~= 0 then
        table.insert(checkList, self.talentId)
    end
    ---@type SkillTable[]
    local skillCfgList = {}
    for _, skillId in ipairs(checkList) do
        if skillId ~= 0 then
            local skillConfig = Config.GetSkillInfo(skillId)
            if skillConfig then
                table.insert(skillCfgList, skillConfig)
            end
        end
    end
    table.sort(skillCfgList, function (a, b)
        return a.priority < b.priority
    end)
    for _, skillCfg in ipairs(skillCfgList) do
        local skillId = skillCfg.id
        ---@type integer[]?
        local target = nil
        if (skillId == self.selectedSkill) then
            local targetBlockList = self:getCurSkillTarget()
            target = {}
            for _, value in ipairs(targetBlockList) do
                table.insert(target, value.id)
            end
        end
        battleMgr:getSkillManager():DoSkillEffect(skillCfg, self, target, delay)
    end
end

---@return BattleBlock[]
function BattleRole:getCurSkillTarget()
    local skillTargets = self.skillFilteredTargets
    if skillTargets == nil then
        if self.selectedSkill == nil then
            self.selectedSkill = self.normalSkill
        end
        local skillMgr = BattleCore:getSkillMgr()
        local skillConfig = Config.GetSkillInfo(self.selectedSkill)
        local curTarget = self:getSkillTarget()
        skillTargets = skillMgr:GetAllTarget(self, curTarget, skillConfig)
    end

    return skillTargets
end

---获取当前的主动技能列表
---@return integer[]
function BattleRole:getActiveSkillList()
    local checkList = tablex.clone(self.skillList)
    local replaceList = self.buffController:getReplaceSkillList()
    for k, v in pairs(replaceList) do
        for listIndex, skillId in ipairs(checkList) do
            if skillId == v then
                checkList[listIndex] = k
                break
            end
        end
    end
    ---测试代码
    -- if self.cid == 10017 then
    --     checkList[4] = 541305
    -- end
    return checkList
end

---获取当前的被动技能列表
function BattleRole:getPassiveSkillList()
    local checkList = tablex.clone(self.passiveSkillList)
    local replaceList = self.buffController:getReplacePassiveSkillList()
    for k, v in pairs(replaceList) do
        for listIndex, skillId in ipairs(checkList) do
            if skillId == v then
                checkList[listIndex] = k
                break
            end
        end
    end
    local additionalSkillList = self.buffController:getAdditionalPassiveSkillList()
    checkList = tablex.combine(checkList, additionalSkillList)
    local battleMgr = BattleCore:getBattleMgr()
    local levelSkillList = battleMgr:getLevelSkillList(self.camp)
    checkList = tablex.combine(checkList, levelSkillList)
    local advantageousRoleEffectList = battleMgr:GetAdvantageousRoleEffectList(self.cid)
    if advantageousRoleEffectList then
        checkList = tablex.combine(checkList, advantageousRoleEffectList)
    end

    return checkList
end

---执行效果
---@param pendingAffixes pendingAffixData[] 待生效效果
function BattleRole:doAffixes(pendingAffixes)
    -- LuaLogger.ds("BattleRole:doAffixes")
    local lastTriggerId = nil
    if next(pendingAffixes) then
        for _, data in ipairs(pendingAffixes) do
            lastTriggerId = self:doAffixesByData(data, lastTriggerId)
        end
    end
end

---通过数据执行效果
---@param data pendingAffixData
---@param lastTriggerId integer? 上一个触发id
function BattleRole:doAffixesByData(data, lastTriggerId)
    local battleMgr = BattleCore:getBattleMgr()
    local skillMgr = battleMgr:getSkillManager()
    local reporter = battleMgr:getReporter()
    local effectTriggerConfig = data.triggerConfig
    local lastTriggerId = nil
    local timing = battleMgr:getTiming()
    --效果跳字
    if effectTriggerConfig then
        local triggerId = effectTriggerConfig.id
        lastTriggerId = reporter:GetLastTriggerId()
        if not lastTriggerId then
            lastTriggerId = triggerId
            reporter:SetLastTriggerId(triggerId)
        end
        ---触发id不同时打包战报，但是不希望因血量变化打断战报连续，战斗初始化阶段不打断战报
        if lastTriggerId ~= effectTriggerConfig.id and timing ~= GE.BattleTiming.RoleHpChange
            and timing ~= GE.BattleTiming.BattleInit then
            battleMgr:getReporter():packStep()
            reporter:SetLastTriggerId(effectTriggerConfig.id)
        end
        local t = data.target
        self:showEffectTipReport(effectTriggerConfig.effectShow, effectTriggerConfig.effectName, data.delay,
            data.sourceSkillID, effectTriggerConfig.effectAct)
        if (effectTriggerConfig.beEffectShow ~= "" and t and t.showEffectTipReport) then
            t:showEffectTipReport(effectTriggerConfig.beEffectShow, nil, data.delay, data.sourceSkillID,
                effectTriggerConfig.effectAct)
        end
    end
    skillMgr:checkPendingAffix(data)
    return lastTriggerId
end

---执行技能
---@param skillId integer 技能id
---@param target BattleBlock[] 目标
---@param delay number? 表现延迟
function BattleRole:doSkill(skillId, target, delay)
    local battleMgr = BattleCore:getBattleMgr()
    ---反击时没有技能目标信息。技能表现需要该数据，填充数据
    if self.beforeCheckTargetList == nil or self.afterCheckTargetList == nil then
        self.beforeCheckTargetList = {}
        self.afterCheckTargetList = {}
        for _, value in ipairs(target) do
            local blockId = value.id
            table.insert(self.beforeCheckTargetList, blockId)
            table.insert(self.afterCheckTargetList, blockId)
        end
    end
    battleMgr:getSkillManager():checkSkill(skillId, self, target, delay)
    --- 反击不会有主动选择地块
    if self.camp == self._roleMgr:getManualCamp() and self.skillTargetBlock then
        local orderData = {
            roleId = self.id,
            skillId = skillId,
            blockId = self:getShowBlock().id,
        }
        battleMgr:addBattleOrder(GE.BattleOrderType.SelectSkill, orderData)
        local mainSkillTargetId = self.skillTargetBlock:getTmpRoleId() or 0
        ---@type SelectBlockOrderData
        local orderData1 = {
            blockId = self.skillTargetBlock.id,
            result = {
                skillId = skillId,
                targetBlockId = self.skillTargetBlock.id,
                mainSkillTargetId = mainSkillTargetId
            }
        }
        battleMgr:addBattleOrder(GE.BattleOrderType.SelectBlock, orderData1)
        local orderData2 = {
            roleId = self.id
        }
        battleMgr:addBattleOrder(GE.BattleOrderType.RoleDoSkill, orderData2)
    end
end

---获取角色当前技能选中地块
---@return BattleBlock
function BattleRole:getSkillTargetBlock()
    return self.skillTargetBlock
end

---@param skillId integer
---@param cdNum integer
function BattleRole:setSkillCD(skillId, cdNum)
    self._skillCDList[skillId] = cdNum
end

---@param skillId integer
---@return integer
function BattleRole:getSkillCD(skillId)
    local leftCDNum = self._skillCDList[skillId] or 0
    return leftCDNum
end

function BattleRole:getAllInCDSkill()
    return self._skillCDList
end

---处理技能CD
function BattleRole:dealSkillCD()
    for k, v in pairs(self._skillCDList) do
        if v > 0 then
            local newValue = v - 1
            if newValue == 0 then
                self._skillCDList[k] = nil
            else
                self._skillCDList[k] = newValue
            end
        end
    end
end

---通过技能ID处理CD数值
function BattleRole:dealSkillCDBySkillID(skillId, offsetNum)
    local curNum = self._skillCDList[skillId] or 0
    local newValue = curNum + offsetNum
    if newValue <= 0 then
        self._skillCDList[skillId] = nil
    else
        self._skillCDList[skillId] = newValue
    end
end

---@param skillID integer
---@param offsetNum integer
function BattleRole:setSkillAmmoUsedNum(skillID, offsetNum)
    if self.isMonster == true then
        return
    end
    local curNum = self:getSkillAmmoUsedNum(skillID)
    curNum = curNum + offsetNum
    if curNum > 0 then
        self._skillAmmoUsedList[skillID] = curNum
    else
        self._skillAmmoUsedList[skillID] = nil
    end
end

---@param skillID integer
function BattleRole:getSkillAmmoUsedNum(skillID)
    local r = self._skillAmmoUsedList[skillID] or 0
    return r
end

---检测是否有剩余技能弹药数量，目前怪物不受此限制
---@param skillID integer
function BattleRole:checkHasLeftSkillAmmo(skillID)
    if self.isMonster == true then
        return true
    end
    local curNum = self:getSkillAmmoUsedNum(skillID)
    if curNum > 0 then
        local skillConfig = Config.GetSkillInfo(skillID)
        return curNum < skillConfig.usageNum
    else
        return true
    end
end

function BattleRole:getSkillAmmoUsedList()
    local r = tablex.clone(self._skillAmmoUsedList)
    return r
end

---检测技能是否可以使用
---@param skillID integer 技能ID
---@return boolean
function BattleRole:checkSkillCanBeUse(skillID)
    return self:getSkillCD(skillID) <= 0 and self:checkHasLeftSkillAmmo(skillID)
end

---统计伤害
---@param value number 伤害值
function BattleRole:statisticalDamage(value)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:getReporter():setStatistic(self.id, GE.BattleStatisticType.Damage, value)
end

---统计承伤
---@param value number 承伤值
function BattleRole:statisticalTakeDamage(value)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:getReporter():setStatistic(self.id, GE.BattleStatisticType.TakeDamage, value)
end

---统计维修
---@param value number 维修值
function BattleRole:statisticalRepair(value)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:getReporter():setStatistic(self.id, GE.BattleStatisticType.Repair, value)
end

---修改生命值
---@param value number|integer  
---@param hitData HitData
---@param source BattleRole
---@param isRepair boolean
---@param restraintCoeff number 克制系数
---@param delay number?
---@param hasPerf boolean?       --是否有表现默认false
---@param notNeedFinalHit boolean?  --是否不需要最终伤害战报 默认false
function BattleRole:modifyHp(value, hitData, source, isRepair, restraintCoeff, delay, hasPerf, notNeedFinalHit)
    if LuaLogger.Enabled and (not GV.IsServer) then
        BattleCore.ds(source.roleConfig.name, "cid", source.roleConfig.id, source.id, "dsw111BattleRole:modifyHp value", self.roleConfig.name, "cid",self.roleConfig.id
        , self.id, value, "isRepair", isRepair, "targetHP", self.hp)
    end
    if isRepair then
        local canHealth = self:checkCanHealth()
        if canHealth == false then
            value = 0
        end
    elseif isRepair == false then
        local _, buff = self:checkHasCanNotBeDamage(hitData.dmgType, hitData.effectTag)
        if buff then
            value = 0
            buff:reduceEffectLimit()
            self.buffController:checkBuffEffectLimit(buff)
        else
            value = self:_transferDamageToBuffSource(value, hitData, source, restraintCoeff, delay)
            local _, leftHpBuff = self:checkMustLeftOneHP()
            if leftHpBuff then
                local limitNum = 0
                local exParam1 = leftHpBuff:getExParam1()
                if exParam1 then
                    local limitType = exParam1[1] or 0
                    if limitType == 1 then
                        local limitPrecent = exParam1[2] or 0
                        if limitPrecent > 0 then
                            local maxHp = self:getAttrib(GE.AttribType.MaxHp)
                            limitNum = math.floor(maxHp * limitPrecent)
                        end
                    elseif limitType == 2 then
                        limitNum = exParam1[2] or 0
                    end
                end
                if limitNum > 0 and (self.hp - value) < limitNum then
                    self:SetRoleTag(GE.ActionTagType.TriggerMustLeftOneHp)
                    value = self.hp - limitNum
                    leftHpBuff:reduceEffectLimit()
                    self.buffController:checkBuffEffectLimit(leftHpBuff)
                end
            end
        end
    end
    ---数值不应该小于0
    value = math.max(value, 0)
    local battleMgr = BattleCore:getBattleMgr()
    value = math.floor(value)
    local targetCamp = self.roleConfig.camp
    if source.camp == GE.BattleCampType.Friend and not tablex.contains(targetCamp, 98) and
        not isRepair then
        battleMgr:setFriendCampAllDamageValue(value)
    end
    if (isRepair) then
        source:statisticalRepair(value)
        self.hp = self.hp + value
        self.hp = math.min(self.maxHp, self.hp)
        if not notNeedFinalHit then
            self:showHitNumber(value, hitData, true, restraintCoeff, delay, hasPerf)
        end
    else
        self.hp = self.hp - value
        if (source and source.statisticalDamage) then
            source:statisticalDamage(value)
        end
        self:statisticalTakeDamage(value)
        --伤害跳字
        if not notNeedFinalHit then
            self:showHitNumber(value, hitData, false, restraintCoeff, delay, hasPerf)
        end
        self:checkAlive(source, delay)
        if self._isAlive == false then
            source:SetRoleTag(GE.ActionTagType.HasKillEnemy)
        end
        local roleAIMgr = battleMgr:getBattleRoleAIManager()
        roleAIMgr:CheckAIEvent(GE.MonsterActiveEventType.BeHurt, self)
    end
    self:SetRoleTag(GE.ActionTagType.HpHasChange)
    -- self:SetRoleEffectActionList(source.id)
    source:SetRoleEffectActionList(self.id)
    local timing = battleMgr:getTiming()
    battleMgr:setTiming(GE.BattleTiming.RoleHpChange)
    battleMgr:setTiming(timing)
end

---@param value integer|number
---@param hitData HitData
---@param source BattleRole
---@param restraintCoeff number
---@param delay number?
---@return integer|integer
function BattleRole:_transferDamageToBuffSource(value, hitData, source, restraintCoeff, delay)
    if value <= 0 or hitData.isTransferDamage then
        return value
    end
    local hasTransferDamage, buff, transferRule, transferRatio = self:checkHasTransferDamageToBuffSource(hitData.dmgType,
        hitData.effectTag)
    if hasTransferDamage == false or buff == nil then
        return value
    end
    local buffSource = self._roleMgr:getRole(buff.sourceId)
    if buffSource == nil or buffSource.id == self.id or buffSource:getIsAlive() == false then
        return value
    end
    local transferValue = math.floor(math.max(value * transferRatio, 0))
    if transferValue <= 0 then
        return value
    end
    local transferHitData = tablex.clone(hitData)
    transferHitData.isTransferDamage = true
    buffSource:modifyHp(transferValue, transferHitData, source, false, restraintCoeff, delay)
    if transferRule == 1 then
        value = math.max(value - transferValue, 0)
    end
    return value
end

---受击
---@param damageData damageData 伤害数据
---@param delay number     延迟
---@param hitData HitData 伤害数据 治疗
---@param hasPerf boolean 是否有表现
function BattleRole:hit(damageData, delay, hitData, hasPerf, needFinalHit)
    ---@type integer
    local changeValue = 0
    local isRepair = damageData.atkCalculateType == GE.SkillCalculateType.Repair
    --治疗
    if (damageData.atkCalculateType == GE.SkillCalculateType.Repair) then
        changeValue = self:mathRepair(damageData)
    else
        changeValue = hitData.dmgValue
        damageData.source:setDamageValue(changeValue)
        if damageData.isCrit then
            self:SetRoleTag(GE.ActionTagType.HasBeCritical)
            damageData.source:SetRoleTag(GE.ActionTagType.HasCriticalOther)
        end
        self:setBeDamagedValue(changeValue)
    end
    local battleMgr = BattleCore:getBattleMgr()
    local source = damageData.source
    if source and source.camp == GE.BattleCampType.Friend then
        local sourceLogData = battleMgr:GetBattleRoleLogData(source.id)
        if sourceLogData then
            if isRepair then
                sourceLogData.totalHeal = sourceLogData.totalHeal + changeValue
            else
                sourceLogData.totalDamage = sourceLogData.totalDamage + changeValue
            end
            if damageData.isCrit then
                sourceLogData.criticalHitCount = sourceLogData.criticalHitCount + 1
            end
        end
    end
    if self.camp == GE.BattleCampType.Friend and not isRepair then
        local selfLogData = battleMgr:GetBattleRoleLogData(self.id)
        if selfLogData then
            selfLogData.totalDamageTaken = selfLogData.totalDamageTaken + changeValue
        end
    end
    local restraintCorrect = damageData.restraintCorrect --克制修正
    self:modifyHp(changeValue, hitData, damageData.source, isRepair, restraintCorrect, delay, hasPerf, not needFinalHit)
end

---@param damageData damageData 伤害数据
---@return HitData hitData 伤害数据
---@return dmgLog? dmgLog 伤害计算日志
function BattleRole:getHitData(damageData)
    local hitData = {}
    local dmgLog = nil
    local isRepair = damageData.atkCalculateType == GE.SkillCalculateType.Repair
    local NonDamage = damageData.atkCalculateType == GE.SkillCalculateType.NonDamage
    if isRepair or NonDamage then
    else
        hitData, dmgLog = self:mathDamage(damageData)
    end
    return hitData, dmgLog
end

---检测是否存活
function BattleRole:checkAlive(source, delay)
    if (self.hp <= 0) then
        local sourceId = source.id
        local battleMgr = BattleCore:getBattleMgr()
        battleMgr:getReporter():setSimpleReport(battleMgr:getCurrentRound(), sourceId, self.id, self.isMonster)
        self._isAlive = false
        self._moveAgainType = nil
        self._actionAgainType = nil
        local roleAIMgr = battleMgr:getBattleRoleAIManager()
        roleAIMgr:CheckAIEvent(GE.MonsterActiveEventType.RoleDie, self)
        self:RemoveSelf(source, delay)
    end
end

---@param source BattleRole?
---@param delay integer?
function BattleRole:RemoveSelf(source, delay)
    local battleMgr = BattleCore:getBattleMgr()
    if self._summonEffectId > 0 then
        battleMgr:RemoveSummonRoleData(self._summonEffectId, self.id)
    end
    self._roleMgr:removeRole(self, true, false, delay, source)
    local roleId = self.id
    local roleAIMgr = battleMgr:getBattleRoleAIManager()
    roleAIMgr:clearPrepareUseSkillData(roleId)
    ---跟随角色的准备类技能，目标死亡时，会清除准备技能数据
    local prepareFollowDataList = battleMgr:getPrepareSkillFollowList(roleId)
    if prepareFollowDataList then
        for _, prepareFollowData in ipairs(prepareFollowDataList) do
            local sourceId = prepareFollowData.sourceId
            roleAIMgr:clearPrepareUseSkillData(sourceId)
        end
    end
    -- battleMgr:getReporter():packStep()
end

---@class HitData 计算每发子弹伤害的数据结构
---@field dmgValue integer 总伤害
---@field singleBulletDmg number 单发子弹伤害
---@field hitNumCorrect number 中弹数量修正
---@field bulletNum number 子弹数量
---@field isCrit boolean 是否暴击
---@field restraintCorrect number 克制修正
---@field dmgType SkillDamage? 伤害类型
---@field effectTag integer[]? 伤害数据来源
---@field isTransferDamage boolean? 是否是伤害传递产生的二次伤害

---@class dmgLog 伤害计算日志
---@field dmg number 伤害基数
---@field dmgType SkillDamage 伤害类型
---@field restraintCorrect number 克制修正
---@field terrCorrect number 地形修正
---@field def number 最终防御属性
---@field baseDmgRate number 基础伤害率
---@field dmgCorrectA number A类伤害修正
---@field dmgCorrectB number B类伤害修正
---@field defCorrectA number A类防御修正
---@field defCorrectB number B类防御修正
---@field skillMultCorrect number 技能倍率修正
---@field critCorrect number 暴击修正
---@field finalDmgValue number 最终伤害值

---计算伤害
---@param damageData damageData 伤害数据
---@return HitData dmgValue 伤害值
---@return dmgLog dmgLog 伤害计算日志
function BattleRole:mathDamage(damageData)
    local restraintCorrect = damageData.restraintCorrect

    local def = 0
    local terrainDef = 1
    local exTerrainDef = 0
    local tData = damageData.terrainCfg or self.block.terrainCfgData
    local canFly = self.roleConfig.canFly == 1
    ---空中单位不受地形防御加成影响
    if tData and canFly == false then
        terrainDef = tData.defAdd
        exTerrainDef = self:getAttrib(GE.AttribType.TerrainRatio, tData.tags)
    end
    --- 对空单位伤害修正
    local flyUnitRatio = 1
    local terrCorrect = terrainDef + exTerrainDef             --地形修正
    local bulletHitRate = 1                                --中弹率
    local baseDmgValue = math.floor(damageData.damage * restraintCorrect) --伤害基数
    if (damageData.damageType == GE.SkillDamageType.Bombard) then
        def = self:getAttrib(GE.AttribType.Armor)
    elseif (damageData.damageType == GE.SkillDamageType.Torpedo) then
        def = self:getAttrib(GE.AttribType.Evade)
        if canFly then
            flyUnitRatio = 0.7
        end
    else
        BattleCore.es("BattleRole:mathDamage wrong SkillDamageType", damageData.damageType)
    end

    local finalDmg = damageData.damage --最终伤害属性
    local finalDef = 0              --最终防御属性

    if (damageData.atkCalculateType == GE.SkillCalculateType.Normal) then
        finalDef = math.floor(def * terrCorrect)
        if (damageData.damageType == GE.SkillDamageType.Bombard) then
            baseDmgValue = baseDmgValue - finalDef
        else
            bulletHitRate = (baseDmgValue - finalDef) / baseDmgValue
        end
    elseif (damageData.atkCalculateType == GE.SkillCalculateType.AirDefense) then
        local defCor = math.floor(def * 0.3 * terrCorrect)
        local airDef = math.floor(self:getAttrib(GE.AttribType.AirDefense) * terrCorrect)
        finalDef = airDef + defCor
        if (damageData.damageType == GE.SkillDamageType.Bombard) then
            bulletHitRate = (baseDmgValue - finalDef) / (baseDmgValue - defCor)
            baseDmgValue = baseDmgValue - defCor
        else
            bulletHitRate = (baseDmgValue - finalDef) / baseDmgValue
        end
    end
    ---命中率最低是0
    bulletHitRate = math.max(0, bulletHitRate)

    local baseDmgRate = self:getAttrib(GE.AttribType.BaseDamageRate) --基础伤害率
    local dmgCorrectA = math.max(0.1, 1 + damageData.exDamageRatio)    --A类伤害修正
    local dmgCorrectB = math.max(0.1, 1 + damageData.exDamageRatioB)      --B类伤害修正
    local defCorrectA = math.min(0.9, self:getAttrib(GE.AttribType.IntelHuntCut)) --A类防御修正
    local defCorrectB = math.min(0.9, self:getAttrib(GE.AttribType.RestraintBuffRatio))                                         --B类防御修正
    local skillMultCorrect = damageData.skillAddRatio --技能倍率修正
    local critCorrect = damageData.isCrit and 1.3 or 1            --暴击修正
    if damageData.isCrit then
        critCorrect = critCorrect + damageData.exCritRatio
    end
    local dmgValue = ((finalDmg * restraintCorrect) - finalDef) *
        baseDmgRate * dmgCorrectA * dmgCorrectB * (1 - defCorrectA) * (1 - defCorrectB) *
        skillMultCorrect * critCorrect * flyUnitRatio

    dmgValue = math.floor(math.max(dmgValue, 1))
    ---@type dmgLog
    local dmgLog = {
        dmg = finalDmg,
        dmgType = damageData.damageType,
        restraintCorrect = restraintCorrect,
        terrCorrect = terrCorrect,
        def = finalDef,
        baseDmgRate = baseDmgRate,
        dmgCorrectA = dmgCorrectA,
        dmgCorrectB = dmgCorrectB,
        defCorrectA = defCorrectA,
        defCorrectB = defCorrectB,
        skillMultCorrect = skillMultCorrect,
        critCorrect = critCorrect,
        finalDmgValue = dmgValue
    }
    if LuaLogger.Enabled == true and (not GV.IsServer) then
        BattleCore.ds("BattleRole:hit damageData", tablex.dump(dmgLog))
    end

	baseDmgValue = math.max(baseDmgValue, 0)
    local baseHitNum = damageData.hitRate * 0.01 * damageData.bulletNum           --基础中弹数量
    local hitNumCorrect = bulletHitRate * baseHitNum                              --修正中弹数量
    local firePow = baseDmgRate / (damageData.hitRate * 0.01) / damageData.bulletNum --火力值
    local singleBulletDmg = baseDmgValue * firePow * skillMultCorrect * critCorrect 
        * dmgCorrectA * dmgCorrectB * (1 - defCorrectA) * (1 - defCorrectB) * flyUnitRatio         --单发伤害
    if not GV.IsServer then
        BattleCore.ds("命中表现数据:", baseHitNum, hitNumCorrect, firePow, damageData.bulletNum, singleBulletDmg, dmgValue)
    end

    ---@type HitData
    local hitData = {}
    hitData.dmgValue = dmgValue
    hitData.singleBulletDmg = singleBulletDmg
    hitData.hitNumCorrect = hitNumCorrect
    hitData.bulletNum = damageData.bulletNum
    hitData.isCrit = damageData.isCrit
    hitData.restraintCorrect = damageData.restraintCorrect
    hitData.dmgType = damageData.damageType
    return hitData, dmgLog
end

---计算维修
---@param damageData damageData 伤害数据
---@return number repairValue 维修值
function BattleRole:mathRepair(damageData)
    local finalDmg = damageData.damage --最终伤害属性
    local repairCorrectA = damageData.healthRatio        --攻击方维修修正
    local repairCorrectB = self:getAttrib(GE.AttribType.BeHealthRatio, nil)        --作用方维修修正
    local repairAddition = 1 + repairCorrectA + repairCorrectB
    repairAddition = math.max(repairAddition, 0)
    local skillMultCorrect = damageData.skillAddRatio --技能倍率修正
    local baseDmgRate = damageData.baseDamageRate  --基础伤害率
    local repairValue = finalDmg * repairAddition * skillMultCorrect * baseDmgRate
    -- local repairLog = {
    --     dmg = finalDmg,
    --     dmgType = damageData.damageType,
    --     baseDmgRate = baseDmgRate,
    --     repairAddition = repairAddition,
    --     skillMultCorrect = skillMultCorrect,
    --     finalRepairValue = repairValue
    -- }
    -- LuaLogger.ds("BattleRole:hit repairData", tablex.dump(repairLog))
    repairValue = math.max(repairValue, 0)
    return repairValue
end

function BattleRole:setDamageValue(v)
    self._curTurnDamageValue = v
end

function BattleRole:getDamageValue()
    return self._curTurnDamageValue
end

function BattleRole:clearDamageValue()
    self._curTurnDamageValue = 0
end

function BattleRole:setBeDamagedValue(v)
    self._curTurnBeDamagedValue = self._curTurnBeDamagedValue + v
end

function BattleRole:getBeDamagedValue()
    return self._curTurnBeDamagedValue
end

function BattleRole:clearBeDamagedValue()
    self._curTurnBeDamagedValue = 0
end

---攻击动画
function BattleRole:showAttackAnim(...)
    self:roleAttackReport(...)
end

---攻击动画Timeline
function BattleRole:showAttackTimeline(delay, timeline, animName, effectName)
    self:roleTimelineReport(timeline, delay)
end

---受击跳字
---@param hitData HitData
---@param restraintCoeff number 克制系数
function BattleRole:showHitNumber(dmgValue, hitData, isRepair, restraintCoeff, delay, hasPerf)
    if (not delay) then
        delay = 0
    end
    self:showHitNumberReport(dmgValue, hitData, isRepair, restraintCoeff, delay + 0.5, hasPerf)
end

---加Buff
---@param buff Buff buff
---@param delay number? 表现延迟
function BattleRole:addBuff(buff, delay)
    self.buffController:addBuff(buff, delay)
    local source = self._roleMgr:getRole(buff.sourceId, true)
    if source ~= nil then
        source:SetRoleEffectActionList(self.id)
    end
end

---驱散Buff
---@param tags table 标签数组
---@param count integer 驱散数量
---@param delay number|nil 表现延迟
function BattleRole:dispelBuff(tags, count, delay)
    self.buffController:removeBuffByTags(tags, count, delay)
end

---获取Buff管理器
function BattleRole:getBuffController()
    return self.buffController
end

---面向地块
---@param block BattleBlock 面朝地块
---@param needReport boolean? 是否加入战报
---@param moveBlock BattleBlock? 移动终点地块
function BattleRole:faceToBlock(block, needReport, moveBlock)
    local curBlock = self:getShowBlock()
    --若通过战报转向需要判断移动终点moveBlock和目标点block是否重合
    --直接转向用的是当前点位 self:getShowBlock()
    if curBlock.id ~= block.id or (moveBlock and moveBlock.id ~= block.id) then
        local direction = self._roleMgr:getFaceToBlockDirection(moveBlock or self:getShowBlock(), block, self.direction)
        --LuaLogger.ds("BattleRole:faceToBlock direction", direction)
        self:turnDirection(direction, needReport == true, 0)
    end
end

---转向
---@param direction integer 方向类型
---@param isReport boolean 是否加入战报
---@param delay number? 表现延迟
function BattleRole:turnDirection(direction, isReport, delay)
    self.direction = direction
    local battleMgr = BattleCore:getBattleMgr()
    if battleMgr:isVerifyMode() then
        return
    end
    if (isReport) then
        self:turnDirectionReport(delay, direction)
    else
        local showMgr = BattleCore:getBattleMgr():getShowManager()
        if (showMgr) then
            local data = {
                id = self.id,
                direction = direction,
                delay = 0
            }
            showMgr:roleTurnDirection(data)
        end
    end
end

---开始再移动
function BattleRole:startMoveAgain(type)
    self._chooseMoveBlock = nil
    self.skillTargetBlock = nil
    self._roleMgr:setLockRole(self)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:setSelectRole(self)
    self:pauseAction()
    self.skillTarget = nil
    self:clearSkillTarget()
    -- self.selectedSkill = self.normalSkill
    -- self._moveAgainType = nil
    -- self._roleMgr:checkAutoAction(self)
    self._curMoveRange, self._curMoveRangeKV = battleMgr:getMap():getMoveRange(self, type, self._againMovePower)
    self:roleActiveReport()
    battleMgr:refreshRoleActionType(self, GE.RoleActionType.OnlyMove, type)
    battleMgr:setBattleState(GE.BattleState.WaitInputOrder)
end

---开始再行动
function BattleRole:startActionAgain(type)
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    self._roleMgr:removeRoleInCompleteActionList(self)
    self._roleMgr:setLockRole(self)
    battleMgr:setSelectRole(self)
    self:SetRoleTag(GE.ActionTagType.ActionAgain)
    self.selectedSkill = self.normalSkill
    self._curMoveRange, self._curMoveRangeKV = mapMgr:getMoveRange(self, type, self._againMovePower)
    self._curAtkRange, self._curAtkRangeKV = mapMgr:getChooseRangeByMoveRange(self._curMoveRange, self.normalSkill, self)
    self:roleActiveReport()
    battleMgr:refreshRoleActionType(self, GE.RoleActionType.Normal, type)
    self:enterActionState()
    self._actionAgainType = nil
    self._againMovePower = nil
    battleMgr:setBattleState(GE.BattleState.WaitInputOrder)
end

---触发再移动
---@param type MovePowerType 类型为Fixed时，需要设置movePower数值
---@param movePower integer?
function BattleRole:moveAgain(type, movePower)
    self._moveAgainType = type
    self._againMovePower = movePower
end

---获取再移动类型
function BattleRole:getMoveAgainType()
    return self._moveAgainType
end

---触发再行动
---@param type MovePowerType 类型为Fixed时，需要设置movePower数值
---@param movePower integer?
function BattleRole:actionAgain(type, movePower)
    self._actionAgainType = type
    self._againMovePower = movePower
end

---刷新护卫队友时相关数据
---@param showBlock BattleBlock?
---@param isShartShow boolean true:开始护卫 false:结束护卫
function BattleRole:refreshBlockByShowGuard(showBlock, isShartShow)
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    if isShartShow and showBlock then
        self.tmpBlock = showBlock
        self.tmpBlock:setTmpRoleId(self.id)
    else
        if self.tmpBlock then
            self.tmpBlock:setTmpRoleId(nil)
        end
        self.tmpBlock = nil
    end
    mapMgr:removeAllBlockEffectGroupByRoleId(self.id)
    self:SetRoleTag(GE.ActionTagType.GuardOther)
    local skillMgr = battleMgr:getSkillManager()
    self:removeBlockEffect()
    self.buffController:checkHaloBuff(true)
    for _, triggerId in ipairs(self.haloSkillList) do
        skillMgr:checkEffect(triggerId, self, {self:getShowBlock().id})
    end
    self:checkBlockEffect(showBlock)
end

function BattleRole:refreshHaloBuff()
    local battleMgr = BattleCore:getBattleMgr()
    local mapMgr = battleMgr:getMap()
    mapMgr:removeAllBlockEffectGroupByRoleId(self.id)
    local skillMgr = battleMgr:getSkillManager()
    self.buffController:checkHaloBuff(true)
    for _, triggerId in ipairs(self.haloSkillList) do
        skillMgr:checkEffect(triggerId, self, {self.block.id})
    end
    self:checkBlockEffect()
end

---设置防卫的角色id
---@param guardRoleId integer?
function BattleRole:setGuardRoleId(guardRoleId)
    self._guardRoleId = guardRoleId
end

function BattleRole:getGuardRoleId()
    return self._guardRoleId
end

function BattleRole:getWaypointList()
    return self._waypointList
end

---自动战斗时计算对自身释放类技能时，需要在计算中临时移动自身所处地格
---@param block BattleBlock?
function BattleRole:setTmpBlockForAI(block)
    if self.tmpBlock then
        self.tmpBlock:setTmpRoleId(nil)
    end
    self.tmpBlock = block
    if self.tmpBlock then
        self.block:setTmpRoleId(-1)
        self.tmpBlock:setTmpRoleId(self.id)
    else
        self.block:setTmpRoleId(nil)
    end
end

function BattleRole:getShowBlock()
    return self.tmpBlock or self.block
end

---设置移动终点地格，提供给AI和战报使用
---@param block BattleBlock
---@param path integer[]?
function BattleRole:setChooseMoveBlock(block, path)
    self._chooseMoveBlock = block
    self._movePathList = path
end

function BattleRole:getChooseMoveBlock()
    return self._chooseMoveBlock
end

---获取剩余行动力
function BattleRole:getRemainMovePower()
    return self._remainMovePower
end

---获取移动路径列表，会包含起始点，故计算移动距离时需要减1(移动后被清除，所以无法用来判断本回合是否有移动)
function BattleRole:getMovePathList()
    return self._movePathList
end
---获取移动经过的地格数量
function BattleRole:getHasMoveDistance()
    return self._hasMoveDistance
end

---@class RefreshEffectData
---@field refreshType integer
---@field maxLimitNum integer
---@field refreshRoundNum integer
---@field curRefreshRoundNum integer
---@field curEffectNum integer

---@param effectData EffectTriggerTable
function BattleRole:setNeedRefreshData(effectData)
    local effectId = effectData.id
    local roundNum = 0
    local limitNum = 0
    local limitData = effectData.limitNum
    if effectData.limitType == GE.EffectRefreshType.RefreshAfterRound then
        roundNum = limitData[1]
        limitNum = limitData[2]
    elseif effectData.limitType == GE.EffectRefreshType.NeverRefresh then
        limitNum = limitData[1]
    end
    ---@type RefreshEffectData
    local d = {
        refreshType = effectData.limitType,
        maxLimitNum = limitNum,
        refreshRoundNum = roundNum,
        curRefreshRoundNum = roundNum,
        curEffectNum = limitNum,
    }

    self._needRefreshEffectList[effectId] = d
end

---@param effectId integer
function BattleRole:reduceEffectLimitNumById(effectId)
    local data = self._needRefreshEffectList[effectId]
    if data then
        data.curEffectNum = data.curEffectNum - 1
    end
end

function BattleRole:checkAndRefreshEffectLimitNum()
    for _, v in pairs(self._needRefreshEffectList) do
        if v.refreshType == GE.EffectRefreshType.RefreshAfterRound and v.curEffectNum < v.maxLimitNum then
            if v.curRefreshRoundNum > 0 then
                v.curRefreshRoundNum = v.curRefreshRoundNum - 1
            end
            if v.curRefreshRoundNum <= 0 then
                v.curRefreshRoundNum = v.refreshRoundNum
                v.curEffectNum = v.maxLimitNum
            end
        end
    end
end

---@param effectData EffectTriggerTable
---@return boolean
function BattleRole:getCanTakeEffectById(effectData)
    local effectId = effectData.id
    local r = true
    local data = self._needRefreshEffectList[effectId]
    if data then
        r = data.curEffectNum > 0
    else
        if effectData.limitType > 0 then
            self:setNeedRefreshData(effectData)
        end
    end
    return r
end

function BattleRole:checkCanHealth()
    return self.buffController:checkCanHealth()
end

function BattleRole:checkMustLeftOneHP()
    return self.buffController:checkMustLeftOneHP()
end

function BattleRole:checkHasCanNotBeDamage(damageType, effectTag)
    return self.buffController:checkHasCanNotBeDamage(damageType, effectTag)
end

function BattleRole:checkHasTransferDamageToBuffSource(damageType, effectTag)
    return self.buffController:checkHasTransferDamageToBuffSource(damageType, effectTag)
end

function BattleRole:checkCanDoAction()
    return self.buffController:checkCanDoAction()
end

---检测是否被护卫
---@return boolean, Buff?
function BattleRole:checkHasGuard()
    return self.buffController:checkHasGuard()
end

---检测是否有无视护卫效果
---@return boolean, Buff?
function BattleRole:checkHasIgnoreGuard()
    return self.buffController:checkHasIgnoreGuard()
end

---检测是否有无法使用主动技能效果
---@return boolean, Buff?
function BattleRole:checkHasCanNotUseActiveSkill()
    return self.buffController:checkHasCanNotUseActiveSkill()
end

---@param buffTags integer[]
function BattleRole:getAddBuffRoundOffset(buffTags)
    return self.buffController:getAddBuffRoundOffset(buffTags)
end

---@param buffTags integer[]
function BattleRole:getSetBuffRoundOffset(buffTags)
    return self.buffController:getSetBuffRoundOffset(buffTags)
end

---@param tagID ActionTag
function BattleRole:SetRoleTag(tagID)
    self._actionTagList[tagID] = true
end

---@param tagID ActionTag
---@return boolean
function BattleRole:CheckHasTag(tagID)
    local hasTag = self._actionTagList[tagID] ~= nil
    return hasTag
end

--- 清理行动标签
function BattleRole:ClearTagList()
    self._actionTagList = {}
end

function BattleRole:GetTagList()
    return self._actionTagList
end

---设置释放技能的目标列表（释放方和被击方都会记录）
---@param roleId integer
function BattleRole:SetRoleActionList(roleId)
    self._roleActionList[roleId] = true
end

---获取释放技能的目标列表（释放方和被击方都会记录）
function BattleRole:GetRoleActionList()
    return self._roleActionList
end

--- 清理目标列表
function BattleRole:ClearRoleActionList()
    self._roleActionList = {}
end

---设置效果的目标列表（释放方和被击方都会记录）
---@param roleId integer
function BattleRole:SetRoleEffectActionList(roleId)
    self._effectActionList[roleId] = true
end

---获取效果的目标列表（释放方和被击方都会记录）
function BattleRole:GetRoleEffectActionList()
    return self._effectActionList
end

--- 清理效果目标列表
function BattleRole:ClearRoleEffectActionList()
    self._effectActionList = {}
end

---角色被移除
function BattleRole:destroy(isFormationState, delay)
    -- self.block:setRoleId(nil)
    if (isFormationState) then
        local data = {
            id = self.id,
            delay = 0
        }
        BattleCore:getBattleMgr():getShowManager():roleRemove(data)
        return
    end
    ---检测死亡时的效果
    self:checkSkills()
end

function BattleRole:getMoveCostOffset()
    local v = self.buffController:getTerrainMoveCost()
    return v
end

---@param value SkillSelectType
function BattleRole:setSkilSelecctState(value)
    self._skillSelectState = value
end

function BattleRole:getSkilSelecctState()
    return self._skillSelectState
end

function BattleRole:setAIConfig(configData)
    self._aiConfig = configData
end

function BattleRole:getAIConfig()
    return self._aiConfig
end

function BattleRole:getIsAlive()
    return self._isAlive
end

function BattleRole:switchNormalSkill()
    if (self.normalSkill2 == 0) then
        return
    end
    self.normalSkill = self.normalSkill == self.normalSkill1 and self.normalSkill2 or self.normalSkill1
    self:calculateActionRange()
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:refreshRoleActionState(self, true)
    battleMgr:callClientShowEvent(GE.ClientBattleShowType.RefreshRoleAction, {
        role = self,
        isInit = true,
    })
end

---@param camp BattleCampType 阵营
function BattleRole:switchRoleCamp(camp)
    self.camp = camp
    self:showHpReport()
end

---切换攻击镜头
---@param isChange boolean 是否切换
---@param targets table<integer> 目标id列表
---@param delay number? 延迟时间
function BattleRole:changeAttackVcam(isChange, targets, delay)
    if (self.camp ~= GE.BattleCampType.Enemy) then
        self:changeAttackVcamReport(isChange, targets, delay)
    end
end

---@param isChange boolean?
function BattleRole:setBuffChangeChangeFlag(isChange)
    self._buffChangeFlag = isChange
end

function BattleRole:getBuffChangeChangeFlag()
    return self._buffChangeFlag
end

---region 表现战报------------------------------------------------------------------------------------

---@param blockId integer
---@param roleData LevelRoleData
---@param skinConfig CharacterSkinTable
function BattleRole:roleCreateReport(blockId, roleData, skinConfig)
    -- LuaLogger.ds("BattleRole:roleCreateReport")
    local _isShow = true
    if roleData.isShowEffect ~= nil then
        _isShow = roleData.isShowEffect
    end
    local _delay = roleData.delay
    local battleMgr = BattleCore:getBattleMgr()
    ---@type RoleCreateData
    local reportData = {
        cid = self.cid,
        id = self.id,
        blockId = blockId,
        image = skinConfig.modelKey,
        modelRate = skinConfig.modelRate,
        modelOffset = skinConfig.modelOffset,
        hpBarOffset = skinConfig.HpBarOffset,
        direction = self.direction,
        hp = self:getAttrib(GE.AttribType.Hp),
        maxHp = self:getAttrib(GE.AttribType.MaxHp),
        camp = self.camp,
        buffList = self.buffController:getBuffList(),
        attribute = self.roleConfig.attribute,
        isShow = true,
        isShowEffect = _isShow,
        moveShowType = skinConfig.moveShowType,
        delay = _delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RoleCreate, reportData)
    if _delay and (_delay > 0) then
        battleMgr:getReporter():packStep()
    end
end

function BattleRole:roleRemoveReport(delay)
    -- LuaLogger.ds("BattleRole:roleRemoveReport")
    local battleMgr = BattleCore:getBattleMgr()
    local reportData = {
        id = self.id,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RoleRemove, reportData)
end

function BattleRole:roleAttackReport(delay, animName, effectId)
    if self._isAlive == false then
        return
    end
    -- LuaLogger.ds("BattleRole:roleAttackReport")
    local battleMgr = BattleCore:getBattleMgr()
    local reportData = {
        id = self.id,
        animName = animName,
        effectId = effectId,
        direction = self.direction,
        delay = delay,
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RoleAttack, reportData)
end

function BattleRole:roleTimelineReport(timeline, delay)
    if self._isAlive == false then
        return
    end
    -- LuaLogger.ds("BattleRole:roleTimelineReport",timeline)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:getReporter():packStep()
    local reportData = {
        id = self.id,
        timeline = timeline,
        skinConfig = self.skinConfig,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RoleTimeline, reportData)
    battleMgr:getReporter():packStep()
end

function BattleRole:roleStandbyReport(delay)
    if self._isAlive == false then
        return
    end
    -- LuaLogger.ds("BattleRole:roleStandbyReport RoleActive")
    local battleMgr = BattleCore:getBattleMgr()
    local reportData = {
        id = self.id,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RoleStandby, reportData)
end

---相机聚焦战报
---@param blockId integer 地块id
---@param isDoTween boolean? 是否显示
---@param cbProgress number? 回调触发占dotween进度
function BattleRole:LookAtBlockReport(blockId, isDoTween, cbProgress)
    if self._isAlive == false then
        return
    end
    local battleMgr = BattleCore:getBattleMgr()
    ---@type BlockReportData
    local reportData = {
        blockId = blockId,
        isDoTween = isDoTween,
        progress = cbProgress,
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.LookAtBlockReport, reportData)
end

---相机聚焦战报
---@param blockId number 地块id
---@param type FollowTargetType 跟随类型
---@param isEdge boolean 是否边缘跟随
function BattleRole:SmoothFollowTargetReport(blockId, type, isEdge)
    if self._isAlive == false then
        return
    end
    local battleMgr = BattleCore:getBattleMgr()
    ---@type smoothFollowTargetReportData
    local reportData = {
        blockId = blockId,
        type = type,
        isEdge = isEdge
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.SmoothFollowTargetReport, reportData)
end

---@class HitReportData 伤害跳字战报的数据结构
---@field id integer role的id
---@field isRepair boolean 是否是回血
---@field delay integer? 战报延时播放时间
---@field hitData HitData 伤害数据  为治疗的话就为{}
---@field restraintCoeff number 克制系数
---@field dmg number 伤害   本次跳字为伤害的话和hitData.dmgValue一样

---伤害跳字
---@param dmg number 伤害
---@param hitData HitData
---@param isRepair boolean 是否是回血
---@param restraintCoeff number 克制系数
---@param delay number 表现延时
---@param hasPerf boolean 是否有过表现 有过则在最终表现的时候不修改角色血量，因为血量会在弹道表现阶段扣除，这里就显示总伤害，buff类没有表现，所以总伤害需要扣血
---@param needFinalHit boolean 是否需要显示最终的扣血
function BattleRole:showHitNumberReport(dmg, hitData, isRepair, restraintCoeff, delay, hasPerf, needFinalHit)
    -- LuaLogger.ds("BattleRole:showHitNumberReport")
    local battleMgr = BattleCore:getBattleMgr()
    ---@type HitReportData
    local reportData = {
        id = self.id,
        isRepair = isRepair,
        delay = delay,
        hitData = hitData,
        restraintCoeff = restraintCoeff,
        dmg = dmg,
        hasPerf = hasPerf
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.ShowHitNumber, reportData)
end

---效果提示
---@param effectDesc string 效果提示名称
---@param delay number 表现延时
---@param effectId integer 效果预制体名
---@param skillId integer 技能id
---@param effectAct string 动作名称
function BattleRole:showEffectTipReport(effectId, effectDesc, delay, skillId, effectAct)
    -- LuaLogger.ds("BattleRole:showEffectTipReport", effectId, effectDesc, delay, skillId)
    --两者都为空则return
    if effectId == "" or effectId == nil or effectId == 0 then
        if effectDesc == "" or effectDesc == nil then
            return
        end
    end
    local skillConfig
    if skillId then
        skillConfig = Config.GetSkillInfo(skillId)
    end
    local needPack = effectId ~= 0 or effectDesc ~= "" or effectAct ~= ""
    local battleMgr = BattleCore:getBattleMgr()
    ---@type EffectTipData
    local reportData = {
        id = self.id,
        effectDesc = effectDesc,
        effectId = effectId,
        delay = delay,
        icon = skillConfig and skillConfig.icon,
        modelOffset = self.skinConfig.modelOffset,
        effectAct = effectAct
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.ShowEffectTip, reportData)
end

function BattleRole:turnDirectionReport(delay, direction)
    if self._isAlive == false then
        return
    end
    -- print("BattleRole:turnDirectionReport")
    local battleMgr = BattleCore:getBattleMgr()
    local reportData = {
        id = self.id,
        direction = direction,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RoleTurnDirection, reportData)
end

-- --添加角色位移战报（下潜用）
-- ---@param delay number 延时
-- ---@param offset number y轴位移
-- function BattleRole:RoleOffsetMoveReport(delay, offset)
--     print("BattleRole:RoleOffsetMoveReport")
--     local battleMgr = BattleCore:getBattleMgr()
--     local reportData = {
--         roleId = self.id,
--         offset = offset,
--         delay = delay
--     }
--     battleMgr:getReporter():addReport(GE.BattleReportType.RoleOffsetMove, reportData)
-- end

function BattleRole:showHpReport(delay)
    -- print("BattleRole:showHpReport camp",self.camp)
    local battleMgr = BattleCore:getBattleMgr()
    local reportData = {
        id = self.id,
        hp = self:getAttrib(GE.AttribType.Hp),
        maxHp = self:getAttrib(GE.AttribType.MaxHp),
        camp = self.camp,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.ShowRoleHp, reportData)
end

function BattleRole:showTargetEffectReport(blockId, delay)
    if self._isAlive == false then
        return
    end
    local battleMgr = BattleCore:getBattleMgr()
    local reportData = {
        blockId = blockId,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.ShowTargetEffect, reportData)
end

---@class DefateReportData
---@field id integer
---@field audioData table?
---@field skinConfig CharacterSkinTable?
---@field roleName LocalStrEnum?
---@field delay number?

---@param source BattleRole?
function BattleRole:showDefeatReport(source, delay)
    local battleMgr = BattleCore:getBattleMgr()
    local _roleName = nil
    local skinConfig = nil
    local _audioData = nil
    ---防止因效果被击杀时触发击杀音效
    if source and source.id ~= self.id then
        _roleName = source.roleConfig.name
        skinConfig = source.skinConfig
        _audioData = skinConfig.battleKill
    end
    if _audioData == nil or (_audioData ~= nil and not next(_audioData)) then
        skinConfig = self.skinConfig
        if skinConfig then
            _audioData = skinConfig.battleDie
        end
        _roleName = self.roleConfig.name
    end
    ---@type DefateReportData
    local reportData = {
        id = self.id,
        audioData = _audioData,
        skinConfig = skinConfig,
        roleName = _roleName,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.ShowDefeat, reportData)
end

function BattleRole:roleActiveReport(delay)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:getReporter():packStep()
    local reportData = {
        id = self.id,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RoleActive, reportData)
end

---刷新角色Buff状态
---@param delay number? 表现延时
function BattleRole:refreshBuffStateReport(delay)
    local battleMgr = BattleCore:getBattleMgr()
    -- 获取buffId列表
    local buffIdList = {}
    local buffList = self.buffController:getRawBuffList()
    local index = 1
    local maxIndex = 3
    for _, buff in ipairs(buffList) do
        local buffConfig = buff.configData
        if not string.isNullOrEmpty(buffConfig.buffIcon) then
            buffIdList[index] = buff.id
            index = index + 1
            if index > maxIndex then
                break
            end
        end
    end
    -- 创建战报
    ---@class BuffStateReportData
    ---@field id integer
    ---@field buffs integer[]
    ---@field delay number?
    local reportData = {
        id = self.id,
        buffs = buffIdList,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.RefreshHeroBuffState, reportData)
end

---切换攻击镜头战报
---@param isChange boolean 是否切换
---@param targets table<integer> 目标id列表
---@param delay number? 表现延时
function BattleRole:changeAttackVcamReport(isChange, targets, delay)
    local battleMgr = BattleCore:getBattleMgr()
    battleMgr:getReporter():packStep()
    local reportData = {
        id = self.id,
        targets = targets,
        isChange = isChange,
        delay = delay
    }
    battleMgr:getReporter():addReport(GE.BattleReportType.ChangeAttackVcam, reportData)
    battleMgr:getReporter():packStep()
end

---endregion -- 表现战报------------------------------------------------------------------------------------

function BattleRole:PlayMoveAudio()

end

return BattleRole
