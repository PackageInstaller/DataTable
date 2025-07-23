-- @FileName:   FieldExplorationController.lua
-- @Description:   荒野探索
-- @Author: ZDH
-- @Date:   2023-07-24 20:35:59
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.controller.FieldExplorationController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_FIELDEXPLORATIONMAINUI, self.onOpenFieldExplorationMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_FIELDEXPLORATIONDUPPANEL, self.onOpenFieldExplorationDupPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_FIELDEXPLORATIONDUPPANEL, self.onCloseFieldExplorationDupPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_FIELDEXPLORATIONMAPMAINUI, self.onOpenFieldExplorationMapMainUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_FIELDEXPLORATIONPAUSEPANEL, self.onOpenFieldExplorationPausePanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_FIELDEXPLORATIONSCENEUI, self.onOpenFieldExplorationSceneUI, self)
    GameDispatcher:addEventListener(EventName.CLOSE_FIELDEXPLORATIONSCENEUI, self.onCloseFieldExplorationSceneUI, self)

    GameDispatcher:addEventListener(EventName.OPEN_FIELDEXPLORATIONSETTLEMENTPANEL, self.onOpenFieldExplorationSettlementPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_FIELDEXPLORATIONSTARAWARDVIEW, self.onOpenFieldExplorationStarAwardView, self)

    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_REQSAVA_SCORE, self.onReqSavaDupScore, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_REA_GETSTARAWARD, self.onReqGetStarAward, self)
    -- GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_GAME_START, self.onReqStartGame, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 跑酷副本面板信息 18120
        SC_PARKOUR_PANEL = self.onReceiveAllInfoMsg,
        --- *s2c* 更新跑酷信息 18122
        SC_UPDATE_PARKOUR_INFO = self.onReceiveInfoMsg,
        --- *s2c* 奖励领取返回 18124
        SC_GAIN_PARKOUR_REWARD = self.onReceiveAwardMsg,
    }
end
---------------------------数据---------------------------------------
--- *s2c* 跑酷副本面板信息 18120
function onReceiveAllInfoMsg(self, msg)
    for _, v in pairs(msg.parkour_list) do
        self.mMgr:parseInfoMsg(v)
    end
    self.mMgr:parseAwardMsg(msg.gained_list)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--- *s2c* 更新跑酷信息 18122
function onReceiveInfoMsg(self, msg)
    if map.MapLoader:getCurSceneType() == MAP_TYPE.FIELD_EXPLORATION then
        local dup_id = msg.parkour_info.id
        local oldRecord = fieldExploration.FieldExplorationManager:getPlayerDupRecord(dup_id)
        local newRecord = msg.parkour_info.point
        GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONSETTLEMENTPANEL, {oldRecord = oldRecord, newRecord = newRecord, dup_id = dup_id})
    end

    self.mMgr:parseInfoMsg(msg.parkour_info)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--- *s2c* 奖励领取返回 18124
function onReceiveAwardMsg(self, msg)
    logAll(msg, "*s2c* 奖励领取返回 18124")
    if msg.result == 0 then
        gs.Message.Show("领取失败")
        return
    end

    self.mMgr:parseAwardMsg(msg.id_list)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

-- --开始游戏（后台打点记录用）
-- function onReqStartGame(self)
--     local dup_id = fieldExploration.FieldExplorationManager:getDupId()
--     SOCKET_SEND(Protocol.CS_START_PARKOUR, {dup_id = dup_id})
-- end

--- *c2s* 获取奖励 18123
function onReqGetStarAward(self, starAwardList)
    logAll(starAwardList, "*c2s* 获取奖励 18123")
    SOCKET_SEND(Protocol.CS_GAIN_PARKOUR_REWARD, {id_list = starAwardList})
end

--- *c2s* 通关跑酷玩法 18121
function onReqSavaDupScore(self, args)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(args.activity_id)
    if activityVo:getTimeRemaining() <= 0 then
        gs.Message.Show("活动已结束") --活动已结束

        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
        return
    end

    local isSave = true
    local point = 0

    local record = fieldExploration.FieldExplorationManager:getPlayerDupRecord(args.dup_id)

    local dupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(args.dup_id)
    if dupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Time_Over then
        if args.score <= 0 then
            isSave = false
        elseif args.score <= record then
            isSave = false
        end

        point = args.score
    elseif dupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Push_Box then
        if args.isPass then
            local starCount = fieldExploration.FieldExplorationManager:getPlayerDupStar(args.dup_id, args.gameTime)
            if starCount <= 0 then
                isSave = false
            end
        else
            isSave = false
        end

        point = args.gameTime
    elseif dupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.EventDie then
        point = 100
        isSave = true
        if record > 0 then
            isSave = false
        end
    end

    if not isSave then
        GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONSETTLEMENTPANEL, {oldRecord = record, newRecord = point, dup_id = args.dup_id})
        return
    end

    logAll({dup_id = args.dup_id, point = point}, "请求保存关卡星数,结算类型 = " .. dupConfigVo.settlement_type)
    SOCKET_SEND(Protocol.CS_PASS_PARKOUR, {dup_id = args.dup_id, point = point}, Protocol.SC_UPDATE_PARKOUR_INFO)
end

---------------------------UI相关--------------------------------------
-- 打开荒野探索主UI
function onOpenFieldExplorationMainUI(self, args)
    if self.mFieldExplorationMainUI == nil then
        self.mFieldExplorationMainUI = UI.new(fieldExploration.FieldExplorationMainUI)
        self.mFieldExplorationMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationMainUI, self)
    end
    self.mFieldExplorationMainUI:open(args)
end

-- ui销毁
function onDestroyFieldExplorationMainUI(self)
    self.mFieldExplorationMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationMainUI, self)
    self.mFieldExplorationMainUI = nil
end

-- 打开荒野探索挑战界面
function onOpenFieldExplorationDupPanel(self, args)
    if self.mFieldExplorationDupPanel == nil then
        self.mFieldExplorationDupPanel = UI.new(fieldExploration.FieldExplorationDupPanel)
        self.mFieldExplorationDupPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationDupPanel, self)
        self.mFieldExplorationDupPanel:open(args)
    else
        self.mFieldExplorationDupPanel:updateView(args)
    end
end

-- 关闭荒野探索挑战界面
function onCloseFieldExplorationDupPanel(self)
    if self.mFieldExplorationDupPanel then
        self.mFieldExplorationDupPanel:close()
    end
end

-- ui销毁
function onDestroyFieldExplorationDupPanel(self)
    self.mFieldExplorationDupPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationDupPanel, self)
    self.mFieldExplorationDupPanel = nil
end

-- 打开荒野探索地图界面
function onOpenFieldExplorationMapMainUI(self, args)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(args.activity_id)
    fieldExploration.FieldExplorationManager:setActivityId(activityVo.id)

    if activityVo:getTimeRemaining() <= 0 then
        gs.Message.Show("活动已结束") --活动已结束
        return
    end

    if self.mFieldExplorationMapMainUI == nil then
        local class = string.format("game/fieldExploration/view/FieldExplorationMapMainUI_%s", args.activity_id)
        self.mFieldExplorationMapMainUI = UI.new(class)

        self.mFieldExplorationMapMainUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationMapMainUI, self)
    end
    self.mFieldExplorationMapMainUI:open(args)
end

-- ui销毁
function onDestroyFieldExplorationMapMainUI(self)
    self.mFieldExplorationMapMainUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationMapMainUI, self)
    self.mFieldExplorationMapMainUI = nil
end

-- 打开荒野探索暂停界面
function onOpenFieldExplorationPausePanel(self, args)
    if self.mFieldExplorationPausePanel == nil then
        self.mFieldExplorationPausePanel = UI.new(fieldExploration.FieldExplorationPausePanel)
        self.mFieldExplorationPausePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationPausePanel, self)
    end
    self.mFieldExplorationPausePanel:open(args)
end

-- ui销毁
function onDestroyFieldExplorationPausePanel(self)
    self.mFieldExplorationPausePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationPausePanel, self)
    self.mFieldExplorationPausePanel = nil
end

-- 打开荒野探索场景战斗界面
function onOpenFieldExplorationSceneUI(self, args)
    if self.mFieldExplorationSceneUI == nil then
        self.mFieldExplorationSceneUI = UI.new(fieldExploration.FieldExplorationSceneUI)
        self.mFieldExplorationSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationSceneUI, self)
    end
    self.mFieldExplorationSceneUI:open(args)
end

-- 关闭荒野探索场景战斗界面
function onCloseFieldExplorationSceneUI(self)
    if self.mFieldExplorationSceneUI then
        self.mFieldExplorationSceneUI:close()
    end
end

-- ui销毁
function onDestroyFieldExplorationSceneUI(self)
    self.mFieldExplorationSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationSceneUI, self)
    self.mFieldExplorationSceneUI = nil
end

-- 打开荒野探索场景结算界面
function onOpenFieldExplorationSettlementPanel(self, args)
    if self.mFieldExplorationSettlementPanel == nil then
        local dupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(args.dup_id)
        local class = string.format("game/fieldExploration/view/FieldExplorationSettlementPanel_%s", dupConfigVo.settlement_type)
        self.mFieldExplorationSettlementPanel = UI.new(class)
        self.mFieldExplorationSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationSettlementPanel, self)
    end
    self.mFieldExplorationSettlementPanel:open(args)
end

-- ui销毁
function onDestroyFieldExplorationSettlementPanel(self)
    self.mFieldExplorationSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationSettlementPanel, self)
    self.mFieldExplorationSettlementPanel = nil
end

-- 打开荒野探索场景星级奖励界面
function onOpenFieldExplorationStarAwardView(self, args)
    if self.mFieldExplorationStarAwardView == nil then
        self.mFieldExplorationStarAwardView = UI.new(fieldExploration.FieldExplorationStarAwardView)
        self.mFieldExplorationStarAwardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationStarAwardView, self)
    end
    self.mFieldExplorationStarAwardView:open(args)
end

-- ui销毁
function onDestroyFieldExplorationStarAwardView(self)
    self.mFieldExplorationStarAwardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFieldExplorationStarAwardView, self)
    self.mFieldExplorationStarAwardView = nil
end

return _M
