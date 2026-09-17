local this = class("cellIconHomeBox", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    active_select = false,
    toggle_isEmpty = false,
    img_icon = "",
    txt_name = "",
    txt_index = "",
    go_light = false,
    img_iconFilter = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self._removeCallback and self._item ~= nil and self.lock == false then
        self._removeCallback(self._item.guid)
      end
    end,
    onRemoveClick = function(self)
      if self._removeCallback and self._item ~= nil then
        self._removeCallback(self._item.guid)
      end
    end,
    onEnter = function(self)
      if self._hasItemCb and self._hasItemCb() then
        self.bind.go_light = true
      end
    end,
    onExit = function(self)
      self.bind.go_light = false
    end
  }
end

function this:open()
  self:refreshByItem(self._index, self._item, self._callback, self._removeCallback, self._hasItemCb)
end

function this:refreshByItem(index, itemData, cb, removeCb, hasItemCb)
  self._callback = cb
  self._removeCallback = removeCb
  self._item = itemData
  self._hasItemCb = hasItemCb
  self._index = index
  if not self.isBind then
    return
  end
  self.lock = true
  self.timer = Timer.once(0.05, function()
    self.lock = false
  end)
  if self._index then
    self.bind.txt_index = tostring(index)
  end
  if itemData then
    local conf
    if itemData.item_id then
      conf = L_ItemTplManager:getCommonItem(itemData.item_id)
      local commonItemTpl = _commonItemTpl:getTplById(itemData.item_id)
    elseif itemData.build_id then
      conf = L_ItemTplManager:getBuildingItem(itemData.build_id)
    end
    local commonItemTpl = _commonItemTpl:getTplById(itemData.item_id)
    self.bind.img_iconFilter = _commonItemTpl:getFilterIcon(commonItemTpl)
    if conf then
      self.bind.img_icon = conf.icon
      self.bind.txt_name = tostring(itemData.num)
      self.bind.toggle_isEmpty = true
      self._isEmpty = false
      return
    end
  end
  self.bind.toggle_isEmpty = false
  self._isEmpty = true
end

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.button.gameObject
  end
end

function this:getTipPosition()
  if self._index <= 3 and self._index >= 1 or self._index <= 9 and self._index >= 7 then
    return self.bindComponents.left_node.position
  else
    return self.bindComponents.right_node.position
  end
end

function this:setSelect(isSelect)
  self.bind.active_select = isSelect
end

function this:invokeDragAni(isRecover)
end

function this:isEmpty()
  return self._isEmpty
end

function this:setAlpha(value)
  local canvasGrp = self.gameObject.transform:GetComponent(typeof(C_CanvasGroup))
  canvasGrp.alpha = value
end

return this
