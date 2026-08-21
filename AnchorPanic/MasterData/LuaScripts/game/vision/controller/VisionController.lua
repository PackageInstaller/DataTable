module("vision.VisionController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_VISION_PANEL, self.onOpenVisionPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_VISION_HERO_INFO_PANEL, self.onOpenVisionHeroInfoPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_VISION_RANK_PANEL, self.onOpenVisionRankPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_VISION_MIRROR_RANK_PANEL, self.onReqVisionMirrorRankPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_VISION_MIRROR_SETTLE, self.onReqVisionMirrorSettle, self)
   
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_VISION_MIRROR_PASS_DUP_PANEL = self.onVisionMirrorPassDupPanelHandler,
        SC_VISION_MIRROR_ALL_DUP_PANEL = self.onVisionMirrorAllDupPanelHandler,
        SC_VISION_MIRROR_RANK_PANEL = self.onVisionMirrorRankPanelHandler,
        SC_VISION_MIRROR_RED_POINT = self.onVisionMirrorRedPointHandler,
    }
end

function onVisionMirrorRedPointHandler(self, msg)
    self.mMgr:updateRed(msg)
end

function onVisionMirrorPassDupPanelHandler(self, msg)
    self.mMgr:parseVisionMirrorPassDupPanelMsg(msg)
end

function onVisionMirrorAllDupPanelHandler(self, msg)
    self.mMgr:parseVisionMirrorAllDupPanelMsg(msg)
end

function onVisionMirrorRankPanelHandler(self, msg)
    self.mMgr:parseVisionMirrorRankPanelMsg(msg)
    GameDispatcher:dispatchEvent(EventName.OPEN_VISION_RANK_PANEL)
end

function onReqVisionMirrorRankPanel(self)
    SOCKET_SEND(Protocol.CS_VISION_MIRROR_RANK_PANEL, {}, Protocol.SC_VISION_MIRROR_RANK_PANEL)
end

-- 通关层手动结算：发送 CS_VISION_MIRROR_SETTLE (19925) 给后端
function onReqVisionMirrorSettle(self)
    SOCKET_SEND(Protocol.CS_VISION_MIRROR_SETTLE, {})
end

function onReqVisionInfo(self)
end

function onReqUpdateVisionInfo(self)
end

function addViewToPool(self, cusView)
    table.insert(self.mMgr.mViewList, cusView)
end

function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mViewList, cusView)
end

function closeAllVisionView(self)
    for i = 1, #self.mMgr.mViewList do
        self.mMgr.mViewList[i]:close()
    end

    self.mMgr.mViewList = {}
end

function onOpenVisionPanel(self,args)
    -- 打开面板时自动清除镜像红点
    SOCKET_SEND(Protocol.CS_DEL_VISION_MIRROR_RED_POINT)
    if self.mVisionPanel == nil then
        self.mVisionPanel = vision.VisionPanel.new()
        self.mVisionPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryVisionHandler,self)
        self:addViewToPool(self.mVisionPanel)
    end
    self.mVisionPanel:open(args)
end

function onDestoryVisionHandler(self)
    self:removeViewToPool(self.mVisionPanel)
    self.mVisionPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryVisionHandler,self)
    self.mVisionPanel = nil
end

function onOpenVisionHeroInfoPanel(self, args)
    if self.mVisionHeroInfoPanel == nil then
        self.mVisionHeroInfoPanel = vision.VisionHeroInfoPanel.new()
        self.mVisionHeroInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryVisionHeroInfoHandler, self)
        self:addViewToPool(self.mVisionHeroInfoPanel)
    end
    self.mVisionHeroInfoPanel:open(args)
end

function onDestoryVisionHeroInfoHandler(self)
    self:removeViewToPool(self.mVisionHeroInfoPanel)
    self.mVisionHeroInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryVisionHeroInfoHandler, self)
    self.mVisionHeroInfoPanel = nil
end

function onOpenVisionRankPanel(self, args)
    if self.mVisionRankPanel == nil then
        self.mVisionRankPanel = vision.VisionRankPanel.new()
        self.mVisionRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryVisionRankPanelHandler, self)
        self:addViewToPool(self.mVisionRankPanel)
    end
    self.mVisionRankPanel:open(args)
end

function onDestoryVisionRankPanelHandler(self)
    self:removeViewToPool(self.mVisionRankPanel)
    self.mVisionRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryVisionRankPanelHandler, self)
    self.mVisionRankPanel = nil
end


return _M
