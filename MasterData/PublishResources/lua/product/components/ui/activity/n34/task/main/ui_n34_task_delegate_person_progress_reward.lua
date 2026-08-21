_class("UIN34TaskDelegatePersonProgressReward", UICustomWidget)
UIN34TaskDelegatePersonProgressReward = UIN34TaskDelegatePersonProgressReward

function UIN34TaskDelegatePersonProgressReward:OnShow(uiParams)
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._go = self:GetGameObject()
end

function UIN34TaskDelegatePersonProgressReward:SetData(reward, callback)
  self._callback = callback
  self._countLabel:SetText(reward.count)
  local cfg_item = Cfg.cfg_item[reward.assetid]
  self._reward = reward
  if not cfg_item then
    return
  end
  local icon = cfg_item.Icon
  self._iconLoader:LoadImage(icon)
end

function UIN34TaskDelegatePersonProgressReward:IconOnClick()
  if self._callback then
    self._callback(self._reward.assetid, self._go.transform.position)
  end
end
