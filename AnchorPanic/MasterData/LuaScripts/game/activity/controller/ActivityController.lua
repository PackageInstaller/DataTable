--[[ 
-----------------------------------------------------
@filename       : ActivityController
@Description    : 运营活动控制器
@date           : 2020-12-09 19:49:34
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.activity.controller.ActivityController', Class.impl(Controller))


--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    if self.mMgr and next(self.mMgr) then
        for _, mgr in pairs(self.mMgr) do
            if mgr.resetData then
                mgr:resetData()
            end
        end
    end
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_ACTIVITY_PANEL, self.onOpenActivityPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_RED, self.updateRed, self)
    GameDispatcher:addEventListener(EventName.SHOW_MAIN_UI, self.onMainUIFinish, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SIGNIN_STATE, self.onSigninPanelClose, self)
    GameDispatcher:addEventListener(EventName.SIGNIN_PANEL_CLOSE, self.onSigninPanelClose, self)
    GameDispatcher:addEventListener(EventName.OPEN_ACTIVITY_WECHAT, self.onOpenActivityWeChatHandler, self)
    --GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_RED, self.updateRed, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateRed, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_ACTIVITY_OPEN_INFO = self.onActivityOpenHandler,
        SC_ACTIVITY_OVER_INFO = self.onActivityOverHandler,
        --- *s2c* 新手活动-入口开启 24250
        SC_ACTIVITY_NOVICE_START = self.onActivityNoviceStartHandler,
        -- *s2c* 关注有礼面板信息 24215
        SC_CONCERN_GIFT_PANEL = self.onActivitySubcribe_Panel_Handler,
        --- *s2c* 领取关注有礼奖励返回结果 24217
        SC_GAIN_CONCERN_GIFT = self.onActivitySubcribe_Receiove_Handler,
    }
end

function updateRed(self)
    for _, activityVo in ipairs(activity.ActivityConst:getTabList()) do
        local isFlag = activityVo.isBubble
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ACTIVITY, isFlag, activityVo.funcId)
    end
end

-- 活动开启登录推送
function onActivityOpenHandler(self, msg)
    self.mMgr.ActivityManager:parseActivityOpenMsg(msg)
end

-- 活动关闭推送
function onActivityOverHandler(self, msg)
    self.mMgr.ActivityManager:parseActivityOverMsg(msg)
end

--- *s2c* 新手活动-入口开启 24250
function onActivityNoviceStartHandler(self, msg)
    self.mMgr.ActivityManager:parseActivityNoviceUpdateMsg(msg.end_time)
end



---  *s2c* 关注有礼面板信息 24215
function onActivitySubcribe_Panel_Handler(self, msg)
    self.mMgr.ActitvityExtraManager:parsenMsg(msg)
end

--- *s2c* 领取关注有礼奖励返回结果 24217
function onActivitySubcribe_Receiove_Handler(self, msg)
    if msg.result == 1 then
        self.mMgr.ActitvityExtraManager:updateMsg(msg)
    else
        gs.Message.Show("领取失败")
    end
end
----------------------------------------------------------

-- 签到界面关闭
function onSigninPanelClose(self)
    self:onActivityPromoOpenHandler()
end

-- 主界面打开完成
function onMainUIFinish(self)
    self.mMainUIFinish = true
    self:onActivityPromoOpenHandler()
end

-- 活动推介打开处理
function onActivityPromoOpenHandler(self, args)
    if self.mMgr.ActivityManager:getPromoIsShow() then
        return
    end

    local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.ACTIVITY_PROMO_SHOW)
    if isNotRemind then
        -- 今天不再提示
        return
    end

    if not self.mMainUIFinish then
        -- 主界面未准备好
        return
    end

    if dailyCheckIn.DailyCheckInManager:getIsSign() == false then
        -- 未签到，不弹
        return
    end
    self.mMgr.ActivityManager:setPromoIsShow(true)
    -- 首次回到主界面则会弹出 1元超值链接补给包推荐购买 （优先弹出签到，签到界面关闭后再弹出推广页），
    -- 若1元超值礼包已被购买则会弹出 首充弹窗界面，若首充已购买则会弹出月卡推荐界面，若月卡已激活则会弹出成长礼遇推荐购买界面
    print("=========================onActivityPromoOpenHandler")

    local finishCall = function ()
        if not recharge.RechargeManager:getIsBuyOneGift() then
            self:onOpenActivityPromo1Handler()
        elseif not firstCharge.FirstChargeManager:getIsReCharge() then
            GameDispatcher:dispatchEvent(EventName.OPEN_FIRSTCHARGE_PANEL, { isShowToggle = true })
        elseif not purchase.MonthCardManager:getIsBuyMonthlyed() and not purchase.MonthCardManager:getIsPurchased() then
            self:onOpenActivityPromo2Handler()
        elseif not purchase.GrowthFundManager:getIsGrowthFundMoney() then
            self:onOpenActivityPromo3Handler()
        end
    end

    if taptapAward.TaptapAwardManager:canOpenTaptapAwardPanel() then
        GameDispatcher:dispatchEvent(EventName.OPEN_TAPTAP_AWARD_PANEL,{finishCall = finishCall})
    else
        finishCall()
    end

end

----------------------------------------------------------

function onOpenActivityPanel(self, args)
    if not args then
        args = {}
    end
    if not args.type then
        if activity.ActivityConst:getTabList()[1] then
            args.type = activity.ActivityConst:getTabList()[1].page
        else
            gs.Message.Show("活动尚未开启")
            return
        end
    end
    if args.type and args.type == activity.ActivityConst.ACTIVITY_GROUTHFUND and purchase.GrowthFundManager:getIsGrowthFundOver() then
        gs.Message.Show("已全部领取")
        return
    end
    if self.mActivityPanel == nil then
        self.mActivityPanel = activity.ActivityPanel.new()
        self.mActivityPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPanel, self)
    end
    self.mActivityPanel:open(args)
end

function onDestroyActivityPanel(self)
    self.mActivityPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPanel, self)
    self.mActivityPanel = nil
end

---------------------------------活动推广--------------------------------------

-- 一元礼包
function onOpenActivityPromo1Handler(self, args)
    if self.mActivityPromoView1 == nil then
        self.mActivityPromoView1 = UI.new(activity.ActivityPromoView1)
        self.mActivityPromoView1:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPromo1Panel, self)
    end
    self.mActivityPromoView1:open(args)
end

function onDestroyActivityPromo1Panel(self)
    self.mActivityPromoView1:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPromo1Panel, self)
    self.mActivityPromoView1 = nil
end

-- 晶耀供给（月卡）
function onOpenActivityPromo2Handler(self, args)
    if self.mActivityPromoView2 == nil then
        self.mActivityPromoView2 = UI.new(activity.ActivityPromoView2)
        self.mActivityPromoView2:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPromo2Panel, self)
    end
    self.mActivityPromoView2:open(args)
end

function onDestroyActivityPromo2Panel(self)
    self.mActivityPromoView2:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPromo2Panel, self)
    self.mActivityPromoView2 = nil
end

-- 成长礼遇
function onOpenActivityPromo3Handler(self, args)
    if self.mActivityPromoView3 == nil then
        self.mActivityPromoView3 = UI.new(activity.ActivityPromoView3)
        self.mActivityPromoView3:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPromo3Panel, self)
    end
    self.mActivityPromoView3:open(args)
end

function onDestroyActivityPromo3Panel(self)
    self.mActivityPromoView3:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityPromo3Panel, self)
    self.mActivityPromoView3 = nil
end


-- 打开关注活动 微信界面
function onOpenActivityWeChatHandler(self, args)
    if self.mActivitySubscribe == nil then
        self.mActivitySubscribe = UI.new(activity.ActivitySubscribeWeChat)
        self.mActivitySubscribe:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityWeChatPanel, self)
    end
    self.mActivitySubscribe:open(args)
end

function onDestroyActivityWeChatPanel(self)
    self.mActivitySubscribe:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyActivityWeChatPanel, self)
    self.mActivitySubscribe = nil
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]