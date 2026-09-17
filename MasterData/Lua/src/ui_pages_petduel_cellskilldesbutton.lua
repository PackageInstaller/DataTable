local this = class("cellSkillDesButton", G_UIModuleBase)

function this.bind()
  return {skillName = "", selected = false}
end

function this.methods()
  return {}
end

function this:refresh()
  if not self.isBind then
    return
  end
  self.bind.skillName = self.bind.skillName
end

function this:setSelected(selected)
  self.bind.selected = selected
end

return this
