local module = class("cellFiltrateSortItem", G_UIModuleBase)
module.tag = "cellFiltrateSortItem"

function module.bind()
  return {
    sortType = "",
    num = 0,
    bgText = "",
    checkText = "",
    bgCheckText = "",
    background = true,
    checkmark = false,
    backgroundCheck = false
  }
end

function module.methods()
  return {
    btnOnClick = function(self)
      if self.bind.background then
        self.bind.background = false
        self.bind.checkmark = false
        self.bind.backgroundCheck = true
        self:emit("sortType", self.bind.num, self.bind.sortType, L_Const.sortOrder.DESC)
      elseif self.bind.backgroundCheck then
        self.bind.background = false
        self.bind.checkmark = true
        self.bind.backgroundCheck = false
        self.sortType = "DESC"
        self:emit("sortType", self.bind.num, self.bind.sortType, L_Const.sortOrder.ASC)
      elseif self.bind.checkmark then
        self.bind.background = false
        self.bind.checkmark = false
        self.bind.backgroundCheck = true
        self:emit("sortType", self.bind.num, self.bind.sortType, L_Const.sortOrder.DESC)
      end
    end
  }
end

return module
