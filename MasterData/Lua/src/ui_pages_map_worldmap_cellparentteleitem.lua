local this = class("cellParentTeleItem", G_UIModuleBase)

function this.bind()
  return {
    go_active = false,
    go_normal = false,
    go_lock = false,
    goVxActive = true,
    txt_name_active = nil,
    txt_name_normal = nil,
    txt_name_lock = nil,
    scrollList_tele = {
      moduleName = "pages/Map/WorldMap/cellTeleListItem"
    },
    areaItemTrans = C_Vector2(337, 73),
    line = C_Vector2(0, 0)
  }
end

function this.methods()
  return {
    onClick_selectArea = function(self)
      self:emit("onClick_selectArea", self.bind)
    end,
    scrollList_tele = {
      onClick_selectItem = function(self, bind)
        self:emit("onClick_selectItem", bind)
      end
    }
  }
end

function this:close(options)
  this.super.close(self, options)
  self.bind.goVxActive = false
end

function this:setSelect(b)
  self.bind.go_active = b
  self.bind.go_normal = not b
end

function this:open()
  self:init()
end

function this:refresh()
  self:refreshRect()
end

function this:init()
  if self.bind.teleportInfo then
    local transferList = self.bind.teleportInfo
    self.bind.scrollList_tele:clear()
    local tempData = {}
    for _, v in ipairs(transferList) do
      table.insert(tempData, {
        go_active = false,
        go_normal = L_SceneStore:getPointIsUnlock(v.id),
        go_lock = not L_SceneStore:getPointIsUnlock(v.id),
        txt_name_active = v.name,
        txt_name_normal = v.name,
        txt_name_lock = v.name,
        id = v.id
      })
    end
    self.bind.scrollList_tele:insert_array(tempData)
    self:refreshRect()
  end
end

function this:refreshRect()
  local size = 0
  if 0 < #self.bind.scrollList_tele and self.bind.go_active == true then
    local height_bg = 73
    local height_item = 73 * #self.bind.scrollList_tele
    self.bind.areaItemTrans = C_Vector2(337, height_bg + height_item)
    size = height_bg + height_item
    self.bind.line = C_Vector2(3, height_item - 20)
    return size
  else
    self.bind.areaItemTrans = C_Vector2(337, 73)
    self.bind.line = C_Vector2(0, 0)
  end
  return size
end

function this:setChildItemActive(id)
  for i, v in ipairs(self.bind.scrollList_tele) do
    local item = self.bind.scrollList_tele:getItemCls(i)
    if self.bind.scrollList_tele:getValue(i, "id") == id then
      item:setSelect(true)
    else
      item:setSelect(false)
    end
  end
end

return this
