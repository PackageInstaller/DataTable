local this = class("cellSituationEnvItem", G_UIModuleBase)

function this.bind()
  return {
    id = nil,
    icon = "",
    name = ""
  }
end

function this.methods()
  return {}
end

function this:init()
end

function this:open()
end

function this:refresh()
end

function this:close()
end

return this
