local moduleActivityTravelLog = class("moduleActivityTravelLog", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local _GameEventStore = L_GameEventStore
local ETaskStateDef = {
  Lock = 1,
  Unlock = 2,
  Finished = 3
}

function moduleActivityTravelLog:ctor(...)
  moduleActivityTravelLog.super.ctor(self, ...)
  self.id = 0
  self.gameEventData = nil
end

function moduleActivityTravelLog.bind()
  return {
    moduleActivityBg = {
      moduleName = "pages/GameAct/moduleActivityBg"
    },
    moduleEffectFolder = {
      moduleName = "pages/gameAct/moduleTripleFolderEffect"
    },
    textDate = "",
    textGo = "",
    textFinished = "",
    textDesc = "",
    nodeGoState = true,
    nodeFinishedState = false,
    nodeConditionState = false,
    listReward = {
      moduleName = "modulePages/cellIconBag"
    },
    condition_list = {
      moduleName = "pages/gameAct/cellLockCondition"
    }
  }
end

function moduleActivityTravelLog.methods()
  return {
    OnClick_Go = function(self)
      L_JumpMgr:jumpTo(self.commonJumpId)
    end,
    onClick_help = function(self)
      if math.isEmpty(self.helpGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end
  }
end

function moduleActivityTravelLog:open()
  self.bind.textGo = L_WordsTpl:getValue("ui_gameevents_gotosee")
  self.bind.textFinished = L_WordsTpl:getValue("ui_game_events_subitem_allfinish")
  if self.bindComponents.soulEssenceTran and Unity.Screen.width / Unity.Screen.height == 1.0 then
    local posY = self.bindComponents.soulEssenceTran.localPosition.y
    self.bindComponents.soulEssenceTran.localPosition = L_Vector3.new(-244, posY, 0)
  end
  self.onEvent_journeyTaskUpdate = handler(self, self.onJourneyTaskUpdate)
  AzurWorld.JourneyMgr:RegisterEvent(C_EJourneyEvent.UpdateJourneyTaskServerData, self.onEvent_journeyTaskUpdate)
end

function moduleActivityTravelLog:close()
  if self.onEvent_journeyTaskUpdate ~= nil then
    AzurWorld.JourneyMgr:UnregisterEvent(C_EJourneyEvent.UpdateJourneyTaskServerData, self.onEvent_journeyTaskUpdate)
    self.onEvent_journeyTaskUpdate = nil
  end
end

function moduleActivityTravelLog:onJourneyTaskUpdate()
  if self.id == 0 or not self.gameEventData then
    return
  end
  self:onRefreshUnlockState()
end

function moduleActivityTravelLog:setActId(id)
  self.id = id
  self.gameEventData = _GameEventStore:getGameEventData(id)
  self:onRefresh()
  local itemId = AzurWorld.JourneyMgr:GetBigRewardItemId()
  self.modules.moduleEffectFolder:StopAnim()
  self.modules.moduleEffectFolder:receiveRewards(itemId)
end

function moduleActivityTravelLog:onRefresh()
  if not self.gameEventData then
    errorf("活动", "没有找到对应id的活动数据 id: " .. self.id)
    return
  end
  local tpl = _GameEventTpl:getTplById(self.id)
  self.gameEvent = self.gameEventData:getGameEvent()
  self.serverData = L_GameEventStore:getGameEventData(self.id)
  self.bind.textDesc = L_Lang:get(_GameEventTpl:getDesc(tpl))
  self.bind.textDate = L_Lang:get(_GameEventTpl:getFakeTime(tpl))
  local rewardTemps = _GameEventTpl:getRewardShow(tpl)
  local rewards = {}
  for i, reward in ipairs(rewardTemps) do
    local item = {}
    item[1] = reward[1]
    item[2] = reward[2]
    item[3] = reward[3]
    table.insert(rewards, item)
  end
  self:CheckAndReplaceItem(rewards)
  local rewardData = L_DataUtil.parseRewardConfig(rewards)
  self.bind.listReward:clear()
  self.bind.listReward:insert_array(rewardData)
  self.helpGroupId = _GameEventTpl:getHelp(tpl)
  self.commonJumpId = _GameEventTpl:getCommonJump(tpl)
  self:onRefreshUnlockState()
end

function moduleActivityTravelLog:CheckAndReplaceItem(rewards)
  local keys = L_DataUtil.getListIdx(rewards)
  for i = 1, #keys do
    local reward = rewards[keys[i]]
    if reward ~= nil then
      local itemType = reward[1]
      local itemId = reward[2]
      local tpl = commonItemTpl:getTplById(itemId)
      if tpl ~= nil then
        local _type = commonItemTpl:getType(tpl)
        if _type and _type == 441 then
          reward[2] = AzurWorld.JourneyMgr:CheckAndReplaceQiboSelectResult(itemId)
        end
      end
    end
  end
end

function moduleActivityTravelLog:onRefreshUnlockState()
  self.isUnlock = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.journeyTask)
  self.curTaskState = self.isUnlock and ETaskStateDef.Unlock or ETaskStateDef.Lock
  if not self.isUnlock then
    local tpl = _GameEventTpl:getTplById(self.id)
    local conditions = _GameEventTpl:getCondition(tpl)
    self.bind.condition_list:clear()
    for i, v in ipairs(conditions) do
      self.isUnlock = false
      local data = {}
      table.insert(data, {
        lockParam = {
          _GameEventTpl:getLockJump(tpl)[i]
        },
        txt_lockDesc = L_Lang:get(_GameEventTpl:getLockText(tpl)[i])
      })
      self.bind.condition_list:insert_array(data)
    end
  else
    local isFinished = AzurWorld.JourneyMgr:AllRewardComplete()
    self.curTaskState = isFinished and ETaskStateDef.Finished or self.curTaskState
  end
  self:onRefreshBtnState()
end

function moduleActivityTravelLog:onSetTaskState(state)
  self.curTaskState = state
  self:onRefreshBtnState()
end

function moduleActivityTravelLog:onRefreshBtnState()
  self.bind.nodeGoState = self.curTaskState == ETaskStateDef.Unlock
  self.bind.nodeConditionState = self.curTaskState == ETaskStateDef.Lock
  self.bind.nodeFinishedState = self.curTaskState == ETaskStateDef.Finished
end

function moduleActivityTravelLog:checkPreMissionIsComplete()
  local tpl = _GameEventTpl:getTplById(self.id)
  local taskId = _GameEventTpl:getGuideTaskId(tpl)
  if taskId == 0 then
    return true
  end
  return AzurWorld.TaskMgr:IsFinishTask(taskId)
end

return moduleActivityTravelLog
