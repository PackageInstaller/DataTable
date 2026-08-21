module("mole.MoleController", Class.impl(Controller))
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
    GameDispatcher:addEventListener(EventName.OPEN_MOLE_GAME_PANEL, self.onOpenMoleGamePanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MOLE_GAME_PANEL, self.onCloseMoleGamePanel, self)

    
    GameDispatcher:addEventListener(EventName.OPEN_MOLE_STAGEMAIN_UI, self.onOpenMoleStageMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_MOLE_STAR_REWARD_PANEL, self.onOpenMoleStarRewardPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_MOLE_DUP_PANEL, self.onOpenMoleDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MOLE_DUP_PANEL, self.onCloseMoleDupPanel, self)
    
    GameDispatcher:addEventListener(EventName.OPEN_MOLE_SETTLE_PANEL, self.onOpenMoleSettlePanel, self)
    

    GameDispatcher:addEventListener(EventName.REQ_MOLE_PASS_DUP, self.onReqMolePassDupHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_MOLE_RECEIVE_STAR, self.onReqMoleReceiveHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_MOLE_TIPS_VIEW, self.onMoleTipsViewHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_MOLE_PANEL = self.onMolePanelHandler,
        SC_MOLE_PASS_DUP = self.onMolePassDupHandler,
    }
end

function onMolePanelHandler(self,msg)
    mole.MoleManager:parseMolePanelData(msg)
end

function onMolePassDupHandler(self,msg)
    mole.MoleManager:parseMolePassDupData(msg)
end

function onReqMolePassDupHandler(self,args)
    SOCKET_SEND(Protocol.CS_MOLE_PASS_DUP,{dup_id = args.dupId,star = args.star},Protocol.SC_MOLE_PASS_DUP)
end

function onReqMoleReceiveHandler(self,list)
    SOCKET_SEND(Protocol.CS_MOLE_RECEIVE_STAR,{star_reward_id = list})
end

function onOpenMoleGamePanel(self,args)
    --GM
    --GameDispatcher:dispatchEvent(EventName.OPEN_MOLE_GAME_PANEL)
    if self.mMoleGamePanel == nil then
        self.mMoleGamePanel = mole.MoleGamePanel.new()
        self.mMoleGamePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMoleGamePanel, self)
    end
    self.mMoleGamePanel:open(args)
end

function onDestoryMoleGamePanel(self)
    self.mMoleGamePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMoleGamePanel, self)
    self.mMoleGamePanel = nil
end

function onCloseMoleGamePanel(self)
    if self.mMoleGamePanel ~= nil then
        self.mMoleGamePanel:close()
    end
end

function onOpenMoleStageMainUI(self,args)
    if self.mMoleStageMainUI == nil then
        self.mMoleStageMainUI = mole.MoleStageMainUI.new()
        self.mMoleStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleStageMainUI, self)
    end
    self.mMoleStageMainUI:open(args)
end

-- ui销毁
function onDestroyMoleStageMainUI(self)
    self.mMoleStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleStageMainUI, self)
    self.mMoleStageMainUI = nil
end

function onOpenMoleStarRewardPanel(self,args)
    if self.mMoleStarRewardPanel == nil then
        self.mMoleStarRewardPanel = mole.MoleStarAwardView.new()
        self.mMoleStarRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleStarRewardPanel, self)
    end
    self.mMoleStarRewardPanel:open(args)
end

function onDestroyMoleStarRewardPanel(self)
    self.mMoleStarRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleStarRewardPanel, self)
    self.mMoleStarRewardPanel = nil
end

function onOpenMoleDupPanel(self,args)
    if self.mMoleDupPanel == nil then
        self.mMoleDupPanel = mole.MoleDupPanel.new()
        self.mMoleDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleDupPanel, self)
    end
    self.mMoleDupPanel:open(args)
end

function onDestroyMoleDupPanel(self)
    self.mMoleDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleDupPanel, self)
    self.mMoleDupPanel = nil
end

function onCloseMoleDupPanel(self)
    if self.mMoleDupPanel ~= nil then
        self.mMoleDupPanel:close()
    end
end

function onOpenMoleSettlePanel(self,args)
    if self.mMoleSettlePanel == nil then
        self.mMoleSettlePanel = mole.MoleSettlePanel.new()
        self.mMoleSettlePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleSettlePanel, self)
    end
    self.mMoleSettlePanel:open(args)
end

function onDestroyMoleSettlePanel(self)
    self.mMoleSettlePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleSettlePanel, self)
    self.mMoleSettlePanel = nil
    
end

function onMoleTipsViewHandler(self,args)
    if self.mMoleTipsView == nil then
        self.mMoleTipsView = mole.MoleTipsView.new()
        self.mMoleTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleTipsView, self)
    end
    self.mMoleTipsView:open(args)
end

function onDestroyMoleTipsView(self)
    self.mMoleTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoleTipsView, self)
    self.mMoleTipsView = nil
end

return _M