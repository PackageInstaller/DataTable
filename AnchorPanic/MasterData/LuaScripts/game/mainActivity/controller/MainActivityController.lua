--[[
-----------------------------------------------------
@filename       : mainActivity
@Description    : 活动控制器
@date           : 2023-5-22 15:43:34
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mainActivity.controller.MainActivityController', Class.impl(Controller))

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
    --请求签到
    GameDispatcher:addEventListener(EventName.REQ_MAINACTIVITY_SIGN, self.onReqSignHandler, self)
    --请求购买
    GameDispatcher:addEventListener(EventName.REQ_MAINACTIVITY_BUY, self.onReqShopButHandler, self)
    --请求领取任务奖励
    GameDispatcher:addEventListener(EventName.REQ_MAINACTIVITY_TASK_AWARD_RECEIVE, self.onReqTaskAwardReceiveHandler, self)
    --打开主题活动主界面
    GameDispatcher:addEventListener(EventName.OPEN_MAINACTIVITY_PANEL, self.onOpenMainActivityPanelHandler, self)
    --打开主题签到界面
    GameDispatcher:addEventListener(EventName.OPEN_MAINACTIVITY_SIGN_VIEW, self.onOpenMainActivitySignViewHandler, self)
    --打开主题活动 商店界面
    GameDispatcher:addEventListener(EventName.OPEN_MAINACTIVITYSHOP_PANEL, self.onOpenMainActivityShopPanelHandler, self)
    --打开主题活动 购买弹窗
    GameDispatcher:addEventListener(EventName.OPEN_MAINACTIVITY_SHOP_BUY_VIEW, self.onOpenMainActivityShopBuyViewHandler, self)
    --打开主题活动 任务界面
    GameDispatcher:addEventListener(EventName.OPEN_MAINACTIVITYTASK_PANEL, self.onOpenMainActivityTaskPanelHandler, self)

    --主界面关闭
    GameDispatcher:addEventListener(EventName.CLOSE_MAINACTIVITY_PANEL, self.onCloseMainActivityPanel, self)

    --活动开启
    GameDispatcher:addEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.onOpenActivityHandler, self)
    --关闭活动
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onCloseActivityHandler, self)

    --更新主界面红点状态
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updateMainUIRedState, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 面板信息 24216
        SC_ACTIVITY_SIGN_PANEL_INFO = self.onResActivitySignInfoHandler,

        --- *s2c* 活动商店信息 24270
        SC_ACTIVITY_SHOP_INFO = self.onRes_Activity_ShopInfo_Handler,
        --- *s2c* 活动商店购买商品 24272
        SC_ACTIVITY_SHOP_BUY = self.onRes_Activity_ShopBuy_Handler,

        --- *s2c* 活动任务面板 24280
        SC_ACTIVITY_TASK_PANEL = self.onRes_Activity_TaskPanel_Handler,
        --- *s2c* 活动任务领取任务奖励 24282
        SC_ACTIVITY_TASK_RECEIVE = self.onRes_Activity_TaskReceive_Handler,
        --- *s2c* 更新活动任务的任务进度 24283
        SC_ACTIVITY_TASK_UPDATE = self.onRes_Activity_TaskUpdate_Handler,
    }
end

function updateMainUIRedState(self)
    local isShowRed = false

    local dup_id = sandPlay.SandPlayManager:getMapId()
    if dup_id == nil then
        dup_id = sysParam.SysParamManager:getValue(SysParamType.SandPlayDupId)
    end

    if dup_id ~= 0 then
        local sceneConfigVo = sandPlay.SandPlayManager:getSceneConfigVo(dup_id)
        for j = 1, #sceneConfigVo.guideList do
            local data = sceneConfigVo.guideList[j]
            for i = 1, #data.activityList do
                local activity_id = data.activityList[i]
                if MainActivityConst.getActivityRedState(activity_id) then
                    isShowRed = true
                    break
                end
            end
        end

    else
        for _, btnVo in ipairs(MainActivityConst.getBtnList()) do
            if MainActivityConst.getActivityRedState(btnVo.activity_id) then
                isShowRed = true
                break
            end
        end

        if not isShowRed then ---下方小游戏的红点
            for _, activity_id in ipairs(MainActivityConst.bottomBtns) do
                if MainActivityConst.getActivityRedState(activity_id) then
                    isShowRed = true
                    break
                end
            end
        end
    end

    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_MAIN_ACTIVITY, isShowRed, funcopen.FuncOpenConst.FUNC_ID_MAIN_ACTIVITY_SIGN)
end

function onOpenActivityHandler(self, args)
    self:updateMainUIRedState()
end

--关闭活动的通知
function onCloseActivityHandler(self, args)
    for _, id in ipairs(args.closeList) do
        if id == activity.ActivityId.MainActivity then
            self:closeAllView()
        end
    end

    self:updateMainUIRedState()
end

--添加到活动页面
function addViewToPool(self, cusView)
    table.insert(self.mMgr.mActiveViewList, cusView)
end

--移除活动页面
function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mActiveViewList, cusView)
end

--关闭所有界面
function closeAllView(self)
    for i = 1, #self.mMgr.mActiveViewList do
        self.mMgr.mActiveViewList[i]:close()
    end
end

---------------------------------1,1活动签到界面-----------------------
function onOpenMainActivitySignViewHandler(self, args)
    if self.mMainActivitySignView == nil then
        self.mMainActivitySignView = mainActivity.MainActivitySignView.new()
        self.mMainActivitySignView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivitySignView, self)
        self:addViewToPool(self.mMainActivitySignView)
    end
    self.mMainActivitySignView:open(args)
end

function onDestroyMainActivitySignView(self)
    self:removeViewToPool(self.mMainActivitySignView)
    self.mMainActivitySignView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivitySignView, self)
    self.mMainActivitySignView = nil
end
---------------------------------1,1活动主界面-----------------------
function onOpenMainActivityPanelHandler(self)
    if self.mMainActivityPanel == nil then
        self.mMainActivityPanel = mainActivity.MainActivityPanel.new()
        self.mMainActivityPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityPanel, self)
        self:addViewToPool(self.mMainActivityPanel)
    end
    if self.mMainActivityPanel.isPop == 1 then
        self.mMainActivityPanel:restViewTime()
    else
        self.mMainActivityPanel:open()
    end
end

function onDestroyMainActivityPanel(self)
    self:removeViewToPool(self.mMainActivityPanel)
    self.mMainActivityPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityPanel, self)
    self.mMainActivityPanel = nil
end

function onCloseMainActivityPanel(self)
    if self.mMainActivityPanel then
        self.mMainActivityPanel:close()
    end
end
---------------------------------1,1活动 商店-----------------------
function onOpenMainActivityShopPanelHandler(self, args)
    if self.mMainActivityShopPanel == nil then
        self.mMainActivityShopPanel = mainActivity.MainActivityShopPanel.new()
        self.mMainActivityShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityShopPanel, self)
        self:addViewToPool(self.mMainActivityShopPanel)
    end
    self.mMainActivityShopPanel:open(args)
end

function onDestroyMainActivityShopPanel(self)
    self:removeViewToPool(self.mMainActivityShopPanel)
    self.mMainActivityShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityShopPanel, self)
    self.mMainActivityShopPanel = nil
end
---------------------------------1,1活动 购买弹窗-----------------------
function onOpenMainActivityShopBuyViewHandler(self, args)
    if self.mMainActivityShopBuyView == nil then
        self.mMainActivityShopBuyView = mainActivity.MainActivityShopBuyView.new()
        self.mMainActivityShopBuyView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityShopBuyView, self)
        self:addViewToPool(self.mMainActivityShopBuyView)
    end
    self.mMainActivityShopBuyView:open(args)
end

function onDestroyMainActivityShopBuyView(self)
    self:removeViewToPool(self.mMainActivityShopBuyView)
    self.mMainActivityShopBuyView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityShopBuyView, self)
    self.mMainActivityShopBuyView = nil
end
---------------------------------1,1活动 任务-----------------------
function onOpenMainActivityTaskPanelHandler(self, args)
    if self.mMainActivityTaskPanel == nil then
        self.mMainActivityTaskPanel = mainActivity.MainActivityTaskPanel.new()
        self.mMainActivityTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityTaskPanel, self)
        self:addViewToPool(self.mMainActivityTaskPanel)
    end
    self.mMainActivityTaskPanel:open(args)
end

function onDestroyMainActivityTaskPanel(self)
    self:removeViewToPool(self.mMainActivityTaskPanel)
    self.mMainActivityTaskPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityTaskPanel, self)
    self.mMainActivityTaskPanel = nil
end

---------------------------------1,1活动协议请求-----------------------
------ *c2s* 领取活动奖励 24215
function onReqSignHandler(self, daily)
    SOCKET_SEND(Protocol.CS_GAIN_ACTIVITY_SIGN_REWARD, {day = daily}, Protocol.SC_ACTIVITY_SIGN_PANEL_INFO)
end

--- *c2s* 活动商店购买商品 24271
function onReqShopButHandler(self, args)
    SOCKET_SEND(Protocol.CS_ACTIVITY_SHOP_BUY, {id = args.id, buy_times = args.purchaseTime})
end

--- *c2s* 活动任务领取任务奖励 24281
function onReqTaskAwardReceiveHandler(self, taskList)
    SOCKET_SEND(Protocol.CS_ACTIVITY_TASK_RECEIVE, {task_id_list = taskList})
end

---------------------------------1,1活动协议返回-----------------------
------ *s2c* 面板信息 24216
function onResActivitySignInfoHandler(self, args)
    mainActivity.MainActivityManager:parseActivitySignMsg(args)
end

--- *s2c* 活动 商店信息 24270
function onRes_Activity_ShopInfo_Handler(self, msg)
    mainActivity.MainActivityManager:parseShopMsg(msg)
end

--- *s2c* 活动 商店购买商品 24272  "结果，1：成功 0：失败"
function onRes_Activity_ShopBuy_Handler(self, msg)
    if msg.result == 1 then
        mainActivity.MainActivityManager:updateShopMsg(msg)
    else
        gs.Message.Show("购买失败")
    end
end

--- *s2c* 活动任务面板 24280
function onRes_Activity_TaskPanel_Handler(self, msg)
    mainActivity.MainActivityManager:parseTaskMsg(msg)
end

--- *s2c* 活动任务领取任务奖励 24282 "结果，1：成功 0：失败"
function onRes_Activity_TaskReceive_Handler(self, msg)
    if msg.result == 1 then
        mainActivity.MainActivityManager:onReceiveTaskAward(msg)
    else
        gs.Message.Show("领取失败")
    end
end

--- *s2c* 更新活动任务的任务进度 24283
function onRes_Activity_TaskUpdate_Handler(self, msg)
    mainActivity.MainActivityManager:updateTaskMsg(msg)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]
