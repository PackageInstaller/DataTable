_class("UIFavourPetVote2QuestCell", UICustomWidget)
UIFavourPetVote2QuestCell = UIFavourPetVote2QuestCell

function UIFavourPetVote2QuestCell:SetData(campaign, tipsCallback)
  self._campaign = campaign
  self._cmptId, self._component, self._componentInfo = UIFavourPetHelper.Component_Quest(self._campaign, 2)
  self._tipsCallback = tipsCallback
  self:_Refresh()
end

function UIFavourPetVote2QuestCell:_Refresh()
  self._quest, self._state = self:_GetQuestInfo(1)
  self:_AutoTake(self._state)
  self:_SetItems(self._state)
  self:_SetState(self._state)
end

function UIFavourPetVote2QuestCell:_GetQuestInfo(index)
  local questInfo = self._component:GetQuestInfo()
  local questStatus = self._component:GetCampaignQuestStatus(questInfo)
  local quest = questInfo[index]
  local q = quest:QuestInfo()
  local s = questStatus[quest] or CampaignQuestStatus.CQS_Over
  return q, s
end

function UIFavourPetVote2QuestCell:_AutoTake(state)
  if state == CampaignQuestStatus.CQS_Completed then
    local questInfo = self._quest
    self._component:Start_HandleQuestTake(questInfo.quest_id, function(res, rewards)
      self:_OnGetRewards(res, rewards)
    end)
  end
end

function UIFavourPetVote2QuestCell:_OnGetRewards(res, rewards)
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self:_Refresh()
  else
    self._campaign:CheckErrorCode(res.m_result)
  end
end

function UIFavourPetVote2QuestCell:_SetItems(state)
  local items = self._quest.rewards or {}
  if #items == 0 then
    return
  end
  local isFin = state == CampaignQuestStatus.CQS_Taken
  local objs = UIWidgetHelper.SpawnObjects(self, "_rewards", "UIFavourPetVote2QuestItem", #items)
  for i, v in ipairs(objs) do
    v:SetData(items[i], isFin, self._tipsCallback)
  end
end

function UIFavourPetVote2QuestCell:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [CampaignQuestStatus.CQS_NotStart] = {},
    [CampaignQuestStatus.CQS_Accepted] = {"_txtNormal"},
    [CampaignQuestStatus.CQS_Completed] = {"_txtNormal"},
    [CampaignQuestStatus.CQS_Taken] = {"_txtFin"},
    [CampaignQuestStatus.CQS_Over] = {}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIFavourPetVote2QuestCell:RewardOnClick(go)
  if self._tipsCallback then
    local roleAsset = self._quest.rewards and self._quest.rewards[1]
    self._tipsCallback(roleAsset.assetid, go.transform.position)
  end
end
