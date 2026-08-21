_class("UIHauteCoutureDrawVideoMainGL", UIHauteCoutureDrawVideoBase)
UIHauteCoutureDrawVideoMainGL = UIHauteCoutureDrawVideoMainGL

function UIHauteCoutureDrawVideoMainGL:Constructor()
end

function UIHauteCoutureDrawVideoMainGL:OnShow(uiParams)
  self:InitWidgets()
  self:_LoadVideo()
end

function UIHauteCoutureDrawVideoMainGL:InitWidgets()
  self:InitWidgetsBase()
end
