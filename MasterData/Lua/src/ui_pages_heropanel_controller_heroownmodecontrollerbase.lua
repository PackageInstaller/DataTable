local this = class("heroOwnModeControllerBase", require("ui.pages.heroPanel.controller.heroModeControllerBase"))

function this:ctor()
  this.super.ctor(self)
  self.isMaxLevel = false
end

local normalShowModuleTypes = {
  [L_Const.heroModuleType.Property] = true,
  [L_Const.heroModuleType.Skill] = true,
  [L_Const.heroModuleType.Talent] = true,
  [L_Const.heroModuleType.Star] = true,
  [L_Const.heroModuleType.SoulEssence] = true,
  [L_Const.heroModuleType.Accessory] = true,
  [L_Const.heroModuleType.Data] = true,
  [L_Const.heroModuleType.Grade] = true
}

function this:checkCanChangeHero()
  return true
end

function this:getShowModuleTypes()
  return normalShowModuleTypes
end

function this:getHero(heroId, showCurrentProperty)
  return L_HeroStore:getHero(heroId)
end

function this:getHeroByConfigId(configId)
  return L_HeroStore:getHeroByConfigId(configId)
end

function this:getSelectConfigId()
  local serverData = L_HeroStore:getHero(self:getSelectGuid())
  return L_HeroStore:getHeroConfigId(serverData)
end

return this
