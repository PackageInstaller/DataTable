module("rogueLike.RogueLikeController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_MAIN_PANEL, self.onOpenRogueLikeMainPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_LEVEL_SELECT_PANEL, self.onOpenRogueLikeLevelSelectPanel, self)

    GameDispatcher:addEventListener(EventName.CLOSE_ROGUELIKE_LEVEL_SELECT_PANEL,self.onCloseRogueLikeLevelSelectPanel,self)
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_MAP_PANEL, self.onOpenRogueLikePanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_SCORE_TIPS, self.onOpenRogueLikeScorePanel, self)
    
    -- GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_CLOSE_VIEW,self.onOpenGougeLikeCloseView,self)
    --GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_FIGHT_INFO_PANEL, self.onOpenRogueLikeFightInfoPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_BUFF_SELECT_PANEL, self.onOpenRogueLikeBuffSelectPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_EVENT_SELECT_PANEL, self.onOpenRogueLikeEventSelectPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_SPECIAL_EVENT_PANEL, self.onOpenRogueLikeSpecialEventPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_SPECIAL_RESULT_PANEL, self.onOpenRogueLikeSpecialResultPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_SHOP_PANEL, self.onOpenRogueLikeShopPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_BUFF_REPLACE_PANEL, self.onOpenRogueLikeBuffReplacePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_SETT_PANEL, self.onOpenRogueLikeSettPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_PRE_DATA_PANEL,self.onOpenRogueLikePreDataPanel,self)

    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_PRE_BUFF_PANEL,self.onOpenRogueLikePreBuffPanel,self)
    
    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_TASK_PANEL, self.onOpenRogueLikeTaskPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_COLLECTION_PANEL, self.onOpenRogueLikeCollectionPanel, self)

    -- GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_FILTER_PANEL,self.onOpenRogueLikeFilterPanel,self)

    -- GameDispatcher:addEventListener(EventName.CLOSE_ROGUELIKE_FILTER_PANEL,self.onCloseRogueLikeFilterPanel,self)

    GameDispatcher:addEventListener(EventName.OPEN_ROGUELIKE_RANK_PANEL, self.onOpenRogueLikeRankPanel, self)

    -- 打开变更buff页面
    GameDispatcher:addEventListener(EventName.ROGUE_SHOW_CHANGE_BUFF, self.onOpenShowBuffPanel, self)
    ----------------------------------请求----------------------------------
    -- 开始肉鸽
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_START, self.onReqOpenRogueLike, self)
    -- 选中了地图
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_MAP_ENTER, self.onReqEnterMapCell, self)
    -- 选择buff
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SELECT_BUFF, self.onReqRogueLikeSelectBuff, self)
    -- 重置地图
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_RESET, self.onReqRogueLikeReset, self)
    -- 选择地图上的buff
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SELECT_MAP_BUFF, self.onReqRogueLikeMapBuff, self)
    -- 选择地图上的事件
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SELECT_EVENT, self.onReqRogueLikeEvent, self)
    -- 选择地图上的特殊事件
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SPECIAL_SELECT_EVENT, self.onReqRogueSpecialLikeEvent, self)
    -- 选择地图上的特殊事件确认
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SPECIAL_SURE_EVENT, self.onReqRogueSpecialLikeSureEvent, self)
    -- 请求打开商店
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SHOP_OPEN, self.onReqOpenShop, self)
    -- 请求关闭商店
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SHOP_CLOSE, self.onReqCloseShop, self)
    -- 购买商品
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SHOP_BUY, self.onReqBuyRogueShop, self)
    -- 出售商品
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SHOP_SELL, self.onReqSellRogueShop, self)
    -- 请求刷新商品
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SHOP_RESET, self.onReqResetRogueShop, self)
    -- 请求升级商店
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_SHOP_LEVEL_UP, self.onReqRogueShopLevelUp, self)
    -- 请求更新锁定状态
    GameDispatcher:addEventListener(EventName.REQ_UPDATE_SHOP_LOCK, self.onReqUpdateLockState, self)
    -- 请求升级BUFF上限
    GameDispatcher:addEventListener(EventName.REQ_LEVEL_UP_BUFF_LIMIT, self.onReqLevelUpBuffLimit, self)
    -- 请求领取肉鸽奖励
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_GAIN_TASK, self.onReqGainTask, self)
    -- 请求肉鸽收藏品数据
    GameDispatcher:addEventListener(EventName.REQ_ROGUE_COLLECTION, self.onReqCollection, self)

    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onCloseActivityHandler, self)

    GameDispatcher:addEventListener(EventName.RES_ROGUELIKE_ALL, self.onCloseActivityHandler, self)

  
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return { --- *s2c* 返回肉鸽地图信息 19301
    -- SC_ROGUELIKE_MAPS_INFO = self.__onRogueLikeMapInfoHanlder, --- *s2c* 肉鸽刷新信息 19302
    -- SC_ROGUELIKE_PANEL_INFO = self.__onRogueLikePanelHandler, --- *s2c* 返回肉鸽战员信息 19303
    -- SC_ROGUELIKE_HERO_INFO = self.__onRogueLikeHeroInfoHandler, --- *s2c* 肉鸽通关关卡后选择buff 19305
    -- SC_ROGUELIKE_PASS_GUARD = self.__onRogueMapBuffHandler, --- *s2c* 肉鸽格子触发事件 19309
    -- SC_ROGUELIKE_TRIGGER_EVENT = self.__onUpdateMapTriggerHandler, --- *s2c* 肉鸽商店信息 19310
    -- SC_ROGUELIKE_SHOP_INFO = self.__onUpdateShopHandler, --- *s2c* 肉鸽商店物品购买结果返回 19312
    -- SC_ROGUELIKE_SHOP_BUY = self.__onRogueBuyShopHandler, --- *s2c* 肉鸽商店出售结果返回 19314
    -- --SC_ROGUELIKE_SHOP_SELL = self.__onRougeSellShopHandler, --- *s2c* 肉鸽商店商品刷新结果返回 19316
    -- SC_ROGUELIKE_SHOP_REFRESH = self.__onRogueResetShopHandler, --- *s2c* 肉鸽商店升级结果返回 19318
    -- --SC_ROGUELIKE_SHOP_LEVEL_UP = self.__onRogueShopLevelUpHandler, --- *s2c* 返回扩展buff上限结果 19323
    -- --SC_ROGUELIKE_EXPAND_BUFF_LIMIT = self.__onExpandBuffLimitHandler, --- *s2c* 更新格子信息 19324
    -- SC_UPDATE_CELL_DATA = self.__onUpdateMapHandler, --- *s2c* 确认触发格子事件成功 19311
    -- SC_ROGUELIKE_CONFIRM_TRIGGER_EVENT = self.__onRogueLikeConfirmEvent, --- *s2c* 结算面板信息 19326
    -- SC_ROGUELIKE_SETTLE_PANEL = self.__onRogueLikeSettleHandler, --- *s2c* 肉鸽任务面板 19327
    -- SC_ROGUELIKE_TASK_PANEL = self.__onRogueLikeTaskHandler, --- *s2c* 肉鸽更新进度 19328
    -- SC_UPDATE_ROGUELIKE_TASK_INFO = self.__onRogueLikeTaskUpdateHandler, --- *s2c* 肉鸽奖励领取返回 19330
    -- SC_ROGUELIKE_GAIN_TASK_REWARD = self.__onRogueLikeGainHandler, --- *s2c* 肉鸽奖励领取返回 19332
    -- SC_ROGUELIKE_COLLECTION = self.__onRogueLikeCollectionHandler, 
    -- SC_ROGUELIKE_UPDATE_POINT = self.__onRogueLikeUpdatePointHandler,
    -- SC_PASS_ROGUELIKE_DIFFICULT = self.__onRogueLikeDifficultHandler, --- *s2c* 通关肉鸽难度 19337

    -- SC_ROGUELIKE_LAYER_STATS = self.__onRogueLikeLayerStatsHandler,--- *s2c* 通关每一层统计数据 19338
}
end

----------------------------------请求----------------------------------
-- 请求开始肉鸽
function onReqOpenRogueLike(self, args)
    SOCKET_SEND(Protocol.CS_ENTER_ROGUELIKE_MAP, {difficulty = args.level},Protocol.SC_ROGUELIKE_MAPS_INFO)
end

-- 肉鸽格子触发事件
function onReqEnterMapCell(self, args)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_TRIGGER_EVENT, {cell_id = args.id})
end

-- 请求重置地图
function onReqRogueLikeReset(self)
    SOCKET_SEND(Protocol.CS_RESET_ROGUELIKE)
end

-- --请求肉鸽战员信息
-- function onReqHeroInfo(self)
--     SOCKET_SEND(Protocol.SC_ROGUELIKE_HERO_INFO)
-- end

-- 请求选择buff 战斗内的
function onReqRogueLikeSelectBuff(self, args)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_SELECT_BUFF, {buff_id = args.buffId})
    self:onCloseRogueLikeGoodsSelectPanelHandler()
end

-- 请求选择buff
function onReqRogueLikeMapBuff(self, args)
    -- 后端需要做兼容处理
    local list = {}
    table.insert(list, args.buffId)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_CONFIRM_TRIGGER_EVENT, {cell_id = args.cellId, args = list})
    self:onCloseRoguleLikeBuffSelectPanelHandler()
end

-- 请求事件
function onReqRogueLikeEvent(self, args)
    -- 后端需要做兼容处理
    local list = {}
    table.insert(list, args.eventId)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_CONFIRM_TRIGGER_EVENT, {cell_id = args.cellId, args = list})
    self:onCloseRoguleLikeEventSelectPanelHandler()
end

-- 请求打开商店
function onReqOpenShop(self, args)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_SHOP_INFO, {cell_id = args.cellId})
end

-- 请求关闭商店
function onReqCloseShop(self, args)
    -- 后端需要做兼容处理
    self.onReqUpdateLockState()
    local list = {}
    table.insert(list, args.eventId)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_CONFIRM_TRIGGER_EVENT, {cell_id = args.cellId, args = list})
end

-- 请求特殊事件
function onReqRogueSpecialLikeEvent(self, args)
    -- 后端需要做兼容处理
    local list = {}
    table.insert(list, args.eventId)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_CONFIRM_TRIGGER_EVENT, {cell_id = args.cellId, args = list})
    -- self:onCloseRoguleLikeEventSelectPanelHandler()
end

-- 请求特殊事件结果确认
function onReqRogueSpecialLikeSureEvent(self, args)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_CONFIRM_TRIGGER_EVENT, {cell_id = args.cellId, args = {}})
end

-- 请求购买商品
function onReqBuyRogueShop(self, args)
    self.onReqUpdateLockState()
    SOCKET_SEND(Protocol.CS_ROGUELIKE_SHOP_BUY, {cell_id = args.cellId, groove_id = args.grooveId})
end

-- 请求出售商品
function onReqSellRogueShop(self, args)
    -- self.onReqUpdateLockState()
    -- -- 格式兼容处理
    -- local list = {}
    -- if args.list == nil then
    --     table.insert(list, args.goodsId)
    -- else
    --     list = args.list
    -- end

    -- SOCKET_SEND(Protocol.CS_ROGUELIKE_SHOP_SELL, {cell_id = args.cellId, goods_list = list})
end

-- 请求刷新商品
function onReqResetRogueShop(self, args)
    self.onReqUpdateLockState()
    SOCKET_SEND(Protocol.CS_ROGUELIKE_SHOP_REFRESH, {cell_id = args.cellId})
end

-- 请求升级商店
function onReqRogueShopLevelUp(self, args)
    self.onReqUpdateLockState()
    --SOCKET_SEND(Protocol.CS_ROGUELIKE_SHOP_LEVEL_UP, {cell_id = args.cellId})
end

-- 请求更新锁定状态
function onReqUpdateLockState(self)
    local updateDic = rogueLike.RogueLikeManager:getUpdateLockState()
    if updateDic ~= nil then
        local list = {}
        for id, data in pairs(updateDic) do
            table.insert(list, {groove_id = id, is_lock = data})
        end

        if #list == 0 then
            return
        end

        rogueLike.RogueLikeManager:clearLockState()
        local cellId = rogueLike.RogueLikeManager:getLastMapId()
        SOCKET_SEND(Protocol.CS_ROGUELIKE_SHOP_LOCK_GOODS, {cell_id = cellId, lock_goods_info = list})
    end
end

-- 请求升级BUFF上限
function onReqLevelUpBuffLimit(self)
    --SOCKET_SEND(Protocol.CS_ROGUELIKE_EXPAND_BUFF_LIMIT)
end

-- 请求领取任务奖励
function onReqGainTask(self, args)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_GAIN_TASK_REWARD, {task_list = args})
end

-- 请求收藏品数据
function onReqCollection(self, args)
    SOCKET_SEND(Protocol.CS_ROGUELIKE_COLLECTION)
end
----------------------------------响应----------------------------------
--- *s2c* 返回肉鸽地图信息 19301
function __onRogueLikeMapInfoHanlder(self, msg)
    rogueLike.RogueLikeManager:parseRogueLikeMap(msg)
end

--- *s2c* 肉鸽刷新信息 19302
function __onRogueLikePanelHandler(self, msg)
    rogueLike.RogueLikeManager:updateRougueLikeInfo(msg)
end

--- *s2c* 返回肉鸽战员信息 19303
function __onRogueLikeHeroInfoHandler(self, msg)
    rogueLike.RogueLikeManager:parseHeroInfo(msg)
end

--- *s2c* 肉鸽通关关卡后选择buff 19305
function __onRogueMapBuffHandler(self, msg)
    rogueLike.RogueLikeManager:setMapBuff(msg)
end

--- *s2c* 肉鸽格子触发事件 19309
function __onUpdateMapTriggerHandler(self, msg)
    rogueLike.RogueLikeManager:updateCurrentCell(msg)
end

--- *s2c* 肉鸽商店信息 19310
function __onUpdateShopHandler(self, msg)
    rogueLike.RogueLikeManager:parseShopData(msg)
end

--- *s2c* 肉鸽商店物品购买结果返回 19312
function __onRogueBuyShopHandler(self, msg)
    if msg.result == 1 then
        rogueLike.RogueLikeManager:updateShopDataByBuy(msg)
    else
        gs.Message.Show("购买buff失败")
    end
end

--- *s2c* 肉鸽商店出售结果返回 19314
function __onRougeSellShopHandler(self, msg)
    if msg.result == 1 then
        rogueLike.RogueLikeManager:updateShopDataBySell(msg)
    else
        gs.Message.Show("出售buff失败")
    end
end

--- *s2c* 肉鸽商店商品刷新结果返回 19316
function __onRogueResetShopHandler(self, msg)
    if msg.result == 1 then
        rogueLike.RogueLikeManager:updateShopDataByReset(msg)
    else
        gs.Message.Show("刷新商店失败")
    end
end

--- *s2c* 肉鸽商店升级结果返回 19318
function __onRogueShopLevelUpHandler(self, msg)
    if msg.result == 1 then
        rogueLike.RogueLikeManager:updateShopDataByLevelUp(msg)
    else
        gs.Message.Show("升级商店失败")
    end
end

--- *s2c* 返回扩展buff上限结果 19323
function __onExpandBuffLimitHandler(self, msg)
    if msg.result == 1 then
        rogueLike.RogueLikeManager:updateBuffLimit(msg)
    else
        gs.Message.Show("扩展buff上限失败")
    end
end

--- *s2c* 更新格子信息 19324
function __onUpdateMapHandler(self, msg)
    rogueLike.RogueLikeManager:updateMap(msg)
end

--- *s2c* 确认触发格子事件成功 19311
function __onRogueLikeConfirmEvent(self, msg)
    if msg.result == 1 then
        -- GameDispatcher:dispatchEvent(EventName.UPDATE_ROGUELIKE_SPECIAL_PANEL,{})--,{lateClose = true})
        self:onCloseRoguleLikeSpecialEventSelectPanelHandler()
        -- self:onCloseRoguleLikeEventSelectPanelHandler()
    else
    end
end

--- *s2c* 结算面板信息 19326
function __onRogueLikeSettleHandler(self, msg)
    rogueLike.RogueLikeManager:updateSettleData(msg)
end

--- *s2c* 肉鸽任务面板 19327
function __onRogueLikeTaskHandler(self, msg)
    rogueLike.RogueLikeManager:parseServerTaskData(msg)
end

--- *s2c* 肉鸽积分更新进度 19328
function __onRogueLikeTaskUpdateHandler(self, msg)
    rogueLike.RogueLikeManager:updateServerTaskData(msg)
end

--- *s2c* 肉鸽奖励领取返回 19330
function __onRogueLikeGainHandler(self, msg)
    rogueLike.RogueLikeManager:updateServerScoreData(msg)
end

--- *s2c* 肉鸽奖励领取返回 19332
function __onRogueLikeCollectionHandler(self, msg)
    rogueLike.RogueLikeManager:updateCollectionData(msg)
end

--- *s2c* 更新分数 19336
function __onRogueLikeUpdatePointHandler(self, msg)
    rogueLike.RogueLikeManager:updatePoint(msg)
end

function __onRogueLikeDifficultHandler(self,msg)
    rogueLike.RogueLikeManager:updateDifficultInfo(msg)
end

function __onRogueLikeLayerStatsHandler(self,msg)
    rogueLike.RogueLikeManager:updateRougueLikePreDataInfo(msg)
end
-------------------------------------------界面变动------------------------------------------------------------------
function addViewToPool(self, cusView)
    table.insert(self.mMgr.mActiveViewList, cusView)
end

function removeViewToPool(self, cusView)
    table.removebyvalue(self.mMgr.mActiveViewList, cusView)
end

function closeAllView(self)
    self.mMgr:resetDatas()
    LoopManager:addFrame(1,0,self,self.__onCloseView)
end

function __onCloseView(self)
    if #self.mMgr.mActiveViewList == 0 then
        LoopManager:removeFrame(self, self.__onCloseView)
        self.mMgr.mActiveViewList = {}
        return
    end

    local view = table.remove(self.mMgr.mActiveViewList, #self.mMgr.mActiveViewList)
    view:close()
end

function onCloseActivityHandler(self, args)
    self:closeAllView()
end

-------------------------------------------打开狗鸽主界面------------------------------------------------------------------

function onOpenRogueLikeMainPanel(self)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRogueLikeMainPanel == nil then
        self.mRogueLikeMainPanel = rogueLike.RogueLikeMainPanel.new()
        self.mRogueLikeMainPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
        self:addViewToPool(self.mRogueLikeMainPanel)
    end
    self.mRogueLikeMainPanel:open()
end

function onDestroyMainPanelHandler(self)
    self:removeViewToPool(self.mRogueLikeMainPanel)
    self.mRogueLikeMainPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainPanelHandler, self)
    self.mRogueLikeMainPanel = nil
end

-------------------------------------------打开狗鸽等级选择界面------------------------------------------------------------------
function onOpenRogueLikeLevelSelectPanel(self)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRogueLikeLevelSelectPanel == nil then
        self.mRogueLikeLevelSelectPanel = rogueLike.RogueLikeLevelSelectPanel.new()
        self.mRogueLikeLevelSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryLevelSelectPanelHandler, self)
        self:addViewToPool(self.mRogueLikeLevelSelectPanel)
    end
    self.mRogueLikeLevelSelectPanel:open()
end

function onDestoryLevelSelectPanelHandler(self)
    self:removeViewToPool(self.mRogueLikeLevelSelectPanel)
    self.mRogueLikeLevelSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryLevelSelectPanelHandler, self)
    self.mRogueLikeLevelSelectPanel = nil
end


function onCloseRogueLikeLevelSelectPanel(self)
    if self.mRogueLikeLevelSelectPanel then
        self.mRogueLikeLevelSelectPanel:close()
    end
end
-------------------------------------------打开狗鸽地图界面------------------------------------------------------------------

function onOpenRogueLikePanel(self)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mRogueLikePanel == nil then
        self.mRogueLikePanel = rogueLike.RogueLikeMapPanel.new()
        self.mRogueLikePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
        self:addViewToPool(self.mRogueLikePanel)
    end
    self.mRogueLikePanel:open()
end

function onDestroyPanelHandler(self)
    self:removeViewToPool(self.mRogueLikePanel)
    self.mRogueLikePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    self.mRogueLikePanel = nil
end

-------------------------------------------打开狗鸽积分界面------------------------------------------------------------------
function onOpenRogueLikeScorePanel(self)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRogueLikeScorePanel == nil then
        self.mRogueLikeScorePanel = rogueLike.RogueLikeScoreTips.new()
        self.mRogueLikeScorePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyScrorePanelHandler, self)
        self:addViewToPool(self.mRogueLikeScorePanel)
    end
    self.mRogueLikeScorePanel:open()
end

function onDestroyScrorePanelHandler(self)
    self:removeViewToPool(self.mRogueLikeScorePanel)
    self.mRogueLikeScorePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyScrorePanelHandler, self)
    self.mRogueLikeScorePanel = nil
end

---------------------------------------------战斗详情----------------------------------------------------------------

function onOpenRogueLikeFightInfoPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mRogueLikeFightInfoPanel == nil then
        self.mRogueLikeFightInfoPanel = rogueLike.RogueLikeFightInfoPanel.new()
        self.mRogueLikeFightInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFightInfoPanelHandler, self)
        self:addViewToPool(self.mRogueLikeFightInfoPanel)
    end
    self.mRogueLikeFightInfoPanel:open(args)
end

function onDestroyFightInfoPanelHandler(self)
    self:removeViewToPool(self.mRogueLikeFightInfoPanel)
    self.mRogueLikeFightInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFightInfoPanelHandler, self)
    self.mRogueLikeFightInfoPanel = nil
end

----------------------------------------------buff选择窗口---------------------------------------------------------------

function onOpenRogueLikeBuffSelectPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mRogueLikeBuffSelectPanel == nil then
        self.mRogueLikeBuffSelectPanel = rogueLike.RogueLikeBuffSelectPanel.new()
        self.mRogueLikeBuffSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuffSelectPanelHandler, self)
        self:addViewToPool(self.mRogueLikeBuffSelectPanel)
    end
    self.mRogueLikeBuffSelectPanel:open(args)
end

function onCloseRoguleLikeBuffSelectPanelHandler(self)
    if self.mRogueLikeBuffSelectPanel then
        self.mRogueLikeBuffSelectPanel:close()
    end
end

function onDestroyBuffSelectPanelHandler(self)
    self:removeViewToPool(self.mRogueLikeBuffSelectPanel)
    self.mRogueLikeBuffSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuffSelectPanelHandler, self)
    self.mRogueLikeBuffSelectPanel = nil
end

----------------------------------------------事件选择窗口---------------------------------------------------------------

function onOpenRogueLikeEventSelectPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    if self.mRogueLikeEventSelectPanel == nil then
        self.mRogueLikeEventSelectPanel = rogueLike.RogueLikeEventSelectPanel.new()
        self.mRogueLikeEventSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEventSelectPanelHandler, self)
        self:addViewToPool(self.mRogueLikeEventSelectPanel)
    end
    self.mRogueLikeEventSelectPanel:open(args)
end

function onDestroyEventSelectPanelHandler(self)
    self:removeViewToPool(self.mRogueLikeEventSelectPanel)
    self.mRogueLikeEventSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEventSelectPanelHandler, self)
    self.mRogueLikeEventSelectPanel = nil
end

function onCloseRoguleLikeEventSelectPanelHandler(self)
    if self.mRogueLikeEventSelectPanel then
        self.mRogueLikeEventSelectPanel:close()
    end
end

----------------------------------------------特殊事件选择窗口---------------------------------------------------------------
function onOpenRogueLikeSpecialEventPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRogueLikeSpecialEventSelectPanel == nil then
        self.mRogueLikeSpecialEventSelectPanel = rogueLike.RogueLikeSpecialEventSelectPanel.new()
        self.mRogueLikeSpecialEventSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEventSpecialSelectPanelHandler, self)
        self:addViewToPool(self.mRogueLikeSpecialEventSelectPanel)
    end
    self.mRogueLikeSpecialEventSelectPanel:open(args)
end

function onDestroyEventSpecialSelectPanelHandler(self)
    self:removeViewToPool(self.mRogueLikeSpecialEventSelectPanel)
    self.mRogueLikeSpecialEventSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEventSpecialSelectPanelHandler, self)
    self.mRogueLikeSpecialEventSelectPanel = nil
end

function onCloseRoguleLikeSpecialEventSelectPanelHandler(self)
    if self.mRogueLikeSpecialEventSelectPanel then
        self.mRogueLikeSpecialEventSelectPanel:close()
    end
end

----------------------------------------------特殊事件结果窗口---------------------------------------------------------------
function onOpenRogueLikeSpecialResultPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRogueLikeSpecialResultPanel == nil then
        self.mRogueLikeSpecialResultPanel = rogueLike.RogueLikeSpecialEventResultPanel.new()
        self.mRogueLikeSpecialResultPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySpecialResultPanelHandler, self)
        self:addViewToPool(self.mRogueLikeSpecialResultPanel)
    end
    self.mRogueLikeSpecialResultPanel:open(args)
end

function onDestroySpecialResultPanelHandler(self)
    self:removeViewToPool(self.mRogueLikeSpecialResultPanel)
    self.mRogueLikeSpecialResultPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySpecialResultPanelHandler, self)
    self.mRogueLikeSpecialResultPanel = nil
end
----------------------------------------------商店窗口---------------------------------------------------------------

function onOpenRogueLikeShopPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRoguelikeShopPanel == nil then
        self.mRoguelikeShopPanel = rogueLike.RogueLikeShopPanel.new()
        self.mRoguelikeShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopPanelHandler, self)
        self:addViewToPool(self.mRoguelikeShopPanel)
    end
    self.mRoguelikeShopPanel:open(args)
end

function onDestroyShopPanelHandler(self)
    self:removeViewToPool(self.mRoguelikeShopPanel)
    self.mRoguelikeShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShopPanelHandler, self)
    self.mRoguelikeShopPanel = nil
end

----------------------------------------------肉鸽结算---------------------------------------------------------------
function onOpenRogueLikeSettPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRoguelikeSettPanel == nil then
        self.mRoguelikeSettPanel = rogueLike.RogueLikeSettPanel.new()
        self.mRoguelikeSettPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySettPanelHandler, self)
        self:addViewToPool(self.mRoguelikeSettPanel)
    end
    self.mRoguelikeSettPanel:open(args)
end

function onDestroySettPanelHandler(self)
    self:removeViewToPool(self.mRoguelikeSettPanel)
    self.mRoguelikeSettPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySettPanelHandler, self)
    self.mRoguelikeSettPanel = nil
end


----------------------------------------------肉鸽单层结算---------------------------------------------------------------
function onOpenRogueLikePreDataPanel(self,args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRogueLikePreDataPanel == nil then
        self.mRogueLikePreDataPanel = rogueLike.RogueLikePreDataPanel.new()
        self.mRogueLikePreDataPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyPreDataHandler,self)
        self:addViewToPool(self.mRogueLikePreDataPanel)
    end
    self.mRogueLikePreDataPanel:open(args)
end

function onDestroyPreDataHandler(self)
    self:removeViewToPool(self.mRogueLikePreDataPanel)
    self.mRogueLikePreDataPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyPreDataHandler,self)
    self.mRogueLikePreDataPanel = nil
end

----------------------------------------------肉鸽单层BUFF查看结算---------------------------------------------------------------
function onOpenRogueLikePreBuffPanel(self,args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRogueLikePreBuffPanel == nil then
        self.mRogueLikePreBuffPanel = rogueLike.RogueLikePreBuffPanel.new()
        self.mRogueLikePreBuffPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyPreBuffHandler,self)
        self:addViewToPool(self.mRogueLikePreBuffPanel)
    end
    self.mRogueLikePreBuffPanel:open(args)
end

function onDestroyPreBuffHandler(self)
    self:removeViewToPool(self.mRogueLikePreBuffPanel)
    self.mRogueLikePreBuffPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestroyPreBuffHandler,self)
    self.mRogueLikePreBuffPanel = nil
end

----------------------------------------------肉鸽任务面板---------------------------------------------------------------
function onOpenRogueLikeTaskPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end

    if not args then
        args = {}
    end
    if not args.type then
        args.type = rogueLike.TaskType.Week -- 页签索引
    end

    if self.mRoguelikeTaskPanel == nil then
        self.mRoguelikeTaskPanel = rogueLike.RogueLikeTaskPanel.new()
        self.mRoguelikeTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTaskPanelHandler, self)
        self:addViewToPool(self.mRoguelikeTaskPanel)
    end
    self.mRoguelikeTaskPanel:open(args)
end

function onDestroyTaskPanelHandler(self)
    self:removeViewToPool(self.mRoguelikeTaskPanel)
    self.mRoguelikeTaskPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTaskPanelHandler, self)
    self.mRoguelikeTaskPanel = nil
end
----------------------------------------------肉鸽收藏品面板---------------------------------------------------------------
function onOpenRogueLikeCollectionPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end
    
    if not args then
        args = {}
    end
    if not args.type then
        args.type = rogueLike.CollectionType.All -- 页签索引
    end

    if self.mRoguelikeCollectionPanel == nil then
        self.mRoguelikeCollectionPanel = rogueLike.RogueLikeCollectionPanel.new()
        self.mRoguelikeCollectionPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCollectionPanelHandler, self)
        self:addViewToPool(self.mRoguelikeCollectionPanel)
    end
    self.mRoguelikeCollectionPanel:open(args)
end

function onDestroyCollectionPanelHandler(self)
    self:removeViewToPool(self.mRoguelikeCollectionPanel)
    self.mRoguelikeCollectionPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCollectionPanelHandler, self)
    self.mRoguelikeCollectionPanel = nil
end

----------------------------------------------肉鸽收藏品筛选面板---------------------------------------------------------------
-- function onOpenRogueLikeFilterPanel(self)
--     if self.RogueLikeCollectionFilterPanel == nil then
--         self.RogueLikeCollectionFilterPanel = rogueLike.RogueLikeCollectionFilterPanel.new()
--         self.RogueLikeCollectionFilterPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCollectionFilterPanelHandler, self)
--     end
--     self.RogueLikeCollectionFilterPanel:open()
-- end

-- function onDestroyCollectionFilterPanelHandler(self)
--     self.RogueLikeCollectionFilterPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyCollectionFilterPanelHandler, self)
--     self.RogueLikeCollectionFilterPanel = nil
-- end

-- function onCloseRogueLikeFilterPanel(self)
--     if self.RogueLikeCollectionFilterPanel then
--         self.RogueLikeCollectionFilterPanel:close()
--     end
-- end
----------------------------------------------肉鸽排行榜面板---------------------------------------------------------------
function onOpenRogueLikeRankPanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRoguelikeRankPanel == nil then
        self.mRoguelikeRankPanel = rogueLike.RogueLikeRankHallPanel.new()
        self.mRoguelikeRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankPanelHandler, self)
        self:addViewToPool(self.mRoguelikeRankPanel)
    end
    self.mRoguelikeRankPanel:open(args)
end

function onDestroyRankPanelHandler(self)
    self:removeViewToPool(self.mRoguelikeRankPanel)
    self.mRoguelikeRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRankPanelHandler, self)
    self.mRoguelikeRankPanel = nil
end


----------------------------------------------buff变更面板---------------------------------------------------------------
function onOpenShowBuffPanel(self,args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRoguelikeBuffChangePanel == nil then
        self.mRoguelikeBuffChangePanel = rogueLike.RogueLikeBuffShowPanel.new()
        self.mRoguelikeBuffChangePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuffShowHandler, self)
        self:addViewToPool(self.mRoguelikeBuffChangePanel)
    end

    self.mRoguelikeBuffChangePanel:open(args)
end

function onDestroyBuffShowHandler(self)
    self:removeViewToPool(self.mRoguelikeBuffChangePanel)
    self.mRoguelikeBuffChangePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuffShowHandler, self)
    self.mRoguelikeBuffChangePanel = nil
end

----------------------------------------------buff替换界面---------------------------------------------------------------
function onOpenRogueLikeBuffReplacePanel(self, args)
    if self.mMgr:isOpen() == false then
        return
    end

    if self.mRogueLikeBuffReplacePanel == nil then
        self.mRogueLikeBuffReplacePanel = rogueLike.RogueLikeBuffReplacePanel.new()
        self.mRogueLikeBuffReplacePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuffReplacePanelHandler, self)
        self:addViewToPool(self.mRogueLikeBuffReplacePanel)
    end
    self.mRogueLikeBuffReplacePanel:open(args)
end

function onDestroyBuffReplacePanelHandler(self)
    self:removeViewToPool(self.mRogueLikeBuffReplacePanel)
    self.mRogueLikeBuffReplacePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBuffReplacePanelHandler, self)
    self.mRogueLikeBuffReplacePanel = nil
end

--------------------------------------------------战后的buff选择-----------------------------------------------------------
function onShowSelectGoods(self, callBack)
    self.mSelectGoodsCallBack = callBack
    local id, buff = rogueLike.RogueLikeManager:getMapIdAndBuff()
    if buff == nil or #buff == 0 then
        self.mSelectGoodsCallBack()
        self.mSelectGoodsCallBack = nil
    else
        self:onOpenRogueLikeGoodsSelectPanel()
    end

    rogueLike.RogueLikeManager:clearMapBuff()
end

function onOpenRogueLikeGoodsSelectPanel(self)
    if self.mMgr:isOpen() == false or rogueLike.RogueLikeManager:getRogueDifficulty() == nil then
        if self.mSelectGoodsCallBack then
            self.mSelectGoodsCallBack()
            self.mSelectGoodsCallBack = nil
        end
        return
    end

    if self.mRogueLikeSelectPanel == nil then
        self.mRogueLikeSelectPanel = rogueLike.RogueLikeGoodsSelectPanel.new()
        self.mRogueLikeSelectPanel:addEventListener(View.EVENT_CLOSE, self.onCloseRogueLikeGoodsSelectPanelCall, self)
        self.mRogueLikeSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRogueLikeSelectPanelHandler, self)
        self:addViewToPool(self.mRogueLikeSelectPanel)
    end
    self.mRogueLikeSelectPanel:open()
end

function onCloseRogueLikeGoodsSelectPanelHandler(self)
    if self.mRogueLikeSelectPanel then
        self.mRogueLikeSelectPanel:close()
    end
end

-- 关闭回调
function onCloseRogueLikeGoodsSelectPanelCall(self)
    if self.mSelectGoodsCallBack then
        self.mSelectGoodsCallBack()
        self.mSelectGoodsCallBack = nil
    end
end

-- ui销毁
function onDestroyRogueLikeSelectPanelHandler(self)
    self:removeViewToPool(self.mRogueLikeSelectPanel)
    self.mRogueLikeSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRogueLikeSelectPanelHandler, self)
    self.mRogueLikeSelectPanel = nil
end

-------------------------------------------------------------------------------------------------------------

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
