--[[ 
-----------------------------------------------------
@filename       : MainExploreController
@Description    : 主线探索控制器
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreController", Class.impl(Controller))

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

--模块间事件监
function listNotification(self)
    -- 尝试进入上一次主探索，没有则进入主场景（战斗结束后调用）
    GameDispatcher:addEventListener(EventName.TRY_LAST_MAIN_EXPLORE_ENTER, self.onTryEnterLastMainExploreHandler, self)
    -- 请求进入地图
    GameDispatcher:addEventListener(EventName.REQ_ENTER_MAIN_EXPLORE_MAP, self.onReqEnterExploreMapHandler, self)
    -- 请求离开地图
    GameDispatcher:addEventListener(EventName.REQ_EXIT_MAIN_EXPLORE_MAP, self.onReqExitExploreMapHandler, self)
    -- 请求同步坐标
    GameDispatcher:addEventListener(EventName.REQ_SYNC_MAIN_EXPLORE_POS, self.onReqSyncExplorePosHandler, self)
    -- 请求触发事件
    GameDispatcher:addEventListener(EventName.REQ_TRIGGER_MAIN_EXPLORE_EVENT, self.onReqTriggerExploreEventHandler, self)
    -- 请求重置地图
    GameDispatcher:addEventListener(EventName.REQ_RESET_MAIN_EXPLORE_MAP, self.onReqResetExploreMapHandler, self)
    -- 请求切换操作的战员
    GameDispatcher:addEventListener(EventName.REQ_CHANGE_MAIN_EXPLORE_CONTROL_HERO, self.onReqChangeControlHeroHandler, self)
    -- 请求战斗成功选择物资
    GameDispatcher:addEventListener(EventName.REQ_MAIN_EXPLORE_SELECT_BUFF, self.onReqSelectBuffHandler, self)
    -- 请求触发初次介绍
    GameDispatcher:addEventListener(EventName.REQ_MAIN_EXPLORE_FIRST_INTRODUCE, self.onReqFirstIntroduceHandler, self)

    -- 请求打开物资界面
    GameDispatcher:addEventListener(EventName.OPEN_MAIN_EXPLORE_GOODS_PANEL, self.onOpenGoodsPanelHandler, self)
    -- 请求打开物资信息面板
    GameDispatcher:addEventListener(EventName.OPEN_MAIN_EXPLORE_GOODS_INFO_PANEL, self.onOpenMainExploreGoodsInfoPanelHandler, self)
    -- 请求打开地图界面
    GameDispatcher:addEventListener(EventName.OPEN_MAIN_EXPLORE_MAP_PANEL, self.onOpenMapPanelHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 进入地图返回 22002
        SC_ENTER_MAP = self.onResEnterExploreMapMsgHandler,
        --- *s2c* 离开地图返回 22004
        SC_LEAVE_MAP = self.onResExitExploreMapMsgHandler,
        --- *s2c* 地图信息 22005
        SC_MAP_INFO = self.onResExploreMapInfoMsgHandler,
        --- *s2c* 触发事件返回 22008
        SC_TRIGGER_EVENT = self.onResExploreTriggerEventMsgHandler,
        --- *s2c* 通关地图 22010
        SC_PASS_MAP = self.onResExplorePassMsgHandler,
        --- *s2c* 重置地图返回 22012
        SC_RESET_MAP = self.onResExploreRestMsgHandler,
        --- *s2c* 切换操作的战员 22014
        SC_CHANGE_CONTROL_HERO = self.onResChangeControleHeroMsgHandler,
        --- *s2c* 战斗成功推送物资数据供玩家选择 22015
        SC_BATTLE_AFTER_BUFF = self.onResSelectBuffMsgHandler,
        --- *s2c* 战斗成功选择物资返回 22017
        SC_SELECT_BUFF = self.onResSelectBuffResultMsgHandler,
        --- *s2c* 战员信息推送 22018
        SC_HERO_INFO = self.onResHeroUpdateMsgHandler,
        --- *s2c* 进行的引导推送 22019
        SC_GUIDE_EVENT = self.onResGuideEventUpdateMsgHandler,
        --- *s2c* 触发初次介绍返回 22021
        SC_TRIGGER_FIRST_INTRODUCE = self.onResFirstIntroduceMsgHandler,
    }
end

---------------------------------------------------------------请求--------------------------------------------------------------------------
--- *c2s* 进入地图 22001
function onReqEnterExploreMapHandler(self, args)
    local dupMapConfigVo = mainExplore.MainExploreSceneManager:getDupMapConfigVo(args.dupType, args.dupId)
    -- 进入指定副本类型、副本id对应探索地图
    mainExplore.MainExploreManager:setTriggerDupData(dupMapConfigVo)
    SOCKET_SEND(Protocol.CS_ENTER_MAP, { map_id = dupMapConfigVo.mapId }, Protocol.SC_ENTER_MAP)
end

--- *c2s* 离开地图 22003
function onReqExitExploreMapHandler(self, args)
    SOCKET_SEND(Protocol.CS_LEAVE_MAP, nil, Protocol.SC_LEAVE_MAP)
end

--- *c2s* 同步坐标 22006
function onReqSyncExplorePosHandler(self, args)
    local playerPos = args.playerPos
    SOCKET_SEND(Protocol.CS_SYNC_POS_Z, { pos = { x = tostring(math.floor(playerPos.x * 100) / 100), y = tostring(math.floor(playerPos.y * 100) / 100), z = tostring(math.floor(playerPos.z * 100) / 100) } })
end

--- *c2s* 触发事件 22007
function onReqTriggerExploreEventHandler(self, args)
    SOCKET_SEND(Protocol.CS_TRIGGER_EVENT, { event_id = args.eventId, args_int = args.paramList })
end

--- *c2s* 重置地图 22011
function onReqResetExploreMapHandler(self, args)
    SOCKET_SEND(Protocol.CS_RESET_MAP, { map_id = args.mapId }, Protocol.SC_RESET_MAP)
end

--- *c2s* 切换操作的战员 22013
function onReqChangeControlHeroHandler(self, args)
    SOCKET_SEND(Protocol.CS_CHANGE_CONTROL_HERO, { hero_id = args.heroId }, Protocol.SC_CHANGE_CONTROL_HERO)
end

--- *c2s* 战斗成功选择物资 22016
function onReqSelectBuffHandler(self, args)
    SOCKET_SEND(Protocol.CS_SELECT_BUFF, { buff_id = args.buffId }, Protocol.SC_SELECT_BUFF)
    self:onCloseGoodsSelectPanelHandler()
end

--- *c2s* 触发初次介绍 22020
function onReqFirstIntroduceHandler(self, args)
    SOCKET_SEND(Protocol.CS_TRIGGER_FIRST_INTRODUCE, { introduce_id = args.introduceId }, Protocol.SC_TRIGGER_FIRST_INTRODUCE)
end

---------------------------------------------------------------返回--------------------------------------------------------------------------
--- *s2c* 进入地图返回 22002
function onResEnterExploreMapMsgHandler(self, msg)
    local mainExploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    if (mainExploreMapConfigVo and msg.result == 1) then
        if (msg.map_id == mainExploreMapConfigVo.mapId) then
            GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_EXPLORE)
        else
            print("探索地图进入错误")
        end
    else
        -- 进入指定副本类型、副本id对应探索地图
        mainExplore.MainExploreManager:setTriggerDupData(nil)
        print("探索地图失败")
    end
end

--- *s2c* 离开地图返回 22004
function onResExitExploreMapMsgHandler(self, msg)
    -- 重登情况下或nil情况下才理会后端，因为顶号后端会推送离开协议过来，会造成转菊花
    if(GameManager:getGameState() == nil or GameManager:getGameState() == 0)then
        mainExplore.MainExploreManager:setTriggerDupData(nil)
        GameDispatcher:dispatchEvent(EventName.CLOSE_MAIN_EXPLORE_SCENE_PANEL)
    end
end

--- *s2c* 地图信息 22005
function onResExploreMapInfoMsgHandler(self, msg)
    local mainExploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    if (mainExploreMapConfigVo and msg.map_id == mainExploreMapConfigVo.mapId) then
        mainExplore.MainExploreManager:setExploreMapInfo(msg)
    end
end

--- *s2c* 触发事件返回 22008
function onResExploreTriggerEventMsgHandler(self, msg)
    if (fight.FightManager:getIsFighting()) then
        print("还在战斗逻辑,不处理地图探索的触发事件")
    else
        local mainExploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
        if (mainExploreMapConfigVo and msg.map_id == mainExploreMapConfigVo.mapId) then
            if (msg.result == 1) then
                mainExplore.MainExploreEventExecutor:checkTriggerEventEffect(msg.trigger_event_id, msg.award_list, msg.other_args, msg.del_event_ids, msg.add_event_list, msg.update_event_list, nil)
            else
                print("触发事件失败")
            end
        end
    end
end

--- *s2c* 通关地图 22010
function onResExplorePassMsgHandler(self, msg)
    mainExplore.MainExploreManager:setAllDupPassData(msg)
end

--- *s2c* 重置地图返回 22012
function onResExploreRestMsgHandler(self, msg)
    if (msg.result == 1) then
        print("重置探索地图成功")
    else
        print("重置探索地图失败")
    end
end

--- *s2c* 切换操作的战员 22014
function onResChangeControleHeroMsgHandler(self, msg)
    local mainExploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    if (mainExploreMapConfigVo and msg.result == 1) then
        if (msg.map_id == mainExploreMapConfigVo.mapId) then
            mainExplore.MainExploreManager:setControlHeroTid(msg.hero_tid)
        end
    else
        print("切换操作的战员失败")
    end
end

--- *s2c* 战斗成功推送物资数据供玩家选择 22015
function onResSelectBuffMsgHandler(self, msg)
    mainExplore.MainExploreManager:setCaculateData(msg)
end

--- *s2c* 战斗成功选择物资返回 22017
function onResSelectBuffResultMsgHandler(self, msg)
    if (msg.result == 1) then
        mainExplore.MainExploreManager:addGoods(msg.map_id, msg.buff_id)
    else
        print("战斗成功选择物资返回失败")
    end
end

--- *s2c* 战员信息推送 22018
function onResHeroUpdateMsgHandler(self, msg)
    mainExplore.MainExploreManager:parseMazeHeroList(msg.map_id, msg.hero_list)
end

--- *s2c* 进行的引导推送 22019
function onResGuideEventUpdateMsgHandler(self, msg)
    mainExplore.MainExploreManager:setGuideEventId(msg.map_id, msg.guide_event_id)
end

--- *s2c* 触发初次介绍返回 22021
function onResFirstIntroduceMsgHandler(self, msg)
    local mainExploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    -- 繁说初次介绍统一暂停
    if (mainExploreMapConfigVo and msg.result == 1) then
        if (msg.map_id == mainExploreMapConfigVo.mapId) then
            -- 更新触发状态：恢复
            mainExplore.MainExploreEventExecutor:updateTriggerState(mainExplore.TriggerState.GAME_PAUSE, false)

            mainExplore.MainExploreManager:addIntroduceId(msg.introduce_id)
            local function callFun()
                mainExplore.MainExploreEventExecutor:updateTriggerState(mainExplore.TriggerState.GAME_PAUSE, true)
            end
            self:onOpenFirstIntroducePanelHandler({ introduceId = msg.introduce_id, callFun = callFun })
            -- GameDispatcher:dispatchEvent(EventName.UPDATE_MAIN_EXPLORE_FIRST_INTRODUCE, msg.introduce_id)
        end
    else
        print("触发初次介绍返回失败")
    end
end

---------------------------------------------------------------面板--------------------------------------------------------------------------
-- 尝试进入上一次主探索，没有则进入主场景（战斗结束后调用）
function onTryEnterLastMainExploreHandler(self, args)
    local mainExploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    if (mainExploreMapConfigVo) then
        GameDispatcher:dispatchEvent(EventName.REQ_ENTER_MAIN_EXPLORE_MAP, { dupType = mainExploreMapConfigVo.dupType, dupId = mainExploreMapConfigVo.dupId })
    else
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    end
end

-- 打开物资面板
function onOpenGoodsPanelHandler(self, args)
    if (not self.mMainExploreGoodsPanel) then
        self.mMainExploreGoodsPanel = mainExplore.MainExploreGoodsPanel.new()
        local function destroyPanel()
            self.mMainExploreGoodsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMainExploreGoodsPanel = nil
            mainExplore.MainExploreManager:setRate(nil)
        end
        self.mMainExploreGoodsPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMainExploreGoodsPanel:open(args)
end

-- 打开物资箱信息面板
function onOpenMainExploreGoodsInfoPanelHandler(self, args)
    if (not self.mMainExploreGoodsInfoPanel) then
        self.mMainExploreGoodsInfoPanel = mainExplore.MainExploreGoodsInfoPanel.new()
        local function destroyPanel()
            self.mMainExploreGoodsInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMainExploreGoodsInfoPanel = nil
        end
        self.mMainExploreGoodsInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMainExploreGoodsInfoPanel:open(args)
end

-- 打开地图面板
function onOpenMapPanelHandler(self, args)
    if (not self.mMainExploreMapPanel) then
        self.mMainExploreMapPanel = mainExplore.MainExploreMapPanel.new()
        local function destroyPanel()
            self.mMainExploreMapPanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMainExploreMapPanel = nil
        end
        self.mMainExploreMapPanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMainExploreMapPanel:open(args)
end

-- 打开初次介绍面板
function onOpenFirstIntroducePanelHandler(self, args)
    if (not self.mFirstIntroducePanel) then
        self.mFirstIntroducePanel = mainExplore.MainExploreFirstIntroducePanel.new()
        local function destroyPanel()
            self.mFirstIntroducePanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mFirstIntroducePanel = nil
        end
        self.mFirstIntroducePanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mFirstIntroducePanel:open(args)
end

------------------------------------------------------------------物品选择------------------------------------------------------------------
-- 通关胜利物品选择
function onShowSelectGoods(self, callBack)
    self.mSelectGoodsCallBack = callBack
    local caculateData = mainExplore.MainExploreManager:getCaculateData()
    if caculateData and #caculateData.buffIdList > 0 then
        self:onOpenGoodsSelectPanel(caculateData)
    elseif self.mSelectGoodsCallBack then
        self.mSelectGoodsCallBack()
        self.mSelectGoodsCallBack = nil
    end
    mainExplore.MainExploreManager:setCaculateData(nil)
end
-- 打开通过物资选择面板
function onOpenGoodsSelectPanel(self, args)
    if self.mMainExploreGoodsSelectPanel == nil then
        self.mMainExploreGoodsSelectPanel = mainExplore.MainExploreGoodsSelectPanel.new()
        self.mMainExploreGoodsSelectPanel:addEventListener(View.EVENT_CLOSE, self.onCloseMainExploreGoodsSelectPanelCall, self)
        self.mMainExploreGoodsSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainExploreGoodsSelectPanelHandler, self)
    end
    self.mMainExploreGoodsSelectPanel:open(args)
end
function onCloseGoodsSelectPanelHandler(self)
    if self.mMainExploreGoodsSelectPanel then
        self.mMainExploreGoodsSelectPanel:close()
    end
end
-- 关闭回调
function onCloseMainExploreGoodsSelectPanelCall(self)
    if self.mSelectGoodsCallBack then
        self.mSelectGoodsCallBack()
        self.mSelectGoodsCallBack = nil
    end
end
-- ui销毁
function onDestroyMainExploreGoodsSelectPanelHandler(self)
    self.mMainExploreGoodsSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainExploreGoodsSelectPanelHandler, self)
    self.mMainExploreGoodsSelectPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]