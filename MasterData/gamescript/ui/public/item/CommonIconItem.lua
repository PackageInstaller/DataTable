local ItemType = CommonDefine.ItemType
local RedDotType = CommonDefine.RedDotType
local CommonIconItem, Super = System.NewComponent("CommonIconItem")

function CommonIconItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(res)
  self.tid = Vue.ref(data.tid)
  self.uid = Vue.ref(data.uid)
  self.num = Vue.ref(data.num)
  self.activityPrizeState = data.activityPrizeState and Vue.ref(data.activityPrizeState)
  self.model = data.model
  self.callback = data.callback
  self.selectedFunc = data.selectedFunc
  self.clickFrameShowFunc = data.clickFrameShowFunc
  self.longPressCallback = data.longPressCallback
  self.showReceivedFunc = data.showReceivedFunc
  self.showMultiSelect = data.showMultiSelect
  self.selectNumFunc = data.selectNumFunc
  self.btnSubFunc = data.btnSubFunc
  self.articleNumberShowFunc = data.articleNumberShowFunc
  self.ShowRedDot = data.ShowRedDot
  self.ShowOwnAwaker = data.ShowOwnAwaker
  self.ShowLockImg = data.ShowLockImg
  self.redFunc = data.redFunc
  self.weaponStarShowFunc = data.weaponStarShowFunc
  self.noEquipFunc = data.noEquipFunc
  self.awakerOwnerFunc = data.awakerOwnerFunc
  self.hideRefineInfo = data.hideRefineInfo
  self.mockOwner = data.mockOwner
  self.showExpiredFunc = data.showExpiredFunc
  self.showName = data.showName
  self.showFullHead = data.showFullHead
end

function CommonIconItem:OnBind(binder)
  self.binder = binder
  self:BindExpiredTimeImg(binder)
  self:BindPress(binder)
  binder:BindLongPressButton(self.ui.Btn_Sub_Subtract, System.fn(self, self.OnSubClick), System.fn(self, self.OnSubClick), tonumber(DT.GetConstant("ItemAddPressTime")), true)
  binder:BindToImage(self.ui.Icon_Article, function()
    local iconPath = self.model:GetIcon(self.tid.value)
    return iconPath
  end)
  binder:BindToRaw(function(_, iconPath)
    self.ui.Icon_Article:SetActive(not iconPath)
    self.ui.Icon_Role:SetActive(iconPath)
    if iconPath then
      self.binder:SetImageSync(self.ui.Icon_Role, iconPath)
    end
  end, function()
    if not self.showFullHead then
      return nil
    end
    local itemCfg = DT.Item[self.tid.value]
    local awakerTid
    if itemCfg and itemCfg.SpParam then
      awakerTid = DT.Item[self.tid.value].SpParam[1]
      local awakerCfg = DT.AwakerConfig[awakerTid]
      local iconPath = awakerCfg.AwakeList
      return iconPath or nil
    end
    return nil
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
  binder:BindToVisible(self.ui.Group_Stars, function()
    if self.hideRefineInfo then
      return false
    end
    if self.weaponStarShowFunc then
      do return end
      return self.weaponStarShowFunc, nil, nil
    end
    local itemType = self.model:GetItemType(self.tid.value)
    return itemType == ItemType.Weapon
  end)
  binder:BindToRaw(function(childBinder, level)
    local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
    local numStars = math.min(level, refineStage1MaxLevel)
    for i = 1, 5 do
      local obj = self.ui["Star_" .. i]
      if obj then
        childBinder:SetActive(obj, i <= numStars)
      end
    end
    if level > refineStage1MaxLevel then
      self.ui.Image_Max:SetActive(true)
      childBinder:SetText(self.ui.Text_Max, level - refineStage1MaxLevel)
    else
      self.ui.Image_Max:SetActive(false)
    end
  end, function()
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType ~= ItemType.Weapon then
      return 0
    end
    do return self.model.GetWeaponRefineLevelByUid, self.model end
    return self.model.GetWeaponRefineLevelByUid, self.model, self.uid.value
  end)
  binder:BindToText(self.ui.Text_Article_Number, function()
    if self.showName then
      do return ItemDataUtils.GetItemName end
      return ItemDataUtils.GetItemName, self.tid.value, nil, nil, nil
    end
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
  binder:BindToVisible(self.ui.Image_Sub_Lock, function()
    if self.ShowLockImg == false then
      return false
    end
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType ~= ItemType.Trinket then
      return false
    end
    local locked = self.model:GetItemLocked(self.uid.value)
    return locked
  end)
  binder:BindToVisible(self.ui.Group_Sub_Awaker_Head, function()
    if self.awakerOwnerFunc then
      return 0 ~= self.awakerOwnerFunc()
    end
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
      return false
    end
    if self.ShowOwnAwaker == false then
      return false
    end
    local ownAwaker = self.model:GetItemOwner(self.uid.value)
    return ownAwaker and ownAwaker > 0
  end)
  binder:BindToImage(self.ui.Icon_Awaker, function()
    if self.awakerOwnerFunc then
      return 0 ~= self.awakerOwnerFunc() and self.model:GetAwakerCircleHeadIcon(self.awakerOwnerFunc())
    end
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
      return false
    end
    local awaker = self.model:GetItemOwner(self.uid.value)
    if not awaker or 0 == awaker then
      return ""
    end
    if self.mockOwner then
      local temp = self.mockOwner()
      if temp and 0 ~= temp then
        awaker = temp
      end
    end
    do return self.model.GetAwakerCircleHeadIcon, self.model end
    return self.model.GetAwakerCircleHeadIcon, self.model, awaker
  end)
  binder:BindToVisible(self.ui.Image_Michi, function()
    if not self.uid.value or 0 == self.uid.value then
      return false
    end
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType ~= ItemType.Trinket then
      return false
    end
    local mainAttr = AwakerTrinketDataUtils.GetMainAttr(self.uid.value)
    if not mainAttr then
      return false
    end
    return true
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    if not self.uid.value or 0 == self.uid.value then
      return ""
    end
    local itemType = self.model:GetItemType(self.tid.value)
    if itemType ~= ItemType.Trinket then
      return ""
    end
    local mainAttr = AwakerTrinketDataUtils.GetMainAttr(self.uid.value)
    if not mainAttr then
      return ""
    end
    local attrType = DT.ActorAttrType[mainAttr.attrId]
    return attrType and attrType.Icon or ""
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.clickFrameShowFunc and self.clickFrameShowFunc(self.uid.value, self.tid.value)
  end)
  binder:BindToRaw(function(_, nVal)
    if nVal then
      self.model:ReqRemoveNew(self.uid.value)
    end
  end, function()
    return self.clickFrameShowFunc and self.clickFrameShowFunc(self.uid.value, self.tid.value)
  end)
  binder:BindToVisible(self.ui.Group_Sub_Select, function()
    return self.selectedFunc and self.selectedFunc()
  end)
  binder:BindToVisible(self.ui.Image_Tick, function()
    return self.selectedFunc and self.selectedFunc() and not self.showMultiSelect
  end)
  binder:BindToVisible(self.ui.Btn_Sub_Subtract, function()
    if not self.selectNumFunc or not self.btnSubFunc then
      return false
    end
    local selectNum = self.selectNumFunc()
    return selectNum > 0
  end)
  binder:BindToText(self.ui.Text_Article_Count, function()
    if not self.selectNumFunc then
      return ""
    end
    do return end
    return self.selectNumFunc, nil
  end)
  binder:BindToVisible(self.ui.Text_Article_Count, function()
    local hasChosen = self.selectedFunc and self.selectedFunc()
    if not hasChosen or not self.selectNumFunc then
      return false
    end
    if not self.showMultiSelect then
      return false
    end
    local selectNum = self.selectNumFunc()
    return selectNum > 0
  end)
  self:BindImageDis(binder)
  binder:BindToVisible(self.ui.Image_Receive, function()
    if not self.activityPrizeState then
      return false
    end
    return self.activityPrizeState.value == CommonDefine.CommonState.GainPrize
  end)
  binder:BindComponent(RedDotComponent(self.ui.Group_Sub_RedDot, RedDotType.Dot, nil, function()
    if self.redFunc then
      do return end
      return self.redFunc, nil, nil
    end
    if self.ShowRedDot == false then
      return false
    end
    local isNew = self.model:IsItemNew(self.uid.value)
    if isNew then
      do return RedPointDataUtils.ShowRedPointState end
      return RedPointDataUtils.ShowRedPointState, {isNew = 1}
    end
    return false
  end))
  if self.noEquipFunc then
    binder:BindToVisible(self.ui.Group_NoEquip, self.noEquipFunc)
  else
    self.ui.Group_NoEquip:SetActive(false)
  end
end

function CommonIconItem:BindExpiredTimeImg(binder)
  binder:BindToVisible(self.ui.Image_Time, function()
    if self.showExpiredFunc then
      do return end
      return self.showExpiredFunc, nil
    else
      return false
    end
  end)
  binder:BindToVisible(self.ui.Group_Expired, function()
    if self.showExpiredFunc then
      do return end
      return self.showExpiredFunc, nil
    else
      return false
    end
  end)
end

function CommonIconItem:BindPress(binder)
  binder:BindLongPressButton(self.ui.Btn_Click, function()
    self.model:ReqRemoveNew(self.uid.value)
    if self.longPressCallback then
      self.longPressCallback(self.tid.value, self.uid.value)
      return
    end
    if self.callback then
      self.callback(self.tid.value, self.uid.value)
    end
  end, System.fn(self, self.OnClick), tonumber(DT.GetConstant("ItemAddPressTime")))
end

function CommonIconItem:OnClick()
  if not self.callback then
    return
  end
  self.callback(self.tid.value, self.uid.value)
  self.model:ReqRemoveNew(self.uid.value)
end

function CommonIconItem:OnSubClick(triggeredTimes)
  if not self.btnSubFunc then
    return
  end
  self.btnSubFunc(self.tid.value, self.uid.value)
  if triggeredTimes and triggeredTimes > 5 then
    local selectNum = self.selectNumFunc()
    for i = 1, selectNum do
      self.btnSubFunc(self.tid.value, self.uid.value)
    end
  end
end

function CommonIconItem:UpdateItemTid(tid)
  tid = tid or 0
  self.tid.value = tid
end

function CommonIconItem:UpdateItemNum(num)
  if not num then
    return
  end
  self.num.value = num
end

function CommonIconItem:UpdateClickFunc(clickFunc)
  self.clickFunc = clickFunc
end

function CommonIconItem:UpdateRedFunc(redFunc)
  self.redFunc = redFunc
end

function CommonIconItem:BindImageDis(binder)
  binder:BindToVisible(self.ui.Image_Dis, function()
    print(" on change state value:", self.activityPrizeState and self.activityPrizeState.value)
    if not self.activityPrizeState then
      return false
    end
    return self.activityPrizeState.value == CommonDefine.CommonState.Finish
  end)
end

function CommonIconItem:UpdatePrizeState(prizeState)
  if not prizeState then
    return
  end
  if not self.activityPrizeState then
    self.activityPrizeState = Vue.ref(prizeState)
  else
    self.activityPrizeState.value = prizeState
  end
end

return CommonIconItem
