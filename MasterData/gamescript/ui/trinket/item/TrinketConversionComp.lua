local UIAnimationController = CS.Z1Client.UIAnimationController
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local TrinketConversionComp, Super = System.NewComponent("TrinketConversionComp")

function TrinketConversionComp:ctor(uiNode, strengthenModel, trinketModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_ConversionResource(uiNode)
  self.strengthenModel = strengthenModel
  self.trinketModel = trinketModel
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.isHasConversionData = Vue.ref(false)
  self.trinketConversionCompletRate = 0
  self.isAutoRefinementOn = Vue.ref(false)
  self.isAutoTranscribing = Vue.ref(false)
  self.autoTranscribeCount = Vue.ref(0)
end

function TrinketConversionComp:OnBind(binder)
  self.binder = binder
  self:BindTrinketInfo(binder)
  self:BindEntries(binder)
  self:BindConversionCurrencyCost(binder)
  self:BindMaterialsCost(binder)
  self:BindToggleAutoSupple(binder)
  self:InitLabels(binder)
  self:BindButtons(binder)
  self:BindAutoConversion(binder)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    if self:_IsBlockedByAutoTranscribing() then
      return
    end
    local title = LT.Text("TrinketConversionRuleTitle")
    local content = LT.Text("TrinketConversionRule")
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
  end)
  binder:BindEvent(EventMgr.Instance.TrinketConversionAnim, System.fn(self, self.PlayConversionAnim))
  binder:BindEvent(EventMgr.Instance.TrinketConfirmAnim, System.fn(self, self.PlayConfirmAnim))
  binder:BindEvent(EventMgr.Instance.OnTrinketLevelRefresh, System.fn(self, self._OnTrinketUpdategraded))
  binder:BindToRaw(function()
    if self.strengthenModel:GetStrengthedType() == CommonDefine.TrinketStrengthenTap.Conversion then
      self:FristOpenAnim()
    end
  end, function()
    do return self.strengthenModel.GetStrengthedType end
    return self.strengthenModel.GetStrengthedType, self.strengthenModel
  end)
  binder:BindToRaw(function(_, attrs)
    if self.strengthenModel:GetStrengthedType() ~= CommonDefine.TrinketStrengthenTap.Conversion then
      return
    end
    if #attrs <= 0 then
      return
    end
    local fullCount = 0
    for _, attr in ipairs(attrs) do
      local maxValue = self.trinketModel:GetSubAttrMaxValue(attr.tid)
      local isLocked = self.strengthenModel:IsConversionAttrLocked(attr.uid)
      if maxValue <= attr.count and not isLocked then
        fullCount = fullCount + 1
      end
    end
    if fullCount >= #attrs then
      AudioManager.Instance:PostSoundEvent("Play_Anim_Covenant_Roll_Full_3")
    elseif fullCount > 0 then
      AudioManager.Instance:PostSoundEvent("Play_Anim_Covenant_Roll_Full_1")
    else
      AudioManager.Instance:PostSoundEvent("Play_Anim_Covenant_Roll_Normal")
    end
  end, function()
    do return self.strengthenModel.GetSubConversionAttrsResult end
    return self.strengthenModel.GetSubConversionAttrsResult, self.strengthenModel
  end)
  binder:BindToVisible(self.ui.Btn_Exchange, function()
    local _, exchangeUnlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Exchange, 0)
    return exchangeUnlock and not self.isAutoTranscribing.value
  end)
  binder:BindButtonClick(self.ui.Btn_Exchange, System.fn(self, self._OnClickExchange))
end

function TrinketConversionComp:_OnClickExchange()
  UIManager.Instance:Reopen(Urls.AlchemyExchangeItemBagView, true)
end

function TrinketConversionComp:FristOpenAnim()
  self.uiAnimController:StopPlayableGraph()
  local clipsToPlay = ""
  if self.isHasConversionData.value == true then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Awaker_Popup_Trinket_Conversion2")
  else
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Awaker_Popup_Trinket_Conversion")
  end
  clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Awaker_Popup_Trinket_Conversion_Replace")
  self.uiAnimController:PlayMultiState(clipsToPlay, function()
  end)
end

function TrinketConversionComp:PlayConversionAnim()
  if self.uiAnimController then
    self.uiAnimController:StopPlayableGraph()
    self.uiAnimController:PlayState("UI_Awaker_Popup_Trinket_Conversion2")
  end
  self:_RefreshConversionCompletRate()
end

function TrinketConversionComp:PlayConfirmAnim()
  if self.uiAnimController then
    self.uiAnimController:StopPlayableGraph()
    self.uiAnimController:PlayState("UI_Awaker_Popup_Trinket_Conversion_Replace")
    AudioManager.Instance:PostSoundEvent("Play_UI_Covenant_Btn_Replace_Click")
  end
  self.binder:SetText(self.ui.Text_CompletRate_Cur, string.format("%s<space=0.2em>%s%%", LT.Text("TrinketCompletionRate"), self.trinketConversionCompletRate))
end

function TrinketConversionComp:InitLabels(binder)
  binder:SetText(self.ui.Text_C_Empty, LT.Text("TrinketGetNewEntries"))
  binder:SetText(self.ui.Text_C_Name_1, LT.Text("TrinketConversion"))
  binder:SetText(self.ui.Text_C_Name_2, LT.Text("TrinketConversionReplace"))
  binder:SetText(self.ui.Text_C_No_Entries, LT.Text("TrinketEntriesNone"))
end

function TrinketConversionComp:BindAutoConversion(binder)
  self.isAutoRefinementOn.value = false
  self.isAutoTranscribing.value = false
  self.autoTranscribeCount.value = 0
  binder:BindToRaw(function(_, newType)
    if newType ~= CommonDefine.TrinketStrengthenTap.Conversion then
      self:_StopAutoTranscription(true, true)
      self.isAutoRefinementOn.value = false
      self.autoTranscribeCount.value = 0
      binder:SetToggle(self.ui.Toggle_AutoRefinement, false)
    end
  end, function()
    do return self.strengthenModel.GetStrengthedType end
    return self.strengthenModel.GetStrengthedType, self.strengthenModel
  end)
  binder:BindToToggleIsOn(self.ui.Toggle_AutoRefinement, function()
    return self.isAutoRefinementOn.value
  end)
  binder:BindToToggleValueChange(self.ui.Toggle_AutoRefinement, function(isOn)
    self.isAutoRefinementOn.value = isOn
  end)
  binder:BindButtonClick(self.ui.Btn_AutoRule, function()
    local content = LT.Text("TrinketAutoRefine")
    UIManager.Instance:Reopen(Urls.CommonillustrateView, nil, content)
  end)
  binder:BindButtonClick(self.ui.Btn_Skip, function()
    self:_OnClickSkip()
  end)
  binder:BindToVisible(self.ui.Group_AutoAnim, function()
    return self.isAutoTranscribing.value
  end)
  binder:BindToVisible(self.ui.Group_Refinement, function()
    return not self.isAutoTranscribing.value
  end)
  binder:BindToVisible(self.ui.Content_MatNeed, function()
    return not self.isAutoTranscribing.value
  end)
  binder:BindToText(self.ui.Text_AutoRefinementTip, function()
    do return LT.Textf, "TrinketAutoRefineProgress" end
    return LT.Textf, "TrinketAutoRefineProgress", self.autoTranscribeCount.value
  end)
end

function TrinketConversionComp:BindButtons(binder)
  binder:BindButtonClick(self.ui.Btn_Refinement, function()
    if self.isAutoRefinementOn.value then
      self:_StartAutoTranscription()
    else
      self.strengthenModel:ReqTrinketConversion(function()
      end)
    end
  end, function()
    if self.strengthenModel:IsTrinketConversionMoneyEnough() and (self.strengthenModel:IsTrinketConversionMatEnough() or self.strengthenModel:IsTrinketConversionLockMatEnough()) then
      return CommonDefine.Z1ButtonState.High
    end
    if self.strengthenModel:IsShowAutoSupply() and self.strengthenModel:IsTrinketConversionMoneyEnough() and self.strengthenModel:IsAutoSupply() then
      return CommonDefine.Z1ButtonState.High
    end
    return CommonDefine.Z1ButtonState.Unclickable
  end)
  binder:BindButtonClick(self.ui.Btn_Replacement, function()
    self.strengthenModel:ReqTrinketConfirmTraining(function()
    end)
  end)
  binder:BindToVisible(self.ui.Btn_Replacement, function()
    return self.isHasConversionData.value == true and not self.isAutoTranscribing.value
  end)
  binder:BindToVisible(self.ui.Text_C_Empty, function()
    return self.isHasConversionData.value == false
  end)
  binder:BindToVisible(self.ui.Text_C_No_Entries, function()
    local subAttrs = self.trinketModel:GetSubAttrs(self.strengthenModel.trinketUid)
    return 0 == #subAttrs
  end)
end

function TrinketConversionComp:BindTrinketInfo(binder)
  binder:BindToRaw(function(_, isHasData)
    self.isHasConversionData.value = isHasData
  end, function()
    do return self.strengthenModel.IsExistedSubConversionAttrs end
    return self.strengthenModel.IsExistedSubConversionAttrs, self.strengthenModel
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    do return self.strengthenModel.GetTrinketIcon end
    return self.strengthenModel.GetTrinketIcon, self.strengthenModel
  end)
  local iconLightComp = UICompTrinketIconMat(self.ui.Image_Icon, {binder = binder})
  binder:BindToRaw(function(_, hasBound, _)
    local partIndex = AwakerTrinketDataUtils.GetTrinketLightPartIndex(self.strengthenModel.trinketTid)
    iconLightComp:EnableLight(true == hasBound, partIndex)
  end, function()
    do return AwakerTrinketDataUtils.IsTrinketBoundForLight end
    return AwakerTrinketDataUtils.IsTrinketBoundForLight, self.strengthenModel.trinketUid
  end)
  self._iconLightComp = iconLightComp
  local position = AwakerTrinketDataUtils.GetConversionTrinketIconPosTable(self.strengthenModel.trinketTid)
  self.ui.Image_Icon.transform.anchoredPosition = CS.UnityEngine.Vector2(position[1], position[2])
end

function TrinketConversionComp:BindEntries(binder)
  self:BindFoundationEntries(binder)
  self:BindConversionEntries(binder)
end

function TrinketConversionComp:BindFoundationEntries(binder)
  local transform = self.ui.Content_Foundation.transform
  for i = 1, transform.childCount do
    local go = transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    binder:BindComponent(TrinketConversionEntry(go, i, self.strengthenModel, self.trinketModel, false, System.fn(self, self._IsBlockedByAutoTranscribing)))
  end
  local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.strengthenModel.trinketUid)
  self.binder:SetText(self.ui.Text_CompletRate_Cur, string.format("%s<space=0.2em>%s%%", LT.Text("TrinketCompletionRate"), completRate))
end

function TrinketConversionComp:_RefreshTrinketCompletRate()
  local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.strengthenModel.trinketUid)
  self.binder:SetText(self.ui.Text_CompletRate_Cur, string.format("%s<space=0.2em>%s%%", LT.Text("TrinketCompletionRate"), completRate))
end

function TrinketConversionComp:BindConversionEntries(binder)
  local transform = self.ui.Content_Hoist.transform
  for i = 1, transform.childCount do
    local go = transform:GetChild(i - 1).gameObject
    binder:BindComponent(TrinketConversionEntry(go, i, self.strengthenModel, self.trinketModel, true))
  end
  self:_RefreshConversionCompletRate()
end

function TrinketConversionComp:_RefreshConversionCompletRate()
  local subAttrsResult = self.strengthenModel:GetSubConversionAttrsResult()
  local subAttrs = {}
  local index = 1
  for _, attr in ipairs(subAttrsResult) do
    local addAttrs = {}
    addAttrs.index = index + 1
    addAttrs.valIndex = attr.valIndex
    addAttrs.val = attr.count
    addAttrs.attrId = attr.tid
    table.insert(subAttrs, addAttrs)
  end
  local completRate = AwakerTrinketDataUtils.GetTrinketPreviewCompletionRate(self.strengthenModel.trinketUid, nil, subAttrs)
  self.binder:SetText(self.ui.Text_CompletRate_New, string.format("%s<space=0.2em>%s%%", LT.Text("TrinketCompletionRate"), completRate))
  self.trinketConversionCompletRate = completRate
end

function TrinketConversionComp:_OnTrinketUpdategraded()
  self:_RefreshTrinketCompletRate()
  self:_RefreshConversionCompletRate()
end

function TrinketConversionComp:BindConversionCurrencyCost(binder)
  local currencyItemId = self.strengthenModel:GetConversionCurrencyType()
  local com = binder:BindComponent(CommonCoinCostCom(self.ui.UI_Common_Group_Coin))
  com:UpdateItem(currencyItemId)
  com:UpdateOriValue("")
  binder:BindToRaw(function(_, need, _)
    local own = need.ownedMoney
    com:NowColorNormal(own >= need.num)
    com:UpdateNow(need.num)
    com:UpdateOriValue("")
  end, function()
    return self.strengthenModel.trinketConversionMoneyCostTable
  end)
end

function TrinketConversionComp:BindToggleAutoSupple(binder)
  local supplyItemId = DT.GetConstant("TrinketRefineCostLock1Substitute")
  local supplyItemName = ""
  if supplyItemId then
    supplyItemName = ItemDataUtils.GetItemName(supplyItemId)
  end
  self.binder:SetText(self.ui.Text_Toggle, LT.Textf("TrinketConversionLockOneOption", supplyItemName))
  self.binder:BindToToggleIsOn(self.ui.Toggle_Screening, function()
    do return self.strengthenModel.IsAutoSupply end
    return self.strengthenModel.IsAutoSupply, self.strengthenModel
  end)
  self.binder:BindToToggleValueChange(self.ui.Toggle_Screening, function(isOn)
    if isOn and self.ui.Toggle_Screening.activeInHierarchy then
      Alert.ShowWithParams(20132, {supplyItemName}, function()
        ClientDataUtils.SetData(cd.ClientDataMainKey.Toggle, cd.ClientSubKey.TrinketTrain, 0)
        self.binder:SetToggle(self.ui.Toggle_Screening, false)
      end)
    end
    ClientDataUtils.SetData(cd.ClientDataMainKey.Toggle, cd.ClientSubKey.TrinketTrain, isOn and 1 or 0)
  end)
  self.binder:BindToRaw(function(_, isShow)
    self.binder:SetActive(self.ui.Toggle_Screening, isShow and not self.isAutoTranscribing.value)
    self.binder:SetToggle(self.ui.Toggle_Screening, self.strengthenModel:IsAutoSupply())
  end, function()
    do return self.strengthenModel.IsShowAutoSupply end
    return self.strengthenModel.IsShowAutoSupply, self.strengthenModel
  end)
  self.binder:BindToVisible(self.ui.Toggle_Screening, function()
    return self.strengthenModel:IsShowAutoSupply() and not self.isAutoTranscribing.value
  end)
end

function TrinketConversionComp:BindMaterialsCost(binder)
  local matItemBinders = {}
  
  local function GetItemNumStr(matData)
    local ownedNum = ItemDataUtils.GetItemNum(matData.tid)
    if ownedNum < matData.num then
      do return string.format, "<color=%s>%d</color>/%d", DT.ColorConfig.Red.Light, ownedNum end
      return string.format, "<color=%s>%d</color>/%d", DT.ColorConfig.Red.Light, ownedNum, matData.num
    end
    return ownedNum .. "/" .. matData.num
  end
  
  local function RefreshItems()
    local matCost = self.strengthenModel.trinketConversionMatCost
    local matNum = #matCost
    for i, childBinder in pairs(matItemBinders) do
      if not childBinder:isDestroyed() then
        childBinder:teardown()
      end
      matItemBinders[i] = nil
    end
    local transform = self.ui.Content_MatNeed.transform
    local cnt = self:ReserveChildren(transform, matNum)
    local commonIconItemModel = binder:createModel(CommonIconItemModel)
    for i = 1, matNum do
      local go = transform:GetChild(i - 1).gameObject
      go:SetActive(true)
      local numStr = GetItemNumStr(matCost[i])
      local itemData = {
        tid = matCost[i].tid,
        num = numStr,
        model = commonIconItemModel,
        strengthenModel = self.strengthenModel
      }
      local comp = TrinketUpgradeUsingMatComp(go, itemData)
      local compBinder = binder:createChild(comp)
      comp:Setup(compBinder)
      compBinder:onDestroy(function()
        if comp.ui then
          comp.ui = nil
        end
        if compBinder.OnDispose then
          compBinder:OnDispose()
        end
      end)
      matItemBinders[i] = compBinder
    end
    for i = matNum + 1, cnt do
      local go = transform:GetChild(i - 1).gameObject
      go:SetActive(false)
    end
  end
  
  binder:BindEvent(EventMgr.Instance.UpdateBagEvent, function(items)
    local matCost = self.strengthenModel.trinketConversionMatCost
    local needRefresh = nil == items
    if not needRefresh then
      for _, v in pairs(items) do
        for i = 1, #matCost do
          if matCost[i].tid == v.tid then
            needRefresh = true
            break
          end
        end
        if needRefresh then
          break
        end
      end
    end
    if not needRefresh then
      return
    end
    RefreshItems()
  end)
  binder:BindToRaw(function(childBinder, matCost, _)
    childBinder:BindToRaw(function()
      RefreshItems()
    end, function()
      do return self.strengthenModel.IsAutoSupply end
      return self.strengthenModel.IsAutoSupply, self.strengthenModel
    end)
  end, function()
    do return self.strengthenModel.GetCurTrinketRefineLockNum end
    return self.strengthenModel.GetCurTrinketRefineLockNum, self.strengthenModel
  end)
end

function TrinketConversionComp:ReserveChildren(transform, num)
  local ct_transform = transform
  local cnt = ct_transform.childCount
  while num > cnt do
    CS.UnityEngine.GameObject.Instantiate(ct_transform:GetChild(0).gameObject, ct_transform)
    cnt = cnt + 1
  end
  return cnt
end

function TrinketConversionComp:OnUnbind()
  self:_StopAutoTranscription(true, true)
  if not IsNil(self.uiAnimController) then
    self.uiAnimController:StopPlayableGraph()
    self.uiAnimController = nil
  end
  if self._iconLightComp then
    self._iconLightComp:OnExitComponent()
    self._iconLightComp = nil
  end
  Super.OnUnbind(self)
end

function TrinketConversionComp:IsAutoTranscribing()
  return self.isAutoTranscribing.value == true
end

function TrinketConversionComp:_IsBlockedByAutoTranscribing()
  if self.isAutoTranscribing.value then
    Alert.Show("TrinketAutoRefineExitTips")
    return true
  end
  return false
end

function TrinketConversionComp:_StartAutoTranscription()
  if self.isAutoTranscribing.value then
    return
  end
  local maxTimes = self.strengthenModel:GetAutoTrainMaxTimes()
  if maxTimes < 1 then
    Alert.Show(10707)
    return
  end
  local tipsTypeCfg = TipsTypeCfgUtils.GetCfg("TrinketAutoRefineTips")
  local viewData = {
    title = LT.Text(tipsTypeCfg and tipsTypeCfg.Title or ""),
    topDesc = LT.Textf(tipsTypeCfg and tipsTypeCfg.Desc or "", maxTimes),
    bottomDesc = LT.Textf(tipsTypeCfg and tipsTypeCfg.BottomDesc or ""),
    rewardInfoList = self:_GetAutoTranscriptionCostList(maxTimes),
    confirmFunc = function()
      self.isAutoTranscribing.value = true
      self.autoTranscribeCount.value = 0
      self._skipRequested = false
      self.binder:SetToggleInteractable(self.ui.Toggle_AutoRefinement, false)
      self:_SendAutoTranscription(maxTimes)
    end
  }
  UIManager.Instance:Reopen(Urls.BuyConfirmPreviewView, viewData)
end

function TrinketConversionComp:_GetAutoTranscriptionOriginalMatCost(maxTimes)
  local costMap = {}
  
  local function addCost(tid, num)
    if tid and num > 0 then
      costMap[tid] = (costMap[tid] or 0) + num
    end
  end
  
  local model = self.strengthenModel
  local pools = model:GetAutoRefineMaterialPools()
  local params = model:GetAutoRefineCostParams()
  local lockedNum = model:GetCurTrinketRefineLockNum()
  local remainChipSuit = pools.chipSuit
  local remainFeather = pools.feather
  local sealNeed = params.sealPerRun * maxTimes
  local directNum = math.min(pools.seal, sealNeed)
  addCost(pools.sealTid, directNum)
  local lackNum = sealNeed - directNum
  if lackNum > 0 then
    local exchangeCostMap, remain = self:_ConvertSealLackToExchangeMats(lackNum, pools)
    for tid, num in pairs(exchangeCostMap) do
      addCost(tid, num)
    end
    lackNum = remain
  end
  if lackNum > 0 and pools.chipSuitSwap > 0 and remainChipSuit > 0 then
    local costCount = math.min(remainChipSuit, math.ceil(lackNum / params.chipSeal))
    addCost(pools.chipSuitTid, costCount)
    remainChipSuit = remainChipSuit - costCount
    lackNum = lackNum - costCount * params.chipSeal
  end
  if lackNum > 0 and pools.featherSwap > 0 and remainFeather > 0 then
    local costCount = math.min(remainFeather, math.ceil(lackNum / params.featherSeal))
    addCost(pools.featherTid, costCount)
    remainFeather = remainFeather - costCount
    lackNum = lackNum - costCount * params.featherSeal
  end
  if lackNum > 0 then
    addCost(pools.sealTid, lackNum)
  end
  if 1 == lockedNum then
    local chipNeed = params.lockChipPerRun * maxTimes
    local chipUse = math.min(remainChipSuit, chipNeed)
    addCost(pools.chipSuitTid, chipUse)
    remainChipSuit = remainChipSuit - chipUse
    if model:IsAutoSupply() then
      local featherUse = math.min(remainFeather, math.ceil((chipNeed - chipUse) / params.lockChipPerRun))
      addCost(pools.featherTid, featherUse)
      remainFeather = remainFeather - featherUse
    end
  elseif lockedNum >= 2 then
    local featherUse = math.min(remainFeather, params.lockFeatherPerRun * maxTimes)
    addCost(pools.featherTid, featherUse)
    remainFeather = remainFeather - featherUse
  end
  local matList = {}
  for tid, num in pairs(costMap) do
    table.insert(matList, {tid = tid, num = num})
  end
  return matList
end

function TrinketConversionComp:_ConvertSealLackToExchangeMats(lackNum, pools)
  local costMap = {}
  local chipSeal = DT.GetConstant("TrinketAutoRefineExchangeChipSeal") or 1
  local remain = lackNum
  for _, chip in ipairs(pools.chipOtherList) do
    if remain <= 0 then
      break
    end
    if chip.num > 0 then
      local costCount = math.min(chip.num, math.ceil(remain / chipSeal))
      costMap[chip.tid] = (costMap[chip.tid] or 0) + costCount
      remain = remain - costCount * chipSeal
    end
  end
  return costMap, remain
end

function TrinketConversionComp:_GetAutoTranscriptionCostList(maxTimes)
  local costList = {}
  local currencyTid = self.strengthenModel:GetConversionCurrencyType()
  local moneyCostPerTime = self.strengthenModel.trinketConversionMoneyCost
  if currencyTid and moneyCostPerTime > 0 then
    table.insert(costList, {
      tid = currencyTid,
      num = moneyCostPerTime * maxTimes
    })
  end
  for _, mat in ipairs(self:_GetAutoTranscriptionOriginalMatCost(maxTimes)) do
    table.insert(costList, mat)
  end
  table.sort(costList, ItemDataUtils.CommonItemSortFunc)
  return costList
end

function TrinketConversionComp:_GetAutoTranscriptionCostStr(maxTimes)
  local parts = {}
  local currencyTid = self.strengthenModel:GetConversionCurrencyType()
  local moneyCostPerTime = self.strengthenModel.trinketConversionMoneyCost
  if currencyTid and moneyCostPerTime > 0 then
    table.insert(parts, ItemNumUtils.GetStr(currencyTid, moneyCostPerTime * maxTimes))
  end
  for _, mat in ipairs(self:_GetAutoTranscriptionOriginalMatCost(maxTimes)) do
    table.insert(parts, ItemNumUtils.GetStr(mat.tid, mat.num))
  end
  do return table.concat, parts end
  return table.concat, parts, " ", ipairs(self:_GetAutoTranscriptionOriginalMatCost(maxTimes))
end

function TrinketConversionComp:_SendAutoTranscription(maxTimes)
  self._autoClientMaxTimes = maxTimes
  local chooseList = self:_BuildAutoExchangeChooseList()
  self.strengthenModel:ReqAutoTrinketConversion(maxTimes, chooseList, function(svrData)
    self:_OnAutoTranscriptionResult(svrData)
  end)
end

function TrinketConversionComp:_BuildAutoExchangeChooseList()
  local chooseList = {}
  local exchangePlan = AlchemyExchangeExtModel.Instance:GetExchangePlan()
  for tid in pairs(exchangePlan or {}) do
    chooseList[tid] = ItemDataUtils.GetItemNum(tid)
  end
  return chooseList
end

function TrinketConversionComp:_OnAutoTranscriptionResult(svrData)
  if nil == svrData then
    self._autoResults = nil
    self:_StopAutoTranscription(false, false)
    return
  end
  self._autoResults = svrData
  self._autoResultIndex = 0
  if self._skipRequested then
    self:_FastForwardAutoResults()
    return
  end
  self:_PlayNextAutoResult()
end

function TrinketConversionComp:_PlayNextAutoResult()
  if not self.isAutoTranscribing.value then
    return
  end
  self._autoTimerId = nil
  local svrData = self._autoResults
  local total = svrData.times or 0
  local attrList = svrData.attrList
  local idx = self._autoResultIndex + 1
  if not (not (total < idx) and attrList) or not attrList[idx] then
    self:_StopAutoTranscription(true, false)
    return
  end
  self._autoResultIndex = idx
  self.strengthenModel:SetSubConversionAttrs(attrList[idx])
  EventMgr.Instance.TrinketConversionAnim:Dispatch()
  self.autoTranscribeCount.value = idx
  self:_RefreshConversionCompletRate()
  self._autoTimerId = TimerManager.Instance:CreateTimer(1, 0, nil, function()
    self:_PlayNextAutoResult()
  end)
end

function TrinketConversionComp:_FastForwardAutoResults()
  local svrData = self._autoResults
  if svrData then
    local total = svrData.times or 0
    local attrList = svrData.attrList
    if total > 0 and attrList and attrList[total] then
      self.strengthenModel:SetSubConversionAttrs(attrList[total])
      EventMgr.Instance.TrinketConversionAnim:Dispatch()
    end
    self.autoTranscribeCount.value = total
    self:_RefreshConversionCompletRate()
  end
  self:_StopAutoTranscription(true, true)
end

function TrinketConversionComp:_IsConversionCostEnough()
  if not self.strengthenModel:IsTrinketConversionMoneyEnough() then
    return false
  end
  return self.strengthenModel:IsTrinketConversionMatEnough() or self.strengthenModel:IsTrinketConversionLockMatEnough()
end

function TrinketConversionComp:_GetTargetConversionAttr()
  local conversionAttrs = self.strengthenModel:GetSubConversionAttrs()
  if conversionAttrs then
    local giveUpLevel = self.strengthenModel:GetTrinketConversionConfirmGiveUpLevel()
    local slotList = {}
    for slot in pairs(conversionAttrs) do
      table.insert(slotList, slot)
    end
    table.sort(slotList)
    for _, slot in ipairs(slotList) do
      local v = conversionAttrs[slot]
      if giveUpLevel <= math.ceil(v.valIndex / 2) then
        return v
      end
    end
  end
  return nil
end

function TrinketConversionComp:_ShowAutoStopTip(forcedEnd)
  local stopReason = self._autoResults and self._autoResults.stopReason or nil
  local targetAttr = self:_GetTargetConversionAttr()
  if targetAttr or "ReachedTarget" == stopReason then
    local title = LT.Textf("TrinketAutoRefineStopByGetTargetAttr", self.autoTranscribeCount.value)
    UIManager.Instance:Reopen(Urls.TrinketAutoRefineSuccessView, title)
    return
  end
  if "MaxTimes" == stopReason then
    local cfgCap = DT.GetConstant("TrinketAutoRefineMaxNum") or 100
    if cfgCap > (self._autoClientMaxTimes or 0) then
      Alert.ShowStr(LT.Textf("TrinketAutoRefineStopByMaterialNotEnough", self.autoTranscribeCount.value))
    else
      Alert.ShowStr(LT.Text("TrinketAutoRefineStopByMaxTimeLimit"))
    end
    return
  end
  local costEnough = self:_IsConversionCostEnough()
  if not costEnough then
    Alert.ShowStr(LT.Textf("TrinketAutoRefineStopByMaterialNotEnough", self.autoTranscribeCount.value))
    return
  end
  if forcedEnd then
    return
  end
  Alert.ShowStr(LT.Text("TrinketAutoRefineStopByMaxTimeLimit"))
end

function TrinketConversionComp:_StopAutoTranscription(showTip, forcedEnd)
  if not self.isAutoTranscribing.value then
    return
  end
  self.isAutoTranscribing.value = false
  self.binder:SetToggleInteractable(self.ui.Toggle_AutoRefinement, true)
  if self._autoTimerId then
    TimerManager.Instance:StopTimer(self._autoTimerId)
    self._autoTimerId = nil
  end
  if self._autoResults and self._autoResults.attrs then
    self.strengthenModel:SetSubConversionAttrs(self._autoResults.attrs)
  end
  if showTip then
    self:_ShowAutoStopTip(forcedEnd)
  end
end

function TrinketConversionComp:_OnClickSkip()
  if not self.isAutoTranscribing.value then
    return
  end
  self._skipRequested = true
  if self._autoTimerId then
    TimerManager.Instance:StopTimer(self._autoTimerId)
    self._autoTimerId = nil
  end
  if self._autoResults then
    self:_FastForwardAutoResults()
  end
end

return TrinketConversionComp
