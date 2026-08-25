local AwakerBreakthroughMaterial, Super = System.NewComponent("AwakerBreakthroughMaterial")

function AwakerBreakthroughMaterial:ctor(go, itemInfo, showCountOnly)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(go)
  self.showCountOnly = showCountOnly
  self.itemInfo = itemInfo
end

function AwakerBreakthroughMaterial:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.uiNode, function()
    return -1 ~= self.itemInfo.id
  end)
  binder:BindToImage(self.ui.Icon_Article, function()
    if -1 ~= self.itemInfo.id then
      do return ItemDataUtils.GetItemIcon end
      return ItemDataUtils.GetItemIcon, self.itemInfo.id
    else
      return ""
    end
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    if -1 ~= self.itemInfo.id then
      local config = DT.Item[self.itemInfo.id]
      do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
      return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
    else
      return ""
    end
  end)
  binder:BindToText(self.ui.Text_Article_Number, function()
    local currCount = ItemDataUtils.GetItemNum(self.itemInfo.id)
    local requiredCount = self.itemInfo.requiredCount
    if self.showCountOnly then
      return requiredCount
    else
      if currCount < requiredCount then
        currCount = string.format("<Color4:%d>", currCount)
      end
      do return string.format, "%s/%s", currCount end
      return string.format, "%s/%s", currCount, requiredCount
    end
  end)
  binder:BindLongPressButton(self.ui.Btn_Click, function()
  end, System.fn(self, self.OnTodoFunc), tonumber(DT.GetConstant("Role_Press_Time")))
end

function AwakerBreakthroughMaterial:OnTodoFunc()
  if -1 ~= self.itemInfo.id then
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.itemInfo.id)
  end
end

return AwakerBreakthroughMaterial
