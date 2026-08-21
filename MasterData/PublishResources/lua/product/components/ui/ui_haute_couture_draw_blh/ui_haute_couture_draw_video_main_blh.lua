_class("UIHauteCoutureDrawVideoMainBLH", UIHauteCoutureDrawVideoBase)
UIHauteCoutureDrawVideoMainBLH = UIHauteCoutureDrawVideoMainBLH

function UIHauteCoutureDrawVideoMainBLH:Constructor()
end

function UIHauteCoutureDrawVideoMainBLH:OnShow(uiParams)
  self:InitWidgets()
  self:_LoadVideo()
end

function UIHauteCoutureDrawVideoMainBLH:InitWidgets()
  self:InitWidgetsBase()
end
