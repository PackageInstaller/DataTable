local module = class("cellPetPropertyItem", G_UIModuleBase)
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    shiningImg = {
      sss = "Page/PetInfo/tex_pet_dec_caibg_2",
      ss = "Page/PetInfo/tex_pet_dec_jinbg_2"
    },
    textColorType = {
      [1] = "#4f525d",
      [2] = "#ff7930"
    },
    upToColor = {
      [1] = "#4C5E87",
      [2] = "#FF7930"
    }
  }
end

function module.bind()
  return {
    show_shiningBg = false,
    shingingBg = "Page/PetInfo/tex_pet_dec_jinbg_2",
    name = "",
    icon = "",
    cur_num = "",
    show_add = false,
    show_upTo = false,
    addNum = "",
    upToColor = CS.UnityEngine.Color(1, 1, 1)
  }
end

function module.methods()
  return {}
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
  self:refreshInfo()
end

function module:refreshInfo()
  local _, standardColor = C_ColorUtility.TryParseHtmlString(self.data.upToColor[1])
  self.bind.upToColor = standardColor
  if self.bind.attrId ~= 0 then
    local tpl = petLearningAblityTpl:getTplById(self.bind.attrId)
    local level = petLearningAblityTpl:getLevel(tpl)
    self.bind.show_shiningBg = true
    self.bind.shingingBg = self.data.shiningImg[level]
    local rawValue_cur = self.bind.cur_num
    self.bind.cur_num = string.format("<color=#ff7930>%s</color>", rawValue_cur)
    local rawValue_after = self.bind.addNum
    self.bind.addNum = string.format("<color=#ff7930>%s</color>", rawValue_after)
    local _, shiningColor = C_ColorUtility.TryParseHtmlString(self.data.upToColor[2])
    self.bind.upToColor = shiningColor
  end
end

function module:close()
end

return module
