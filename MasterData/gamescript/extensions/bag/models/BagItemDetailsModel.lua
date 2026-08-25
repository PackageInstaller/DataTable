local BagItemDetailsModel = NewClass("BagItemDetailsModel", BaseModel)

function BagItemDetailsModel:OnInit()
  self:OnReset()
end

function BagItemDetailsModel:OnReset()
  self.itemUid = 0
end

function BagItemDetailsModel:SetItemUid(itemUid)
  if self.itemUid == itemUid then
    return
  end
  self.itemUid = itemUid
  self:LocalNotify(NotifyId.OnBagItemDetailChanged, itemUid)
end

function BagItemDetailsModel:GetItemUid()
  return self.itemUid
end

function BagItemDetailsModel:GetItemIcon(itemData)
  if not itemData then
    return ""
  end
  do return ItemDataUtils.GetIcon end
  return ItemDataUtils.GetIcon, itemData.tid
end

function BagItemDetailsModel:GetWeaponExclusiveDesc(weapon)
  if not weapon then
    return ""
  end
  local weaponConfig = DT.Item[weapon.tid]
  if nil == weaponConfig then
    return ""
  end
  if nil == weaponConfig.SpParam then
    return ""
  end
  local awakerTid = weaponConfig.SpParam[3]
  if nil == awakerTid then
    return ""
  end
  local hasOwner = nil ~= weapon.awaker and 0 ~= weapon.awaker
  local color = "#AAAAAA"
  if hasOwner then
    local ownerAwakerConfig = DT.AwakerConfig[weapon.awaker]
    if ownerAwakerConfig.ID == awakerTid then
      color = "#FFFFFF"
    end
  end
  local exclusiveAwakerConfig = DT.AwakerConfig[awakerTid]
  local exclusiveAwakerName = LT.Text(exclusiveAwakerConfig.Title)
  local tips = LT.Textf("WeaponExclusiveTips", exclusiveAwakerName, exclusiveAwakerName)
  do return string.format, "<Color='%s'>%s</Color>", color end
  return string.format, "<Color='%s'>%s</Color>", color, tips
end

return BagItemDetailsModel
