_class("UIFavourPetQuestCell", UICustomWidget)
UIFavourPetQuestCell = UIFavourPetQuestCell

function UIFavourPetQuestCell:SetData(index, campaign, quest, status, clickCallback, tipsCallback)
  self._index = index
  self._campaign = campaign
  self._quest = quest:QuestInfo()
  self._state = status or CampaignQuestStatus.CQS_Over
  self._clickCallback = clickCallback
  self._tipsCallback = tipsCallback
  self:_Refresh()
end

function UIFavourPetQuestCell:_Refresh()
  self:_SetTitle()
  self:_SetItem()
  self:_SetState(self._state)
end

function UIFavourPetQuestCell:PlayAnimationInSequence(index)
  local animName, duration = "uieff_UIFavourPet_Quest_Cell_in", 333
  local delay = index * 66
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", animName, delay, duration, nil, false)
end

function UIFavourPetQuestCell:_SetTitle()
  local title = StringTable.Get(self._quest.CondDesc)
  local cur, total = self._quest.cur_progress, self._quest.total_progress
  local text = string.format("%s(%s/%s)", title, cur, total)
  UIWidgetHelper.SetLocalizationText(self, "_txtDescProg", text)
end

function UIFavourPetQuestCell:_SetItem()
  local roleAsset = self._quest.rewards and self._quest.rewards[1]
  UIWidgetHelper.SetItemIcon(self, roleAsset.assetid, "_rewardIcon")
  UIWidgetHelper.SetLocalizationText(self, "_rewardCount", "*" .. roleAsset.count)
end

function UIFavourPetQuestCell:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [CampaignQuestStatus.CQS_NotStart] = {
      "state_NotStart",
      "_bg_Mask"
    },
    [CampaignQuestStatus.CQS_Accepted] = {
      "state_Accepted"
    },
    [CampaignQuestStatus.CQS_Completed] = {
      "state_Completed"
    },
    [CampaignQuestStatus.CQS_Taken] = {
      "state_Taken",
      "_bg_Mask"
    },
    [CampaignQuestStatus.CQS_Over] = {"state_Over", "_bg_Mask"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIFavourPetQuestCell:RewardOnClick(go)
  if self._tipsCallback then
    local roleAsset = self._quest.rewards and self._quest.rewards[1]
    self._tipsCallback(roleAsset.assetid, go.transform.position)
  end
end

function UIFavourPetQuestCell:CompletedBtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._quest)
  end
end
