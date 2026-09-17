local this = class("cellBattleEnergy", G_UIModuleBase)

function this.bind()
  return {
    go_cd = false,
    fillAmount = 0,
    go_node = false,
    go_high = false
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
end

function this:close()
end

return this
