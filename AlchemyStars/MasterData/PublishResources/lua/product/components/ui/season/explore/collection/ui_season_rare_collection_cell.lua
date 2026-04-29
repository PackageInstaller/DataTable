_class("UISeasonRareCollectionCell", UICustomWidget)
UISeasonRareCollectionCell = UISeasonRareCollectionCell

function UISeasonRareCollectionCell:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonRareCollectionCell:InitWidget()
  self.item = self:GetUIComponent("RawImageLoader", "item")
  self.select = self:GetGameObject("select")
  self.new = self:GetGameObject("new")
end

function UISeasonRareCollectionCell:SetData(itemInfo, index, selectIndex, clickCb)
  self.clickCb = clickCb
  self.itemInfo = itemInfo
  self.index = index
  local itemCfg = itemInfo:GetTemplate()
  if not itemCfg then
    Log.error("err UISeasonRareCollectionCell can't find cfg_item with id = " .. templateId)
    return
  end
  self:SetSelect(index == selectIndex)
  self.item:LoadImage(itemCfg.Icon)
  self.isNew = not UISeasonExploreHelper.IsRareItemHasClicked(itemInfo:GetID())
  self.new:SetActive(self.isNew)
end

function UISeasonRareCollectionCell:SetSelect(bSelect)
  self.select:SetActive(bSelect)
end

function UISeasonRareCollectionCell:ItemOnClick(go)
  if self.clickCb then
    self.clickCb(self)
  end
  if self.isNew then
    UISeasonExploreHelper.SetRareItemAsClicked(self.itemInfo:GetID())
    self.new:SetActive(false)
  end
end
