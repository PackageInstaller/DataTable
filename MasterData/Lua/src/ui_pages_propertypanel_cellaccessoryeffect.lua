local this = class("cellAccessoryEffect", G_UIModuleBase)

function this.bind()
  return {
    subList = {
      moduleName = "pages/propertyPanel/cellAccessoryEffectSub"
    }
  }
end

function this.methods()
  return {}
end

function this:refresh()
  if not self.isBind then
    return
  end
  self.bind.subList:clear()
  local suites = table.clone(self.bind.suites)
  self.bind.subList:insert_array(suites)
end

return this
