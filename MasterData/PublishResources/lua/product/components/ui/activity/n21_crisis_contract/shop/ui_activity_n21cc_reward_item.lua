_class("UIActivityN21CCRewardItem", UICustomWidget)
UIActivityN21CCRewardItem = UIActivityN21CCRewardItem

function UIActivityN21CCRewardItem:OnShow()
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._go = self:GetGameObject()
end

function UIActivityN21CCRewardItem:OnHide()
end

function UIActivityN21CCRewardItem:Refresh(data)
  if data == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._data = data
  self._countLabel:SetText(data.count)
  local ItemTempleate = Cfg.cfg_item[data.assetid]
  self._iconLoader:LoadImage(ItemTempleate.Icon)
end

function UIActivityN21CCRewardItem:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCShopRewardItemClick, self._data.assetid, self._go.transform.position)
end
