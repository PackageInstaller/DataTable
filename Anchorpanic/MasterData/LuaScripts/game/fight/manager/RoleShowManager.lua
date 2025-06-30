module('fight.RoleShowManager', Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self.m_showDataDict = nil
    self:_parseShowData()
    self.m_offsetDataDict = nil
    self:_parseOffsetData()
    self.m_showModeDataDict = nil
    self:_parseModeData()
end

-- 战斗表现数据配置表
function _parseShowData(self)
    self.m_showDataDict = {}
    local baseData = RefMgr:getData('fight_show_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.FightShowDataRo)
        ro:parseData(key, data)
        self.m_showDataDict[key] = ro
    end
end

-- 战斗表现数据配置表
function _parseOffsetData(self)
    self.m_offsetDataDict = {}
    local baseData = RefMgr:getData('role_showoffset')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.RoleShowoffsetRo)
        ro:parseData(key, data)
        self.m_offsetDataDict[key] = ro
    end
end

function _parseModeData(self)
    self.m_showModeDataDict = {}
    local baseData = RefMgr:getData('role_showmode')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.RoleShowmodeRo)
        ro:parseData(key, data)
        self.m_showModeDataDict[key] = ro
    end
end

function getShowData(self, modelID)
    modelID = tostring(modelID)
    if self.m_showDataDict[modelID] == nil then
        -- Debug:log_warn("FightManager", "战斗表现数据中 不存在 Id:" .. modelID)
        logError(string.format("战斗表现数据中 不存在 Id: [%s], 找俭城", modelID))
        return
    end
    return self.m_showDataDict[modelID]
end

function getOffsetData(self, modelID, modeType)
    local ro = self.m_offsetDataDict[modelID]
    if ro == nil then
        Debug:log_warn("FightManager", "模型的展示偏移数据 不存在 Id:" .. modelID..", 找俭城")
        return
    end
    if modeType == MainCityConst.ROLE_MODE_FORMATION then
        if table.empty(ro:getFormationOffset()) then return nil end
        return ro:getFormationOffset()
    elseif modeType == MainCityConst.ROLE_MODE_OVERVIEW then
        if table.empty(ro:getOverviewOffset()) then return nil end
        return ro:getOverviewOffset()
    elseif modeType == MainCityConst.ROLE_MODE_CULTIVATE then
        if table.empty(ro:getCultivateOffset()) then return nil end
        return ro:getCultivateOffset()
    elseif modeType == MainCityConst.ROLE_MODE_INTERACTION then
        if table.empty(ro:getInteractionOffset()) then return nil end
        return ro:getInteractionOffset()
    elseif modeType == MainCityConst.ROLE_MODE_CLIP then
        if table.empty(ro:getChipOffset()) then return nil end
        return ro:getChipOffset()
    elseif modeType == MainCityConst.ROLE_MODE_MANUAL_MONSTER or modeType == MainCityConst.ROLE_MODE_APOSTLE_MONSTER then
        if table.empty(ro:getMonsterOffset()) then return nil end
        return ro:getMonsterOffset()
    elseif modeType == MainCityConst.ROLE_MODE_UI or modeType == MainCityConst.APOSTLE_MONSTER_UI then
        if table.empty(ro:getNormalUiOffset()) then return nil end
        return ro:getNormalUiOffset()
    elseif modeType == MainCityConst.ROLE_MODE_MAIN then
        if table.empty(ro:getMainOffset()) then return nil end
        return ro:getMainOffset()
    elseif modeType == MainCityConst.ROLE_MODE_STORY then
        if table.empty(ro:getStoryOffset()) then return nil end
        return ro:getStoryOffset()
    end
end

function getOffsetData2(self, heroTid, modeType)
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroTid)
    if heroConfigVo then
        return self:getOffsetData(heroConfigVo.model, modeType)
    end
end

function getModeData(self, modeType)
    if self.m_showModeDataDict[modeType] == nil then
        Debug:log_warn("FightManager", "战员模式 不存在 Id:" .. modeType)
        return
    end
    return self.m_showModeDataDict[modeType]
end

-- 获取模型缩放比例
function getModelScale(self, modelId)
    local vo = self.m_offsetDataDict[modelId]
    if not vo then
        return 1
    end
    return vo:getModelScale()
end

-- 获取模型展示的缩放比例
function getModelShowScale(self, modelId)
    local vo = self.m_offsetDataDict[modelId]
    if not vo then
        return 1
    end
    return vo:getModelShowScale()
end

-- 获取战员总览模型展示摄像机Y轴偏移
function getCameraOffsetY(self, modelId)
    local vo = self.m_offsetDataDict[modelId]
    if not vo then
        return 0
    end
    return vo:getCameraOffsetY()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]