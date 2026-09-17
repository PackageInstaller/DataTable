local this = class("moduleSituationEditBase", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:toBind(uiBinding)
  this.super.toBind(self, uiBinding)
end

function this:unBind(uiBinding)
  this.super.unBind(self, uiBinding)
end

function this:open()
end

function this:close()
end

return this
