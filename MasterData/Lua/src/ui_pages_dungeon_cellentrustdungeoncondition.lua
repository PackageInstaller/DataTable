local this = class("cellEntrustDungeonCondition", G_UIModuleBase)

function this.bind()
  return {
    txt_condition_on = "",
    txt_condition_off = "",
    active_bg = false,
    toggle_condition = false
  }
end

function this.methods()
  return {}
end

return this
