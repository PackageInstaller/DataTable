_class("UISimpleHauteCoutureConfirm", UIController)
UISimpleHauteCoutureConfirm = UISimpleHauteCoutureConfirm

function UISimpleHauteCoutureConfirm:LoadDataOnEnter(TT, res, uiParams)
end

function UISimpleHauteCoutureConfirm:OnShow(uiParams)
  self._costItemID = uiParams[1]
  self._titleTxt = uiParams[2]
  self._costNum = uiParams[3]
  self._confirmCallback = uiParams[4]
  self:_GetComponents()
  self:_InitComponents()
end

function UISimpleHauteCoutureConfirm:_GetComponents()
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.have = self:GetUIComponent("UILocalizationText", "have")
  self.rest = self:GetUIComponent("UILocalizationText", "rest")
end

function UISimpleHauteCoutureConfirm:_InitComponents()
  local itemModule = self:GetModule(ItemModule)
  local itemCfg = Cfg.cfg_item[self._costItemID]
  self.icon:LoadImage(itemCfg.Icon)
  self.title:SetText(self._titleTxt)
  local haveNum = itemModule:GetItemCount(self._costItemID)
  local rest = haveNum - self._costNum
  if 99999 < haveNum then
    haveNum = "99999+"
  end
  if 99999 < rest then
    rest = "99999+"
  end
  self.have:SetText(haveNum)
  self.rest:SetText(rest)
end

function UISimpleHauteCoutureConfirm:ConfirmButtonOnClick(go)
  if self._confirmCallback then
    self._confirmCallback()
  end
  self:CloseDialog()
end

function UISimpleHauteCoutureConfirm:CancelButtonOnClick(go)
  self:CloseDialog()
end
