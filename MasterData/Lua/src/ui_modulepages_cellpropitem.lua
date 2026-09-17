local module = class("cellPropItem", G_UIModuleBase)

function module.bind()
  return {
    bg = "",
    icon = "",
    num = ""
  }
end

function module.methods()
  return {
    onLongPress_info = function(self)
      if not math.isEmpty(self.bind.id) then
        L_ItemTplManager:showInfoTip(L_Const.resType.commonItem, self.bind.id, self.bind.guid)
      end
    end
  }
end

return module
