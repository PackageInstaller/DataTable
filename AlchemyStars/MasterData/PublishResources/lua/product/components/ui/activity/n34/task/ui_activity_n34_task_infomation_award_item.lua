_class("UIActivityN34TaskInfomationAwardItem", UICustomWidget)
UIActivityN34TaskInfomationAwardItem = UIActivityN34TaskInfomationAwardItem

function UIActivityN34TaskInfomationAwardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIActivityN34TaskInfomationAwardItem:_GetComponents()
  self._background = self:GetUIComponent("Image", "Background")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._count = self:GetUIComponent("UILocalizationText", "Count")
end

function UIActivityN34TaskInfomationAwardItem:SetData(data, callBack, bigAwardItem)
  self._data = data
  self._callback = callBack
  local cfg = Cfg.cfg_item[self._data.assetid]
  if cfg == nil then
    Log.fatal("cfg_item is nil." .. self._data.assetid)
    return
  end
  self._icon:LoadImage(cfg.Icon)
  self._count:SetText(self._data.count)
end

function UIActivityN34TaskInfomationAwardItem:IconOnClick(go)
  self._callback(self._data.assetid, go.transform.position)
end
