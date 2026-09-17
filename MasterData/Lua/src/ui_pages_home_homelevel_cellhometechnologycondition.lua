local this = class("cellHomeTechnologyCondition", G_UIModuleBase)

function this.bind()
  return {
    go_complete = false,
    txt_name_complete = nil,
    go_notComplete = false,
    txt_name_notComplete = nil
  }
end

function this.methods()
  return {}
end

return this
