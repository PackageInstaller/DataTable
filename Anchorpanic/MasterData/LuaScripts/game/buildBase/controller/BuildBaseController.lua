module("game.buildBase.controller.BuildBaseController", Class.impl(Controller))

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
    if next(self.mMgr) then
        for _, mgr in pairs(self.mMgr) do
            if mgr and mgr.resetData then
                mgr:resetData()
            end
        end
    end
end

-- 游戏开始的回调
function gameStartCallBack(self)
end

-- 模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_SCENE, self.onOpenBuildBaseScene, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_LEVELUP, self.onOpenBuildBaseLevelUp, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_SETTLEINLIST_PANEL, self.onOpenSettleInListPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_FAC_PANEL, self.onOpenFacPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_HEROSELECT, self.onOpenHeroSelectHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_INFO, self.onOpenBuildBaseInfo, self)
    GameDispatcher:addEventListener(EventName.OPEN_DISPATCH_DOCK, self.onOpenDispatchDockPanel, self)

    -- self:onOpenDispatchDockPanel(msg)
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_PRODUCE_INFO_PANEL, self.onOpenProducePanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_CHARGE_SPEED_UP_VIEW, self.onOpenChargeSPView, self)
    GameDispatcher:addEventListener(EventName.OPEN_DISPATCH_DRONE_SPEED_UP_VIEW, self.onOpenDispatchDroneViewHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_LEVELUP, self.onReqBuildBaseLevelUp, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_AWARD, self.onReqProduce, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_ALL_AWARD, self.onReqOneKeyProduce, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_BUY_PRODUCE, self.onReqBuyProduce, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_HEROLIST, self.onReqSettledHero, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_FAC_INFO, self.onReqFacInfo, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_PRODUCE, self.onReqFacProduce, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_SPEEDUP, self.onReqFacSpeedUp, self)
    GameDispatcher:addEventListener(EventName.AUTOSETTLEDBUILDBASEHERO, self.onAutoSettledHero, self)
    GameDispatcher:addEventListener(EventName.ENTER_BUILDBASE_ROOMSCENE, self.onEnterBuildBaseRoomScene, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_DISPATCHDOCK_INFO, self.onReqOpenDispatchDock, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_DISPATCH_HERO, self.onReqDispatchHero, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_DISPATCH_SPEEDUP, self.onReqAccDispatch, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_DISPATCH_RECALL, self.onReqHeroRecall, self)
    GameDispatcher:addEventListener(EventName.REQ_BUILDBASE_DISPATCH_REWARDS, self.onReqReceiveRewards, self)
    GameDispatcher:addEventListener(EventName.OPEN_DISPATCHDOCK_AVAILABLE, self.onOpenDisAvailableView, self)
    GameDispatcher:addEventListener(EventName.OPEN_DISPATCHDOCK_INCOMPLETE_VIEW, self.onOpenDisIncompleteView, self)
    GameDispatcher:addEventListener(EventName.OPEN_POWER_TIPS_VIEW, self.onOpenPowerView, self)
    --兑换无人机界面
    GameDispatcher:addEventListener(EventName.OPEN_UAV_SPEEDUP_VIEW, self.onOpenADDUAV, self)
    --总览
    GameDispatcher:addEventListener(EventName.OPEN_BUILDBASE_OVERVIEW, self.onOpenOverview, self)

    GameDispatcher:addEventListener(EventName.DISPATCH_ONE_KEY_BEGIN, self.onReqBeginOneKey, self)
    GameDispatcher:addEventListener(EventName.DISPATCH_ONE_KEY_RECEIVE, self.onReqReceiveOneKey, self)
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 战舰面板信息 19450
        SC_WAR_SHIP_PANEL = self.onRecShipInfo,
        --- *s2c* 战舰更新建筑信息 19456
        SC_WAR_SHIP_UPDATE_BUILDING = self.onUpdateBuilding,
        --- *s2c* 战舰更新战员信息 19455
        SC_WAR_SHIP_UPDATE_HERO = self.onUpdateHeroInfo,
        --- *s2c* 返回战舰加工厂信息 19459
        SC_WAR_SHIP_FACTORY_INFO = self.onUpdateFacInfo,
        --- *s2c* 返回战舰加速生产 19462
        SC_WAR_SHIP_SPEED_UP = self.onSpeedUpHandler,
        --- *s2c* 返回战舰派遣邬信息 19463
        SC_WAR_SHIP_EXPLORE_INFO = self.onBuildBaseResponseHandler,
        --- *s2c* 返回战舰派遣邬区域探索 19465
        SC_WAR_SHIP_EXPLORE_BEGIN = self.onDispatchResponseHandler,
        --- *s2c* 返回战舰派遣邬区域加速 19468
        SC_WAR_SHIP_EXPLORE_SPEED_UP = self.onAccDispatcResponseHandler,
        --- *s2c* 返回战舰派遣邬探索召回 19467
        SC_WAR_SHIP_EXPLORE_STOP = self.onHeroRecallResponseHandler,
        --- *s2c* 返回战舰派遣邬探索领奖 19471
        SC_WAR_SHIP_EXPLORE_RECEIVE = self.onReceiveRewardsResponseHandler,
        --- *s2c* 返回战舰派遣邬区域一键探索 19474
        SC_WAR_SHIP_EXPLORE_BEGIN_ONE_KEY = self.onBeginExploreOneKeyHandler,
        --- *s2c* 返回战舰派遣邬探索一键领奖 19476
        SC_WAR_SHIP_EXPLORE_RECEIVE_ONE_KEY = self.onReceiveExploreOneKeyHandler,
    }
end

----------------------------------------------协议 ----------------------------------------------------

function onRecShipInfo(self, msg)
    buildBase.BuildBaseManager:parseShipMsg(msg.building_list)
    buildBase.BuildBaseHeroManager:parseBuildBaseHeroMsg(msg.hero_list)

    buildBase.BuildBaseRedPointManager:checkRedPoint()
    GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_HERELIST_UPDATE)
    GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE)
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.POWER_TID)
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.UAV_TID)
end
function onUpdateBuilding(self, msg)
    --if msg.result == 1 then 
    buildBase.BuildBaseManager:updateMultShipInfo(msg)
    buildBase.BuildBaseRedPointManager:checkRedPoint()
    GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_BUILDBASE_PANEL_LEVEL_UP)
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.POWER_TID)
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.UAV_TID)
    --end
end
-- 更新基建战员MSG
function onUpdateHeroInfo(self, msg)
    buildBase.BuildBaseHeroManager:parseBuildBaseHeroMsg(msg.hero_list)
    GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_HERELIST_UPDATE)
end

function onUpdateFacInfo(self, msg)
    buildBase.BuildBaseManager:parseFacMsg(msg)
    buildBase.BuildBaseRedPointManager:checkRedPoint()
    GameDispatcher:dispatchEvent(EventName.BUILDBASE_FAC_INFO_UPDATE)
end
--进入战员派遣界面
function onBuildBaseResponseHandler(self, msg)
    buildBase.DispatchDockManager:parseMsg(msg)
    buildBase.DispatchDockManager:onUpdateBuildPanelMsg()
    buildBase.BuildBaseRedPointManager:checkRedPoint()
    GameDispatcher:dispatchEvent(EventName.DISPATCH_INFO_UPDATE)
end
--战员派遣
function onDispatchResponseHandler(self, msg)
    if msg.result == 1 then
        -- buildBase.BuildBaseHeroManager:updateDispatchMemer()
        buildBase.DispatchDockManager:onUpdateMsg(msg.explore_info)
        buildBase.DispatchDockManager:onClearDispatchMemebers()
        buildBase.DispatchDockManager:onUpdateBuildPanelMsg()
        GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_DISPATCH_HERO, msg.explore_info.explore_id)
        gs.Message.Show("派遣成功")
    else
        gs.Message.Show("派遣失败")
    end
end

--返回战舰加速生产
function onSpeedUpHandler(self, msg)
    if msg.result == 1 then

        buildBase.BuildBaseRedPointManager:checkRedPoint()
        gs.Message.Show(_TT(76192)) --“加速成功”
    else
        gs.Message.Show("无人机加速失败")
    end
end
--加速派遣
function onAccDispatcResponseHandler(self, msg)
    if msg.result == 1 then

        -- buildBase.BuildBaseHeroManager:updateDispatchMemer()
        buildBase.DispatchDockManager:onUpdateMsg(msg.explore_info)
        buildBase.DispatchDockManager:onUpdateBuildPanelMsg()
        buildBase.BuildBaseRedPointManager:checkRedPoint()
        GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_DISPATCH_SPEEDUP, msg.explore_info.explore_id)
        gs.Message.Show(_TT(76192)) --“加速成功”
    else
        gs.Message.Show("加速失败")
    end
end
--召回已经派遣的战员
function onHeroRecallResponseHandler(self, msg)
    if msg.result == 1 then
        -- buildBase.BuildBaseHeroManager:updateDispatchMemer()
        buildBase.DispatchDockManager:onUpdateMsg(msg.explore_info)
        buildBase.DispatchDockManager:onUpdateBuildPanelMsg()
        GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_DISPATCH_RECALL, msg.explore_info.explore_id)
        gs.Message.Show("召回成功")
    else
        gs.Message.Show("召回失败")
    end
end
--领取奖励
function onReceiveRewardsResponseHandler(self, msg)
    if msg.result == 1 then
        buildBase.DispatchDockManager:onUpdateMsg(msg.explore_info)
        buildBase.DispatchDockManager:onUpdateBuildPanelMsg()
        buildBase.BuildBaseRedPointManager:checkRedPoint()
        GameDispatcher:dispatchEvent(EventName.RESPONSE_DISPATCH_RECEIVE_REWARD, msg.explore_info.explore_id)
    else
        gs.Message.Show("领取奖励失败")
    end
end

--- *s2c* 返回战舰派遣邬区域一键探索 19474
function onBeginExploreOneKeyHandler(self, msg)
    if msg.result == 1 then
        for i, v in ipairs(msg.war_ship_explore_list) do
            buildBase.DispatchDockManager:onUpdateMsg(v.explore_info)
            GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_DISPATCH_HERO, v.explore_info.explore_id)
        end

        buildBase.DispatchDockManager:onClearDispatchMemebers()
        buildBase.DispatchDockManager:onUpdateBuildPanelMsg()
        gs.Message.Show("派遣成功")
    else
        gs.Message.Show("派遣失败")
    end
end

--- *s2c* 返回战舰派遣邬探索一键领奖 19476
function onReceiveExploreOneKeyHandler(self, msg)
    if msg.result == 1 then
        for i, v in ipairs(msg.war_ship_explore_list) do
            buildBase.DispatchDockManager:onUpdateMsg(v.explore_info)
            GameDispatcher:dispatchEvent(EventName.RESPONSE_BUILDBASE_DISPATCH_HERO, v.explore_info.explore_id)
        end

        buildBase.DispatchDockManager:onClearDispatchMemebers()
        buildBase.DispatchDockManager:onUpdateBuildPanelMsg()
    else
        gs.Message.Show("领取奖励失败")
    end
end

---------------------------------------------发送 -----------------------------------------------------------

--- *c2s* 战舰建筑升级 19451
function onReqBuildBaseLevelUp(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_BUILDING_LV_UP, { building_id = args.id }, Protocol.SC_WAR_SHIP_UPDATE_BUILDING)
    --buildBase.BuildBaseManager:updateBuildBaseLevelData(args.id)
end

--- *c2s* 战舰入驻战员 19453
-- function onReqSettleIn(self, args)
--     SOCKET_SEND(Protocol.CS_WAR_SHIP_HERO_WORK, {building_id = args.buildId, hero_list = args.heroList}, Protocol.SC_WAR_SHIP_HERO_WORK)
--     -- SOCKET_SEND(Protocol.CS_WAR_SHIP_BUILDING_LV_UP, {building_id = args.buildId, hero_list = args.heroList}, Protocol.SC_WAR_SHIP_UPDATE_HERO)
-- end

--- *c2s* 战舰领取生产奖励 19453
function onReqProduce(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_RECEIVE_PRODUCE, { building_id = args.id })
end

--- *c2s* 战舰一键领取生产奖励 19454
function onReqOneKeyProduce(self)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_RECEIVE_PRODUCE_AUTO, nil)
end

--- *c2s* 战舰购买生产资源 19455
function onReqBuyProduce(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_BUY_PRODUCE, { buy_count = args.num })
end

--- *c2s* 战舰入驻战员 19452(操作站员的入住跟移除)
function onReqSettledHero(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_HERO_WORK, { building_id = args.build_id, hero_list = args.hero_list })
end

--- *c2s* 战舰加工厂信息 19458
function onReqFacInfo(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_FACTORY_INFO, { building_id = args.id })
end

--- *c2s* 战舰加工厂生产订单 19460
function onReqFacProduce(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_FACTORY_PRODUCE, { building_id = args.id, order_type = args.orderType, order_id = args.orderId, count = args.count })
end

--- *c2s* 战舰加速生产 19461
function onReqFacSpeedUp(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_SPEED_UP, { building_id = args.id, cost_num = args.costNum })
end

---派遣坞
--- *c2s* 获取战舰派遣邬信息 19462
function onReqOpenDispatchDock(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_EXPLORE_INFO, { building_id = args.buildId })
end

--- *c2s* 派遣战员请求 19464
function onReqDispatchHero(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_EXPLORE_BEGIN, { building_id = args.buildId, explore_id = args.exploreId, hero_list = args.heroList })
end

--- *c2s* 战舰派遣邬区域加速 19468
function onReqAccDispatch(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_EXPLORE_SPEED_UP, { building_id = args.buildId, explore_id = args.exploreId, cost_num = args.costNum })
end

--- *c2s* 战舰派遣邬探索召回 19466
function onReqHeroRecall(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_EXPLORE_STOP, { building_id = args.buildId, explore_id = args.exploreId })
end

---*c2s* 战舰派遣邬探索领奖 19470
function onReqReceiveRewards(self, args)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_EXPLORE_RECEIVE, { building_id = args.buildId, explore_id = args.exploreId })
end

--- *s2c* 返回战舰派遣邬区域一键探索 19474
function onReqBeginOneKey(self, args)
    local list = {}
    for k, v in pairs(args) do
        local heroList = {}
        for pos, tid in ipairs(v) do
            table.insert(heroList, { hero_tid = tid, pos = pos })
        end

        local cmd = { building_id = buildBase.DispatchDockManager:getBaseBuildId(), explore_id = k, hero_list = heroList }
        table.insert(list, cmd)
    end
    SOCKET_SEND(Protocol.CS_WAR_SHIP_EXPLORE_BEGIN_ONE_KEY, { explore_one_key_list = list })
end

--- *c2s* 战舰派遣邬探索一键领奖 19475
function onReqReceiveOneKey(self)
    SOCKET_SEND(Protocol.CS_WAR_SHIP_EXPLORE_RECEIVE_ONE_KEY)
end

-------------------------------------------------------------------------------------------------------------

--自动操作站员的移除跟入住
function onAutoSettledHero(self, args)
    local buildBaseMsgVo = buildBase.BuildBaseManager:getBuildBaseData(args.build_id)
    local heroList = buildBaseMsgVo.heroList or {}
    local isInIndex = -1
    for k, v in pairs(heroList) do
        if args.hero_id == v then
            isInIndex = k
            break
        end
    end


    if isInIndex ~= -1 then
        logAll(args.hero_id, "请求移除")
        table.remove(heroList, isInIndex)
        -- else
        --     logAll(args.hero_id, "请求入住")
        --     table.insert(heroList)
    end
    local herolistData = {}
    for i = 1, #heroList do
        table.insert(herolistData, { hero_tid = heroList[i], pos = i })
    end

    self:onReqSettledHero({ build_id = args.build_id, hero_list = herolistData })
end

-- 打开基建场景
function onOpenBuildBaseScene(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_WARSHIP, true) == false then
        return
    end
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.BUILDBASE)
end

--进入基建小房间
function onEnterBuildBaseRoomScene(self, args)
    local roomConfigData = buildBase.BuildBaseManager:getBuildBasePosDataByPos(args.id)
    if roomConfigData.liveType == buildBase.RoomLiveType.DormitoryLive then
        GameDispatcher:dispatchEvent(EventName.ENTER_DORMITORY_SCENE, args.id)
    else
        buildBase.BuildBaseRoomScene:setRoomData(args.id)
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.BUILDBASEROOM)
    end
end

function onOpenBuildBaseLevelUp(self, args)
    if self.mLevelUpTips == nil then
        self.mLevelUpTips = buildBase.BuildBaseCreatePanel.new()
        self.mLevelUpTips:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLevelUpHandler, self)
    end
    self.mLevelUpTips:open(args)
end

function onDestroyLevelUpHandler(self)
    self.mLevelUpTips:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyLevelUpHandler, self)
    self.mLevelUpTips = nil
end

function onOpenBuildBaseInfo(self)
    if self.mBuildBaseRoomInfo == nil then
        self.mBuildBaseRoomInfo = buildBase.BuildBaseRoomInfo.new()
        self.mBuildBaseRoomInfo:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOpenBuildBaseInfoHandler, self)
    end
    self.mBuildBaseRoomInfo:open(args)
end

function onDestroyOpenBuildBaseInfoHandler(self)
    self.mBuildBaseRoomInfo:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOpenBuildBaseInfoHandler, self)
    self.mBuildBaseRoomInfo = nil
end

function onOpenSettleInListPanel(self, args)
    if self.mSettleInPanel == nil then
        self.mSettleInPanel = buildBase.BuildBaseSettleInListPanel.new()
        self.mSettleInPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySettleInPanelHandler, self)
    end
    self.mSettleInPanel:open({ buildBaseVo = args.buildBaseVo })
end

function onDestroySettleInPanelHandler(self)
    self.mSettleInPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySettleInPanelHandler, self)
    self.mSettleInPanel = nil
end

function onOpenFacPanel(self, args)
    if self.mFacPanel == nil then
        self.mFacPanel = buildBase.BuildBaseFacListPanel.new()
        self.mFacPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryFacPanelHandler, self)
    end
    self.mFacPanel:open(args)
end

function onDestoryFacPanelHandler(self)
    self.mFacPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryFacPanelHandler, self)
    self.mFacPanel = nil
end

function onOpenProducePanel(self, args)
    if self.mProducePanel == nil then
        self.mProducePanel = buildBase.BuildBaseFacProducePanel.new()
        self.mProducePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryProducePanelHandler, self)
    end
    -- for k,v in pairs(table_name) do
    --     print(k,v)
    -- end
    local openSource = args.openSource
    self.mProducePanel:open({ produceVo = args.produceVo, openSource = openSource })
end

function onDestoryProducePanelHandler(self)
    self.mProducePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryProducePanelHandler, self)
    self.mProducePanel = nil
end
--打开消耗消耗体力充能无人机(发电站)
function onOpenChargeSPView(self)
    if self.mChargeSPView == nil then
        self.mChargeSPView = buildBase.BuildBasePowerPlantView.new()
        self.mChargeSPView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestorynChargeSPViewHandler, self)
    end
    self.mChargeSPView:open()
end

function onDestorynChargeSPViewHandler(self)
    self.mChargeSPView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestorynChargeSPViewHandler, self)
    self.mChargeSPView = nil
end

--打开派遣坞界面
function onOpenDispatchDockPanel(self, args)
    if self.mDispatchDockPanel == nil then
        self.mDispatchDockPanel = buildBase.DispatchDockPanel.new()
        self.mDispatchDockPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDispatchDockPanelHandler, self)
    end
    self.mDispatchDockPanel:open(args)
end

function onDestoryDispatchDockPanelHandler(self)
    self.mDispatchDockPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDispatchDockPanelHandler, self)
    self.mDispatchDockPanel = nil
end

--打开派遣坞无人机加速界面
function onOpenDispatchDroneViewHandler(self, exploreId)
    if self.mDispatchDrone == nil then
        self.mDispatchDrone = buildBase.DispatchDroneView.new()
        self.mDispatchDrone:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDispatchDroneViewHandler, self)
    end
    self.mDispatchDrone:open(exploreId)
end

-- ui销毁
function onDestroyDispatchDroneViewHandler(self)
    self.mDispatchDrone:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDispatchDroneViewHandler, self)
    self.mDispatchDrone = nil
end


--派遣任务界面
function onOpenDisAvailableView(self, args)
    if self.mDispatchDockAvailableView == nil then
        self.mDispatchDockAvailableView = buildBase.DispatchDockAvailableView.new()
        self.mDispatchDockAvailableView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDisAvailableViewHandler, self)
    end
    self.mDispatchDockAvailableView:open(args)
end

function onDestoryDisAvailableViewHandler(self)
    self.mDispatchDockAvailableView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDisAvailableViewHandler, self)
    self.mDispatchDockAvailableView = nil
end

--打开未完成界面
function onOpenDisIncompleteView(self, args)
    if self.mDisIncompleteView == nil then
        self.mDisIncompleteView = buildBase.DispatchDockIncompleteView.new()
        self.mDisIncompleteView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDisIncompleteViewHandler, self)
    end
    self.mDisIncompleteView:open(args)
end

function onDestoryDisIncompleteViewHandler(self)
    self.mDisIncompleteView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryDisIncompleteViewHandler, self)
    self.mDisIncompleteView = nil
end

-- 打开电力界面
function onOpenPowerView(self)
    if self.mPowerView == nil then
        self.mPowerView = buildBase.BuildBasePowerTipsView.new()
        self.mPowerView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPowerViewHandler, self)
    end
    self.mPowerView:open()
end
-- ui销毁
function onDestroyPowerViewHandler(self)
    self.mPowerView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPowerViewHandler, self)
    self.mPowerView = nil
end

-- 打开电力界面
function onOpenADDUAV(self)

    if self.mAddUAVView == nil then
        self.mAddUAVView = buildBase.BuildBaseChargeTimerInfo.new()
        self.mAddUAVView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroymAddUAVViewHandler, self)
    end
    self.mAddUAVView:open()

end
-- ui销毁
function onDestroymAddUAVViewHandler(self)
    self.mAddUAVView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroymAddUAVViewHandler, self)
    self.mAddUAVView = nil
end

-- 总览
function onOpenOverview(self)
    if self.mOverview == nil then
        self.mOverview = buildBase.BuildBaseOverviewPanel.new()
        self.mOverview:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOverviewHandler, self)
    end
    self.mOverview:open()
end

-- ui销毁
function onDestroyOverviewHandler(self)
    self.mOverview:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOverviewHandler, self)
    self.mOverview = nil
end

--战员入住
function onOpenHeroSelectHandler(self)
    if self.mHeroSelect == nil then
        self.mHeroSelect = buildBase.BuildBaseHeroSelectPanel.new()
        self.mHeroSelect:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroSelectHandler, self)
    end
    self.mHeroSelect:open()
end

-- ui销毁
function onDestroyHeroSelectHandler(self)
    self.mHeroSelect:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroSelectHandler, self)
    self.mHeroSelect = nil
end


return _M