_class("UIBattlePassCN1RewardCell", UICustomWidget)
UIBattlePassCN1RewardCell = UIBattlePassCN1RewardCell

function UIBattlePassCN1RewardCell:SetData(index, campaign, component, clickCallback, tipCallback, preview)
  self._index = index
  self._campaign = campaign
  self._component = component
  self._info = component:ComponentInfo()
  self._clickCallback = clickCallback
  self._tipCallback = tipCallback
  self._rewardObj = {}
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_SetState()
  self:_SetLevel(self._index)
  self:_SetIconReward({adv = false})
  self:_SetIconReward({adv = true})
  local isLast = index == self._info.m_max_level
  local showSplite = not preview and not isLast
  self:GetGameObject("_splite"):SetActive(showSplite)
end

function UIBattlePassCN1RewardCell:_SetState()
  local lvUnlock = self._index <= self._info.m_current_level and 1 or 2
  local goldReward = self._component:IsPreviewLvFromConfig(self._index) and 1 or 2
  local tb_reward = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_bg_Gold"},
    {"_bg_Normal"}
  })
  UIWidgetHelper.SetObjGroupShow(tb_reward, goldReward)
end

function UIBattlePassCN1RewardCell:_SetLevel(lv)
  lv = string.isnullorempty(lv) and "" or tostring(lv)
  UIWidgetHelper.SetLocalizationText(self, "_lv", lv)
end

function UIBattlePassCN1RewardCell:_SetIconReward(args)
  local widgetName = args.adv and "deluxePool" or "standardPool"
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIBattlePassCN1ItemIconReward")
  obj:SetData(self._index, args.adv, self._campaign, self._component, self._clickCallback, self._tipCallback)
  local index = args.adv == true and 2 or 1
  self._rewardObj[index] = obj
end

function UIBattlePassCN1RewardCell:FindClaimItemIcon(index)
  local obj = self._rewardObj[index]
  if obj._state == UIBattlePassCN1ItemIconRewardState.EState_Claim then
    return obj
  end
end
