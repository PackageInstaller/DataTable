_class("UIN31SecondAnniversaryAwardItem", UICustomWidget)
UIN31SecondAnniversaryAwardItem = UIN31SecondAnniversaryAwardItem

function UIN31SecondAnniversaryAwardItem:OnShow(uiParams)
  self._atlas = self:GetAsset("N31Anniversary.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponents()
end

function UIN31SecondAnniversaryAwardItem:_GetComponents()
  self._background = self:GetUIComponent("Image", "Background")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._count = self:GetUIComponent("UILocalizationText", "Count")
end

function UIN31SecondAnniversaryAwardItem:SetData(data, callBack, bigAwardItem)
  self._data = data
  self._callback = callBack
  if bigAwardItem then
    self._background.sprite = self._atlas:GetSprite("hdzx_2znqd_icondi")
  else
    self._background.sprite = self._atlas:GetSprite("hdzx_2znqd_icondi")
  end
  local cfg = Cfg.cfg_item[self._data.assetid]
  if cfg == nil then
    Log.fatal("cfg_item is nil." .. self._data.assetid)
    return
  end
  self._icon:LoadImage(cfg.Icon)
  self._count:SetText(self._data.count)
end

function UIN31SecondAnniversaryAwardItem:IconOnClick(go)
  self._callback(self._data.assetid, go.transform.position)
end
