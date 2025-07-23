module("explore.ExploreController", Class.impl(Controller))

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


function getManager(self)
    return explore.ExploreManager
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_EXPLORE_PANEL, self.onOpenExplorePanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_EXPLOREPREPARE_PANEL,self.onOpenExplorePreparePanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_EXPLOREINFO_PANEL,self.onOpenExploreInfoPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_EXPLORE_SPEED_PANEL,self.onOpenExploreSpeedPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_EXPLORE_CANCEL_PANEL,self.onOpenExploreCancelPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_EXPLORE_SELECT_PANEL,self.onOpenExploreSelectPanel,self)
    

    GameDispatcher:addEventListener(EventName.REQ_START_ARENA_EXPLORE,self.onReqStartArenaExplore,self)
    GameDispatcher:addEventListener(EventName.REQ_CANCEL_ARENA_EXPLORE,self.onReqCancelArenaExplore,self)
    GameDispatcher:addEventListener(EventName.REQ_SPEEDUP_ARENA_EXPLORE,self.onReqSpeedUpArenaExplore,self)
    GameDispatcher:addEventListener(EventName.REQ_GAIN_ARENA_EXPLORE_AWARD,self.onReqGainArenaAward,self)
    GameDispatcher:addEventListener(EventName.REQ_REFLASH_EXPLORE,self.onReqFlashExplore,self)
end


------------------------------------------------------------------------ 请求 ------------------------------------------------------------------------
function onReqStartArenaExplore(self,msg)
    SOCKET_SEND(Protocol.CS_START_AREA_EXPLORE,{area_id = msg.id,hero_id_list = msg.list})
end

function onReqCancelArenaExplore(self,msg)
    SOCKET_SEND(Protocol.CS_CANCEL_AREA_EXPLORE,{area_id = msg.id})
end

function onReqSpeedUpArenaExplore(self,msg)
    SOCKET_SEND(Protocol.CS_SPEED_UP_AREA_EXPLORE,{area_id = msg.id})
end

function onReqGainArenaAward(self,msg)
    SOCKET_SEND(Protocol.CS_GAIN_AREA_EXPLORE_AWARD,{area_id = msg.id})
end

function onReqFlashExplore(self, msg)
    SOCKET_SEND(Protocol.CS_REFRESH_AREA_EVENT, {area_id = msg.id})
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 区域探险面板信息 21031
        SC_AREA_EXPLORE_PANEL_INFO = self.__onResExplorInfoHandler,
        --- *s2c* 开始区域探险结果返回 22023
        SC_START_AREA_EXPLORE_RESULT = self.__onResStartArenaExploreHandler,
        --- *s2c* 取消区域探险结果返回 22025
        SC_CANCEL_AREA_EXPLORE_RESULT = self.__onResCancelArenaExploreHandler,
        --- *s2c* 加速区域探险结果返回 22027
        SC_SPEED_UP_AREA_EXPLORE_RESULT = self.__onResSpeedUpArenaExploreHandler,
        --- *s2c* 领取区域探险奖励 22029
        SC_GAIN_AREA_EXPLORE_AWARD_RESULT = self.__onResGainArenaAwardHandler,
        --- *s2c* 刷新区域探索信息 21041
        SC_UPDATE_AREA_INFO = self.__onUpdateAreaInfo,
    }
end


------------------------------------------------------------------------ 响应 ------------------------------------------------------------------------

--- *s2c* 区域探险面板信息 21021
function __onResExplorInfoHandler(self, msg)
    explore.exploreManager:parseExploreMsg(msg)
end

--- *s2c* 开始区域探险结果返回 22023
function __onResStartArenaExploreHandler(self,msg)
    if msg.result == 1 then
        gs.Message.Show(_TT(40041))--"开始区域探险成功")
         GameDispatcher:dispatchEvent(EventName.UPDATE_EXPLORE,msg.area_id)
    GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)

    end

end

--- *s2c* 取消区域探险结果返回 22025
function __onResCancelArenaExploreHandler(self,msg)
    logInfo("取消区域探险结果返回 id".. msg.area_id.."结果:"..msg.result)
   
    if msg.result == 1 then
        gs.Message.Show(_TT(40042))--"取消区域探险成功")
        GameDispatcher:dispatchEvent(EventName.UPDATE_EXPLORE,msg.area_id)
    GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)

   end
end

--- *s2c* 加速区域探险结果返回 22027
function __onResSpeedUpArenaExploreHandler(self,msg)
    logInfo("加速区域探险结果返回 id".. msg.area_id.."结果:"..msg.result)

    if msg.result == 1 then
        --gs.Message.Show("加速区域探险成功")
        GameDispatcher:dispatchEvent(EventName.UPDATE_EXPLORE,msg.area_id)
    GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)

   end
end

function __onResGainArenaAwardHandler(self,msg)
    logInfo("领取区域探险结果返回 id".. msg.area_id.."结果:"..msg.result)

    if msg.result == 1 then
        --gs.Message.Show("领取区域探险成功")
        GameDispatcher:dispatchEvent(EventName.UPDATE_EXPLORE,msg.area_id)
    GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)

   end
end

--- *s2c* 刷新区域探索信息 21041
function __onUpdateAreaInfo(self, msg)
    explore.exploreManager:parseUpdateExploreMsg(msg)
end

------------------------------------------------------------------------ 探索界面 ------------------------------------------------------------------------
function onOpenExplorePanel(self)
    if self.mExplorePanel == nil then
        self.mExplorePanel = explore.explorePanel.new()
        self.mExplorePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyExplorePanelHandler, self)
    end
    self.mExplorePanel:open()
end

function onDestroyExplorePanelHandler(self)
    self.mExplorePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyExplorePanelHandler, self)
    self.mExplorePanel = nil
end

------------------------------------------------------------------------ 探索准备界面 ------------------------------------------------------------------------

function onOpenExplorePreparePanel(self, args)
    if self.mExplorePreparePanel == nil then
        self.mExplorePreparePanel = explore.explorePreparePanel.new()
        self.mExplorePreparePanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroyExplorePreparePanelHandler,
            self
        )
    end
    self.mExplorePreparePanel:open(args)
end

function onDestroyExplorePreparePanelHandler(self)
    self.mExplorePreparePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyExplorePreparePanelHandler, self)
    self.mExplorePreparePanel = nil
end

------------------------------------------------------------------------ 探索详情界面 ------------------------------------------------------------------------
function onOpenExploreInfoPanel(self,args)
    if self.mExploreInfoPanel == nil then
        self.mExploreInfoPanel = explore.exploreInfoPanel.new()
        self.mExploreInfoPanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroyExploreInfoPanelHandler,
            self
        )
    end
    self.mExploreInfoPanel:open()
    self.mExploreInfoPanel:show(args)
end

function onDestroyExploreInfoPanelHandler(self)
    self.mExploreInfoPanel:removeEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroyExploreInfoPanelHandler,
        self
    )
    self.mExploreInfoPanel = nil
end

------------------------------------------------------------------------ 探索加速界面 ------------------------------------------------------------------------

function onOpenExploreSpeedPanel(self,args)
    if self.mExploreSpeedPanel ==nil then
        self.mExploreSpeedPanel = explore.exploreSpeedPanel.new()
        self.mExploreSpeedPanel:addEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyExploreSpeedPanelHandler,
        self)
    end
    self.mExploreSpeedPanel:open(args)
end

function onDestroyExploreSpeedPanelHandler(self)
    self.mExploreSpeedPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
    self.onDestroyExploreSpeedPanelHandler,
    self)
    self.mExploreSpeedPanel = nil
end

------------------------------------------------------------------------ 探索战员选择界面 ------------------------------------------------------------------------

function onOpenExploreSelectPanel(self,args)
    if self.mExploreSelectPanel == nil then
        self.mExploreSelectPanel = explore.exploreSelectPanel.new()
        self.mExploreSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyExploreSelectPanelHandler,
        self)
    end
    self.mExploreSelectPanel:open({manager = self:getManager(),data = args})
end


function onDestroyExploreSelectPanelHandler(self)
    self.mExploreSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
    self.onDestroyExploreSelectPanelHandler,
    self)
    self.mExploreSelectPanel = nil
end
------------------------------------------------------------------------ 探索取消界面 ------------------------------------------------------------------------


function onOpenExploreCancelPanel(self,args)
    if self.mExploreCancelPanel == nil then
        self.mExploreCancelPanel = explore.exploreCancelPanel.new()
        self.mExploreCancelPanel:addEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyExploreCancelPanelHandler,
        self)
    end
    self.mExploreCancelPanel:open(args)
end

function onDestroyExploreCancelPanelHandler(self)
    self.mExploreCancelPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
    self.onDestroyExploreCancelPanelHandler,
    self)
    self.mExploreCancelPanel = nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
