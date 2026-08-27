local UINActivityCollectFortuneItem = class("UINActivityCollectFortuneItem", UIBaseNode)
local base = UIBaseNode

function UINActivityCollectFortuneItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if self.ui.Btn_Item then
    UIUtil.AddButtonListener(self.ui.Btn_Item, self, self.OnClickItem)
  end
  if self.ui.Btn_Minus then
    UIUtil.AddButtonListener(self.ui.Btn_Minus, self, self.OnClickBtnMinus)
  end
end

function UINActivityCollectFortuneItem:InitCollectFortuneItem(index, id, count, clickFunc)
  self._index = index
  self._itemId = id
  self._count = count
  self._clickFunc = clickFunc
  local itemCfg = ConfigData.item[id]
  if itemCfg == nil then
    return
  end
  self.ui.Tex_OwnNum.text = tostring(count)
  self.ui.Img_Pic:SetIndex(index - 1)
  self:SetCollectFortuneItemOperateNum(0)
  self:SetCollectFortuneItemLocked(false)
end

function UINActivityCollectFortuneItem:BindCollectFortuneOperateFunc(operateFunc)
  self._operateFunc = operateFunc
end

function UINActivityCollectFortuneItem:SetCollectFortuneItemLocked(isLock)
  if self.ui.Obj_Lock then
    self.ui.Obj_Lock:SetActive(isLock)
  end
end

function UINActivityCollectFortuneItem:SetCollectFortuneItemOperateNum(num)
  if self.ui.Tex_DonateNum then
    self.ui.DonateNumBg:SetActive(0 < num)
    self.ui.Tex_DonateNum.text = tostring(num)
  end
  if self.ui.Btn_Minus then
    self.ui.Btn_Minus.gameObject:SetActive(0 < num)
  end
end

function UINActivityCollectFortuneItem:OnClickItem()
  if self._clickFunc ~= nil then
    self._clickFunc(self._index)
  else
    local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
    window:InitCommonItemDetailWithCount(ConfigData.item[self._itemId], nil, self._count)
  end
end

function UINActivityCollectFortuneItem:OnClickBtnMinus()
  if self._operateFunc then
    self._operateFunc(self._index)
  end
end

function UINActivityCollectFortuneItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityCollectFortuneItem
