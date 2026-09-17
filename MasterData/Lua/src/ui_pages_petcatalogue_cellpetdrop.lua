local module = class("cellPetDrop", G_UIModuleBase)

function module.bind()
  return {img_icon = ""}
end

function module.methods()
  return {
    onClickItem = function(self)
      L_ItemTplManager:showInfoTip(L_Const.resType.commonItem, self.bind.id)
    end
  }
end

function module:refresh()
  local _tpl = L_GameTpl:getCommonItemTpl():getTplById(self.bind.id)
  if not _tpl then
    C_MJLog.LogError("cellPetDrop tpl is null. id = " .. self.bind.id)
    return
  end
  self.bind.img_icon = L_GameTpl:getCommonItemTpl():getIcon(_tpl)
end

return module
