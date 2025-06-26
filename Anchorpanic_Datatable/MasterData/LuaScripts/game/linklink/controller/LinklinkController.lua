-- @FileName:   LinklinkController.lua
-- @Description:  连连看
-- @Author: ZDH
-- @Date:   2023-07-24 20:35:59
-- @Copyright:   (LY) 2023 雷焰网络

module('game.linklink.controller.LinklinkController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.LINKLINK_OPEN_STAGEMAINUI, self.onOpenLinklinkStageMainUI, self)
    GameDispatcher:addEventListener(EventName.LINKLINK_OPEN_SCENEUI, self.onOpenLinklinkSceneUI, self)
    GameDispatcher:addEventListener(EventName.LINKLINK_CLOSE_SCENEUI, self.onCloseLinklinkSceneUI, self)

    GameDispatcher:addEventListener(EventName.LINKLINK_OPEN_DUPPANEL, self.onOpenLinklinkDupPanel, self)
    GameDispatcher:addEventListener(EventName.LINKLINK_CLOSE_DUPPANEL, self.onCloseLinklinkDupPanel, self)

    GameDispatcher:addEventListener(EventName.LINKLINK_OPEN_SETTLEMENTPANEL, self.onOpenLinklinkSettlementPanel, self)
    GameDispatcher:addEventListener(EventName.LINKLINK_OPEN_STARAWARDVIEW, self.onOpenLinklinkStarAwardView, self)

    GameDispatcher:addEventListener(EventName.ONREQ_LINKLINK_PASS_DUP, self.onReqPassDup, self)
    GameDispatcher:addEventListener(EventName.ONREQ_LINKLINK_GET_AWARD, self.onReqgetAward, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_LINKLINK_PANEL = self.onReceiveMainPanMsg,
        SC_LINKLINK_PASS_DUP = self.onReceivePassDupMsg,

    }
end
---------------------------数据---------------------------------------
-- *s2c* 羊了个羊面板 18220
function onReceiveMainPanMsg(self, msg)
    logAll(msg, "*s2c* 连连看面板 18220")
    linklink.LinklinkManager:setPassDupId(msg.dup_list)
    linklink.LinklinkManager:setAwardList(msg.star_reward_list)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_LINKLINK_DATA_REFRESH)
end

--- *s2c* 羊了个羊-过关-返回 18202
function onReceivePassDupMsg(self, msg)
    logAll(msg, "*s2c* 连连看-过关-返回 182222")
    local old_star = linklink.LinklinkManager:getDupPassStar(msg.dup_id)
    GameDispatcher:dispatchEvent(EventName.LINKLINK_OPEN_SETTLEMENTPANEL, {dupId = msg.dup_id, first = old_star == 0})
end

--- *c2s* 羊了个羊-过关 18201
function onReqPassDup(self, args)
    local oldStar_count = linklink.LinklinkManager:getDupPassStar(args.dup_id)
    if args.star <= 0 or args.star <= oldStar_count then
        GameDispatcher:dispatchEvent(EventName.LINKLINK_OPEN_SETTLEMENTPANEL, {dupId = args.dup_id, star = args.star})
        return
    end

    logAll(args, "*c2s* 连连看-过关 18221")
    SOCKET_SEND(Protocol.CS_LINKLINK_PASS_DUP, {dup_id = args.dup_id, star = args.star})
end

--- *c2s* 获取奖励 18123
function onReqgetAward(self, list)
    logAll(list, "  *c2s* 连连看-收取星星奖励 18223")
    SOCKET_SEND(Protocol.CS_LINKLINK_RECEIVE_STAR, {star_reward_id = list})
end

---------------------------界面---------------------------------------

-- 打开荒野探索场景星级奖励界面
function onOpenLinklinkStageMainUI(self, args)
    if self.mLinklinkStageMainUI == nil then
        self.mLinklinkStageMainUI = UI.new(linklink.LinklinkStageMainUI)
        self.mLinklinkStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkStageMainUI, self)

        self.mLinklinkStageMainUI:open(args)
    end
end
-- ui销毁
function onDestroyLinklinkStageMainUI(self)
    self.mLinklinkStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkStageMainUI, self)
    self.mLinklinkStageMainUI = nil
end

function onOpenLinklinkSceneUI(self, args)
    if self.mLinklinkSceneUI == nil then
        self.mLinklinkSceneUI = UI.new(linklink.LinklinkSceneUI)
        self.mLinklinkSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkSceneUI, self)

        self.mLinklinkSceneUI:open(args)
    else
        self.mLinklinkSceneUI:refreshView(args)
    end
end

function onCloseLinklinkSceneUI(self, args)
    if self.mLinklinkSceneUI ~= nil then
        self.mLinklinkSceneUI:close()
    end
end
-- ui销毁
function onDestroyLinklinkSceneUI(self)
    self.mLinklinkSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkSceneUI, self)
    self.mLinklinkSceneUI = nil
end

function onOpenLinklinkDupPanel(self, args)
    if self.mLinklinkDupPanel == nil then
        self.mLinklinkDupPanel = UI.new(linklink.LinklinkDupPanel)
        self.mLinklinkDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkDupPanel, self)

        self.mLinklinkDupPanel:open(args)
    else
        self.mLinklinkDupPanel:updateView(args)
    end
end
function onCloseLinklinkDupPanel(self, args)
    if self.mLinklinkDupPanel ~= nil then
        self.mLinklinkDupPanel:close()
    end
end
-- ui销毁
function onDestroyLinklinkDupPanel(self)
    self.mLinklinkDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkDupPanel, self)
    self.mLinklinkDupPanel = nil
end

function onOpenLinklinkSettlementPanel(self, args)
    if self.mLinklinkSettlementPanel == nil then
        self.mLinklinkSettlementPanel = UI.new(linklink.LinklinkSettlementPanel)
        self.mLinklinkSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkSettlementPanel, self)

        self.mLinklinkSettlementPanel:open(args)
    end
end
-- ui销毁
function onDestroyLinklinkSettlementPanel(self)
    self.mLinklinkSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkSettlementPanel, self)
    self.mLinklinkSettlementPanel = nil
end

function onOpenLinklinkStarAwardView(self, args)
    if self.mLinklinkStarAwardView == nil then
        self.mLinklinkStarAwardView = UI.new(linklink.LinklinkStarAwardView)
        self.mLinklinkStarAwardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkStarAwardView, self)

        self.mLinklinkStarAwardView:open(args)
    end
end
-- ui销毁
function onDestroyLinklinkStarAwardView(self)
    self.mLinklinkStarAwardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLinklinkStarAwardView, self)
    self.mLinklinkStarAwardView = nil
end

return _M
