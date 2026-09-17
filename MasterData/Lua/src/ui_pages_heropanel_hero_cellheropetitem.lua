local this = class("cellHeroPetItem", G_UIModuleBase)

function this.bind()
  return {
    tex_petName = "",
    modulePet = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    txt_petResume = ""
  }
end

function this.methods()
  return {}
end

function this:refresh()
  local _petTpl = L_GameTpl:getPetTpl()
  local petInfo = _petTpl:getTplById(self.bind.id)
  self.bind.tex_petName = _petTpl:getName(petInfo, false)
  local modulePet = self.modules.modulePet
  modulePet:setConfigId(self.bind.id, true, false)
  self.bind.txt_petResume = _petTpl:getDesc(petInfo)
end

return this
