_class("UIN33ShopSelectInfo", UICustomWidget)
UIN33ShopSelectInfo = UIN33ShopSelectInfo

function UIN33ShopSelectInfo:OnShow()
  self._pos = self:GetGameObject("Pos")
  local rowPool = self:GetUIComponent("UISelectObjectPath", "ItemSelectObject")
  self._awardCell = rowPool:SpawnObject("UIN33ShopAwardCell")
  self._itemInfoName = self:GetUIComponent("UILocalizationText", "LTextName")
  self._itemInfoDesc = self:GetUIComponent("UILocalizationText", "LTextIntro")
  self._isDispose = false
end

function UIN33ShopSelectInfo:SetData(data, itemInfoCallback, unlock, yieldTime, isTips)
  if self._isDispose then
    return
  end
  self._pos:SetActive(true)
  self._awardCell:InitN33ShopAwardCellData(data, itemInfoCallback, unlock, yieldTime, isTips)
  local itemConfig = Cfg.cfg_item[data.m_item_id]
  if not itemConfig then
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  if not itemModule then
    return
  end
  self._itemInfoName:SetText(StringTable.Get(itemConfig.Name))
  self._itemInfoDesc:SetText(StringTable.Get(itemConfig.Intro))
end

function UIN33ShopSelectInfo:PosOnClick()
  self._pos:SetActive(false)
end

function UIN33ShopSelectInfo:OnHide()
  self._isDispose = true
end
