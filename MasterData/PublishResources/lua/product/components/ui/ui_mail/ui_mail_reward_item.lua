_class("UIMailRewardItem", UICustomWidget)
UIMailRewardItem = UIMailRewardItem

function UIMailRewardItem:OnShow(uiParams)
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self.uiItem:SetClickCallBack(function()
    self:ButtonItemOnClick()
  end)
end

function UIMailRewardItem:Refresh(reward)
  if not reward then
    return
  end
  local templateData = Cfg.cfg_item[reward.assetid]
  if not templateData then
    Log.fatal("###cfg_item is nil ! id --> ", reward.assetid)
    return
  end
  self._matID = reward.assetid
  self._uiItemAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  local icon = templateData.Icon
  local quality = templateData.Color
  local text1 = reward.count
  local text2 = StringTable.Get(templateData.Name)
  local itemId = templateData.ID
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = itemId
  })
end

function UIMailRewardItem:ButtonItemOnClick(go)
  if not self._matID then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._matID, self:GetGameObject().transform.position)
end
