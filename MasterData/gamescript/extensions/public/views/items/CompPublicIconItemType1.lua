local ItemType = CommonDefine.ItemType
local CompPublicIconItemType1, Super = NewViewComponent("CompPublicIconItemType1")

function CompPublicIconItemType1:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_WuPin_Type1Resource(uiNode)
  self.tid = data.tid
  self.uid = data.uid
  self.num = data.num
  self.activityPrizeState = data.activityPrizeState and data.activityPrizeState
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
  self.isUnEffecting = data.isUnEffecting
  self.showSubBtn = data.showSubBtn
  self.hideIsNew = data.hideIsNew
  self.itemType = ItemDataUtils.GetItemType(self.tid)
  self.config = DT.Item[self.tid]
end

function CompPublicIconItemType1:OnEnterComponent()
  self:InitBtnClick()
  self:InitImageDis()
  self:InitSubSelectGroup()
  self.ui.Image_Time:SetActive(self:Image_Time_Visible())
  self.ui.Group_Expired:SetActive(self:Group_Expired_Visible())
  self.ui.Group_Get:SetActive(self.showReceivedFunc and self.showReceivedFunc())
  self.ui.Group_Stars:SetActive(self:Group_Stars_Visible())
  self.ui.Image_Sub_Lock:SetActive(self:Image_Sub_Lock_Visible())
  self.ui.Group_Sub_Awaker_Head:SetActive(self:Group_Sub_Awaker_Head_Visible())
  self.ui.Image_Michi:SetActive(self:Image_Michi_Visible())
  self.ui.Image_Select:SetActive(self:Image_Select_Visible())
  self.ui.Image_Tick:SetActive(self.selectedFunc and self.selectedFunc() and not self.showMultiSelect)
  self.ui.Image_Receive:SetActive(self:Image_Receive_Visible())
  self.ui.Group_NoEquip:SetActive(self.noEquipFunc and self.noEquipFunc())
  self.ui.Group_NotActive:SetActive(self.isUnEffecting)
  self.ui.Btn_Sub_Subtract:SetActive(self:Btn_Sub_Subtract_Visible())
  self:SetImage(self.ui.Icon_Article, ItemDataUtils.GetIcon(self.tid))
  self:SetImage(self.ui.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(self.config, self.ui.Image_Bg_Black))
  self:SetImage(self.ui.Icon_Awaker, self:Icon_Awaker_Image())
  self:SetImage(self.ui.Image_Icon, self:Image_Icon_Image())
  self:SetText(self.ui.Text_Article_Number, self:Text_Article_Number_Text())
  self:AddViewComponentOnce(self.ui.Group_Sub_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, System.fn(self, self.OnRedFunc))
  local refineLevel
  if self.itemType ~= ItemType.Weapon then
    refineLevel = 0
  else
    refineLevel = ItemDataUtils.GetWeaponRefineLevelByUid(self.uid)
  end
  local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  local numStars = math.min(refineLevel, refineStage1MaxLevel)
  for i = 1, 5 do
    local obj = self.ui["Star_" .. i]
    if obj then
      obj:SetActive(i <= numStars)
    end
  end
  if refineLevel > refineStage1MaxLevel then
    self.ui.Image_Max:SetActive(true)
    self:SetText(self.ui.Text_Max, refineLevel - refineStage1MaxLevel)
  else
    self.ui.Image_Max:SetActive(false)
  end
end

function CompPublicIconItemType1:Image_Time_Visible()
  if self.showExpiredFunc then
    do return end
    return self.showExpiredFunc
  else
    return false
  end
end

function CompPublicIconItemType1:Group_Expired_Visible()
  if self.showExpiredFunc then
    do return end
    return self.showExpiredFunc
  else
    return false
  end
end

function CompPublicIconItemType1:Group_Stars_Visible()
  if self.hideRefineInfo then
    return false
  end
  if self.weaponStarShowFunc then
    do return end
    return self.weaponStarShowFunc, nil
  end
  local itemType = self.itemType
  return itemType == ItemType.Weapon
end

function CompPublicIconItemType1:OnLongClick()
  if not self.hideIsNew then
    ItemDataUtils.ReqRemoveNew(self.uid)
  end
  if self.longPressCallback then
    self.longPressCallback(self.tid, self.uid)
    return
  end
  if self.callback then
    self.callback(self.tid, self.uid)
  end
end

function CompPublicIconItemType1:OnShortClick()
  if not self.callback then
    return
  end
  self.callback(self.tid, self.uid)
  if not self.hideIsNew then
    ItemDataUtils.ReqRemoveNew(self.uid)
  end
end

function CompPublicIconItemType1:OnSubClick(triggeredTimes)
  if not self.btnSubFunc then
    return
  end
  self.btnSubFunc(self.tid, self.uid)
  if triggeredTimes and triggeredTimes > 5 then
    local selectNum = self.selectNumFunc()
    for i = 1, selectNum do
      self.btnSubFunc(self.tid, self.uid)
    end
  end
end

function CompPublicIconItemType1:Text_Article_Number_Text()
  if self.showName then
    do return ItemDataUtils.GetItemName end
    return ItemDataUtils.GetItemName, self.tid, nil, nil, nil
  end
  if self.num then
    return self.num
  end
  local itemType = self.itemType
  if itemType == ItemType.Weapon then
    return ""
  elseif itemType == ItemType.Trinket then
    local level = ItemDataUtils.GetTrinketLevelByUid(self.uid)
    if level < 0 then
      level = 0
    end
    do return string.format, "+%s" end
    return string.format, "+%s", level
  else
    local num = ItemDataUtils.GetItemNum(self.tid)
    if self.articleNumberShowFunc then
      num = self.articleNumberShowFunc(self.tid, num)
    end
    return num
  end
end

function CompPublicIconItemType1:Image_Sub_Lock_Visible()
  if self.ShowLockImg == false then
    return false
  end
  local itemType = self.itemType
  if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
    return false
  end
  local locked = ItemDataUtils.GetItemLocked(self.uid)
  return locked
end

function CompPublicIconItemType1:Group_Sub_Awaker_Head_Visible()
  if self.awakerOwnerFunc then
    return 0 ~= self.awakerOwnerFunc()
  end
  local itemType = self.itemType
  if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
    return false
  end
  if self.ShowOwnAwaker == false then
    return false
  end
  local ownAwaker = ItemDataUtils.GetItemOwner(self.uid)
  return ownAwaker and ownAwaker > 0
end

function CompPublicIconItemType1:Icon_Awaker_Image()
  if self.awakerOwnerFunc then
    return 0 ~= self.awakerOwnerFunc() and AwakerDataUtils.GetCircleHeadIcon(self.awakerOwnerFunc())
  end
  local itemType = self.itemType
  if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
    return false
  end
  local awaker = ItemDataUtils.GetItemOwner(self.uid)
  if not awaker or 0 == awaker then
    return ""
  end
  if self.mockOwner then
    local temp = self.mockOwner()
    if temp and 0 ~= temp then
      awaker = temp
    end
  end
  do return AwakerDataUtils.GetCircleHeadIcon end
  return AwakerDataUtils.GetCircleHeadIcon, awaker
end

function CompPublicIconItemType1:Image_Michi_Visible()
  if not self.uid or 0 == self.uid then
    return false
  end
  local itemType = self.itemType
  if itemType ~= ItemType.Trinket then
    return false
  end
  local mainAttr = AwakerTrinketDataUtils.GetMainAttr(self.uid)
  if not mainAttr then
    return false
  end
  return true
end

function CompPublicIconItemType1:Image_Icon_Image()
  if not self.uid or 0 == self.uid then
    return ""
  end
  local itemType = self.itemType
  if itemType ~= ItemType.Trinket then
    return ""
  end
  local mainAttr = AwakerTrinketDataUtils.GetMainAttr(self.uid)
  if not mainAttr then
    return ""
  end
  local attrType = DT.ActorAttrType[mainAttr.attrId]
  return attrType and attrType.Icon or ""
end

function CompPublicIconItemType1:Image_Select_Visible()
  return self.clickFrameShowFunc and self.clickFrameShowFunc(self.uid, self.tid)
end

function CompPublicIconItemType1:Btn_Sub_Subtract_Visible()
  if self.showSubBtn then
    return self.showSubBtn
  end
  if not self.selectNumFunc or not self.btnSubFunc then
    return false
  end
  local selectNum = self.selectNumFunc()
  return selectNum > 0
end

function CompPublicIconItemType1:Text_Article_Count_Visible()
  local hasChosen = self.selectedFunc and self.selectedFunc()
  if not hasChosen or not self.selectNumFunc then
    return false
  end
  if not self.showMultiSelect then
    return false
  end
  local selectNum = self.selectNumFunc()
  return selectNum > 0
end

function CompPublicIconItemType1:Image_Dis_Visible()
  if not self.activityPrizeState then
    return false
  end
  return self.activityPrizeState == CommonDefine.CommonState.Finish
end

function CompPublicIconItemType1:Image_Receive_Visible()
  if not self.activityPrizeState then
    return false
  end
  return self.activityPrizeState == CommonDefine.CommonState.GainPrize
end

function CompPublicIconItemType1:OnRedFunc()
  if self.redFunc then
    do return end
    return self.redFunc, nil, nil
  end
  if self.hideIsNew then
    return false
  end
  if self.ShowRedDot == false then
    return false
  end
  local isNew = ItemDataUtils.IsItemNew(self.uid)
  if isNew then
    do return RedPointDataUtils.ShowRedPointState end
    return RedPointDataUtils.ShowRedPointState, {isNew = 1}
  end
  return false
end

function CompPublicIconItemType1:InitImageDis()
  self.ui.Image_Dis:SetActive(self:Image_Dis_Visible())
end

function CompPublicIconItemType1:InitBtnClick()
  self:SetLongPressButtonIntervalTime(self.ui.Btn_Click, tonumber(DT.GetConstant("ItemAddPressTime")))
  self:AddLongPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnLongClick))
  self:AddShortPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnShortClick))
  self:SetLongPressButtonIntervalTime(self.ui.Btn_Sub_Subtract, tonumber(DT.GetConstant("ItemAddPressTime")))
  self:AddShortPressButtonListener(self.ui.Btn_Sub_Subtract, System.fn(self, self.OnSubClick))
end

function CompPublicIconItemType1:InitSubSelectGroup()
  self.ui.Text_Article_Count:SetActive(self:Text_Article_Count_Visible())
  self.ui.Group_Sub_Select:SetActive(self.selectedFunc and self.selectedFunc())
  local selectNum = self.selectNumFunc and self.selectNumFunc()
  if not selectNum then
    return
  end
  self:SetText(self.ui.Text_Article_Count, selectNum)
  UIUtils.RefreshSelectCountLayout(self.ui.Text_Article_Count, self.ui.Image_Select_Bg, selectNum)
end

function CompPublicIconItemType1:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicIconItemType1
