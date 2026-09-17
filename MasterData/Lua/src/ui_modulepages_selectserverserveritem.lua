local page = class("selectServerServerItem", G_UIModuleBase)
local tag = "page:selectServerServerItem"
local event = {onClick = "onClick"}

function page.bind()
  return {id = 0, displayName = ""}
end

function page.methods()
  return {
    onServerClick = function(self)
      self:emit(event.onClick, self.bind)
    end
  }
end

function page:open(options)
  page.super.open(self, options)
end

return page
