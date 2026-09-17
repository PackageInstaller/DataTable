local module = class("cellTalentRuneBonus", G_UIModuleBase)

function module.bind()
  return {
    runeIcon = "",
    runeNameText = "",
    cellSkillActive = true,
    cellSkill = {
      moduleName = "pages/HeroPanel/talent/cellTalentSkillLevel"
    },
    attributeList = {
      moduleName = "pages/HeroPanel/talent/cellTalentAttributeBonus"
    },
    selectedBg = false
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
end

return module
