local PATH_CONTAINER_AWAKER = "UI_Awaker_Panel_Main(Clone).Container_Awaker"
local AwakerTrinketBindComp, Super = System.NewComponent("AwakerTrinketBindComp", AwakerBasePageComp)

function AwakerTrinketBindComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_BindResource(uiNode)
  self.gameObject = uiNode
  self.model = model
  self.refreshCounter = Vue.ref(0)
  self.selectPart = Vue.ref(0)
end

function AwakerTrinketBindComp:GetOpenAnim()
  self.gameObject:SetActive(true)
  self:_SetAwakerContainerActive(false)
  return "", nil
end

function AwakerTrinketBindComp:GetCloseAnim()
  self.gameObject:SetActive(false)
  self:_SetAwakerContainerActive(true)
  return "", nil
end

function AwakerTrinketBindComp:GetEnterDetailAnim()
  return "", nil
end

function AwakerTrinketBindComp:GetExitDetailAnim()
  return "", nil
end

function AwakerTrinketBindComp:OnBind(binder)
  self.binder = binder
  self.boundTrinketLightComps = {}
  self:_BindTrinketParts(binder)
  self:_BindTrinketSuitGatherAll(binder)
  self:_BindEmptySuitTips(binder)
  self:_BindRuleBtn(binder)
  self:_BindEmptyArea(binder)
  self:_BindBindBtn(binder)
  self:_BindChangeBindBtn(binder)
  self:_BindUnbindAllBtn(binder)
  self:_BindDynamicLists(binder)
  
  function self._onBoundDataChangedHandler(awakerTid)
    self:_OnTrinketBoundDataChanged(awakerTid)
  end
  
  GlobalDispatcher:AddListener(NotifyId.OnTrinketBoundDataChanged, self._onBoundDataChangedHandler)
  
  function self._onTrinketAttrsChangedHandler(targetUid)
    self:_OnTrinketAttrsChanged(targetUid)
  end
  
  GlobalDispatcher:AddListener(NotifyId.OnTrinketUpdategraded, self._onTrinketAttrsChangedHandler)
  GlobalDispatcher:AddListener(NotifyId.OnTrinketConversioned, self._onTrinketAttrsChangedHandler)
  
  function self._onBagItemChangedHandler(uid, tid)
    self:_OnBagItemDataChanged(uid, tid)
  end
  
  GlobalDispatcher:AddListener(NotifyId.OnBagItemDataChanged, self._onBagItemChangedHandler)
  binder:Watch(function()
    return self.model.selectAwakerId
  end, function(_, newId, oldId)
    if newId == oldId then
      return
    end
    self.selectPart.value = 0
    ItemDetailsController.Instance:CloseItemDetailTips()
  end)
  self:_RefreshAll()
end

function AwakerTrinketBindComp:OnUnbind()
  for _, lightComp in ipairs(self.boundTrinketLightComps or {}) do
    lightComp:OnExitComponent()
  end
  self.boundTrinketLightComps = nil
  if self._onBoundDataChangedHandler then
    GlobalDispatcher:RemoveListener(NotifyId.OnTrinketBoundDataChanged, self._onBoundDataChangedHandler)
    self._onBoundDataChangedHandler = nil
  end
  if self._onTrinketAttrsChangedHandler then
    GlobalDispatcher:RemoveListener(NotifyId.OnTrinketUpdategraded, self._onTrinketAttrsChangedHandler)
    GlobalDispatcher:RemoveListener(NotifyId.OnTrinketConversioned, self._onTrinketAttrsChangedHandler)
    self._onTrinketAttrsChangedHandler = nil
  end
  if self._onBagItemChangedHandler then
    GlobalDispatcher:RemoveListener(NotifyId.OnBagItemDataChanged, self._onBagItemChangedHandler)
    self._onBagItemChangedHandler = nil
  end
  Super.OnUnbind(self)
end

function AwakerTrinketBindComp:_BindTrinketParts(binder)
  if self.ui.Group_Parts then
    binder:BindToVisible(self.ui.Group_Parts, function()
      local _ = self.refreshCounter.value
      do return self._HasBoundTrinkets end
      return self._HasBoundTrinkets, self
    end)
  end
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    self:_BindOneTrinketPart(binder, i)
  end
end

function AwakerTrinketBindComp:_BindOneTrinketPart(binder, part)
  local btnObj = self.ui["Btn_Parts_" .. part]
  if btnObj then
    binder:BindButtonClick(btnObj, function()
      self:_OnClickTrinketPart(part)
    end)
  end
  local imageObj = self:FindChild(btnObj, "Image_Parts_" .. part)
  if imageObj then
    local lightComp = UIUtils.BindBoundTrinketIconWithLight(binder, imageObj, function()
      do return self._GetBoundTrinketData, self end
      return self._GetBoundTrinketData, self, part
    end, part)
    table.insert(self.boundTrinketLightComps, lightComp)
  end
  local selectObj = self:FindChild(btnObj, "Image_Select_Patrs_" .. part)
  if selectObj then
    binder:BindToVisible(selectObj, function()
      return self.selectPart.value == part
    end)
  end
end

function AwakerTrinketBindComp:_BindTrinketSuitGatherAll(binder)
  local imageFinish = self.ui.Image_Finish
  if not imageFinish then
    return
  end
  binder:BindToVisible(imageFinish, function()
    local _ = self.refreshCounter.value
    local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(self.model.selectAwakerId)
    do return TrinketModel.Instance.IsSuitGatherAll, TrinketModel.Instance end
    return TrinketModel.Instance.IsSuitGatherAll, TrinketModel.Instance, boundTrinkets
  end)
  binder:BindToImage(imageFinish, function()
    local _ = self.refreshCounter.value
    local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(self.model.selectAwakerId)
    if not TrinketModel.Instance:IsSuitGatherAll(boundTrinkets) then
      return
    end
    local trinket = ItemDataUtils.GetItemByUid(boundTrinkets[1])
    if not trinket then
      return
    end
    do return AwakerTrinketDataUtils.GetSuitIcon end
    return AwakerTrinketDataUtils.GetSuitIcon, trinket.suitId
  end)
end

function AwakerTrinketBindComp:_BindEmptySuitTips(binder)
  local textEmptySuit = self.ui.Text_C_Empty_Suit
  if not textEmptySuit then
    return
  end
  binder:BindToVisible(textEmptySuit, function()
    local _ = self.refreshCounter.value
    return 0 == #self:_GetSuitDescList()
  end)
end

function AwakerTrinketBindComp:_CanEditBinding()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  do return AwakerDataUtils.HasOwnedAwaker end
  return AwakerDataUtils.HasOwnedAwaker, self.model.selectAwakerId
end

function AwakerTrinketBindComp:_OnClickTrinketPart(part)
  if not self:_CanEditBinding() then
    return
  end
  self.selectPart.value = part
  local trinket = self:_GetBoundTrinketData(part)
  if not trinket then
    self:_OpenTrinketSelectView(part)
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui["Btn_Parts_" .. part], trinket.uid, trinket.tid)
end

function AwakerTrinketBindComp:_BindRuleBtn(binder)
  local btnRule = self.ui.Btn_Rule
  if not btnRule then
    return
  end
  binder:BindButtonClick(btnRule, function()
    self:_ShowRuleTips()
  end)
end

function AwakerTrinketBindComp:_BindEmptyArea(binder)
  local groupEmpty = self.ui.Group_Empty
  if groupEmpty then
    binder:BindToVisible(groupEmpty, function()
      local _ = self.refreshCounter.value
      return not self:_HasBoundTrinkets()
    end)
    binder:BindButtonClick(groupEmpty, function()
      if not self:_CanEditBinding() then
        return
      end
      self:_OpenTrinketSelectView()
    end)
  end
  local textEmptyTips = self.ui.Text_Empty_Tips
  if textEmptyTips then
    binder:SetText(textEmptyTips, LT.Textf("TrinketBindBonusDesc", self:_GetBindBonusRateStr()))
  end
end

function AwakerTrinketBindComp:_BindBindBtn(binder)
  local btnBind = self.ui.Btn_Bind
  if not btnBind then
    return
  end
  binder:BindToVisible(btnBind, function()
    local _ = self.refreshCounter.value
    do return self._CanEditBinding end
    return self._CanEditBinding, self
  end)
  local textBind = self:FindChild(btnBind, "Text_C_Bind")
  if textBind then
    binder:BindToText(textBind, function()
      local part = self.selectPart.value
      local _ = self.refreshCounter.value
      if 0 ~= part then
        local uid = AwakerDataUtils.GetBoundTrinketUid(self.model.selectAwakerId, part)
        if uid and uid > 0 then
          do return LT.Text end
          return LT.Text, "TrinketChangeBind"
        end
      end
      do return LT.Text end
      return LT.Text, "TrinketBind", "TrinketChangeBind"
    end)
  end
  binder:BindButtonClick(btnBind, function()
    if not self:_CanEditBinding() then
      return
    end
    local part = self.selectPart.value
    self:_OpenTrinketSelectView(part > 0 and part or nil)
  end)
end

function AwakerTrinketBindComp:_BindChangeBindBtn(binder)
  local btnChangeBind = self.ui.Btn_Change_Bind
  if not btnChangeBind then
    return
  end
  binder:BindToVisible(btnChangeBind, function()
    local part = self.selectPart.value
    local _ = self.refreshCounter.value
    if not self:_CanEditBinding() then
      return false
    end
    if 0 == part then
      return false
    end
    local uid = AwakerDataUtils.GetBoundTrinketUid(self.model.selectAwakerId, part)
    return uid and uid > 0
  end)
  binder:BindButtonClick(btnChangeBind, function()
    if not self:_CanEditBinding() then
      return
    end
    local part = self.selectPart.value
    self:_OpenTrinketSelectView(part > 0 and part or nil)
  end)
end

function AwakerTrinketBindComp:_BindUnbindAllBtn(binder)
  local btnUnbindAll = self.ui.Btn_Unbind_All
  if not btnUnbindAll then
    return
  end
  binder:BindToVisible(btnUnbindAll, function()
    local _ = self.refreshCounter.value
    if not self:_CanEditBinding() then
      return false
    end
    do return self._HasBoundTrinkets end
    return self._HasBoundTrinkets, self
  end)
  binder:BindButtonClick(btnUnbindAll, function()
    if not self:_CanEditBinding() then
      return
    end
    self:_OpenBatchUnbindView()
  end)
end

function AwakerTrinketBindComp:_BindDynamicLists(binder)
  binder:BindToRaw(function(childBinder, _, _)
    self:_RefreshAttrList(childBinder)
    self:_RefreshSuitEffects(childBinder)
  end, function()
    return {
      self.refreshCounter.value,
      self.model.selectAwakerId
    }
  end)
end

function AwakerTrinketBindComp:_RefreshAttrList(childBinder)
  local uidList = self:_GetBoundUidList()
  local attrList = TrinketModel.Instance:GetActiveTrinketAttrsByUids(uidList)
  local bindBonusDisplayMap = AwakerTrinketDataUtils.GetBindBonusAttrDisplayMap(uidList, attrList)
  local ctTransform = self.ui.Content_Props.transform
  local cnt = self:_ReserveChildren(ctTransform, #attrList)
  local showNum = math.min(#attrList, cnt)
  for i = 1, showNum do
    local attr = attrList[i]
    local attrCfg = DT.ActorAttrType[attr.tid]
    if not attrCfg then
    else
      local textCount = AwakerTrinketDataUtils.GetAttrFmtString(attr)
      local bonusInfo = bindBonusDisplayMap[attr.tid]
      if bonusInfo then
        textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(bonusInfo.displayCount, attr.isPercent)
        textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount)
      end
      local showAttr = {
        textCount = textCount,
        imageIcon = attrCfg.Icon,
        textName = LT.Text(attrCfg.Text)
      }
      local itemData = {
        showAttr = showAttr,
        clientAttr = attr,
        resourceCls = UI_Awaker_Item_Trinket_AttributeResource
      }
      local go = ctTransform:GetChild(i - 1).gameObject
      go:SetActive(true)
      childBinder:BindComponent(AwakerAttrItem(go, itemData))
    end
  end
  for i = showNum + 1, cnt do
    local go = ctTransform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function AwakerTrinketBindComp:_GetBindBonusRateStr()
  local rateCfg = DT.Constant.TrinketMainAttrBindBonusRate
  local rate = rateCfg and rateCfg.Data and rateCfg.Data[1] or 0
  do return StrUtils.GetPercentNum end
  return StrUtils.GetPercentNum, rate
end

function AwakerTrinketBindComp:_RefreshSuitEffects(childBinder)
  local contentGo = self.ui.Content_Suit
  if not contentGo then
    return
  end
  local suitDescList = self:_GetSuitDescList()
  local ctTransform = contentGo.transform
  local cnt = self:_ReserveChildren(ctTransform, #suitDescList)
  local showNum = math.min(#suitDescList, cnt)
  for i = 1, showNum do
    local go = ctTransform:GetChild(i - 1).gameObject
    go:SetActive(true)
    self:_RefreshOneSuitEffect(childBinder, suitDescList[i], go)
  end
  for i = showNum + 1, cnt do
    local go = ctTransform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  CS.Framework.UIUtilTool.RefreshLayout(contentGo)
end

function AwakerTrinketBindComp:_GetSuitDescList()
  local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(self.model.selectAwakerId)
  local suitId2NumMap = AwakerTrinketDataUtils.GetSuitId2NumMapByTrinketUids(boundTrinkets)
  local descList = {}
  for suitId, activeNum in pairs(suitId2NumMap) do
    if AwakerTrinketDataUtils.IsSuitEffectActive(suitId, activeNum) then
      local descData = AwakerTrinketDataUtils.GetSuitDescData(suitId, activeNum, true)
      if descData and descData.suitEffectTitle then
        local effectDescList = descData.effectDescList or {}
        local numNeedList = descData.numNeedList or {}
        local filterDescList = {}
        local filterNeedList = {}
        for i, needNum in ipairs(numNeedList) do
          if needNum <= activeNum then
            table.insert(filterDescList, effectDescList[i])
            table.insert(filterNeedList, needNum)
          end
        end
        descData.effectDescList = filterDescList
        descData.numNeedList = filterNeedList
        descData.activeNum = activeNum
        table.insert(descList, descData)
      end
    end
  end
  return descList
end

function AwakerTrinketBindComp:_RefreshOneSuitEffect(childBinder, suitData, go)
  local ui = UI_Awaker_Item_Trinket_SuitdescResource(go)
  childBinder:BindToText(ui.Text_Suit_Name, function()
    return suitData and suitData.suitEffectTitle or ""
  end)
  local effectDescList = suitData.effectDescList or {}
  local numNeedList = suitData.numNeedList or {}
  local groupSuit = ui.Group_Suit
  if not groupSuit then
    return
  end
  local ctTransform = groupSuit.transform
  local cnt = self:_ReserveChildren(ctTransform, #effectDescList)
  local showNum = math.min(#effectDescList, cnt)
  for i = 1, showNum do
    local descGo = ctTransform:GetChild(i - 1).gameObject
    descGo:SetActive(true)
    childBinder:BindToText(descGo, function()
      return effectDescList[i] or ""
    end)
    local imageObj = ui["Image_Suit_Icon_" .. i]
    if not imageObj then
    else
      childBinder:BindToImage(imageObj, function()
        local isActive = (suitData.activeNum or 0) >= (numNeedList[i] or 0)
        if isActive then
          return AwakerTrinketDataUtils.SuitActiveImagePath
        end
        return AwakerTrinketDataUtils.SuitNotActiveImagePath
      end)
      childBinder:BindToImageColor(imageObj, function()
        local isActive = (suitData.activeNum or 0) >= (numNeedList[i] or 0)
        local wordEffectKey = "TrinketSuitOff"
        if isActive then
          wordEffectKey = "TrinketSuitOn"
        end
        local config = DT.WordsEffectConfig[wordEffectKey]
        do return StrUtils.GetWordsEffectColor end
        return StrUtils.GetWordsEffectColor, config
      end)
    end
  end
  for i = showNum + 1, cnt do
    local descGo = ctTransform:GetChild(i - 1).gameObject
    descGo:SetActive(false)
  end
end

function AwakerTrinketBindComp:_OpenTrinketSelectView(part)
  if not self:_CanEditBinding() then
    return
  end
  local awakerTid = self.model.selectAwakerId
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return
  end
  UIManager.Instance:Reopen(Urls.TrinketAwakerBindView, awakerData, part)
end

function AwakerTrinketBindComp:_OpenBatchUnbindView()
  if not self:_HasBoundTrinkets() then
    return
  end
  UIManager.Instance:Reopen(Urls.TrinketAwakerUnBindView, self.model.selectAwakerId, nil)
end

function AwakerTrinketBindComp:_ShowRuleTips()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, nil, LT.Text("TrinketBindRuleDesc"))
end

function AwakerTrinketBindComp:_OnTrinketBoundDataChanged(awakerTid)
  if awakerTid ~= self.model.selectAwakerId then
    return
  end
  self.selectPart.value = 0
  self:_RefreshAll()
end

function AwakerTrinketBindComp:_OnTrinketAttrsChanged(targetUid)
  if not targetUid or 0 == targetUid then
    return
  end
  local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(self.model.selectAwakerId)
  for _, uid in pairs(boundTrinkets or {}) do
    if uid == targetUid then
      self:_RefreshAll()
      return
    end
  end
end

function AwakerTrinketBindComp:_OnBagItemDataChanged(uid, tid)
  if not uid or 0 == uid then
    return
  end
  if tid and ItemDataUtils.GetItemType(tid) ~= CommonDefine.ItemType.Trinket then
    return
  end
  local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(self.model.selectAwakerId)
  for _, boundUid in pairs(boundTrinkets or {}) do
    if boundUid == uid then
      self:_RefreshAll()
      return
    end
  end
end

function AwakerTrinketBindComp:_RefreshAll()
  self.refreshCounter.value = self.refreshCounter.value + 1
end

function AwakerTrinketBindComp:_HasBoundTrinkets()
  return table.next(AwakerDataUtils.GetBoundTrinkets(self.model.selectAwakerId)) ~= nil
end

function AwakerTrinketBindComp:_GetBoundTrinketData(part)
  local _ = self.refreshCounter.value
  local uid = AwakerDataUtils.GetBoundTrinketUid(self.model.selectAwakerId, part)
  if not uid or 0 == uid then
    return nil
  end
  do return ItemDataUtils.GetItemByUid end
  return ItemDataUtils.GetItemByUid, uid
end

function AwakerTrinketBindComp:_GetBoundUidList()
  local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(self.model.selectAwakerId)
  local uidList = {}
  for _, uid in pairs(boundTrinkets) do
    if uid and uid > 0 then
      table.insert(uidList, uid)
    end
  end
  return uidList
end

function AwakerTrinketBindComp:_SetAwakerContainerActive(state)
  local containerGo = GuidePanelUtils.GetNodeGo(PATH_CONTAINER_AWAKER)
  if not containerGo then
    return
  end
  containerGo:SetActive(state)
end

function AwakerTrinketBindComp:FindChild(go, childName)
  if not go then
    return nil
  end
  local trs = go.transform:Find(childName)
  if trs then
    return trs.gameObject
  end
  return nil
end

function AwakerTrinketBindComp:_ReserveChildren(transform, num)
  local cnt = transform.childCount
  if 0 == cnt then
    return 0
  end
  while num > cnt do
    CS.UnityEngine.GameObject.Instantiate(transform:GetChild(0).gameObject, transform)
    cnt = cnt + 1
  end
  return cnt
end

return AwakerTrinketBindComp
