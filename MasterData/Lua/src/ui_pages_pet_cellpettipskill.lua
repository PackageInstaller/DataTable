local this = class("cellPetTipSkill", G_UIModuleBase)
local FRAMEICON = {
  [0] = "Page/PetBox/tex_pet_bg_nonebg",
  [1] = "Page/PetBox/tex_pet_bg_firebg",
  [2] = "Page/PetBox/tex_pet_bg_windbg",
  [3] = "Page/PetBox/tex_pet_bg_landbg",
  [4] = "Page/PetBox/tex_pet_bg_woodbg",
  [5] = "Page/PetBox/tex_pet_bg_icebg",
  [6] = "Page/PetBox/tex_pet_bg_waterbg",
  [7] = "Page/PetBox/tex_pet_bg_thunderbg",
  [8] = "Page/PetBox/tex_pet_bg_lightbg",
  [9] = "Page/PetBox/tex_pet_bg_darkbg"
}

function this.bind()
  return {
    img_icon = "",
    img_lv = "",
    txt_name = "",
    txt_desc = "",
    size_root = C_Vector2(512, 182),
    borderImgColor = FRAMEICON[0]
  }
end

function this:open()
  if self.bind.skillElement ~= nil then
    self.bind.borderImgColor = FRAMEICON[self.bind.skillElement[1]]
  end
  L_GameUtil.forceRebuildLayout(self.bindComponents.cellTrans)
end

return this
