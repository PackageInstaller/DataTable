local cls = class("cellEntrustReward", G_UIModuleBase)

function cls.bind()
  return {
    active_img_receive = false,
    module_cellIcon = L_Const.ModuleInfo.CellIconBag,
    color_icon = C_Color(1, 1, 1, 1)
  }
end

function cls:refresh()
  if not self.bind.itemType then
    self.modules.module_cellIcon:setContentActive(false)
  else
    self.modules.module_cellIcon:setGeneralContent(self.bind.itemType, self.bind.itemId, {
      itemNum = self.bind.num or self.bind.itemNum
    })
  end
  self.bind.active_img_receive = self.bind.received
  if self.bind.received == true then
    local darkSafeHelper = self.bindComponents.m_content:GetComponent(typeof(CS.Lens.Framework.UI.UIDarkenSafeHelper))
    darkSafeHelper:SetGrayForLua(0.42)
    local _, _color = C_ColorUtility.TryParseHtmlString("#808080")
    self.bind.color_icon = _color
  else
    local darkSafeHelper = self.bindComponents.m_content:GetComponent(typeof(CS.Lens.Framework.UI.UIDarkenSafeHelper))
    darkSafeHelper:ResetColors()
    local _, _color = C_ColorUtility.TryParseHtmlString("#FFFFFF")
    self.bind.color_icon = _color
  end
end

return cls
