-- @FileName:   ThreeSheepController.lua
-- @Description:   羊了又羊
-- @Author: ZDH
-- @Date:   2023-07-24 20:35:59
-- @Copyright:   (LY) 2023 雷焰网络

module('game.threeSheep.controller.ThreeSheepController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.THREESHEEP_OPEN_STAGEMAINUI, self.onOpenThreeSheepStageMainUI, self)
    GameDispatcher:addEventListener(EventName.THREESHEEP_OPEN_SCENEUI, self.onOpenThreeSheepSceneUI, self)
    GameDispatcher:addEventListener(EventName.THREESHEEP_CLOSE_SCENEUI, self.onCloseThreeSheepSceneUI, self)

    GameDispatcher:addEventListener(EventName.THREESHEEP_OPEN_DUPPANEL, self.onOpenThreeSheepDupPanel, self)
    GameDispatcher:addEventListener(EventName.THREESHEEP_CLOSE_DUPPANEL, self.onCloseThreeSheepDupPanel, self)

    
    GameDispatcher:addEventListener(EventName.THREESHEEP_OPEN_SETTLEMENTPANEL, self.onOpenThreeSheepSettlementPanel, self)
    GameDispatcher:addEventListener(EventName.THREESHEEP_OPEN_STARAWARDVIEW, self.onOpenThreeSheepStarAwardView, self)

    GameDispatcher:addEventListener(EventName.ONREQ_THREESHEEP_PASS_DUP, self.onReqPassDup, self)
    GameDispatcher:addEventListener(EventName.ONREQ_THREESHEEP_GET_AWARD, self.onReqgetAward, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_THREE_TILES_PANEL = self.onReceiveMainPanMsg,
        --- *s2c* 羊了个羊-过关-返回 18202
        SC_THREE_TILES_PASS_DUP = self.onReceivePassDupMsg,

    }
end
---------------------------数据---------------------------------------
-- *s2c* 羊了个羊面板 18200
function onReceiveMainPanMsg(self, msg)
    -- logAll(msg, "*s2c*  羊了个羊面板 18200")
    threeSheep.ThreeSheepManager:setPassDupId(msg.dup_list)
    threeSheep.ThreeSheepManager:setAwardList(msg.star_reward_list)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
    GameDispatcher:dispatchEvent(EventName.ONRECEIVE_THREESHEEP_DATA_REFRESH)
end

--- *s2c* 羊了个羊-过关-返回 18202
function onReceivePassDupMsg(self, msg)
    -- logAll(msg, "--- *s2c* 羊了个羊-过关-返回 18202")
    local old_star = threeSheep.ThreeSheepManager:getDupPassStar(msg.dup_id)
    GameDispatcher:dispatchEvent(EventName.THREESHEEP_OPEN_SETTLEMENTPANEL, {dupId = msg.dup_id, first = old_star == 0})
end

--- *c2s* 羊了个羊-过关 18201
function onReqPassDup(self, args)
    -- logAll(args, "*c2s* 羊了个羊-过关 18201")
    SOCKET_SEND(Protocol.CS_THREE_TILES_PASS_DUP, {dup_id = args.dup_id, star = args.star})
end

--- *c2s* 获取奖励 18123
function onReqgetAward(self, list)
    -- logAll(list, "*c2s* 羊了个羊-收取星星奖励 18203")
    SOCKET_SEND(Protocol.CS_THREE_TILES_RECEIVE_STAR, {star_reward_id = list})
end

---------------------------界面---------------------------------------

-- 打开荒野探索场景星级奖励界面
function onOpenThreeSheepStageMainUI(self, args)
    if self.mThreeSheepStageMainUI == nil then
        self.mThreeSheepStageMainUI = UI.new(threeSheep.ThreeSheepStageMainUI)
        self.mThreeSheepStageMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepStageMainUI, self)

        self.mThreeSheepStageMainUI:open(args)
    end
end
-- ui销毁
function onDestroyThreeSheepStageMainUI(self)
    self.mThreeSheepStageMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepStageMainUI, self)
    self.mThreeSheepStageMainUI = nil
end

function onOpenThreeSheepSceneUI(self, args)
    if self.mThreeSheepSceneUI == nil then
        self.mThreeSheepSceneUI = UI.new(threeSheep.ThreeSheepSceneUI)
        self.mThreeSheepSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepSceneUI, self)

        self.mThreeSheepSceneUI:open(args)
    else
        self.mThreeSheepSceneUI:refreshView(args)
    end
end

function onCloseThreeSheepSceneUI(self, args)
    if self.mThreeSheepSceneUI ~= nil then
        self.mThreeSheepSceneUI:close()
    end
end
-- ui销毁
function onDestroyThreeSheepSceneUI(self)
    self.mThreeSheepSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepSceneUI, self)
    self.mThreeSheepSceneUI = nil
end

function onOpenThreeSheepDupPanel(self, args)
    if self.mThreeSheepDupPanel == nil then
        self.mThreeSheepDupPanel = UI.new(threeSheep.ThreeSheepDupPanel)
        self.mThreeSheepDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepDupPanel, self)

        self.mThreeSheepDupPanel:open(args)
    else
        self.mThreeSheepDupPanel:updateView(args)
    end
end
function onCloseThreeSheepDupPanel(self, args)
    if self.mThreeSheepDupPanel ~= nil then
        self.mThreeSheepDupPanel:close()
    end
end
-- ui销毁
function onDestroyThreeSheepDupPanel(self)
    self.mThreeSheepDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepDupPanel, self)
    self.mThreeSheepDupPanel = nil
end

function onOpenThreeSheepSettlementPanel(self, args)
    if self.mThreeSheepSettlementPanel == nil then
        self.mThreeSheepSettlementPanel = UI.new(threeSheep.ThreeSheepSettlementPanel)
        self.mThreeSheepSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepSettlementPanel, self)

        self.mThreeSheepSettlementPanel:open(args)
    end
end
-- ui销毁
function onDestroyThreeSheepSettlementPanel(self)
    self.mThreeSheepSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepSettlementPanel, self)
    self.mThreeSheepSettlementPanel = nil
end

function onOpenThreeSheepStarAwardView(self, args)
    if self.mThreeSheepStarAwardView == nil then
        self.mThreeSheepStarAwardView = UI.new(threeSheep.ThreeSheepStarAwardView)
        self.mThreeSheepStarAwardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepStarAwardView, self)

        self.mThreeSheepStarAwardView:open(args)
    end
end
-- ui销毁
function onDestroyThreeSheepStarAwardView(self)
    self.mThreeSheepStarAwardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyThreeSheepStarAwardView, self)
    self.mThreeSheepStarAwardView = nil
end

return _M
