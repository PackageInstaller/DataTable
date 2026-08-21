_class("UIN34TaskDelegatePersonTaskReward", UICustomWidget)
UIN34TaskDelegatePersonTaskReward = UIN34TaskDelegatePersonTaskReward

function UIN34TaskDelegatePersonTaskReward:OnShow(uiParams)
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._trustIcon = self:GetGameObject("TrustIcon")
  self._icon = self:GetGameObject("Icon")
  self._go = self:GetGameObject()
  self._imageGO = self:GetGameObject("Image")
end

function UIN34TaskDelegatePersonTaskReward:SetData(isTrust, reward, callback)
  self._callback = callback
  self._countLabel:SetText(reward.count)
  self._reward = reward
  if isTrust then
    self._trustIcon:SetActive(true)
    self._icon:SetActive(false)
  else
    self._trustIcon:SetActive(false)
    self._icon:SetActive(true)
    local cfg_item = Cfg.cfg_item[reward.assetid]
    if not cfg_item then
      return
    end
    local icon = cfg_item.Icon
    self._iconLoader:LoadImage(icon)
    self._imageGO:SetActive(icon ~= "n34_dc_icon06")
  end
end

function UIN34TaskDelegatePersonTaskReward:IconOnClick()
  if self._callback then
    self._callback(self._reward.assetid, self._go.transform.position)
  end
end
