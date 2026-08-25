local PvpSettleTextItem, Super = System.NewComponent("PvpSettleTextItem")

function PvpSettleTextItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Out_ManifestationResource(uiNode)
  self.name = data.name
  self.num = data.num
end

function PvpSettleTextItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Description, function()
    do return LT.Text end
    return LT.Text, self.name
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    do return string.format, "+%s" end
    return string.format, "+%s", self.num
  end)
end

return PvpSettleTextItem
