local AwakerTrinketDetailShowType = CommonDefine.AwakerTrinketDetailShowType
local AwakerPage = CommonDefine.AwakerPage
local AwakerTrinketDetailItem, Super = System.NewComponent("AwakerTrinketDetailItem")

function AwakerTrinketDetailItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Trinket_DetailResource(uiNode)
  self.model = data.model
  self.showType = data.showType
  self.tid = Vue.computed(function()
    if self.showType == AwakerTrinketDetailShowType.Selected then
      return self.model.selectTrinketTid
    elseif self.showType == AwakerTrinketDetailShowType.Equipped then
      return self.model.equippedTrinketTid
    end
    return 0
  end)
  self.uid = Vue.computed(function()
    if self.showType == AwakerTrinketDetailShowType.Selected then
      return self.model.selectTrinketUid
    elseif self.showType == AwakerTrinketDetailShowType.Equipped then
      return self.model.equippedTrinketUid
    end
    return 0
  end)
end

function AwakerTrinketDetailItem:BindEquipedGroup(binder)
  binder:BindToVisible(self.ui.Group_Awaker_Equip, function()
    local ownAwaker = self.model:GetOwner(self.uid.value)
    return ownAwaker and ownAwaker > 0
  end)
  binder:BindToImage(self.ui.Icon_Awaker, function()
    local ownAwaker = self.model:GetOwner(self.uid.value)
    if not ownAwaker or 0 == ownAwaker then
      return
    end
    local selectAwakerTid = self.model.awakerModel.selectAwakerId
    if selectAwakerTid and 0 ~= selectAwakerTid then
      local changeFormAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
      if ownAwaker == selectAwakerTid or changeFormAwaker == selectAwakerTid then
        ownAwaker = selectAwakerTid
      end
    elseif not AwakerDataUtils.IsAwakerShow(ownAwaker) then
      ownAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
    end
    local awakerIconPath = self.model:GetAwakerSmallIcon(ownAwaker)
    return awakerIconPath
  end)
end

function AwakerTrinketDetailItem:BindBaseInfo(binder)
  binder:BindToText(self.ui.Text_Name, function()
    local name = self.model:GetTrinketName(self.tid.value)
    return name
  end)
  binder:BindToText(self.ui.Text_Prop_Add, function()
    local level = self.model:GetLevel(self.uid.value)
    do return string.format, "+%s" end
    return string.format, "+%s", level
  end)
  binder:BindToImage(self.ui.Image_Base_Prop, function()
    local mainAttr = self.model:GetMainAttr(self.uid.value)
    local tid = mainAttr.tid
    if not tid or 0 == tid then
      return ""
    end
    return DT.ActorAttrType[tid].Icon
  end)
  binder:BindToText(self.ui.Text_Base_Prop, function()
    local mainAttr = self.model:GetMainAttr(self.uid.value)
    return mainAttr.name
  end)
  binder:BindToText(self.ui.Text_Base_Prop_Count, function()
    local mainAttr = self.model:GetMainAttr(self.uid.value)
    do return AwakerTrinketDataUtils.GetAttrFmtStringByValue, mainAttr.count or 0 end
    return AwakerTrinketDataUtils.GetAttrFmtStringByValue, mainAttr.count or 0, mainAttr.isPercent
  end)
end

function AwakerTrinketDetailItem:BindSubAttrs(binder)
  for i = 1, 5 do
    local obj = self.ui["Prop_" .. i]
    if obj then
      binder:BindToVisible(obj, function()
        local subAttr = self.model:GetSubAttrs(self.uid.value)
        return subAttr and #subAttr >= i
      end)
    end
  end
  binder:BindToRaw(function(cb, subAttrs)
    if not subAttrs then
      CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_List)
      return
    end
    for i = 1, 5 do
      local obj = self.ui["Prop_" .. i]
      local attr = subAttrs[i]
      if obj and attr then
        local attrType = DT.ActorAttrType[attr.tid]
        local showAttr = {
          textCount = AwakerTrinketDataUtils.GetAttrFmtStringWithMax(attr, 26),
          imageIcon = attrType.Icon,
          textName = LT.Text(attrType.Text)
        }
        local itemData = {
          showAttr = showAttr,
          clientAttr = attr,
          resourceCls = UI_Awaker_Item_EntryResource
        }
        cb:BindComponent(AwakerAttrItem(obj, itemData))
      end
    end
    CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_List)
  end, function()
    local data = self.model:GetSubAttrs(self.uid.value)
    return data
  end)
end

function AwakerTrinketDetailItem:BindSuitsInfo(binder)
  local suitDescUI = UI_Awaker_Item_Trinket_SuitdescResource(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
  binder:BindToVisible(suitDescUI.uiNode, function()
    return 0 ~= self.tid.value
  end)
  for i = 1, 3 do
    local imageObj = suitDescUI["Image_Suit_Icon_" .. i]
    if imageObj then
      binder:BindToImage(imageObj, function()
        local imagePath = AwakerTrinketDataUtils.SuitNotActiveImagePath
        if 0 == self.tid.value then
          return
        end
        local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(self.tid.value)
        local suitId = trinketInfo and trinketInfo[2] or 0
        local activeNum = self.model:GetSuitActiveEffectNum(suitId)
        local suitConfig = DT.TrinketSuitEffect[suitId]
        local suitActiveNum = i * 2
        local suitNumKey = string.format("SuitEffectNum_%s", i)
        if suitConfig[suitNumKey] then
          suitActiveNum = suitConfig[suitNumKey]
        end
        local isActive = activeNum >= suitActiveNum
        if isActive then
          imagePath = AwakerTrinketDataUtils.SuitActiveImagePath
        end
        return imagePath
      end)
      binder:BindToImageColor(imageObj, function()
        local wordEffectKey = "TrinketSuitOff"
        if 0 == self.tid.value then
          return
        end
        local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(self.tid.value)
        local suitId = trinketInfo and trinketInfo[2] or 0
        local activeNum = self.model:GetSuitActiveEffectNum(suitId)
        local suitConfig = DT.TrinketSuitEffect[suitId]
        local suitActiveNum = i * 2
        local suitNumKey = string.format("SuitEffectNum_%s", i)
        if suitConfig[suitNumKey] then
          suitActiveNum = suitConfig[suitNumKey]
        end
        local isActive = activeNum >= suitActiveNum
        if isActive then
          wordEffectKey = "TrinketSuitOn"
        end
        local config = DT.WordsEffectConfig[wordEffectKey]
        local colorHexStr = StrUtils.GetWordsEffectColor(config)
        return colorHexStr
      end)
    end
  end
  binder:BindToRaw(function(cb, descData)
    if not descData then
      return
    end
    cb:BindToText(suitDescUI.Text_Suit_Name, function()
      return descData and descData.suitEffectTitle or ""
    end)
    local descList = descData.effectDescList
    if not descList then
      return
    end
    for childIndex, desc in ipairs(descList) do
      local textObj = suitDescUI["Text_Suit_Desc_" .. childIndex]
      if textObj then
        textObj:SetActive(true)
        cb:BindToText(textObj, function()
          return desc
        end, nil, nil, nil)
      end
    end
    for i = #descList + 1, 6 do
      local textObj = suitDescUI["Text_Suit_Desc_" .. i]
      if textObj then
        textObj:SetActive(false)
      end
    end
    cb:BindTimer(0.01, 0, nil, function()
      CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_List)
    end)
  end, function()
    if 0 == self.tid.value then
      return
    end
    local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(self.tid.value)
    local suitId = trinketInfo and trinketInfo[2] or 0
    local activeNum = self.model:GetSuitActiveEffectNum(suitId)
    do return self.model.GetSuitDescData, self.model, suitId, activeNum end
    return self.model.GetSuitDescData, self.model, suitId, activeNum, true
  end)
end

function AwakerTrinketDetailItem:OnBind(binder)
  self:BindEquipedGroup(binder)
  self:BindBaseInfo(binder)
  self:BindSubAttrs(binder)
  self:BindSuitsInfo(binder)
  binder:BindCommonLockPrefab(self.ui.UI_Common_Btn_Lock, UI_Common_Btn_LockResource, function(isOn)
    self.model:ReqItemLock(self.uid.value, isOn)
  end, function()
    do return self.model.GetItemLocked, self.model end
    return self.model.GetItemLocked, self.model, self.uid.value
  end)
  binder:BindToText(self.ui.Text_Equip, function()
    local ownAwaker = self.model:GetOwner(self.uid.value)
    if not ownAwaker or 0 == ownAwaker then
      return ""
    end
    local selectAwakerTid = self.model.awakerModel.selectAwakerId
    if selectAwakerTid and 0 ~= selectAwakerTid then
      local changeFormAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
      if ownAwaker == selectAwakerTid or changeFormAwaker == selectAwakerTid then
        ownAwaker = selectAwakerTid
      end
    elseif not AwakerDataUtils.IsAwakerShow(ownAwaker) then
      ownAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
    end
    local name = AwakerDataUtils.GetAwakerTitle(ownAwaker)
    name = LT.Textf("TipsAwakerEquip", name)
    return name
  end)
  binder:BindToText(self.ui.Text_Story, function()
    do return self.model.GetTrinketStory, self.model end
    return self.model.GetTrinketStory, self.model, self.tid.value
  end)
  binder:BindToRaw(function(cb, show, _)
    if nil == show then
      return
    end
    if show then
      cb:BindTimer(0.01, 0, nil, function()
        CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_List)
      end)
    end
  end, function()
    return self.model.compareMode
  end)
  binder:BindToRaw(function(cb, page)
    if nil == page then
      return
    end
    if page == AwakerPage.TrinketChange then
      cb:BindTimer(0.01, 0, nil, function()
        CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_List)
      end)
    end
  end, function()
    return self.model.awakerModel.page
  end)
end

function AwakerTrinketDetailItem:OnUnbind()
  Super.OnUnbind(self)
end

return AwakerTrinketDetailItem
