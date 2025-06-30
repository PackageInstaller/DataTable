module("doundless.DoundlessController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.REQ_DOUNDLESS_INFO, self.onReqDoundlessInfo,self)
    GameDispatcher:addEventListener(EventName.REQ_UPDATE_DOUNDLESS_INFO, self.onReqUpdateDoundlessInfo,self)
    

    GameDispatcher:addEventListener(EventName.OPEN_DOUNDLESS_PANEL, self.onOpenDoundlessPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DOUNDLESS_REWARD_PANEL, self.onOpenDoundlessRewardPanel, self)
    
    GameDispatcher:addEventListener(EventName.OPEN_DOUNDLESS_DISTURBANCE_PANEL, self.onOpenDoundlessDisturbancePanel, self)
    
    GameDispatcher:addEventListener(EventName.OPEN_DOUNDLESS_RANK_PANEL,self.onOpenDoundlessRankPanel,self)

    GameDispatcher:addEventListener(EventName.OPEN_DOUNDLESS_LOG_PANEL,self.onOpenDoundlessLogPanel,self)


    GameDispatcher:addEventListener(EventName.OPEN_DOUNDLESS_RESULT_PANEL,self.onOpenDoundlessResultPanel,self)
   
    GameDispatcher:addEventListener(EventName.CLOSE_ALL_DOUNDLESS_PANEL,self.closeAllDoundlessView,self)
    GameDispatcher:addEventListener(EventName.FIVE_RESET,self.closeAllDoundlessView,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_BOUNDLESS_CITY_PANEL = self.onDoundlessCityPanelHandler,
        SC_BOUNDLESS_CITY_SETTLE_PANEL = self.onDoundlessCitySettlePanelHandler,
        SC_BOUNDLESS_CITY_RED = self.onDoundlessCityRedHandler,
        SC_BOUNDLESS_CITY_UPDATE_PANEL = self.onUpdateDoundleeHandler,
    }
end

function onDoundlessCityPanelHandler(self,msg)
    doundless.DoundlessManager:onDoundlessInfo(msg)
end

function onDoundlessCitySettlePanelHandler(self,msg)
    doundless.DoundlessManager:onDoundlessSettleInfo(msg)
end

function onDoundlessCityRedHandler(self,msg)
    doundless.DoundlessManager:updateRed(msg)
end

function onUpdateDoundleeHandler(self,msg)
    doundless.DoundlessManager:onUpdateDoundlessInfo(msg)
end

function onReqDoundlessInfo(self)
    SOCKET_SEND(Protocol.CS_BOUNDLESS_CITY_PANEL,{},Protocol.SC_BOUNDLESS_CITY_PANEL)
end

function onReqUpdateDoundlessInfo(self)
    SOCKET_SEND(Protocol.CS_BOUNDLESS_CITY_UPDATE_PANEL,{},Protocol.SC_BOUNDLESS_CITY_UPDATE_PANEL)
    
end

function addViewToPool(self, cusView)
    table.insert(self.mMgr.mViewList, cusView)
end

function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mViewList, cusView)
end

function closeAllDoundlessView(self)
    for i = 1, #self.mMgr.mViewList do
        self.mMgr.mViewList[i]:close()
    end

    self.mMgr.mViewList = {}
end

function onOpenDoundlessPanel(self,args)
    if self.mDoundlessPanel == nil then
        self.mDoundlessPanel = doundless.DoundlessPanel.new()
        self.mDoundlessPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessHandler,self)
        self:addViewToPool(self.mDoundlessPanel)
    end
    self.mDoundlessPanel:open(args)
end

function onDestoryDoundlessHandler(self)
    self:removeViewToPool(self.mDoundlessPanel)
    self.mDoundlessPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessHandler,self)
    self.mDoundlessPanel = nil
end


function onOpenDoundlessRewardPanel(self,args)
    if not args then
        args = {}
    end

    if not args.type then
        args.type = doundless.WarType.Low
    end

    if self.mDoundlessRewardPanel == nil then
        self.mDoundlessRewardPanel = doundless.DoundlessRewardPanel.new()
        self.mDoundlessRewardPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessRewardPanelHandler,self)
        self:addViewToPool(self.mDoundlessRewardPanel)
    end
    self.mDoundlessRewardPanel:open(args)
end

function onDestoryDoundlessRewardPanelHandler(self)
    self:removeViewToPool(self.mDoundlessRewardPanel)
    self.mDoundlessRewardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessRewardPanelHandler,self)
    self.mDoundlessRewardPanel = nil
end

function onOpenDoundlessDisturbancePanel(self,args)
    if self.mDoundlessDisturbancePanel == nil then
        self.mDoundlessDisturbancePanel = doundless.DoundlessDisturbancePanel.new()
        self.mDoundlessDisturbancePanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessDisturbanceHandler,self)
        self:addViewToPool(self.mDoundlessDisturbancePanel)
    end
    self.mDoundlessDisturbancePanel:open(args)
end

function onDestoryDoundlessDisturbanceHandler(self)
    self:removeViewToPool(self.mDoundlessDisturbancePanel)
    self.mDoundlessDisturbancePanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessDisturbanceHandler,self)
    self.mDoundlessDisturbancePanel = nil
end

function onOpenDoundlessRankPanel(self,args)
    if self.mDoundlessRankPanel == nil then
        self.mDoundlessRankPanel = doundless.DoundlessRankPanel.new()
        self.mDoundlessRankPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessRankPanelHandler,self)
        self:addViewToPool(self.mDoundlessRankPanel)
    end
    self.mDoundlessRankPanel:open(args)
end

function onDestoryDoundlessRankPanelHandler(self)
    self:removeViewToPool(self.mDoundlessRankPanel)
    self.mDoundlessRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessRankPanelHandler,self)
    self.mDoundlessRankPanel = nil
end

function onOpenDoundlessLogPanel(self,args)
    if self.mDoundlessLogPanel == nil then
        self.mDoundlessLogPanel = doundless.DoundlessLogPanel.new()
        self.mDoundlessLogPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessLogPanelHandler,self)
        self:addViewToPool(self.mDoundlessLogPanel)
    end
    self.mDoundlessLogPanel:open(args)
end

function onDestoryDoundlessLogPanelHandler(self)
    self:removeViewToPool(self.mDoundlessLogPanel)
    self.mDoundlessLogPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessLogPanelHandler,self)
    self.mDoundlessLogPanel = nil
end

function onOpenDoundlessResultPanel(self,args)
    if self.mDoundlessResultPanel == nil then
        self.mDoundlessResultPanel = doundless.DoundlessResultPanel.new()
        self.mDoundlessResultPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessResultPanelHandler,self)
    end
    self.mDoundlessResultPanel:open(args)
end

function onDestoryDoundlessResultPanelHandler(self)
    self.mDoundlessResultPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryDoundlessResultPanelHandler,self)
    self.mDoundlessResultPanel = nil
end

return _M