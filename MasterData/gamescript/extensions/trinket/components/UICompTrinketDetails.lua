local UICompTrinketDetails, Super = NewViewComponent("UICompTrinketDetails")

function UICompTrinketDetails:ctor(uiNode, view, nodeEffectLink)
  Super.ctor(self, uiNode, view)
  self.nodeEffectLink = nodeEffectLink
  self.ui = UI_Team_Item_Trinket_DetailResource(uiNode)
end

function UICompTrinketDetails:OnBuildComponent()
  self.clickScrollViewProps = UIClickableScrollView(self.ui.ScrollView_Props, System.fn(self, self._OnCloseTrinketDetailsTips))
  self.clickScrollViewSuit = UIClickableScrollView(self.ui.ScrollView_Suit, System.fn(self, self._OnCloseTrinketDetailsTips))
end

function UICompTrinketDetails:OnExitComponent()
  if self.clickScrollViewProps then
    self.clickScrollViewProps:Dispose()
  end
  if self.clickScrollViewSuit then
    self.clickScrollViewSuit:Dispose()
  end
  Super.OnExitComponent(self)
end

function UICompTrinketDetails:RefreshDetails(trinkets, compareTrinkets, isBindMode, forceBonusUid)
  self.trinkets = trinkets
  self.compareTrinkets = compareTrinkets
  self.isBindMode = isBindMode and true or false
  self.forceBonusUid = forceBonusUid or 0
  self:_RefreshTrinketStrengthProgress()
  self:_RefreshAttrs()
  self:_RefreshSuitEffects()
end

function UICompTrinketDetails:_RefreshTrinketStrengthProgress()
  local trinkets = self.trinkets
  if not TrinketModel.Instance:ExistsAnyTrinkets(trinkets) then
    self.ui.Image_Completeness:SetActive(false)
    return
  end
  self.ui.Image_Completeness:SetActive(true)
  self:SetText(self.ui.Text_CompletRate, AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(trinkets) .. "%")
  self:SetText(self.ui.Text_CompletRate_Title, LT.Text("TrinketCompletionRate"))
end

function UICompTrinketDetails:_RefreshAttrs()
  local isEmpty = not TrinketModel.Instance:ExistsAnyTrinkets(self.trinkets)
  local attrList = TrinketModel.Instance:GetActiveTrinketAttrsByUids(self.trinkets)
  local attrListCompared = self.compareTrinkets and TrinketModel.Instance:GetActiveTrinketAttrsByUids(self.compareTrinkets) or nil
  local bindBonusDisplayMap = AwakerTrinketDataUtils.GetBindBonusAttrDisplayMap(self.trinkets, attrList, {
    forceBonusUid = self.forceBonusUid
  })
  local compareBonusDisplayMap = self.compareTrinkets and attrListCompared and AwakerTrinketDataUtils.GetBindBonusAttrDisplayMap(self.compareTrinkets, attrListCompared) or nil
  local ct_transform = self.ui.Content_Props.transform
  local cnt = self:ReserveChildren(ct_transform, #attrList)
  for i = 1, #attrList do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    local attr = attrList[i]
    local attrCompare = attrListCompared and attrListCompared[i] or nil
    local compareCount = attrCompare and attrCompare.count or nil
    local showBonusInfo = bindBonusDisplayMap[attr.tid]
    local isBindBonusHit = nil ~= showBonusInfo
    local showCount = attr.count
    if isBindBonusHit then
      showCount = showBonusInfo.displayCount
    end
    if compareCount then
      local compareBonusInfo = compareBonusDisplayMap and compareBonusDisplayMap[attr.tid] or nil
      if compareBonusInfo then
        compareCount = compareBonusInfo.displayCount
      end
    end
    local textCount = isEmpty and "-" or AwakerTrinketDataUtils.GetAttrFmtStringByValue(showCount, attr.isPercent)
    local showCompared = attrCompare and compareCount ~= showCount
    if not isEmpty and isBindBonusHit then
      textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount)
    elseif not isEmpty and showCompared then
      local color = showCount > compareCount and DT.ColorConfig.TrinketSuitAttrAdd.Light or DT.ColorConfig.TrinketSuitAttrSub.Light
      textCount = string.format("<color=%s>%s</color>", color, textCount)
    end
    local showAttr = {
      textCount = textCount,
      imageIcon = DT.ActorAttrType[attr.tid].Icon,
      textName = LT.Text(DT.ActorAttrType[attr.tid].Text)
    }
    local itemData = {
      showAttr = showAttr,
      clientAttr = attr,
      resourceCls = UI_Team_Item_Prop_DetailResource
    }
    local comp = self:AddViewComponentOnce(go, UICompAwakerAttrItem, itemData)
    comp.ui.Text_Count:SetActive(true)
    if isEmpty or not showCompared then
      comp.ui.Image_Arrow:SetActive(false)
      comp.ui.Text_Compare:SetActive(false)
    else
      comp.ui.Image_Arrow:SetActive(true)
      comp.ui.Text_Compare:SetActive(true)
      self:SetText(comp.ui.Text_Compare, AwakerTrinketDataUtils.GetAttrFmtStringByValue(compareCount, attrCompare.isPercent))
    end
  end
  for i = #attrList + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function UICompTrinketDetails:_RefreshSuitEffects()
  local suitEffects = TrinketModel.Instance:GetActiveSuitEffectDescListByUids(self.trinkets)
  if not suitEffects or 0 == #suitEffects then
    self.ui.Text_C_Suit_Null:SetActive(true)
    self.ui.ScrollView_Suit:SetActive(false)
    return
  end
  self.ui.Text_C_Suit_Null:SetActive(false)
  self.ui.ScrollView_Suit:SetActive(true)
  local ct_transform = self.ui.Content_Suit.transform
  local cnt = self:ReserveChildren(ct_transform, #suitEffects)
  for i = 1, #suitEffects do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    self:RefreshOneSuitEffect(go, suitEffects[i])
  end
  for i = #suitEffects + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content_Suit)
end

function UICompTrinketDetails:RefreshOneSuitEffect(effNode, suitData)
  local ui = UI_Awaker_Item_Trinket_SuitdescResource(effNode)
  self:SetText(ui.Text_Suit_Name, suitData and suitData.suitEffectTitle or "")
  local effectDescList = suitData.effectDescList
  local group_Suit = ui.Group_Suit
  local ct_transform = group_Suit.transform
  local cnt = self:ReserveChildren(ct_transform, #effectDescList)
  local extraParam = {
    lockParentNode = self.nodeEffectLink
  }
  for i = 1, #effectDescList do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    self:SetText(go, effectDescList[i] and effectDescList[i].desc or "", true, nil, extraParam)
    local imageObj = ui["Image_Suit_Icon_" .. i]
    if not imageObj then
    else
      local imagePath = AwakerTrinketDataUtils.SuitEffectActiveImagePath
      local colorCfg = DT.ColorConfig.TrinketPlanSuitActived
      self:SetImage(imageObj, imagePath)
      self:SetImageColorByHtml(imageObj, colorCfg.Light)
    end
  end
  for i = #effectDescList + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function UICompTrinketDetails:_OnCloseTrinketDetailsTips()
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
end

return UICompTrinketDetails
