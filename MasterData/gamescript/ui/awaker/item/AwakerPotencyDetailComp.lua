local AwakerPage = CommonDefine.AwakerPage
local AwakerPotencyState = CommonDefine.AwakerPotencyState
local AwakerSkillMode = CommonDefine.AwakerSkillMode
local AwakerPotencyEffectType = CommonDefine.AwakerPotencyEffectType
local AwakerPotencyDetailComp, Super = System.NewComponent("AwakerPotencyDetailComp")

function AwakerPotencyDetailComp:ctor(uiNode, model, skillModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Potency_DetailResource(uiNode)
  self.model = model
  self.skillModel = skillModel
end

function AwakerPotencyDetailComp:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.Btn_Activate, function()
    local function OnSuccess()
      AudioManager.Instance:PostSoundEvent("AWAKER_EVOVLE")
      
      UIManager.Instance:Reopen(Urls.ActiveSuccessPanel, LT.Text("Potency_LevelUp_Success"))
      EventMgr.Instance.AwakerShowVoice:Dispatch(AwakerAudioManager.Instance:GetAwakerVoiceId(self.model:GetVoiceTrigger(), self.model.selectAwakerId, self.model.awakerCurSkin))
    end
    
    local awakerTid = self.model.selectAwakerId
    self.model:ReqActivePotency(awakerTid, OnSuccess)
  end, System.fn(self, self._GetBtnActiveState), function()
    do return LT.Text end
    return LT.Text, "AwakerPotencyBtnText"
  end, nil, nil, nil)
  binder:BindToVisible(self.ui.Group_Unique, function()
    return true
  end)
  binder:SetZ1Toggle(self.ui.Btn_Survey, true)
  binder:BindToZ1Toggle(self.ui.Btn_Survey, nil, function(isOn)
    if isOn then
      self.model:SetPotencyMode(AwakerSkillMode.DBG)
    end
  end)
  binder:SetZ1Toggle(self.ui.Btn_Course, false)
  binder:BindToZ1Toggle(self.ui.Btn_Course, nil, function(isOn)
    if isOn then
      Alert.Show(10389)
      self.model:SetPotencyMode(AwakerSkillMode.DBG)
      binder:SetZ1Toggle(self.ui.Btn_Survey, true)
    end
  end)
  binder:BindToVisible(self.ui.Group_Common, function()
    return false
  end)
  binder:BindToText(self.ui.Text_Name_Sec, System.fn(self, self._GetPotencyTypeName))
  binder:BindToText(self.ui.Text_Name, function()
    local potency = self.model.selectPotency
    local mode = self.model.mode
    local name = self.model:GetPotencyName(potency, mode)
    return name
  end)
  binder:BindToVisible(self.ui.Text_Name, System.fn(self, self._ShowPassiveSkillPotencyInfo))
  binder:BindToText(self.ui.Text_Originally, System.fn(self, self._GetCurAttrPotencyActiveNum))
  binder:BindToText(self.ui.Text_Hoist, System.fn(self, self._GetNextAttrPotencyActiveNum))
  binder:BindToVisible(self.ui.Image_Originally, System.fn(self, self._ShowCurAttrPotencyActiveNum))
  binder:BindToVisible(self.ui.Image_Arrow, System.fn(self, self._ShowCurAttrPotencyActiveNum))
  binder:BindToText(self.ui.Text_Foundation, System.fn(self, self._GetAttrPotencyMaxNum))
  binder:BindToVisible(self.ui.Text_Hoist, System.fn(self, self._ShowAttrPotencyInfo))
  binder:BindToVisible(self.ui.Text_C_Lv, System.fn(self, self._ShowNextPotencyLvPrefix))
  binder:BindToVisible(self.ui.Text_Foundation, System.fn(self, self._ShowAttrPotencyInfo))
  binder:BindToTextColor(self.ui.Text_Hoist, System.fn(self, self._GetCurLevelTextColor))
  binder:BindToText(self.ui.Text_Desc, function()
    local awakerTid = self.model.selectAwakerId
    local potency = self.model.selectPotency
    local mode = self.model.mode
    local skillModel = self.skillModel
    local desc = self.model:GetPotencyDesc(awakerTid, potency, mode, skillModel)
    return desc
  end, nil, nil, true)
  binder:BindToText(self.ui.Text_Warning_CN, function()
    if not AwakerDataUtils.HasOwnedAwaker(self.model.selectAwakerId) then
      do return LT.Text end
      return LT.Text, "AwakerNotObtained"
    end
    if self.model.potencyActiveState == AwakerPotencyState.Locked then
      do return LT.Text end
      return LT.Text, "NeedToActivateTheFrontPotency"
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Text_Desc, System.fn(self, self._ShowPassiveSkillPotencyInfo))
  binder:BindToRaw(function(cb, nVal, _)
    if not nVal then
      return
    end
    local numText = ItemDataUtils.GetItemNumText(nVal.needItemNum, nVal.ownNum)
    local itemData = {
      itemTid = nVal.itemTid,
      showText = numText,
      ifShowAppr = true,
      ifShowDesc = true
    }
    cb:BindComponent(ItemPublicArticleCommon(self.ui.UI_Common_Item_Article, itemData))
    cb:BindToVisible(self.ui.UI_Common_Item_Article, function()
      return true
    end)
  end, function()
    local potencyIndex = self.model.selectPotencyIndex
    if 0 == potencyIndex then
      return
    end
    local itemTid = self.model:GetPotencyCostItemId(self.model.selectAwakerId)
    local needItemNum = self.model:GetPotencyCostItemNum(potencyIndex)
    local ownNum = ItemDataUtils.GetItemNum(itemTid)
    local data = {
      itemTid = itemTid,
      needItemNum = needItemNum,
      ownNum = ownNum
    }
    return data
  end)
  binder:BindToVisible(self.ui.Btn_Current, System.fn(self, self._ShowLevelPreviewBtnsAndCost))
  binder:BindToVisible(self.ui.Btn_Lower, System.fn(self, self._ShowLevelPreviewBtnsAndCost))
  binder:BindToVisible(self.ui.Group_Warning, System.fn(self, self._ShowGroupWarning))
  binder:BindToVisible(self.ui.Btn_Activate, System.fn(self, self._ShowBtnActive))
  binder:BindToVisible(self.ui.Group_Article, System.fn(self, self._ShowCostItem))
  binder:BindToVisible(self.ui.Text_Actived, System.fn(self, self._ShowTextActive))
  binder:BindToRaw(function(_, v)
    if not self:_ShowAttrPotencyInfo() then
      self.ui.AddAttrs:SetActive(false)
      self.ui.Group_Mad:SetActive(false)
      self.ui.Group_Lv:SetActive(false)
      self.ui.Image_Adapt:SetActive(false)
      self.ui.Btn_Ranking:SetActive(false)
      self.ui.Group_MaxMad:SetActive(false)
      return
    end
    self.ui.Btn_Ranking:SetActive(true)
    local startIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self.model.selectAwakerId) - 1
    self.ui.Image_Adapt:SetActive(startIndex <= self.model.curActivePotencyIndex)
    self.ui.AddAttrs:SetActive(true)
    self.ui.Group_Mad:SetActive(true)
    self.ui.Group_Lv:SetActive(true)
    self.ui.Group_MaxMad:SetActive(true)
    self:_RefreshPotencyExtraAttr()
  end, function()
    local selectAwakerId = self.model.selectAwakerId
    local selectPotencyIndex = self.model.selectPotencyIndex
    local data = {awakerTid = selectAwakerId, selectPotencyIndex = selectPotencyIndex}
    return data
  end)
  self.ScrollView_Adapt = self.ui.ScrollView_Adapt:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  binder:BindToRaw(function()
    self.ScrollView_Adapt.verticalNormalizedPosition = 1
    local height
    if self:_GetCurPotencyIndex() >= self.model.maxPotencyIndex then
      self.ui.Image_Line:SetActive(false)
      height = 728
    else
      self.ui.Image_Line:SetActive(true)
      height = 484
    end
    CS.Framework.TransformUtil.SetHeight(self.ui.ScrollView_Adapt.transform, height)
  end, function()
    return {
      self.model.selectPotencyIndex,
      self:_GetCurAttrPotencyActiveNum()
    }
  end)
  self:_BindPotencyAddAttrs(binder)
  binder:BindButtonClick(self.ui.Btn_Ranking, System.fn(self, self._OnClickPotencyDetail))
end

function AwakerPotencyDetailComp:_BindPotencyAddAttrs(binder)
  binder:BindToRaw(function(childBinder, data)
    for i = 1, 3 do
      local nodeUI = self.ui["UI_Awaker_Item_Skillup_List" .. i]
      if not nodeUI then
        break
      end
      local currAddAttr = data.showPotencyAddAttrs[i]
      if not currAddAttr then
        nodeUI:SetActive(false)
      else
        nodeUI:SetActive(true)
        local isMax = self:_GetCurPotencyIndex() >= self.model.maxPotencyIndex
        local affixSymbol = currAddAttr.isPercent and "%" or ""
        local _oldValue = "+" .. currAddAttr.count .. affixSymbol
        if isMax then
          _oldValue = ""
        end
        local itemData = {
          nameText = currAddAttr.name,
          oldValue = _oldValue,
          newValue = "+" .. currAddAttr.nextLvCount .. affixSymbol,
          showArrow = not isMax,
          iconPath = DT.ActorAttrType[currAddAttr.tid].Icon
        }
        childBinder:BindComponent(AwakerSkillUpAttrItem(nodeUI, itemData))
      end
    end
    self:_RefreshPotencyExtraAttr()
  end, function()
    local selectAwakerId = self.model.selectAwakerId
    local data = {
      awakerTid = selectAwakerId,
      potencyIndex = self:_GetCurPotencyIndex() + 1,
      showPotencyAddAttrs = self.model.showPotencyAddAttrs
    }
    return data
  end)
end

function AwakerPotencyDetailComp:_GetPromoteAttrList()
  local curSelPotencyIndex = self:_GetCurPotencyIndex()
  local currPotencyData = self.model.totalPotencyList[curSelPotencyIndex]
  local nextPotencyData = self.model.totalPotencyList[curSelPotencyIndex + 1]
  if not currPotencyData or not nextPotencyData then
    return {}
  end
  local currActiveAddAttrs = AwakerDataUtils.GetPotencyAddAttrs(self.model.selectAwakerId, currPotencyData.tid)
  local nextActiveAddAttrs = AwakerDataUtils.GetPotencyAddAttrs(self.model.selectAwakerId, nextPotencyData.tid)
  local showList = {}
  local attrRecordTempMap = {}
  for _, attr in ipairs(currActiveAddAttrs) do
    attrRecordTempMap[attr.tid] = table.clone(attr)
  end
  for _, nextAttr in ipairs(nextActiveAddAttrs) do
    if not attrRecordTempMap[nextAttr.tid] then
      attrRecordTempMap[nextAttr.tid] = table.clone(nextAttr)
      attrRecordTempMap[nextAttr.tid].count = 0
    end
    attrRecordTempMap[nextAttr.tid].nextLvCount = nextAttr.count
  end
  for _, attr in pairs(attrRecordTempMap) do
    table.insert(showList, attr)
  end
  
  local function attrSort(a, b)
    local cfgA = DT.ActorAttrType[a.tid]
    local cfgB = DT.ActorAttrType[b.tid]
    local sortA = cfgA.AttributeSort or 0
    local sortB = cfgB.AttributeSort or 0
    return sortA < sortB
  end
  
  table.sort(showList, attrSort)
  return showList
end

function AwakerPotencyDetailComp:_GetCurPotencyIndex()
  local curActivePotencyIndex = self.model.curActivePotencyIndex
  local startIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self.model.selectAwakerId) - 1
  do return math.max, startIndex end
  return math.max, startIndex, curActivePotencyIndex
end

function AwakerPotencyDetailComp:_RefreshPotencyExtraAttr()
  local curActiveIndex = self:_GetCurPotencyIndex()
  local nextIndex = curActiveIndex + 1
  local colonStr = LangTable.NeedJoinSpaceBetweenDesc() and ":" or "："
  local awakerData = AwakerDataUtils.GetAwakerData(self.model.selectAwakerId)
  local curMaxLevel = AwakerDataUtils.GetAwakerPotencyLevelValue(awakerData, curActiveIndex)
  local nextMaxLevel = AwakerDataUtils.GetAwakerPotencyLevelValue(awakerData, nextIndex)
  local TempVector2 = CS.UnityEngine.Vector2(0, 0)
  local sizeDelta = self.ui.Content.transform.sizeDelta
  TempVector2.x = sizeDelta.x
  TempVector2.y = 596
  if curMaxLevel == nextMaxLevel then
    self.binder:SetText(self.ui.Text_Promote, "")
  else
    self.binder:SetText(self.ui.Text_Promote, "+" .. curMaxLevel)
  end
  self.ui.Image_Level_Arrow:SetActive(curMaxLevel ~= nextMaxLevel)
  self.binder:SetText(self.ui.Text_Base, "+" .. nextMaxLevel)
  self.binder:SetText(self.ui.Text_Lv_Limit, DT.CommonID[CommonDefine.AwakerPotencyEffectType.LevelLimit_Promote].Desc)
  self.binder:SetText(self.ui.Text_Mad_Name, AwakerDataUtils.GetPotencyUtlSkillName(self.model.selectAwakerId))
  local utlSkillStatus = AwakerDataUtils.GetPotencyUtlSkillStatus(self.model.selectAwakerId)
  if curActiveIndex >= utlSkillStatus.index then
    self.ui.Text_C_Unsolved:SetActive(false)
    self.ui.Text_C_WillSolved:SetActive(false)
    self.ui.Text_C_Solved:SetActive(true)
    self.binder:SetTextColorType(self.ui.Text_Mad, CommonDefine.ColorType.Light)
    self.binder:SetTextColorType(self.ui.Text_Mad_Name, CommonDefine.ColorType.Light)
  elseif nextIndex == utlSkillStatus.index then
    self.ui.Text_C_Unsolved:SetActive(false)
    self.ui.Text_C_Solved:SetActive(false)
    self.ui.Text_C_WillSolved:SetActive(true)
    self.binder:SetTextColorType(self.ui.Text_Mad, CommonDefine.ColorType.Dark)
    self.binder:SetTextColorType(self.ui.Text_Mad_Name, CommonDefine.ColorType.Dark)
  else
    self.binder:SetTextColorType(self.ui.Text_Mad, CommonDefine.ColorType.Dark)
    self.binder:SetTextColorType(self.ui.Text_Mad_Name, CommonDefine.ColorType.Dark)
    self.ui.Text_C_WillSolved:SetActive(false)
    self.ui.Text_C_Unsolved:SetActive(true)
    self.ui.Text_C_Solved:SetActive(false)
  end
  if utlSkillStatus.effectType == AwakerPotencyEffectType.ComingSoon then
    self.binder:SetText(self.ui.Text_Mad, LT.Text("PotencyComingSoon"))
  elseif utlSkillStatus.effectType == AwakerPotencyEffectType.UtlSkill_Promote then
    local awakerTid = self.model.selectAwakerId
    local potency = utlSkillStatus.potency
    local mode = self.model.mode
    local skillModel = self.skillModel
    local desc = self.model:GetPotencyDesc(awakerTid, potency, mode, skillModel)
    local showStr = string.format("%s%s%s", LT.Text("OverLimitUtlSkill"), colonStr, desc)
    self.binder:SetText(self.ui.Text_Mad, showStr, nil, nil, {
      lockParentNode = self.ui.Group_MadTipsPos
    })
  end
  local maxPotencyTid = AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self.model.selectAwakerId)
  if maxPotencyTid then
    local awakerTid = self.model.selectAwakerId
    local mode = self.model.mode
    local skillModel = self.skillModel
    local desc = self.model:GetPotencyDesc(awakerTid, maxPotencyTid, mode, skillModel)
    local showStr = string.format("%s%s%s", LT.Text("UltraPotencyKeywords"), colonStr, desc)
    self.binder:SetText(self.ui.Text_MaxMad, showStr, nil, nil, {
      lockParentNode = self.ui.Group_MaxMadTipsPos
    })
    self.binder:SetText(self.ui.Text_MaxMad_Name, LT.Text(AwakerPotencyCfgUtils.GetCfgField("PotencyName", maxPotencyTid)))
    if curActiveIndex >= self.model.maxPotencyIndex then
      self.ui.Text_C_MaxMad_Unsolved:SetActive(false)
      self.ui.Text_C_MaxMad_WillSolved:SetActive(false)
      self.ui.Text_C_MaxMad_Solved:SetActive(true)
      self.binder:SetTextColorType(self.ui.Text_MaxMad, CommonDefine.ColorType.Light)
      self.binder:SetTextColorType(self.ui.Text_MaxMad_Name, CommonDefine.ColorType.Light)
    elseif nextIndex == self.model.maxPotencyIndex then
      self.ui.Text_C_MaxMad_Unsolved:SetActive(false)
      self.ui.Text_C_MaxMad_WillSolved:SetActive(true)
      self.ui.Text_C_MaxMad_Solved:SetActive(false)
      self.binder:SetTextColorType(self.ui.Text_MaxMad, CommonDefine.ColorType.Dark)
      self.binder:SetTextColorType(self.ui.Text_MaxMad_Name, CommonDefine.ColorType.Dark)
    else
      self.ui.Text_C_MaxMad_Unsolved:SetActive(true)
      self.ui.Text_C_MaxMad_WillSolved:SetActive(false)
      self.ui.Text_C_MaxMad_Solved:SetActive(false)
      self.binder:SetTextColorType(self.ui.Text_MaxMad, CommonDefine.ColorType.Dark)
      self.binder:SetTextColorType(self.ui.Text_MaxMad_Name, CommonDefine.ColorType.Dark)
    end
  else
    self.ui.Text_C_MaxMad_Unsolved:SetActive(true)
    self.ui.Text_C_MaxMad_WillSolved:SetActive(false)
    self.ui.Text_C_MaxMad_Solved:SetActive(false)
    self.binder:SetTextColorType(self.ui.Text_MaxMad, CommonDefine.ColorType.Dark)
    self.binder:SetTextColorType(self.ui.Text_MaxMad_Name, CommonDefine.ColorType.Dark)
    self.binder:SetText(self.ui.Text_MaxMad_Name, LT.Text("UltraPotencyLockedName"))
    self.binder:SetText(self.ui.Text_MaxMad, LT.Text("UltraPotencyCommingsoon"))
  end
  self.binder:BindTimer(0.1, 0, nil, function()
    local textHeight = StrUtils.SetPreferredHeight(self.ui.Text_Mad, 30)
    if textHeight > 80 then
      TempVector2.y = 596 + textHeight
    end
    self.ui.Group_Mad.transform.sizeDelta = CS.UnityEngine.Vector2(self.ui.Group_Mad.transform.sizeDelta.x, textHeight + 30)
    self.ui.Content.transform.sizeDelta = TempVector2
  end)
end

function AwakerPotencyDetailComp:_GetPotencyTypeName()
  if 0 == self.model.selectPotency then
    return
  end
  do return self.model.GetPotencyTypeName, self.model end
  return self.model.GetPotencyTypeName, self.model, self.model.selectPotency
end

function AwakerPotencyDetailComp:_ShowCostItem()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  local isMax = self:_GetCurPotencyIndex() >= self.model.maxPotencyIndex
  if isMax then
    return false
  end
  return self.model.potencyActiveState < AwakerPotencyState.Active
end

function AwakerPotencyDetailComp:_ShowGroupWarning()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  local selectAwakerId = self.model.selectAwakerId
  if not AwakerDataUtils.HasOwnedAwaker(selectAwakerId) then
    return true
  end
  if self.model.curActivePotencyIndex >= #self.model.totalPotencyList then
    return false
  end
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(selectAwakerId)
  if attrPotencyStartIndex <= self.model.selectPotencyIndex and self.model.curActivePotencyIndex >= attrPotencyStartIndex - 1 then
    return false
  end
  return self.model.potencyActiveState == AwakerPotencyState.Locked
end

function AwakerPotencyDetailComp:_ShowBtnActive()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  local selectAwakerId = self.model.selectAwakerId
  if 0 == selectAwakerId then
    return false
  end
  if not AwakerDataUtils.HasOwnedAwaker(selectAwakerId) then
    return false
  end
  local maxPassivePotencyNum = self.model:GetAwakerPassivePotencyMaxNum(selectAwakerId)
  if maxPassivePotencyNum >= self.model.selectPotencyIndex then
    return self.model.potencyActiveState == AwakerPotencyState.Unlocked
  end
  local curActivePotencyIndex = self.model.curActivePotencyIndex
  local startIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self.model.selectAwakerId) - 1
  if curActivePotencyIndex < startIndex then
    return false
  end
  return curActivePotencyIndex < #self.model.totalPotencyList
end

function AwakerPotencyDetailComp:_ShowTextActive()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  local selectAwakerId = self.model.selectAwakerId
  if 0 == selectAwakerId then
    return false
  end
  local maxPassivePotencyNum = self.model:GetAwakerPassivePotencyMaxNum(selectAwakerId)
  if maxPassivePotencyNum >= self.model.selectPotencyIndex then
    return self.model.potencyActiveState == AwakerPotencyState.Active
  end
  return self:_GetCurPotencyIndex() >= #self.model.totalPotencyList
end

function AwakerPotencyDetailComp:_ShowPassiveSkillPotencyInfo()
  if 0 == self.model.selectPotency then
    return
  end
  return not self.model.hasSelectAttrPotency
end

function AwakerPotencyDetailComp:_ShowLevelPreviewBtnsAndCost()
  return false
end

function AwakerPotencyDetailComp:_ShowAttrPotencyInfo()
  if 0 == self.model.selectPotency then
    return
  end
  return self.model.hasSelectAttrPotency
end

function AwakerPotencyDetailComp:_ShowNextPotencyLvPrefix()
  if not self:_ShowAttrPotencyInfo() then
    return false
  end
  local isMax = self:_GetCurPotencyIndex() >= self.model.maxPotencyIndex
  if isMax then
    return true
  end
  local selectAwakerId = self.model.selectAwakerId
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(selectAwakerId)
  return self.model.nextActivePotencyIndex == attrPotencyStartIndex
end

function AwakerPotencyDetailComp:_ShowCurAttrPotencyActiveNum()
  if not self:_ShowAttrPotencyInfo() then
    return false
  end
  local selectAwakerId = self.model.selectAwakerId
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(selectAwakerId)
  local isMax = self:_GetCurPotencyIndex() >= self.model.maxPotencyIndex
  return attrPotencyStartIndex <= self:_GetCurPotencyIndex() and not isMax
end

function AwakerPotencyDetailComp:_GetCurLevelTextColor()
  local selectAwakerId = self.model.selectAwakerId
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(selectAwakerId)
  if attrPotencyStartIndex > self.model.curActivePotencyIndex then
    return CommonDefine.ColorType.Normal
  end
  if self.model.selectPotencyIndex == self.model.nextActivePotencyIndex + 1 then
    return CommonDefine.ColorType.Light
  end
  return CommonDefine.ColorType.Normal
end

function AwakerPotencyDetailComp:_GetNextAttrPotencyActiveNum()
  local startAttrPotencyIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self.model.selectAwakerId)
  if startAttrPotencyIndex > self.model.nextActivePotencyIndex then
    return ""
  end
  return self.model.nextActivePotencyIndex - startAttrPotencyIndex + 1
end

function AwakerPotencyDetailComp:_GetCurAttrPotencyActiveNum()
  local activeNum = self.model:GetAwakerAttrPotencyActiveNum(self.model.selectAwakerId)
  if activeNum <= 0 then
    return ""
  end
  return activeNum
end

function AwakerPotencyDetailComp:_GetAttrPotencyMaxNum()
  return "/" .. self.model:GetAwakerAttrPotencyMaxNum(self.model.selectAwakerId)
end

function AwakerPotencyDetailComp:_GetBtnNextState()
  local potencyList = self.model.totalPotencyList
  local targetPotencyIndex = self.model.nextActivePotencyIndex + 1
  if targetPotencyIndex > #potencyList then
    targetPotencyIndex = #potencyList
  end
  if self.model.selectPotencyIndex == targetPotencyIndex then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Normal
end

function AwakerPotencyDetailComp:_GetBtnCurrentState()
  if self.model.selectPotencyIndex == self.model.nextActivePotencyIndex then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Normal
end

function AwakerPotencyDetailComp:_GetBtnActiveState()
  local selectAwakerId = self.model.selectAwakerId
  if 0 == selectAwakerId then
    return CommonDefine.BtnType.Unclickable
  end
  if not AwakerDataUtils.HasOwnedAwaker(selectAwakerId) then
    return CommonDefine.BtnType.Unclickable
  end
  local isMax = self:_GetCurPotencyIndex() >= #self.model.totalPotencyList
  if isMax then
    return CommonDefine.BtnType.Unclickable
  end
  if self.model.potencyActiveState ~= AwakerPotencyState.Unlocked then
    return CommonDefine.BtnType.High
  end
  if self.model.enoughItemToActive then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function AwakerPotencyDetailComp:_OnClickBtnCurrent()
  local page = self.model.awakerModel.page
  if page ~= AwakerPage.Potency and page ~= AwakerPage.PotencyDetail then
    return
  end
  if self:_GetCurPotencyIndex() >= #self.model.totalPotencyList then
    return
  end
  if self.model.selectPotencyIndex == self.model.nextActivePotencyIndex then
    return
  end
  local selectAwakerId = self.model.selectAwakerId
  local nextActivePotencyIndex = self.model.nextActivePotencyIndex
  local list = AwakerDataUtils.GetAwakerPotencyList(selectAwakerId)
  local nextActivePotency = list[nextActivePotencyIndex]
  self.model:SetSelectPotency(nextActivePotency.tid)
  self.model:SetSelectPotencyIndex(nextActivePotencyIndex)
end

function AwakerPotencyDetailComp:_OnClickBtnNext()
  local page = self.model.awakerModel.page
  if page ~= AwakerPage.Potency and page ~= AwakerPage.PotencyDetail then
    return
  end
  if self:_GetCurPotencyIndex() >= #self.model.totalPotencyList then
    return
  end
  local targetIndex = self.model.nextActivePotencyIndex + 1
  if self.model.selectPotencyIndex == targetIndex then
    return
  end
  local selectAwakerId = self.model.selectAwakerId
  local list = AwakerDataUtils.GetAwakerPotencyList(selectAwakerId)
  local targetPotency = list[targetIndex]
  self.model:SetSelectPotency(targetPotency.tid)
  self.model:SetSelectPotencyIndex(targetIndex)
end

function AwakerPotencyDetailComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerPotencyDetailComp:_OnClickPotencyDetail()
  UIManager.Instance:Reopen(Urls.AwakerPotencyDetailView, self.model.selectAwakerId, self.model.mode, self.skillModel)
end

return AwakerPotencyDetailComp
