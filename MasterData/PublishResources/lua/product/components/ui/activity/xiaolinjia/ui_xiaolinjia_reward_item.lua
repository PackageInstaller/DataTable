_class("UIXiaoLinJiaRewardItem", UICustomWidget)
UIXiaoLinJiaRewardItem = UIXiaoLinJiaRewardItem

function UIXiaoLinJiaRewardItem:Constructor()
end

function UIXiaoLinJiaRewardItem:OnShow(uiParams)
  self.rewardRoot = self:GetGameObject("rewardItems")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.firstIn = true
end

function UIXiaoLinJiaRewardItem:SetData(index, campaign, quest, status, componentInfo, clickCallback, tipsCallback)
  self._index = index
  self._campaign = campaign
  self._quest = quest:QuestInfo()
  self._state = status or CampaignQuestStatus.CQS_Over
  self._componentInfo = componentInfo
  self._clickCallback = clickCallback
  self._tipsCallback = tipsCallback
  self:_Refresh()
  self:PlayShowAnim()
end

function UIXiaoLinJiaRewardItem:PlayShowAnim()
  if self.firstIn then
    self.firstIn = false
    self:StartTask(function(TT)
      YIELD(TT, self._index * 50)
      self.anim:Play("uieffanim_UIXiaoLinJiaQuestionDBItem_in")
    end)
  end
end

function UIXiaoLinJiaRewardItem:_Refresh()
  self:_SetObject()
  self:_SetTitle()
  self:_SetItem()
  self:_SetState(self._state)
  self:_SetEvent()
end

function UIXiaoLinJiaRewardItem:_SetEvent()
  local count = table.count(self._quest.rewards)
  for i = 1, 3 do
    local btn = self:GetGameObject("icon" .. i)
    self:AddUICustomEventListener(UICustomUIEventListener.Get(btn), UIEvent.Click, function(go)
      if self._quest.rewards[i] then
        self._tipsCallback(self._quest.rewards[i].assetid, go.transform.position)
      end
    end)
  end
end

function UIXiaoLinJiaRewardItem:_SetObject()
  local count = table.count(self._quest.rewards)
  for i = 1, 3 do
    self.rewardRoot.transform:GetChild(i - 1).gameObject:SetActive(i <= count)
  end
end

function UIXiaoLinJiaRewardItem:PlayAnimationInSequence(index)
  local animName, duration = "UIeff_UIXiaoLinJiaRewardItem_in1", 367
  local delay = index * 60
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", animName, delay, duration, nil, false)
end

function UIXiaoLinJiaRewardItem:_SetTitle()
  local title = StringTable.Get(self._quest.CondDesc)
  UIWidgetHelper.SetLocalizationText(self, "_txt_title", title)
end

function UIXiaoLinJiaRewardItem:_SetItem()
  for i, roleAsset in pairs(self._quest.rewards) do
    UIWidgetHelper.SetLocalizationText(self, "count" .. i, roleAsset.count)
    UIWidgetHelper.SetItemIcon(self, roleAsset.assetid, "icon" .. i)
  end
end

function UIXiaoLinJiaRewardItem:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [CampaignQuestStatus.CQS_NotStart] = {},
    [CampaignQuestStatus.CQS_Accepted] = {"inProgress"},
    [CampaignQuestStatus.CQS_Completed] = {"canGet"},
    [CampaignQuestStatus.CQS_Taken] = {"finished"},
    [CampaignQuestStatus.CQS_Over] = {}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIXiaoLinJiaRewardItem:CanGetBtnOnClick()
  if self._clickCallback then
    self._clickCallback(self._quest)
  end
end
