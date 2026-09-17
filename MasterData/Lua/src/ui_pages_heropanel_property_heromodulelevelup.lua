local this = class("heroModuleLevelUp", G_UIModuleBase)

function this.bind()
  return {
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    go_heroGiftAdvence = false,
    go_heroLevelUpArea = true,
    heroGiftAdvance = {
      moduleName = "pages/heroPanel/property/heroGiftAdvance"
    },
    heroPreviewProperty = {
      moduleName = "pages/heroPanel/property/heroPreviewProperty"
    },
    heroLevelUpArea = {
      moduleName = "pages/heroPanel/property/heroLevelUpArea"
    }
  }
end

function this.methods()
  return {}
end

function this:onOpenExp()
  self.modules.heroLevelUpArea:onOpenExp()
end

function this:onCloseExpBtn()
  self.bind.go_heroGiftAdvence = false
  self.modules.heroPreviewProperty:resetShadowLv()
  self.modules.heroLevelUpArea:onCloseExpBtn()
  self.modules.heroPreviewProperty:destoryLevelUpEffect()
end

function this:getHero()
  return self.parent:getHero(self:getHeroId())
end

function this:getHeroId()
  return self.parent.heroGuid
end

function this:open()
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.heroStrength)
  self.modules.moduleCurrency:refreshRes(tpl_sys)
  self.modules.heroLevelUpArea:setAnimatorHander(self.modules.heroPreviewProperty:getChangeAnimatorHandler())
end

function this:close()
end

function this:setHeroInfo(data)
  self.modules.heroPreviewProperty:setHeroInfo(data)
end

function this:refreshHeroProperty()
  self.modules.heroLevelUpArea:refreshHeroProperty()
end

return this
