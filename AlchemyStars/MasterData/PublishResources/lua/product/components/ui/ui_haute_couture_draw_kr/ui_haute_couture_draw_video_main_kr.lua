_class("UIHauteCoutureDrawVideoMainKR", UIHauteCoutureDrawVideoBase)
UIHauteCoutureDrawVideoMainKR = UIHauteCoutureDrawVideoMainKR

function UIHauteCoutureDrawVideoMainKR:Constructor()
end

function UIHauteCoutureDrawVideoMainKR:OnShow(uiParams)
  self:InitWidgets()
  self:_LoadVideo()
end

function UIHauteCoutureDrawVideoMainKR:InitWidgets()
  self:InitWidgetsBase()
end
