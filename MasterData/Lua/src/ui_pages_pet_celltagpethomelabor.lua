local this = class("cellTagPetHomeLabor", G_UIModuleBase)
local _HomeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local path_frame = {
  [1] = "UI/Atlas/PetTalentObsolute/tex_pet_frame_gongzhong_bg1.png",
  [2] = "UI/Atlas/PetTalentObsolute/tex_pet_frame_gongzhong_bg2.png",
  [3] = "UI/Atlas/PetTalentObsolute/tex_pet_frame_gongzhong_bg3.png"
}
local path_light = {
  [1] = "UI/Atlas/PetTalentObsolute/tex_pet_dec_gongzhong_light1.png",
  [2] = "UI/Atlas/PetTalentObsolute/tex_pet_dec_gongzhong_light2.png",
  [3] = "UI/Atlas/PetTalentObsolute/tex_pet_dec_gongzhong_light3.png"
}

function this.bind()
  return {
    img_frame = "",
    active_frame = false,
    img_icon = "",
    img_time = "",
    active_time = false,
    img_light = "",
    active_light = false,
    text_grade = ""
  }
end

function this:open()
  local laborId = self.bind.laborId
  local laborGrade = self.bind.laborGrade
  local upperLaborGrade = self.bind.upperLaborGrade
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local talentId = self.bind.talentId
  if talentId then
    local tpl = _HomeTalentTpl:getTplById(talentId)
    self.bind.active_frame = true
    self.bind.img_frame = path_frame[_HomeTalentTpl:getTalentLevel(tpl)]
    self.bind.img_time = _HomeTalentTpl:getTypeIcon(tpl)
    print("img Path:", self.bind.img_time)
    self.bind.active_time = true
    self.bind.active_light = true
    self.bind.img_light = path_light[_HomeTalentTpl:getTalentLevel(tpl)]
  end
  self.bind.text_grade = tostring(laborGrade)
  self.bind.img_icon = _homeLaborTypeTpl:getLaborIcon(homeLaborTypeTpl)
end

return this
