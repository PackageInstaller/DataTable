local Special_Show_Potency_Factor = 4
local AwakerPotencyDetailView, Super = NewClass("AwakerPotencyDetailView", BaseView)
AwakerPotencyDetailView.uiResCls = UI_Awaker_Popup_Topped_Tip3Resource

function AwakerPotencyDetailView:ctor(awakerTid, awakerSkillMode, skillModel)
  Super.ctor(self)
  self.awakerSkillMode = awakerSkillMode
  self.awakerTid = awakerTid
  self.skillModel = skillModel
end

function AwakerPotencyDetailView:OnBuildView()
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.L,
    clickFunc = function()
      self:Close()
    end,
    textTitleCN = LT.Text("PotencyPopupTitle")
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_L, CompPublicPopupTips, commonPopupConfirmTipsData)
end

function AwakerPotencyDetailView:RegisterNotifications()
end

function AwakerPotencyDetailView:RegisterEvents()
  self.potencyIndexView = self:CreateTableview(self.ui.ScrollView_Item, function()
    return self.attrPotencyMaxIndex
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Awaker_Popup_Topped_Tip3_Item)
    self:_FillPotencyCell(cell, index)
    return cell
  end, function()
    return 220, 190
  end)
  
  function self.potencyIndexView.reloadFinishCallback()
    self.potencyIndexView:MoveCellToCenter(self.curSelPotencyIndex - self.attrPotencyStartIndex)
  end
  
  self:AddButtonClickListener(self.ui.Image_Mad_Icon, System.fn(self, self._OnClickBtnMad))
  self:AddButtonClickListener(self.ui.Image_MaxMad_Icon, System.fn(self, self._OnClickBtnMaxMad))
end

function AwakerPotencyDetailView:_OnClickBtnMad()
  local tipsData = {
    title = LT.Text("SuperUltlSkillName"),
    desc = LT.Text(WordsEffectCfgUtils.GetLinkStateDesc("OverLimitUtlSkillKeywords"))
  }
  Alert.ShowToolTipsByData(tipsData, self.ui.Mad_Tips_Node)
end

function AwakerPotencyDetailView:_OnClickBtnMaxMad()
  local tipsData = {
    title = LT.Text("UltraPotencyLockedName"),
    desc = LT.Text("UltraPotencyDesc")
  }
  Alert.ShowToolTipsByData(tipsData, self.ui.MaxMad_Tips_Node)
end

function AwakerPotencyDetailView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_Mad_Lock, LT.Textf("PotencyUnlockFormat", 4))
  self:SetText(self.ui.Text_MaxMad_Lock, LT.Textf("PotencyUnlockFormat", 12))
  self:_CalPotencyData()
  self:_RefreshCurPotency()
  self.potencyIndexView:ReloadData()
end

function AwakerPotencyDetailView:_CalPotencyData()
  self.totalPotencyList = AwakerDataUtils.GetAwakerPotencyList(self.awakerTid)
  local awaker = AwakerDataUtils.GetAwakerData(self.awakerTid)
  self.attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self.awakerTid)
  self.attrPotencyMaxIndex = AwakerDataUtils.GetAwakerAttrPotencyMaxNum(self.awakerTid)
  self.curActivePotency = AwakerDataUtils.GetAwakerPotencyIndex(self.awakerTid, awaker.potency)
  self.curSelPotencyIndex = math.max(math.min(self.curActivePotency + 1, self:_GetMaxPotencyIndex()), self.attrPotencyStartIndex)
end

function AwakerPotencyDetailView:_GetMaxPotencyIndex()
  return self.attrPotencyStartIndex + self.attrPotencyMaxIndex - 1
end

function AwakerPotencyDetailView:_FillPotencyCell(cell, index)
  local actualIndex = self.attrPotencyStartIndex + index - 1
  local uiRes = UI_Awaker_Popup_Topped_Tip3_ItemResource(cell.gameObject)
  self:SetText(uiRes.Text_Lv, index)
  self:AddButtonClickListener(uiRes.Button, function()
    self.curSelPotencyIndex = actualIndex
    self.potencyIndexView:Refresh()
    self:_RefreshCurPotency()
  end)
  if actualIndex <= self.curActivePotency then
    uiRes.Group_Nor:SetActive(true)
    uiRes.Group_Dis:SetActive(false)
    self:SetTextColorByHtml(uiRes.Text_Lv, "#FFFFFF")
  else
    uiRes.Group_Nor:SetActive(false)
    uiRes.Group_Dis:SetActive(true)
    self:SetTextColorByHtml(uiRes.Text_Lv, "#b5b5b5")
  end
  local maxPotencyTid = AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self.awakerTid)
  local isMax = index >= self.attrPotencyMaxIndex
  local maxPotencyActived = isMax and maxPotencyTid
  uiRes.Image_Max:SetActive(maxPotencyActived)
  uiRes.Text_Lv:SetActive(not maxPotencyActived or actualIndex > self.curActivePotency)
  uiRes.Image_Special_Ash:SetActive(0 == index % Special_Show_Potency_Factor)
  uiRes.Image_Special:SetActive(AwakerDataUtils.ExistsPotencyExtraAttrs(self.awakerTid, actualIndex) and not maxPotencyActived)
  uiRes.Group_Sel:SetActive(self.curSelPotencyIndex == actualIndex)
end

function AwakerPotencyDetailView:_RefreshCurPotency()
  self:_RefreshAttr()
  self:_RefreshPotencyExtraAttr()
  local isActived = self.curActivePotency >= 7
  self.ui.Image_Activation:SetActive(isActived)
  self.ui.Image_Not_Activation:SetActive(not isActived)
  local maxPotencyTid = AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self.awakerTid)
  if not maxPotencyTid then
    self:SetText(self.ui.Text_Not_Complete, LT.Text("UltraPotencyCommingsoon"))
    self:SetActive(self.ui.Text_Not_Complete, true)
    self:SetActive(self.ui.ScrollView_MaxMadDesc, false)
    self:SetActive(self.ui.MaxMad_RewardReceived, false)
    return
  end
  self:SetActive(self.ui.Text_Not_Complete, false)
  self:SetActive(self.ui.ScrollView_MaxMadDesc, true)
  self:SetActive(self.ui.MaxMad_RewardReceived, true)
  local desc = AwakerDataUtils.GetPotencyDesc(self.awakerTid, maxPotencyTid, self.awakerSkillMode, self.skillModel)
  local showStr = string.format("「%s」：%s", LT.Text(AwakerPotencyCfgUtils.GetCfgField("PotencyName", maxPotencyTid)), desc)
  self:SetText(self.ui.Text_MaxMad, showStr, nil, nil, true)
  local isMax = self.curActivePotency >= 15
  local maxPotencyActived = isMax and maxPotencyTid
  self.ui.MaxMad_Image_Activation:SetActive(maxPotencyActived)
  self.ui.MaxMad_Image_Not_Activation:SetActive(not maxPotencyActived)
end

function AwakerPotencyDetailView:_RefreshAttr()
  local showList = self:_GetPromoteAttrList()
  for i = 1, #showList do
    local obj = self.ui["Image_Attributes_" .. i]
    if not obj then
      break
    end
    local currAddAttr = showList[i]
    local affixSymbol = currAddAttr.isPercent and "%" or ""
    local oldValue = "+" .. currAddAttr.count .. affixSymbol
    local iconGo = self:FindChild(obj, "Image_Line/Image_Icon")
    local attrNameGo = self:FindChild(obj, "Image_Line/Text_Attributes")
    local valueGo = self:FindChild(obj, "Image_Line/Text_Value")
    local nextValueGo = self:FindChild(obj, "Image_Line/Text_Value_Add")
    self:SetText(attrNameGo, currAddAttr.name)
    self:SetText(valueGo, oldValue)
    self:SetText(nextValueGo, "+" .. currAddAttr.nextLvCount .. affixSymbol)
    self:SetImage(iconGo, DT.ActorAttrType[currAddAttr.tid].Icon)
  end
end

function AwakerPotencyDetailView:_RefreshPotencyExtraAttr()
  local currPotencyData = self.totalPotencyList[self.curSelPotencyIndex]
  if not currPotencyData then
    return
  end
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerTid)
  local curMaxLevel = AwakerDataUtils.GetAwakerPotencyLevelValue(awakerData, self.curSelPotencyIndex - 1)
  local nextMaxLevel = AwakerDataUtils.GetAwakerPotencyLevelValue(awakerData, self.curSelPotencyIndex)
  if curMaxLevel == nextMaxLevel then
    self:SetText(self.ui.Text_Promote, "")
    self.ui.Image_Level_Arrow:SetActive(false)
  else
    self:SetText(self.ui.Text_Promote, "+" .. curMaxLevel)
    self.ui.Image_Level_Arrow:SetActive(true)
  end
  self:SetText(self.ui.Text_Base, "+" .. nextMaxLevel)
  self:SetText(self.ui.Text_Lv_Name, DT.CommonID[CommonDefine.AwakerPotencyEffectType.LevelLimit_Promote].Desc)
  local utlSkillStatus = AwakerDataUtils.GetPotencyUtlSkillStatus(self.awakerTid)
  if utlSkillStatus.effectType == CommonDefine.AwakerPotencyEffectType.ComingSoon then
    self:SetText(self.ui.Text_Mad, LT.Text("PotencyComingSoon"))
  else
    local potency = utlSkillStatus.potency
    local desc = AwakerDataUtils.GetPotencyDesc(self.awakerTid, potency, self.awakerSkillMode, self.skillModel)
    local showStr = string.format("「%s」：%s", LT.Text(AwakerPotencyCfgUtils.GetCfgField("PotencyName", potency)), desc)
    self:SetText(self.ui.Text_Mad, showStr, nil, nil, true)
  end
end

function AwakerPotencyDetailView:_GetPromoteAttrList()
  local currPotencyData = self.totalPotencyList[math.max(1, self.curSelPotencyIndex - 1)]
  local nextPotencyData = self.totalPotencyList[self.curSelPotencyIndex]
  if not currPotencyData or not nextPotencyData then
    return {}
  end
  local currActiveAddAttrs = AwakerDataUtils.GetPotencyAddAttrs(self.awakerTid, currPotencyData.tid)
  local nextActiveAddAttrs = AwakerDataUtils.GetPotencyAddAttrs(self.awakerTid, nextPotencyData.tid)
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

return AwakerPotencyDetailView
