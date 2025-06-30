--[[ 
-----------------------------------------------------
@filename       : NoviceActivityConst
@Description    : 新手活动Const
@date           : 2023-6-5 16:50:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.noviceActivity.manager.NoviceActivityConst", Class.impl())
--烙痕链接计划
NOVICEACTIVITY_LINKPLAN = 1
--招募计划
NOVICEACTIVITY_RECRUITPLAN = 2
--升格计划
NOVICEACTIVITY_PROMOTIONPLAN = 3
--成长返还
NOVICEACTIVITY_RETURN = 4

--抽奖
NOVICEACTIVITY_RAFFLE = 5

--邀请函
NOVICEAVTIVITY_SSR = 6

--庆典筹备
NOVICEACTIVITY_RECHARGE = 7

function getTabList(self)
    local tabList = {}

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_SSR) and activity.ActivityManager:getNoviceActivitySsrIsOpen() then
        table.insert(tabList, { page = self.NOVICEAVTIVITY_SSR, nomalLan = _TT(121218), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_92.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_92.png"), view = noviceActivity.NoviceActivitySsrOptionalTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_SSR })
    end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RECHARGE) and activity.ActivityManager:getNoviceActivityRechargeIsOpen() then
        table.insert(tabList, { page = self.NOVICEACTIVITY_RECHARGE, nomalLan = _TT(121219), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_82.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_82.png"), view = noviceActivity.NoviceActivityRechargeTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RECHARGE })
    end

    --招募 | 链接
    if activity.ActivityManager:getNoviceActivityIsOpen() then
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_RECRUIT) then
            table.insert(tabList, { page = self.NOVICEACTIVITY_LINKPLAN, nomalLan = _TT(90033), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_62.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_62.png"), view = noviceActivity.NoviceActivityRecruitTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_RECRUIT })
        end
        --铸痕
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_BRACELECTS) then
            table.insert(tabList, { page = self.NOVICEACTIVITY_RECRUITPLAN, nomalLan = _TT(90034), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_53.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_53.png"), view = noviceActivity.NoviceActivityBracelectsTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_BRACELECTS })
        end
        --铸痕升格计划
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_UPGRADEPLAN) then
            table.insert(tabList, { page = self.NOVICEACTIVITY_PROMOTIONPLAN, nomalLan = _TT(90035), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_36.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_36.png"), view = noviceActivity.NovicePromotionPlanView, funcId = funcopen.FuncOpenConst.FUNC_ID_FACTORY_NOVICEACTIVITY_UPGRADEPLAN })
        end
        --升级返回
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RETURN) then
            table.insert(tabList, { page = self.NOVICEACTIVITY_RETURN, nomalLan = _TT(90038), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_64.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_64.png"), view = noviceActivity.NoviceActivityReturnTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RETURN })
        end
    end
   
    --抽奖
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE) then
    --     table.insert(tabList, { page = self.NOVICEACTIVITY_RAFFLE, nomalLan = _TT(90051), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_37.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_37.png"), view = noviceActivity.NoviceActivityRaffleTabView, funcId = funcopen.FuncOpenConst.FUNC_ID_NOVICEACTIVITY_RAFFLE })
    -- end

    
    return tabList
end

return _M