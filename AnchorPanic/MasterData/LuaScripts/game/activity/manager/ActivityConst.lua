module("game.activity.manager.ActivityConst", Class.impl())

ACTIVITY_SEVENLOADING = 1 -- 七日登录
ACTIVITY_SEVENTDAY_TARGET = 2 -- 入职特训
ACTIVITY_PERMIT = 4 -- 通行证
ACTIVITY_GROUTHFUND = 3 ---成长基金
ACTIVITY_DAILYCHECKIN = 5 -- 每日签到
--ACTIVITY_FIRSTCHARGE = 4 -- 首充
ACTIVITY_SUBSCRIBE = 6 -- 关注社区领奖

WELFAREOPT_RAFFLE = 7

function getTabList(self)
    local tabList = {}
    -- 七日登录
    if (welfareOpt.WelfareOptManager:getSevenOpen()) then
        table.insert(tabList, {page = self.ACTIVITY_SEVENLOADING, nomalLan = _TT(48101), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), view = welfareOpt.WelfareOptSevenLoadingView, funcId = funcopen.FuncOpenConst.FUNC_ID_WELFATEOPT_SEVENDAY, isLimit = false, isBubble = welfareOpt.WelfareOptManager:getTabRed(welfareOpt.WelfareOptConst.WELFAREOPT_SEVENLOADING)})
    end
    -- 入职特训
    --if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_SEVENDAY_TARGET, false) and not activityTarget.ActivityTargetManager:getIsFinish() then
    --    table.insert(tabList, { page = self.ACTIVITY_SEVENTDAY_TARGET, nomalLan = _TT(52020), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_8.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_8.png"), view = welfareOpt.WelfareOptSevenDayTargetView, funcId = funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_SEVENDAY_TARGET, isLimit = false, isBubble = welfareOpt.WelfareOptManager:getTabRed(welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET) })
    --end
    ---- 首充
    --if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIRSTCHARGE) and (not firstCharge.FirstChargeManager:getIsReciveOver())) then
    --    table.insert(tabList, { page = self.ACTIVITY_FIRSTCHARGE, nomalLan = _TT(50032), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_48.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_48.png"), view = firstCharge.FirstChargePanel, funcId = funcopen.FuncOpenConst.FUNC_ID_FIRSTCHARGE, isLimit = false, isBubble = firstCharge.FirstChargeManager:updateRed() })
    --end
    ---成长基金
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_GROWTHFUND, false) and (not purchase.GrowthFundManager:getIsGrowthFundOver())) then
        table.insert(tabList, {page = self.ACTIVITY_GROUTHFUND, nomalLan = _TT(72110), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_50.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_50.png"), view = purchase.GrowthFundPanel, funcId = funcopen.FuncOpenConst.FUNC_ID_GROWTHFUND, isLimit = false, isBubble = purchase.GrowthFundManager:updateRed()})
    end
    -- 通行证
    if self:checkActivityLimit(funcopen.FuncOpenConst.FUNC_ID_PERMIT) then
        table.insert(tabList, {page = self.ACTIVITY_PERMIT, nomalLan = _TT(72109), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_51.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_51.png"), view = permit.PermitPanel, funcId = funcopen.FuncOpenConst.FUNC_ID_PERMIT, isLimit = true, isBubble = permit.PermitManager:updateRed()})
    end
    -- 每日签到
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_SIGNIN, false) then
        table.insert(tabList, {page = self.ACTIVITY_DAILYCHECKIN, nomalLan = _TT(72111), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_49.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_49.png"), view = dailyCheckIn.DailyCheckInTabSubView, funcId = funcopen.FuncOpenConst.FUNC_ID_HOME_SIGNIN, isLimit = false, isBubble = false})
    end
    -- 关注社区领奖
    if (activity.ActitvityExtraManager:checkIsOpen() and not GameManager:getIsInCommiting()) then
        table.insert(tabList, {page = self.ACTIVITY_SUBSCRIBE, nomalLan = _TT(91002), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_63.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_63.png"), view = activity.ActivitySubscribeGift, funcId = funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_SUBSCRIBE, isLimit = false, isBubble = activity.ActitvityExtraManager:checkBubble()})
    end

    --星夜漫步
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE, false) and self:checkActivityLimit(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE) then
    --     table.insert(tabList, {page = self.WELFAREOPT_RAFFLE, nomalLan = _TT(90051), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_37.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_37.png"), view = noviceActivity.NoviceActivityRaffleTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE, isLimit = false, isBubble = noviceActivity.NoviceActivityManager:checkRaffleBubble()})
    -- end

    return tabList
end

function checkActivityLimit(self, fucId)
    local isOpen = activity.ActivityManager:checkIsOpenByFuncId(fucId)
    return isOpen
end

activity.ActivityId = {
    --通行证
    Permit = 101,
    --时装通行证
    Fashion_Permit = 217,
    --主题活动——试玩关卡
    TrialPlayLevel = 201,
    --主题活动——普通关卡
    NomalLevel = 202,
    --主题活动——困难关卡
    DifficultyLevel = 203,

    --主题活动—-小游戏
    Gameplay = 213,
    --主题活动—-推箱子
    Gameplay2 = 212,

    --主题活动——签到
    Sign = 204,
    --主题活动——商店
    Shop = 205,
    --主题活动——任务
    Task = 206,
    --主题活动——主界面
    MainActivity = 207,
    --双倍
    Double = 208,

    --主题活动——超难关卡
    HellLevel = 210,

    --节日
    Festival = 301,

    --挖宝
    Mining = 214,
    --钓鱼
    Fishing = 215,
    --消消乐
    Eliminate = 216,
    --蛋壳
    DanKe = 218,

    --总力战
    Disaster = 219,

    --捡金币（跑酷小游戏3）
    Gold = 220,
    --周年庆典-SSR月卡自选
    SsrOptional = 221,
    --周年庆典--庆典任务
    CelebrationTask = 222,
    --周年庆典--庆典累充
    CelebrationTotalTopUp = 223,
    --水管
    Ciruit = 224,
    --周年庆典--抽奖转盘
    CelebrationRaffle = 211,
}

return _M
