local module = class("modulePamiTalkListCell", G_UIModuleBase)

function module.bind()
  return {
    groupNameText = "",
    favorabilityText = "",
    heroHeadIcon = ""
  }
end

function module.methods()
  return {
    onClick_cell = function(self)
      local pamiLetterGroupTpl = L_GameTpl:getPamiLetterGroupTpl()
      L_UI:open("pagePamiTalkLetter", {
        groupId = pamiLetterGroupTpl:getId(self.bind.letterGroupTpl),
        heroId = pamiLetterGroupTpl:getHeroId(self.bind.letterGroupTpl)
      })
    end
  }
end

function module:refresh()
  local pamiLetterGroupTpl = L_GameTpl:getPamiLetterGroupTpl()
  self.bind.groupNameText = L_Config:provider(pamiLetterGroupTpl:getName(self.bind.letterGroupTpl))
  local heroId = pamiLetterGroupTpl:getHeroId(self.bind.letterGroupTpl)
  local heroItem = L_ItemManager:parseHeroItem(heroId)
  self.bind.heroHeadIcon = heroItem.iconBattle
  local groupId = pamiLetterGroupTpl:getId(self.bind.letterGroupTpl)
  L_ReddotManager:registerReddot(self.bindComponents.groupDot, string.format(L_ReddotManager.DotDef.PamiTalkGroup, groupId))
  local heroData = L_HeroStore:getHero(heroId)
  if heroData then
    self.bind.favorabilityText = tostring(L_HeroStore:getHeroFavorAbilityLevel(heroData))
  end
end

return module
