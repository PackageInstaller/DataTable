-- @FileName:   RoundPrizeController.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-12-20 17:42:57
-- @Copyright:   (LY) 2024 锚点降临

module("game.roundPrizeTwo.RoundPrizeTwoController", Class.impl(Controller))

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
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.ROUNDPRIZE_OPENRULEPANEL_TWO, self.onOpenRoundPrizeRulePanelHandler, self)
    GameDispatcher:addEventListener(EventName.ROUNDPRIZE_OPENSHOPPANEL_TWO, self.onOpenRoundPrizeShopPanelHandler, self)
    GameDispatcher:addEventListener(EventName.ROUNDPRIZE_CLOSE_SHOWAWARDPANEL_TWO, self.onShowRewardClose, self)

    GameDispatcher:addEventListener(EventName.ROUNDPRIZE_ONREQPRIZE_TWO, self.onReqPrize, self)
    GameDispatcher:addEventListener(EventName.ROUNDPRIZE_ONREQGETREWARD_TWO, self.onReqGetReward, self)

    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.updateRed, self)

    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.updateRed, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.updateRed, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.updateRed, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 新年轮盘面板 24470
        SC_NEW_YEAR_TURNTABLE_PANEL2 = self.onReceiveMainPanMsg,
        --- *s2c* 新年轮盘抽奖 24472
        SC_NEW_YEAR_TURNTABLE_LOTTERY2 = self.onReceivePrizeHandler,
        --- *s2c* 领取累抽奖励 24474
        SC_NEW_YEAR_TURNTABLE_GAIN_ACC_AWARD2 = self.onReceiveGetRewardHandler,
    }
end

---------------------------------------------------------事件处理--------------------------------------------------
function updateRed(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_NEWYEAR_ROUNDPRIZE_TWO, false) then
        local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.RoundPrizeTwo)
        if activityVo and activityVo:getTimeRemaining() > 0 and activityVo:getIsCanOpen() then
            GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
            GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
        end
    end
end

function onShowRewardClose(self)
    if self.m_PrizeData then
        local main_info = roundPrizeTwo.RoundPrizeTwoManager:getMainInfo()
        main_info.acc_times = self.m_PrizeData.acc_times
        main_info.unlucky_times = self.m_PrizeData.unlucky_times

        self.m_PrizeData = nil

        GameDispatcher:dispatchEvent(EventName.ROUNDPRIZE_ONRECEIVEMAINPANMSG_TWO)
    end
end

---------------------------------------------------------响应--------------------------------------------------------------
--- *s2c* 新年轮盘面板 24470
function onReceiveMainPanMsg(self, msg)
    -- logAll(msg, "*s2c* 新年轮盘面板 24470")
    roundPrizeTwo.RoundPrizeTwoManager:parseMainInfo(msg)
    GameDispatcher:dispatchEvent(EventName.ROUNDPRIZE_ONRECEIVEMAINPANMSG_TWO)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CELEBRATION_RED_STATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
end

--- *s2c* 新年轮盘抽奖 24472
function onReceivePrizeHandler(self, msg)
    if msg.result == 0 then
        gs.Message.Show("抽奖失败！")
        self.m_OnPrizeing = false
        return
    end

    self.m_PrizeData = msg

    GameDispatcher:dispatchEvent(EventName.ROUNDPRIZE_ONRECEIVEPRIZEHANDLER_TWO, msg)

    self.m_OnPrizeing = false
end

--- *s2c* 领取累抽奖励 24474
function onReceiveGetRewardHandler(self, msg)
    if msg.result == 0 then
        gs.Message.Show("领取失败！")
        return
    end
end

--- *s2c* 兑换抽奖券 24476
function onReceiveExchangePropsHandler(self, msg)
    if msg.result == 0 then
        gs.Message.Show("兑换失败！")
        return
    end
end
---------------------------------------------------------请求--------------------------------------------------------------

--- *c2s* 新年轮盘抽奖 24471
function onReqPrize(self, times)
    if self.m_OnPrizeing then
        return
    end

    self.m_OnPrizeing = true
    -- logAll({times = times}, "*c2s* 新年轮盘抽奖 24471")
    SOCKET_SEND(Protocol.CS_NEW_YEAR_TURNTABLE_LOTTERY2, {times = times}, Protocol.SC_NEW_YEAR_TURNTABLE_LOTTERY2)
end

--- *c2s* 领取累抽奖励 24473
function onReqGetReward(self, times)
    -- logAll({times = times}, " *c2s* 领取累抽奖励 24473")

    SOCKET_SEND(Protocol.CS_NEW_YEAR_TURNTABLE_GAIN_ACC_AWARD2, {times = times}, Protocol.SC_NEW_YEAR_TURNTABLE_GAIN_ACC_AWARD2)
end

---------------------------------------------------------界面-------------------------------------------------------------
--打开信息
function onOpenRoundPrizeRulePanelHandler(self, args)
    if self.mRoundPrizeRulePanel == nil then
        self.mRoundPrizeRulePanel = UI.new(roundPrizeTwo.RoundPrizeRuleTwoPanel)
        self.mRoundPrizeRulePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoundPrizeRulePanelHandler, self)
    end
    self.mRoundPrizeRulePanel:open(args)
end

function onDestroyRoundPrizeRulePanelHandler(self)
    self.mRoundPrizeRulePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoundPrizeRulePanelHandler, self)
    self.mRoundPrizeRulePanel = nil
end

--打开信息
function onOpenRoundPrizeShopPanelHandler(self, args)
    if self.mRoundPrizeShopPanel == nil then
        self.mRoundPrizeShopPanel = UI.new(roundPrizeTwo.RoundPrizeShopTwoPanel)
        self.mRoundPrizeShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoundPrizeShopPanelHandler, self)
    end
    self.mRoundPrizeShopPanel:open(args)
end

function onDestroyRoundPrizeShopPanelHandler(self)
    self.mRoundPrizeShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRoundPrizeShopPanelHandler, self)
    self.mRoundPrizeShopPanel = nil
end

return _M
