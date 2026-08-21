_class("UIDrawCardAwardConversionOneDetailItem", UICustomWidget)
UIDrawCardAwardConversionOneDetailItem = UIDrawCardAwardConversionOneDetailItem

function UIDrawCardAwardConversionOneDetailItem:OnShow()
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.item = self:GetUIComponent("RawImageLoader", "item")
  self.itemObject = self:GetGameObject("item")
  self.pop = self:GetUIComponent("UISelectObjectPath", "item")
end

function UIDrawCardAwardConversionOneDetailItem:SetData(data)
  local cfg = Cfg.cfg_item
  self.itemData = data
  if self.itemData[1] == 0 then
    self.item:LoadImage("icon_item_3000020")
    self.count.color = Color(0.8705882352941177, 0.7764705882352941, 0.3843137254901961)
  else
    self.item:LoadImage(cfg[self.itemData[1]].Icon)
    self.count.color = Color(0.8352941176470589, 0.8352941176470589, 0.8352941176470589)
  end
  self.count:SetText(self.itemData[2])
end

function UIDrawCardAwardConversionOneDetailItem:ItemOnClick(go)
  if self.itemData[1] ~= 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self.itemData[1], self.itemObject.transform.position)
  end
end

function UIDrawCardAwardConversionOneDetailItem:OnHide()
end
