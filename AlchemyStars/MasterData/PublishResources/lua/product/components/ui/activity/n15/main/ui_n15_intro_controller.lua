_class("UIN15IntroController", UIController)
UIN15IntroController = UIN15IntroController

function UIN15IntroController:OnShow(uiParams)
  self:_GetComponent()
  self:_InitParams(uiParams)
  self:_RefView()
end

function UIN15IntroController:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "_title")
  self._content = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._animation = self:GetUIComponent("Animation", "_uianim")
end

function UIN15IntroController:_InitParams(uiParams)
  if uiParams[2] then
    self._title_str = uiParams[1]
    self._content_str = uiParams[2]
  else
    self._title_str = "str_n15_intro_map_title"
    self._content_str = "str_n15_intro_map"
  end
end

function UIN15IntroController:_RefView()
  self._title:SetText(StringTable.Get(self._title_str))
  self._content:SetText(StringTable.Get(self._content_str))
end

function UIN15IntroController:ConfirmBtnOnClick(go)
  self:CloseDialog()
end
