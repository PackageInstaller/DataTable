local this = class("cellHeroHeadItem", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    bgIcon = "",
    head = "",
    lvBgColor = "",
    lv = ""
  }
end

function this:refresh()
end

return this
