local this = class("cellMapTaskInfo", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    desc = "",
    color_undone = nil,
    color_done = nil,
    go_undone = false,
    go_done = false
  }
end

return this
