local this = class("pageAvatarBattlePrepare", G_UIPageBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {challengeId = -1}
end

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:close(options)
end

function this:open(options)
  self.data.challengeId = options.challengeId
end

function this:show()
  self:refreshUi()
end

function this:refreshUi()
end

return this
