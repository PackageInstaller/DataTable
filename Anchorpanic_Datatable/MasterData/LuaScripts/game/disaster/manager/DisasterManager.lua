module("disaster.DisasterManager", Class.impl(Manager))

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
    self.mViewList = {}
end

-- 析构函数
function dtor(self)
end

function updateDisasterRankInfo(self, msg)
    self.mRank = msg.my_rank
    self.mRankValue = msg.my_rank_val
    self.mRankList = msg.rank_list

    GameDispatcher:dispatchEvent(EventName.OPEN_DISASTER_RANK_PANEL)
end

function getDisasterRank(self)
    return self.mRank
end

function getDisasterRankValue(self)
    return self.mRankValue
end

function getDisasterList(self)
    return self.mRankList
end

function getFormationCount(self)
    return self.curPassCount, self.maxListCount
end

function onDisasterPanelInfo(self, msg)
    --self.panelType = msg.panel -- 1主界面 2-阵型界面
    self.disasterMainPanelInfo = msg.disaster_main_panel -- 主界面信息
    self.disasterFormationPanelInfo = msg.disaster_formation_panel -- 阵型界面信息

    self.curDif = 1 -- 当前难度

    for i = 1, #self.disasterMainPanelInfo.disaster_list do
        if self.disasterMainPanelInfo.disaster_list[i].is_pass == 1 then
            -- self.curPassCount = self.curPassCount + 1
            if self.curDif < self.disasterMainPanelInfo.disaster_list[i].id + 1 then
                self.curDif = self.disasterMainPanelInfo.disaster_list[i].id + 1
            end
        end
    end
    self.allDamage = self.disasterMainPanelInfo.all_damage
    self.infDamage = self.disasterMainPanelInfo.infinite_damage
    self.remCount = self.disasterMainPanelInfo.today_times
    self.allCount = sysParam.SysParamManager:getValue(SysParamType.DISASTER_ALLTIMER)

    self.hadRewardList = self.disasterMainPanelInfo.had_reward_list
    self.disasterList = self.disasterMainPanelInfo.disaster_list
    -- self.bossList = self.disasterMainPanelInfo.boss_list
    ---------------------------------阵型---------------------------------------
    self.curChallengingDif = self.disasterFormationPanelInfo.challenging_difficulty
    self.heroList = self.disasterFormationPanelInfo.hero_list
    self.formationList = self.disasterFormationPanelInfo.formation_list
    self.curDamage = self.disasterFormationPanelInfo.cur_damage
    self.curPassCount = 0
    for i = 1, #self.formationList do
        if self.formationList[i].is_pass == 1 then
            self.curPassCount = self.curPassCount + 1
        end
    end
    self.maxListCount = #self.formationList

    self.warId = self.disasterMainPanelInfo.war_id

    self:updateRed()
end

function getDisasterWarTxt(self)
    local text = _TT(104025)
    if self.warId == 2 then
        text = _TT(104025)
    elseif self.warId == 3 then
        text = _TT(104026)
    elseif self.warId == 4 then
        text = _TT(104027)
    end
    return text
end

function getDisasterFormationInfo(self)
    return self.disasterFormationPanelInfo
end

function getAwardRed(self)
    local red = false
    local data = self:getDisasterAwardData()
    for i = 1, #data do
        if data[i].state == 0 then
            red = true
        end
    end
    return red
end

function updateRed(self)
    local red = self:getAwardRed()
    red = red or self:getCanFight()
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_DISASTER, red)

    GameDispatcher:dispatchEvent(EventName.UPDATE_DISASTER_MAIN_PANEL)
end

function getCanFight(self)
    local red = self.remCount > 0 and self.curDif < self:getDisasterDupMaxDif()
    return red
end

function getFormationCurDamage(self)
    return self.curDamage
end

-- function getDisasterPanelType(self)
--     return self.panelType
-- end

function getRewardIsGet(self, id)
    return table.indexof01(self.hadRewardList, id) > 0
end

function updateReward(self, id)
    table.insert(self.hadRewardList, id)
    self:updateRed()
    GameDispatcher:dispatchEvent(EventName.UPDATE_DISASTER_FIGHT_AWARD_PANEL)
end

function getBossInfo(self, dif)
    for i = 1, #self.disasterList do
        if self.disasterList[i].id == dif then
            return self.disasterList[i].boss_info.now_hp, self.disasterList[i].boss_info.max_hp
        end
    end
end

function setCurChallengingDif(self, dif)
    self.curChallengingDif = dif
end

function getFormationIsFight(self, index)
    local startIndex = 19000
    for i = 1, #self.formationList do
        if startIndex + index == self.formationList[i].id then
            return self.formationList[i].is_pass == 1
        end
    end
    return false
end

function getFormationStartIndex(self)
    -- return 1

    local startIndex = 19000
    local numList = {}
    for i = 1, #self.formationList do
        if self.formationList[i].is_pass == 0 then
            table.insert(numList, self.formationList[i].id - startIndex)
        end
    end
    table.sort(numList, function(n1, n2)
        return n1 < n2
    end)
    return numList[1] ~= nil and numList[1] or 1
end

function getCurChallengingDif(self)
    return self.curChallengingDif
end

function getMyRank(self)
    return self.mRank
end

function getDisasterIsOpen(self)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Disaster)
    return activityVo:getIsCanOpen() and activityVo:getTimeRemaining() > 0
end

function getDisasterOverTime(self)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Disaster)
    return activityVo:getOverTimeDt()
end

function getRemCount(self)
    return self.remCount, self.allCount
end

function getAllFight(self)
    return self.allDamage
end

function getInfDamage(self)
    return self.infDamage
end

function getCurFight(self)
    return self.curFight
end

function getCurDif(self)
    return self.curDif
end

function getHpInfo(self)
    return self.remHp, self.allHp
end

function parseDisasterDupData(self)
    self.mDisasterDupData = {}
    self.mMaxDupDif = 0
    self.mMaxDupId = 0
    local baseData = RefMgr:getData("disaster_dup_data")
    for dupId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(disaster.DisasterDupVo)
        vo:parseData(dupId, data)
        self.mDisasterDupData[dupId] = vo
        if self.mMaxDupDif < vo.difficulty then
            self.mMaxDupDif = vo.difficulty
        end
        if self.mMaxDupId < dupId then
            self.mMaxDupId = dupId
        end
    end
end

function getMaxDupId(self)
    if self.mMaxDupId == nil then
        self:parseDisasterDupData()
    end
    return self.mMaxDupId
end

function getDisasterDupData(self)
    if self.mDisasterDupData == nil then
        self:parseDisasterDupData()
    end
    return self.mDisasterDupData
end

function getDisasterDupMaxDif(self)
    if self.mDisasterDupData == nil then
        self:parseDisasterDupData()
    end
    return self.mMaxDupDif
end

function getDisasterDupDataByDupId(self, dupId)
    if self.mDisasterDupData == nil then
        self:parseDisasterDupData()
    end
    return self.mDisasterDupData[dupId]
end

function getDisasterDupDataByDif(self, dif)
    if self.mDisasterDupData == nil then
        self:parseDisasterDupData()
    end
    for k, vo in pairs(self.mDisasterDupData) do
        if vo.difficulty == dif then
            return vo
        end
    end
    return nil
end

function parseDisasterAwardData(self)
    self.mDisasterAwardData = {}
    local baseData = RefMgr:getData("disaster_damage_award_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(disaster.DisasterAwardVo)
        vo:parseData(id, data)
        table.insert(self.mDisasterAwardData, vo)
    end
    -- table.sort(self.mDisasterAwardData, function(vo1, vo2)
    --     return vo1.id < vo2.id
    -- end)
    -- self.mDisasterAwardData.sort
end

function getDisasterAwardData(self)
    if self.mDisasterAwardData == nil then
        self:parseDisasterAwardData()
    end
    for i = 1, #self.mDisasterAwardData do
        local isGet = self:getRewardIsGet(self.mDisasterAwardData[i].id)
        local isOK = self.mDisasterAwardData[i].targetDamage < tonumber(self:getAllFight())

        if isOK == true and isGet == false then
            self.mDisasterAwardData[i].state = 0
        elseif isOK == false and isGet == false then
            self.mDisasterAwardData[i].state = 1
        else
            self.mDisasterAwardData[i].state = 2
        end
    end

    table.sort(self.mDisasterAwardData, function(vo1, vo2)
        if vo1.state == vo2.state then
            return vo1.id < vo2.id
        else
            return vo1.state < vo2.state
        end
    end)
    return self.mDisasterAwardData
end

function parseDisasterRankAwardData(self)
    self.mDisasterRankAwardData = {}
    self.mLowAward = nil
    local baseData = RefMgr:getData("disaster_low_rank_award_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(disaster.DisasterRankAwardVo)
        vo:parseData(id, data)
        table.insert(self.mDisasterRankAwardData, vo)
        if self.mLowAward ==nil or  self.mLowAward.leftRank < vo.leftRank then
            self.mLowAward = vo
        end
    end
    table.sort(self.mDisasterRankAwardData, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

function parseDisasterRankMidAwardData(self)
    self.mDisasterRankAwardDataMid = {}
    self.mLowAwardMid = nil 
    local baseData = RefMgr:getData("disaster_mid_rank_award_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(disaster.DisasterRankAwardVo)
        vo:parseData(id, data)
        table.insert(self.mDisasterRankAwardDataMid, vo)
        if self.mLowAwardMid ==nil or  self.mLowAwardMid.leftRank < vo.leftRank then
            self.mLowAwardMid = vo
        end
    end
    table.sort(self.mDisasterRankAwardDataMid, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

function parseDisasterRankHighAwardData(self)
    self.mDisasterRankAwardDataHigh = {}
    self.mLowAwardHigh = nil 
    local baseData = RefMgr:getData("disaster_high_rank_award_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(disaster.DisasterRankAwardVo)
        vo:parseData(id, data)
        table.insert(self.mDisasterRankAwardDataHigh, vo)
        if self.mLowAwardHigh ==nil or  self.mLowAwardHigh.leftRank < vo.leftRank then
            self.mLowAwardHigh = vo
        end
    end
    table.sort(self.mDisasterRankAwardDataHigh, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end



function getLowRankAwardData(self,warId)
    if  self.warId == 2 then
        if self.mLowAward == nil then
            self:parseDisasterRankAwardData()
        end
        return self.mLowAward
    elseif  self.warId == 3 then
        if self.mLowAwardMid == nil then
            self:parseDisasterRankMidAwardData()
        end
        return self.mLowAwardMid
    elseif  self.warId == 4 then
        if self.mLowAwardHigh == nil then
            self:parseDisasterRankHighAwardData()
        end
        return self.mLowAwardHigh
    end
end

function getDisasterRankAwardData(self,warId)
    if  self.warId == 2 then
        if self.mDisasterRankAwardData == nil then
            self:parseDisasterRankAwardData()
        end
        return self.mDisasterRankAwardData
    elseif  self.warId == 3 then
        if self.mDisasterRankAwardDataMid == nil then
            self:parseDisasterRankMidAwardData()
        end
        return self.mDisasterRankAwardDataMid

    elseif  self.warId == 4 then
        if self.mDisasterRankAwardDataHigh == nil then
            self:parseDisasterRankHighAwardData()
        end
        return self.mDisasterRankAwardDataHigh

    end 
end

return _M
