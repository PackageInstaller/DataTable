-- baoruichang
-- 2023/6/5 14:05:50
local UIDayEnergyCtrl = BaseClass("UIDayEnergyCtrl", BaseUICtrl)
local M = UIDayEnergyCtrl
local ECycleEvent = protocol.ECycleEvent
local sSplit = string.split
local MessageId = Proto.MessageId
local ONEHOUR = 3600
local ONEMINUTE = 60


function M:Init()
    self._view.imgLeft:SetOnClick(Bind(self, self._OnClickItem))
    self._view.imgRight:SetOnClick(Bind(self, self._OnClickItem))
end

-- 进入UI，可传参数
function M:OnEnter()
    local EnergyData = CycleDataMgr:GetInstance():GetCycleDataByType(ECycleEvent.ECET_Daily_Gift)
    local lastTimer = EnergyData:GetLastGetTimer()
    local rewardValue = EnergyData:GetRewardValue()
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local isOneDay = TimeUtil.IsOneDay(lastTimer - 5 * ONEMINUTE, nowTimer - 5 * ONEMINUTE)
    rewardValue = isOneDay and rewardValue or 0
    self.activityenergys = ConfigHelper.GetCfgs("activityenergy")
    local nowS = TimeUtil.GetSecondIndexInDay()
    for _, activityenergy in pairs(self.activityenergys) do
        local isReward = self:IsReward(rewardValue, activityenergy.id)
        if isReward then
            activityenergy.state = 4 -- 已经领取
        else
            local timerStar = self:GetTimeS(activityenergy.startTime)
            local timerEnd = self:GetTimeS(activityenergy.endTime)
            if timerEnd < nowS then
                activityenergy.state = 3 -- 已经结束
            elseif timerStar > nowS then
                activityenergy.state = 1 -- 未开始
            else
                activityenergy.state = 2 -- 可领取
            end
        end
    end
    self._view.imgLeft:UpdateItem(self.activityenergys[1])
    self._view.imgRight:UpdateItem(self.activityenergys[2])
    --刷新每日用餐页签红点
    RedPointMgr:ForceCheck(RedPointConst.DayEnergyRedPointChecker)
end

function M:IsReward(rewardValue, id)
    return 1 << id & rewardValue > 0
end

function M:GetTimeS(timer)
    local tabTimer = sSplit(timer, ":")
    local s = tonumber(tabTimer[1]) * ONEHOUR + tonumber(tabTimer[2]) * ONEMINUTE
    return s
end

function M:_OnClickItem(id)
    local EnergyData = CycleDataMgr:GetInstance():GetCycleDataByType(ECycleEvent.ECET_Daily_Gift)
    local lastTimer = EnergyData:GetLastGetTimer()
    local rewardValue = EnergyData:GetRewardValue()
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local isOneDay = TimeUtil.IsOneDay(lastTimer - 5 * ONEMINUTE, nowTimer - 5 * ONEMINUTE)
    rewardValue = isOneDay and rewardValue or 0
    local activityenergy = self.activityenergys[id]
    local isReward = self:IsReward(rewardValue, activityenergy.id)
    if isReward then
        GameHelper.TipsById(5611) -- 已经领取
        self:OnEnter()
        return
    end
    local nowS = TimeUtil.GetSecondIndexInDay()
    local timerStar = self:GetTimeS(activityenergy.startTime)
    local timerEnd = self:GetTimeS(activityenergy.endTime)
    if timerEnd < nowS then -- 已经过期
        GameHelper.TipsById(30004)
        self:OnEnter()
        return
    elseif timerStar > nowS then -- 未开始
        GameHelper.TipsById(861)
        self:OnEnter()
        return
    end
    self:RequestDailyAward(id)
end

function M:RequestDailyAward(id)
    self._tempResponseDailyAwardCallBack = NetPack:RegistResponse(MessageId.ResponseDailyAward, Bind(self, self._ResponseDailyAwardCallBack))
    local request = {}
    request.Ids = {id}
    NetPack:SendMessage(MessageId.RequestDailyAward, request)
end

function M:_ResponseDailyAwardCallBack(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseDailyAward, self._tempResponseDailyAwardCallBack)
    self._tempResponseDailyAwardCallBack = nil
    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    GameHelper.ShowGetItemsByItems(msg.Awards)
    self:OnEnter()
end

return UIDayEnergyCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O. = /O
--                        ____/`---'.____
--						  . ' ..| |// `.
--                       / ..||| : |||// .
--                     / _||||| -:- |||||- .
--                       | | ... - --/ | |
--                     | ._| ''.---/'' |_. |
--                      . .-.__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___._<|>_/___.' >'"".
--               | | : `- .`.;`. _ /`;.`/ - ` : | |
--                 \ \ `-. ._ __. /__ _/ .-` / /
--         ======`-.____`-.___._____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员？

