local this = class("moduleGameActivityStarLevel", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this.bind()
  return {
    txt_level = "",
    scroll_to = 1,
    reward_list = {
      moduleName = "pages/gameAct/ActivityStarLevel/cellActivityStarLevelReward"
    }
  }
end

function this.methods()
  return {
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

function this:setActId(id, isRefresh)
  self.activityId = id
  self:initComponents()
  self:initPage(isRefresh)
end

function this:hide()
end

function this:open()
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onRefreshLevel, self)
end

function this:close()
  self.isInit = false
  L_TimerManager:stopTimer(self, "starlevelMoveto")
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshBaseInfo, self.onRefreshLevel)
end

function this:onRefreshLevel()
  local lv = L_PlayerStore:getLv()
  self.bind.txt_level = tostring(lv)
end

function this:initComponents()
  self.bindComponents.gridView_rewardList.Padding.top = 14
  self.bindComponents.gridView_rewardList.Padding.bottom = 14
end

function this:initPage(isRefresh)
  local tpl = _GameEventTpl:getTplById(self.activityId)
  self.helpGroupId = _GameEventTpl:getHelp(tpl)
  local lv = L_PlayerStore:getLv()
  self.bind.txt_level = tostring(lv)
  local list = L_GameEventStore:getGameEventData(self.activityId):getRewardStateList()
  local canRewardIdList = {}
  for _, v in pairs(list) do
    if v.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      table.insert(canRewardIdList, v.reward_id)
    end
    v.callback = self.selectCallBack
  end
  for _, v in pairs(list) do
    v.canRewardIdList = canRewardIdList
    
    function v.refreshPageFunc()
      self:refreshRewardList()
    end
  end
  if self.isInit then
    for i = 1, #list do
      self.bind.reward_list:change(i, list[i])
    end
  else
    self.bind.reward_list:clear()
    self.bind.reward_list:insert_array(list)
  end
  if not isRefresh then
    self:moveToIndex()
  end
  self.isInit = true
end

function this:selectCallBack(group_id, id_list)
  L_GameEventStore:req_CsProtoActivityReward(group_id, id_list, function(data)
    local rewards = require("ui.manager.reward.rewardData").new()
    rewards.rewardShowType = L_Const.rewardShowType.full
    local data = L_DataUtil.parseRewardConfig(data.rewards, true, true)
    rewards:constructList(data)
    L_RewardManager:ShowReward(rewards)
  end)
end

function this:refreshPage()
  self:initPage()
end

function this:refreshRewardList()
  local list = L_GameEventStore:getGameEventData(self.activityId):getRewardStateList()
  for i = 1, #list do
    self.bind.reward_list:change(i, list[i])
  end
end

function this:moveToIndex()
  local index = -1
  local list = L_GameEventStore:getGameEventData(self.activityId):getRewardStateList()
  for i, v in ipairs(list) do
    if v.reward_state == L_Const.ActivityRewardState.ARS_FINISH or v.reward_state == L_Const.ActivityRewardState.ARS_NONE then
      index = i
      break
    end
  end
  local cellHeight = self.bindComponents.cellLockCondition.transform.rect.height
  local viewHeight = self.bindComponents.Viewport.transform.rect.height
  local input_index = index
  if index < 1 then
    input_index = 0
  else
    input_index = index - 1
  end
  if self.isInit then
    self.bindComponents.gridView_rewardList:FocusItemIndex(input_index, true)
  else
    L_TimerManager:newOrResetTimer(self, "starlevelMoveto", function()
      self.bindComponents.gridView_rewardList:FocusItemIndex(input_index, true)
    end, 0.2)
  end
end

return this
