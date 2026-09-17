local this = class("cellPixelPetLabor", G_UIModuleBase)
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local _homeTalentTpl = L_GameTpl:getHomeTalentTpl()
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
    laborIcon = "",
    laborTypeIcon = "",
    activeLaborType = false,
    img_light = "",
    laborGrade = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  L_ProfilerUtil.BeginSample("lua cellPixelPet open")
  this.super.open(self)
  self:refresh()
  L_ProfilerUtil.EndSample()
end

function this:refresh()
  self.laborId = self.bind.laborId
  self.talentId = self.bind.talentId
  self.bind.activeLaborType = not math.isEmpty(self.talentId)
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(self.laborId)
  if homeLaborTypeTpl then
    self.bind.laborIcon = _homeLaborTypeTpl:getLaborIcon(homeLaborTypeTpl)
  end
  if self.bind.activeLaborType then
    local homeTalentTpl = _homeTalentTpl:getTplById(self.talentId)
    self.bind.laborTypeIcon = _homeTalentTpl:getTypeIcon(homeTalentTpl)
    self.bind.img_frame = path_frame[_homeTalentTpl:getTalentLevel(homeTalentTpl)]
    self.bind.img_light = path_light[_homeTalentTpl:getTalentLevel(homeTalentTpl)]
  else
    self.bind.img_frame = ""
    self.bind.img_light = ""
  end
end

function this:close()
end

return this
