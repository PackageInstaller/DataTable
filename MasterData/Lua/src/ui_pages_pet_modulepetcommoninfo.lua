local this = class("modulePetCommonInfo", G_UIModuleBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local petInfoTpl = L_GameTpl:getPetTpl()
local petLevelTpl = L_GameTpl:getPetLevelTpl()

function this.bind()
  return {
    lv = "0",
    exp = "",
    expSlider = 0,
    petGradeValue = "",
    petGradeIcon = "",
    petGradeColor = C_Color.white,
    showSpecialColor = false,
    showNormalColor = true,
    showSpecialBg = false,
    showNormalBg = true,
    bgColor_1 = C_Color.white,
    bgColor_2 = C_Color.white,
    showOpenExp = false
  }
end

function this.methods()
  return {}
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  local petTpl = petInfoTpl:getTplById(pet.id)
  self.maxLv = L_PetStore:getPetMaxLevel()
  self.lv = pet.lv
  self.bind.lv = tostring(pet.lv)
  local tpl = petLevelTpl:getTplById(pet.lv)
  local next_exp = petLevelTpl:getExp(tpl)
  self.bind.exp = string.format("%d/%d", pet.exp, next_exp)
  self.bind.expSlider = next_exp == 0 and 1 or pet.exp / next_exp
  if pet.lv == self.maxLv then
    self.bind.expSlider = 1
    self.bind.exp = "MAX"
  end
  local colorList = L_PetManager:getPetBgColor()
  local property = L_PetStore:getPetOriginalProperty(pet)
  local gradeTpl = petGradeTpl:getTplById(property.gradeRank)
  self.bind.petGradeIcon = petGradeTpl:getIcon(gradeTpl)
  self.bind.petGradeValue = tostring(property.grade)
  self.bind.showSpecialBg = table.isEmpty(colorList[property.gradeRank]) and true or false
  self.bind.showNormalBg = not table.isEmpty(colorList[property.gradeRank]) and true or false
  if colorList[property.gradeRank] then
    local _, topColor = C_ColorUtility.TryParseHtmlString(colorList[property.gradeRank][1])
    local _, downColor = C_ColorUtility.TryParseHtmlString(colorList[property.gradeRank][2])
    local _, gradeColor = C_ColorUtility.TryParseHtmlString(colorList[property.gradeRank][3])
    self.bind.petGradeColor = gradeColor
    self.bind.bgColor_1 = downColor
    self.bind.bgColor_2 = topColor
  end
end

function this:showOpenExpButton(bool)
  self.bind.showOpenExp = bool
end

return this
