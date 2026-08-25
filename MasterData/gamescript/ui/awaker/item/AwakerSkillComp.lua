local AwakerPage = CommonDefine.AwakerPage
local typeof = _ENV.typeof
local RectTransform = CS.UnityEngine.RectTransform
local SaveAndReload = CS.Z1Client.SaveAndReload
local _SetHeight = CS.Framework.TransformUtil.SetHeight
local AttributeScroll_Long_Height = 625
local AttributeScroll_Short_Height = 231
local AwakerSkillComp, Super = System.NewComponent("AwakerSkillComp", AwakerBasePageComp)

function AwakerSkillComp:ctor(res, awakerModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Skill_TrainingResource(res)
  self.isEnabled = Vue.ref(true)
  self.isPreview = Vue.ref(false)
  self._initData = nil
  if awakerModel then
    self.awakerModel = awakerModel
  end
  self.showNextLevelAttr = Vue.ref(false)
  self.skillHoverMap = {}
  self.skillHoverTimes = 0
end

function AwakerSkillComp:OnBind(binder)
  self.binder = binder
  self.saveAndReload = self.ui.uiNode:GetComponent(typeof(SaveAndReload))
  if self.awakerModel then
    self.skillModel = binder:createModel(AwakerSkillModel, self.awakerModel)
    self:_InitUltiSkillData()
  end
  self:_InitData(binder)
  self:_InitPosData()
  self.itemModel = binder:createModel(CommonIconItemModel)
  binder:BindToImage(self.ui.Icon_Awaker, System.fn(self, self._GetUltiSkillIcon))
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, System.fn(self, self._GetAwakerSchoolIcon))
  binder:BindToText(self.ui.Text_Skill_Name, System.fn(self, self._GetUltiSkillName))
  binder:BindToText(self.ui.Text_Skill, function()
    return false
  end)
  binder:BindToText(self.ui.Text_Skill_1, function()
    return false
  end)
  binder:BindToText(self.ui.Text_Hoist, System.fn(self, self._GetUltiSkillCurLv))
  binder:BindToText(self.ui.Text_Hoist_1, System.fn(self, self._GetUltiSkillCurLv))
  binder:BindToText(self.ui.Text_Foundation, System.fn(self, self._GetUltiSkillMaxLv))
  binder:BindToText(self.ui.Text_Foundation_1, System.fn(self, self._GetUltiSkillMaxLv))
  binder:BindToText(self.ui.Text_Hoist_2, System.fn(self, self._GetSelectSkillLv))
  binder:BindToText(self.ui.Text_Foundation_2, System.fn(self, self._GetSelectSkillMaxLv))
  binder:BindToText(self.ui.Text_Explain, System.fn(self, self._GetSkillStory))
  binder:BindToText(self.ui.Text_Awaker_Name, System.fn(self, self._GetAwakerName))
  binder:BindToText(self.ui.Text_Insufficient, System.fn(self, self._GetWarningTipsText))
  binder:BindToTextColor(self.ui.Text_Hoist_2, System.fn(self, self._GetCurLevelTextColorState))
  binder:BindToTextColor(self.ui.Text_Hoist, System.fn(self, self._BindUltiSkillCurLevelTextColor))
  binder:BindToVisible(self.ui.UI_Vx_UltiSkill_Activate02, System.fn(self, self._ShowUltiSkillActiveEffect))
  binder:BindToVisible(self.ui.Image_LevelUP, System.fn(self, self._EnableToUpgradeUtilSkill))
  binder:BindToVisible(self.ui.Image_Skill_Above, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_Skill_1, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_Maniac, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_Lv, System.fn(self, self._IsUltiSkillInfoVisible))
  binder:BindToVisible(self.ui.Image_Lv_1, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_List, System.fn(self, self._IsSelectSlot))
  binder:BindToVisible(self.ui.Image_State, function()
    return true
  end)
  binder:BindToVisible(self.ui.Image_Description, System.fn(self, self._ShowUltiSkillDesc))
  binder:BindToVisible(self.ui.ScrollView_Material, System.fn(self, self._IsCostListVisible))
  binder:BindToVisible(self.ui.UI_Common_Btn_Level2, System.fn(self, self._IsBtnLevelUpVisible))
  binder:BindToVisible(self.ui.Image_Tale, System.fn(self, self._ShowSkillStory))
  binder:BindToVisible(self.ui.Btn_Full, System.fn(self, self._IsSelectSkillMaxLv))
  binder:BindToVisible(self.ui.Btn_Current, System.fn(self, self._ShowNotMaxLevelUI))
  binder:BindToVisible(self.ui.Btn_Next, System.fn(self, self._ShowNotMaxLevelUI))
  binder:BindToVisible(self.ui.UI_Common_Group_Coin, System.fn(self, self._ShowNotMaxLevelUI))
  binder:BindToVisible(self.ui.Btn_Prompt_2, System.fn(self, self._ShowSkillDescTipsBtn))
  binder:BindToVisible(self.ui.Btn_Insufficient, System.fn(self, self._ShowWarningTips))
  binder:BindToVisible(self.ui.Btn_MaxLv, function()
    local isSelectSlot = self:_IsSelectSlot()
    local isAllSkillMaxLevel = self.skillModel:IsAllSkillLevelMax()
    return not isSelectSlot and not isAllSkillMaxLevel
  end)
  binder:BindZ1Button(self.ui.Btn_Click, System.fn(self, self._OnClickUltiSkill))
  binder:BindButtonClick(self.ui.Btn_Basis, System.fn(self, self._OnClickUltiSkill))
  binder:BindZ1Button(self.ui.Btn_Prompt_2, System.fn(self, self._OnClickSkillDescTips))
  binder:BindZ1Button(self.ui.Btn_Next, System.fn(self, self._OnClickNextLvBtn), System.fn(self, self._ShowNextLvBtnState))
  binder:BindZ1Button(self.ui.Btn_Current, System.fn(self, self._OnClickCurrLvBtn), System.fn(self, self._ShowCurrLvBtnState))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level2, System.fn(self, self._OnClickLevelUpBtn), System.fn(self, self._ShowLevelUpBtnState), System.fn(self, self._GetLevelUpText))
  binder:BindZ1Button(self.ui.Btn_MaxLv, function()
    if not self.isPreview.value then
      self.isPreview.value = true
    else
      self.isPreview.value = false
    end
  end, function()
    if self.isPreview.value == false then
      return CommonDefine.Z1ButtonState.Normal
    else
      return CommonDefine.Z1ButtonState.High
    end
  end)
  binder:BindToRaw(function()
    self.isPreview.value = false
  end, function()
    return self.awakerModel.selectAwakerId
  end)
  self:_BindAttributeScrollHeight(binder)
  self:_BindScrollView(binder)
  self.binder:BindToRaw(function(cBinder, isEnabled)
    if isEnabled then
      self:_BindSkillCardItem(cBinder)
    end
  end, function()
    return self.isEnabled.value
  end)
  self.binder:BindToRaw(function(cBinder, desc)
    self.binder:SetText(self.ui.Text_Skill_Desc, desc)
    local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Skill_Desc, 0, 0, 40)
    if comp and self.ui.Btn_Basis then
      comp:SetBtn(self.ui.Btn_Basis)
    end
  end, function()
    do return self._GetUltiSkillDesc end
    return self._GetUltiSkillDesc, self
  end)
  self:_BindGroupsMove(binder)
  self:_BindCurrency(binder)
  self:_BindCost(binder)
  self.binder:BindToRaw(function()
    self.binder:BindTimer(0.3, 0, nil, function()
      StrUtils.SetPreferredHeight(self.ui.Text_Explain, 10)
    end)
  end, function()
    do return self._GetSkillStory end
    return self._GetSkillStory, self
  end)
end

function AwakerSkillComp:_InitPosData()
  local cardGroupsRt = self.ui.Image_Cards:GetComponent(typeof(RectTransform))
  self.originCardGroupPos = cardGroupsRt.anchoredPosition
  self.ultiSkillRootRt = self.ui.Image_Foundation:GetComponent(typeof(RectTransform))
  self.originUltiSkillGroupPos = self.ultiSkillRootRt.anchoredPosition
  local groupRootsRt = self.ui.Group_Roots:GetComponent(typeof(RectTransform))
  self.upgradeCardGroupPos = groupRootsRt.anchoredPosition
  local upgradeUltiSkillRootRt = self.ui.Root_Ulti_Skill:GetComponent(typeof(RectTransform))
  self.upgradeUltiSkillGroupPos = upgradeUltiSkillRootRt.anchoredPosition
  local selectRootRt = self.ui.Root_Select:GetComponent(typeof(RectTransform))
  self.selectRootPos = selectRootRt.anchoredPosition
  local selectUltiSkillRootRt = self.ui.Root_Select_Ulti_Skill:GetComponent(typeof(RectTransform))
  self.selectUltiSkillRootPos = selectUltiSkillRootRt.anchoredPosition
  self.tipsBtnRt = self.ui.Btn_Prompt_2:GetComponent(typeof(RectTransform))
  self.tipsBtnUltiSkillPos = self.tipsBtnRt.anchoredPosition
  local tipsBtnCardRt = self.ui.Root_Btn_Tips:GetComponent(typeof(RectTransform))
  self.tipsBtnCardPos = tipsBtnCardRt.anchoredPosition
  self.upgradeCardOriginPos = {}
  if self.saveAndReload then
    self.saveAndReload:Save()
  end
end

function AwakerSkillComp:_InitData(binder)
  if not binder or self.skillModel and self.awakerModel then
    return
  end
  if not self._initData then
    return
  end
  self.awakerModel = binder:createModel(AwakerModel, {
    selectAwakerId = self._initData.awakerTid
  })
  self.skillModel = binder:createModel(AwakerSkillModel, self.awakerModel)
  self:_InitUltiSkillData()
end

function AwakerSkillComp:_InitUltiSkillData()
  self.ultiSkillData = Vue.computed(function()
    if not (self.skillModel and self.skillModel.skillList) or #self.skillModel.skillList <= 0 then
      return {}
    end
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerModel.selectAwakerId)
    if not awakerData then
      return {}
    end
    local AwakerSkillType = CommonDefine.AwakerSkillType
    for _, skill in ipairs(self.skillModel.skillList) do
      local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
      local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
      local skillTypes = BattleSkillUtils.GetSkillType(DT.Skill[skill.tid], breakSkillLevel, potencyLevel)
      if skillTypes[1] == AwakerSkillType.Ulti_Skill then
        return skill
      end
    end
    return {}
  end)
end

function AwakerSkillComp:_ShowUltiSkillActiveEffect()
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return
  end
  return self.ultiSkillData.value.slot == self.skillModel.selectSlot
end

function AwakerSkillComp:_EnableToUpgradeUtilSkill()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  if self.isPreview.value then
    return false
  end
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerModel.selectAwakerId)
  if not awakerData then
    return
  end
  if not AwakerDataUtils.HasOwnedAwaker(awakerData.tid) then
    return false
  end
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return
  end
  do return AwakerDataUtils.IsSlotCanUpgrade, awakerData end
  return AwakerDataUtils.IsSlotCanUpgrade, awakerData, self.ultiSkillData.value.slot
end

function AwakerSkillComp:_IsSelectSlot()
  return 0 ~= self.skillModel.selectSlot
end

function AwakerSkillComp:_IsUltiSkillInfoVisible()
  return true
end

function AwakerSkillComp:_ShowNotMaxLevelUI()
  if not self.awakerModel:HasOwnedAwaker(self.awakerModel.selectAwakerId) then
    return false
  end
  return not self:_IsSelectSkillMaxLv()
end

function AwakerSkillComp:_ShowSkillStory()
  do return self._IsSelectSkillMaxLv end
  return self._IsSelectSkillMaxLv, self
end

function AwakerSkillComp:_IsSelectSkillMaxLv()
  if not self:_IsSelectSlot() then
    return
  end
  do return self.skillModel.IsSkillLevelMax, self.skillModel end
  return self.skillModel.IsSkillLevelMax, self.skillModel, self.skillModel.selectSlot
end

function AwakerSkillComp:_IsCostListVisible()
  if not self.awakerModel:HasOwnedAwaker(self.awakerModel.selectAwakerId) then
    return false
  end
  return not self:_IsSelectSkillMaxLv()
end

function AwakerSkillComp:_IsBtnLevelUpVisible()
  if not self.awakerModel:HasOwnedAwaker(self.awakerModel.selectAwakerId) then
    return false
  end
  if not self.skillModel.canLevelUp then
    return false
  end
  return not self:_IsSelectSkillMaxLv()
end

function AwakerSkillComp:_GetSkillAttrUpgradeChanges()
  if not self.skillModel then
    return {}
  end
  return self.skillModel.skillChangeArgs
end

function AwakerSkillComp:_OnUpdateSkillAttrItem(childBinder, go, index)
  local data = self.skillModel.skillChangeArgs[index]
  
  local function _ShowAttrValueTextFunc()
    if self:_ShowNotMaxLevelUI() and self.showNextLevelAttr.value then
      return data.nextArgShowText
    end
    return data.currArgShowText
  end
  
  local function _ShowAttrNameTextFunc()
    return data.nameText
  end
  
  local itemData = {nameTextFunc = _ShowAttrNameTextFunc, attrValueTextFunc = _ShowAttrValueTextFunc}
  childBinder:BindComponent(AwakerTextAttrItem(go, itemData))
end

function AwakerSkillComp:_GetUpgradeCostItemList()
  if not self.skillModel then
    return {}
  end
  return self.skillModel.levelUpCostItems
end

function AwakerSkillComp:_GetCurLevelTextColorState()
  if self.showNextLevelAttr.value and not self:_IsSelectSkillMaxLv() then
    return CommonDefine.ColorType.Light
  end
  return CommonDefine.ColorType.Normal
end

function AwakerSkillComp:_GetSelectSkillLv()
  if not self.skillModel then
    return
  end
  if not self:_IsSelectSlot() then
    return
  end
  if self.showNextLevelAttr.value then
    return self.skillModel.targetLevel
  end
  return self.skillModel.selectSlotLevel
end

function AwakerSkillComp:_GetSelectSkillMaxLv()
  if not self.skillModel then
    return
  end
  if not self:_IsSelectSlot() then
    return
  end
  return self.skillModel.skillMaxLevel
end

function AwakerSkillComp:_GetAwakerName()
  if not self.awakerModel then
    return
  end
  do return self.awakerModel.GetAwakerName, self.awakerModel end
  return self.awakerModel.GetAwakerName, self.awakerModel, self.awakerModel.selectAwakerId
end

function AwakerSkillComp:_GetAwakerSchoolIcon()
  if not self.awakerModel then
    return
  end
  local tid = self.awakerModel.selectAwakerId
  local config = self.awakerModel:GetAwakerConfig(tid)
  if not config then
    return ""
  end
  local iconPath = self.awakerModel:GetSchoolIcon(config.School)
  return iconPath
end

function AwakerSkillComp:_GetSkillStory()
  if not self.skillModel then
    return
  end
  if not self:_IsSelectSlot() then
    return
  end
  do return self.skillModel.GetSkillStory, self.skillModel end
  return self.skillModel.GetSkillStory, self.skillModel, self.skillModel.selectSlot
end

local function GetCostItemNumText(needNum, currNum, effectResultValue)
  if not needNum or not currNum then
    return ""
  end
  local currNumText = currNum
  local notEnough = currNum < needNum
  if effectResultValue then
    notEnough = currNum < effectResultValue
  end
  if notEnough then
    currNumText = LT.Textf("<Color4:{s1}>", currNum)
  end
  if effectResultValue then
    needNum = LT.Textf("{s1} <color=#9A9A9A><Del:{s2}></color>", effectResultValue, needNum)
  end
  do return LT.Textf, "{s1}/{s2}", currNumText end
  return LT.Textf, "{s1}/{s2}", currNumText, needNum
end

function AwakerSkillComp:_OnUpdateCostItem(childBinder, go, index)
  local data = self.skillModel.levelUpCostItems[index]
  local item = ItemDataUtils.GetItemByTid(data.tid)
  local num = item and item.num or 0
  local numText = GetCostItemNumText(data.num, num) or ""
  
  local function _OnClickItem()
    local uid = item and item.uid
    local tid = data.tid
    ItemDataUtils.ShowItemDetailTips(childBinder, go, uid, tid)
  end
  
  local itemData = {
    tid = data.tid,
    num = numText,
    model = self.itemModel,
    callback = _OnClickItem
  }
  local itemComp = childBinder:BindComponent(CommonIconItem(go, itemData))
  childBinder:BindToRaw(function(_, nVal)
    if not nVal then
      return
    end
    itemComp:UpdateItemNum(nVal)
  end, function()
    local _item = ItemDataUtils.GetItemByTid(data.tid)
    local _num = _item and _item.num or 0
    local _numText = GetCostItemNumText(data.num, _num) or ""
    return _numText
  end)
end

function AwakerSkillComp:_GetUltiSkillIcon()
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return
  end
  do return self.skillModel.GetSkillAwakerIcon, self.skillModel end
  return self.skillModel.GetSkillAwakerIcon, self.skillModel, self.ultiSkillData.value.slot
end

function AwakerSkillComp:_GetUltiSkillName()
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return
  end
  do return self.skillModel.GetSkillName, self.skillModel end
  return self.skillModel.GetSkillName, self.skillModel, self.ultiSkillData.value.slot
end

function AwakerSkillComp:_GetUltiSkillDesc()
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return
  end
  local isSelectUltiSkill = self.ultiSkillData.value.slot == self.skillModel.selectSlot
  if self.showNextLevelAttr.value and isSelectUltiSkill then
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerModel.selectAwakerId)
    if not awakerData then
      return
    end
    local level = self.skillModel:GetSkillLevel(self.ultiSkillData.value.slot) + 1
    local maxLevel = self:_GetUltiSkillMaxLv()
    if self.isPreview.value then
      level = maxLevel
    end
    if maxLevel < level then
      level = maxLevel
    end
    local tid = self.ultiSkillData.value.tid
    do return SkillUtils.GetAwakerSkillDesc, awakerData, tid end
    return SkillUtils.GetAwakerSkillDesc, awakerData, tid, level
  end
  do return self.skillModel.GetSkillDesc, self.skillModel, self.ultiSkillData.value.slot, nil end
  return self.skillModel.GetSkillDesc, self.skillModel, self.ultiSkillData.value.slot, nil, self.isPreview.value, awakerData, tid, level
end

function AwakerSkillComp:_GetUltiSkillCurLv()
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return
  end
  if self.isPreview.value then
    local val = 6
    do return LT.Textf, "MaxLvPreview_Txt" end
    return LT.Textf, "MaxLvPreview_Txt", val
  end
  local level = self.skillModel:GetSkillLevel(self.ultiSkillData.value.slot)
  local isSelectUltiSkill = self.ultiSkillData.value.slot == self.skillModel.selectSlot
  if self.showNextLevelAttr.value and isSelectUltiSkill and level + 1 <= self.skillModel.skillMaxLevel then
    level = level + 1
  end
  return level
end

function AwakerSkillComp:_BindUltiSkillCurLevelTextColor()
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return CommonDefine.ColorType.Normal
  end
  local isSelectUltiSkill = self.ultiSkillData.value.slot == self.skillModel.selectSlot
  if self.showNextLevelAttr.value and isSelectUltiSkill then
    local level = self.skillModel:GetSkillLevel(self.ultiSkillData.value.slot)
    if level < self.skillModel.skillMaxLevel then
      return CommonDefine.ColorType.Light
    end
  end
  return CommonDefine.ColorType.Normal
end

function AwakerSkillComp:_GetUltiSkillMaxLv()
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return
  end
  do return self.skillModel.GetMaxLevel, self.skillModel end
  return self.skillModel.GetMaxLevel, self.skillModel, self.ultiSkillData.value.slot
end

function AwakerSkillComp:_GetWarningTipsText()
  local slot = self.skillModel.selectSlot
  local mode = self.skillModel.mode
  local level = self.skillModel:GetSkillLevel(slot, mode)
  if not AwakerDataUtils.CheckSkillLevelUpUnlockCondition(level, false) then
    do return AwakerDataUtils.GetSkillLevelUplockConditionTips end
    return AwakerDataUtils.GetSkillLevelUplockConditionTips, level, false
  end
  local warningText = LT.Textf("AwakerSkillUpgradeTips", self.skillModel.needAwakerLevel)
  return warningText
end

function AwakerSkillComp:_BindScrollView(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Attribute, System.fn(self, self._GetSkillAttrUpgradeChanges), System.fn(self, self._OnUpdateSkillAttrItem))
  binder:BindToCircularListView(self.ui.ScrollView_Material, System.fn(self, self._GetUpgradeCostItemList), System.fn(self, self._OnUpdateCostItem))
end

function AwakerSkillComp:_BindGroupsMove(binder)
  if not self.awakerModel then
    return
  end
  if not self.cardGroupsTf then
    self.cardGroupsTf = self.ui.Image_Cards:GetComponent(typeof(RectTransform))
  end
  if not self.ultiSkillRootTf then
    self.ultiSkillRootTf = self.ui.Image_Foundation:GetComponent(typeof(RectTransform))
  end
  local originUltiSkillScale = 1
  local changedUltiSkillScale = 1
  local scaleVector = CS.UnityEngine.Vector3(1, 1, 1)
  binder:BindToRaw(function(_, nSelectSlot, oSelectSlot)
    if not nSelectSlot then
      return
    end
    if oSelectSlot and nSelectSlot == oSelectSlot then
      return
    end
    local btnTipsPos = self.tipsBtnUltiSkillPos
    if 0 == nSelectSlot then
      scaleVector.x = originUltiSkillScale
      scaleVector.y = originUltiSkillScale
    else
      scaleVector.x = changedUltiSkillScale
      scaleVector.y = changedUltiSkillScale
    end
    local hasSelectSlot = nSelectSlot and 0 ~= nSelectSlot
    self:_SetGroupPos(hasSelectSlot)
    self.tipsBtnRt.anchoredPosition = btnTipsPos
  end, function()
    if not self.skillModel then
      return 0
    end
    return self.skillModel.selectSlot
  end)
end

function AwakerSkillComp:_SetGroupPos(hasSelectSlot)
  local cardGroupPos = hasSelectSlot and self.upgradeCardGroupPos or self.originCardGroupPos
  local ultiSkillRootPos = hasSelectSlot and self.upgradeUltiSkillGroupPos or self.originUltiSkillGroupPos
  self.cardGroupsTf.anchoredPosition = cardGroupPos
  self.ultiSkillRootTf.anchoredPosition = ultiSkillRootPos
end

function AwakerSkillComp:_SetUpgradeSkillPos(slot, isUltiSkill, _)
  local skill = self.skillModel.skillList[slot]
  if not skill then
    return
  end
  if isUltiSkill then
    local pos = self.selectUltiSkillRootPos
    self.ultiSkillRootTf.anchoredPosition = pos
  end
end

function AwakerSkillComp:_BindCurrency(binder)
  local currencyList = DT.GetOriginalConstant("GeneralCultivationNeedCurreny")
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, currencyList, false, true))
end

function AwakerSkillComp:_BindCost(binder)
  local com = binder:BindComponent(CommonCoinCostCom(self.ui.UI_Common_Group_Coin))
  binder:BindToRaw(function(_, need, _)
    if not need then
      return
    end
    local currencyItemId = self.skillModel.levelUpNeedMoneyData.tid
    com:UpdateItem(currencyItemId)
    com:UpdateOriValue("")
    local own = ItemDataUtils.GetItemNum(currencyItemId)
    com:NowColorNormal(need <= own)
    com:UpdateNow(need)
  end, function()
    if not self.skillModel.levelUpNeedMoneyData then
      return
    end
    local moneyNeed = self.skillModel.levelUpNeedMoneyData.num
    local effectType = CommonDefine.AwakerSpecialSkillType.ResNeedReduce
    local funcModule = "AwakerSkillLvUp"
    local awakerModel = self.awakerModel
    local effectResultValue = awakerModel:GetResNeedReducePreviewResult(moneyNeed, effectType, funcModule)
    return effectResultValue
  end)
end

function AwakerSkillComp:_BindSkillCardItem(binder)
  if not self.skillModel then
    return
  end
  self.isPreview.value = false
  local cardInitScalces = {}
  local AwakerSkillType = CommonDefine.AwakerSkillType
  binder:BindToRaw(function(childBinder, result)
    local awakerTid = result[1]
    if not awakerTid or 0 == awakerTid then
      return
    end
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerModel.selectAwakerId)
    local skillNum = 0
    for _, skill in ipairs(self.skillModel.skillList) do
      if skillNum > self.skillModel.MAX_SKILL_SHOW_NUM then
        break
      end
      if not skill then
      else
        local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awakerData)
        local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awakerData)
        local skillTypes = BattleSkillUtils.GetSkillType(DT.Skill[skill.tid], breakSkillLevel, potencyLevel)
        if skillTypes[1] == AwakerSkillType.Ulti_Skill then
        else
          skillNum = skillNum + 1
          local obj = self.ui["Cards_0" .. skillNum]
          if not obj then
          else
            local rt = obj.transform
            if not cardInitScalces[skillNum] then
              cardInitScalces[skillNum] = rt.localScale
            end
            
            local function _OnClickSkillCardItem()
              self:_OnClickSkill(skill.slot, obj)
            end
            
            local _initData = {
              cardHighlightFunc = function()
                return skill.slot == self.skillModel.selectSlot
              end,
              slotData = skill,
              clickCallback = _OnClickSkillCardItem,
              showNextLevelDesc = function()
                local isSelectSlot = skill.slot == self.skillModel.selectSlot
                return isSelectSlot and self.showNextLevelAttr.value
              end,
              showState = true,
              isPreview = self.isPreview.value
            }
            childBinder:BindComponent(AwakerSkillCardItem(obj, _initData))
            childBinder:BindToRaw(function(_, isSelectSlot)
              if nil == isSelectSlot then
                return
              end
            end, function()
              return skill.slot == self.skillModel.selectSlot
            end)
          end
        end
      end
    end
  end, function()
    return {
      self.awakerModel.selectAwakerId,
      self.isPreview.value
    }
  end)
end

function AwakerSkillComp:ShowNextLevelAttrValue(show)
  if nil == show then
    show = false
  end
  self.showNextLevelAttr.value = show
end

function AwakerSkillComp:_ShowNextLvBtnState()
  if self.showNextLevelAttr.value then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Normal
end

function AwakerSkillComp:_ShowCurrLvBtnState()
  if not self.showNextLevelAttr.value then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Normal
end

function AwakerSkillComp:_ShowUltiSkillDesc()
  if not self.skillModel or not self.skillModel.skillList then
    return false
  end
  return true
end

function AwakerSkillComp:_ShowSkillDescTipsBtn()
  return false
end

function AwakerSkillComp:_ShowLevelUpBtnState()
  local canLevelUp = self.skillModel.canLevelUp
  local enough = self.skillModel.isItemEnoughForLevelUp
  local costMoney = self.skillModel.levelUpNeedMoneyData and self.skillModel.levelUpNeedMoneyData.num or 0
  local canCompose = ItemAlchemyUtils.OpenUpgradeViewWithItemList(self.skillModel.levelUpCostItems, true, costMoney)
  local enableUpgrade = canLevelUp and (enough or canCompose)
  return enableUpgrade and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
end

function AwakerSkillComp:_ShowWarningTips()
  if not self.awakerModel:HasOwnedAwaker(self.awakerModel.selectAwakerId) then
    return false
  end
  local notMaxLv = not self:_IsSelectSkillMaxLv()
  local cantLevelUp = not self.skillModel.canLevelUp
  local showWarningTips = notMaxLv and cantLevelUp
  return showWarningTips
end

function AwakerSkillComp:_OnClickSkillDescTips()
  if not self:_IsSelectSlot() then
    return
  end
  self:OpenSkillAffixPanel(self.ui.Btn_Prompt_2)
end

function AwakerSkillComp:_OnClickUltiSkill()
  if not self.ultiSkillData or not self.ultiSkillData.value then
    return
  end
  self:_OnClickSkill(self.ultiSkillData.value.slot, self.ui.Image_State)
end

function AwakerSkillComp:_OnClickSkill(slot, ui)
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return
  end
  if not slot then
    return
  end
  local movePos = 0
  if not self.skillModel.selectSlot or 0 == self.skillModel.selectSlot then
    if slot == self.ultiSkillData.value.slot then
      movePos = self:GetUltiSkillPosMoveX()
    else
      movePos = self:GetCardPosMoveX()
    end
  end
  self.skillModel:ShowSkillLevelUp(true)
  self.skillModel:SetSelectSlot(slot)
  self.awakerModel:SetAwakerPage(AwakerPage.SkillDetail)
  self:OpenSkillAffixPanel(ui, movePos)
  self.binder:SetButtonState(self.ui.Btn_MaxLv, CommonDefine.Z1ButtonState.Normal)
  self.isPreview.value = false
end

function AwakerSkillComp:_OnClickCurrLvBtn()
  self:ShowNextLevelAttrValue(false)
end

function AwakerSkillComp:_OnClickNextLvBtn()
  self:ShowNextLevelAttrValue(true)
end

function AwakerSkillComp:_OnClickLevelUpBtn()
  local panel = UIManager.Instance:GetWindow(Urls.AwakerSkillAffixPanel)
  if panel and panel.cardKeyWordComp and not panel.cardKeyWordComp.isHide then
    return
  end
  if not self.skillModel.isItemEnoughForLevelUp then
    local costMoney = self.skillModel.levelUpNeedMoneyData and self.skillModel.levelUpNeedMoneyData.num or 0
    if not ItemAlchemyUtils.OpenUpgradeViewWithItemList(self.skillModel.levelUpCostItems, false, costMoney) then
      Alert.ShowStr(LT.Text("SkillUpgradeInsufficientMaterial"))
    end
    return
  end
  
  local function OnLevelUpSuccess()
    local awakerTid = self.skillModel.awakerTid
    UIManager.Instance:Reopen(Urls.ActiveSuccessPanel, LT.Text("Skill_LevelUp_Success"), nil, awakerTid)
    self.skillModel.awakerModel:SetCurAwakerVoice("", "")
  end
  
  self.skillModel:ReqAwakerSkillLevelUp(OnLevelUpSuccess)
end

function AwakerSkillComp:_GetLevelUpText()
  print("alc money skill", table.tostring(self.skillModel.levelUpNeedMoneyData))
  local costMoney = self.skillModel.levelUpNeedMoneyData and self.skillModel.levelUpNeedMoneyData.num or 0
  if self.skillModel.isItemEnoughForLevelUp or not ItemAlchemyUtils.OpenUpgradeViewWithItemList(self.skillModel.levelUpCostItems, true, costMoney) then
    do return LT.Text end
    return LT.Text, "RoleDetailsSkillLevelUp_Btn_Determine", true, costMoney
  else
    do return LT.Text end
    return LT.Text, "AwakerUpgradeMaterialCompose", true, costMoney
  end
end

function AwakerSkillComp:_BindAttributeScrollHeight(binder)
  binder:BindToRaw(function(_, nVal)
    if false == nVal then
      _SetHeight(self.ui.ScrollView_Attribute.transform, AttributeScroll_Long_Height)
    else
      _SetHeight(self.ui.ScrollView_Attribute.transform, AttributeScroll_Short_Height)
    end
  end, function()
    local isCostListVisible = self:_IsCostListVisible()
    local isShowSkillStory = self:_ShowSkillStory()
    return isCostListVisible or isShowSkillStory
  end)
end

function AwakerSkillComp:SetActive(bool)
  if not (self.ui and self.ui.uiNode) or not self.binder then
    return
  end
  if nil == bool then
    bool = false
  end
  self.isEnabled.value = bool
  self.binder:SetActive(self.ui.uiNode, bool)
end

function AwakerSkillComp:NeedOpenSkillAffixPanel(slot)
  return true
end

function AwakerSkillComp:OpenSkillAffixPanel(ui, movePos)
  local skill = self.skillModel.skillList[self.skillModel.selectSlot]
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerModel.selectAwakerId)
  local skillLevel = self.skillModel:GetSkillLevel(self.skillModel.selectSlot)
  if self.showNextLevelAttr.value then
    skillLevel = self.skillModel.targetLevel
  end
  UIManager.Instance:Reopen(Urls.AwakerSkillAffixPanel, skill.tid, awakerData, ui, skillLevel, movePos)
end

function AwakerSkillComp:OnClickHover()
  self.skillHoverTimes = 0
  for ui, info in pairs(self.skillHoverMap) do
    if info.hover then
      self:_OnClickSkill(info.slot, ui)
      return
    end
  end
end

function AwakerSkillComp:_GetHoverMapLen()
  local rst = 0
  for _, _ in pairs(self.skillHoverMap) do
    rst = rst + 1
  end
  return rst
end

function AwakerSkillComp:GetCardPosMoveX()
  if not self.originCardGroupPos or not self.upgradeCardGroupPos then
    return 0
  end
  return self.originCardGroupPos.x - self.upgradeCardGroupPos.x
end

function AwakerSkillComp:GetUltiSkillPosMoveX()
  if not self.originUltiSkillGroupPos or not self.upgradeUltiSkillGroupPos then
    return 0
  end
  return self.originUltiSkillGroupPos.x - self.upgradeUltiSkillGroupPos.x
end

function AwakerSkillComp:OnUnbind()
  if self.saveAndReload then
    self.saveAndReload:Reload()
  end
end

function AwakerSkillComp:OnOpen()
  if self.awakerModel:HasOwnedSelectAwaker() then
    PlayerDataUtils.OpenFirstTimeTutorial(self.__name, 17852)
  end
end

function AwakerSkillComp:GetOpenAnim()
  self:SetActive(true)
  return "UI_Awaker_Panel_Main_Weapon_Awaker_Close"
end

function AwakerSkillComp:GetCloseAnim()
  self:SetActive(false)
  return "UI_Awaker_Panel_Main_Weapon_Awaker_Open"
end

function AwakerSkillComp:GetEnterDetailAnim()
  return "", nil
end

function AwakerSkillComp:GetExitDetailAnim()
  return "", nil
end

function AwakerSkillComp:OnExitDetail()
  self:ShowNextLevelAttrValue(false)
  self.skillModel:ShowSkillLevelUp(false)
  self.skillModel:SetSelectSlot(0)
  UIManager.Instance:CloseByUrl(Urls.AwakerSkillAffixPanel)
end

return AwakerSkillComp
