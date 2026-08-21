--[[ 
-----------------------------------------------------
@filename       : DailyCheckInManager
@Description    : 每日签到
@date           : 2023-3-13 
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.dailyCheckIn.manager.DailyCheckInManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.mIsSigned = false
    self.mIsOnMainUI = false
    self.mIsServerBack = false
    self.mDailyCheckInConfigDic = nil
    self.mDailyCheckInConfigList = {}
    self.mDailyCheckInMsgList = {}
    self.mDailyCheckInMoonthMsgList = {}
end

---------------------------------------------------------配置--------------------------------------------------------------
--获取签到信息
function parseDailyCheckInDataConfigData(self)
    self.mDailyCheckInConfigDic = {}
    self.mDailyCheckInConfigList = {}
    local baseData = RefMgr:getData("sign_data")
    for daily, data in pairs(baseData) do
        local vo = dailyCheckIn.DailyCheckInVo.new()
        vo:parseData(daily, data)
        self.mDailyCheckInConfigDic[daily] = vo
        table.insert(self.mDailyCheckInConfigList, vo)
    end
    table.sort(self.mDailyCheckInConfigList, function(vo1, vo2)
        return vo1.daily < vo2.daily
    end)
end

function parseDailyCheckInPanelMsg(self, msg)
    if msg then
        local isInit = false
        if self:getCurRealDaily() <= 1 then
            self.mDailyCheckInMsgList = {}
            isInit = true
        end
        if activity.ActivityManager:getPromoIsShow() == nil then
            activity.ActivityManager:setPromoIsShow(false)
        end
        self.mIsSigned = (msg.today_is_sign > 0) and true or false
        for _, dailyId in pairs(msg.sign_days) do
            if table.indexof(self.mDailyCheckInMsgList, dailyId) == false and dailyId ~= 0 then
                table.insert(self.mDailyCheckInMsgList, dailyId)
            end
        end
        table.sort(self.mDailyCheckInMsgList, function(a, b)
            return a < b
        end)
        for _, id in pairs(msg.month_card_award_list) do
            if table.indexof(self.mDailyCheckInMoonthMsgList, id) == false then
                table.insert(self.mDailyCheckInMoonthMsgList, id)
            end
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_SIGNIN_STATE)
        self.mIsServerBack = true
        self:OpneDailyCheckIn(isInit)
    end
end
function OpneDailyCheckIn(self, isInit)
    if ((self:getIsSign() == false) and (self.mIsOnMainUI == true) and (self.mIsServerBack == true)) then
        GameDispatcher:dispatchEvent(EventName.OPEN_SIGNIN_PANEL, isInit)
    end
end

function setisOnMainUI(self, isOn)
    self.mIsOnMainUI = isOn
    if self.mIsOnMainUI == true then
        self:OpneDailyCheckIn()
    end
end

function getCurDaily(self)
    for day, dailyVo in ipairs(self:getDailyCheckInList()) do
        if (self.mIsSigned == false) then
            if table.indexof(self.mDailyCheckInMsgList, dailyVo.daily) == false then
                return day
            end
        else
            return self.mDailyCheckInMsgList[#self.mDailyCheckInMsgList]
        end
    end
end

function getCurRealDaily(self)
    local day = os.date("*t", GameManager:getClientTime() - 5 * 60 * 60).day
    return day
end

function getCurMonth(self)
    local time = os.date("*t", GameManager:getClientTime() - 5 * 60 * 60)
    local month = time.month
    return month
end

function getIsRecivedNomalById(self, daily)
    return table.indexof(self.mDailyCheckInMsgList, daily) ~= false
end


function getIsRecivedList(self)
    return self.mDailyCheckInMsgList
end

function getIsRecivedMoonthById(self, daily)
    return table.indexof(self.mDailyCheckInMoonthMsgList, daily) ~= false
end

--是否已签到
function getIsSign(self)
    return self.mIsSigned
end

function parseDailyCheckInMsg(self, msg)
    if msg.result == 1 then
        if table.indexof(self.mDailyCheckInMsgList, msg.sign_day) == false then
            self.mIsSigned = true
            table.insert(self.mDailyCheckInMsgList, msg.sign_day)
        end
        table.sort(self.mDailyCheckInMsgList, function(a, b)
            return a < b
        end)
        GameDispatcher:dispatchEvent(EventName.UPDATE_SIGNIN_VIEW, msg.award)
    end
end
--
function getCurDailyCheckInVo(self)
    return self:getDailyCheckInList()[self:getCurDaily()]
end

-- 获取工厂配置字典
function getDailyCheckInList(self)
    if (#self.mDailyCheckInConfigList <= 0) then
        self:parseDailyCheckInDataConfigData()
    end
    local list = {}
    local time = os.date("*t", GameManager:getClientTime() - 5 * 60 * 60)
    local monthDaily = tonumber(os.date("%d", os.time({ year = time.year, month = time.month + 1, day = 0 })))
    for daily, dailyVo in ipairs(self.mDailyCheckInConfigList) do
        if dailyVo.daily <= monthDaily then
            table.insert(list, dailyVo)
        end
    end
    table.sort(list, function(a, b) return a.daily < b.daily end)
    return list or {}
end


-- 显示状态（主UI使用）保底显示
function checkShowState(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIRSTCHARGE)
    if not isOpen then
        return false
    end
    return true
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]