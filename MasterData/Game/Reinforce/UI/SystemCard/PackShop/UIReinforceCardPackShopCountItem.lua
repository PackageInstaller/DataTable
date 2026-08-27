local base = UIBaseNode
local UIReinforceCardPackShopCountItem = class("UIReinforceCardPackShopCountItem", base)

function UIReinforceCardPackShopCountItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Reduce, self, self.OnClickMin)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickAdd)
end

function UIReinforceCardPackShopCountItem:InitReinforceCardPackShopCountItem(onChangeCountEvent, minCount, maxCount)
  self.onChangeCountEvent = onChangeCountEvent
  self.minCount = minCount
  self.maxCount = maxCount
  self.num = self.minCount
  self:RefreshCount()
end

function UIReinforceCardPackShopCountItem:OnClickAdd()
  self:ChangeCount(1)
end

function UIReinforceCardPackShopCountItem:OnPressAdd()
  local pressedTime = self.ui.btn_Add:GetPressedTime()
  local changeNum = math.ceil(pressedTime * pressedTime / 5)
  changeNum = math.min(changeNum, 100)
  self:ChangeCount(changeNum)
end

function UIReinforceCardPackShopCountItem:OnClickMin()
  self:ChangeCount(-1)
end

function UIReinforceCardPackShopCountItem:OnPressMin()
  local pressedTime = self.ui.btn_Reduce:GetPressedTime()
  local changeNum = math.ceil(pressedTime * pressedTime / 5)
  changeNum = math.min(changeNum, 100)
  self:ChangeCount(-changeNum)
end

function UIReinforceCardPackShopCountItem:ChangeCount(changeNum)
  AudioManager:PlayAudioById(0 < changeNum and 1064 or 1065)
  self:SetCurrentNum(self.num + changeNum)
end

function UIReinforceCardPackShopCountItem:RefreshCount()
  self.ui.tex_Num.text = tostring(self.num)
end

function UIReinforceCardPackShopCountItem:ClampCount(count)
  if count < self:GetMinCount() then
    return self:GetMinCount()
  end
  if count > self:GetMaxCount() then
    return self:GetMaxCount()
  end
  return count
end

function UIReinforceCardPackShopCountItem:GetMinCount()
  if self.minCount == nil then
    return 1
  end
  return self.minCount
end

function UIReinforceCardPackShopCountItem:GetMaxCount()
  return self.maxCount
end

function UIReinforceCardPackShopCountItem:GetCurrentNum()
  return self.num
end

function UIReinforceCardPackShopCountItem:SetCurrentNum(num)
  self.num = num
  self.num = self:ClampCount(self.num)
  self:RefreshCount()
  if self.onChangeCountEvent ~= nil then
    self.onChangeCountEvent(self.num)
  end
end

function UIReinforceCardPackShopCountItem:OnDelete()
  base.OnDelete(self)
end

return UIReinforceCardPackShopCountItem
