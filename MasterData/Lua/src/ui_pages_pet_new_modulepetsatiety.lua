local this = class("modulePetSatiety", G_UIModuleBase)

function this.bind()
  return {
    satiety_cur = "",
    satiety_max = "",
    color_tipSatiety = C_Color.white
  }
end

function this:setGuid(guid)
  self.bind.satiety_max = tostring(L_SatietyStore:getPetMaxSatiety(guid))
  local str = tostring(L_SatietyStore:getPetSatiety(guid))
  local satietyInterval = L_SatietyStore:getPetSatietyStatus(guid)
  local colorSatiety = L_PetConst.NewSatietyTextColor[satietyInterval]
  self.bind.satiety_cur = L_GameUtil.fillColor(str, colorSatiety)
end

return this
