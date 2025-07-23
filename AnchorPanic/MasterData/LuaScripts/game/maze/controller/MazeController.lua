module("maze.MazeController", Class.impl(Controller))

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
    -- 尝试进入上一次迷宫，没有则进入主场景（战斗结束后调用）
    GameDispatcher:addEventListener(EventName.TRY_LAST_MAZE_ENTER, self.__onTryEnterLastMazeHandler, self)
    -- 打开迷宫面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_PANEL, self.__onOpenMazePanelHandler, self)
    -- 打开迷宫进度面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_PROGRESS_PANEL, self.__onOpenMazeProgressPanelHandler, self)
    -- 打开迷宫物资面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_GOODS_PANEL, self.__onOpenMazeGoodsPanelHandler, self)
    -- -- 打开迷宫排行榜面板
    -- GameDispatcher:addEventListener(EventName.OPEN_MAZE_RANK_PANEL, self.__onOpenMazeRankPanelHandler, self)
    
    -- 打开迷宫事件信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_EVENT_INFO_PANEL, self.__onOpenMazeEventInfoPanelHandler, self)
    -- 打开迷宫奖励信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_AWARD_INFO_PANEL, self.__onOpenMazeAwardInfoPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_AWARDPREVIEW_PANEL, self.__onOpenMazeAwardPreviewPanelHandler, self)

    -- 打开迷宫物资信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_GOODS_INFO_PANEL, self.__onOpenMazeGoodsInfoPanelHandler, self)
    -- 打开迷宫副本信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_DUP_INFO_PANEL, self.__onOpenMazeDupInfoPanelHandler, self)
    -- 打开迷宫雇佣兵信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_MERCENARY_INFO_PANEL, self.__onOpenMazeMercenaryInfoPanelHandler, self)
    -- 打开迷宫触发型信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_TRIGGER_INFO_PANEL, self.__onOpenMazeTriggerInfoPanelHandler, self)
    -- 打开迷宫大炮信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_CANNON_INFO_PANEL, self.__onOpenMazeCannonInfoPanelHandler, self)
    -- 打开迷宫旋转阀门信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_ROTARY_SWITCH_INFO_PANEL, self.__onOpenMazeRotarySwitchInfoPanelHandler, self)
    
    -- 打开迷宫拥有异常面板
    GameDispatcher:addEventListener(EventName.OPEN_MAZE_ABNORMAL_SHOW_PANEL, self.__onOpenAbnormalShowPanelHandler, self)
    
    -- 关闭迷宫所有信息面板
    GameDispatcher:addEventListener(EventName.CLOSE_MAZE_ALL_INFO_PANEL, self.__onCloseMazeAllInfoPanelHandler, self)
    
    -- 请求进入迷宫
    GameDispatcher:addEventListener(EventName.REQ_MAZE_ENTER, self.__onReqEnterMazeHandler, self)
    -- 请求离开迷宫
    GameDispatcher:addEventListener(EventName.REQ_MAZE_EXIT, self.__onReqExitMazePanel, self)
    -- 请求迷宫面板信息
    GameDispatcher:addEventListener(EventName.REQ_MAZE_PANEL, self.__onReqMazePanelInfoHandler, self)
    -- 请求迷宫目标点是否可以移动
    GameDispatcher:addEventListener(EventName.REQ_CHECK_MAZE_PLAYER_MOVE, self.__onReqCheckMazePlayerMoveHandler, self)
    -- 请求迷宫玩家移动
    GameDispatcher:addEventListener(EventName.REQ_MAZE_PLAYER_MOVE, self.__onReqMazePlayerMoveHandler, self)
    -- -- 请求迷宫排行榜
    -- GameDispatcher:addEventListener(EventName.REQ_MAZE_RANK_INFO, self.__onReqMazeRankInfoHandler, self)
    -- 请求迷宫战员信息
    GameDispatcher:addEventListener(EventName.REQ_MAZE_HERO_LIST, self.__onReqMazeHeroListHandler, self)
    -- 请求迷宫副本怪物信息
    GameDispatcher:addEventListener(EventName.REQ_MAZE_DUP_MONSTER_LIST, self.__onReqMazeDupMonsterListHandler, self)
    -- 请求迷宫挑战成功后buff选择
    GameDispatcher:addEventListener(EventName.REQ_MAZE_SELECT_BUFF, self.__onReqMazeSelectBuffHandler, self)
    -- 请求迷宫重置
    GameDispatcher:addEventListener(EventName.REQ_MAZE_RESET, self.__onReqMazeResetHandler, self)
    -- 请求是否额外获得物资
    GameDispatcher:addEventListener(EventName.REQ_MAZE_EXTRA_GOODS, self.__onReqMazeExtraGoodsHandler, self)
    -- 请求迷宫确认触发主动事件
    GameDispatcher:addEventListener(EventName.REQ_MAZE_CONFIRM_TRIGGER, self.__onReqMazeConfirmTriggerHandler, self)
    -- 迷宫请求检查触发
    GameDispatcher:addEventListener(EventName.REQ_MAZE_CHECK_TRIGGER, self.__onReqMazeCheckTriggerHandler, self)
    -- 迷宫请求跳过怪物事件
    GameDispatcher:addEventListener(EventName.REQ_MAZE_SKIP_MONSTER, self.__onReqMazeSkipMonsterHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 返回迷宫面板信息 19160
        SC_MAZE_PANEL_INFO = self.__onResMazePanelInfoMsgHandler,
        --- *s2c* 迷宫进出地图 19163
        SC_MAZE_MAP_ENTER_LEAVE = self.__onResMazeEnterLeaveMsgHandler,
        --- *s2c* 迷宫详细信息 19164
        SC_MAZE_MAP_INFO = self.__onResEnterMazeInfoMsgHandler,
        --- *s2c* 迷宫是否可以移动返回 19166
        SC_CHECK_MAZE_MOVE = self.__onResCheckMazeMoveMsgHandler,
        --- *s2c* 迷宫移动结果返回 19168
        SC_MAZE_MOVE = self.__onResMazeMoveMsgHandler,
        --- *s2c* 返回迷宫战员信息 19172
        SC_MAZE_HERO_INFO = self.__onResMazeHeroListMsgHandler,
       --- *s2c* 请求副本怪物信息 19182
        SC_MAZE_DUP_MON_INFO = self.__onResMazeDupMonsterListMsgHandler,
        --- *s2c* 迷宫挑战通过后选择buff 19173
        SC_MAZE_PASS_CITY = self.__onResMazeSelectBuffMsgHandler,
        --- *s2c* 迷宫重置地图 19176
        SC_MAZE_RESET_MAP = self.__onResMazeResetMsgHandler,
        --- *s2c* 迷宫所有boss关卡挑战通过 19177
        SC_MAZE_BOSS_ALL_PASS = self.__onResMazePassAllBossMsgHandler,
        --- *s2c* 通用触发返回 19179
        SC_MAZE_CONFIRM_TRIGGER = self.__onResMazeCommonTriggerMsgHandler,
       --- *s2c* 通用奖励触发返回 19180
        SC_MAZE_AWARD_GET = self.__onResMazeAwardTriggerMsgHandler,
        --- *s2c* 额外获得物资 19184
        SC_MATERIALS_ID = self.__onResMazeExtraGoodsMsgHandler,
        --- *s2c* 可触发的事件列表 19185
        SC_TRIGGER_EVENT_LIST = self.__onResTriggerEventListMsgHandler,
        --- *s2c* 迷宫迷雾格子 19187
        SC_HAD_PASS_GRIDS = self.__onResPassTileMsgHandler,
        --- *s2c* 已通关的怪物格子id 19189
        SC_DEFEAT_MON_GRIDS = self.__onResPassMonsterTileMsgHandler,
    }
end

---------------------------------------------------------------请求--------------------------------------------------------------------------
--- *c2s* 请求迷宫面板信息 19160
function __onReqMazePanelInfoHandler(self, args)
    SOCKET_SEND(Protocol.CS_MAZE_PANEL_INFO, {})
    -- SOCKET_SEND(Protocol.CS_MAZE_PANEL_INFO, {}, Protocol.SC_MAZE_PANEL_INFO)
end

--- *c2s* 请求进入迷宫地图 19162
function __onReqEnterMazeHandler(self, args)
    maze.MazeManager:setLastMazeId(args.mazeId)
    SOCKET_SEND(Protocol.CS_ENTER_MAZE_MAP, {maze_id = args.mazeId}, Protocol.SC_MAZE_MAP_ENTER_LEAVE)
end

--- *c2s* 请求离开迷宫地图 19162
function __onReqExitMazePanel(self, args)
    SOCKET_SEND(Protocol.CS_LEAVE_MAZE_MAP, {maze_id = args.mazeId})
end

--- *c2s* 迷宫是否可以移动 19165
function __onReqCheckMazePlayerMoveHandler(self, args)
    local msg = {}
    msg.maze_id = args.mazeId
    msg.target_pos = args.tileId
    -- maze.MazeSceneManager:parseCheckMazeMove(msg)
    -- logAll(msg,"移动前告知请求后端移动")
    SOCKET_SEND(Protocol.CS_CHECK_MAZE_MOVE,msg) 
end

--- *c2s* 请求迷宫移动 19164
function __onReqMazePlayerMoveHandler(self, args)
    -- local msg = {}
    -- msg.maze_id = args.mazeId
    -- msg.result = 1
    -- msg.auto_event_pos_list = {}
    -- msg.active_event_pos_list = {}
    -- msg.new_pos = args.tileId
    -- maze.MazeSceneManager:parseMazeMove(msg)
    -- logAll({maze_id = args.mazeId, target_pos = args.tileId},"*c2s* 请求迷宫移动 19164")
    SOCKET_SEND(Protocol.CS_MAZE_MOVE, {maze_id = args.mazeId, target_pos = args.tileId})
end

-- --- *c2s* 迷宫排行榜 19166
-- function __onReqMazeRankInfoHandler(self, args)
--     SOCKET_SEND(Protocol.CS_MAZE_RANK_INFO, {})
-- end

--- *c2s* 请求迷宫战员信息 19170
function __onReqMazeHeroListHandler(self, args)
    SOCKET_SEND(Protocol.CS_MAZE_HERO_INFO, {maze_id = args.mazeId}, Protocol.SC_MAZE_HERO_INFO)
end

--- *c2s* 请求迷宫副本怪物信息 19180
function __onReqMazeDupMonsterListHandler(self, args)
    SOCKET_SEND(Protocol.CS_MAZE_DUP_MON_INFO, {maze_id = args.mazeId, target_pos = args.tileId}, Protocol.SC_MAZE_DUP_MON_INFO)
end

--- *c2s* 迷宫挑战成功后选择的buff 19173
function __onReqMazeSelectBuffHandler(self, args)
    SOCKET_SEND(Protocol.CS_MAZE_SELLECT_BUFF, {maze_id = args.mazeId, target_pos = args.tileId, buff_id = args.buffId})
    self:onCloseMazeGoodsSelectPanelHandler()
end

--- *c2s* 迷宫重置地图 19174
function __onReqMazeResetHandler(self, args)
    SOCKET_SEND(Protocol.CS_MAZE_RESET_MAP, {maze_id = args.mazeId}, Protocol.SC_MAZE_RESET_MAP)
end

--- *c2s* 请求是否额外获得物资 19183
function __onReqMazeExtraGoodsHandler(self, args)
    SOCKET_SEND(Protocol.CS_MATERIALS_ID, {maze_id = args.mazeId}, Protocol.SC_MATERIALS_ID)
end

--- *c2s* 迷宫确认触发事件 19177
function __onReqMazeConfirmTriggerHandler(self, args)
    SOCKET_SEND(Protocol.CS_MAZE_CONFIRM_TRIGGER, {maze_id = args.mazeId, target_pos = args.tileId, active_event_id = args.eventId, other_args = args.paramList})
end

--- *c2s* 迷宫请求检查触发 19186，目前只在初始打开时请求
function __onReqMazeCheckTriggerHandler(self, args)
    --服务端说暂时注释，原因:一笔画传送门，初始进来会触发事件，导致事件失败
    -- SOCKET_SEND(Protocol.CS_MAZE_CHECK_TRIGGER, {maze_id = args.mazeId})
end

--- *c2s* 跳过怪物事件 19188
function __onReqMazeSkipMonsterHandler(self, args)
    SOCKET_SEND(Protocol.CS_SKIP_MON_EVENT, {maze_id = args.mazeId, pos_id = args.tileId}, Protocol.SC_MAZE_CONFIRM_TRIGGER)
end

---------------------------------------------------------------返回--------------------------------------------------------------------------
--- *s2c* 返回迷宫面板信息 19160
function __onResMazePanelInfoMsgHandler(self, msg)
    maze.MazeManager:parseMsgMazeList(msg.maze_list)
end

--- *s2c* 迷宫进出地图 19163
function __onResMazeEnterLeaveMsgHandler(self, msg)
    if(msg.maze_id == maze.MazeSceneManager:getMazeId())then
        if(msg.maze_map_state == 1)then
            GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAZE)
        else
            maze.MazeManager:setLastMazeId(nil)
            GameDispatcher:dispatchEvent(EventName.CLOSE_MAZE_SCENE_PANEL)
        end
    end
end

--- *c2s* 进入迷宫的详细信息 19163
function __onResEnterMazeInfoMsgHandler(self, msg)
    maze.MazeSceneManager:parseEnterMazeInfo(msg)
end

--- *s2c* 迷宫是否可以移动返回 19166
function __onResCheckMazeMoveMsgHandler(self, msg)
    -- logAll(msg,"迷宫移动返回")
    -- maze.MazeSceneManager:parseCheckMazeMove(msg)
end
 --- *s2c* 迷宫移动结果返回 19168
function __onResMazeMoveMsgHandler(self, msg)
    -- logAll(msg,"*s2c* 迷宫移动结果返回 19168")
    maze.MazeSceneManager:parseMazeMove(msg)
end

--- *s2c* 返回迷宫战员信息 19171
function __onResMazeHeroListMsgHandler(self, msg)
    maze.MazeManager:parseMazeHeroList(msg)
end

--- *s2c* 返回迷宫副本怪物信息 19181
function __onResMazeDupMonsterListMsgHandler(self, msg)
    maze.MazeManager:parseDupMonsterList(msg)
end

--- *s2c* 迷宫挑战通过后选择buff 19172
function __onResMazeSelectBuffMsgHandler(self, msg)
    maze.MazeManager:setCaculateData(msg)
    if(not fight.FightManager:getIsFighting())then
        self:onShowSelectGoods(nil)
    end
end

--- *s2c* 迷宫重置地图 19175
function __onResMazeResetMsgHandler(self, msg)
    if(msg.result == 1)then
        gs.Message.Show2("重置成功")
        -- GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_SCENE_DATA, {mazeId = msg.maze_id})
    else
        gs.Message.Show2("重置失败")
    end
end

--- *s2c* 迷宫所有boss关卡挑战通过 19176
function __onResMazePassAllBossMsgHandler(self, msg)
    maze.MazeManager:setAllDupPassData(msg)
end

--- *s2c* 通用触发返回 19178
function __onResMazeCommonTriggerMsgHandler(self, msg)
    -- logAll(msg,"*s2c* 通用触发返回 19178")
    if(msg.maze_id == maze.MazeSceneManager:getMazeId())then
        if(fight.FightManager:getIsFighting())then
            print("还在战斗逻辑,不处理迷宫的触发事件")
        else
            maze.MazeEventExecutor:checkTriggerEventEffect(msg.maze_id, msg.target_pos, msg.active_event_id, msg.other_args, msg.del_event_list, msg.add_event_list, msg.update_event_list, msg.update_grid_info, nil)
        end
    end
end

--- *s2c* 通用奖励触发返回 19179
function __onResMazeAwardTriggerMsgHandler(self, msg)
    if(msg.maze_id == maze.MazeSceneManager:getMazeId())then
        if(fight.FightManager:getIsFighting())then
            print("还在战斗逻辑,不处理迷宫的触发事件")
        else
            maze.MazeEventExecutor:checkTriggerEventEffect(msg.maze_id, msg.target_pos, msg.active_event_id, msg.award, msg.del_event_list, msg.add_event_list, nil, nil, nil)
        end
    end
end

--- *s2c* 额外获得物资 19184
function __onResMazeExtraGoodsMsgHandler(self, msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_EXTRA_GOODS, {buffId = msg.sp_id})
end

--- *s2c* 可触发的事件列表 19185
function __onResTriggerEventListMsgHandler(self, msg)
    if(maze.MazeSceneManager:getMazeId() ~= nil)then
        maze.MazeSceneManager:parseTriggerEventList(msg.trigger_event_list)
    end
end

--- *s2c* 迷宫已走格子更新 19187
function __onResPassTileMsgHandler(self, msg)
    -- logAll(msg,"*s2c* 迷宫已走格子更新 19187 = ")
    maze.MazeSceneManager:setPassTileIdList(msg)
    GameDispatcher:dispatchEvent(EventName.MAZE_REFRESH_FOG)
end

--- *s2c* 已通关的怪物格子id 19189
function __onResPassMonsterTileMsgHandler(self, msg)
    maze.MazeSceneManager:setPassMonsterTileIdList(msg)
end

---------------------------------------------------------------面板--------------------------------------------------------------------------
-- 尝试进入上一次迷宫，没有则进入主场景（战斗结束后调用）
function __onTryEnterLastMazeHandler(self)
    local lastMazeId = maze.MazeManager:getLastMazeId()
    if(lastMazeId)then
        GameDispatcher:dispatchEvent(EventName.REQ_MAZE_ENTER, {mazeId = lastMazeId})
    else
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    end
end

-- 打开迷宫面板
function __onOpenMazePanelHandler(self, args)
    if(not self.mMazePanel)then
        self.mMazePanel = maze.MazePanel.new()
        local function destroyPanel()
            self.mMazePanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazePanel = nil
        end
        self.mMazePanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazePanel:open()
end

-- 打开迷宫进度面板
function __onOpenMazeProgressPanelHandler(self, args)
    if(not self.mMazeProgressPanel)then
        self.mMazeProgressPanel = maze.MazeProgressPanel.new()
        local function destroyPanel()
            self.mMazeProgressPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeProgressPanel = nil
        end
        self.mMazeProgressPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeProgressPanel:open(args)
end

-- 打开迷宫物资面板
function __onOpenMazeGoodsPanelHandler(self, args)
    if(not self.mMazeGoodsPanel)then
        self.mMazeGoodsPanel = maze.MazeGoodsPanel.new()
        local function destroyPanel()
            self.mMazeGoodsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeGoodsPanel = nil
        end
        self.mMazeGoodsPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeGoodsPanel:open(args)
end

-- -- 打开迷宫排行榜面板
-- function __onOpenMazeRankPanelHandler(self, args)
--     if(not self.mMazeRankPanel)then
--         self.mMazeRankPanel = maze.MazeRankHallPanel.new()
--         local function destroyPanel()
--             self.mMazeRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
--             self.mMazeRankPanel = nil
--         end
--         self.mMazeRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
--     end
--     self.mMazeRankPanel:open(args)
-- end

-- 打开迷宫事件信息面板
function __onOpenMazeEventInfoPanelHandler(self, args)
    if(not self.mMazeEventInfoPanel)then
        self.mMazeEventInfoPanel = maze.MazeEventInfoPanel.new()
        local function destroyPanel()
            self.mMazeEventInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeEventInfoPanel = nil
        end
        self.mMazeEventInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeEventInfoPanel:open(args)
end

-- 打开迷宫奖励信息面板
function __onOpenMazeAwardInfoPanelHandler(self, args)
    if(not self.mMazeAwardInfoPanel)then
        self.mMazeAwardInfoPanel = maze.MazeAwardInfoPanel.new()
        local function destroyPanel()
            self.mMazeAwardInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeAwardInfoPanel = nil
        end
        self.mMazeAwardInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeAwardInfoPanel:open(args)
end

-- 打开迷宫奖励预览面板
function __onOpenMazeAwardPreviewPanelHandler(self, args)
    if(not self.mMazeAwardPreviewPanel)then
        self.mMazeAwardPreviewPanel = maze.MazeAwardPreviewPanel.new()
        local function destroyPanel()
            self.mMazeAwardPreviewPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeAwardPreviewPanel = nil
        end
        self.mMazeAwardPreviewPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeAwardPreviewPanel:open(args)
end

-- 打开迷宫物资信息面板
function __onOpenMazeGoodsInfoPanelHandler(self, args)
    if(not self.mMazeGoodsInfoPanel)then
        self.mMazeGoodsInfoPanel = maze.MazeGoodsInfoPanel.new()
        local function destroyPanel()
            self.mMazeGoodsInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeGoodsInfoPanel = nil
        end
        self.mMazeGoodsInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeGoodsInfoPanel:open(args)
end

-- 打开迷宫副本信息面板
function __onOpenMazeDupInfoPanelHandler(self, args)
    if(not self.mMazeDupInfoPanel)then
        self.mMazeDupInfoPanel = maze.MazeDupInfoPanel.new()
        local function destroyPanel()
            self.mMazeDupInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeDupInfoPanel = nil
        end
        self.mMazeDupInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeDupInfoPanel:open(args)
end

-- 打开迷宫雇佣兵信息面板
function __onOpenMazeMercenaryInfoPanelHandler(self, args)
    if(not self.mMazeHelperInfoPanel)then
        self.mMazeHelperInfoPanel = maze.MazeMercenaryInfoPanel.new()
        local function destroyPanel()
            self.mMazeHelperInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeHelperInfoPanel = nil
        end
        self.mMazeHelperInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeHelperInfoPanel:open(args)
end

-- 打开迷宫触发型信息面板
function __onOpenMazeTriggerInfoPanelHandler(self, args)
    if(not self.mMazeTriggerInfoPanel)then
        self.mMazeTriggerInfoPanel = maze.MazeTriggerInfoPanel.new()
        local function destroyPanel()
            self.mMazeTriggerInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeTriggerInfoPanel = nil
        end
        self.mMazeTriggerInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeTriggerInfoPanel:open(args)
end

-- 打开迷宫大炮信息面板
function __onOpenMazeCannonInfoPanelHandler(self, args)
    if(not self.mMazeCannonInfoPanel)then
        self.mMazeCannonInfoPanel = maze.MazeCannonInfoPanel.new()
        local function destroyPanel()
            self.mMazeCannonInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeCannonInfoPanel = nil
        end
        self.mMazeCannonInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeCannonInfoPanel:open(args)
end

-- 打开迷宫旋转阀门信息面板
function __onOpenMazeRotarySwitchInfoPanelHandler(self, args)
    if(not self.mMazeRotarySwitchInfoPanel)then
        self.mMazeRotarySwitchInfoPanel = maze.MazeRotarySwitchInfoPanel.new()
        local function destroyPanel()
            self.mMazeRotarySwitchInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMazeRotarySwitchInfoPanel = nil
        end
        self.mMazeRotarySwitchInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMazeRotarySwitchInfoPanel:open(args)
end

-- 打开拥有异常界面
function __onOpenAbnormalShowPanelHandler(self, args)
    if self.mAbnormalShowView == nil then
        self.mAbnormalShowView = maze.MazeAbnormalShowPanel.new()
        local function destroyPanel()
            self.mAbnormalShowView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mAbnormalShowView = nil
        end
        self.mAbnormalShowView:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mAbnormalShowView:open(args)
end

-- 关闭迷宫所有信息面板
function __onCloseMazeAllInfoPanelHandler(self, args)
    if(self.mMazeProgressPanel)then
        self.mMazeProgressPanel:close()
    end
    if(self.mMazeGoodsPanel)then
        self.mMazeGoodsPanel:close()
    end
    if(self.mMazeRankPanel)then
        self.mMazeRankPanel:close()
    end
    if(self.mMazeEventInfoPanel)then
        self.mMazeEventInfoPanel:close()
    end
    if(self.mMazeAwardInfoPanel)then
        self.mMazeAwardInfoPanel:close()
    end
    if(self.mMazeDupInfoPanel)then
        self.mMazeDupInfoPanel:close()
    end
    if(self.mMazeHelperInfoPanel)then
        self.mMazeHelperInfoPanel:close()
    end
    if(self.mMazeTriggerInfoPanel)then
        self.mMazeTriggerInfoPanel:close()
    end
    if(self.mMazeCannonInfoPanel)then
        self.mMazeCannonInfoPanel:close()
    end
    if(self.mMazeRotarySwitchInfoPanel)then
        self.mMazeRotarySwitchInfoPanel:close()
    end
    if(self.mAbnormalShowView)then
        self.mAbnormalShowView:close()
    end
end

------------------------------------------------------------------物品选择------------------------------------------------------------------
-- 通关胜利物品选择
function onShowSelectGoods(self, callBack)
    self.mSelectGoodsCallBack = callBack
    local caculateData = maze.MazeManager:getCaculateData()
    if caculateData and #caculateData.buffIdList > 0 then
        self:onOpenMazeGoodsSelectPanel(caculateData)
    elseif self.mSelectGoodsCallBack then
        self.mSelectGoodsCallBack()
        self.mSelectGoodsCallBack = nil
    end
    maze.MazeManager:setCaculateData(nil)
end
-- 打开通关物品选择界面
function onOpenMazeGoodsSelectPanel(self, args)
    if self.mMazeGoodsSelectPanel == nil then
        self.mMazeGoodsSelectPanel = maze.MazeGoodsSelectPanel.new()
        self.mMazeGoodsSelectPanel:addEventListener(View.EVENT_CLOSE, self.onCloseMazeGoodsSelectPanelCall, self)
        self.mMazeGoodsSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMazeGoodsSelectPanelHandler, self)
    end
    self.mMazeGoodsSelectPanel:open(args)
end
function onCloseMazeGoodsSelectPanelHandler(self)
    if self.mMazeGoodsSelectPanel then
        self.mMazeGoodsSelectPanel:close()
    end
end
-- 关闭回调
function onCloseMazeGoodsSelectPanelCall(self)
    if self.mSelectGoodsCallBack then
        self.mSelectGoodsCallBack()
        self.mSelectGoodsCallBack = nil
    end
end
-- ui销毁
function onDestroyMazeGoodsSelectPanelHandler(self)
    self.mMazeGoodsSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMazeGoodsSelectPanelHandler, self)
    self.mMazeGoodsSelectPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
