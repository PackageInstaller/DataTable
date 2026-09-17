local module = class("moduleButtonSingle", G_UIModuleBase)

function module.bind()
  return {
    txt_name = "",
    txt_nameEn = "",
    txt_num = nil,
    txt_numOld = nil,
    img_icon = nil,
    active_img_icon = true,
    active_node_cost = true,
    activeBg = true,
    txt_alpha = 1,
    btn_interactable = true
  }
end

function module.methods()
  return {
    onClick = function(self)
      if self._callback then
        self._callback()
      end
    end
  }
end

function module:setData(txtName, callback, params)
  params = params or {}
  if params.nameTxtColor then
    txtName = L_GameUtil.fillColor(txtName, params.nameTxtColor)
  end
  self.bind.txt_name = txtName or ""
  self.bind.txt_nameEn = L_DecorateTpl:getDecoEnglish(txtName) or "DEFAULT"
  self._callback = callback
  local isEmptyOrZero = params.txtNum == nil or params.txtNum == "" or type(params.txtNum) == "number" and params.txtNum == 0
  if isEmptyOrZero then
    self.bind.active_node_cost = false
    self.bind.active_img_icon = false
  else
    self.bind.active_node_cost = params.active_node_cost ~= nil and params.active_node_cost or true
    if params.showIcon == false then
      self.bind.active_img_icon = false
    elseif params.itemType and params.itemId then
      local item = L_ItemTplManager:getItemConfig(params.itemType, params.itemId)
      self.bind.img_icon = item.smallIcon or item.icon
    end
    if type(params.txtNum) == "number" and params.itemType and params.itemId and L_ItemTplManager:getItemNum(params.itemType, params.itemId) < params.txtNum then
      self.bind.txt_num = L_GameUtil.fillColor(params.txtNum, "#FFA6A6")
    else
      self.bind.txt_num = tostring(params.txtNum)
    end
  end
  if params.activeBg ~= nil then
    self.bind.activeBg = L_CommonUtil.toBoolean(params.activeBg)
  end
  if params.nameTxtAlpha ~= nil then
    self.bind.txt_alpha = params.nameTxtAlpha
  end
  if params.btnInteractable == nil then
    self.bind.btn_interactable = true
  else
    self.bind.btn_interactable = params.btnInteractable
  end
end

return module
