-- @FileName:   LinklinkManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.linklink.manager.LinklinkManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)

end

function parseDupConfigData(self)
    self.m_DupConfigVoDic = {}
    local baseData = RefMgr:getData("linklink_dup_data")
    for key, data in pairs(baseData) do
        local baseVo = linklink.LinklinkDupConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_DupConfigVoDic[key] = baseVo
    end
end

function parseAreaConfigData(self)
    self.m_AreaConfigVoDic = {}
    local baseData = RefMgr:getData("linklink_data")
    for key, data in pairs(baseData) do
        local baseVo = linklink.LinklinkAreaConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_AreaConfigVoDic[key] = baseVo
    end
end

function parseStarRewardConfigData(self)
    self.m_StarRewardConfigVoDic = {}
    local baseData = RefMgr:getData("linklink_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = linklink.LinklinkStarRwardConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_StarRewardConfigVoDic[key] = baseVo
    end
end

--------------------------------------------配置数据

function getStarRewardConfig(self)
    if not self.m_StarRewardConfigVoDic then
        self:parseStarRewardConfigData()
    end
    return self.m_StarRewardConfigVoDic
end

--获取副本配置
function getDupConfig(self, dup_id)
    if not self.m_DupConfigVoDic then
        self:parseDupConfigData()
    end
    return self.m_DupConfigVoDic[dup_id]
end

function getAreaConfig(self, area_id)
    if not self.m_AreaConfigVoDic then
        self:parseAreaConfigData()
    end
    return self.m_AreaConfigVoDic[area_id]
end

function getAreaConfigDic(self)
    if not self.m_AreaConfigVoDic then
        self:parseAreaConfigData()
    end
    return self.m_AreaConfigVoDic
end

--获取下一个关卡
function getNextDupId(self, dupId)
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

------------------------------------------服务器数据

function setPassDupId(self, passDupIdList)
    self.m_PassDupDic = {}

    for _, dupData in pairs(passDupIdList) do
        self.m_PassDupDic[dupData.dup_id] = dupData.star
    end
end

--已经领取了的成就奖励
function setAwardList(self, award_list)
    self.m_GetAwardDic = {}

    for _, award_id in pairs(award_list) do
        self.m_GetAwardDic[award_id] = 1
    end
end

function getAwardState(self, award_id)
    if not self.m_GetAwardDic then
        return false
    end
    return self.m_GetAwardDic[award_id] == 1
end

function getAreaPassState(self, area_id)
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

function getDupPassState(self, dupId)
    return self:getDupPassStar(dupId) ~= 0
end

function getDupPassStar(self, dupId)
    if not self.m_PassDupDic then
        return 0
    end
    return self.m_PassDupDic[dupId] or 0
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

function setIsPause(self, value)
    self.m_IsPause = value
end

function getIsPause(self)
    return self.m_IsPause
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
        if self:getDupPassState(lastDup_id) and not self:getDupPassState(dup_id) and dupConfig:isOpen() and not StorageUtil:getBool1(gstor.LINKLINK_DUPNEWOPENSTR .. dup_id) then
            return true
        end
    end

    return false
end

return _M
