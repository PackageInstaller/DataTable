local module = class("moduleBtn", G_UIModuleBase)

function module.bind()
  return {
    txt_name = nil,
    img_icon = nil,
    txt_cost = nil,
    active_cost = nil
  }
end

function module.methods()
  return {
    onClick = function(self)
      if self._params and self._params.callback then
        self._params.callback()
      end
    end
  }
end

function module:setData(params)
  self._params = params or {}
  self.bind.txt_name = self._params.txtName
  self.bind.active_cost = not math.isEmpty(params.itemType)
  if self.bind.active_cost then
    local item = L_ItemTplManager:getItemConfig(params.itemType, params.itemId)
    self.bind.img_icon = item.smallIcon or item.icon
    self.bind.txt_cost = params.itemNumTxt
    print("=====================params.itemType, params.itemId", params.itemType, params.itemId)
    if params.itemNum then
      if L_ItemTplManager:getItemNum(params.itemType, params.itemId) < params.itemNum then
        local colorKey = params.colorKey or "#F45757"
        self.bind.txt_cost = L_GameUtil.fillColor(params.itemNum, colorKey)
      else
        self.bind.txt_cost = params.itemNumTxt or tostring(params.itemNum)
      end
    end
  end
end

function module:setAnimState(state)
end

return module
