_class("UILostLandAwardViewItem", UICustomWidget)
UILostLandAwardViewItem = UILostLandAwardViewItem

function UILostLandAwardViewItem:OnShow()
  self:GetComponents()
end

function UILostLandAwardViewItem:Active(active)
  self._go:SetActive(active)
end

function UILostLandAwardViewItem:SetData(data, callback)
  self._callback = callback
  self._id = data.assetid
  local count = data.count
  local cfg_item = Cfg.cfg_item[self._id]
  if not cfg_item then
    Log.error("###[UILostLandAwardViewItem] cfg_item is nil ! id --> ", self._id)
  end
  self._icon:LoadImage(cfg_item.Icon)
  self._name:SetText(StringTable.Get(cfg_item.Name) .. " x " .. count)
end

function UILostLandAwardViewItem:GetComponents()
  self._go = self:GetGameObject("rect")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
end

function UILostLandAwardViewItem:iconOnClick(go)
  if self._callback then
    self._callback(self._id, go.transform.position)
  end
end
