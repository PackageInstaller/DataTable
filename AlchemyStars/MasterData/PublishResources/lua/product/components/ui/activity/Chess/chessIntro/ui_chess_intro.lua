_class("UIChessIntro", UIController)
UIChessIntro = UIChessIntro

function UIChessIntro:OnShow(uiParams)
  self:_GetComponent()
  self:_InitParams(uiParams)
  self:_RefView()
end

function UIChessIntro:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "_title")
  self._content = self:GetUIComponent("UILocalizationText", "txtDesc")
end

function UIChessIntro:_InitParams(uiParams)
  self._title_str = uiParams[1]
  self._content_str = uiParams[2]
end

function UIChessIntro:_RefView()
  self._title:SetText(StringTable.Get(self._title_str))
  self._content:SetText(StringTable.Get(self._content_str))
end

function UIChessIntro:ConfirmBtnOnClick(go)
  self:CloseDialog()
end
