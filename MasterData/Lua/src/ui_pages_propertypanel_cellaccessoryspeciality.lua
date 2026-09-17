local this = class("cellAccessorySpeciality", G_UIModuleBase)

function this.bind()
  return {
    subList = {
      moduleName = "pages/propertyPanel/cellSubtxt"
    }
  }
end

function this.methods()
  return {}
end

function this:refresh()
  local skills = table.clone(self.bind.skills)
  self.bind.subList:clear()
  self.bind.subList:insert_array(skills)
end

return this
