local ItemType = CommonDefine.ItemType
local AssistAwakerWeaponItem, Super = System.NewComponent("AssistAwakerWeaponItem")

function AssistAwakerWeaponItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(res)
end

function AssistAwakerWeaponItem:OnBind(binder)
  self:BindPress(binder)
  binder:BindToImage(self.ui.Icon_Article, function()
    local iconPath = self.model:GetIcon(self.tid.value)
    return iconPath
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local config = DT.Item[self.tid.value]
    do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
    return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
  end)
  binder:BindToVisible(self.ui.Group_Get, function()
    if self.showReceivedFunc then
      do return end
      return self.showReceivedFunc, nil
    end
  end)
  binder:SetActive(self.ui.Group_Refine_Level, false)
  binder:BindToText(self.ui.Text_Refine_Level, function()
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType ~= ItemType.Weapon then
      return 0
    end
    do return self.model.GetWeaponRefineLevelByUid, self.model end
    return self.model.GetWeaponRefineLevelByUid, self.model, self.uid.value
  end)
  binder:BindToVisible(self.ui.Group_Stars, function()
    if self.weaponStarShowFunc then
      do return end
      return self.weaponStarShowFunc, nil, nil
    end
    local itemType = self.model:GetItemType(self.tid.value)
    return itemType == ItemType.Weapon
  end)
  binder:BindToRaw(function(childBinder, n, _)
    for i = 1, 5 do
      local obj = self.ui["Star_" .. i]
      if obj then
        childBinder:SetActive(obj, i <= n)
      end
    end
  end, function()
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType ~= ItemType.Weapon then
      return 0
    end
    local stars = self.model:GetWeaponRefineLevelByUid(self.uid.value)
    return stars
  end)
  binder:BindToText(self.ui.Text_Article_Number, function()
    if self.num.value then
      return self.num.value
    end
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType == ItemType.Weapon then
      return ""
    elseif itemType == ItemType.Trinket then
      local level = self.model:GetTrinketLevelByUid(self.uid.value)
      if level < 0 then
        level = 0
      end
      do return string.format, "+%s" end
      return string.format, "+%s", level
    else
      local num = self.model:GetItemNumByTid(self.tid.value)
      if self.articleNumberShowFunc then
        num = self.articleNumberShowFunc(self.tid.value, num)
      end
      return num
    end
  end)
  binder:BindToText(self.ui.Text_Article_Count, function()
    if not self.selectNumFunc then
      return ""
    end
    do return end
    return self.selectNumFunc, nil
  end)
end

function AssistAwakerWeaponItem:BindPress(binder)
  binder:BindLongPressButton(self.ui.Btn_Click, function()
    self.model:ReqRemoveNew(self.uid.value)
    if self.longPressCallback then
      self.longPressCallback(self.tid.value, self.uid.value)
      return
    end
    if self.callback then
      self.callback(self.tid.value, self.uid.value)
    end
  end, System.fn(self, self.OnClick), tonumber(DT.GetConstant("Role_Press_Time")))
end

function AssistAwakerWeaponItem:OnClick()
  if not self.callback then
    return
  end
  self.callback(self.tid.value, self.uid.value)
  self.model:ReqRemoveNew(self.uid.value)
end

return AssistAwakerWeaponItem
