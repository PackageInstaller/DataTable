local this = class("cellActivityTarget", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _GameEventStore = L_GameEventStore

function this.bind()
  return {
    bgLock = false,
    targetDescribe_Lock = "",
    targetProgress_Lock = "",
    bgProgressing = false,
    targetDescribe_processing = "",
    targetProgress_processing = "",
    bgRewarding = false,
    targetDescribe_reward = "",
    targetProgress_reward = "",
    bgCompleteing = false,
    targetDescribe_complete = "",
    targetProgress_complete = "",
    rewardList = L_Const.ModuleInfo.CellIconBag,
    interactiveBtn = false,
    obj_go = false,
    obj_process = false,
    obj_Line = false,
    fx = false
  }
end

function this.methods()
  return {
    onClick_View = function(self)
      self:emit("onClickReward", 0, self.bind.targetId)
    end,
    onClick_Jump = function(self)
      if self.bind.jumpId then
        L_JumpMgr:jumpTo(self.bind.jumpId)
      end
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {id = 0}
end

function this:open()
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.refreshEntranceReddot, self)
  L_GameStore:listenCallFunc(L_GameStore.event.nDayActivityRefreshAnimation, self.refreshAnimation, self)
end

function this:refresh()
  local state = C_NDaysActivityStore.GetInstance():GetTargetStateByTargetId(self.bind.targetId)
  local complete = state.state == C_ETargetState.Rewarded
  local results = {}
  local rewards = state.rewards
  for j = 0, rewards.Count - 1 do
    table.insert(results, {
      itemType = rewards[j].itemType,
      itemId = rewards[j].itemId,
      itemNum = rewards[j].itemNum,
      isReceived = complete
    })
  end
  self.bind.state = state.state
  self:setTargetReward(results)
end

function this:setTargetReward(rewardList)
  if rewardList ~= nil then
    self.bind.rewardList:clear()
    self.bind.rewardList:insert_array(rewardList)
  end
end

function this:close()
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.refreshEntranceReddot)
  L_GameStore:unListenCallFunc(L_GameStore.event.nDayActivityRefreshAnimation, self.refreshAnimation)
  self.bindComponents.animation.enabled = true
end

function this:refreshAnimation(animationState)
  self.bindComponents.animation.enabled = animationState[1]
end

function this:refreshEntranceReddot()
end

return this
