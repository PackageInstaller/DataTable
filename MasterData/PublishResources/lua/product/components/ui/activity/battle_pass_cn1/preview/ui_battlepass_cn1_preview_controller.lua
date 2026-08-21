_class("UIBattlePassCN1PreviewController", UIController)
UIBattlePassCN1PreviewController = UIBattlePassCN1PreviewController

function UIBattlePassCN1PreviewController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  obj:SetData(function()
    self:CloseDialog()
  end)
end

function UIBattlePassCN1PreviewController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityBattlePassHelper.LoadDataOnEnter(TT, res)
end

function UIBattlePassCN1PreviewController:OnShow(uiParams)
  self:_AttachEvents()
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_SetCommonTopButton()
  self:_SetRewards()
end

function UIBattlePassCN1PreviewController:OnHide()
  self:_DetachEvents()
end

function UIBattlePassCN1PreviewController:_SetRewards()
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_LVReward(self._campaign)
  local rewards = component:GetSortAdvancedRewards()
  self:_SpawnRewards("rewardElite", rewards)
  local rewards = component:GetSortNormalRewards()
  self:_SpawnRewards("rewardStandard", rewards)
end

function UIBattlePassCN1PreviewController:_SpawnRewards(widgetName, rewards)
  local items = UIWidgetHelper.SpawnObjects(self, widgetName, "UIBattlePassCN1ItemIcon", table.count(rewards))
  for i, v in ipairs(items) do
    v:SetData(i, rewards[i], function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end, UIItemScale.Level4)
    local count = 3
    v:PlayAnimationInSequence(math.floor((i - 1) / count))
  end
end

function UIBattlePassCN1PreviewController:CloseBtnOnClick(go)
  Log.info("UIBattlePassCN1PreviewController:CloseBtnOnClick")
  self:CloseDialog()
end

function UIBattlePassCN1PreviewController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIBattlePassCN1PreviewController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIBattlePassCN1PreviewController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end
