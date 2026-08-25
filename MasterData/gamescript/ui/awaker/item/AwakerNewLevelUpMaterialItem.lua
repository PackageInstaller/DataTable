local AwakerNewLevelUpMaterialItem, Super = System.NewComponent("AwakerNewLevelUpMaterialItem")

function AwakerNewLevelUpMaterialItem:ctor(go, slotIndex, awakerLevelUpModel, onClick, onClickSubBtn)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(go)
  self.slotIndex = slotIndex
  self.model = awakerLevelUpModel
  self.onClick = onClick
  self.onClickSubBtn = onClickSubBtn
end

function AwakerNewLevelUpMaterialItem:OnBind(binder)
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
    local tSlotData = self.model:GetSlotData(self.slotIndex)
    local itemId = tSlotData.itemId
    local ownCnt = ItemDataUtils.GetItemNum(itemId)
    do return LT.Text, string.format("%s/%s", tSlotData.useCnt, ownCnt) end
    return LT.Text, string.format("%s/%s", tSlotData.useCnt, ownCnt)
  end)
  binder:BindLongPressButton(self.ui.Btn_Sub_Subtract, function()
  end, System.fn(self, self.SubButtonClick), tonumber(DT.GetConstant("ItemAddPressTime")))
  binder:BindLongPressButton(self.ui.Btn_Click, System.fn(self, self.LongPress), System.fn(self, self.SingleAddClick), tonumber(DT.GetConstant("ItemAddPressTime")))
  binder:BindToVisible(self.ui.Btn_Sub_Subtract, function()
    local tSlotData = self.model:GetSlotData(self.slotIndex)
    return tSlotData.useCnt > 0
  end)
end

function AwakerNewLevelUpMaterialItem:GetItemCfg()
  local tSlotData = self.model:GetSlotData(self.slotIndex)
  local itemId = tSlotData.itemId
  local config = DT.Item[itemId]
  return config
end

function AwakerNewLevelUpMaterialItem:SingleAddClick()
  self:AddButtonClick()
  if self.onClick then
    local tSlotData = self.model:GetSlotData(self.slotIndex)
    self.onClick(tSlotData.itemId)
  end
end

function AwakerNewLevelUpMaterialItem:LongPress()
  local isMax = self.model:GetTargetLevel() >= self.model.maxLevel
  local isUseAll = self.model:IsUseAllByIndex(self.slotIndex)
  if isMax or isUseAll then
    return
  end
  self:AddButtonClick()
end

function AwakerNewLevelUpMaterialItem:AddButtonClick()
  self.model:SetSlotMaterialUseCnt(self.slotIndex, 1)
end

function AwakerNewLevelUpMaterialItem:SubButtonClick()
  self.model:SetSlotMaterialUseCnt(self.slotIndex, -1)
  if self.onClickSubBtn then
    self.onClickSubBtn()
  end
end

return AwakerNewLevelUpMaterialItem
