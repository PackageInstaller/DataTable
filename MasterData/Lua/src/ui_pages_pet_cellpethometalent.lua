local module = class("cellPetHomeTalent", G_UIModuleBase)
local homeTalentTpl = L_GameTpl:getHomeTalentTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    levelImg = {
      [1] = "Page/PetBox/tex_pet_word_1",
      [2] = "Page/PetBox/tex_pet_word_2",
      [3] = "Page/PetBox/tex_pet_word_3"
    }
  }
end

function module.bind()
  return {
    talentIcon = "Page/PetBox/tex_pet_icon_shouge",
    levelImg = ""
  }
end

function module.methods()
  return {
    onClick_Choose = function(self)
      self:emit("onClick_Choose", self.bind)
    end
  }
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
end

function module:refreshInfo()
  if not math.isEmpty(self.bind.talentId) then
    local tpl = homeTalentTpl:getTplById(self.bind.talentId)
    local talentName = homeTalentTpl:getTalentName(tpl)
    local talentLv = homeTalentTpl:getTalentLevel(tpl)
    self.bind.levelImg = self.data.levelImg[talentLv]
  end
end

function module:close()
end

return module
