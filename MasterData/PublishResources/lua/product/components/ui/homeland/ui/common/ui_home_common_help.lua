_class("UIHomelandCommonHelp", UICustomWidget)
UIHomelandCommonHelp = UIHomelandCommonHelp

function UIHomelandCommonHelp:Constructor()
end

function UIHomelandCommonHelp:OnShow(uiParams)
  self._helpBtn = self:GetGameObject("HelpBtn")
end

function UIHomelandCommonHelp:SetData(str, backCB)
  self._tipStr = str
  self._backCB = backCB
end

function UIHomelandCommonHelp:HelpBtnOnClick(go)
  local tip = self:ShowDialog("UIHomeHelpController", self._tipStr)
end
