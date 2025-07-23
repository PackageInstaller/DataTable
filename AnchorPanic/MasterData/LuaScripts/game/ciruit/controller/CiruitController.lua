-- @FileName:   CiruitController.lua
-- @Description:   荒野探索
-- @Author: ZDH
-- @Date:   2023-07-24 20:35:59
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ciruit.controller.CiruitController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.CIRUIT_OPENSTAGEMAINUI, self.onOpenCiruitStageMainUI, self)
    GameDispatcher:addEventListener(EventName.CIRUIT_OPENDUPINFOPANEL, self.onOpenCiruitDupInfoPanel, self)
    GameDispatcher:addEventListener(EventName.CIRUIT_CLOSEDUPINFOPANEL, self.onCloseCiruitDupInfoPanel, self)

    GameDispatcher:addEventListener(EventName.CIRUIT_OPENSCENEUI, self.onOpenCiruitSceneUI, self)

    GameDispatcher:addEventListener(EventName.CIRUIT_REQ_PASSDUP, self.onReqPassDup, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        -- --- *s2c* 水管工人面板 18179
        SC_CIRCUIT_PANEL = self.onReceivePassDupMsg,
    }
end
---------------------------数据---------------------------------------
--- *s2c* 水管工面板信息 18179
function onReceivePassDupMsg(self, msg)
    -- logAll(msg, "*s2c* 水管工面板信息 18179")
    ciruit.CiruitManager:setPassDupId(msg.dup_list)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--- *c2s* 通关玩法 18180
function onReqPassDup(self, dupid)
    -- logAll(dupid, "*c2s* 通关玩法 18180 -- ")
    SOCKET_SEND(Protocol.CS_PASS_CIRCUIT, {dup_id = dupid})
end

-- 打开荒野探索场景星级奖励界面
function onOpenCiruitStageMainUI(self, args)
    if self.mCiruitStageMainUI == nil then
        self.mCiruitStageMainUI = UI.new(ciruit.CiruitStageMainUI)
        self.mCiruitStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCiruitStageMainUI, self)
    end
    self.mCiruitStageMainUI:open(args)
end

-- ui销毁
function onDestroyCiruitStageMainUI(self)
    self.mCiruitStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCiruitStageMainUI, self)
    self.mCiruitStageMainUI = nil
end

-- 打开荒野探索场景星级奖励界面
function onOpenCiruitDupInfoPanel(self, args)
    if self.mCiruitDupInfoPanel == nil then
        self.mCiruitDupInfoPanel = UI.new(ciruit.CiruitDupPanel)
        self.mCiruitDupInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCiruitDupInfoPanel, self)
        self.mCiruitDupInfoPanel:open(args)
    else
        self.mCiruitDupInfoPanel:updateView(args)
    end
end

-- 打开荒野探索场景星级奖励界面
function onCloseCiruitDupInfoPanel(self)
    if self.mCiruitDupInfoPanel then
        self.mCiruitDupInfoPanel:close()
    end
end

-- ui销毁
function onDestroyCiruitDupInfoPanel(self)
    self.mCiruitDupInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCiruitDupInfoPanel, self)
    self.mCiruitDupInfoPanel = nil
end

-- 打开荒野探索场景星级奖励界面
function onOpenCiruitSceneUI(self, args)
    if self.mCiruitSceneUI == nil then
        self.mCiruitSceneUI = UI.new(ciruit.CiruitSceneUI)
        self.mCiruitSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCiruitSceneUI, self)
        self.mCiruitSceneUI:open(args)
    else
        self.mCiruitSceneUI:refreshView(args)
    end
end

-- ui销毁
function onDestroyCiruitSceneUI(self)
    self.mCiruitSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCiruitSceneUI, self)
    self.mCiruitSceneUI = nil
end

return _M
