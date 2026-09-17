local this = class("cellIconHome", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function this.bind()
  return {
    active_icon = true,
    img_icon = "",
    txt_num = "",
    active_select = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self._callback then
        self._callback()
      end
    end
  }
end

function this:open()
  self:refreshByItem(self._item, self._callback)
end

local itemData = {
  item_id = 0,
  build_id = 0,
  num = 0,
  guid = 0
}

function this:refreshByItem(itemData, cb)
  self._callback = cb
  self._item = itemData
  if not self.isBind then
    return
  end
  if itemData then
    self.bind.active_icon = true
    if itemData.item_id then
      self.bind.img_icon = L_ItemTplManager:getCommonItem(itemData.item_id).icon
    elseif itemData.build_id then
      local tpl = _homeBuildingTpl:getTplById(itemData.build_id)
      self.bind.img_icon = _homeBuildingTpl:getBuildIcon(tpl)
    end
    self.bind.txt_num = tostring(itemData.num)
  else
    self.bind.active_icon = false
  end
end

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.button.gameObject
  end
end

return this
