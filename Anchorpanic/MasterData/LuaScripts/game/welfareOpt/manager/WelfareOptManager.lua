-- module("welfareOpt.WelfareOptManager", Class.impl(Manager))
module("welfareOpt.WelfareOptManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.battleSupplyDic = nil
    self.battleSupplyProDic = nil
    self.goldSwishingServerData = nil
    self.fightSupplyProDic = nil
    self.goldWishingDic = nil
    self.sevenLoadingDic = nil

    self.loadingDay = nil
    self.rewardList = nil
    self.awardList = {}

    -- 签到 copy
    self.m_monthCardAwardList = nil
    self.m_awardList = nil
    self.mIsSignin = nil

    self.mNoviceDic = nil
    self.mNoviceAwardDic = nil

    self.mTaskList = {}
    self.mTrainerDic = nil
    self.mTrainerRewardList = nil
    self.mTrainerStageReward = false

    -- 无操作正常检查红点记录是时间
    self.mStrengthRecordTime = nil

    self.m_5TimeStamp = 5 * 3600
    self.supplySateDic = {}
    self.isBiliOpen = 0

    self.taptapTaskList = {}
end

function canGetGain(self)
    if #self.taptapTaskList <= 0 then
        return false
    else
        return self:getTapTapGedCount() == #self.taptapTaskList and self.isGainGrandPrize == 0
    end
end

function canGetSingle(self)
    for k, v in pairs(self.taptapTaskList) do
        if v.state == 0 then
            return true
        end
    end
    return false
end

function parseTapTapTaskServerInfo(self, msg)
    self.isBiliOpen = msg.is_b_open --B站包是否开启功能
    self.taptapTaskList = msg.task_list
    self.isGainGrandPrize = msg.is_gain_grand_prize
end

function getTapTapServerInfo(self, id)
    for k, v in pairs(self.taptapTaskList) do
        if v.id == id then
            return v
        end
    end
    return nil
end

function getTapTapGedCount(self)
    local count = 0
    for k, v in pairs(self.taptapTaskList) do
        if v.state == 2 then
            count = count + 1
        end
    end
    return count
end

function getIsGainGrandPrize(self)
    return self.isGainGrandPrize
end

function updateTapTaskServerInfo(self, msg)
    for k, v in pairs(msg.task_id_list) do
        self.taptapTaskList[v].state = 2
    end
    self:updateTapTapFlag()
end

function updateTapTaskServerGrandInfo(self, msg)
    self.isGainGrandPrize = 1
    self:updateTapTapFlag()
end

function updateTapTapTaskInfo(self, msg)
    self.taptapTaskList[msg.task_info.id] = msg.task_info
    self:updateTapTapFlag()
end

function updateTapTapFlag(self)
    if self:getTapActivityIsOpen() then
        GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {tabType = welfareOpt.WelfareOptConst.WELFAREOPT_TAPTAP})
        GameDispatcher:dispatchEvent(EventName.UPDATE_TAPTAP_TASK_PANEL)
    end
end

-- 解析活动消息
function parseFestivalSignInfoMsg(self, msg)
    self.loginDay = msg.login_day
    self.signDayRewardList = msg.sign_day_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {tabType = welfareOpt.WelfareOptConst.WELFAREOPT_HOLIDAY})
    GameDispatcher:dispatchEvent(EventName.UPDATE_FESTIVAL_REWARD)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
end

-- 获取登录天数
function getSignDay(self)
    return self.loginDay
end

function getSignRewardList(self)
    return self.signDayRewardList == nil
end

-- 获取登录奖励列表
function getSignRewardGeted(self, i)
    return table.indexof01(self.signDayRewardList, i) > 0
end

function getSevenOpen(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFATEOPT_SEVENDAY, false) and
        (self.rewardList and self.loadingDay) then
        local data = self:getSevenLoadingServerData()
        if (data and #data.list < 7) then
            return true
        end
    end
    return false
end

function getSevenIsReciving(self)
    if self:getSevenLoadingServerData() then
        local isRecving = table.indexof01(self:getSevenLoadingServerData().list, 7) > 0
        return isRecving
    else
        return true
    end
    return false
end

function getRedData(self, index)
    local isRed = false

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFATEOPT_SEVENDAY, false) and index ==
        welfareOpt.WelfareOptConst.WELFAREOPT_SEVENLOADING and (self.rewardList and self.loadingDay) then
        local reciveDay = 0
        for i = 1, self.loadingDay do
            if table.indexof01(self.rewardList, i) > 0 then
                reciveDay = reciveDay + 1
            end
        end
        if reciveDay == self.loadingDay then
            isRed = false
        else
            isRed = true
        end
    elseif funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFATEOPT_STRENGTH, false) and index ==
        welfareOpt.WelfareOptConst.WELFAREOPT_SIGN then
        self:updateStrengthSupplyBubble()
        if self.mIsSignin == 1 then
            isRed = false
        else
            isRed = true
        end
    elseif funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_GOLDWSHING, false) and index ==
        welfareOpt.WelfareOptConst.WELFAREOPT_GOLDWISHING then
        if self.goldSwishingServerData == nil then
            isRed = false
            return isRed
        end

        local vo = welfareOpt.WelfareOptManager:getGoldWishingServerData()
        local tadayMax = sysParam.SysParamManager:getValue(48)
        local today = vo.hadWishTimes
        if today < tadayMax then
            local goldData = welfareOpt.WelfareOptManager:getGoldWishingData(today + 1)
            local myNum = MoneyUtil.getMoneyCountByTid(1)
            if self.goldSwishingServerData.state == 2 or
                (self.goldSwishingServerData.state == 0 and myNum > goldData.goldCost) then
                isRed = true
                return isRed
            end
        else
            isRed = false
            return isRed
        end
    elseif funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_FIGHT, false) and index ==
        welfareOpt.WelfareOptConst.WELFAREOPT_FIGHTSUPPLY then
        for i = 1, 2 do
            local data = self:getDataFightSupplyData(i)

            local oneNum = bag.BagManager:getPropsCountByTid(data.costOneId)
            local needOneNum = data.costOneNum
            if (oneNum >= needOneNum) then
                isRed = true
                return isRed
            end

        end

        isRed = false
    elseif funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_NOVICETRAIN, false) and index ==
        welfareOpt.WelfareOptConst.WELFAREOPT_NOVICEGOAL then
        if (self:getTrainerData() and self:getTrainerData().reciveAll ~= 1) then
            local doneAll = true
            local hasDone = false
            for i = 1, #self:getTrainerData().taskList do
                if (self.mTaskList[i].state ~= 2) then
                    doneAll = false
                    if (self.mTaskList[i].state == 0) then
                        hasDone = true
                    end
                end
            end
            isRed = doneAll or hasDone
        end
    elseif funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_SEVENDAY_TARGET, false) and index ==
        welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET then
        if (not activityTarget.ActivityTargetManager.isFinish) then
            for _, taskVo in pairs(activityTarget.ActivityTargetManager.mServerTaskDic) do
                if (taskVo.state == 0) then
                    isRed = true
                    break
                end
            end
        end
    elseif funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_OPEN_BETA, false) and index ==
        welfareOpt.WelfareOptConst.WELFAREOPT_OPEN_BETA then
        isRed = welfareOpt.WelfareOptOpenBetaManager:checkBubble()
    elseif self:getTapActivityIsOpen() and index == welfareOpt.WelfareOptConst.WELFAREOPT_TAPTAP then
        isRed = self:canGetGain() or self:canGetSingle()
    elseif funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FESTIVAL, false) and mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Festival):getTimeRemaining() > 0 and index ==
        welfareOpt.WelfareOptConst.WELFAREOPT_HOLIDAY then
        if self:getSignRewardList() == false then
            isRed = self.loginDay > #self.signDayRewardList
        end
    end

    return isRed
end

function getTabRed(self, type)
    local flag = self:getRedData(type)
    return flag
end

function getRedAll(self)
    local isRed = false

    local tab = welfareOpt.WelfareOptConst:getTabList()

    for id, data in pairs(tab) do
        isRed = self:getRedData(data.page)
        if isRed then
            return true
        end
    end
    return false
end

function parseSignInfoMsg(self, msg)
    self.m_awardList = {}
    for i = 1, #msg.sign_award_list do
        local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
        propsVo:setPropsAwardMsgData(msg.sign_award_list[i])
        table.insert(self.m_awardList, propsVo)
    end

    self.m_monthCardAwardList = {}
    for i = 1, #msg.month_card_award_list do
        local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
        propsVo:setPropsAwardMsgData(msg.month_card_award_list[i])
        table.insert(self.m_monthCardAwardList, propsVo)
    end
    self:updateBubble()
end

function updateBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {
        tabType = welfareOpt.WelfareOptConst.WELFAREOPT_SIGN
    })
end

function getAwardList(self)
    return self.m_awardList or {}
end

function getMonthCardAwardList(self)
    return self.m_monthCardAwardList or {}
end

function parseTapTapTask(self)
    self.taptapDic = {}
    local baseData = RefMgr:getData("linkage_data")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptTapTapTaskVo.new()
        vo:parseTapTapTaskData(id, data)
        self.taptapDic[id] = vo
    end
end

function getTapTapTask(self)
    if self.taptapDic == nil then
        self:parseTapTapTask()
    end
    return self.taptapDic
end

-- 解析战斗补给数据
function parseBattleSupplyData(self)
    self.battleSupplyDic = {}
    local baseData = RefMgr:getData("battle_supply_data")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptFightSupplyVo.new()
        vo:pareseFightSupplyVo(data)
        self.battleSupplyDic[id] = vo
    end
end

-- 解析体力补给配置表
function parseStrengthSupplyData(self)
    self.mStrengthSupplyDic = {}
    local baseData = RefMgr:getData("strength_supply")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptStrengthSupplyVo.new()
        vo:parseWelfareOptStrengthSupplyData(data)
        self.mStrengthSupplyDic[id] = vo
    end
end

-- 解析战斗补给展示数据
function parseBattleSupplyList(self)
    self.battleSupplyProDic = {}
    self.mbattleMaxId = 0
    local baseData = RefMgr:getData("battle_supply_list")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptFightSupplyProVo.new()
        vo:pareseFightSupplyProVo(data)
        if self.mbattleMaxId < id then
            self.mbattleMaxId = id
        end
        self.battleSupplyProDic[id] = vo
    end
end

-- 解析训练营数据
function parseNoviceData(self)
    self.mNoviceDic = {}
    local baseData = RefMgr:getData("novice_training_data")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptNoviceVo.new()
        vo:parseNoviceData(id, data)
        self.mNoviceDic[id] = vo
    end
end

function parseNoviceAwardData(self)
    self.mNoviceAwardDic = {}
    local baseData = RefMgr:getData("novice_training_award_data")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptNoviceAwardVo.new()
        vo:parseNoviceAwardData(data)
        self.mNoviceAwardDic[id] = vo
    end
end

function parseFestivalData(self)
    self.mFestivalList = {}
    local baseData = RefMgr:getData("festival_sign_data")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptFestivalVo.new()
        vo:parseData(id, data)
        table.insert(self.mFestivalList, vo)
    end

    table.sort(self.mFestivalList, function(a, b)
        return a.id < b.id
    end)
end

function getFestivalData(self)
    if self.mFestivalList == nil then
        self:parseFestivalData()
    end
    return self.mFestivalList
end

function getIsFestivalRed(self)
    for i, v in ipairs(self:getFestivalData()) do
        local geted = welfareOpt.WelfareOptManager:getSignRewardGeted(i)
        if not geted and i<= self:getSignDay() then
            return true
        end
    end
    return false
end

-- 获取体力补给数据通过时间
function getStrengthSupplyDic(self)
    if self.mStrengthSupplyDic == nil then
        self:parseStrengthSupplyData()
    end
    return self.mStrengthSupplyDic
end

-- 获取是否需要进行红点更新
function getIsUpdateRed(self)
    if not self.mStrengthRecordTime then
        local clientTime = GameManager:getServerTime()
        self.mStrengthRecordTime = os.date('*t', clientTime)
    end
    if self:getIsInterval() then
    end
end

-- 获取当前奖励列表
function getCurStrengthSupplyAwardList(self)
    local list = {}
    if not self.mStrengthSupplyDic then
        self:getStrengthSupplyDic()
    end
    for id, value in pairs(self.mStrengthSupplyDic) do
        if not table.indexof(self.awardList, id) then
            list = value:getAwardList()
            list[1].count = list[1].num
            return list
        end
    end
    return {}
end

-- 获取战斗补给数据
function getDataFightSupplyData(self, id)
    if (self.battleSupplyDic == nil) then
        self:parseBattleSupplyData()
    end
    return self.battleSupplyDic[id]
end

function getDataFightSupplyColorData(self, id)
    if self.battleSupplyProDic == nil then
        self:parseBattleSupplyList()
    end

    local curStageId = battleMap.MainMapManager:getMainMapCurStage()
    local chapterVo = battleMap.MainMapManager:getChapterVoByStageId(curStageId)

    local vo = self.battleSupplyProDic[chapterVo.chapterId]
    if vo == nil then
        vo = self.battleSupplyProDic[self.mbattleMaxId]
    end

    local dic = vo:getColorDic(id)
    local des = vo:getDes(id)
    return dic, des
end

-- 获取训练营数据
function getNoviceData(self, id)
    if (self.mNoviceDic == nil) then
        self:parseNoviceData()
    end
    if (id == nil) then
        return self.mNoviceDic
    else
        return self.mNoviceDic[id]
    end
end

function getNoviceDataByStage(self, stage)
    if (self.mNoviceDic == nil) then
        self:parseNoviceData()
    end
    local resList = {}
    for _, v in pairs(self.mNoviceDic) do
        if (v.mStep == stage) then
            table.insert(resList, v)
        end
    end
    return resList
end

function getNoviceAwardData(self, id)
    if (self.mNoviceAwardDic == nil) then
        self:parseNoviceAwardData()
    end
    if (id == nil) then
        return self.mNoviceAwardDic
    else
        return self.mNoviceAwardDic[id]
    end
end

-- 解析概率数据
function parseFightSupplyProData(self)
    self.fightSupplyProDic = {}
    local baseData = RefMgr:getData("active_draw_data")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptFightSupplyProVo.new()
        vo:pareseFightSupplyProVo(data)
        self.fightSupplyProDic[id] = vo
    end
end

-- 获取概率数据 类型 章节id
function getFightSupplyProData(self, type, chapter)
    if self.fightSupplyProDic == nil then
        self:parseFightSupplyProData()
    end

    local ruleProData = {}
    local data = self.fightSupplyProDic[type]
    for id, data in pairs(data.ruleData) do
        if data.chapterId == chapter then
            table.insert(ruleProData, data)
        end
    end

    return ruleProData
end

-- 解析金币祈愿数据
function parseGoldWishingData(self)
    self.goldWishingDic = {}
    local baseData = RefMgr:getData("gold_wish_data")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptGoldWishingVo.new()
        vo:parseGoldWishingData(data)
        self.goldWishingDic[id] = vo
    end
end

-- 获取金币祈愿数据
function getGoldWishingData(self, id)
    if self.goldWishingDic == nil then
        self:parseGoldWishingData()
    end

    return self.goldWishingDic[id]
end

function parseGoldWishingServerData(self, msg)
    self.goldSwishingServerData = welfareOpt.WelfareOptGoldWishingServerVo.new()
    self.goldSwishingServerData:parseGoldWishingServerData(msg)

    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {
        tabType = welfareOpt.WelfareOptConst.WELFAREOPT_GOLDWISHING
    })
end

-- 获取服务器下发的金币祈愿数据
function getGoldWishingServerData(self)
    if self.goldSwishingServerData == nil then
        return
    end
    return self.goldSwishingServerData
end

-- 解析7天登录配置
function parseSevenLoadingData(self)
    self.sevenLoadingDic = {}
    local baseData = RefMgr:getData("sevenday_data")
    for id, data in pairs(baseData) do
        local vo = welfareOpt.WelfareOptSevenLoadingVo.new()
        vo:parseWelfareSevenLoadingData(data)
        self.sevenLoadingDic[id] = vo
    end
end

-- 获取7天登录数据
function getSevenLoadingData(self)
    if (self.sevenLoadingDic == nil) then
        self:parseSevenLoadingData()
    end
    return self.sevenLoadingDic
end

-- 解析7天登录服务器数据
function parseSevenLoadingServerData(self, msg)
    self.loadingDay = msg.login_day
    self.rewardList = msg.seven_day_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {
        tabType = welfareOpt.WelfareOptConst.WELFAREOPT_SEVENLOADING
    })
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
    if self:getSevenLoadingServerData() and #self:getSevenLoadingServerData().list >= 7 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_HIDE, activity.ActivityConst.ACTIVITY_SEVENLOADING)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
end

-- 获取7天登录服务器数据
function getSevenLoadingServerData(self)
    if self.loadingDay == nil then
        return
    end
    return {
        day = self.loadingDay,
        list = self.rewardList
    }
end

function parseStrengthSupplyServerData(self, msg)
    -- 奖励列表
    self.awardList = {}
    if next(msg.reward_list) then
        self.awardList = msg.reward_list
    end
    self:updateStrengthSupplyBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATE_STRANGTH_REWARD_PANEL)
end

function getStrengthSupplyAwardList(self)
    if (self.awardList == nil) then
        return {}
    end
    return self.awardList
end

function retReward(self, msg)
    if (msg.result == 1) then
        GameDispatcher:dispatchEvent(EventName.UPDATE_STRANGTH_REWARD_PANEL)
        ShowAwardPanel:showPropsAwardMsg(self:getCurStrengthSupplyAwardList())
    else
        gs.Message.Show(_TT(36516))
    end
end

function updateStrengthSupplyBubble(self)
    if not self.mStrengthSupplyDic then
        self:getStrengthSupplyDic()
    end
    local curState = self.mIsSignin
    if (self:getIsCanReceived() == true) then
        self.mIsSignin = 2
    else
        self.mIsSignin = 1
    end
    if curState ~= self.mIsSignin then
        GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {
            tabType = welfareOpt.WelfareOptConst.WELFAREOPT_SIGN
        })
    end
end

-- 获取体力补给是否在当前时间段
function getIsStrengthSupplyTime(self, data, time, idx)
    local severTime = self:getConversionTimetoSec1(time.hour, time.min, time.sec)
    local dataBeginTime = self:getConversionTimetoSec1(data.beginHour, 0, 0)
    local dataEndTime = self:getConversionTimetoSec1(data.endHour, 0, 0)
    if idx == 1 then
        if severTime >= dataBeginTime and severTime <= dataEndTime then
            return true
        end
        return false
    else
        if severTime >= dataBeginTime or severTime < dataEndTime then
            return true
        end
        return false
    end
end

-- 是否可领取有红点
function getIsCanReceived(self)
    local clientTime = GameManager:getServerTime()
    local t = os.date('*t', clientTime)
    if not self.mStrengthSupplyDic then
        self:getStrengthSupplyDic()
    end

    for idx, Vo in pairs(self.mStrengthSupplyDic) do
        if self:getIsStrengthSupplyTime(self.mStrengthSupplyDic[idx], t, idx) then
            if self.awardList == nil or not table.indexof(self.awardList, idx) then
                return true
            end
        end
    end
    return false
end

-- 当前GroupID是否在领取时间段
function checkGroupisInTimeSpan(self, idx)
    local t = os.date('*t', GameManager:getServerTime())
    if self:getIsStrengthSupplyTime(self:getStrengthSupplyDic()[idx], t, idx) then
        return true
    end
    return false
end

-- 当前时间是否在过期领取时间
function checkIsExpired(self, idx)
    local time = os.date('*t', GameManager:getServerTime())
    if self.mStrengthSupplyDic == nil then
        self:parseStrengthSupplyData()
    end
    local curTIme = self:getConversionTimetoSec1(time.hour, time.min, time.sec)
    -- 求余24 ，过天 24点为0
    local endTime = self:getConversionTimetoSec1(self.mStrengthSupplyDic[idx].endHour % 24, 0, 0)
    if endTime == self.m_5TimeStamp then
        return false
    end
    return curTIme >= endTime and self.m_5TimeStamp > curTIme
end

-- 转化时间为秒 h+min+sec
function getConversionTimetoSec1(self, hour, min, sec)
    local hourSum = hour * 60 * 60
    local minSum = min * 60
    local totalValue = hourSum + minSum + sec
    return totalValue
end

-- 解析新手训练营任务进度
function parseTaskInfo(self, msg)
    if (self.mTaskList == nil) then
        self.mTaskList = {}
    end
    for _, v in pairs(msg) do
        local vo = welfareOpt.WelfareOptNoviceMissionVo.new()
        vo:parseNoviceMissionData(v)
        local haveVo = false
        for i = 1, #self.mTaskList do
            if (self.mTaskList[i].id == vo.id) then
                haveVo = true
                self.mTaskList[i] = vo
            end
        end

        if not haveVo then
            table.insert(self.mTaskList, vo)
        end
    end

    self:sortTaskList()
    if (self.mTrainerDic == nil) then
        self.mTrainerDic = {}
    end
    self.mTrainerDic.taskList = self.mTaskList
    GameDispatcher:dispatchEvent(EventName.UPDATE_TRAINER_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {
        tabType = welfareOpt.WelfareOptConst.WELFAREOPT_NOVICEGOAL
    })
end

function sortTaskList(self)
    table.sort(self.mTaskList, function(a, b)
        if (a.state ~= b.state) then
            return a.state < b.state
        else
            return a.id < b.id
        end
    end)
end

-- 解析训练营服务器数据
function parseTrainerServerData(self, msg)
    if (self.mTrainerDic ~= nil and self.mTrainerDic ~= {}) then
        if (msg.step ~= self.mTrainerDic.step) then
            self.mTrainerDic = nil
            self.mTaskList = {}
            self.mTrainerStageReward = false
        end
    end
    self.mTrainerDic = {
        step = msg.step,
        reciveAll = msg.is_received_all,
    taskList = {}}
    self:parseTaskInfo(msg.task_list)
    GameDispatcher:dispatchEvent(EventName.UPDATE_TRAINER_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {
        tabType = welfareOpt.WelfareOptConst.WELFAREOPT_NOVICEGOAL
    })
end

-- 解析新手训练营任务奖励结果
function parseTrainerRewardServerData(self, msg)
    if (msg.result == 1) then
        self.mTrainerRewardList = msg.task_id_list
        for i = 1, #self.mTrainerRewardList do
            for j = 1, #self.mTaskList do
                if self.mTaskList[j].id == self.mTrainerRewardList[i] then
                    self.mTaskList[j].state = 2
                end
            end
        end
        self:sortTaskList()
        GameDispatcher:dispatchEvent(EventName.UPDATE_TRAINER_PANEL)
        GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {
            tabType = welfareOpt.WelfareOptConst.WELFAREOPT_NOVICEGOAL
        })
    end
end

-- 获取新手训练营阶段奖励结果 true : 成功，false 失败
function parseTrainerStageRewardServerData(self, msg)
    self.mTrainerStageReward = msg.result == 1 and true or false
    GameDispatcher:dispatchEvent(EventName.UPDATE_TRAINER_PANEL)
    GameDispatcher:dispatchEvent(EventName.UPDATE_WELFAREOPT_FLAG, {
        tabType = welfareOpt.WelfareOptConst.WELFAREOPT_NOVICEGOAL
    })
end

function getTaskInfo(self)
    return self.mTaskList
end

function getStageRewardResult(self)
    return self.mTrainerStageReward
end

function getRewardList(self)
    return self.mTrainerRewardList
end

function getTrainerData(self)
    if (self.mTrainerDic == {}) then
        return {{
            reciveAll = 1,
        taskList = {}}} -- 无的话就不显示训练营了
    end
    return self.mTrainerDic
end
-- 是否所有奖励已领取完毕
function IsTrainerReciveAll(self)
    if self.mNoviceDic == nil then
        self:parseNoviceData()
    end
    if self.mTrainerDic ~= nil then
        if (self:DicMax(self.mNoviceDic).mStep == self.mTrainerDic.step) and (self.mTrainerDic.reciveAll == 1) then
            return true
        end
    end
    return false
end
-- 字典最大值
function DicMax(self, dic)
    local mn = nil;
    local maxVo = nil;
    for k, v in pairs(dic) do
        if (mn == nil) then
            mn = k
        end
        if mn < k then
            mn = k
            maxVo = v
        end
    end
    return maxVo
end

-- 判断领取状态
function checkWelfareSupply(self, idx)
    local t = os.date('*t', GameManager:getServerTime())
    local curTime = self:getConversionTimetoSec1(t.hour, t.min, t.sec)
    if curTime == self.m_5TimeStamp then
        self.awardList = {}
    end
    if table.indexof(self.awardList, idx) then
        self:checkStateIsChange(idx, welfareOpt.WelfareOptConst.SUPPLY_REIVED)
    elseif self:checkGroupisInTimeSpan(idx) and not table.indexof(self.awardList, idx) then
        self:checkStateIsChange(idx, welfareOpt.WelfareOptConst.SUPPLY_CANREIVE)
    elseif not self:checkGroupisInTimeSpan(idx) and not table.indexof(self.awardList, idx) then
        if self:checkIsExpired(idx) then
            self:checkStateIsChange(idx, welfareOpt.WelfareOptConst.SUPPLY_EXPIRE)
        else
            self:checkStateIsChange(idx, welfareOpt.WelfareOptConst.SUPPLY_CANNOTRECEIVE)
        end
    end
end

-- 状态改变通知UI变换
function checkStateIsChange(self, index, state)
    if self.supplySateDic[index] ~= state then
        self.supplySateDic[index] = state
        GameDispatcher:dispatchEvent(EventName.UPDATE_SIGN_STATE_CHANGE, {
            idx = index,
            state = state
        })
    end
end

-- taptap活动是否开启
function getTapActivityIsOpen(self)
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if channelId == sdk.AndroidChannelId.BILI and self.isBiliOpen == 0 then
        -- bilibili包后端控制开放
        return false
    end
    if not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_TAPTAP, false) then
        return false
    end
    return false
    --return true
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
