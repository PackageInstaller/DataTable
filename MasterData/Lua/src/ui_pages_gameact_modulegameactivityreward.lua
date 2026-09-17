local this = class("moduleGameActivityReward", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local enumRewardState = {
  None = 0,
  CanNotReceived = 1,
  NotReceived = 2,
  Received = 3
}
local singleRewardData = {
  reward_id = 0,
  reward_state = enumRewardState.None
}
local rewardData = {
  reward_id = 0,
  reward_list = {}
}

function this.bind()
  return {txt_rewardNum = ""}
end

function this.methods()
  return {
    onClick_openRewardPage = function(self)
      local tpl = _GameEventTpl:getTplById(self.bind.id)
      local eType = _GameEventTpl:getType(tpl)
      if eType == L_Const.ActivityType.AT_REPEAT_EVENT then
        L_UI:open("PageGameActRedungeonTask")
      else
        L_UI:open("pageGameActivityReward", {
          id = self.bind.id
        })
      end
      L_AudioUtil.playSound("Play_SFX_System_UI_EnTrust_Championship_Reward_Open")
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    all_reward_list = {}
  }
end

function this:open()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshRedDotCallback, self)
end

function this:close()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventReward, self.refreshRedDotCallback, self)
end

function this:initRewardData(activityId)
  self.bind.id = activityId
  self.data.reward_state_list = L_GameEventStore:getGameEventData(self.bind.id):getRewardStateList()
  local rewardNum, totalNum = self:CalculateRewardNum(self.data.reward_state_list)
  if rewardNum ~= nil and totalNum ~= nil then
    self:refreshRewardNum(rewardNum .. "/" .. totalNum)
  end
  self:registerRedDot()
  local isNew = self:hasNewData(self.bind.id)
  self:refreshRedDot(isNew)
end

function this:refreshRedDotCallback()
  local isNew = self:hasNewData(self.bind.id)
  self:refreshRedDot(isNew)
end

function this:setReddotState(isShowReddot)
  self:refreshRedDot(isShowReddot)
end

function this:CalculateRewardNum(dataList)
  local rewardNum = 0
  local totalNum = 0
  if dataList == nil or #dataList == 0 then
    printf("活动" .. "奖励数据为空")
    return
  end
  for _, rewardData in ipairs(dataList) do
    if rewardData.reward_state == L_Const.ActivityRewardState.ARS_REWARDED then
      rewardNum = rewardNum + 1
    end
    totalNum = totalNum + 1
  end
  return rewardNum, totalNum
end

function this:registerRedDot()
  L_ReddotManager:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.GameAct_Events_Group_Reward, self.bind.id))
end

function this:refreshRedDot(isNew)
  if self.isBind == false then
    return
  end
  if isNew then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_Events_Group_Reward, self.bind.id)
  else
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_Events_Group_Reward, self.bind.id)
  end
  if self.bindComponents ~= nil and L_CommonUtil.isValid(self.bindComponents.reddotnew) then
    self.bindComponents.reddotnew.gameObject:SetActive(isNew)
  end
end

function this:hasNewData(id)
  local red_point = L_GameEventStore:getGameEventData(id):getRedPointData()
  local is_new = false
  for i, v in pairs(red_point) do
    if v == true then
      is_new = true
      break
    end
  end
  return is_new
end

function this:refreshRewardNum(rewardNum)
  self.bind.txt_rewardNum = rewardNum
end

return this
