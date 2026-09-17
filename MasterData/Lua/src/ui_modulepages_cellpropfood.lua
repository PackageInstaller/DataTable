local this = class("cellPropFood", G_UIModuleBase)

function this.bind()
  return {
    guid = 0,
    id = 0,
    num = 0,
    name = "",
    selected = false,
    pageType = false,
    quick = false,
    expendNum = 0
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.pageType then
        if self.bind.num == 0 then
          return
        end
        self:emit("onClick", self.bind.id)
      else
        self:emit("onClick", self.bind.id)
      end
    end,
    onClick_cancel = function(self)
      self:emit("cancel", self.bind.id)
    end
  }
end

return this
