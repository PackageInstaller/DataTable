local AwakerOriginUnlockMaterialItem, Super = System.NewComponent("AwakerOriginUnlockMaterialItem")

function AwakerOriginUnlockMaterialItem:ctor(go, data)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(go)
  self.data = data
end

function AwakerOriginUnlockMaterialItem:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Icon_Article, function()
    local config = self:GetItemCfg()
    return config.Icon
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local config = self:GetItemCfg()
    do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
    return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
  end)
  binder:BindToText(self.ui.Text_Article_Number, function()
    local itemId = self.data.itemId
    local ownCnt = ItemDataUtils.GetItemNum(itemId)
    local numStr
    if ownCnt < self.data.useCnt then
      numStr = string.format("<color=%s>%d</color>/%d", DT.ColorConfig.Red.Light, ownCnt, self.data.useCnt)
    else
      numStr = ownCnt .. "/" .. self.data.useCnt
    end
    return numStr
  end)
  binder:BindLongPressButton(self.ui.Btn_Click, function()
  end, function()
    local itemId = self.data.itemId
    ItemDataUtils.ShowItemDetailTips(binder, self.ui.uiNode, nil, itemId)
  end, tonumber(DT.GetConstant("Role_Press_Time")))
end

function AwakerOriginUnlockMaterialItem:GetItemCfg()
  local itemId = self.data.itemId
  local config = DT.Item[itemId]
  return config
end

return AwakerOriginUnlockMaterialItem
