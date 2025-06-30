module("seabed.SeabedController", Class.impl(Controller))
-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)

end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- 游戏开始的回调
function gameStartCallBack(self)
end

-- 模块间事件监听
function listNotification(self)

    GameDispatcher:addEventListener(EventName.REQ_ENTER_SEABED, self.onReqEnterSeabed, self)

    GameDispatcher:addEventListener(EventName.REQ_ABANDON_SEABED, self.onReqAbandonSeabed, self)

    GameDispatcher:addEventListener(EventName.REQ_SEABED_EVENT, self.onReqSeabedEventSeabed, self)

    GameDispatcher:addEventListener(EventName.REQ_SEABED_POSTWAR_SELECT, self.onReqSeabedPostwarSelect, self)

    GameDispatcher:addEventListener(EventName.REQ_SEABED_SHOP_BUY_ITEM, self.onReqSeabedShopItem, self)

    GameDispatcher:addEventListener(EventName.REQ_SEABED_SHOP_QUIT, self.onReqSeabedShopQuit, self)

    GameDispatcher:addEventListener(EventName.REQ_RESET_POSTAR_BUFF, self.onReqSeabedPostarBuff, self)

    GameDispatcher:addEventListener(EventName.REQ_SEABED_TASK_REWARD, self.onReqSeabedTaskReward, self)
    GameDispatcher:addEventListener(EventName.REQ_SEABED_STORY_AWARD, self.onReqSeabedStoryReward, self)

    GameDispatcher:addEventListener(EventName.REQ_SEABED_RANK_DATA, self.onReqSeabedRankList, self)

    GameDispatcher:addEventListener(EventName.REQ_SEABED_TALENT_UNLOCK, self.onReqSeabedTalentUnLock, self)
    GameDispatcher:addEventListener(EventName.REQ_SEABED_COLLECTION_AWARD_GET, self.onReqSeabedCollectionAward, self)

    GameDispatcher:addEventListener(EventName.CAN_SEABED_NEED_PANEL, self.onCanOpenSeabedPanel, self)

    GameDispatcher:addEventListener(EventName.SHOW_SEABED_TOP_PANEL, self.onShowSeabedPanel, self)

    GameDispatcher:addEventListener(EventName.CLOSE_SEABED_TOP_PANEL, self.onCloseSeabedTopPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_MAIN_PANEL, self.onOpenSeabedMainPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_LEVEL_PANEL, self.onOpenSeabedLevelPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_HERO_SELECT_PANEL, self.onOpenSeabedHeroSelectPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_SKILL_PANEL, self.onOpenSeabedSkillPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_MAP_PANEL, self.onOpenSeabedMapPanel, self)

    GameDispatcher:addEventListener(EventName.CLOSE_SEABED_MAP_PANEL, self.onCloseSeabedMapPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_OR_UPDATE_SEABED_MAP_PANEL, self.onOpenOrUpdateSeabedMapPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_BATTLE_BUFF, self.onOpenSeabedBattleBuffPanel, self)

    GameDispatcher:addEventListener(EventName.CLOSE_SEABED_BATTLE_BUFF, self.onCloseSeabedBattleBuffPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_SHOP_PANEL, self.onOpenSeabedShopPanel, self)

    GameDispatcher:addEventListener(EventName.CLOSE_SEABED_SHOP_PANEL, self.onCloseSeabedShopPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_BUFF_CHANGE_PANEL, self.onOpenSeabedBuffChangePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_SETTPANEL, self.onOpenSeabedSettPanel, self)

    GameDispatcher:addEventListener(EventName.OPEB_SEABED_SHOW_LAYER_PANEL, self.onOpenSeabedShowLayerPanel, self)

    GameDispatcher:addEventListener(EventName.CLOSE_SEABED_ALL_PANEL, self.closeAllSeabedPanel, self)

    -------------------------------------------opt----------------------------------------
    GameDispatcher:addEventListener(EventName.OPEN_SEABED_TASK_PANEL, self.onOpenSeabedTaskPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SEABED_TALENT_PANEL, self.onOpenSeabedTalentPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SEABED_TALENT_ALL_PANEL, self.onOpenSeabedTalentAllPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_COLLECTION_PANEL, self.onOpenSeabedShowroomPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SEABED_COLLECTION_AWARD_PANEL, self.onOpenSeabedCollectionAwardPanel,
        self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_STORY_PANEL, self.onOpenSeabedStoryPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SEABED_STORY_AWARD_PANEL, self.onOpenSeabedStoryAwardPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SEABED_RANK_PANEL, self.onOpenSeabedRankPanel, self)

    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_RED, self.onUpdateSeabedRed, self)

end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_SEABED_PREWAR_INFO = self.onSeabedPrewarInfo,

        SC_SEABED_RESOURCE_INFO = self.onSeabedResourceInfo,

        SC_SEABED_LINE_INFO = self.onSeabedLineInfo,

        SC_SEABED_UPDATE_CELL_INFO = self.onSeabedCellUpdataInfo,

        -- SC_SEABED_BATTLE_INFO = self.onSeabedBattleInfo,

        SC_SEABED_ADD_BUFF = self.onSeabedAddBuffInfo,

        SC_SEABED_DEC_BUFF = self.onSeabedDelectBuffInfo,

        SC_SEABED_ADD_COLLAGE = self.onSeabedAddCollageInfo,

        SC_SEABED_DEC_COLLAGE = self.onSeabedDelectCollageInfo,

        SC_SEABED_SETTLE_INFO = self.onSeabedSettleInfo,

        -- SC_SEABED_SETTLE_INFO = self.onSeabedSettle

        SC_SEABED_HISTORY_INFO = self.onSeabedHistoryInfo,

        SC_SEABED_BUY_GOODS = self.onSeabedBuyGoodsInfo,

        SC_SEABED_TASK_INFO = self.onSeabedTaskInfo,

        -- SC_SEABED_SHOP_INFO = self.onSeabedShopInfo,

        SC_SEABED_TASK_REWARD = self.onSeabedTaskRewardInfo,

        SC_UPDATE_SEABED_TASK_INFO = self.onSeabedTaskUpdateTaskInfo,

        SC_SEABED_STORY_LIST = self.onSeabedStoryListInfo,

        SC_SEABED_GAIN_SHOWROOM_REWARD = self.onSeabedStoryAwardInfo,

        SC_SEABED_RANK_PANEL = self.onSeabedRankListInfo,

        SC_SEABED_TALENT_INFO = self.onSeabedTalentInfo,

        SC_SEABED_UPDATE_TALENT_POINT = self.onSeabedTalentPointInfo,

        SC_SEABED_UNLOCK_TALENT = self.onSeabedUnlockTalentInfo,

        SC_SEABED_GAIN_COLLAGE_OR_BUFF_REWARD = self.onSeabedGainCollectionOrBuffRewardInfo
    }
end

function onUpdateSeabedRed(self, args)
    local isFlag = false
    isFlag = seabed.SeabedManager:getRedFlag()
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, isFlag,
        funcopen.FuncOpenConst.FUNC_ID_SEADED)
end

function onSeabedPrewarInfo(self, msg)
    seabed.SeabedManager:parseSeabedPrewarMsg(msg)
end

function onSeabedResourceInfo(self, msg)
    seabed.SeabedManager:parseSeabedResourceMsg(msg)
end

function onSeabedLineInfo(self, msg)
    seabed.SeabedManager:parseSeabedLineMsg(msg)
end

function onSeabedCellUpdataInfo(self, msg)
    seabed.SeabedManager:parseSeabedUpdateCellMsg(msg)
end

function onSeabedBattleInfo(self, msg)
    seabed.SeabedManager:parseSeabedBattleMsg(msg)
end

function onSeabedAddBuffInfo(self, msg)
    seabed.SeabedManager:parseSeabedAddBuffMsg(msg)
end

function onSeabedDelectBuffInfo(self, msg)
    seabed.SeabedManager:parseSeabedDelectBuffMsg(msg)
end

function onSeabedAddCollageInfo(self, msg)
    seabed.SeabedManager:parseSeabedAddCollectionMsg(msg)
end

function onSeabedDelectCollageInfo(self, msg)
    seabed.SeabedManager:parseSeabedDelectCollectionMsg(msg)
end

function onSeabedSettleInfo(self, msg)
    seabed.SeabedManager:parseSeabedSettleMsg(msg)
end

function onSeabedHistoryInfo(self, msg)
    seabed.SeabedManager:parseSeabedHistoryMsg(msg)
end

function onSeabedBuyGoodsInfo(self, msg)
    if msg.result == 1 then
        seabed.SeabedManager:parseSeabedBuyGoodsMsg(msg)
    end
end

function onSeabedTaskInfo(self, msg)
    seabed.SeabedManager:parseSeabedTaskMsg(msg)
end

function onSeabedTaskRewardInfo(self, msg)
    if msg.result == 1 then
        seabed.SeabedManager:parseSeabedTaskRewardMsg(msg)
    end
end

function onSeabedTaskUpdateTaskInfo(self, msg)
    seabed.SeabedManager:parseSeabedTaskMsgUpdate(msg)
end

function onSeabedStoryListInfo(self, msg)
    seabed.SeabedManager:parseSeabedStoryListMsg(msg)
end

function onSeabedStoryAwardInfo(self, msg)
    if msg.result == 1 then
        seabed.SeabedManager:parseSeabedStoryAwardMsg(msg)
    end
end

function onSeabedRankListInfo(self, msg)
    seabed.SeabedManager:parseSeabedRankListMsg(msg)
end

function onSeabedTalentInfo(self, msg)
    seabed.SeabedManager:parseSeabedTalentMsg(msg)
end

function onSeabedTalentPointInfo(self, msg)
    seabed.SeabedManager:parseSeabedTalentPointMsg(msg)
end

function onSeabedUnlockTalentInfo(self, msg)
    if msg.result == 1 then
        seabed.SeabedManager:parseSeabedUnlockTalentMsg(msg)
    end
end

function onSeabedGainCollectionOrBuffRewardInfo(self, msg)
    if msg.result == 1 then
        seabed.SeabedManager:parseSeabedGetCollectionOrBuffMsg(msg)
    end
end

function onReqEnterSeabed(self, args)
    SOCKET_SEND(Protocol.CS_PREPARE_ENTER_SEABED, {
        step = args.step,
        args = args.list
    }, Protocol.SC_SEABED_PREWAR_INFO)
end

function onReqAbandonSeabed(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_SETTLE, {}, Protocol.SC_SEABED_SETTLE_INFO)
end

function onReqSeabedEventSeabed(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_TRIGGER_EVENT, {
        cell_id = args.cellId,
        option_event = args.eventId
    }, Protocol.SC_SEABED_UPDATE_CELL_INFO)
end

function onReqSeabedPostwarSelect(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_POSTWAR_SELECT, {
        select_type = args.type,
        select_id = args.selectId
    }, Protocol.SC_SEABED_UPDATE_CELL_INFO)
end

function onReqSeabedShopItem(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_BUY_GOODS, {
        goods_id = args.goodsId
    }, Protocol.SC_SEABED_BUY_GOODS)
end

function onReqSeabedShopQuit(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_LEAVE_SHOP, {}, Protocol.SC_SEABED_UPDATE_CELL_INFO)
end

function onReqSeabedPostarBuff(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_POSTWAR_REFRESH_BUFF, {}, Protocol.SC_SEABED_UPDATE_CELL_INFO)
end

function onReqSeabedTaskReward(self, list)
    SOCKET_SEND(Protocol.CS_SEABED_TASK_REWARD, {
        task_ids = list
    }, Protocol.SC_SEABED_TASK_REWARD)
end

function onReqSeabedStoryReward(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_GAIN_SHOWROOM_REWARD, {
        id = args.id
    }, Protocol.SC_SEABED_GAIN_SHOWROOM_REWARD)
end

function onReqSeabedRankList(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_RANK_PANEL, {}, Protocol.SC_SEABED_RANK_PANEL)
end

function onReqSeabedTalentUnLock(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_UNLOCK_TALENT, {
        talent_id = args.id
    }, Protocol.SC_SEABED_UNLOCK_TALENT)
end

function onReqSeabedCollectionAward(self, args)
    SOCKET_SEND(Protocol.CS_SEABED_GAIN_COLLAGE_OR_BUFF_REWARD, {
        id = args.id
    }, Protocol.SC_SEABED_GAIN_COLLAGE_OR_BUFF_REWARD)
end

function closeAllSeabedPanel(self)
    -- self:onCloseSeabedTopPanel()
    for i = 1, #self.mMgr.mActiveViewList, 1 do
        self.mMgr.mActiveViewList[i]:close()
    end
    self.mMgr.mActiveViewList = {}
end

function addViewToPool(self, cusView)
    table.insert(self.mMgr.mActiveViewList, cusView)
end

function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mActiveViewList, cusView)
end

function onCanOpenSeabedPanel(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_ALL_PANEL)
    local step = seabed.SeabedManager:getSeabedCurStep()
    if step == seabed.SeabedStepType.Dif then
        GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_LEVEL_PANEL)
    elseif step == seabed.SeabedStepType.Skill then
        GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_SKILL_PANEL)
    elseif step == seabed.SeabedStepType.Finish then
        -- GameDispatcher:dispatchEvent(EventName.SHOW_SEABED_TOP_PANEL)
        -- GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_MAP_PANEL)

        local function openMapPanel()
            seabed.SeabedManager:setIsFirstShowMap()
            GameDispatcher:dispatchEvent(EventName.SHOW_SEABED_TOP_PANEL)
            GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_MAP_PANEL)
        end
        if seabed.SeabedManager:getNeedShowFirstLayer() then
            seabed.SeabedManager:resetNeedShowFirstLayer()
            GameDispatcher:dispatchEvent(EventName.OPEB_SEABED_SHOW_LAYER_PANEL, {
                callback = openMapPanel
            })
        else
            openMapPanel()
        end

    end
end

function onShowSeabedPanel(self, args)
    if self.mSeabedTopPanel == nil then
        self.mSeabedTopPanel = seabed.SeabedTopPanel.new()
        self.mSeabedTopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedTopPanel, self)
        self.mSeabedTopPanel:open(args)
    end
    self.mSeabedTopPanel:setActiveTopPanel(true)
end

function onHideSeabedTopPanel(self)
    if self.mSeabedTopPanel then
        self.mSeabedTopPanel:setActiveTopPanel(false)
    end
end

function onCloseSeabedTopPanel(self)
    if self.mSeabedTopPanel then
        self.mSeabedTopPanel:close()
    end
end

function onDestorySeabedTopPanel(self)
    self.mSeabedTopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedTopPanel, self)
    self.mSeabedTopPanel = nil
end

function updateOpenIsPass(self)
    -- local isPass = battleMap.MainMapManager:isStagePass(9086)
    local isPass = seabed.SeabedManager:getSeabedEndIsPass()
    seabed.SeabedManager:setOpenIsPass(isPass)
end

function onOpenSeabedMainPanel(self, args)
    self:updateOpenIsPass()
    if self.mSeabedMainPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedMainPanel = isEnd and seabed.SeabedMainPanel_end.new() or seabed.SeabedMainPanel.new()
        self.mSeabedMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedMainPanel, self)
    end
    self.mSeabedMainPanel:open(args)
end

function onDestorySeabedMainPanel(self)
    self.mSeabedMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedMainPanel, self)
    self.mSeabedMainPanel = nil
end

function onOpenSeabedLevelPanel(self, args)
    if self.mSeabedLevelPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedLevelPanel = isEnd and seabed.SeabedLevelPanel_end.new() or seabed.SeabedLevelPanel.new()
        self.mSeabedLevelPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedLevelPanel, self)
        self:addViewToPool(self.mSeabedLevelPanel)
    end
    self.mSeabedLevelPanel:open(args)
end

function onDestorySeabedLevelPanel(self)
    self:removeViewToPool(self.mSeabedLevelPanel)
    self.mSeabedLevelPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedLevelPanel, self)
    self.mSeabedLevelPanel = nil
end

function onOpenSeabedHeroSelectPanel(self, args)
    if self.mSeabedHeroSelectPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedHeroSelectPanel = isEnd and seabed.SeabedHeroSelectPanel_end.new() or
                                          seabed.SeabedHeroSelectPanel.new()
        self.mSeabedHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedHeroSelectPanel, self)
        self:addViewToPool(self.mSeabedHeroSelectPanel)
    end
    self.mSeabedHeroSelectPanel:open(args)
end

function onDestorySeabedHeroSelectPanel(self)
    self:removeViewToPool(self.mSeabedHeroSelectPanel)
    self.mSeabedHeroSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedHeroSelectPanel, self)
    self.mSeabedHeroSelectPanel = nil
end

function onOpenSeabedSkillPanel(self, args)
    if self.mSeabedSkillPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedSkillPanel = isEnd and seabed.SeabedSkillPanel_end.new() or seabed.SeabedSkillPanel.new()
        self.mSeabedSkillPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedSkillPanel, self)
        self:addViewToPool(self.mSeabedSkillPanel)
    end
    self.mSeabedSkillPanel:open(args)
end

function onDestorySeabedSkillPanel(self)
    self:removeViewToPool(self.mSeabedSkillPanel)
    self.mSeabedSkillPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedSkillPanel, self)
    self.mSeabedSkillPanel = nil
end

function onOpenSeabedMapPanel(self, args)
    if self.mSeabedMapPanel == nil then
        self.mSeabedMapPanel = seabed.SeabedMapPanel.new()
        self.mSeabedMapPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedMapPanel, self)
        self:addViewToPool(self.mSeabedMapPanel)
    end
    self.mSeabedMapPanel:open(args)
end

function onDestorySeabedMapPanel(self)
    self:removeViewToPool(self.mSeabedMapPanel)
    self.mSeabedMapPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedMapPanel, self)
    self.mSeabedMapPanel = nil
end

function onCloseSeabedMapPanel(self)
    if self.mSeabedMapPanel then
        self.mSeabedMapPanel:close()
    end
end

function onOpenOrUpdateSeabedMapPanel(self)
    if self.mSeabedMapPanel then
        self.mSeabedMapPanel:showPanel()
    else
        self:onOpenSeabedMapPanel()
    end
end

function onOpenSeabedBattleBuffPanel(self, args)
    if self.mSeabedBattleBuffPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedBattleBuffPanel = isEnd and seabed.SeabedBattleBuffPanel_end.new() or
                                          seabed.SeabedBattleBuffPanel.new()
        self.mSeabedBattleBuffPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedBattleBuffPanel, self)
        self:addViewToPool(self.mSeabedBattleBuffPanel)
    end
    self.mSeabedBattleBuffPanel:open(args)
end

function onDestorySeabedBattleBuffPanel(self)
    self:removeViewToPool(self.mSeabedBattleBuffPanel)
    self.mSeabedBattleBuffPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedBattleBuffPanel, self)
    self.mSeabedBattleBuffPanel = nil
end

function onCloseSeabedBattleBuffPanel(self)
    if self.mSeabedBattleBuffPanel then
        self.mSeabedBattleBuffPanel:close()
    end
end

function onOpenSeabedShopPanel(self, args)
    if self.mSeabedShopPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedShopPanel = isEnd and seabed.SeabedShopPanel_end.new() or seabed.SeabedShopPanel.new()
        self.mSeabedShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedShopPanel, self)
        self:addViewToPool(self.mSeabedShopPanel)
    end
    self.mSeabedShopPanel:open(args)
end

function onDestorySeabedShopPanel(self)
    self:removeViewToPool(self.mSeabedShopPanel)
    self.mSeabedShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedShopPanel, self)
    self.mSeabedShopPanel = nil
end

function onCloseSeabedShopPanel(self)
    if self.mSeabedShopPanel then
        self.mSeabedShopPanel:close()
    end
end

function onOpenSeabedBuffChangePanel(self, args)
    if self.mSeabedBuffChangePanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedBuffChangePanel = isEnd and seabed.SeabedBuffChangePanel_end.new() or
                                          seabed.SeabedBuffChangePanel.new()
        self.mSeabedBuffChangePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedBuffChangePanel, self)
        self:addViewToPool(self.mSeabedBuffChangePanel)
    end
    self.mSeabedBuffChangePanel:open(args)
end

function onDestorySeabedBuffChangePanel(self)
    self:removeViewToPool(self.mSeabedBuffChangePanel)
    self.mSeabedBuffChangePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedBuffChangePanel, self)
    self.mSeabedBuffChangePanel = nil
end

function onOpenSeabedSettPanel(self, args)
    if self.mSeabedSettPanel == nil then
        self.mSeabedSettPanel = seabed.SeabedSettPanel.new()
        self.mSeabedSettPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedSettPanel, self)
        -- self:addViewToPool(self.mSeabedSettPanel)
    end
    self.mSeabedSettPanel:open(args)
end

function onDestorySeabedSettPanel(self)
    self.mSeabedSettPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedSettPanel, self)
    self.mSeabedSettPanel = nil
end

function onOpenSeabedShowLayerPanel(self, args)
    if self.mSeabedShowLayerPanel == nil then
        self.mSeabedShowLayerPanel = seabed.SeabedShowLayerPanel.new()
        self.mSeabedShowLayerPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedShowLayerHandler, self)
    end
    self.mSeabedShowLayerPanel:setCallFinish(args.callback)
    self.mSeabedShowLayerPanel:open(args)
end

function onDestorySeabedShowLayerHandler(self)
    self.mSeabedShowLayerPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedShowLayerHandler, self)
    self.mSeabedShowLayerPanel = nil
end

function onOpenSeabedTaskPanel(self, args)
    if not args then
        args = {}
    end
    if not args.type then
        args.type = seabed.SeabedTaskType.Def
    end
    if self.mSeabedTaskPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedTaskPanel = isEnd and seabed.SeabedTaskPanel_end.new() or seabed.SeabedTaskPanel.new()
        self.mSeabedTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedTaskPanel, self)
    end
    self.mSeabedTaskPanel:open(args)
end

function onDestorySeabedTaskPanel(self)
    self.mSeabedTaskPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedTaskPanel, self)
    self.mSeabedTaskPanel = nil
end

function onOpenSeabedTalentPanel(self, args)
    if self.mSeabedTalentPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedTalentPanel = isEnd and seabed.SeabedTalentPanel_end.new() or seabed.SeabedTalentPanel.new()
        self.mSeabedTalentPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedTalentPanel, self)
    end
    self.mSeabedTalentPanel:open(args)
end

function onDestorySeabedTalentPanel(self)
    self.mSeabedTalentPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedTalentPanel, self)
    self.mSeabedTalentPanel = nil
end

function onOpenSeabedTalentAllPanel(self, args)
    if self.mSeabedTalentAllPanel == nil then
        self.mSeabedTalentAllPanel = seabed.SeabedTalentAllPanel.new()
        self.mSeabedTalentAllPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedTalentAllPanel, self)
    end
    self.mSeabedTalentAllPanel:open(args)
end

function onDestorySeabedTalentAllPanel(self)
    self.mSeabedTalentAllPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedTalentAllPanel, self)
    self.mSeabedTalentAllPanel = nil
end

function onOpenSeabedShowroomPanel(self, args)
    if not args then
        args = {}
    end
    if not args.type then
        args.type = seabed.SeabedBattleType.Collage
    end

    if self.mSeabedCollectionPanel == nil then
        self.mSeabedCollectionPanel = seabed.SeabedCollectionPanel.new()
        self.mSeabedCollectionPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedCollectionPanel, self)
    end
    self.mSeabedCollectionPanel:open(args)
end

function onDestorySeabedCollectionPanel(self)
    self.mSeabedCollectionPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedCollectionPanel, self)
    self.mSeabedCollectionPanel = nil
end

function onOpenSeabedCollectionAwardPanel(self, args)
    if self.mSeabedCollectionAwardPanel == nil then
        self.mSeabedCollectionAwardPanel = seabed.SeabedCollectionAwardPanel.new()
        self.mSeabedCollectionAwardPanel:addEventListener(View.EVENT_VIEW_DESTROY,
            self.onDestorySeabedCollectionAwardPanel, self)
    end
    self.mSeabedCollectionAwardPanel:open(args)
end

function onDestorySeabedCollectionAwardPanel(self)
    self.mSeabedCollectionAwardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestorySeabedCollectionAwardPanel, self)
    self.mSeabedCollectionAwardPanel = nil
end

function onOpenSeabedStoryPanel(self, args)
    if self.mSeabedStoryPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedStoryPanel = isEnd and seabed.SeabedStoryPanel_end.new() or seabed.SeabedStoryPanel.new()
        self.mSeabedStoryPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedStoryPanel, self)
    end
    self.mSeabedStoryPanel:open(args)
end

function onDestorySeabedStoryPanel(self)
    self.mSeabedStoryPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedStoryPanel, self)
    self.mSeabedStoryPanel = nil
end

function onOpenSeabedStoryAwardPanel(self)
    if self.mSeabedStoryAwardPanel == nil then
        self.mSeabedStoryAwardPanel = seabed.SeabedStoryAwardPanel.new()
        self.mSeabedStoryAwardPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedStoryAwardPanel, self)
    end
    self.mSeabedStoryAwardPanel:open()
end

function onDestorySeabedStoryAwardPanel(self)
    self.mSeabedStoryAwardPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedStoryAwardPanel, self)
    self.mSeabedStoryAwardPanel = nil
end

function onOpenSeabedRankPanel(self, args)
    if self.mSeabedRankPanel == nil then
        local isEnd = seabed.SeabedManager:getOpenIsPass()
        self.mSeabedRankPanel = isEnd and seabed.SeabedRankPanel_end.new() or seabed.SeabedRankPanel.new()
        self.mSeabedRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedRankPanel, self)
    end
    self.mSeabedRankPanel:open(args)
end

function onDestorySeabedRankPanel(self)
    self.mSeabedRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorySeabedRankPanel, self)
    self.mSeabedRankPanel = nil
end

return _M
