local page = class("cellFilterCloseItem", G_UIModuleBase)

function page.bind()
  return {txt_name = "", id = 0}
end

function page.methods()
  return {
    onClick_remove = function(self)
      self:emit("onClick_remove", self.bind)
    end
  }
end

return page
