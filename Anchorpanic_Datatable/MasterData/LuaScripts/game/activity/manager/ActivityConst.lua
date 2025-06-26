module("game.activity.manager.ActivityConst", Class.impl())

ACTIVITY_SEVENLOADING = 1 -- 七日登录
ACTIVITY_SEVENTDAY_TARGET = 2 -- 入职特训
ACTIVITY_PERMIT = 4 -- 通行证
ACTIVITY_GROUTHFUND = 3 ---成长基金
ACTIVITY_DAILYCHECKIN = 5 -- 每日签到
--ACTIVITY_FIRSTCHARGE = 4 -- 首充
ACTIVITY_SUBSCRIBE = 6 -- 关注社区领奖

WELFAREOPT_RAFFLE = 7
--节日福利
WELFAREOPT_HOLIDAY = 8

function getTabList(self)
    local tabList = {}
    -- --节日福利
    -- if mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Festival) and
    --     mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Festival):getTimeRemaining() > 0 and
    --     welfareOpt.WelfareOptManager:getSignRewardList() == false then
    --     table.insert(tabList, {page = self.WELFAREOPT_HOLIDAY, nomalLan = _TT(48144), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_80.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_3.png"), view = welfareOpt.WelfareOptFestivalView, funcId = funcopen.FuncOpenConst.FUNC_ID_FESTIVAL, activityId = activity.ActivityId.Festival, isLimit = false, isBubble = welfareOpt.WelfareOptManager:getIsFestivalRed()})
    -- end
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
    -- 关注社区领奖(公众号无人维护、微博看的人少，活动直接屏蔽了)
    -- if (activity.ActitvityExtraManager:checkIsOpen() and not GameManager:getIsInCommiting() and not sdk.SdkManager:getIsChannelHarmonious()) then
    --     table.insert(tabList, {page = self.ACTIVITY_SUBSCRIBE, nomalLan = _TT(91002), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_63.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_63.png"), view = activity.ActivitySubscribeGift, funcId = funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_SUBSCRIBE, isLimit = false, isBubble = activity.ActitvityExtraManager:checkBubble()})
    -- end
    --星夜漫步
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE, false) and self:checkActivityLimit(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE) then
    --     table.insert(tabList, {page = self.WELFAREOPT_RAFFLE, nomalLan = _TT(90051), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_37.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_37.png"), view = noviceActivity.NoviceActivityRaffleTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE, isLimit = false, isBubble = noviceActivity.NoviceActivityManager:checkRaffleBubble()})
    -- end

    return tabList
end
--获取活动界面所包含的所有活动ID
function getActivityList(self)
    return
    {
        activity.ActivityId.Festival,
        activity.ActivityId.Permit,
    }
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
    --时装通行证2
    Fashion_Permit_Two = 226,
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
    --痒了又痒
    ThreeSheep = 228,

    --活动-充值好礼
    RechargeNiceGift = 502,
    --阿尔戈特供
    Supercial = 501,
    --狂欢好礼
    Activity_Carnival_Gift = 503,
    --投资理财
    Activity_Invest = 504,
    --特供活动
    SpecialSupply = 505,

    --自选礼包
    SelectBuy = 506,
    --新年活动-轮盘抽奖
    RoundPrize = 507,

    --狂欢好礼时装回廊活动
    --GiftFashionHis = 508,
    
    --时装通行证时装回廊活动
    PermitFashionHis = 509,
    --新年活动-轮盘抽奖2
    RoundPrizeTwo = 510,

    --农场活动入口
    HappyFarm = 225,
    --主题活动--整理背包
    OrganizeBackpacks = 227,
    --打砖块
    ShootBrick = 229,
    --拼图游戏
    PutImage = 230,
    --连连看
    Linklink = 231,

}

activity.LimitShopActivityType = {
    --副本类型和副本ID
    DupType = 1,
    --招募达到X次
    Recruitment = 2,
    --任意战员达到N阶
    Role = 3,
    --打开某个界面(界面代码)
    View = 4,
}

--历史时装类型
activity.FashionHisType = {
    CarnivalGift = 1,
    FashionPermit = 2,
}
return _M
