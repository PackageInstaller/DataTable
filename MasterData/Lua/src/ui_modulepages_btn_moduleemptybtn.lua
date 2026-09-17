local module = class("moduleEmptyBtn", G_UIModuleBase)

function module.bind()
  return {txt_name = ""}
end

function module.methods()
  return {}
end

function module:setName(name)
  self.bind.txt_name = name
end

function module:setData(params)
  self._params = params or {}
  self.bind.txt_name = self._params.txtName
  self.bind.active_cost = not math.isEmpty(params.itemType)
  if self.bind.active_cost then
    local item = L_ItemTplManager:getItemConfig(params.itemType, params.itemId)
    self.bind.img_icon = item.smallIcon or item.icon
    self.bind.txt_cost = params.itemNumTxt
    if params.itemNum then
      if L_ItemTplManager:getItemNum(params.itemType, params.itemId) < params.itemNum then
        self.bind.txt_cost = L_GameUtil.fillColor(params.itemNum, "#FFA6A6")
      else
        self.bind.txt_cost = tostring(params.itemNum)
      end
    end
  end
end

return module
