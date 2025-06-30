module("game.sandPlay.controller.SandPlayController", Class.impl(Controller))

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

    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_SCENEUI, self.onOpenSandPlaySceneUI, self)
    GameDispatcher:addEventListener(EventName.CLOSE_SANDPLAY_SCENEUI, self.onCloseSandPlaySceneUI, self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_OPEN_FISHING_UI, self.onOpenSandPlayFishingUI, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_CLOSE_FISHING_UI, self.onCloseSandPlayFishingUI, self)

    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_MAPPANEL, self.onOpenSandPlayMapPanel, self)

    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onActivityClose, self)

    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_FISHATLASPANEL, self.onOpenSandPlayFishingAtlasPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_FISHING_RESULTPANEL, self.onOpenSandPlayFishingResultPanel, self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_ONREQ_FISHING, self.onReqFishing, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_ONREQ_ACHIEVEAWARD, self.onReqTask, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_ONREQ_COLLECTAWARD, self.onReqCollect, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_ONREQ_EVENTTRIGGER, self.onReqEventTrigger, self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_ONREQPLANT, self.onReqHappyFarmPlant, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_FINISHTASK, self.onReqHappyFarmFinishTask, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_REAPCHICKEN, self.onReqHappyFarmReapChicken, self)

    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_FISH_TEACHING_VIEW, self.onOpenSandPlayFishingTeachingView, self)
    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_DUPINFOPANEL, self.onOpenSandPlayDupInfoPanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_HAPPYFARM_TASKPANEL, self.onOpenSandPlayHappyFarmTaskPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_HAPPYFARM_SHOPPANEL, self.onOpenSandPlayHappyFarmShopPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_HAPPYFARM_FIELD, self.onOpenSandPlayHappyFarmField, self)
    GameDispatcher:addEventListener(EventName.CLOSE_SANDPLAY_HAPPYFARM_FIELD, self.onCloseSandPlayHappyFarmField, self)

    GameDispatcher:addEventListener(EventName.OPEN_SANDPLAY_HAPPYFARM_BREEDPANEL, self.onOpenSandPlayHappyFarmBreedPanel, self)

    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return
    {
        SC_SANDPLAY_PANEL = self.onReceiveMapInfo,
        SC_SANDPLAY_MAP_UPDATE = self.onReceiveMapEventUpdata,

        SC_FISHING_PANEL = self.onReceiveFishingInitInfo,
        SC_FISHING_TASK_UPDATE = self.onReceiveFishingTaskInfo,
        SC_FISHING = self.onReceiveFishing,

        SC_HAPPY_FARM_FIELD_LIST = self.onReceiveHappyFarmEventList,
        SC_HAPPY_FARM_ORDER_LIST = self.onReceiveHappyFarmTaskList,
    }
end
-------------------------------------------------------------数据--------------------------------------------------------
-----------------------------接收
function onReceiveHappyFarmEventList(self, msg)
    -- logAll(msg, "*s2c* 农场事件列表 18190")
    sandPlay.SandPlayManager:parseHappyFarmEventInfoDic(msg.farm_field_list)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_EVENT_UPDATE)
end

function onReceiveHappyFarmTaskList(self, msg)
    -- logAll(msg, "*s2c* 农场订单列表 18191")
    sandPlay.SandPlayManager:parseHappyFarmTaskData(msg.order_ids)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_TASK_REFRESH)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function onReceiveFishingInitInfo(self, msg)
    -- logAll(msg, "收到钓鱼基础信息")
    sandPlay.SandPlayManager:parseFishingInitData(msg)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_RECEIVE_INFO)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function onReceiveFishingTaskInfo(self, msg)
    -- logAll(msg, "钓鱼任务更新")
    sandPlay.SandPlayManager:parseFishingTaskData(msg.task_info)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_RECEIVE_ACHIEVE)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function onReceiveFishing(self, msg)
    -- logAll(msg, "钓鱼返回 = ")

    sandPlay.SandPlayManager:parseFishingFishData(msg.fish_info)
    sandPlay.SandPlayManager:setCurFishingFishResult(msg)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_RECEIVE_FISH)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function onReceiveMapInfo(self, msg)
    -- logAll(msg, "SC_SANDPLAY_PANEL = ")

    sandPlay.SandPlayManager:initMapEventInfo(msg.map_list)

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_RECEIVE_MAPEVENTINFO)
end

function onReceiveMapEventUpdata(self, msg)
    -- logAll(msg, "SC_SANDPLAY_MAP_UPDATE = ")

    sandPlay.SandPlayManager:refreshMapEvent(msg.map_id, msg.npc_id, msg.event_id)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_RECEIVE_MAPEVENT_TRIGGER, {map_id = msg.map_id, npc_id = msg.npc_id, event_id = msg.event_id})
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_CHECK_NPCTHING)
end

-----------------------------请求
function onReqHappyFarmPlant(self, args)
    ---农田args： 收获 {0} 开荒 {1}  种植{2,种子id}浇水 {3}
    ---家禽args： 收获{0} 养殖{1,种子Id}

    local cmd = {field_id = args.field_id, args = args.params}
    -- logAll(cmd, "请求操作开心农场作物 18192")
    SOCKET_SEND(Protocol.CS_FARM_OPERATE, cmd)
end

function onReqHappyFarmFinishTask(self, args)
    local cmd = {order_id = args}
    -- logAll(cmd, "请求提交开心农场订单任务 18194")

    SOCKET_SEND(Protocol.CS_SUBMIT_ORDER, cmd)
end

function onReqHappyFarmReapChicken(self, args)
    local cmd = {seed_id = args}
    -- logAll(cmd, "请求一键收鸡蛋 18194")

    SOCKET_SEND(Protocol.CS_UNIFY_COLLECT, cmd)
end

function onReqFishing(self, fishInfo)
    local cmd = {fish_id = fishInfo.fish_id, bait = fishInfo.bait_id, size = fishInfo.size}
    -- logAll(cmd, "请求钓鱼成功")
    SOCKET_SEND(Protocol.CS_FISHING, cmd, Protocol.SC_FISHING)
end

function onReqTask(self, task_id)
    local cmd = {task_id_list = {task_id}}
    -- logAll(cmd, "钓鱼请求领取成就成功")
    SOCKET_SEND(Protocol.CS_FISHING_TASK_GAIN, cmd, Protocol.SC_FISHING_TASK_UPDATE)
end

function onReqCollect(self, collect_id)
    local cmd = {collect_id = collect_id}
    -- logAll(cmd, "钓鱼请求领取奖励成功")
    SOCKET_SEND(Protocol.CS_FISHING_COLLECT_GAIN, cmd, Protocol.SC_FISHING_PANEL)

end

--事件触发
function onReqEventTrigger(self, args)
    local map_id = sandPlay.SandPlayManager:getMapId(dup_id)
    if sandPlay.SandPlayManager:getMapEventIsPass(map_id, args.npc_id, args.event_id) then
        return
    end

    local cmd = {map_id = map_id, npc_id = args.npc_id, event_id = args.event_id}
    -- logAll(cmd, "请求事件触发 -----")
    SOCKET_SEND(Protocol.CS_SANDPLAY_TRIGGER_EVENT, cmd, Protocol.SC_SANDPLAY_MAP_UPDATE)

end
--------------------------------------------------------------打开UI界面(其他与角色玩家)----------------------------------------------------------------------
-- 打开沙盒场景战斗界面
function onOpenSandPlaySceneUI(self, args)
    if self.mSandPlaySceneUI == nil then
        self.mSandPlaySceneUI = UI.new(sandPlay.SandPlaySceneUI)
        self.mSandPlaySceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlaySceneUI, self)
    end
    self.mSandPlaySceneUI:open(args)
end

-- 关闭沙盒场景战斗界面
function onCloseSandPlaySceneUI(self)
    if self.mSandPlaySceneUI then
        self.mSandPlaySceneUI:close()
    end
end

-- ui销毁
function onDestroySandPlaySceneUI(self)
    self.mSandPlaySceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlaySceneUI, self)
    self.mSandPlaySceneUI = nil
end

-- 打开地图界面
function onOpenSandPlayMapPanel(self, args)
    if self.mSandPlayMapPanel == nil then
        self.mSandPlayMapPanel = UI.new(sandPlay.SandPlayMapPanel)
        self.mSandPlayMapPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayMapPanel, self)
    end
    self.mSandPlayMapPanel:open(args)
end

-- 关闭地图界面
function onCloseSandPlayMapPanel(self)
    if self.mSandPlayMapPanel then
        self.mSandPlayMapPanel:close()
    end
end

-- ui销毁
function onDestroySandPlayMapPanel(self)
    self.mSandPlayMapPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayMapPanel, self)
    self.mSandPlayMapPanel = nil
end

-- 打开钓鱼界面
function onOpenSandPlayFishingUI(self, args)
    if self.mSandPlayFishingUI == nil then
        self.mSandPlayFishingUI = UI.new(sandPlay.SandPlayFishingUI)
        self.mSandPlayFishingUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayFishingUI, self)
    end
    self.mSandPlayFishingUI:open(args)
end

-- 关闭钓鱼界面
function onCloseSandPlayFishingUI(self)
    if self.mSandPlayFishingUI then
        self.mSandPlayFishingUI:close()
    end
end

-- ui销毁
function onDestroySandPlayFishingUI(self)
    self.mSandPlayFishingUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayFishingUI, self)
    self.mSandPlayFishingUI = nil
end

-- 打开钓鱼图鉴界面
function onOpenSandPlayFishingAtlasPanel(self, args)
    if self.mSandPlayFishingAtlasPanel == nil then
        self.mSandPlayFishingAtlasPanel = UI.new(sandPlay.SandPlayFishingAtlasPanel)
        self.mSandPlayFishingAtlasPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayFishingAtlasPanel, self)
    end
    self.mSandPlayFishingAtlasPanel:open(args)
end

-- ui销毁
function onDestroySandPlayFishingAtlasPanel(self)
    self.mSandPlayFishingAtlasPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayFishingAtlasPanel, self)
    self.mSandPlayFishingAtlasPanel = nil
end

-- 打开钓鱼图鉴界面
function onOpenSandPlayFishingResultPanel(self, args)
    if self.mSandPlayFishingResultPanel == nil then
        self.mSandPlayFishingResultPanel = UI.new(sandPlay.SandPlayFishingResultPanel)
        self.mSandPlayFishingResultPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayFishingResultPanel, self)
    end
    self.mSandPlayFishingResultPanel:open(args)
end

-- ui销毁
function onDestroySandPlayFishingResultPanel(self)
    self.mSandPlayFishingResultPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayFishingResultPanel, self)
    self.mSandPlayFishingResultPanel = nil
end

-- 打开钓鱼教程界面
function onOpenSandPlayFishingTeachingView(self, args)
    if self.mSandPlayFishingTeachingView == nil then
        self.mSandPlayFishingTeachingView = UI.new(sandPlay.SandPlayFishingTeachingView)
        self.mSandPlayFishingTeachingView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayFishingTeachingView, self)
    end
    self.mSandPlayFishingTeachingView:open(args)
end

-- ui销毁
function onDestroySandPlayFishingTeachingView(self)
    self.mSandPlayFishingTeachingView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayFishingTeachingView, self)
    self.mSandPlayFishingTeachingView = nil
end

-- 打开副本界面
function onOpenSandPlayDupInfoPanel(self, args)
    if self.mSandPlayDupInfoPanel == nil then
        self.mSandPlayDupInfoPanel = UI.new(sandPlay.SandPlayDupInfoPanel)
        self.mSandPlayDupInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayDupInfoPanel, self)
    end
    self.mSandPlayDupInfoPanel:open(args)
end

-- ui销毁
function onDestroySandPlayDupInfoPanel(self)
    self.mSandPlayDupInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayDupInfoPanel, self)
    self.mSandPlayDupInfoPanel = nil
end

-- 打开开心农场订单界面
function onOpenSandPlayHappyFarmTaskPanel(self, args)
    if self.mSandPlayHappyFarmTaskPanel == nil then
        self.mSandPlayHappyFarmTaskPanel = UI.new(sandPlay.SandPlayHappyFarmTaskPanel)
        self.mSandPlayHappyFarmTaskPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayHappyFarmTaskPanel, self)
    end
    self.mSandPlayHappyFarmTaskPanel:open(args)
end

-- ui销毁
function onDestroySandPlayHappyFarmTaskPanel(self)
    self.mSandPlayHappyFarmTaskPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayHappyFarmTaskPanel, self)
    self.mSandPlayHappyFarmTaskPanel = nil
end

-- 打开开心农场商店界面
function onOpenSandPlayHappyFarmShopPanel(self, args)
    if self.mSandPlayHappyFarmShopPanel == nil then
        self.mSandPlayHappyFarmShopPanel = UI.new(sandPlay.SandPlayHappyFarmShopPanel)
        self.mSandPlayHappyFarmShopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayHappyFarmShopPanel, self)
    end
    self.mSandPlayHappyFarmShopPanel:open(args)
end

-- ui销毁
function onDestroySandPlayHappyFarmShopPanel(self)
    self.mSandPlayHappyFarmShopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayHappyFarmShopPanel, self)
    self.mSandPlayHappyFarmShopPanel = nil
end

-- 打开开心农场种植仓库界面
function onOpenSandPlayHappyFarmField(self, args)
    if self.mSandPlayHappyFarmField == nil then
        self.mSandPlayHappyFarmField = UI.new(sandPlay.SandPlayHappyFarmField)
        self.mSandPlayHappyFarmField:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayHappyFarmField, self)
    end
    self.mSandPlayHappyFarmField:open(args)
end

-- 关闭开心农场种植仓库界面
function onCloseSandPlayHappyFarmField(self, args)
    if self.mSandPlayHappyFarmField then
        self.mSandPlayHappyFarmField:close()
    end
end

-- ui销毁
function onDestroySandPlayHappyFarmField(self)
    self.mSandPlayHappyFarmField:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayHappyFarmField, self)
    self.mSandPlayHappyFarmField = nil
end

-- 打开开心农场养殖界面
function onOpenSandPlayHappyFarmBreedPanel(self, args)
    if self.mSandPlayHappyFarmBreedPanel == nil then
        self.mSandPlayHappyFarmBreedPanel = UI.new(sandPlay.SandPlayHappyFarmBreedPanel)
        self.mSandPlayHappyFarmBreedPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayHappyFarmBreedPanel, self)
    end
    self.mSandPlayHappyFarmBreedPanel:open(args)
end

-- ui销毁
function onDestroySandPlayHappyFarmBreedPanel(self)
    self.mSandPlayHappyFarmBreedPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySandPlayHappyFarmBreedPanel, self)
    self.mSandPlayHappyFarmBreedPanel = nil
end

---------------------------------------------------------------响应------------------------------------------------------------------

function onActivityClose(self, args)
    for i = 1, #args.closeList do
        local activity_id = args.closeList[i]
        if activity_id == activity.ActivityId.MainActivity then
            gs.Message.Show(_TT(95053))

            gs.PopPanelManager.CloseAll(true)
            mainui.MainUIManager:setWaitOpenUIcode(LinkCode.MainUI)
            GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
        end
    end
end

function onBagUpdateHandler(self)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.HappyFarm)
    if not activityVo:getIsCanOpen() then
        return
    end

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)

end

---------------------------------------------------------------请求------------------------------------------------------------------

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
