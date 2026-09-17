local this = class("moduleHeroBase", G_UIModuleBase)

function this:initPage(params)
end

function this:getModeController()
  return self.parent.modeController
end

function this:isPreviewMode()
  local modeController = self:getModeController()
  return modeController:isPreviewMode()
end

function this:showCurrentProperty()
  local modeController = self:getModeController()
  return modeController:showCurrentProperty()
end

function this:getHero(heroId, showCurrentProperty)
  local modeController = self:getModeController()
  return modeController:getHero(heroId, showCurrentProperty)
end

function this:playChangeEffect()
end

return this
