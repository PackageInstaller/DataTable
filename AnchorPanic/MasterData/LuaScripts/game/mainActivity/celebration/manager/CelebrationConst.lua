module("Celebration.CelebrationConst", Class.impl())
WELFAREOPT_HOLIDAY=1--"七日签到"
SSR_Optional = 2--"SSR月卡自选"
Celebration_Task = 3--"庆典任务"
Raffle = 4
AccRecharge = 5
AwardState={
    Nomal=0,--未解锁
    Recive=1,--已解锁未领取
    Recived=2,--已领取
}
CelebrationTaskState={
    Nomal=1,--未解锁
    Recive=0,--已解锁未领取
    Recived=2,--已领取
}
function getTabList(self)
    local tabList={}
    if mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Festival) and
    mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Festival):getTimeRemaining() > 0 and
    welfareOpt.WelfareOptManager:getSignRewardList() == false
    then
        table.insert(tabList, {page = self.WELFAREOPT_HOLIDAY, nomalLan = _TT(48144), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_80.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_3.png"), view = welfareOpt.WelfareOptFestivalView, funcId = funcopen.FuncOpenConst.FUNC_ID_FESTIVAL,activityId=activity.ActivityId.Festival, isBubble = welfareOpt.WelfareOptManager:getIsFestivalRed()})
    end
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SSR_OPTIONAL, false)) then
        table.insert(tabList,{page = self.SSR_Optional, nomalLan = _TT(121191), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_82.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_50.png"), view = Celebration.CeleSsrOptionalSubView, funcId = funcopen.FuncOpenConst.FUNC_ID_SSR_OPTIONAL,activityId=activity.ActivityId.SsrOptional, isBubble = Celebration.CelebrationManager:getSSROptionalIsRed()})
    end
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CELEBRATION_TASK, false)) then
        table.insert(tabList,{page = self.Celebration_Task, nomalLan = _TT(121010), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_81.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_50.png"), view = Celebration.CelebrationTaskSubView, funcId = funcopen.FuncOpenConst.FUNC_ID_CELEBRATION_TASK,activityId=activity.ActivityId.CelebrationTask, isBubble = Celebration.CelebrationManager:getTaskIsHasRed()})
    end
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE, false)) then
        table.insert(tabList,{page = self.Raffle, nomalLan = _TT(90051), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_83.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_50.png"), view = noviceActivity.NoviceActivityRaffleTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE,activityId=activity.ActivityId.CelebrationRaffle, isBubble = noviceActivity.NoviceActivityManager:checkRaffleBubble()})
    end
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CELEBRATION_ACC_RECHARGE, false)) then
        table.insert(tabList,{page = self.AccRecharge, nomalLan = _TT(121015), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_79.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_50.png"), view = Celebration.CelebrationAccRechargeView, funcId = funcopen.FuncOpenConst.FUNC_ID_CELEBRATION_ACC_RECHARGE,activityId=activity.ActivityId.CelebrationTotalTopUp, isBubble = Celebration.CelebrationManager:getIsRechargeRed()})
    end
    return tabList
end
return _M