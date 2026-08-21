--[[ 
-----------------------------------------------------
@filename       : DailyRechargeManager
@Description    : 每日充值
@date           : 2026-06-01
@Author         : sxt
@copyright      : (LY) 雷焰网络
-----------------------------------------------------
]]
module("dailyRecharge.DailyRechargeManager", Class.impl(Manager))

function ctor(self)
    super.ctor(self)
    self:__init()
end

function dtor(self)
end

function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 配置缓存：列表用于页签展示，字典用于按档位快速查询
    self.mDailyRechargeConfigList = nil
    self.mDailyRechargeConfigDic = nil
    -- 服务端活动数据，结构为 mDailyRechargeData[gear][day] = { gear, day, state }
    self.mDailyRechargeData = {}
    -- 今日累计充值金额，服务端以分为单位下发
    self.mTodayPay = 0
end

-- 解析每日累充面板协议数据，并刷新面板与入口红点
function parseDailyRechargePanelData(self, msg)
    self.mDailyRechargeData = {}
    self.mTodayPay = msg.today_pay or 0
    -- 兼容协议字段 day_acc_pay_lit / day_acc_pay_list
    local list = msg.day_acc_pay_lit or msg.day_acc_pay_list or {}
    for i = 1, #list do
        local data = list[i]
        self.mDailyRechargeData[data.gear] = self.mDailyRechargeData[data.gear] or {}
        self.mDailyRechargeData[data.gear][data.day] = data
    end
    self:updateRed()
    GameDispatcher:dispatchEvent(EventName.UPDATE_DAILY_RECHARGE_PANEL)
end

-- 获取今日累计充值金额
function getTodayPay(self)
    return self.mTodayPay or 0
end

-- 获取指定档位、指定天数的服务端领取状态数据
function getDailyRechargeData(self, gear, day)
    if self.mDailyRechargeData[gear] then
        return self.mDailyRechargeData[gear][day]
    end
end

-- 指定档位是否存在可领取奖励
function getIsCanGainByGear(self, gear)
    if self.mDailyRechargeData[gear] then
        for day, data in pairs(self.mDailyRechargeData[gear]) do
            if data.state == 1 then
                return true
            end
        end
    end
    return false
end

-- 任意档位是否存在可领取奖励，用于主界面入口红点
function getIsCanGain(self)
    for gear, dayDic in pairs(self.mDailyRechargeData) do
        for day, data in pairs(dayDic) do
            if data.state == 1 then
                return true
            end
        end
    end
    return false
end

-- 刷新主界面每日充值入口红点
function updateRed(self)
    local notFirst = StorageUtil:hasKey0(gstor.FIRST_DAILY_RECHARGE) and StorageUtil:getBool0(gstor.FIRST_DAILY_RECHARGE) == true
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_DAILY_RECHARGE, (not notFirst) or self:getIsCanGain())
end

-- 领取成功后本地更新奖励状态为已领取
function updateDailyRechargeAwardState(self, args)
    if not args then
        return
    end
    self.mDailyRechargeData[args.gear] = self.mDailyRechargeData[args.gear] or {}
    self.mDailyRechargeData[args.gear][args.day] = self.mDailyRechargeData[args.gear][args.day] or { gear = args.gear, day = args.day }
    self.mDailyRechargeData[args.gear][args.day].state = 2
end

-- 解析每日充值配置表 day_acc_pay_data
function parseDailyRechargeConfig(self)
    self.mDailyRechargeConfigList = {}
    self.mDailyRechargeConfigDic = {}
    local baseData = RefMgr:getData("day_acc_pay_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(dailyRecharge.DailyRechargeVo)
        vo:parseData(id, data)
        self.mDailyRechargeConfigDic[id] = vo
        table.insert(self.mDailyRechargeConfigList, vo)
    end
    table.sort(self.mDailyRechargeConfigList, function(vo1, vo2)
        return vo1.id < vo2.id
    end)
end

function getDailyRechargeConfigList(self)
    if self.mDailyRechargeConfigList == nil then
        self:parseDailyRechargeConfig()
    end
    return self.mDailyRechargeConfigList
end

function getDailyRechargeConfigVo(self, id)
    if self.mDailyRechargeConfigDic == nil then
        self:parseDailyRechargeConfig()
    end
    return self.mDailyRechargeConfigDic[id]
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]
