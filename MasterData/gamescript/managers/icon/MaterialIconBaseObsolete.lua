local ItemType = CommonDefine.ItemType
local _SetWidth = CS.Framework.TransformUtil.SetWidth
local _SetHeight = CS.Framework.TransformUtil.SetHeight
local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local UI_Vx_Common_Goods_Select_02 = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Common_Goods_Select_02_1.prefab"
local MaterialIconBaseObsolete = NewClass("MaterialIconBaseObsolete")

function MaterialIconBaseObsolete:ctor(container)
  self.gameObject = container.gameObject
  self.data = nil
  self.binder = nil
end

function MaterialIconBaseObsolete:GetData()
  return self.data
end

function MaterialIconBaseObsolete:SetProxy(proxy)
  self.proxy = proxy
end

function MaterialIconBaseObsolete:SetData(data)
  self.data = data
  self.activityPrizeState = nil
  if data.supportPrizeState then
    self.activityPrizeState = data.activityPrizeState and Vue.ref(data.activityPrizeState)
  end
end

function MaterialIconBaseObsolete:Dispose()
  self:StopReceiveEffect()
  if self.binder then
    self.binder:teardown()
    self.binder = nil
  end
end

function MaterialIconBaseObsolete:SetBinder(binder)
  if self.parentBinder ~= binder and self.binder then
    self.binder:teardown()
    self.binder = nil
  end
  self.parentBinder = binder
  if not self.binder then
    self.binder = binder:createChild()
    binder:onDestroy(function()
      self.binder = nil
    end)
    self.binder:UpdateLocalizedTextAndResouce(self.ui.uiNode)
  end
  self.binder:clearChildren()
end

function MaterialIconBaseObsolete:OnActive()
  self:Refresh()
end

function MaterialIconBaseObsolete:OnDeative()
  self:StopReceiveEffect()
  if self.binder then
    self.binder:teardown()
    self.binder = nil
  end
end

function MaterialIconBaseObsolete:Refresh()
  self:RefreshIcon()
  self:RefreshQuality()
  self:BindTagNew()
  self:BindTagRedDot()
  self:BindPress()
  self:BindSelected()
  self:BindLockStatus()
  self:BindMaterialOwner()
  self:BindReceived()
  self:BindBtnSubtract()
  self:BindAdvancedSelected()
  self:BindReceiveEffect()
  self:BindArticleNumber()
  self:BindFrameVisible()
  self:RefreshTrinketMainAttr()
  self:BindWeaponRefineStarts()
  self:UpdateByConfig()
  self:BindExpired()
  if self.ui.Group_NoEquip then
    self.ui.Group_NoEquip:SetActive(false)
  end
end

function MaterialIconBaseObsolete:UpdateByConfig()
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

function MaterialIconBaseObsolete:BindReceiveEffect()
  if not self.data.supportPrizeState then
    self.ui.Image_Receive:SetActive(false)
    self.ui.Image_Dis:SetActive(false)
    self:StopReceiveEffect()
    return
  end
  self.binder:BindToRaw(function(_, state)
    self.ui.Image_Receive:SetActive(state == CommonDefine.CommonState.GainPrize)
    self.ui.Image_Dis:SetActive(state == CommonDefine.CommonState.Finish)
    if state == CommonDefine.CommonState.GainPrize then
      self:TryPlayReceiveEffect()
    else
      self:StopReceiveEffect()
    end
  end, function()
    return CommonDefine.CommonState.GainPrize
  end)
end

function MaterialIconBaseObsolete:TryPlayReceiveEffect()
  if not self.receivedEff or not self.receivedEff:IsValid() then
    self.receivedEff = self.binder:PlayEffect(UI_Vx_Common_Goods_Select_02, self.ui.Image_Receive, 0, 0, true)
  end
  self.receivedEff:SetActive(true)
end

function MaterialIconBaseObsolete:StopReceiveEffect()
  if not self.receivedEff or not self.receivedEff:IsValid() then
    return
  end
  self.binder:StopEffect(self.receivedEff)
  self.receivedEff = nil
end

function MaterialIconBaseObsolete:BindBtnSubtract()
  if not self.data.btnSubFunc then
    self.ui.Btn_Sub_Subtract:SetActive(false)
    return
  end
  self.binder:BindToVisible(self.ui.Btn_Sub_Subtract, function()
    if not self.data.selectNumFunc then
      return false
    end
    local selectNum = self.data.selectNumFunc()
    return selectNum > 0
  end)
  self.binder:BindLongPressButton(self.ui.Btn_Sub_Subtract, System.fn(self, self.OnSubClick), System.fn(self, self.OnSubClick), tonumber(DT.GetConstant("Role_Press_Time")), true)
end

function MaterialIconBaseObsolete:BindReceived()
  if not self.data.showReceivedFunc then
    self.ui.Group_Get:SetActive(false)
    return
  end
  self.binder:BindToVisible(self.ui.Group_Get, function()
    if self.data.showReceivedFunc then
      do return end
      return self.data.showReceivedFunc, nil
    end
  end)
end

function MaterialIconBaseObsolete:BindMaterialOwner()
  if not self:_IsTrinket() and not self:_IsWeapon() then
    self.ui.Group_Sub_Awaker_Head:SetActive(false)
    return
  end
  self.binder:BindToRaw(function(childBinder, awaker)
    if self.data.ShowOwnAwaker == false then
      self.ui.Group_Sub_Awaker_Head:SetActive(false)
      return false
    end
    local awakerId = awaker
    self.ui.Group_Sub_Awaker_Head:SetActive(0 ~= awakerId)
    if 0 == awakerId then
      return
    end
    if not AwakerDataUtils.IsAwakerShow(awakerId) then
      awakerId = AwakerDataUtils.GetChangerForm(awakerId)
    end
    local iconPath = self.data.iconItemModel:GetAwakerCircleHeadIcon(awakerId)
    self.binder:SetImage(self.ui.Icon_Awaker, iconPath)
  end, function()
    local ownAwaker = self.data.iconItemModel:GetItemOwner(self.data.uid)
    return ownAwaker or 0
  end)
end

function MaterialIconBaseObsolete:BindLockStatus()
  if not self:_IsTrinket() and not self:_IsWeapon() then
    self.ui.Image_Sub_Lock:SetActive(false)
    return
  end
  self.binder:BindToVisible(self.ui.Image_Sub_Lock, function()
    do return self.data.iconItemModel.GetItemLocked, self.data.iconItemModel end
    return self.data.iconItemModel.GetItemLocked, self.data.iconItemModel, self.data.uid
  end)
end

function MaterialIconBaseObsolete:BindTagNew()
  self.binder:BindToRaw(function(_, isNew)
    if self.data.ShowNew == false then
      self.ui.Group_Sub_RedDot:SetActive(false)
      return
    end
    self.ui.Group_Sub_RedDot:SetActive(isNew)
    self.ui.Group_New:SetActive(isNew)
    if isNew then
      self.binder:UpdateLocalizedTextAndResouce(self.ui.Group_Sub_RedDot)
    end
  end, function()
    if self.redFunc then
      do return end
      return self.redFunc, nil, nil
    end
    if self.showRedDot == false then
      return false
    end
    local isNew = self.data.iconItemModel and self.data.iconItemModel:IsItemNew(self.data.uid) or false
    if isNew then
      return true
    end
    return false
  end)
end

function MaterialIconBaseObsolete:UpdateTagRedDot(isRed)
  if self.data.ShowNew == false then
    self.ui.Group_Sub_RedDot:SetActive(false)
    return
  end
  local isNew = self.data.iconItemModel and self.data.iconItemModel:IsItemNew(self.data.uid) or false
  if isNew then
    self.ui.Group_RedDot:SetActive(false)
    return
  end
  self.ui.Group_RedDot:SetActive(isRed)
  if isRed and not self.ui.Group_Sub_RedDot.activeInHierarchy then
    self.ui.Group_Sub_RedDot:SetActive(true)
  end
end

function MaterialIconBaseObsolete:BindTagRedDot()
  self.binder:BindToRaw(function(_, isRed)
    self:UpdateTagRedDot(isRed)
  end, function()
    if self.data.showRedFunc then
      do return end
      return self.data.showRedFunc, nil
    end
    return false
  end)
end

function MaterialIconBaseObsolete:BindSelected()
  self.binder:BindToRaw(function(_, nVal)
    self.ui.Image_Select:SetActive(nVal)
    if nVal and self.data.iconItemModel then
      self.data.iconItemModel:ReqRemoveNew(self.data.uid)
      if ItemDataUtils.IsSpecificOnceRedItem(self.data.tid) then
        RedPointDataUtils.UpdateSpecificItemOnceRed(self.data.tid, false)
      end
      local isRed = false
      if self.data.showRedFunc then
        isRed = self.data.showRedFunc()
      end
      self:UpdateTagRedDot(isRed)
    end
  end, function()
    return self.data.clickFrameShowFunc and self.data.clickFrameShowFunc(self.data.uid, self.data.tid)
  end)
end

function MaterialIconBaseObsolete:BindAdvancedSelected()
  if not self.data.supportAdvancedSelected then
    self.ui.Group_Sub_Select:SetActive(false)
    return
  end
  self.binder:BindToRaw(function(_, isSelected)
    self.ui.Group_Sub_Select:SetActive(isSelected)
    self.ui.Image_Tick:SetActive(isSelected and not self.data.showMultiSelect)
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

function MaterialIconBaseObsolete:RefreshIcon()
  if self.data.isRelic then
    self.binder:SetImage(self.ui.Icon, RelicDataUtils.GetRelicIcon(self.data.tid))
  else
    self.binder:SetImage(self.ui.Icon, ItemDataUtils.GetIcon(self.data.tid))
  end
end

function MaterialIconBaseObsolete:RefreshQuality()
  if self.data.isRelic then
    local config = RelicDataUtils.GetRelicConfig(self.data.tid)
    self.binder:SetImage(self.ui.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(config, self.ui.Image_Bg_Black))
  else
    local config = DT.Item[self.data.tid]
    self.binder:SetImage(self.ui.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(config, self.ui.Image_Bg_Black))
  end
end

function MaterialIconBaseObsolete:BindPress()
  self.binder:BindLongPressButton(self.ui.Btn_Click, function()
    if self.data.uid and self.data.iconItemModel then
      self.data.iconItemModel:ReqRemoveNew(self.data.uid)
    end
    if self.longPressCallback then
      self.longPressCallback(self.data.tid, self.data.uid)
      return
    end
    if self.data.onClick then
      self.data.onClick(self.data.tid, self.data.uid)
    end
  end, System.fn(self, self.OnClick), tonumber(DT.GetConstant("Role_Press_Time")))
end

function MaterialIconBaseObsolete:OnClick()
  if not self.data.onClick then
    return
  end
  self.data.onClick(self.data.tid, self.data.uid)
  if self.data.uid and self.data.iconItemModel then
    self.data.iconItemModel:ReqRemoveNew(self.data.uid)
  end
end

function MaterialIconBaseObsolete:OnSubClick(triggeredTimes)
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

function MaterialIconBaseObsolete:BindArticleNumber()
  if self.data.hideGroupDown then
    self.ui.Group_Down:SetActive(false)
    return
  end
  self.ui.Group_Down:SetActive(true)
  if self:_IsWeapon() then
    self.binder:SetText(self.ui.Text_Article_Number, "")
    return
  end
  self.binder:BindToRaw(function(_, nLevel)
    self.binder:SetText(self.ui.Text_Article_Number, nLevel)
  end, function()
    if self:_IsTrinket() then
      local level = 0
      if self.data.iconItemModel then
        level = self.data.iconItemModel:GetTrinketLevelByUid(self.data.uid)
      end
      if level < 0 then
        level = 0
      end
      do return string.format, "+%s" end
      return string.format, "+%s", level
    end
    local num = self.data.iconItemModel and self.data.iconItemModel:GetItemNumByTid(self.data.tid) or 0
    if self.data.articleNumberShowFunc then
      num = self.data.articleNumberShowFunc(self.data.tid, num)
    end
    return num
  end)
end

function MaterialIconBaseObsolete:BindFrameVisible()
  local isShow = not self.data.hideBg
  if self.ui.Group_Bg then
    self.ui.Group_Bg:SetActive(isShow)
  end
  if self.ui.Image_Quality then
    self.ui.Image_Quality:SetActive(isShow)
  end
  self.binder:onDestroy(function()
    if self.ui and self.ui.Group_Bg and not IsNil(self.ui.Group_Bg) then
      self.ui.Group_Bg:SetActive(true)
    end
    if self.ui and self.ui.Image_Quality and not IsNil(self.ui.Image_Quality) then
      self.ui.Image_Quality:SetActive(true)
    end
  end)
end

function MaterialIconBaseObsolete:RefreshTrinketMainAttr()
  if not self:_IsTrinket() then
    self.ui.Image_Michi:SetActive(false)
    return
  end
  local mainAttr
  if self.data.uid and 0 ~= self.data.uid then
    mainAttr = AwakerTrinketDataUtils.GetMainAttr(self.data.uid)
  end
  self.ui.Image_Michi:SetActive(nil ~= mainAttr)
  if mainAttr then
    local attrType = DT.ActorAttrType[mainAttr.attrId]
    if attrType and attrType.Icon then
      self.binder:SetImage(self.ui.Image_Icon, attrType.Icon)
    end
  end
end

function MaterialIconBaseObsolete:BindWeaponRefineStarts()
  if self.data.hideRefineInfo or not self:_IsWeapon() then
    self.ui.Group_Stars:SetActive(false)
    return
  end
  if self.data.weaponStarShowFunc then
    local actived = self.data.weaponStarShowFunc()
    self.ui.Group_Stars:SetActive(actived)
    return
  end
  self.ui.Group_Stars:SetActive(true)
  self.binder:BindToRaw(function(childBinder, level)
    local numStars = math.min(level, RefineStage1MaxLevel)
    for i = 1, 5 do
      local obj = self.ui["Star_" .. i]
      if obj then
        childBinder:SetActive(obj, i <= numStars)
      end
    end
    if level > RefineStage1MaxLevel then
      self.ui.Image_Max:SetActive(true)
      childBinder:SetText(self.ui.Text_Max, level - RefineStage1MaxLevel)
    else
      self.ui.Image_Max:SetActive(false)
    end
  end, function()
    local uid = self.data.uid
    if uid and 0 ~= uid then
      return self.data.iconItemModel and self.data.iconItemModel:GetWeaponRefineLevelByUid(self.data.uid) or 0
    end
    do return ItemDataUtils.GetItemDefaultLevel end
    return ItemDataUtils.GetItemDefaultLevel, self.data.tid, self.data.uid
  end)
end

function MaterialIconBaseObsolete:BindExpired()
  self.ui.Image_Time:SetActive(false)
  if self.data.isRelic then
    self.ui.Image_Time:SetActive(false)
    return false
  end
  local config = ItemDataUtils.GetItemConfig(self.data.tid)
  if config.Type == ItemType.Special then
    self.binder:BindToVisible(self.ui.Image_Time, function()
      return config.SubType == CommonDefine.ItemSubType.BackTrack
    end)
  end
end

function MaterialIconBaseObsolete:_IsTrinket()
  if self.data.isRelic then
    return false
  end
  local itemType = ItemDataUtils.GetItemType(self.data.tid)
  return itemType == ItemType.Trinket
end

function MaterialIconBaseObsolete:_IsWeapon()
  if self.data.isRelic then
    return false
  end
  local itemType = ItemDataUtils.GetItemType(self.data.tid)
  return itemType == ItemType.Weapon
end

return MaterialIconBaseObsolete
