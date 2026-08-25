local AwakerPage = CommonDefine.AwakerPage
local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local AwakerFullAttrPanel, Super = System.NewClass("AwakerFullAttrPanel", UIBasePanel)
AwakerFullAttrPanel.uiResCls = UI_Awaker_Popup_Attribute_DetailResource

function AwakerFullAttrPanel:ctor(model, openFrom, teamModel)
  Super.ctor(self)
  self.teamModel = teamModel
  self.model = model
  self.openFrom = openFrom
  self.attrList = Vue.computed(function()
    if self.openFrom == AwakerPage.Detail then
      return self.model.clientAttrs
    elseif self.openFrom == AwakerPage.Trinket then
      return self.model.finalTrinketAttrs
    end
    return {}
  end)
end

function AwakerFullAttrPanel:OnBind(binder)
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.Close))
  self:_CalEquipAttrsFromTeamModel()
  self:_CalBindBonusDisplayMap()
  local CommonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.S,
    textTitleEN = nil,
    clickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_S, CommonPopupTipsData))
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    if not animator then
      self:Close()
      return
    end
    AnimatorUtils.PlayState(animator, "Base Layer.ClosePanel")
  end)
  local euipedAwaker = self:CloneAwakerAddEquipsAttr()
  binder:BindToCircularListView(self.ui.ScrollView_Prop, function()
    do return end
    return self.attrList, nil
  end, function(childBinder, obj, index)
    local data = self.attrList()[index]
    local itemData = {
      clientAttr = data,
      resourceCls = UI_Awaker_Item_Prop_DetailResource
    }
    self:_ApplyEquipsAttr(itemData)
    self:_ApplyBindBonusDisplay(itemData)
    local attrDesc = AttrUtils.GetAttrDesc(data.tid)
    local attrAddVal = self.equipsAttrs[data.tid] and self.equipsAttrs[data.tid] or 0
    data.attrDesc = AttrUtils.CalAttrDesc(euipedAwaker, attrDesc, data.type, data.tid, attrAddVal)
    childBinder:BindComponent(AwakerAttrItem(obj, itemData))
  end)
  self:_BindBaseAttrComp(binder)
end

function AwakerFullAttrPanel:CloneAwakerAddEquipsAttr()
  local equipedAwaker = table.deepclone(self.model.selectAwaker)
  local attrs = equipedAwaker.attrs or {}
  for attrTid, equipValue in pairs(self.equipsAttrs) do
    local attrCfg = DT.ActorAttrType[attrTid] or {}
    local attrKey = attrCfg.Name
    attrs[attrKey] = (attrs[attrKey] or 0) + equipValue
  end
  for attrKey, attrValue in pairs(attrs) do
  end
  equipedAwaker.attrs = attrs
  return equipedAwaker
end

function AwakerFullAttrPanel:_ApplyEquipsAttr(itemData)
  local attrId = itemData.clientAttr.tid
  if not (self.equipsAttrs and self.equipsAttrs[attrId]) or 0 == self.equipsAttrs[attrId] then
    return
  end
  local clientAttr = AwakerTrinketDataUtils.TrinketAttrToClientAttr({
    attrId = attrId,
    val = self.equipsAttrs[attrId]
  })
  local textCount = AwakerTrinketDataUtils.GetAttrFmtStringWithMax(itemData.clientAttr)
  local addTextCount = AwakerTrinketDataUtils.GetAttrFmtStringWithMax(clientAttr)
  local suffixText = "+" .. addTextCount
  if self.bindBonusAttrTids and self.bindBonusAttrTids[attrId] then
    suffixText = AwakerTrinketDataUtils.GetBindBonusAttrText(suffixText)
  else
    local color = DT.ColorConfig.TrinketSuitAttrAdd
    suffixText = string.format("<color=%s>%s</color>", color.Light, suffixText)
  end
  local attrType = DT.ActorAttrType[attrId]
  local showAttr = {
    textCount = textCount .. suffixText,
    imageIcon = attrType.Icon,
    textName = LT.Text(attrType.Text)
  }
  itemData.showAttr = showAttr
end

function AwakerFullAttrPanel:_CalBindBonusDisplayMap()
  self.bindBonusDisplayMap = nil
  if self.openFrom ~= AwakerPage.Trinket then
    return
  end
  self.bindBonusDisplayMap = AwakerTrinketDataUtils.GetBindBonusAttrDisplayMap(self.model.trinkets, self.attrList())
end

function AwakerFullAttrPanel:_ApplyBindBonusDisplay(itemData)
  if self.openFrom ~= AwakerPage.Trinket then
    return
  end
  local clientAttr = itemData.clientAttr
  local attrId = clientAttr and clientAttr.tid
  if not attrId then
    return
  end
  local bonusInfo = self.bindBonusDisplayMap and self.bindBonusDisplayMap[attrId]
  if not bonusInfo then
    return
  end
  local textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(bonusInfo.displayCount, clientAttr.isPercent)
  textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount)
  if itemData.showAttr then
    itemData.showAttr.textCount = textCount
    return
  end
  local attrType = DT.ActorAttrType[attrId]
  itemData.showAttr = {
    textCount = textCount,
    imageIcon = attrType and attrType.Icon or "",
    textName = attrType and LT.Text(attrType.Text) or ""
  }
end

function AwakerFullAttrPanel:_CalEquipAttrsFromTeamModel()
  self.equipsAttrs = {}
  self.bindBonusAttrTids = {}
  if not self.teamModel then
    return
  end
  local awakerId = self.model.awakerModel.selectAwakerId
  local slotIndex
  local maxNum = CommonDefine.TeamAssign.MaxBattleNum
  for nSlot = 1, maxNum do
    local tid = self.teamModel:GetTeamAwakerTidBySlot(nSlot)
    if tid == awakerId then
      slotIndex = nSlot
      break
    end
    if nSlot == maxNum and self.teamModel:GetAssistAwaker() then
      slotIndex = nSlot
      break
    end
  end
  if not slotIndex then
    return
  end
  AwakerTrinketExtModel.Instance:CalTrinketAttrsFromTeamSlot(self.teamModel, slotIndex, self.equipsAttrs)
  TeamWeaponModel.Instance:CalWeaponAttrsFromTeamSlot(self.teamModel, slotIndex, self.equipsAttrs)
  local contributions = AwakerTrinketExtModel.Instance:CollectSlotBindContributions(self.teamModel, slotIndex)
  for bonusAttrId in pairs(contributions) do
    self.bindBonusAttrTids[bonusAttrId] = true
  end
end

function AwakerFullAttrPanel:_BindBaseAttrComp(binder)
  local baseAttrData = {}
  for _, attrData in ipairs(self.model.baseAttrs) do
    if attrData then
      baseAttrData[attrData.type] = attrData
    end
  end
  local awakerTid = self.model.selectAwaker.tid
  local hpAttrData = {
    clientAttr = baseAttrData.physique,
    awakerTid = awakerTid,
    resourceCls = UI_Awaker_Item_Prop_DetailResource
  }
  binder:BindComponent(AwakerAttrItem(self.ui.Prop_Hp, hpAttrData))
  local atkAttrData = {
    clientAttr = baseAttrData.atk,
    awakerTid = awakerTid,
    resourceCls = UI_Awaker_Item_Prop_DetailResource
  }
  binder:BindComponent(AwakerAttrItem(self.ui.Prop_Atk, atkAttrData))
  local defAttrData = {
    clientAttr = baseAttrData.def,
    awakerTid = awakerTid,
    resourceCls = UI_Awaker_Item_Prop_DetailResource
  }
  binder:BindComponent(AwakerAttrItem(self.ui.Prop_Def, defAttrData))
  local ultiMaxAttrData = {
    clientAttr = baseAttrData.ulti_energy_max,
    awakerTid = awakerTid,
    resourceCls = UI_Awaker_Item_Prop_DetailResource
  }
  binder:BindComponent(AwakerAttrItem(self.ui.Prop_UltiEnergy, ultiMaxAttrData))
end

function AwakerFullAttrPanel:Close()
  Super.Close(self)
end

return AwakerFullAttrPanel
