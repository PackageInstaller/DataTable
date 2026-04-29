_class("UIHauteCoutureDrawVideoMainPLM", UIHauteCoutureDrawVideoBase)
UIHauteCoutureDrawVideoMainPLM = UIHauteCoutureDrawVideoMainPLM

function UIHauteCoutureDrawVideoMainPLM:Constructor()
end

function UIHauteCoutureDrawVideoMainPLM:OnShow(uiParams)
  self:InitWidgets()
  self:_LoadVideo()
end

function UIHauteCoutureDrawVideoMainPLM:InitWidgets()
  self:InitWidgetsBase()
end
