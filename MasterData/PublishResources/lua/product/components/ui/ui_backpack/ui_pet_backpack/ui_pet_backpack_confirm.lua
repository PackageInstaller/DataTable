_class("UIPetBackPackConfirm", UIController)
UIPetBackPackConfirm = UIPetBackPackConfirm

function UIPetBackPackConfirm:OnShow(uiParams)
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._contentLabel = self:GetUIComponent("UILocalizationText", "Content")
  self._item = uiParams[1]
  self._petId = uiParams[2]
  self._callback = uiParams[3]
  local itemName = ""
  local itemId = self._item:GetTemplateID()
  local itemCfg = Cfg.cfg_item[itemId]
  if itemCfg then
    itemName = StringTable.Get(itemCfg.Name)
  end
  local petName = ""
  local petCfg = Cfg.cfg_pet[self._petId]
  if petCfg then
    petName = StringTable.Get(petCfg.Name)
  end
  self._contentLabel:SetText(StringTable.Get("str_item_select_pet_tips", itemName, petName))
end

function UIPetBackPackConfirm:BtnConfrimOnClick()
  if self._callback then
    self._callback()
  end
end

function UIPetBackPackConfirm:BtnCancelOnClick()
  self:CloseDialog()
end
