_class("UIItemForConversion", UICustomWidget)
UIItemForConversion = UIItemForConversion

function UIItemForConversion:OnShow(uiParams)
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._nameTex = self:GetUIComponent("UILocalizationText", "nameTex")
end

function UIItemForConversion:SetData(info, clickCallback)
  self._tid = info.assetid
  local count = info.count
  self._clickCallback = clickCallback
  local cfg = Cfg.cfg_item[self._tid]
  local itemName = cfg.Name
  self._nameTex:SetText(StringTable.Get(itemName))
  local params = {}
  params.quality = cfg.Color
  params.icon = cfg.Icon
  params.text = count
  self.item = self._pool:SpawnObject("UIAsset")
  self.item:SetItemData(params)
  self.item:SetData(self._tid)
end

function UIItemForConversion:BtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._tid, go.transform.position)
  end
end
