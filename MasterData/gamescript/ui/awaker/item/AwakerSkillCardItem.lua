local AwakerSkillCardItem, Super = System.NewComponent("AwakerSkillCardItem")

function AwakerSkillCardItem:ctor(res, initData)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_CardResource(res)
  self.slotData = Vue.computed(function()
    if not initData then
      return
    end
    if initData.slotData then
      local awakerData = self:_GetAwakerDataBySlotData(initData.slotData)
      if AwakerDataUtils.HasOwnedAwaker(awakerData.tid) or table.next(DataCenter.awakerData.mockAwakerMap) then
        return awakerData and awakerData.skills[initData.slotData.slot]
      end
      local skills = AwakerDataUtils.GetNotOwnAwakerSkills(awakerData.tid)
      return skills[initData.slotData.slot]
    end
    return initData.slotData
  end)
  self.showCardLevelFunc = initData and initData.showCardLevelFunc
  self.cardHighlightFunc = initData and initData.cardHighlightFunc
  self.clickCallback = initData and initData.clickCallback
  self.showNextLevelDesc = initData and initData.showNextLevelDesc
  self.showCurLevel = Vue.ref(self.slotData.value.level)
  self.isPreview = initData.isPreview
end

function AwakerSkillCardItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Existing_1, System.fn(self, self._GetSkillCurLv))
  binder:BindToText(self.ui.Text_Basis_1, System.fn(self, self._GetSkillMaxLv))
  binder:BindToTextColor(self.ui.Text_Existing_1, System.fn(self, self._BindCurLevelTextColorChanged))
  binder:BindToVisible(self.ui.Image_Quantity_1, System.fn(self, self._IsCardLvShow))
  binder:BindToVisible(self.ui.Image_LevelUP, System.fn(self, self._ShowLevelUpIcon))
  self:BindSkillCardItem(binder)
end

function AwakerSkillCardItem:_ShowLevelUpIcon()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  if self.isPreview then
    return false
  end
  if not self.slotData.value then
    return false
  end
  local awakerData = self:_GetAwakerDataBySlotData(self.slotData.value)
  if not AwakerDataUtils.HasOwnedAwaker(awakerData.tid) then
    return false
  end
  do return AwakerDataUtils.IsSlotCanUpgrade, awakerData end
  return AwakerDataUtils.IsSlotCanUpgrade, awakerData, self.slotData.value.slot
end

function AwakerSkillCardItem:_IsCardLvShow()
  if self.showCardLevelFunc then
    do return end
    return self.showCardLevelFunc
  end
  return true
end

function AwakerSkillCardItem:_GetAwakerDataBySlotData(slotData)
  if not slotData then
    return
  end
  local skillTid = slotData.tid or 0
  local config = DT.Skill[skillTid]
  if config then
    local awakerData = AwakerDataUtils.GetAwakerData(config.AwakerID)
    return awakerData
  end
end

function AwakerSkillCardItem:_GetSkillCurLv()
  if not self.showCurLevel.value then
    return
  end
  if self.isPreview then
    local val = 6
    do return LT.Textf, "MaxLvPreview_Txt" end
    return LT.Textf, "MaxLvPreview_Txt", val
  end
  return self.showCurLevel.value
end

function AwakerSkillCardItem:_GetSkillMaxLv()
  if not self.slotData.value then
    return
  end
  local skillConfig = DT.Skill[self.slotData.value.tid]
  local awakerTid = skillConfig and skillConfig.AwakerID
  local slotLv = AwakerDataUtils.GetSkillSlotLevel(awakerTid, self.slotData.value.slot)
  local extraLv = math.max(0, self.slotData.value.level - slotLv)
  local cfgLevel = DT.GetConstant("AwakerSkillUpperLevel")
  return cfgLevel + extraLv
end

function AwakerSkillCardItem:OnLongPressCard()
  local skillConfig = DT.Skill[self.slotData.value.tid]
  local awakerData = self:_GetAwakerDataBySlotData(self.slotData.value)
  if table.next(DataCenter.awakerData.mockAwakerMap) then
    awakerData = DataCenter.awakerData.mockAwakerMap[skillConfig and skillConfig.AwakerID or 0]
  end
  local cardData = {
    cardUid = nil,
    cardTid = self.slotData.value.tid,
    cardDesc = self.cardItem:GetCardDesc(),
    cardLevel = self.slotData.value.level or 1,
    awakerData = awakerData
  }
  UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, cardData)
end

function AwakerSkillCardItem:BindSkillCardItem(binder)
  self.cardItem = binder:BindComponent(AwakerSkillCardBaseItem(self.ui.Item_Card_Base, nil, self.slotData.value.tid))
  self.cardItem:SetClickCallback(self.clickCallback)
  self.cardItem:SetSkipAutoKeywordTips(true)
  self.cardItem:SetLongPressedCallback(System.fn(self, self.OnLongPressCard))
  binder:BindToRaw(function(_, isSelect)
    if self.cardItem then
      self.cardItem:SetSelectShow(isSelect)
    end
  end, System.fn(self, self._IsSelected))
  binder:BindToRaw(function(_, nVal)
    if not nVal then
      return
    end
    if self.cardItem then
      self.cardItem:UpdateCardLevel(nVal)
    end
    self.showCurLevel.value = nVal
  end, function()
    if not self.slotData.value then
      return
    end
    local level = self.slotData.value.level
    if self.showNextLevelDesc and self.showNextLevelDesc() then
      level = level + 1
      local maxLevel = self:_GetSkillMaxLv()
      if level > maxLevel then
        level = maxLevel
      end
    end
    if self.isPreview then
      level = self:_GetSkillMaxLv()
    end
    return level
  end)
end

function AwakerSkillCardItem:_BindCurLevelTextColorChanged()
  if not self.slotData.value or not self.showCurLevel.value then
    return CommonDefine.ColorType.Normal
  end
  if self.slotData.value.level < self.showCurLevel.value then
    return CommonDefine.ColorType.Light
  end
  return CommonDefine.ColorType.Normal
end

function AwakerSkillCardItem:_IsSelected()
  if self.cardHighlightFunc then
    do return end
    return self.cardHighlightFunc
  end
  return false
end

return AwakerSkillCardItem
