_class("UIN25IdolAchieveReward", UICustomWidget)
UIN25IdolAchieveReward = UIN25IdolAchieveReward

function UIN25IdolAchieveReward:Constructor()
  self._parent = nil
  self._data = nil
  self._itemId = nil
  self._itemCount = 0
end

function UIN25IdolAchieveReward:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._iconImg = self:GetUIComponent("RawImage", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._txtName.gameObject:SetActive(false)
end

function UIN25IdolAchieveReward:OnHide()
end

function UIN25IdolAchieveReward:SetData(parent, data)
  self._parent = parent
  self._data = data
  if data == nil or #data < 2 then
    return
  end
  self._itemId = data[1]
  self._itemCount = data[2]
  local cfgItem = Cfg.cfg_item[self._itemId]
  if cfgItem ~= nil then
    self._iconLoader:LoadImage(cfgItem.Icon)
  end
  self._txtCount:SetText(string.format("%d", self._itemCount))
end

function UIN25IdolAchieveReward:ButtonOnClick(go)
  if self._itemId ~= nil then
    self._parent:OnShowItemInfo(self._itemId, go.transform.position)
  end
end
