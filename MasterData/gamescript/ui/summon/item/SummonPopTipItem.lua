local SummonPopTipItem, Super = System.NewComponent("SummonPopTipItem")

function SummonPopTipItem:ctor(res, itemId, num)
  Super.ctor(self)
  self.ui = UI_Summon_Item_Side_TipResource(res)
  self.itemId = itemId
  self.num = num
end

function SummonPopTipItem:OnBind(binder)
  binder:BindToVisible(self.ui.Image_Article_Icon, function()
    return false
  end)
  binder:BindToImage(self.ui.Image_Awaker_Head, function()
    return DT.Item[self.itemId].Icon
  end)
  binder:BindToText(self.ui.Text_Desc, function()
    do return ItemNumUtils.GetNextLineStr, self.itemId end
    return ItemNumUtils.GetNextLineStr, self.itemId, self.num
  end)
  binder:BindToText(self.ui.Text_Note, function()
    do return LT.Text end
    return LT.Text, "GetSSRDecompose"
  end)
end

return SummonPopTipItem
