_class("UICollectCardAwardViewItem", UICustomWidget)
UICollectCardAwardViewItem = UICollectCardAwardViewItem

function UICollectCardAwardViewItem:OnShow(uiParam)
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._nameTex = self:GetUIComponent("UILocalizationText", "NameTex")
  self._number = self:GetUIComponent("UILocalizationText", "Number")
end

function UICollectCardAwardViewItem:SetData(id, count, callback)
  self._id = id
  self._callback = callback
  local cfg = Cfg.cfg_item[self._id]
  local icon = cfg.Icon
  self._icon:LoadImage(icon)
  self._number:SetText("x" .. count)
  self._nameTex:SetText(StringTable.Get(cfg.Name))
end

function UICollectCardAwardViewItem:IconOnClick(go)
  if self._callback then
    self._callback(self._id, go.transform.position)
  end
end
