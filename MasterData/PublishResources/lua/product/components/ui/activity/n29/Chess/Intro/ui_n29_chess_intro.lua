_class("UIN29ChessIntro", UIController)
UIN29ChessIntro = UIN29ChessIntro

function UIN29ChessIntro:OnShow(uiParams)
  self:_GetComponent()
  self:_InitParams(uiParams)
  self:_RefView()
end

function UIN29ChessIntro:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "_title")
  self._content = self:GetUIComponent("UILocalizationText", "txtDesc")
end

function UIN29ChessIntro:_InitParams(uiParams)
  self._title_str = uiParams[1]
  self._content_str = uiParams[2]
end

function UIN29ChessIntro:_RefView()
  self._title:SetText(StringTable.Get(self._title_str))
  self._content:SetText(StringTable.Get(self._content_str))
end

function UIN29ChessIntro:ConfirmBtnOnClick(go)
  self:CloseDialog()
end
