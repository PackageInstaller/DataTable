local module = class("cellSkillItem", G_UIModuleBase)
local SKILLBORDERICON = {
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

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {id = nil, guid = nil}
end

function module.bind()
  return {
    isActive = false,
    borderImgColor = "Page/PetBox/tex_pet_bg_nonebg",
    skillLv = "",
    skillName = "",
    itemIcon = "Skill/tex_icon_skill_playgirl01",
    active_old = false,
    txt_oldLv = ""
  }
end

function module.methods()
  return {
    onClick_Choose = function(self)
      self:emit("onClick_Choose", self.bind.index, self.bind)
    end
  }
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
end

function module:refreshInfo()
  if self.bind.starLv and self.bind.starLv ~= 0 then
    self.bind.itemIcon = "Skill/tex_icon_skill_playgirl01"
  end
  if self.bind.skillElement ~= nil then
    self.bind.borderImgColor = SKILLBORDERICON[self.bind.skillElement[1]]
  end
  if self.bind.oldLv then
    self.bind.active_old = true
    self.bind.txt_oldLv = "Lv." .. self.bind.oldLv
  end
end

function module:getPosition()
  return self.bindComponents.skillItemTrans.position
end

function module:close()
end

return module
