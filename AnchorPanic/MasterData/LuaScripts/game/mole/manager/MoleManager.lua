module("mole.MoleManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    self.mDupDic = {}
    self.mStartRewardList = {}
end

function parseMolePanelData(self, msg)
    for i = 1, #msg.dup_list do
        self.mDupDic[msg.dup_list[i].dup_id] = msg.dup_list[i].star
    end
    self.mStartRewardList = msg.star_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_MOLE_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function parseMolePassDupData(self, msg)
    self.mDupDic[msg.dup_id] = msg.star
    GameDispatcher:dispatchEvent(EventName.UPDATE_MOLE_PASS_DUP)
    GameDispatcher:dispatchEvent(EventName.UPDATE_MOLE_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function parseStarData(self)
    self.mStarData = {}
    local baseData = RefMgr:getData("mole_star_data")
    for key, value in pairs(baseData) do
        local moleStarVo = LuaPoolMgr:poolGet(mole.MoleStarDataVo)
        moleStarVo:parseData(key, value)
        self.mStarData[key] = moleStarVo
    end
end

function getStarDataById(self,id)
    if self.mStarData == nil then
        self:parseStarData()
    end
    return self.mStarData[id]
end


function parseMoleDupData(self)
    self.mMoleDupData = {}
    local baseData = RefMgr:getData("mole_area_data")
    for key, value in pairs(baseData) do
        local moleDupVo = LuaPoolMgr:poolGet(mole.MoleDupDataVo)
        moleDupVo:parseCogfigData(key, value)
        self.mMoleDupData[key] = moleDupVo
    end
end

function getAreaConfigDic(self)
    if self.mMoleDupData == nil then
        self:parseMoleDupData()
    end
    return self.mMoleDupData
end

function getAreaConfig(self,area_id)
    if self.mMoleDupData == nil then
        self:parseMoleDupData()
    end
    return self.mMoleDupData[area_id]
    
end

function getAreaPassState(self,area_id)
    local areaConfig = self:getAreaConfig(area_id)
    if areaConfig then
        for _, dupId in pairs(areaConfig.stage_list) do
            if not self:getDupPassState(dupId) then
                return false
            end
        end
    end
    return true
end

function getDupPassState(self,dupId)
    return self:getDupPassStar(dupId) ~= 0
end

function getDupPassStar(self,dupId)
    if not self.mDupDic or self.mDupDic[dupId] == nil then
        return 0
    end
    return self.mDupDic[dupId] or 0
end

function getNextDupId(self,dupId)
    local isBreak = false
    local allAreaCofig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(allAreaCofig) do
        if isBreak then
            return areaConfigVo.stage_list[1]
        end

        local length = #areaConfigVo.stage_list
        for i = 1, length do
            if areaConfigVo.stage_list[i] == dupId then
                local next_index = i + 1
                if next_index <= length then
                    return areaConfigVo.stage_list[next_index]
                else
                    isBreak = true
                    break
                end
            end
        end
    end
end

function getDupConfig(self,dup_id)
    if not self.mMoleData then
        self:parseMoleData()
    end
    return self.mMoleData[dup_id]
end

function parseMoleData(self)
    self.mMoleData = {}
    local baseData = RefMgr:getData("mole_data")
    for key, value in pairs(baseData) do
        local moleVo = LuaPoolMgr:poolGet(mole.MoleGameDataVo)
        moleVo:parseData(key, value)
        self.mMoleData[key] = moleVo
    end
end

function getMoleDataById(self, id)
    if self.mMoleData == nil then
        self:parseMoleData()
    end
    return self.mMoleData[id]
end

function parseMoleItemData(self)
    self.mMoleItemData = {}
    local baseData = RefMgr:getData("mole_item_data")
    for key, value in pairs(baseData) do
        local moleItemVo = LuaPoolMgr:poolGet(mole.MoleItemDataVo)
        moleItemVo:parseData(key, value)
        self.mMoleItemData[key] = moleItemVo
    end
end

function getMoleItemData(self, moleId)
    if self.mMoleItemData == nil then
        self:parseMoleItemData()
    end
    return self.mMoleItemData[moleId]
end


function getAreaShowRed(self, areaConfigVo)
    local timeOpen = areaConfigVo:isOpen()
    if not timeOpen then
        return false
    end

    for i = 1, #areaConfigVo.stage_list do
        local dup_id = areaConfigVo.stage_list[i]
        if self:getDupShowRed(dup_id) then
            return true
        end
    end

    return false
end

function getDupShowRed(self, dup_id)
    local dupConfig = self:getDupConfig(dup_id)
    if dupConfig then
        local lastDup_id = dupConfig.pre_id

        local pass = self:getDupPassState(lastDup_id) or lastDup_id == 0
        local curPass = not self:getDupPassState(dup_id)
        local isOpen = dupConfig:isOpen()
        local isNewOpen = not StorageUtil:getBool1(gstor.MOLE_DUPNEWOPENSTR.. dup_id)

        if pass and curPass and isOpen and isNewOpen then
            return true
        end
    end

    return false
end

function getPassAllStarCount(self)
    local starCount = 0
    local areaConfigDic = self:getAreaConfigDic()
    for area_id, areaConfig in pairs(areaConfigDic) do
        for _, dupId in pairs(areaConfig.stage_list) do
            starCount = starCount + self:getDupPassStar(dupId)
        end
    end

    return starCount
end

function getStarAwardRedState(self)
    local starCount = self:getPassAllStarCount()
    local rewardList = self:getStarRewardConfig()
    for i = 1, #rewardList do
        local isGet = self:getAwardState(rewardList[i].id)
        if starCount >= rewardList[i].star_num and isGet == false then
            return true
        end
    end

    return false
end

function getAwardState(self,award_id)
    if not self.mStartRewardList then
        return false
    end
    return table.indexof01(self.mStartRewardList,award_id)>0
end

function getStarRewardConfig(self)
    if not self.m_StarRewardConfigVoDic then
        self:parseStarRewardConfigData()
    end
    return self.m_StarRewardConfigVoDic
end

function parseStarRewardConfigData(self)
    self.m_StarRewardConfigVoDic = {}
    local baseData = RefMgr:getData("mole_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = mole.MoleStarRwardConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_StarRewardConfigVoDic[key] = baseVo
    end
end

function getPassAllStarCount(self)
    local starCount = 0
    local areaConfigDic = self:getAreaConfigDic()
    for area_id, areaConfig in pairs(areaConfigDic) do
        for _, dupId in pairs(areaConfig.stage_list) do
            starCount = starCount + self:getDupPassStar(dupId)
        end
    end

    return starCount
end

function getIsShowRed(self)
    local areaConfig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(areaConfig) do
        if self:getAreaShowRed(areaConfigVo) then
            return true
        end
    end

    if self:getStarAwardRedState() then
        return true
    end

    return false
end

return _M
