local RedType = RedPointDataUtils.RedType
local RedDotType = CommonDefine.RedDotType
local AwakerPage = CommonDefine.AwakerPage
local TRINKET_SLOT_COUNT = CommonDefine.MaxEquipTrinketsNum
local AwakerTrinketSuitInfoComp, Super = System.NewComponent("AwakerTrinketSuitInfoComp")

function AwakerTrinketSuitInfoComp:ctor(uiNode, model, trinketModel, attrModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_Main3Resource(uiNode)
  self.model = model
  self.trinketModel = trinketModel
  self.attrModel = attrModel
end

function AwakerTrinketSuitInfoComp:OnBind(binder)
  self.boundLightComps = {}
  self:BindTrinketSuitComponents(binder)
  self:BindTrinketSuitRecommentRedPoint(binder)
  self:BindTrinketSuitGatherAll(binder)
  self:BindTakeOffAll(binder)
  self:BindRecommendEquip(binder)
  self:BindTrinketSuitAttrs(binder)
  self:BindChangeTrinket(binder)
  self:BindTrinketSuitEffects(binder)
end

function AwakerTrinketSuitInfoComp:BindTrinketSuitEffects(binder)
  binder:BindToRaw(function(childBinder, descs, _)
    if not descs then
      return
    end
    self.ui.Text_C_Empty_2:SetActive(0 == #descs)
    self:RefreshSuitEffectsList(childBinder)
  end, function()
    do return self.trinketModel.GetActiveSuitEffectDescList end
    return self.trinketModel.GetActiveSuitEffectDescList, self.trinketModel
  end)
end

function AwakerTrinketSuitInfoComp:RefreshSuitEffectsList(binder)
  local suitList = self.trinketModel:GetActiveSuitEffectDescList()
  local suitNum = #suitList
  local ct_transform = self.ui.Content_Suit.transform
  local cnt = self:ReserveChildren(ct_transform, suitNum)
  for i = 1, #suitList do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    self:RefreshOneSuitEffect(binder, suitList[i], go)
  end
  for i = suitNum + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Content_Suit)
end

function AwakerTrinketSuitInfoComp:RefreshOneSuitEffect(binder, suitData, go)
  local ui = UI_Awaker_Item_Trinket_SuitdescResource(go)
  binder:BindToText(ui.Text_Suit_Name, function()
    return suitData and suitData.suitEffectTitle or ""
  end)
  local effectDescList = suitData.effectDescList
  local group_Suit = ui.Group_Suit
  local ct_transform = group_Suit.transform
  local cnt = self:ReserveChildren(ct_transform, #effectDescList)
  for i = 1, #effectDescList do
    local descGo = ct_transform:GetChild(i - 1).gameObject
    descGo:SetActive(true)
    binder:BindToText(descGo, function()
      return effectDescList[i] and effectDescList[i].desc or ""
    end, nil, nil, nil)
    local imageObj = ui["Image_Suit_Icon_" .. i]
    if not imageObj then
    else
      binder:BindToImage(imageObj, function()
        local imagePath = AwakerTrinketDataUtils.SuitNotActiveImagePath
        local isActive = suitData.activeNum >= effectDescList[i].activeNum
        if isActive then
          imagePath = AwakerTrinketDataUtils.SuitActiveImagePath
        end
        return imagePath
      end)
      binder:BindToImageColor(imageObj, function()
        local wordEffectKey = "TrinketSuitOff"
        local isActive = suitData.activeNum >= effectDescList[i].activeNum
        if isActive then
          wordEffectKey = "TrinketSuitOn"
        end
        local config = DT.WordsEffectConfig[wordEffectKey]
        local colorHexStr = StrUtils.GetWordsEffectColor(config)
        return colorHexStr
      end)
    end
  end
  for i = #effectDescList + 1, cnt do
    local hideGo = ct_transform:GetChild(i - 1).gameObject
    hideGo:SetActive(false)
  end
end

function AwakerTrinketSuitInfoComp:BindTrinketSuitGatherAll(binder)
  binder:BindToVisible(self.ui.Image_Finish, function()
    do return self.trinketModel.IsSuitGatherAll end
    return self.trinketModel.IsSuitGatherAll, self.trinketModel
  end)
  binder:BindToImage(self.ui.Image_Finish, function()
    local isGatherAll = self.trinketModel:IsSuitGatherAll()
    if not isGatherAll then
      return
    end
    local trinkets = self.trinketModel.trinkets
    local suitId = trinkets[1].suitId
    local iconPath = self.trinketModel:GetSuitIcon(suitId)
    return iconPath
  end)
end

function AwakerTrinketSuitInfoComp:BindTrinketSuitComponents(binder)
  for i = 1, TRINKET_SLOT_COUNT do
    local btnObj = self.ui["Btn_Parts_" .. i]
    if btnObj then
      binder:BindButtonClick(btnObj, function()
        if table.next(AwakerDataUtils.GetMockAwakerMap()) then
          return
        end
        self.trinketModel:SetSelectPos(i)
        self.model:SetAwakerPage(AwakerPage.TrinketChange)
        self.trinketModel:SetDefaultChosenTrinket()
      end)
    end
  end
  for i = 1, TRINKET_SLOT_COUNT do
    local imageObj = self.ui["Image_Parts_" .. i]
    if imageObj then
      binder:BindToImage(imageObj, function()
        local trinkets = self.trinketModel.trinkets
        local trinket = trinkets[i]
        if not trinket then
          return
        end
        local iconPath = self.trinketModel:GetTrinketIcon(trinket.tid)
        return iconPath
      end)
      binder:BindToVisible(imageObj, function()
        local trinkets = self.trinketModel.trinkets
        local trinket = trinkets[i]
        if not trinket then
          return false
        end
        return trinket.tid and trinket.tid > 0
      end)
      local lightComp = UICompTrinketIconMat(imageObj, {binder = binder})
      binder:BindToRaw(function(_, hasBound, _)
        lightComp:EnableLight(true == hasBound, i)
      end, function()
        local trinket = self.trinketModel.trinkets[i]
        return trinket and AwakerTrinketDataUtils.IsTrinketBoundForLight(trinket.uid) or false
      end)
      table.insert(self.boundLightComps, lightComp)
    end
  end
end

function AwakerTrinketSuitInfoComp:BindTrinketSuitRecommentRedPoint(binder)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Recommend, RedDotType.Dot, nil, function()
    local needShow = not table.next(AwakerDataUtils.GetMockAwakerMap())
    if not needShow then
      return false
    end
    local awakerTid = self.model.selectAwakerId
    if not self.model:HasOwnedAwaker(awakerTid) then
      return false
    end
    do return RedPointDataUtils.GetRedPointState, RedType.AwakerTrinket end
    return RedPointDataUtils.GetRedPointState, RedType.AwakerTrinket, {awakerTid}, awakerTid
  end))
end

function AwakerTrinketSuitInfoComp:BindTakeOffAll(binder)
  binder:BindButtonClick(self.ui.Btn_TakeOff_All, function()
    UIManager.Instance:Reopen(Urls.TeamTrinketEquipView, {
      tempMpdel = self.trinketModel
    })
  end)
  binder:BindToVisible(self.ui.Btn_TakeOff_All, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    local trinkets = self.trinketModel.trinkets
    local hasAnyTrinket = false
    for _, _ in pairs(trinkets) do
      hasAnyTrinket = true
    end
    return hasAnyTrinket
  end)
end

function AwakerTrinketSuitInfoComp:BindRecommendEquip(binder)
  binder:BindToVisible(self.ui.Btn_Suggest, function()
    return not table.next(AwakerDataUtils.GetMockAwakerMap())
  end)
  binder:BindZ1Button(self.ui.Btn_Suggest, function()
    if self.model.page ~= AwakerPage.Trinket then
      return
    end
    local freeSlots = {}
    for i = 1, TRINKET_SLOT_COUNT do
      local trinket = self.trinketModel.trinkets[i]
      if not trinket then
        table.insert(freeSlots, i)
      end
    end
    if 0 == #freeSlots then
      Alert.Show(10638)
      return
    end
    local hasFreeTrinkets = false
    for _, pos in ipairs(freeSlots) do
      local trinketUids = self.trinketModel:GetPosList(pos, true)
      for _, uid in ipairs(trinketUids) do
        local trinket = self.trinketModel:GetTrinketDataByUid(uid)
        if 0 == trinket.awaker then
          hasFreeTrinkets = true
          break
        end
      end
    end
    if not hasFreeTrinkets then
      Alert.Show(10637)
      return
    end
    local awakerTid = self.model.selectAwakerId
    self.trinketModel:EquipRecommendTrinket(awakerTid)
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "Trinket_Suggest_Btn"
  end)
end

function AwakerTrinketSuitInfoComp:BindTrinketSuitAttrs(binder)
  binder:BindToRaw(function(childBinder, n, _)
    if not n then
      return
    end
    local attrList = n
    local bindBonusDisplayMap = AwakerTrinketDataUtils.GetBindBonusAttrDisplayMap(self.trinketModel.trinkets, attrList)
    local ct_transform = self.ui.Content_Props.transform
    local cnt = self:ReserveChildren(ct_transform, #attrList)
    for i = 1, #attrList do
      local attr = attrList[i]
      local textCount = AwakerTrinketDataUtils.GetAttrFmtString(attr)
      local bonusInfo = bindBonusDisplayMap[attr.tid]
      if bonusInfo then
        textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(bonusInfo.displayCount, attr.isPercent)
        textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount)
      end
      local showAttr = {
        textCount = textCount,
        imageIcon = DT.ActorAttrType[attr.tid].Icon,
        textName = LT.Text(DT.ActorAttrType[attr.tid].Text)
      }
      local itemData = {
        showAttr = showAttr,
        clientAttr = attr,
        resourceCls = UI_Awaker_Item_Trinket_AttributeResource
      }
      local go = ct_transform:GetChild(i - 1).gameObject
      go:SetActive(true)
      childBinder:BindComponent(AwakerAttrItem(go, itemData))
    end
    for i = #attrList + 1, cnt do
      local go = ct_transform:GetChild(i - 1).gameObject
      go:SetActive(false)
    end
  end, function()
    return self.trinketModel.currActiveTrinketAttrs
  end)
end

function AwakerTrinketSuitInfoComp:BindChangeTrinket(binder)
  binder:BindToVisible(self.ui.Btn_Replace, function()
    return not table.next(AwakerDataUtils.GetMockAwakerMap())
  end)
  binder:BindZ1Button(self.ui.Btn_Replace, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    if self.model.page ~= AwakerPage.Trinket then
      return
    end
    self.model:SetAwakerPage(AwakerPage.TrinketChange)
    local defaultPos = self.trinketModel:GetFirstNotEmptyPos()
    self.trinketModel:SetSelectPos(defaultPos)
    binder:BindTimer(0.1, 0, nil, function()
      self.trinketModel:SetDefaultChosenTrinket()
    end)
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "RoleDetailsEquipDetails_Btn_Change"
  end, nil, nil, nil)
end

function AwakerTrinketSuitInfoComp:ReserveChildren(transform, num)
  local ct_transform = transform
  local cnt = ct_transform.childCount
  while num > cnt do
    CS.UnityEngine.GameObject.Instantiate(ct_transform:GetChild(0).gameObject, ct_transform)
    cnt = cnt + 1
  end
  return cnt
end

function AwakerTrinketSuitInfoComp:OnUnbind()
  for _, lightComp in ipairs(self.boundLightComps or {}) do
    lightComp:OnExitComponent()
  end
  self.boundLightComps = nil
  Super.OnUnbind(self)
end

return AwakerTrinketSuitInfoComp
