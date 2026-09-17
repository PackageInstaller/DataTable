local module = class("cellPetRankUpInfoItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    id = nil,
    guid = nil,
    typeIcon = {
      [1] = "Page/BSPet/tex_pet_icon_yz001",
      [2] = "Page/BSPet/tex_pet_icon_jn001",
      [3] = "",
      [4] = ""
    }
  }
end

function module.bind()
  return {
    type = "",
    skillName = "",
    describe = "",
    typeIcon = ""
  }
end

function module.methods()
  return {}
end

function module:open()
  self:refreshInfo()
end

function module:refresh()
end

function module:refreshInfo()
  if self.bind.rankUpType ~= nil then
    self.bind.typeIcon = self.data.typeIcon[self.bind.rankUpType]
  end
end

function module:close()
end

return module
