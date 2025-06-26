-- @FileName:   ShootBrickManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-28 15:28:41
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.ShootBrickManager', Class.impl(Manager))

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
function parseDupConfigVo(self)
    if not self.m_dupConfigVoDic then
        self.m_dupConfigVoDic = {}
        local baseData = RefMgr:getData("breakout_dup_data")
        for key, data in pairs(baseData) do
            local baseVo = shootBrick.ShootBrickDupConfigVo.new()
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
        local baseData = RefMgr:getData("breakout_star_data")
        for key, data in pairs(baseData) do
            local baseVo = shootBrick.ShootBrickStarConfigVo.new()
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

function parsePropsConfigVo(self)
    if not self.m_propConfigVoDic then
        self.m_propConfigVoDic = {}
        local baseData = RefMgr:getData("breakout_item_data")
        for key, data in pairs(baseData) do
            local baseVo = shootBrick.ShootBrickPropConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_propConfigVoDic[key] = baseVo
        end
    end

    return self.m_propConfigVoDic[map_id]
end

function getPropConfigVo(self, prop_id)
    if not self.m_propConfigVoDic then
        self:parsePropsConfigVo()
    end

    return self.m_propConfigVoDic[prop_id]
end

function parseBallConfigVo(self)
    if not self.m_ballConfigVoDic then
        self.m_ballConfigVoDic = {}
        local baseData = RefMgr:getData("breakout_bullet_data")
        for key, data in pairs(baseData) do
            local baseVo = shootBrick.ShootBrickBallConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_ballConfigVoDic[key] = baseVo
        end
    end

    return self.m_ballConfigVoDic[map_id]
end

function getBallConfigVo(self, ball_id)
    if not self.m_ballConfigVoDic then
        self:parseBallConfigVo()
    end

    return self.m_ballConfigVoDic[ball_id]
end

function parseBrickConfigVo(self)
    if not self.m_brickConfigVoDic then
        self.m_brickConfigVoDic = {}
        local baseData = RefMgr:getData("breakout_brick_data")
        for key, data in pairs(baseData) do
            local baseVo = shootBrick.ShootBrickBrickConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_brickConfigVoDic[key] = baseVo
        end
    end

    return self.m_brickConfigVoDic[map_id]
end

function getBrickConfigVo(self, brick_id)
    if not self.m_brickConfigVoDic then
        self:parseBrickConfigVo()
    end

    return self.m_brickConfigVoDic[brick_id]
end

function parseRewardkConfigVo(self)
    if not self.m_rewardConfigVoDic then
        self.m_rewardConfigVoDic = {}
        local baseData = RefMgr:getData("breakout_reward_data")
        for key, data in pairs(baseData) do
            local baseVo = shootBrick.ShootBrickRewardConfigVo.new()
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

function getTeachingState(self)
    local lasetClickRedDt = StorageUtil:getNumber1(gstor.SHOOTBRICK_TEACHINGSTATE)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.ShootBrick)
    if activityVo and lasetClickRedDt < activityVo.startTime then
        return true
    end

    return false
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

    if self:getAllDupShowRed() then
        return true
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

function getAllDupShowRed(self)
    local dupConfigDic = self:getDupConfigVoDic()
    for dup_id, dupConfigVo in pairs(dupConfigDic) do
        if self:getDupShowRed(dupConfigVo) then
            return true
        end
    end
    return false
end

function getDupShowRed(self, dupConfigVo)
    local lastDup_id = dupConfigVo.pre_id
    if self:isPassDup(lastDup_id) and not self:isPassDup(dupConfigVo.id) and dupConfigVo:isOpen() and not StorageUtil:getBool1(gstor.SHOOTBRICK_DUPNEWOPENSTR .. dupConfigVo.id) then
        return true
    end

    return false
end

return _M
