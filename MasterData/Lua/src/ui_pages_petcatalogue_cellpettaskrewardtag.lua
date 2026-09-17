local module = class("cellPetTaskRewardTag", G_UIModuleBase)

function module.bind()
  return {img_icon = "", txt_num = ""}
end

function module.methods()
  return {
    onClickItem = function(self)
      L_ItemTplManager:showInfoTip(self.bind.itemType, self.bind.itemId)
    end
  }
end

function module:refresh()
  local _tpl
  if self.bind.itemType == L_Const.resType.commonItem then
    _tpl = L_GameTpl:getCommonItemTpl():getTplById(self.bind.itemId)
  elseif self.bind.itemType == L_Const.resType.currency then
    _tpl = L_GameTpl:getCurrencyTpl():getTplById(self.bind.itemId)
  else
    error("item type not support: " .. tostring(self.bind.itemType))
    return
  end
  if _tpl then
    self.bind.img_icon = L_GameTpl:getCommonItemTpl():getIcon(_tpl)
  end
  self.bind.txt_num = "X" .. tostring(self.bind.itemNum)
end

return module
