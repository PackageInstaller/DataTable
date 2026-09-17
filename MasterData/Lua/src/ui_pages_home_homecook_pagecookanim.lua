local this = class("pageCookAnim", G_UIPageBase)

function this.bind()
  return {progress = true}
end

function this.methods()
  return {}
end

function this:created(obj, config)
  this.super.created(self, obj, config)
end

function this:preOpen(options)
  self.bind.progress = true
  this.super.preOpen(self, options)
end

function this:open()
  L_TimerManager:newOrResetTimer(self, "cookAni", function()
    self.bind.progress = false
    L_UI:close(self.pageName)
  end, 3.5)
end

function this:close()
  self.bind.progress = false
  L_TimerManager:clearTimer(self)
end

function this:escHandle()
end

return this
