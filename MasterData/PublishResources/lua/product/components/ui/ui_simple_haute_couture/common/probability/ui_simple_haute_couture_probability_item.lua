_class("UISimpleHauteCoutureProbabiltyItem", UICustomWidget)
UISimpleHauteCoutureProbabiltyItem = UISimpleHauteCoutureProbabiltyItem

function UISimpleHauteCoutureProbabiltyItem:Constructor()
end

function UISimpleHauteCoutureProbabiltyItem:OnShow(uiParams)
  self:_GetComponents()
end

function UISimpleHauteCoutureProbabiltyItem:_GetComponents()
  self._prizeImg1 = self:GetUIComponent("RawImageLoader", "prizeImg1")
  self._percent = self:GetUIComponent("UILocalizationText", "percent")
  self._asset = self:GetUIComponent("UISelectObjectPath", "asset")
  self._detailBg = self:GetUIComponent("Image", "detailbg")
end

function UISimpleHauteCoutureProbabiltyItem:SetData(cfg, isBig, callback)
  self._cfg = cfg
  self._isBig = isBig
  self._callback = callback
  self:_InitComponents()
end

function UISimpleHauteCoutureProbabiltyItem:_InitComponents()
  local itemCfg = Cfg.cfg_item[self._cfg.ItemID]
  self._percent:SetText(self._cfg.Probablity * 100 .. "%")
  self._detailBg.sprite = self.uiOwner.altas:GetSprite("senior_rare0" .. self._cfg.Color)
  self._prizeImg1.gameObject:SetActive(self._isBig)
  if not self._isBig then
    local asset = self._asset:SpawnObject("UIAsset")
    asset:SetData(self._cfg.ItemID)
    local param = {}
    param.text = self._cfg.Count
    param.icon = Cfg.cfg_item[self._cfg.ItemID].Icon
    asset:SetItemData(param)
  else
    self._prizeImg1:LoadImage(self._cfg.Pic)
  end
end

function UISimpleHauteCoutureProbabiltyItem:ItemBtnOnClick(go)
  if self._callback then
    self._callback(self._cfg.ItemID, go.transform.position)
  end
end
