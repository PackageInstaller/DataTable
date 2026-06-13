local RechargeConst = {}

local PlatformType = {
    ios = 1,
    android = 2
}

local RechargeType = {
    Recharge = 1,
    MonthCard = 2,
}
local IsShow = {
    On = 0,
    Off = 1
}

local ShopBagType = {
    MonthCard = 2, --月卡
    RookiePack = 3, -- 新手礼包
    WeeklyPack = 4, -- 周期礼包
    FreeLevelPack = 5, -- 免费等级礼包
    PaidLevelPack = 6, -- 付费等级礼包
    ModifyName = 7, --改名卡
    DailyPack = 8, --每日刷新礼包
    MonthlyPack = 9, --月刷新礼包
    FixedPack = 10, --固定刷新礼包
}

local FirstRechargeState = {
    NotRecharge = 0, --未充值
    RechargedAndNotReward = 1, --充值未领奖
    Rewarded = 2, --已经领奖
}

RechargeConst.PlatformType = PlatformType
RechargeConst.RechargeType = RechargeType
RechargeConst.IsShow = IsShow
RechargeConst.ShopBagType = ShopBagType
RechargeConst.FirstRechargeState = FirstRechargeState

return RechargeConst
