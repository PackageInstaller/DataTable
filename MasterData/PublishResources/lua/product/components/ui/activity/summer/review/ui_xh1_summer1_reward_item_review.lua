_class("UIXH1Summer1RewardItemReview", UICustomWidget)
UIXH1Summer1RewardItemReview = UIXH1Summer1RewardItemReview

function UIXH1Summer1RewardItemReview:OnShow()
  self._hasGet = self:GetGameObject("HasGet")
  self._canGet = self:GetGameObject("CanGet")
  self._unComplete = self:GetGameObject("UnComplete")
  self._percentLabel = self:GetUIComponent("UILocalizationText", "Percent")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._icon = self:GetGameObject("Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
end

function UIXH1Summer1RewardItemReview:SetData(data, callback, collectCallback)
  self._data = data
  self._callback = callback
  self._collectCallback = collectCallback
  self._hasGet:SetActive(false)
  self._canGet:SetActive(false)
  self._unComplete:SetActive(false)
  if self._data.status == 1 then
    self._hasGet:SetActive(true)
  elseif self._data.status == 2 then
    self._canGet:SetActive(true)
  elseif self._data.status == 3 then
    self._unComplete:SetActive(true)
  end
  local processStr = math.floor(data.progress)
  self._percentLabel:SetText(processStr .. "%")
  local roleAsset = self._data.rewards[1]
  local cfg = Cfg.cfg_item[roleAsset.assetid]
  self._iconLoader:LoadImage(cfg.Icon)
  self._countLabel:SetText(roleAsset.count)
end

function UIXH1Summer1RewardItemReview:IconOnClick()
  if self._callback then
    local roleAsset = self._data.rewards[1]
    self._callback(roleAsset, self._icon.transform.position)
  end
end

function UIXH1Summer1RewardItemReview:CanGetOnClick(go)
  self._collectCallback(self._data.progress)
  self._hasGet:SetActive(true)
  self._canGet:SetActive(false)
end
