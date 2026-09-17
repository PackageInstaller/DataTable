local this = class("cellAccessoryEffectSub", G_UIModuleBase)

function this.bind()
  return {txtTitle = "", txtDesc = ""}
end

function this.methods()
  return {}
end

function this:refresh()
  if not self.isBind then
    return
  end
  self.bind.txtTitle = self.bind.suitName
  local desc = table.concat(self.bind.des, "\n")
  self.bind.txtDesc = desc
end

return this
