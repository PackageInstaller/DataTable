-- @FileName:   RankingManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-28 15:28:41
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ranking.manager.RankingManager', Class.impl(Manager))

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
    self.m_passStageDic = {}
    self.m_rewardInfoDic = {}
    self.m_IsOpenSettlement = false
end
-------------------------------------------------数据-------------------------
function setPassStageStar(self, stage_info)
    self.m_passStageDic[stage_info.dup_id] = stage_info.star
end

function getPassStageStar(self, stage_id)
    return self.m_passStageDic[stage_id] or 0
end

function isPassDup(self, dupId)
    if dupId ~= 0 then
        if not self.m_passStageDic[dupId] then
            return false
        end
    end

    return true
end

function getAreaPassState(self, area_id)
    local areaConfig = self:getAreaConfig(area_id)
    if areaConfig then
        for _, dupId in pairs(areaConfig.stage_list) do
            if not self:isPassDup(dupId) then
                return false
            end
        end
    end

    return true
end

function getPassAllStarCount(self)
    local star_count = 0
    for stage_id, star in pairs(self.m_passStageDic) do
        star_count = star_count + star
    end

    return star_count
end

function setRewardInfo(self, reward_id)
    self.m_rewardInfoDic[reward_id] = 1
end

function getRewardGetState(self, reward_id)
    return self.m_rewardInfoDic[reward_id] == 1
end

--前端本地临时数据
function setSelectDup_id(self, dup_id)
    self.m_selectDupId = dup_id
end

function getSelectDup_id(self)
    return self.m_selectDupId
end

-------------------------------------------------配置-------------------------
function parseAreaConfigData(self)
    self.mAreaConfigVoDic = {}
    local baseData = RefMgr:getData("ranking_game_area_data")
    for key, data in pairs(baseData) do
        local baseVo = ranking.RankingAreaConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.mAreaConfigVoDic[key] = baseVo
    end
end

--获取地图区域配置
function getAreaConfig(self, area_id)
    if not self.mAreaConfigVoDic then
        self:parseAreaConfigData()
    end
    return self.mAreaConfigVoDic[area_id]
end

function getAreaConfigDic(self)
    if not self.mAreaConfigVoDic then
        self:parseAreaConfigData()
    end
    return self.mAreaConfigVoDic
end

function parseDupConfigVo(self)
    if not self.m_dupConfigVoDic then
        self.m_dupConfigVoDic = {}
        local baseData = RefMgr:getData("ranking_game_data")
        for key, data in pairs(baseData) do
            local baseVo = ranking.RankingDupConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_dupConfigVoDic[key] = baseVo
        end
    end
end

function getDupConfigVo(self, dupId)
    if not self.m_dupConfigVoDic then
        self:parseDupConfigVo()
    end

    return self.m_dupConfigVoDic[dupId]
end

--获取下一个关卡
function getNextDupConfig(self, dupId)
    local isBreak = false
    local dupConfigList = self:getDupConfigVoList()
    for index, dupConfigVo in pairs(dupConfigList) do
        if dupConfigVo.id == dupId then
            if dupConfigList[index + 1] then
                return dupConfigList[index + 1]
            end
        end
    end
end

function getDupConfigVoList(self)
    if not self.m_dupConfigVoDic then
        self:parseDupConfigVo()
    end

    local dupList = {}
    for dup_id, dupConfig in pairs(self.m_dupConfigVoDic) do
        table.insert(dupList, dupConfig)
    end

    table.sort(dupList, function (a, b)
        return a.id < b.id
    end)

    return dupList
end

function getDupConfigVoDic(self)
    if not self.m_dupConfigVoDic then
        self:parseDupConfigVo()
    end

    return self.m_dupConfigVoDic
end

function parseStarConfigVo(self)
    if not self.m_starConfigVoDic then
        self.m_starConfigVoDic = {}
        local baseData = RefMgr:getData("ranking_game_star_data")
        for key, data in pairs(baseData) do
            local baseVo = ranking.RankingStarConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_starConfigVoDic[key] = baseVo
        end
    end

    return self.m_starConfigVoDic[map_id]
end

function getStarConfigVo(self, star_id)
    if not self.m_starConfigVoDic then
        self:parseStarConfigVo()
    end

    return self.m_starConfigVoDic[star_id]
end

function parseThingConfigVo(self)
    if not self.m_thingConfigVoDic then
        self.m_thingConfigVoDic = {}
        local baseData = RefMgr:getData("ranking_game_thing_data")
        for key, data in pairs(baseData) do
            local baseVo = ranking.RankingThingConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_thingConfigVoDic[key] = baseVo
        end
    end

    return self.m_thingConfigVoDic[map_id]
end

function getThingConfigVo(self, thing_id)
    if not self.m_thingConfigVoDic then
        self:parseThingConfigVo()
    end

    return self.m_thingConfigVoDic[thing_id]
end

function parseRewardkConfigVo(self)
    if not self.m_rewardConfigVoDic then
        self.m_rewardConfigVoDic = {}
        local baseData = RefMgr:getData("ranking_game_reward_data")
        for key, data in pairs(baseData) do
            local baseVo = ranking.RankingRewardConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_rewardConfigVoDic[key] = baseVo
        end
    end

    return self.m_rewardConfigVoDic[map_id]
end

function getRewardConfigVoDic(self)
    if not self.m_rewardConfigVoDic then
        self:parseRewardkConfigVo()
    end

    return self.m_rewardConfigVoDic
end

function setOpenSettlementPanel(self, value)
    self.m_IsOpenSettlement = value
end

function getOpenSettlementPanel(self)
    return self.m_IsOpenSettlement
end

---------------------------
function getIsShowRed(self)
    if self:getStarRewardRedState() then
        return true
    end

    local areaConfig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(areaConfig) do
        if self:getAreaShowRed(areaConfigVo) then
            return true
        end
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
        if self:getDupShowRed(self:getDupConfigVo(dup_id)) then
            return true
        end
    end

    return false
end

function getStarRewardRedState(self)
    local starCount = self:getPassAllStarCount()
    local rewardList = self:getRewardConfigVoDic()
    for k, v in pairs(rewardList) do
        local isGet = self:getRewardGetState(v.id)
        if starCount >= v.star_num and isGet == false then
            return true
        end
    end

    return false
end

function getDupShowRed(self, dupConfigVo)
    local lastDup_id = dupConfigVo.pre_id
    if self:isPassDup(lastDup_id) and not self:isPassDup(dupConfigVo.id) and dupConfigVo:isOpen() and not StorageUtil:getBool1(gstor.RANKING_DUPNEWOPENSTR .. dupConfigVo.id) then
        return true
    end

    return false
end

return _M
