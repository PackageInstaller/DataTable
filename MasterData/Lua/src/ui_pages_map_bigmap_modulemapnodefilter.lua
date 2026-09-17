local this = class("moduleMapNodeFilter", G_UIModuleBase)
local _worldSievingTypeTpl = L_GameTpl:getWorldFilterTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {curType = nil}
end

function this.bind()
  return {
    img_select = nil,
    txt_select = "",
    go_list = false,
    go_arrowOpen = false,
    go_arrowClose = true,
    scrollList_filter = {
      moduleName = "pages/Map/BigMap/cellMapNodeFilter"
    }
  }
end

function this.methods()
  return {
    onClick_filer = function(self)
      self.bind.go_list = not self.bind.go_list
      self.bind.go_arrowClose = not self.bind.go_list
      self.bind.go_arrowOpen = self.bind.go_list
    end,
    scrollList_filter = {
      onClick = function(self, type)
        self.data.curType = type
        self:setActive()
        L_MapStore:setFilterType(self.data.curType)
        self.parent:refreshNodeListPos()
      end
    }
  }
end

function this:open()
  self:initModule()
end

function this:initModule()
  self.data.curType = L_MapStore:getFilterType()
  self:refreshList()
  self:setActive()
end

function this:refreshList()
  local config = _worldSievingTypeTpl:getConfig()
  local tmp = {}
  for _, v in pairs(config) do
    local icon = _worldSievingTypeTpl:getIcon(v)
    local name = _worldSievingTypeTpl:getName(v)
    table.insert(tmp, {
      type = _worldSievingTypeTpl:getId(v),
      go_default = true,
      go_active = false,
      img_icon_default = icon,
      txt_name_default = name,
      img_icon_active = icon,
      txt_name_active = name
    })
  end
  self.bind.scrollList_filter:clear()
  self.bind.scrollList_filter:insert_array(tmp)
  self.bindComponents.list_filter:GetChild(0).transform:GetChild(0).gameObject:ActiveTrans(false)
end

function this:setActive()
  if not self.data.curType then
    return
  end
  for i = 1, #self.bind.scrollList_filter do
    if self.data.curType == self.bind.scrollList_filter:getValue(i, "type") then
      self.bind.scrollList_filter:change(i, {go_active = true, go_default = false})
      self.bind.img_select = self.bind.scrollList_filter:getValue(i, "img_icon_active")
      self.bind.txt_select = self.bind.scrollList_filter:getValue(i, "txt_name_active")
    else
      self.bind.scrollList_filter:change(i, {go_active = false, go_default = true})
    end
  end
end

return this
