module("fight.SkillManager", Class.impl())
-- 构造函数
function ctor(self)
    self.m_skillDic = nil
    self.m_skillTypeDict = {}
    self.m_skillEftDict = nil
    self.m_skillEditDataDict = nil
    self:_parseSkillData()
    self:_parseSkillEftData()
end

-- 初始化配置表
function _parseSkillData(self)
    self.m_skillDic = {}
    local baseData = RefMgr:getData('skill_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.SkillDataRo)
        ro:parseData(key, data)
        self.m_skillDic[key] = ro

        local typeDict = self.m_skillTypeDict[ro:getType()]
        if not typeDict then
            typeDict = {}
            self.m_skillTypeDict[ro:getType()] = typeDict
        end
        table.insert(typeDict, ro)
    end
end

function _parseSkillEftData(self)
    self.m_skillEftDict = {}
    local baseData = RefMgr:getData('effect_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.EffectDataRo)
        ro:parseData(key, data)
        self.m_skillEftDict[key] = ro
    end
end

function _parseSkillEditData(self)
    self.m_skillEditDataDict = {}
    local baseData = RefMgr:getData('skill_editor_data')
    for modelID, skillData in pairs(baseData) do
        local skillMap = self.m_skillEditDataDict[modelID]
        if not skillMap then
            skillMap = {}
            self.m_skillEditDataDict[modelID] = skillMap
        end
        for skillName, skillVal in pairs(skillData) do
            local ro = LuaPoolMgr:poolGet(fight.SkillEditorDataRo)
            ro:parseData(modelID, skillVal)
            skillMap[skillName] = ro
        end
    end
end

-- 技能基础数据
function skillRos(self)
    if self.m_skillDic == nil then
        self:_parseSkillData()
    end
    return self.m_skillDic
end

function skillEftRos(self)
    if self.m_skillEftDict == nil then
        self:_parseSkillEftData()
    end
    return self.m_skillEftDict
end

function skillEditDataRos(self)
    if self.m_skillEditDataDict == nil then
        self:_parseSkillEditData()
    end
    return self.m_skillEditDataDict
end

-- 取技能基础数据
function getSkillRo(self, skillID)
    local dic = self:skillRos()
    if dic[skillID] == nil then
        Debug:log_error("SkillManager", "不存在skillId:" .. tostring(skillID))
        return
    end
    return dic[skillID]
end

function getSkillRosByType(self, skillType)
    self:skillRos()
    return self.m_skillTypeDict[skillType]
end

function getSkillEftRo(self, eftID)
    local dic = self:skillEftRos()
    if dic[eftID] == nil then
        Debug:log_error("SkillManager", "不存在eftD:" .. tostring(eftID))
        return
    end
    return dic[eftID]
end

function getSkillEditDataRo(self, modelID, skillID)
    local skillRo = self:getSkillRo(skillID)
    if not skillRo then
        return
    end
    return self:getSkillEditDataRo01(modelID, skillRo:getAnimation())
end

function getSkillEditDataRo01(self, modelID, skillName)
    local dic = self:skillEditDataRos()
    local modelData = dic[modelID]
    if modelData == nil then
        -- 没有特殊战斗效果则读取默认的
        local arr = string.split(modelID, "_")
        local baseModelId = arr[1] --切掉时装后缀
        modelData = dic[baseModelId]
        if modelData == nil then
            Debug:log_warn("SkillManager", "modelID: " .. tostring(modelID) .. " 不存在技能表现数据")
            return
        end
    end
    -- table.print(modelData)
    local editorRo = modelData[skillName]
    if editorRo == nil then
        Debug:log_warn("SkillManager", "modelID: " .. tostring(modelID) .. " 不存在 [" .. tostring(skillName) .. "] 技能表现数据")
    end
    return editorRo
end

function getSkillEftCountList(self, skillID)
    local skillRo = self:getSkillRo(skillID)
    if skillRo then
        local countList = {}
        local efts = skillRo:getEffect()
        for _, eftID in ipairs(efts) do
            local eftRo = self:getSkillEftRo(eftID)
            if eftRo then
                table.insert(countList, eftRo:getEffectCount())
            end
        end
        if not table.empty(countList) then
            return countList
        end
    end
end

-- 获取技能镜头类型（单体，直线……）
function getSkillCameraType(self, skillID)
    local skillRo = self:getSkillRo(skillID)
    if skillRo then
        return skillRo:getCameraType()
    end
    return 1
end

-- 获取技能目标选取
function getSkillEftTargetRule(self, skillID)
    local skillRo = self:getSkillRo(skillID)
    if skillRo then
        local efts = skillRo:getEffect()
        for _, eftID in ipairs(efts) do
            local eftRo = self:getSkillEftRo(eftID)
            if eftRo then
                return eftRo:getTargetRule()
            end
        end
    end
    return 1
end

-- 获取战员的技能描述（可升级的在技能升级配置表拿，拿不到就到技能表拿）
function getHeroSkillDesc(self, skillId, heroVo)
    local skillVo = nil
    if heroVo and heroVo.activeSkillDic then
        local skillLvl = heroVo:getActiveSkill(skillId) + heroVo:getExtraLv(skillId)
        skillVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillId, skillLvl)
    end
    if not skillVo then
        skillVo = self:getSkillRo(skillId)
    end
    return skillVo:getDesc()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]