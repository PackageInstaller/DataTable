_class("UIHomeVisitGiftItem", UICustomWidget)
UIHomeVisitGiftItem = UIHomeVisitGiftItem

function UIHomeVisitGiftItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomeVisitGiftItem:InitWidget()
  self.item = self:GetUIComponent("UISelectObjectPath", "item")
  self.add = self:GetGameObject("add")
  self.itemGo = self:GetGameObject("item")
  self.delBtn = self:GetGameObject("Del")
  self.select = self:GetGameObject("Select")
end

function UIHomeVisitGiftItem:SetData(idx, data, onRemove, onClick)
  self._idx = idx
  self._onRemove = onRemove
  self._onClick = onClick
  if data == nil then
    self.add:SetActive(true)
    self.itemGo:SetActive(false)
    self.delBtn:SetActive(false)
  else
    local itemHome = self.item:SpawnObject("UIItemHomeland")
    local asset = RoleAsset:New()
    asset.assetid = data.assetid
    asset.count = data.count
    itemHome:Flush(asset)
    self.add:SetActive(false)
    self.itemGo:SetActive(true)
    self.delBtn:SetActive(true)
  end
  self:Select(false)
end

function UIHomeVisitGiftItem:DelOnClick(go)
  self._onRemove(self._idx)
end

function UIHomeVisitGiftItem:AreaOnClick(go)
  self._onClick(self._idx, go)
end

function UIHomeVisitGiftItem:Select(select)
  self.select:SetActive(select)
end
