local this = class("cellCatchScanItem", G_UIModuleBase)

function this.bind()
  return {
    active_select = false,
    txt_num = "",
    img_icon = ""
  }
end

function this.methods()
  return {
    onclick_Select = function(self)
      self:emit("onclick_Select", self.configId)
    end
  }
end

function this:open()
  self.configId = self.bind.configId
  self:InitScan()
end

function this:onShowSelectByConfigId(_configId)
  local flag = _configId == self.bind.configId
  self.bind.active_select = flag
  return flag and self.bind.keyId or -1
end

function this:onShowSelectByKeyId(_keyId)
  local flag = _keyId == self.bind.keyId
  self.bind.active_select = flag
  return flag and self.configId or -1
end

function this:InitScan()
  local itemConfig = L_ItemTplManager:getItemConfig(L_Const.resType.commonItem, self.configId)
  self.bind.txt_num = tostring(itemConfig.num)
  self.bind.img_icon = itemConfig.icon
end

function this:close()
end

return this
