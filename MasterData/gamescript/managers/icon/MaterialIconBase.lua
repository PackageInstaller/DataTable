local ItemType = CommonDefine.ItemType
local _SetWidth = CS.Framework.TransformUtil.SetWidth
local _SetHeight = CS.Framework.TransformUtil.SetHeight
local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local Role_Press_Time = tonumber(DT.GetConstant("Role_Press_Time"))
local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local UI_Vx_Common_Goods_Select_02 = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Common_Goods_Select_02_1.prefab"
local BoundTrinketQualityKey = "UR"
local MaterialIconBase = NewClass("MaterialIconBase")

function MaterialIconBase:ctor(container)
  self.gameObject = container.gameObject
  self.data = nil
  self.view = nil
end

function MaterialIconBase:GetData()
  return self.data
end

function MaterialIconBase:SetProxy(proxy)
  self.proxy = proxy
end

function MaterialIconBase:SetData(data)
  self.data = data
end

function MaterialIconBase:Dispose()
  self:StopReceiveEffect()
  if self._boundLightComp then
    self._boundLightComp:OnExitComponent()
    self._boundLightComp = nil
  end
end

function MaterialIconBase:SetView(view)
  self.view = view
end

function MaterialIconBase:OnActive()
  if self.gameObject and self.view and self.view.binder then
    self.view.binder:UpdateLocalizedTextAndResouce(self.gameObject)
  end
  self:Refresh()
end

function MaterialIconBase:OnDeative()
  self:StopReceiveEffect()
end

function MaterialIconBase:Refresh()
  self:AddPressListeners()
  self:BindTagRedDot()
  self:RefreshIcon()
  self:RefreshQuality()
  self:RefreshTagNew()
  self:RefreshChoosedStatus()
  self:RefreshLockStatus()
  self:RefreshNoEquipIcon()
  self:RefreshMaterialOwner()
  self:RefreshBoundTrinketTag()
  self:RefreshBoundTrinketLight()
  self:RefreshArticleNumber()
  self:RefreshReceived()
  self:RefreshDisableNode()
  self:BindBtnSubtract()
  self:BindAdvancedSelected()
  self:RefreshTrinketMainAttr()
  self:RefreshWeaponRefineStarts()
  self:UpdateByConfig()
  self:BindExpired()
end

function MaterialIconBase:UpdateByConfig()
  if self.data.hideGroupDown then
    _SetWidth(self.ui.Image_Select.transform, 185)
    _SetHeight(self.ui.Image_Select.transform, 185)
    _SetLocalPos(self.ui.Image_Select.transform, 0, 10, 0)
  else
    _SetWidth(self.ui.Image_Select.transform, 185)
    _SetHeight(self.ui.Image_Select.transform, 214)
    _SetLocalPos(self.ui.Image_Select.transform, 0, 0, 0)
  end
end

function MaterialIconBase:SetPrizeState(state)
  self.view:SetActive(self.ui.Image_Receive, state == CommonDefine.CommonState.GainPrize)
  self.view:SetActive(self.ui.Image_Dis, state == CommonDefine.CommonState.Finish)
  if state == CommonDefine.CommonState.GainPrize then
    self:TryPlayReceiveEffect()
  else
    self:StopReceiveEffect()
  end
end

function MaterialIconBase:TryPlayReceiveEffect()
  if self.receivedEff or not self.receivedEff:IsValid() then
    self.receivedEff = self.view:PlayEffect(UI_Vx_Common_Goods_Select_02, self.ui.Image_Receive, 0, 0, true)
  end
  self.view:SetActive(self.receivedEff, true)
end

function MaterialIconBase:StopReceiveEffect()
  if not self.receivedEff or not self.receivedEff:IsValid() then
    return
  end
  self.view:StopEffect(self.receivedEff)
  self.receivedEff = nil
end

function MaterialIconBase:BindBtnSubtract()
  if not self.data.btnSubFunc then
    self.view:SetActive(self.ui.Btn_Sub_Subtract, false)
    return
  end
  if self.binder then
    self.binder:BindToVisible(self.ui.Btn_Sub_Subtract, function()
      if not self.data.selectNumFunc then
        return false
      end
      local selectNum = self.data.selectNumFunc()
      return selectNum > 0
    end)
    self.binder:BindLongPressButton(self.ui.Btn_Sub_Subtract, System.fn(self, self.OnSubClick), System.fn(self, self.OnSubClick), tonumber(DT.GetConstant("Role_Press_Time")), true)
  end
end

function MaterialIconBase:RefreshReceived()
  self.view:SetActive(self.ui.Group_Get, false)
end

function MaterialIconBase:RefreshNoEquipIcon()
  if self.data.noEquipFunc ~= nil then
    self.view:SetActive(self.ui.Group_NoEquip, self.data.noEquipFunc())
  else
    self.view:SetActive(self.ui.Group_NoEquip, false)
  end
end

function MaterialIconBase:RefreshMaterialOwner()
  local awakerId = self.data.getOwnerTid and self.data.getOwnerTid(self.data.uid) or 0
  if self.data.getOwnerTid and 0 == awakerId then
    self.view:SetActive(self.ui.Group_Sub_Awaker_Head, false)
    return
  end
  if not self:_IsTrinket() and not self:_IsWeapon() then
    self.view:SetActive(self.ui.Group_Sub_Awaker_Head, false)
    return
  end
  local ownerAwakerId = 0 ~= awakerId and awakerId or ItemDataUtils.GetItemOwner(self.data.uid) or 0
  self.view:SetActive(self.ui.Group_Sub_Awaker_Head, 0 ~= ownerAwakerId)
  if 0 == ownerAwakerId then
    return
  end
  local iconPath = AwakerDataUtils.GetCircleHeadIcon(ownerAwakerId)
  self.view:SetImage(self.ui.Icon_Awaker, iconPath)
end

function MaterialIconBase:RefreshBoundTrinketTag()
  local isShow = self.data.isBoundTrinketTag and AwakerTrinketDataUtils.IsTrinketBoundForCellTag(self.data) or false
  self.view:SetActive(self.ui.Image_Trinket_Bind, isShow)
end

function MaterialIconBase:RefreshBoundTrinketLight()
  if not self:_IsTrinket() then
    if self._boundLightComp then
      self._boundLightComp:EnableLight(false)
    end
    return
  end
  if not self._boundLightComp then
    local hostBinder = self.view and self.view.binder or self.binder
    if not hostBinder then
      return
    end
    self._boundLightComp = UICompTrinketIconMat(self.ui.Icon, {binder = hostBinder})
  end
  local partIndex = AwakerTrinketDataUtils.GetTrinketLightPartIndex(self.data.tid)
  self._boundLightComp:EnableLight(AwakerTrinketDataUtils.IsTrinketBoundForLight(self.data.uid), partIndex)
end

function MaterialIconBase:RefreshLockStatus()
  if not self:_IsTrinket() and not self:_IsWeapon() then
    self.view:SetActive(self.ui.Image_Sub_Lock, false)
    return
  end
  local isLocked = ItemDataUtils.GetItemLocked(self.data.uid)
  self.view:SetActive(self.ui.Image_Sub_Lock, isLocked)
end

function MaterialIconBase:RefreshTagNew()
  local isNew = self:_IsItemNew(self.data.uid)
  self.view:SetActive(self.ui.Group_New, isNew)
  if isNew and not self.ui.Group_Sub_RedDot.activeInHierarchy then
    self.view:SetActive(self.ui.Group_Sub_RedDot, true)
  end
end

function MaterialIconBase:RefreshTagRedDot(isRed)
  local isNew = self:_IsItemNew(self.data.uid)
  if isNew then
    self.view:SetActive(self.ui.Group_RedDot, false)
    return
  end
  self.view:SetActive(self.ui.Group_RedDot, isRed)
  if isRed and not self.ui.Group_Sub_RedDot.activeInHierarchy then
    self.view:SetActive(self.ui.Group_Sub_RedDot, true)
  end
end

function MaterialIconBase:BindTagRedDot()
  self.view.binder:BindToRaw(function(_, isRed)
    self:RefreshTagRedDot(isRed)
  end, function()
    if self.data.showRedFunc then
      do return end
      return self.data.showRedFunc, nil, nil, nil
    end
    return ItemDataUtils.IsSpecificOnceRedItem(self.data.tid) and RedPointDataUtils.GetRedPointState(RedTypeDefine.RedType.SpecificItemOnceRed, {
      self.data.tid
    }) or false
  end)
end

function MaterialIconBase:_ReqRemoveNew(uid)
  local isNew = self:_IsItemNew(uid)
  if not isNew then
    return
  end
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Item, RedPointDataUtils.RedAttrType.IsNew, uid)
end

function MaterialIconBase:_IsItemNew(uid)
  if self.data.hideIsNew then
    return false
  end
  if not uid or 0 == uid then
    return false
  end
  local redData = RedPointDataUtils.GetRedDataByTid(RedPointDataUtils.RedType.Item, uid)
  if nil == redData then
    return false
  end
  return 1 == redData.isNew
end

function MaterialIconBase:SetChoosed(isChoosed)
  self.view:SetActive(self.ui.Image_Select, isChoosed)
  if isChoosed then
    if ItemDataUtils.IsSpecificOnceRedItem(self.data.tid) then
      RedPointDataUtils.UpdateSpecificItemOnceRed(self.data.tid, false)
    end
    self:_ReqRemoveNew(self.data.uid)
  end
end

function MaterialIconBase:RefreshChoosedStatus()
  local isChoosed = false
  if self.data.isChoosed then
    isChoosed = self.data.isChoosed(self.data.uid, self.data.tid)
  end
  self:SetChoosed(isChoosed)
end

function MaterialIconBase:BindAdvancedSelected()
  if not self.binder or not self.data.supportAdvancedSelected then
    self.view:SetActive(self.ui.Group_Sub_Select, false)
    return
  end
  self.binder:BindToRaw(function(_, isSelected)
    self.view:SetActive(self.ui.Group_Sub_Select, isSelected)
    self.view:SetActive(self.ui.Image_Tick, isSelected and not self.data.showMultiSelect)
  end, function()
    return self.data.selectedFunc and self.data.selectedFunc(self.data.tid, self.data.uid)
  end)
  self.binder:BindToText(self.ui.Text_Article_Count, function()
    if not self.data.selectNumFunc then
      return ""
    end
    do return end
    return self.data.selectNumFunc, nil
  end)
  self.binder:BindToVisible(self.ui.Text_Article_Count, function()
    local hasChosen = self.data.selectedFunc and self.data.selectedFunc(self.data.tid, self.data.uid)
    if not hasChosen or not self.data.selectNumFunc then
      return false
    end
    if not self.data.showMultiSelect then
      return false
    end
    local selectNum = self.data.selectNumFunc()
    return selectNum > 0
  end)
end

function MaterialIconBase:RefreshIcon()
  if self.data.isRelic then
    self.view:SetImage(self.ui.Icon, RelicDataUtils.GetRelicIcon(self.data.tid))
  else
    self.view:SetImage(self.ui.Icon, ItemDataUtils.GetIcon(self.data.tid))
  end
end

function MaterialIconBase:_GetBoundTrinketQualityFrame()
  if not self.data.boundTrinketUrQuality then
    return nil
  end
  if not self:_IsTrinket() then
    return nil
  end
  if not AwakerTrinketDataUtils.IsTrinketBoundForLight(self.data.uid) then
    return nil
  end
  local qualityCfg = DT.ItemQuality[BoundTrinketQualityKey]
  return qualityCfg and qualityCfg.ItemQualityFrame or ""
end

function MaterialIconBase:RefreshQuality()
  if self.data.isRelic then
    local config = RelicDataUtils.GetRelicConfig(self.data.tid)
    self.view:SetImage(self.ui.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(config, self.ui.Image_Bg_Black))
    return
  end
  local boundFrame = self:_GetBoundTrinketQualityFrame()
  if boundFrame then
    self.view:SetImage(self.ui.Image_Quality, boundFrame)
    return
  end
  local config = DT.Item[self.data.tid]
  self.view:SetImage(self.ui.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(config, self.ui.Image_Bg_Black))
end

function MaterialIconBase:RefreshDisableNode()
  if not self.ui.Group_Disable then
    return
  end
  self.view:SetActive(self.ui.Group_Disable, self.data.displayDisableNode or false)
  self.view:SetText(self.ui.Text_Disable, self.data.disableText)
end

function MaterialIconBase:AddPressListeners()
  self.view:SetLongPressButtonIntervalTime(self.ui.Btn_Click, Role_Press_Time)
  self.view:AddShortPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnClick))
  self.view:AddLongPressButtonListener(self.ui.Btn_Click, function()
    local tid, uid = self.data.tid, self.data.uid
    self:_ReqRemoveNew(uid)
    if self.data.longPressCallback then
      self.data.longPressCallback(tid, uid)
      return
    end
    if self.data.onClick then
      self.data.onClick(tid, uid)
    end
  end)
end

function MaterialIconBase:OnClick()
  if not self.data.onClick then
    return
  end
  local tid, uid = self.data.tid, self.data.uid
  self:_ReqRemoveNew(uid)
  self.data.onClick(tid, uid)
end

function MaterialIconBase:OnSubClick(triggeredTimes)
  if not self.data.btnSubFunc then
    return
  end
  self.data.btnSubFunc(self.data.tid, self.data.uid)
  if triggeredTimes and triggeredTimes > 5 then
    local selectNum = self.data.selectNumFunc()
    for i = 1, selectNum do
      self.data.btnSubFunc(self.data.tid, self.data.uid)
    end
  end
end

function MaterialIconBase:RefreshArticleNumber()
  if self.data.hideGroupDown then
    self.view:SetActive(self.ui.Group_Down, false)
    self.view:SetActive(self.ui.Progress_Collection, false)
    return
  end
  self.view:SetActive(self.ui.Group_Down, true)
  self.view:SetActive(self.ui.Progress_Collection, false)
  local isShowNum = true
  if self:_IsWeapon() then
    isShowNum = false
  elseif self:_IsTrinket() then
    local sortType = BagExtModel.Instance:GetTrinketSortType()
    if sortType == CommonDefine.AwakerTrinketSortType.Level then
      local itemData = ItemDataUtils.GetItemByUid(self.data.uid)
      local level = itemData and (itemData.level or 0) or 0
      if level < 0 then
        level = 0
      end
      self.view:SetText(self.ui.Text_Article_Number, string.format("+%s", level))
    else
      local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.data.uid)
      self.view:SetText(self.ui.Text_Article_Number, completRate .. "%")
    end
  elseif self:_IsShowUseCount() then
    self.view:SetActive(self.ui.Progress_Collection, true)
    local num = ItemDataUtils.GetItemNum(self.data.tid) or 0
    local useCount = ItemDataUtils.GetMinUseCount(self.data.tid)
    self.view:SetText(self.ui.Text_Article_Number, useCount and string.format("%s/%s", num, useCount) or num)
    self.view:SetImageFillAmount(self.ui.Progress_Collection, math.min(1, num / useCount))
  elseif self:_IsKeeperSkill() then
    local name = ItemDataUtils.GetItemName(self.data.tid) or nil
    if not name then
      Logger.Info("钥令名未找到,钥令tid为", self.data.tid)
    end
    self.view:SetText(self.ui.Text_Article_Number, name)
  else
    local num = ItemDataUtils.GetItemNum(self.data.tid) or 0
    self.view:SetText(self.ui.Text_Article_Number, num)
  end
  self.view:SetActive(self.ui.Text_Article_Number, isShowNum)
end

function MaterialIconBase:RefreshTrinketMainAttr()
  if not self:_IsTrinket() then
    self.view:SetActive(self.ui.Image_Michi, false)
    return
  end
  local mainAttr
  if self.data.uid and 0 ~= self.data.uid then
    mainAttr = AwakerTrinketDataUtils.GetMainAttr(self.data.uid)
  end
  self.view:SetActive(self.ui.Image_Michi, nil ~= mainAttr)
  if mainAttr then
    local attrType = DT.ActorAttrType[mainAttr.attrId]
    if attrType and attrType.Icon then
      self.view:SetImage(self.ui.Image_Icon, attrType.Icon)
    end
  end
end

function MaterialIconBase:RefreshWeaponRefineStarts()
  if not self:_IsWeapon() then
    self.view:SetActive(self.ui.Group_Stars, false)
    return
  end
  self.view:SetActive(self.ui.Group_Stars, true)
  local itemData = ItemDataUtils.GetItemByUid(self.data.uid)
  local level = itemData and (itemData.level or 0) or ItemDataUtils.GetItemDefaultLevel(self.data.tid)
  local numStars = math.min(level, RefineStage1MaxLevel)
  for i = 1, 5 do
    local obj = self.ui["Star_" .. i]
    if obj then
      self.view:SetActive(obj, i <= numStars)
    end
  end
  if level > RefineStage1MaxLevel then
    self.view:SetActive(self.ui.Image_Max, true)
    self.view:SetText(self.ui.Text_Max, level - RefineStage1MaxLevel)
  else
    self.view:SetActive(self.ui.Image_Max, false)
  end
end

function MaterialIconBase:BindExpired()
  self.view:SetActive(self.ui.Image_Time, false)
  if self.data.isRelic then
    self.view:SetActive(self.ui.Image_Time, false)
    return false
  end
  local config = ItemDataUtils.GetItemConfig(self.data.tid)
  if config.Type == ItemType.Special then
    self.view:SetActive(self.ui.Image_Time, config.SubType == CommonDefine.ItemSubType.BackTrack)
    return
  end
  self.view:SetActive(self.ui.Image_Time, table.contains(CommonDefine.ExpiredItemTidList, self.data.tid))
end

function MaterialIconBase:_IsKeeperSkill()
  if self.data.isRelic then
    return false
  end
  local itemType = ItemDataUtils.GetItemType(self.data.tid)
  return itemType == ItemType.KeeperSkill
end

function MaterialIconBase:_IsTrinket()
  if self.data.isRelic then
    return false
  end
  local itemType = ItemDataUtils.GetItemType(self.data.tid)
  return itemType == ItemType.Trinket
end

function MaterialIconBase:_IsWeapon()
  if self.data.isRelic then
    return false
  end
  local itemType = ItemDataUtils.GetItemType(self.data.tid)
  return itemType == ItemType.Weapon
end

function MaterialIconBase:_IsMaterial()
  if self.data.isRelic then
    return false
  end
  local itemType = ItemDataUtils.GetItemType(self.data.tid)
  return itemType == ItemType.Material
end

function MaterialIconBase:_IsSpecial()
  if self.data.isRelic then
    return false
  end
  local itemType = ItemDataUtils.GetItemType(self.data.tid)
  return itemType == ItemType.Special
end

function MaterialIconBase:_IsShowUseCount()
  do return ItemDataUtils.IsHaveUseCount end
  return ItemDataUtils.IsHaveUseCount, self.data.tid
end

return MaterialIconBase
