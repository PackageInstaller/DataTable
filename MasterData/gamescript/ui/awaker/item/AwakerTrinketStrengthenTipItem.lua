local ItemType = CommonDefine.ItemType
local AwakerTrinketStrengthenTipItem, Super = System.NewComponent("AwakerTrinketStrengthenTipItem")

function AwakerTrinketStrengthenTipItem:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_TipResource(uiNode)
  self.model = model
end

function AwakerTrinketStrengthenTipItem:OnBind(binder)
  local model = self.model
  local trinketModel = model.trinketModel
  
  local function CheckIdValid(id)
    if not id or 0 == id then
      return false
    end
    return true
  end
  
  binder:BindCommonLockPrefab(self.ui.UI_Common_Btn_Lock, UI_Common_Btn_LockResource, function(isOn)
    trinketModel:ReqItemLock(model.showTipUid, isOn)
    if isOn then
      local chosenData = model:GetChosenMaterialData(model.showTipUid)
      if nil ~= chosenData then
        model:ChooseMaterial(model.showTipUid, -1 * chosenData.num)
      end
    end
  end, function()
    do return trinketModel.GetItemLocked, trinketModel end
    return trinketModel.GetItemLocked, trinketModel, model.showTipUid
  end)
  binder:BindToText(self.ui.Text_Name, function()
    if not CheckIdValid(model.showTipTid) then
      return
    end
    local name = trinketModel:GetTrinketName(model.showTipTid)
    return name
  end)
  binder:BindToText(self.ui.Text_Type, function()
    if not CheckIdValid(model.showTipTid) then
      return
    end
    local subTypeName = trinketModel:GetItemSubTypeName(model.showTipTid)
    return subTypeName
  end)
  binder:BindToText(self.ui.Text_Weapon_Level, function()
    local level = trinketModel:GetLevel() or 0
    do return LT.Textf, "TipsRefineLevel" end
    return LT.Textf, "TipsRefineLevel", level
  end)
  binder:BindToVisible(self.ui.Group_Stars, function()
    if not model.showTipTid or 0 == model.showTipTid then
      return false
    end
    local itemType = model:GetItemType(model.showTipTid)
    return itemType == ItemType.Weapon
  end)
  for i = 1, 5 do
    local obj = self.ui["Star_" .. i]
    if obj then
      binder:BindToVisible(obj, function()
        if not model.showTipTid or 0 == model.showTipTid then
          return false
        end
        local itemType = model:GetItemType(model.showTipTid)
        if itemType ~= ItemType.Weapon then
          return false
        end
        local level = trinketModel:GetLevel() or 0
        return level >= i
      end)
    end
  end
  for i = 1, 2 do
    local obj = self.ui["Text_Weapon_Desc_" .. i]
    if obj then
      binder:BindToText(obj, function()
        local uid = model.showTipUid
        if 0 == uid then
          return ""
        end
        local descList = model:GetWeaponDescList(uid)
        local desc = descList[i]
        return desc or ""
      end)
      binder:BindToVisible(obj, function()
        local uid = model.showTipUid
        if 0 == uid then
          return false
        end
        local descList = model:GetWeaponDescList(uid)
        local desc = descList[i]
        return nil ~= desc
      end)
    end
  end
  binder:BindToText(self.ui.Text_Story, function()
    if not model.showTipTid or 0 == model.showTipTid then
      return ""
    end
    local itemType = model:GetItemType(model.showTipTid)
    if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
      return ""
    end
    return model:GetItemStory(model.showTipTid) or ""
  end)
  binder:BindToRaw(function(childBinder, n)
    if not n then
      return
    end
    for i = 1, 5 do
      local obj = self.ui["Star_" .. i]
      if obj then
        childBinder:SetActive(obj, i <= n)
      end
    end
  end, function()
    local level = trinketModel:GetLevel()
    return level or 0
  end)
  binder:BindToText(self.ui.Text_Prop_Add, function()
    if not CheckIdValid(model.showTipUid) then
      return
    end
    local level = trinketModel:GetLevel(model.showTipUid)
    do return string.format, "+%s" end
    return string.format, "+%s", level
  end)
  binder:BindToText(self.ui.Text_Main_Property, function()
    if not CheckIdValid(model.showTipUid) then
      return
    end
    local itemData = model:GetItemData(model.showTipUid)
    if not itemData then
      return ""
    end
    if model:GetItemType(itemData.tid) == ItemType.Weapon then
      return ItemDataUtils.GetWeaponAttrName(itemData.tid) or ""
    end
    local mainAttr = trinketModel:GetMainAttr(model.showTipUid)
    return mainAttr.name
  end)
  binder:BindToText(self.ui.Textt_Main_Property_Count, function()
    if not CheckIdValid(model.showTipUid) then
      return
    end
    local itemData = model:GetItemData(model.showTipUid)
    if not itemData then
      return ""
    end
    if model:GetItemType(itemData.tid) == ItemType.Weapon then
      return ItemDataUtils.GetWeaponAttrValue(itemData.tid) or 0
    end
    local mainAttr = trinketModel:GetMainAttr(model.showTipUid)
    local value = mainAttr.count
    if mainAttr.isPercent then
      value = value .. "%"
    end
    return value
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    if not CheckIdValid(model.showTipTid) then
      return
    end
    do return trinketModel.GetTrinketIcon, trinketModel end
    return trinketModel.GetTrinketIcon, trinketModel, model.showTipTid
  end)
  local iconLightComp = UICompTrinketIconMat(self.ui.Image_Icon, {binder = binder})
  binder:BindToRaw(function(_, hasBound, _)
    local partIndex = CheckIdValid(model.showTipTid) and AwakerTrinketDataUtils.GetTrinketLightPartIndex(model.showTipTid) or nil
    iconLightComp:EnableLight(true == hasBound, partIndex)
  end, function()
    if not CheckIdValid(model.showTipUid) then
      return false
    end
    local itemData = model:GetItemData(model.showTipUid)
    if not itemData or model:GetItemType(itemData.tid) ~= ItemType.Trinket then
      return false
    end
    do return AwakerTrinketDataUtils.IsTrinketBoundForLight end
    return AwakerTrinketDataUtils.IsTrinketBoundForLight, model.showTipUid, itemData.tid
  end)
  self._iconLightComp = iconLightComp
  binder:BindToImage(self.ui.Image_Bg_Quality, function()
    if not CheckIdValid(model.showTipTid) then
      return
    end
    local framePath = ItemDataUtils.GetBgQualityFramePath(model.showTipTid, model.showTipUid)
    return framePath
  end)
  binder:BindToImage(self.ui.Image_Title_Quality, function()
    if not CheckIdValid(model.showTipTid) then
      return
    end
    local framePath = ItemDataUtils.GetTitleQualityFramePath(model.showTipTid, model.showTipUid)
    return framePath
  end)
  binder:BindToRaw(function(childBinder, isBound, _)
    local textColor = isBound and "#000000" or "#ffffff"
    childBinder:SetTextColorByHtml(self.ui.Text_Name, textColor)
    childBinder:SetTextColorByHtml(self.ui.Text_Type, textColor)
    childBinder:SetTextColorByHtml(self.ui.Textt_Main_Property_Count, textColor)
  end, function()
    if not CheckIdValid(model.showTipTid) or not CheckIdValid(model.showTipUid) then
      return false
    end
    do return ItemDataUtils.IsBoundTrinketTips end
    return ItemDataUtils.IsBoundTrinketTips, model.showTipUid
  end)
  for i = 1, 5 do
    local obj = self.ui["Prop_" .. i]
    if obj then
      binder:BindToVisible(obj, function()
        if not CheckIdValid(model.showTipUid) then
          return
        end
        local subAttr = trinketModel:GetSubAttrs(model.showTipUid)
        return subAttr and #subAttr >= i
      end)
    end
  end
  binder:BindToRaw(function(cb, subAttrs)
    if not subAttrs then
      return
    end
    for i = 1, 5 do
      local obj = self.ui["Prop_" .. i]
      local attr = subAttrs[i]
      if obj then
        local itemData = {
          clientAttr = attr,
          resourceCls = UI_Awaker_Item_EntryResource,
          useDefaultIcon = true
        }
        cb:BindComponent(AwakerAttrItem(obj, itemData))
      end
    end
  end, function()
    if not CheckIdValid(model.showTipUid) then
      return {}
    end
    local data = trinketModel:GetSubAttrs(model.showTipUid)
    return data
  end)
  binder:BindToVisible(self.ui.Group_Weapon, function()
    if not model.showTipTid or 0 == model.showTipTid then
      return false
    end
    local itemType = model:GetItemType(model.showTipTid)
    return itemType == ItemType.Weapon
  end)
  binder:BindToVisible(self.ui.Group_Prop, function()
    if not model.showTipTid or 0 == model.showTipTid then
      return false
    end
    local itemType = model:GetItemType(model.showTipTid)
    return itemType == ItemType.Trinket
  end)
  local suitDescUI = UI_Awaker_Item_Trinket_SuitdescResource(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
  binder:BindToVisible(suitDescUI.uiNode, function()
    if not model.showTipTid or 0 == model.showTipTid then
      return false
    end
    local itemType = model:GetItemType(model.showTipTid)
    return itemType == ItemType.Trinket
  end)
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
        cb:BindToText(textObj, function()
          return desc
        end, nil, nil, nil)
      end
    end
    cb:BindTimer(0.01, 0, nil, function()
      CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_Tip_List)
    end)
  end, function()
    if 0 == model.showTipTid then
      return
    end
    local itemType = model:GetItemType(model.showTipTid)
    if itemType ~= ItemType.Trinket then
      return {}
    end
    local activeNum = trinketModel:GetSuitActiveEffectNum(model.showTipTid)
    local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(model.showTipTid)
    local suitId = trinketInfo and trinketInfo[2] or 0
    do return trinketModel.GetSuitDescData, trinketModel, suitId end
    return trinketModel.GetSuitDescData, trinketModel, suitId, activeNum
  end)
end

function AwakerTrinketStrengthenTipItem:OnUnbind()
  if self._iconLightComp then
    self._iconLightComp:OnExitComponent()
    self._iconLightComp = nil
  end
  Super.OnUnbind(self)
end

return AwakerTrinketStrengthenTipItem
