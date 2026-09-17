local this = class("modulePetSSLCheckBar", G_UIModuleBase)

function this.bind()
  return {
    color_stamina = nil,
    fillAmount_stamina = nil,
    txt_info = nil,
    img_bg = nil
  }
end

function this.methods()
  return {}
end

function this:setData(guid)
  local pet = L_PetStore:getPetItem(guid)
  local satietyPer = L_SatietyStore:getPetSatietyPercent(guid)
  satietyPer = math.clamp(satietyPer, 0, 1)
  self.bind.fillAmount_stamina = satietyPer
  self.bind.color_stamina = L_PetConst.SatietyStatusColor[L_SatietyStore:getPetSatietyStatus(guid)]
  self.bind.txt_info = L_WordsTpl:getValue("ui_modulePetSSLCheckBar", {
    [0] = L_Const.colorHtml.grey009,
    [1] = L_MountManager:getMountSpeed(guid)
  })
  local property = L_PetStore:getPetOriginalProperty(pet)
  self.bind.frameBg = L_PetConst.GradeFrameBg[property.gradeRank]
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_modulePetSSLCheckBar)
end

function this:setLevel(guid)
  local pet = L_PetStore:getPetItem(guid)
  self.bind.txt_info = string.format("Lv.%s", pet.lv)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_modulePetSSLCheckBar)
end

function this:setSatiety(guid)
  local satietyPer = L_SatietyStore:getPetSatietyPercent(guid)
  self.bind.txt_info = string.format("%d%%", math.round(satietyPer * 100))
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_modulePetSSLCheckBar)
end

return this
