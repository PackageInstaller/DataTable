_class("UISeasonMazeMsgBox", UIController)
UISeasonMazeMsgBox = UISeasonMazeMsgBox
_enum("SeasonMazeMsgBoxType", {OkCancel = 0, Ok = 1})

function UISeasonMazeMsgBox:InitWidget()
  self._onlyOk = self:GetGameObject("OnlyOk")
  self._okCancel = self:GetGameObject("OkCancel")
  self._titleTex = self:GetUIComponent("UILocalizationText", "title")
  self._titleTex2 = self:GetUIComponent("UILocalizationText", "title2")
  self._descTex = self:GetUIComponent("UILocalizationText", "desc")
  self._txtOnlyOk = self:GetUIComponent("UILocalizationText", "txtOnlyOk")
  self._txtOK = self:GetUIComponent("UILocalizationText", "txtOK")
  self._txtCancel = self:GetUIComponent("UILocalizationText", "txtCancel")
end

function UISeasonMazeMsgBox:OnShow(uiParams)
  self:InitWidget()
  self._title = uiParams[1]
  self._desc = uiParams[2]
  self._uiType = uiParams[3]
  self._okCb = uiParams[4]
  self._okParams = uiParams[5]
  self._cancelCb = uiParams[6]
  self._cancelParams = uiParams[7]
  self._afterShowCb = uiParams[8]
  if string.isnullorempty(self._title) then
    self._titleTex:SetText("")
    self._titleTex2:SetText("")
  else
    self._titleTex:SetText(self._title)
    self._titleTex2:SetText(self._title)
  end
  if string.isnullorempty(self._desc) then
    self._descTex:SetText("")
  else
    self._descTex:SetText(self._desc)
  end
  self._onlyOk:SetActive(self._uiType == SeasonMazeMsgBoxType.Ok)
  self._okCancel:SetActive(self._uiType == SeasonMazeMsgBoxType.OkCancel)
  if self._afterShowCb then
    self._afterShowCb(self)
  end
end

function UISeasonMazeMsgBox:CancelBtnOnClick(go)
  if self._cancelCb then
    self._cancelCb(self._cancelParams)
  end
  self:CloseDialog()
end

function UISeasonMazeMsgBox:OkBtnOnClick(go)
  if self._okCb then
    self._okCb(self._okParams)
  end
  self:CloseDialog()
end

function UISeasonMazeMsgBox:OnlyOkBtnOnClick(go)
  if self._okCb then
    self._okCb(self._okParams)
  end
  self:CloseDialog()
end

function UISeasonMazeMsgBox:SetOnlyOkBtnTxt(txt)
  self._txtOnlyOk:SetText(txt)
end

function UISeasonMazeMsgBox:SetOkCancelBtnTxt(okTxt, cancelTxt)
  self._txtOK:SetText(okTxt)
  self._txtCancel:SetText(cancelTxt)
end

function UISeasonMazeMsgBox:OnHide()
end
