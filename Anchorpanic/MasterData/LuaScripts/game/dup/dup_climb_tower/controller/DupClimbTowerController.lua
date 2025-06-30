module('dup/DupClimbTowerController', Class.impl(Controller))
--[[ 
    爬塔副本控制器
    @autor Jacob 
]]
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
    GameDispatcher:addEventListener(EventName.OPEN_CLIMB_TOWER_PANEL, self.__onOpenPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_CLIMB_TOWER_AREA_PANEL, self.__onOpenAreaPanelHandler, self)
    GameDispatcher:addEventListener(EventName.REC_CLIMB_TOWER_AWARD, self.onRecAward, self)

    GameDispatcher:addEventListener(EventName.OPEN_DEEP_TOWER_PANEL, self.__onOpenDeepPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DEEP_TOWER_DUP_PANEL, self.__onOpenDeepDupPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DEEP_TOWER_RANK, self.__onOpenDeepRankPanelHandler, self)
    
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.onBackToMainHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_CLIMB_TOWER_ROUND_END = self.onDupClimbTowerRoundEndMsg,
        SC_CLIMB_TOWER_GAIN_LIST = self.onHasRecAwardAreaID,
        SC_ELEMENT_TOWER_PANEL = self.onRecElementTowerInfo,
        SC_UPDATE_ELEMENT_TOWER = self.onUpdateElementTowerInfo,
    }
end

--- *s2c* 爬塔轮次结束 18008
function onDupClimbTowerRoundEndMsg(self, msg)
    self.mMgr:parseDupClimbTowerRoundEndMsg(msg)
end

--- *s2c* 爬塔轮次奖励列表 18010
function onHasRecAwardAreaID(self, msg)
    self.mMgr:parseDupClimbTowerAwardList(msg)
end

--- *s2c* 元素塔面板信息 19440
function onRecElementTowerInfo(self, msg)
    self.mMgr:parseMsgData(msg)
end

--- *s2c* 更新元素塔信息 19441
function onUpdateElementTowerInfo(self, msg)
    self.mMgr:updateMsgData(msg)
end

--- *c2s* 爬塔奖励领取请求
function onRecAward(self, args)
    SOCKET_SEND(Protocol.CS_CLIMB_TOWER_AWARD, {map_id = args.areaId})
end

function __onOpenPanelHandler(self)
    if self.gPanel == nil then
        self.gPanel = dup.DupClimbTowerPanel.new()
        self.gPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.gPanel:open()
end

function __onOpenAreaPanelHandler(self, cusVo)
    if self.gAreaPanel == nil then
        self.gAreaPanel = dup.DupClimbTowerDupPanel.new()
        self.gAreaPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAreaViewHandler, self)
    end
    self.gAreaPanel:open(cusVo)
end

-- ui销毁
function onDestroyAreaViewHandler(self)
    self.gAreaPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAreaViewHandler, self)
    self.gAreaPanel = nil
end
-- ui销毁
function onDestroyViewHandler(self)
    self.gPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.gPanel = nil
end

function __onOpenDeepPanelHandler(self)
    if not dup.DupClimbTowerManager.hasDeepData then
        local enterId = dup.DupClimbTowerManager:getDeepAreaData()[1].enterDup
        local dupName = _TT(dup.DupClimbTowerManager:getDeepDupVo(enterId).name)
        gs.Message.Show(_TT(24518, dupName))
        return
    end
    if self.gDeepPanel == nil then
        self.gDeepPanel = dup.DupClimbTowerDeepPanel.new()
        self.gDeepPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDeepViewHandler, self)
    end
    self.gDeepPanel:open()
end

function onDestroyDeepViewHandler(self)
    self.gDeepPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDeepViewHandler, self)
    self.gDeepPanel = nil
end

function __onOpenDeepDupPanelHandler(self, cusVo)
    if self.gDeepDupPanel == nil then
        self.gDeepDupPanel = dup.DupClimbTowerDeepDupPanel.new()
        self.gDeepDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDeepDupViewHandler, self)
    end
    self.gDeepDupPanel:open(cusVo)
end

function onDestroyDeepDupViewHandler(self)
    self.gDeepDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDeepDupViewHandler, self)
    self.gDeepDupPanel = nil
end

function __onOpenDeepRankPanelHandler(self)
    -- if self.gRankPanel == nil then
    --     self.gRankPanel = dup.DupClimbTowerRankPanel.new()
    --     self.gRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankViewHandler, self)
    -- end
    -- self.gRankPanel:open()
end

function onDestroyRankViewHandler(self)
    self.gRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankViewHandler, self)
    self.gRankPanel = nil
end

function onBackToMainHandler(self)
    if(dup.DupClimbTowerManager.isInElementFight) then 
        dup.DupClimbTowerManager.backToMain = true
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
