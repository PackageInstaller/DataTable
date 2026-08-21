_class("UIHomelandMessageBox", UIController)
UIHomelandMessageBox = UIHomelandMessageBox

function UIHomelandMessageBox:Constructor()
end

function UIHomelandMessageBox:OnShow(uiParams)
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.btn1 = self:GetGameObject("btn1")
  self.btn2 = self:GetGameObject("btn2")
  self.txt1 = self:GetUIComponent("UILocalizationText", "txt1")
  self.txt2 = self:GetUIComponent("UILocalizationText", "txt2")
  self._txtTitleGo = self:GetGameObject("txtTitle")
  self._titleBg = self:GetGameObject("titlebg")
  self._btnClose = self:GetGameObject("btnClose")
  self.strTitle = uiParams[1]
  self.strDesc = uiParams[2]
  self.btn1Data = uiParams[3]
  self.btn2Data = uiParams[4]
  self.hideCloseBtn = uiParams[5]
  self:Flush()
end

function UIHomelandMessageBox:OnHide()
end

function UIHomelandMessageBox:Flush()
  if self.hideCloseBtn then
    self._btnClose:SetActive(false)
  else
    self._btnClose:SetActive(true)
  end
  if self.strTitle and self.strTitle ~= "" then
    self.txtTitle:SetText(self.strTitle)
    self._txtTitleGo:SetActive(true)
    self._titleBg:SetActive(true)
  else
    self._txtTitleGo:SetActive(false)
    self._titleBg:SetActive(false)
  end
  self.txtDesc:SetText(self.strDesc)
  if self.btn1Data then
    self.btn1:SetActive(true)
    self.txt1:SetText(self.btn1Data[1])
  else
    self.btn1:SetActive(false)
  end
  if self.btn1Data then
    self.btn2:SetActive(true)
    self.txt2:SetText(self.btn2Data[1])
  else
    self.btn2:SetActive(true)
  end
end

function UIHomelandMessageBox:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIHomelandMessageBox:btn1OnClick(go)
  self:ClickBtnX(self.btn1Data)
end

function UIHomelandMessageBox:btn2OnClick(go)
  self:ClickBtnX(self.btn2Data)
end

function UIHomelandMessageBox:ClickBtnX(btnXData)
  if btnXData[2] then
    btnXData[2]()
  end
  self:CloseDialog()
end
