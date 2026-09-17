local this = class("moduleOneKeySwitch", G_UIModuleBase)

function this.bind()
  return {
    img_hero = "",
    goEmpty = false,
    goContent = false,
    go_effectCDLoop = false
  }
end

function this.methods()
  return {
    onClick_change = function(self)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open(options)
  this.super.open(self, options)
end

return this
