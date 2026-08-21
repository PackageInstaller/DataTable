_class("UIHomelandDecomposeItem", UICustomWidget)
UIHomelandDecomposeItem = UIHomelandDecomposeItem

function UIHomelandDecomposeItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomelandDecomposeItem:InitWidget()
  self.item = self:GetUIComponent("UISelectObjectPath", "item")
  self.selector = self:GetGameObject("Selector")
  self.empty = self:GetGameObject("empty")
  self.itemGo = self:GetGameObject("item")
end

function UIHomelandDecomposeItem:SetData(idx, data, onSelect)
  self._idx = idx
  self._onSelect = onSelect
  if data then
    self.itemGo:SetActive(true)
    self.empty:SetActive(false)
    local itemHome = self.item:SpawnObject("UIItemHomeland")
    local asset = RoleAsset:New()
    asset.assetid = data.assetid
    asset.count = data.count
    itemHome:Flush(asset)
  else
    self.itemGo:SetActive(false)
    self.empty:SetActive(true)
  end
  self:Select(false)
end

function UIHomelandDecomposeItem:AreaOnClick(go)
  self._onSelect(self._idx)
end

function UIHomelandDecomposeItem:Select(select)
  self.selector:SetActive(select)
end
