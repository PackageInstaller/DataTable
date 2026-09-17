local this = class("cellRewardCondition", G_UIModuleBase)

function this.bind()
  return {
    success = false,
    lock = true,
    txt_condition_lock = "",
    txt_condition = ""
  }
end

function this.methods()
  return {}
end

function this:ctor()
  this.super.ctor(self)
end

function this:open()
end

function this:refreshSuccess(state)
  self.bind.success = state
  self.bind.lock = not state
end

return this
