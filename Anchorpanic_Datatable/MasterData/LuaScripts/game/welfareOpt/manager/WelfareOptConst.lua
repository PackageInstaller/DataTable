module("game.welfareOpt.manager.WelfareOptConst", Class.impl())

WELFAREOPT_SEVENLOADING = 1 -- 7天签到
WELFAREOPT_SIGN = 2 -- 出勤津贴(体力补给) (每日补给)
WELFAREOPT_GOLDWISHING = 3 ---金币许愿
WELFAREOPT_FIGHTSUPPLY = 4 ----战斗补给
WELFAREOPT_NOVICEGOAL = 5 -- 新人训练营
WELFAREOPT_SEVENTDAY_TARGET = 6 -- 7天训练目标
WELFAREOPT_OPEN_BETA = 7 -- 公测福利
WELFAREOPT_UP = 8 -- 副本双倍edl

--WELFAREOPT_RAFFLE = 9 --新手抽奖
WELFAREOPT_HOLIDAY = 9 -- 节日福利
WELFAREOPT_TAPTAP = 10 --TAPTAP联动

SUPPLY_CANREIVE = 7 --可领取
SUPPLY_REIVED = 8 --已经领取的
SUPPLY_EXPIRE = 9 --已经过期
SUPPLY_CANNOTRECEIVE = 10--早于

function getTabList(self)
    local tabList = {}

    --if (welfareOpt.WelfareOptManager:getSevenOpen()) then
    --    tabList[WELFAREOPT_SEVENLOADING] = { page = WELFAREOPT_SEVENLOADING, nomalLan = _TT(48101), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_6.png"), view = welfareOpt.WelfareOptSevenLoadingView }
    --end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_GOLDWSHING, false) then
        table.insert(tabList, {page = self.WELFAREOPT_GOLDWISHING, nomalLan = _TT(48103), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_7.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_5.png"), view = welfareOpt.WelfareOptGoldWishingView})
    end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_FIGHT, false) then
        table.insert(tabList, {page = self.WELFAREOPT_FIGHTSUPPLY, nomalLan = _TT(48105), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_8.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_5.png"), view = welfareOpt.WelfareOptFightSupplyView})
    end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_NOVICETRAIN, false) and welfareOpt.WelfareOptManager:IsTrainerReciveAll() == false then
        table.insert(tabList, {page = self.WELFAREOPT_NOVICEGOAL, nomalLan = _TT(48130), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_7.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_7.png"), view = welfareOpt.WelfareOptNoviceGoalView})
    end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFAREOPT_SEVENDAY_TARGET, false) and not activityTarget.ActivityTargetManager:getIsFinish() then
        table.insert(tabList, {page = self.WELFAREOPT_SEVENTDAY_TARGET, nomalLan = _TT(52020), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_8.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_8.png"), view = welfareOpt.WelfareOptSevenDayTargetView})
    end

    if welfareOpt.WelfareOptOpenBetaManager:checkIsOpen() then
        table.insert(tabList, {page = self.WELFAREOPT_OPEN_BETA, nomalLan = _TT(91006), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_65.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_65.png"), view = welfareOpt.WelfareOptOpenBetaView})
    end

    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Double) then
        table.insert(tabList, {page = self.WELFAREOPT_UP, nomalLan = _TT(85012), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabList/tabList_7.png"), selectIcon = UrlManager:getIconPath("tabList/tabList_63.png"), view = mainActivity.MainActivityUpView})
    end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WELFATEOPT_STRENGTH, false) then
        table.insert(tabList, {page = self.WELFAREOPT_SIGN, nomalLan = _TT(48102), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_9.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_9.png"), view = welfareOpt.WelfareOptSignView})
    end

    if welfareOpt.WelfareOptManager:getTapActivityIsOpen() then
        table.insert(tabList, {page = self.WELFAREOPT_TAPTAP, nomalLan = "TAPTAP联动", nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_9.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_9.png"), view = welfareOpt.WelfareOptTapTapView})
    end
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_RAFFLE,false) then
    --     table.insert(tabList, { page = self.WELFAREOPT_RAFFLE, nomalLan = "抽奖", nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_9.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_9.png"), view = welfareOpt.WelfareOptRaffleView })
    -- end

    return tabList
end

--七日目标战员展示
-- 1201 戴灵
WELFAREOPT_SEVENTDAY_TARGET_HERO_TID = 1201

--新手训练营战员展示
-- 1104 狄俄涅
WELFAREOPT_NOVICE_GOAL_HERO_TID = 1104
return _M
-- 每日补给(体力补给)状态--[[ 替换语言包自动生成，请勿修改！]]
