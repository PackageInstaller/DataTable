_class("UIActivityN4CCAffixSelectItem", UICustomWidget)
UIActivityN4CCAffixSelectItem = UIActivityN4CCAffixSelectItem

function UIActivityN4CCAffixSelectItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN4CC.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UIActivityN4CCAffixSelectItem:InitWidget()
  self.txtEff1 = self:GetUIComponent("UILocalizedTMP", "txtEff1")
  self.txtEff2 = self:GetUIComponent("UILocalizedTMP", "txtEff2")
  self.txtEff3 = self:GetUIComponent("UILocalizedTMP", "txtEff3")
  self.open = self:GetGameObject("open")
  self.select = self:GetGameObject("select")
  self.lock = self:GetGameObject("lock")
  self.imgBg = self:GetUIComponent("Image", "imgBg")
end

function UIActivityN4CCAffixSelectItem:SetData(affixId, clickCb)
  self._affixId = affixId
  self._clickCb = clickCb
  local cfg = Cfg.cfg_affix[self._affixId]
  if cfg then
    local lockStr = UIActivityN4CCHelper.GetAffixDesc(cfg, "42423f")
    local unLockStr = UIActivityN4CCHelper.GetAffixDesc(cfg, "8d0707")
    self.txtEff1:SetText(unLockStr)
    self.txtEff2:SetText(unLockStr)
    self.txtEff3:SetText(lockStr)
  end
end

function UIActivityN4CCAffixSelectItem:SetState(bSelect, canSelect)
  self._bSelect = bSelect
  self._canSelect = canSelect
  local bLock = not bSelect and not canSelect
  local bOpen = not bSelect and canSelect
  self.select:SetActive(bSelect)
  self.lock:SetActive(bLock)
  self.open:SetActive(bOpen)
  if bLock then
    self.imgBg.sprite = self._atlas:GetSprite("activity_wjyz_qh_btn03")
  elseif bSelect then
    self.imgBg.sprite = self._atlas:GetSprite("activity_wjyz_qh_btn02")
  else
    self.imgBg.sprite = self._atlas:GetSprite("activity_wjyz_qh_btn01")
  end
end

function UIActivityN4CCAffixSelectItem:GetState()
  return self._bSelect, self._canSelect
end

function UIActivityN4CCAffixSelectItem:BtnOnClick(go)
  if self._clickCb then
    self._clickCb(self)
  end
end

function UIActivityN4CCAffixSelectItem:GetAffixId()
  return self._affixId
end
