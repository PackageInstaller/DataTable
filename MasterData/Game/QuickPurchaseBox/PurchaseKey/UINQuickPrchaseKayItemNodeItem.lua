local UINQuickPrchaseKayItemNodeItem = class("UINQuickPrchaseKayItemNodeItem", UIBaseNode)
local base = UIBaseNode

function UINQuickPrchaseKayItemNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.selectNum = 0
  self.warehousNum = 0
  UIUtil.AddButtonListener(self.ui.btn_itemNode, self, self.AddOne)
  self.ui.btn_itemNode.onPress:AddListener(BindCallback(self, self.AddOne))
  UIUtil.AddButtonListener(self.ui.btn_UnSelect, self, self.MineOne)
  self.ui.btn_UnSelect.onPress:AddListener(BindCallback(self, self.MineOne))
  self:SetLimtTimeDetailActive(false)
end

function UINQuickPrchaseKayItemNodeItem:InitQPKItem(packageItemId, onChangeCallback)
  self.selectNum = 0
  self.packageItemId = packageItemId
  self.onChangeCallback = onChangeCallback
  self.itemCfg = ConfigData.item[packageItemId]
  self.isOutTime = false
  self.outTime = -1
  if self.itemCfg == nil then
    error("can't read itemCfg with id:" .. tostring(packageItemId))
  end
  self.ui.img_ItemIcon.sprite = CRH:GetSprite(self.itemCfg.icon)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(self.itemCfg.name)
  local itemNum = PlayerDataCenter:GetItemCount(self.packageItemId)
  self:RefreshWharehouseNume(itemNum)
  self:RefreshNum(true)
  self:SetLimtTimeDetailActive(false)
end

function UINQuickPrchaseKayItemNodeItem:InitQPKLimiTimeItem(packageItemId, outTime, count, onChangeCallback)
  self.selectNum = 0
  self.packageItemId = packageItemId
  self.onChangeCallback = onChangeCallback
  self.itemCfg = ConfigData.item[packageItemId]
  self.outTime = outTime
  self.isOutTime = false
  if self.itemCfg == nil then
    error("can't read itemCfg with id:" .. tostring(packageItemId))
  end
  self.ui.img_ItemIcon.sprite = CRH:GetSprite(self.itemCfg.icon)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(self.itemCfg.name)
  self:RefreshWharehouseNume(count)
  self:RefreshNum(true)
end

function UINQuickPrchaseKayItemNodeItem:AddOne()
  if self.selectNum >= self.warehousNum then
    return
  end
  if self.isOutTime == true then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6041))
    return
  end
  self.selectNum = self.selectNum + 1
  self:RefreshNum()
end

function UINQuickPrchaseKayItemNodeItem:AddAll()
  if self.selectNum >= self.warehousNum then
    return
  end
  if self.isOutTime == true then
    return
  end
  self.selectNum = self.warehousNum
  self:RefreshNum()
end

function UINQuickPrchaseKayItemNodeItem:AddNum(num, isInit)
  if self.selectNum >= self.warehousNum then
    return
  end
  if self.isOutTime == true then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6041))
    return
  end
  self.selectNum = self.selectNum + num
  self:RefreshNum(isInit)
end

function UINQuickPrchaseKayItemNodeItem:MineOne()
  if self.selectNum <= 0 then
    return
  end
  self.selectNum = self.selectNum - 1
  self:RefreshNum()
end

function UINQuickPrchaseKayItemNodeItem:MineNum(num, isInit)
  if self.selectNum <= 0 then
    return
  end
  self.selectNum = self.selectNum - num
  self:RefreshNum(isInit)
end

function UINQuickPrchaseKayItemNodeItem:CleanAll()
  self.selectNum = 0
  self:RefreshNum()
end

function UINQuickPrchaseKayItemNodeItem:RefreshNum(isInit)
  self.ui.tex_ItemSelectNum.text = tostring(self.selectNum)
  self.ui.btn_UnSelect.gameObject:SetActive(self.selectNum > 0)
  self.ui.go_imgNumber:SetActive(self.selectNum > 0)
  if not isInit and self.onChangeCallback ~= nil then
    self.onChangeCallback(self, self.selectNum)
  end
end

function UINQuickPrchaseKayItemNodeItem:RefreshWharehouseNume(itemNum)
  self.warehousNum = itemNum
  self.ui.tex_Number.text = tostring(self.warehousNum)
end

function UINQuickPrchaseKayItemNodeItem:GetKeyNum()
  return self.itemCfg.giftOptainDic[ConstGlobalItem.SKey]
end

function UINQuickPrchaseKayItemNodeItem:SetLimtTimeDetailActive(bValue)
  if self.ui.obj_Time.activeSelf ~= bValue then
    self.ui.obj_Time:SetActive(bValue)
  end
end

function UINQuickPrchaseKayItemNodeItem:UpdateLimitTimeDetail()
  self.isOutTime = false
  self:SetLimtTimeDetailActive(true)
  local diffTime = self.outTime - PlayerDataCenter.timestamp
  if 0 < diffTime then
    local d, h, m, s = TimeUtil:TimestampToTimeInter(diffTime, false, true)
    if 0 < d then
      self.ui.text_Time:SetIndex(0, tostring(d), tostring(h))
    elseif 0 < h then
      self.ui.text_Time:SetIndex(1, tostring(h), tostring(m))
    elseif 0 < m then
      self.ui.text_Time:SetIndex(2, tostring(m))
    else
      self.ui.text_Time:SetIndex(2, tostring(1))
    end
  else
    self.isOutTime = true
    self.ui.text_Time:SetIndex(3)
  end
end

function UINQuickPrchaseKayItemNodeItem:GetIsOutTime()
  return self.isOutTime
end

function UINQuickPrchaseKayItemNodeItem:GetOutTime()
  return self.outTime
end

function UINQuickPrchaseKayItemNodeItem:GetLastNum()
  return self.warehousNum - self.selectNum
end

function UINQuickPrchaseKayItemNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINQuickPrchaseKayItemNodeItem
