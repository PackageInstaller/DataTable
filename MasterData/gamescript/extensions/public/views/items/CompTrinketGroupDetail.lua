local CompTrinketGroupDetail, Super = NewViewComponent("CompTrinketGroupDetail")
local TRINKET_SLOT_COUNT = CommonDefine.MaxEquipTrinketsNum

function CompTrinketGroupDetail:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Item_Trinket_DetailResource(uiNode)
  self.showTrinketDataMap = data.showTrinketDataMap
  self.compareTrinketUidMap = data.compareTrinketUidMap
  self.showAwakerTid = data.showAwakerTid
  self.boundTrinkets = data.boundTrinkets
  self.showTrinketAttrs = self:_GetActiveTrinketAttrs(data.showTrinketDataMap)
  self.compareTrinketDataMap = self:_GetActiveTrinketAttrs(data.compareTrinketUidMap)
end

function CompTrinketGroupDetail:OnEnterComponent()
  self:_InitTrinketAttrs()
  self:_InitTrinketImages()
  self:_InitTrinketProgress()
  self:_InitTrinketSuitEffectsList()
end

function CompTrinketGroupDetail:_InitTrinketAttrs()
  local attrList = self.showTrinketAttrs
  local bindBonusDisplayMap = AwakerTrinketDataUtils.GetBindBonusAttrDisplayMap(self.showTrinketDataMap, attrList, {
    boundTrinkets = self.boundTrinkets
  })
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
      resourceCls = UI_Team_Item_Prop_DetailResource
    }
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    self.binder:BindComponent(AwakerAttrItemCompare(go, itemData))
  end
  for i = #attrList + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function CompTrinketGroupDetail:_InitTrinketImages()
  self:_RecycleLightComps()
  for i = 1, TRINKET_SLOT_COUNT do
    local imageObj = self.ui["Image_Parts_" .. i]
    if imageObj then
      local trinketData = self.showTrinketDataMap[i]
      local tid = trinketData and trinketData.tid or 0
      self:SetImage(imageObj, ItemDataUtils.GetItemIcon(tid))
      imageObj:SetActive(tid and tid > 0)
      if self.boundTrinkets then
        local lightComp = UICompTrinketIconMat(imageObj, {
          binder = self.binder
        })
        lightComp:EnableLight(AwakerTrinketDataUtils.IsTrinketBoundForLightByBoundTable(trinketData and trinketData.uid or 0, self.boundTrinkets), i)
        table.insert(self._lightComps, lightComp)
      end
    end
  end
  local isSuitGatherAll = AwakerTrinketDataUtils.IsSuitGatherAll(self.showTrinketDataMap)
  self.ui.Image_Finish:SetActive(isSuitGatherAll)
  if isSuitGatherAll then
    local suitId = self.showTrinketDataMap[1].suitId
    self:SetImage(self.ui.Image_Finish, AwakerTrinketDataUtils.GetSuitIcon(suitId))
  end
end

function CompTrinketGroupDetail:_GetActiveTrinketAttrs(trinketDataMap)
  do return AwakerTrinketDataUtils.GetAttrsByTrinketDataMap, trinketDataMap end
  return AwakerTrinketDataUtils.GetAttrsByTrinketDataMap, trinketDataMap, CommonDefine.AttrShowType.TrinketShow
end

function CompTrinketGroupDetail:_InitTrinketProgress()
  self:SetText(self.ui.Text_CompletRate, AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(self.showTrinketDataMap) .. "%")
  self:SetText(self.ui.Text_CompletRate_Title, LT.Text("TrinketCompletionRate"))
end

function CompTrinketGroupDetail:_InitTrinketSuitEffectsList()
  local suitList = AwakerTrinketDataUtils.GetActiveSuitEffectDescList(self.showTrinketDataMap)
  local suitNum = #suitList
  self.ui.Text_C_Suit_Null:SetActive(0 == suitNum)
  local ct_transform = self.ui.Content_Suit.transform
  local cnt = self:ReserveChildren(ct_transform, suitNum)
  for i = 1, #suitList do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(true)
    self:RefreshOneSuitEffect(suitList[i], go)
  end
  for i = suitNum + 1, cnt do
    local go = ct_transform:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Content_Suit)
end

function CompTrinketGroupDetail:RefreshOneSuitEffect(suitData, go)
  local ui = UI_Awaker_Item_Trinket_SuitdescResource(go)
  self:SetText(ui.Text_Suit_Name, suitData and suitData.suitEffectTitle or "")
  local effectDescList = suitData.effectDescList
  local group_Suit = ui.Group_Suit
  local ct_transform = group_Suit.transform
  local cnt = self:ReserveChildren(ct_transform, #effectDescList)
  for i = 1, #effectDescList do
    local isActive = suitData.activeNum >= effectDescList[i].activeNum
    local useGo = ct_transform:GetChild(i - 1).gameObject
    useGo:SetActive(true)
    self:SetText(useGo, effectDescList[i] and effectDescList[i].desc or "")
    local imageObj = ui["Image_Suit_Icon_" .. i]
    if not imageObj then
    else
      self:SetImage(imageObj, isActive and AwakerTrinketDataUtils.SuitActiveImagePath or AwakerTrinketDataUtils.SuitNotActiveImagePath)
      local wordEffectKey = isActive and "TrinketSuitOn" or "TrinketSuitOff"
      local config = DT.WordsEffectConfig[wordEffectKey]
      local colorHexStr = StrUtils.GetWordsEffectColor(config)
      self:SetImageColorByHtml(imageObj, colorHexStr)
    end
  end
  for i = #effectDescList + 1, cnt do
    local noUseGo = ct_transform:GetChild(i - 1).gameObject
    noUseGo:SetActive(false)
  end
end

function CompTrinketGroupDetail:ReserveChildren(transform, num)
  local ct_transform = transform
  local cnt = ct_transform.childCount
  while num > cnt do
    CS.UnityEngine.GameObject.Instantiate(ct_transform:GetChild(0).gameObject, ct_transform)
    cnt = cnt + 1
  end
  return cnt
end

function CompTrinketGroupDetail:_RecycleLightComps()
  for _, lightComp in ipairs(self._lightComps or {}) do
    lightComp:OnExitComponent()
  end
  self._lightComps = {}
end

function CompTrinketGroupDetail:OnExitComponent()
  self:_RecycleLightComps()
  Super.OnExitComponent(self)
end

return CompTrinketGroupDetail
