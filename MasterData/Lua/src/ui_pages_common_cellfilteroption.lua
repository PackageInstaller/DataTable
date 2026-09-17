local this = class("cellFilterOption", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {selectValue = nil}
end

function this.bind()
  return {
    txt_title = "",
    scrollList_option = {
      moduleName = "modulePages/cellButtonCommon"
    }
  }
end

function this.methods()
  return {
    scrollList_option = {
      onClick = function(self, bind)
        if bind.go_active then
          self.data.selectValue = nil
        else
          self.data.selectValue = bind.value
        end
        self:setOptionListActive()
        self.parent.data.filterParam[self.bind.type] = self.data.selectValue
      end
    }
  }
end

function this:refresh()
  local tmp = {}
  for i, v in pairs(self.bind.optionList) do
    table.insert(tmp, {
      value = v.value,
      txt_name = v.txt_name,
      go_active = false
    })
  end
  self.bind.scrollList_option:clear()
  self.bind.scrollList_option:insert_array(tmp)
end

function this:setOptionListActive()
  for i = 1, #self.bind.scrollList_option do
    local active = false
    if self.data.selectValue == self.bind.scrollList_option:getValue(i, "value") then
      active = true
    end
    self.bind.scrollList_option:change(i, {go_active = active})
  end
end

return this
