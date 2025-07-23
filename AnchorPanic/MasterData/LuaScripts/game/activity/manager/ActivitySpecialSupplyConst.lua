module("game.activity.manager.ActivitySpecialSupplyConst", Class.impl())

ACTIVITY_RECHARGE_NICEGIFT = 1 -- 充值好礼
ACTIVITY_INVEST = 2 -- 投资理财
ACTIVITY_CARNIVA_GIFT = 3 -- 狂欢好礼
ACTIVITY_SELECT_BUY = 4 --自选礼包
ROUNDPRIZE = 5

ROUNDPRIZE_TWO = 6 -- 转盘2

function getTabList(self, isNeedCloseAct)
    local tabList = {}
    -- 充值好礼
    if isNeedCloseAct or (
        (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_RECHARGE_NICE_GIFT)
            and activity.ActivityManager:getActivityVoById(activity.ActivityId.RechargeNiceGift)
        and activity.ActivityManager:getActivityVoById(activity.ActivityId.RechargeNiceGift):isOpen()))
        then
        table.insert(tabList, {page = self.ACTIVITY_RECHARGE_NICEGIFT, nomalLan = _TT(136002), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_87.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_87.png"), view = activity.ActivityRechargeNiceGift, funcId = funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_RECHARGE_NICE_GIFT, isLimit = false, isBubble = activity.ActitvityExtraManager:getRechargeNcieGiftRed()})
    end
    --投资理财
    if isNeedCloseAct or (
        funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_INVEST, false)
        and activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_Invest)
    and activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_Invest):isOpen())
    then
    table.insert(tabList, {page = self.ACTIVITY_INVEST, nomalLan = _TT(136511), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_86.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_86.png"), view = activity.ActivityInvestView, funcId = funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_INVEST, isLimit = false, isBubble = activity.ActivityManager:getInvestRed()})
end

if isNeedCloseAct or (
    funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CARNIVAL_GIFT, false)
    and activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_Carnival_Gift)
and activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_Carnival_Gift):isOpen())
then
table.insert(tabList, {page = self.ACTIVITY_CARNIVA_GIFT, nomalLan = _TT(138501), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_88.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_88.png"), view = activity.ActivityCarnivalGift, funcId = funcopen.FuncOpenConst.FUNC_ID_CARNIVAL_GIFT, isLimit = false, isBubble = activity.ActitvityExtraManager:getCarnivalIsRedState()})
end

--自选礼包 特约赞助
if isNeedCloseAct or (
    funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_SELECT_BUY, false)
    and activity.ActivityManager:getActivityVoById(activity.ActivityId.SelectBuy)
and activity.ActivityManager:getActivityVoById(activity.ActivityId.SelectBuy):isOpen())
then
table.insert(tabList, {page = self.ACTIVITY_SELECT_BUY, nomalLan = _TT(149008), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_89.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_89.png"), view = activity.ActivitySelectBuyView, funcId = funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_SELECT_BUY, isLimit = false, isBubble = activity.ActitvityExtraManager:getSelectGiftIsRedState()})
end

--新年活动--抽奖
if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NEWYEAR_ROUNDPRIZE, false) then
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.RoundPrize)
    if activityVo and activityVo:getTimeRemaining() > 0 and activityVo:getIsCanOpen() then
        table.insert(tabList, {page = self.ROUNDPRIZE, nomalLan = activityVo:getName(), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_96.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_96.png"), view = roundPrize.RoundPrizePanel, funcId = funcopen.FuncOpenConst.FUNC_ID_NEWYEAR_ROUNDPRIZE, activityId = activity.ActivityId.RoundPrize, isLimit = false, isBubble = roundPrize.RoundPrizeManager:isShowRed()})
    end
end

--新年活动--抽奖
if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NEWYEAR_ROUNDPRIZE_TWO, false) then
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.RoundPrizeTwo)
    if activityVo and activityVo:getTimeRemaining() > 0 and activityVo:getIsCanOpen() then
        table.insert(tabList, {page = self.ROUNDPRIZE_TWO, nomalLan = activityVo:getName(), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_97.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_97.png"), view = roundPrizeTwo.RoundPrizeTwoPanel, funcId = funcopen.FuncOpenConst.FUNC_ID_NEWYEAR_ROUNDPRIZE_TWO, activityId = activity.ActivityId.RoundPrizeTwo, isLimit = false, isBubble = roundPrizeTwo.RoundPrizeTwoManager:isShowRed()})
    end
end


return tabList
end

function checkActivityLimit(self, fucId)
    local isOpen = activity.ActivityManager:checkIsOpenByFuncId(fucId)
    return isOpen
end

--获取特供界面所包含的所有活动ID
function getActivityList(self)
    return
    {
        activity.ActivityId.Activity_Invest,
        activity.ActivityId.RechargeNiceGift,
        activity.ActivityId.Activity_Carnival_Gift,
        activity.ActivityId.SelectBuy,
    }
end

return _M
