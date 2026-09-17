local this = class("heroPreviewModeControllerBase", require("ui.pages.heroPanel.controller.heroModeControllerBase"))
local previewShowModuleTypes = {
  [L_Const.heroModuleType.Property] = true,
  [L_Const.heroModuleType.Skill] = false,
  [L_Const.heroModuleType.Star] = false,
  [L_Const.heroModuleType.SoulEssence] = false,
  [L_Const.heroModuleType.Accessory] = false
}

function this:ctor(heroConfigId)
  this.super.ctor(self)
  self.isMaxLevel = false
  self._heroConfigId = heroConfigId
end

function this:checkCanChangeHero()
  return false
end

function this:getShowModuleTypes()
  return previewShowModuleTypes
end

function this:isPreviewMode()
  return true
end

function this:setCurrentProperty(b)
  self.currentProperty = b
end

function this:showCurrentProperty()
  return self.currentProperty
end

function this:setisMaxLevel(isMaxLevel)
  self.isMaxLevel = isMaxLevel
end

function this:getIsMaxLevel()
  return self.isMaxLevel
end

function this:getHero(heroId, showCurrentProperty)
  local heroData = L_HeroManager:getPreviewHeroData(heroId, self:getIsMaxLevel(), showCurrentProperty)
  return heroData
end

function this:checkShowPreviewLevel(moduleType)
  if moduleType == L_Const.heroModuleType.Property or moduleType == L_Const.heroModuleType.Gift or moduleType == L_Const.heroModuleType.Skill or moduleType == L_Const.heroModuleType.Star then
    return true
  end
  return false
end

function this:showMainBtn()
  return false
end

return this
