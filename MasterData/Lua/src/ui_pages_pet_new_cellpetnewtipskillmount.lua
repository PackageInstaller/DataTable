local this = class("cellPetNewTipSkillMount", G_UIModuleBase)

function this.bind()
  return {
    cellPetNewTipSkill = {
      moduleName = "pages/pet/new/cellPetNewTipSkill"
    },
    img_icon = nil,
    txt_moveType = ""
  }
end

function this:open()
end

function this:initModule(kiboInfo)
  if not kiboInfo then
    return
  end
  self.modules.cellPetNewTipSkill:setKiboInfo(kiboInfo)
end

function this:refreshSkillType(skillData)
  for _, v in pairs(skillData) do
    self.bind.img_icon = v.img_icon
    self.bind.txt_moveType = v.txt_moveType
  end
end

return this
