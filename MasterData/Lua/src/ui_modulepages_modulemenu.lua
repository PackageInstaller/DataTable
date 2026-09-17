local this = class("moduleMenu", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {selectType = nil, checkTypeFunc = nil}
end

function this.bind()
  return {
    scrollList_type = {
      moduleName = "modulePages/cellResTypeMenu"
    }
  }
end

function this.methods()
  return {
    scrollList_type = {
      onClick_select = function(self, type)
        self.data.checkTypeFunc(type)
        self.data.selectType = type
        self:setTypeListActive()
      end
    }
  }
end

function this:open()
  this.super.open(self)
end

function this:close()
  this.super.close(self)
end

function this:initModule(typeList, defaultSelectType, func)
  self.data.checkTypeFunc = func
  self.data.selectType = defaultSelectType
  self:initTypeList(typeList)
  self:setTypeListActive()
end

function this:initTypeList(typeList)
  local tmp = {}
  for i, v in pairs(typeList) do
    table.insert(tmp, {
      type = v.type,
      img_icon_normal = v.icon,
      img_icon_active = v.icon,
      reddotKey = v.reddotKey
    })
  end
  self.bind.scrollList_type:clear()
  self.bind.scrollList_type:insert_array(tmp)
end

function this:setTypeListActive()
  for i = 1, #self.bind.scrollList_type do
    local active = false
    if self.bind.scrollList_type:getValue(i, "type") == self.data.selectType then
      active = true
    end
    self.bind.scrollList_type:change(i, {
      go_active = active,
      go_normal = not active
    })
  end
end

return this
