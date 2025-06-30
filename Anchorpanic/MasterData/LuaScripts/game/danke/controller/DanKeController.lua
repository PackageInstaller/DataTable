-- @FileName:   DanKeController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-05 16:11:19
-- @Copyright:   (LY) 2023 雷焰网络

module("game.danke.controller.DanKeController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_DANKE_STAGEPANEL, self.onOpenDankeStagePanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DANKE_REWARDVIEW, self.onOpenDanKeRewardView, self)
    GameDispatcher:addEventListener(EventName.OPEN_DANKE_SCENEUI, self.onOpenDanKeSceneUI, self)
    GameDispatcher:addEventListener(EventName.CLOSE_DANKE_SCENEUI, self.onCloseDanKeSceneUI, self)
    GameDispatcher:addEventListener(EventName.OPEN_DANKE_PAUSEPANEL, self.onOpenDanKePausePanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DANKE_SKILL_SELECTPANEL, self.onOpenDanKeSkillSelectPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_DANKESETTLEMENTPANEL, self.onOpenDanKeSettlementPanel, self)

    GameDispatcher:addEventListener(EventName.DANKE_ONREQ_GETREWARD, self.onReqDanKeRewardGetAward, self)
    GameDispatcher:addEventListener(EventName.DANKE_ONREQ_PASSSTAGE, self.onReqDanKePassStage, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return
    {
        SC_DANKE_PANEL = onReceiveDanKePanelInfo,
        -- SC_DANKE_TASK_UPDATE = onReceiveDanKeTaskInfo,
        SC_DANKE_GAIN_STAR_AWARD = onReceiveDanKeGetReward,
        SC_UPDATE_DANKE_INFO = onReceiveDanKeDupInfo,
    }
end
-------------------------------------------------------------数据--------------------------------------------------------------------

--------------------------------------------------------------打开UI界面(其他与角色玩家)----------------------------------------------
-- 打开蛋壳副本选择界面
function onOpenDankeStagePanel(self, args)
    if self.mDankeStagePanel == nil then
        self.mDankeStagePanel = UI.new(danke.DankeStagePanel)
        self.mDankeStagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDankeStagePanel, self)
    end
    self.mDankeStagePanel:open(args)
end

-- ui销毁
function onDestroyDankeStagePanel(self)
    self.mDankeStagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDankeStagePanel, self)
    self.mDankeStagePanel = nil
end

-- 打开蛋壳任务界面
function onOpenDanKeRewardView(self, args)
    if self.mDanKeRewardView == nil then
        self.mDanKeRewardView = UI.new(danke.DanKeRewardView)
        self.mDanKeRewardView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKeRewardView, self)
    end
    self.mDanKeRewardView:open(args)
end

-- ui销毁
function onDestroyDanKeRewardView(self)
    self.mDanKeRewardView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKeRewardView, self)
    self.mDanKeRewardView = nil
end

-- 打开蛋壳场景战斗界面
function onOpenDanKeSceneUI(self, args)
    if self.mDanKeSceneUI == nil then
        self.mDanKeSceneUI = UI.new(danke.DanKeSceneUI)
        self.mDanKeSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKeSceneUI, self)
    end
    self.mDanKeSceneUI:open(args)
end

-- ui销毁
function onDestroyDanKeSceneUI(self)
    self.mDanKeSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKeSceneUI, self)
    self.mDanKeSceneUI = nil
end

-- 关闭蛋壳场景战斗界面
function onCloseDanKeSceneUI(self)
    if self.mDanKeSceneUI then
        self.mDanKeSceneUI:close()
    end
end

-- 打开蛋壳战斗暂停界面
function onOpenDanKePausePanel(self, args)
    if self.mDanKePausePanel == nil then
        self.mDanKePausePanel = UI.new(danke.DanKePausePanel)
        self.mDanKePausePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKePausePanel, self)
    end
    self.mDanKePausePanel:open(args)
end

-- ui销毁
function onDestroyDanKePausePanel(self)
    self.mDanKePausePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKePausePanel, self)
    self.mDanKePausePanel = nil
end

-- 打开蛋壳战斗武器选择界面
function onOpenDanKeSkillSelectPanel(self, args)
    if self.mDanKeSkillSelectPanel == nil then
        self.mDanKeSkillSelectPanel = UI.new(danke.DanKeSkillSelectPanel)
        self.mDanKeSkillSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKeSkillSelectPanel, self)
        self.mDanKeSkillSelectPanel:open(args)
    else
        self.mDanKeSkillSelectPanel:refreshSkill(args)
    end
end

-- ui销毁
function onDestroyDanKeSkillSelectPanel(self)
    self.mDanKeSkillSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKeSkillSelectPanel, self)
    self.mDanKeSkillSelectPanel = nil
end

-- 打开蛋壳结算界面
function onOpenDanKeSettlementPanel(self, args)
    if self.mDanKeSettlementPanel == nil then
        self.mDanKeSettlementPanel = UI.new(danke.DanKeSettlementPanel)
        self.mDanKeSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKeSettlementPanel, self)
    end
    self.mDanKeSettlementPanel:open(args)
end

-- ui销毁
function onDestroyDanKeSettlementPanel(self)
    self.mDanKeSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDanKeSettlementPanel, self)
    self.mDanKeSettlementPanel = nil
end

---------------------------------------------------------------响应------------------------------------------------------------------

--面板数据
function onReceiveDanKePanelInfo(self, msg)
    -- logAll(msg,"*s2c* 蛋壳面板 18170")
    for _, stage_info in pairs(msg.dup_list) do
        danke.DanKeManager:setPassStageStar(stage_info)
    end

    -- for _, taskInfo in pairs(msg.task_info) do
    --     danke.DanKeManager:setTaskInfo(taskInfo)
    -- end

    for _, rewardId in pairs(msg.gain_star_award_list) do
        danke.DanKeManager:setRewardState(rewardId)
    end

    GameDispatcher:dispatchEvent(EventName.DANKE_RECEIVE_STAGE)
    GameDispatcher:dispatchEvent(EventName.DANKE_RECEIVE_REWARD)

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

-- --任务更新
-- function onReceiveDanKeTaskInfo(self, msg)
--     danke.DanKeManager:setTaskInfo(msg.task_info)

--     GameDispatcher:dispatchEvent(EventName.DANKE_RECEIVE_REWARD)
--     GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
-- end

--奖励领取
function onReceiveDanKeGetReward(self, msg)
    if msg.result == 0 then
        logError("领取错误")
        return
    end

    for _, rewardId in pairs(msg.id_list) do
        danke.DanKeManager:setRewardState(rewardId)
    end
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)

    GameDispatcher:dispatchEvent(EventName.DANKE_RECEIVE_REWARD)
end

--关卡信息更新
function onReceiveDanKeDupInfo(self, msg)
    -- logAll(msg,"*s2c* 关卡更新 18175")
    danke.DanKeManager:setPassStageStar(msg.dup_info)
    GameDispatcher:dispatchEvent(EventName.DANKE_RECEIVE_STAGE)
end

---------------------------------------------------------------请求------------------------------------------------------------------

-- --向后端记录任务进度
-- function onReqDanKeTaskProcess(self)
--     local taskConfigDic = danke.DanKeManager:getTaskConfigVoDic()

--     local type_dic = {}
--     for task_id, taskConfigVo in pairs(taskConfigDic) do
--         type_dic[taskConfigVo.type] = 1
--     end

--     local list = {}
--     for _key, v in pairs(type_dic) do
--         local value = 0
--         if _key == 1 then
--             local playerThing = danke.DanKeSceneController:getPlayerThing()
--             local attr = playerThing:getAttr()
--             value = attr.kill_num
--         elseif _key == 2 then
--             value = math.floor(danke.DanKeSceneController:getDupTime())
--         end

--         table.insert(list, {key = _key, value = value})
--     end
--     logAll(list, "CS_DANKE_EVENT")
--     SOCKET_SEND(Protocol.CS_DANKE_EVENT, {event_list = list})
-- end

--请求领取任务奖励
function onReqDanKeRewardGetAward(self, reward_id_list)
    -- logAll(reward_id_list, "请求领取任务奖励")
    SOCKET_SEND(Protocol.CS_DANKE_GAIN_STAR_AWARD, {id_list = reward_id_list, Protocol.SC_DANKE_GAIN_STAR_AWARD})
end

--请求通关关卡
function onReqDanKePassStage(self, kill_monster_id)
    local dup_id = danke.DanKeManager:getStage_id()
    local kill_count = 0
    local playerThing = danke.DanKeSceneController:getPlayerThing()
    if playerThing then
        local attr = playerThing:getAttr()
        kill_count = attr.kill_num
    end

    local settlementStar_count = danke.DanKeManager:getStageStarByInfo(dup_id, kill_count, kill_monster_id)
    local cacheMaxStar = danke.DanKeManager:getPassStageMaxStar(dup_id)
    
    --打开结算界面
    GameDispatcher:dispatchEvent(EventName.OPEN_DANKESETTLEMENTPANEL, settlementStar_count)
    if settlementStar_count <= cacheMaxStar then
        -- logAll("【蛋壳】没有星级改变，不请求通关关卡")
        return
    end

    --向后端发送结算数据
    local cmd = {dup_id = dup_id, kill_count = kill_count, special_kill = {kill_monster_id}}
    -- logAll(cmd, "请求通关关卡")
    SOCKET_SEND(Protocol.CS_PASS_DANKE, cmd)
end

return _M
