local ItemType = CommonDefine.ItemType
local ItemSubType = CommonDefine.ItemSubType
local CS = _ENV.CS
local typeof = _ENV.typeof
local CanvasGroup = CS.UnityEngine.CanvasGroup
local MAX_JUMP_BTN_NUM = 15
local UIAnimationController = CS.Z1Client.UIAnimationController
local CommonItemDetailTipsItem, Super = System.NewComponent("CommonItemDetailTipsItem")

function CommonItemDetailTipsItem:ctor(uiNode, _, model, parentNode, useBagRes, closeCb, lockCb, hideAttr, posY, posX, ignoreCustomInput)
  Logger.Info("CommonItemDetailTipsItem:ctor ", debug.traceback())
  Super.ctor(self)
  if useBagRes then
    self.ui = UI_Bag_Item_DetailResource(uiNode)
  else
    self.ui = UI_Common_Item_DetailResource(uiNode)
  end
  self.model = model
  self.parentNode = parentNode
  self.closeCb = closeCb
  self.lockCb = lockCb
  self.showUiNode = Vue.ref(nil ~= parentNode)
  self.useBagRes = useBagRes
  self.hideAttr = hideAttr
  self.posY = posY
  self.posX = posX
  self.ignoreCustomInput = ignoreCustomInput
end

function CommonItemDetailTipsItem:OnBind(binder)
  GlobalDispatcher:AddListener(NotifyId.OnTrinketUpdategraded, self._OnTrinketUpdategraded, self)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.binder = binder
  self.binder:LoadAllLangFont(self.ui.Text_Normal_Desc)
  self.transform = self.ui.uiNode.transform
  if self.parentNode then
    self.canvasGroup = self.ui.uiNode:GetComponent(typeof(CanvasGroup))
    self.canvasGroup.alpha = 0
  end
  local firstInit = true
  AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_ITEMINFO_ON")
  self:_OnBindKeeperSkillInfo()
  self:_OnBindAttrInfo()
  binder:BindToVisible(self.ui.UI_Common_Btn_Lock, function()
    do return self.model.ShowLockIcon end
    return self.model.ShowLockIcon, self.model
  end)
  binder:BindToVisible(self.ui.Group_Weapon, function()
    return self.model.itemType == ItemType.Weapon
  end)
  binder:BindToVisible(self.ui.Group_Normal, function()
    local itemType = self.model.itemType
    return (itemType ~= ItemType.Trinket or self.model.isPreview) and itemType ~= ItemType.Weapon
  end)
  binder:BindToVisible(self.ui.Image_Possess, function()
    local showOwnTxtTypeGroup = DT.GetOriginalConstant("ItemTipsNum")
    do return table.contains, showOwnTxtTypeGroup end
    return table.contains, showOwnTxtTypeGroup, self.model.itemType
  end)
  binder:BindToVisible(self.ui.Image_PlayerAvatar, function()
    local itemSubType = self.model.itemSubType
    return itemSubType == CommonDefine.ItemSubType.PlayerAvatar or itemSubType == CommonDefine.ItemSubType.AwakerSkin
  end)
  binder:BindToText(self.ui.Text_Possess, function()
    if not self.model.chosenItemData then
      do return LT.Text end
      return LT.Text, "", nil, nil, nil
    end
    local tid = self.model.chosenItemData.tid
    local ownNum = ItemDataUtils.IsPayMoneyType(tid) and ItemDataUtils.GetPayMoneyTotalNum() or ItemDataUtils.GetItemNum(tid)
    do return LT.Textf, "CommonTipsOwnedText" end
    return LT.Textf, "CommonTipsOwnedText", ownNum
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    local iconPath = self.model:GetItemIcon()
    return iconPath or ""
  end)
  local iconLightComp = UICompTrinketIconMat(self.ui.Image_Icon, {binder = binder})
  binder:BindToRaw(function(_, hasBound, _)
    local itemData = self.model.chosenItemData
    local partIndex = itemData and AwakerTrinketDataUtils.GetTrinketLightPartIndex(itemData.tid) or nil
    iconLightComp:EnableLight(true == hasBound, partIndex)
  end, function()
    if self.model.itemType ~= ItemType.Trinket then
      return false
    end
    local itemData = self.model.chosenItemData
    return itemData and AwakerTrinketDataUtils.IsTrinketBoundForLight(itemData.uid) or false
  end)
  self._iconLightComp = iconLightComp
  binder:BindToImage(self.ui.Image_Bg_Quality, function()
    local framePath = self.model:GetItemBgQualityFrame()
    return framePath
  end)
  binder:BindToRaw(function(childBinder, _)
    local boundCheckUid
    if not self.model.isPreview and self.model.chosenItemData then
      boundCheckUid = self.model.chosenItemData.uid
    end
    local bgColor = ItemDataUtils.IsBoundTrinketTips(boundCheckUid) and "#ffffff" or "#000000"
    childBinder:SetImageColorByHtml(self.ui.bg1, bgColor)
  end, function()
    return self.model.chosenItemData
  end)
  binder:BindToImage(self.ui.Image_Title_Quality, function()
    local framePath = self.model:GetItemTitleQualityFrame()
    return framePath
  end)
  binder:BindToText(self.ui.Text_Name, function()
    local name = self.model:GetItemName()
    return name
  end)
  binder:BindToRaw(function(childBinder, _)
    local boundCheckUid
    if not self.model.isPreview and self.model.chosenItemData then
      boundCheckUid = self.model.chosenItemData.uid
    end
    local boundTextColor = ItemDataUtils.IsBoundTrinketTips(boundCheckUid) and "#000000" or "#ffffff"
    childBinder:SetTextColorByHtml(self.ui.Text_Name, boundTextColor)
    childBinder:SetTextColorByHtml(self.ui.Text_Type, boundTextColor)
    childBinder:SetTextColorByHtml(self.ui.Textt_Main_Property_Count, boundTextColor)
    local itemType = self.model.itemType
    if itemType == CommonDefine.ItemType.Weapon then
      return
    elseif itemType == ItemType.Trinket then
      childBinder:SetText(self.ui.Text_Main_Property, "")
      local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.model.chosenUid)
      childBinder:SetText(self.ui.Textt_Main_Property_Count, completRate .. "%")
      return
    end
    childBinder:SetText(self.ui.Text_Main_Property, self.model:GetMainAttrName())
    childBinder:SetText(self.ui.Textt_Main_Property_Count, self.model:GetMainAttrValue())
    local colorStr = "#ffffff"
    childBinder:SetTextColorByHtml(self.ui.Text_Name, colorStr)
    childBinder:SetTextColorByHtml(self.ui.Text_Type, colorStr)
    childBinder:SetTextColorByHtml(self.ui.Text_Possess, colorStr)
  end, function()
    return self.model.chosenItemData
  end)
  binder:BindToText(self.ui.Text_Desc_Sec, function()
    local story = self.model:GetItemStory()
    return story
  end)
  binder:BindToText(self.ui.Text_Type, function()
    local subTypeName = self.model:GetItemSubTypeName()
    return subTypeName
  end)
  if self.ui.Text_C_Time and self.ui.Text_Normal_Time then
    binder:BindToRaw(function(childBinder, endTime)
      if nil == endTime then
        self.ui.Text_C_Time:SetActive(false)
        return
      end
      local isExpiredItem = self.model.chosenItemData and table.contains(CommonDefine.ExpiredItemTidList, self.model.chosenItemData.tid)
      local showText = isExpiredItem and LT.Text("InheritConsumeDrawItemConvertTips") or LT.Text("RemainValidTime")
      childBinder:SetText(self.ui.Text_C_Time, showText)
      self.ui.Text_C_Time:SetActive(true)
      local timeDescHeight = 0
      
      local function tickCall()
        if endTime < TimeUtils.GetServerTime() then
          childBinder:SetText(self.ui.Text_Normal_Time, LT.Text("ActivityTimeExpired"))
          timeDescHeight = StrUtils.GetPreferredHeight(self.ui.Text_Normal_Time)
          return
        end
        local tickStr = TimeUtils.format(endTime - TimeUtils.GetServerTime(), CommonDefine.TimeParseType.dhms)
        childBinder:SetText(self.ui.Text_Normal_Time, tickStr)
        timeDescHeight = StrUtils.GetPreferredHeight(self.ui.Text_Normal_Time)
      end
      
      tickCall()
      StrUtils.SetPreferredHeight(self.ui.Text_C_Time, timeDescHeight)
      childBinder:BindTimer(1, -1, function()
        tickCall()
      end)
    end, function()
      local itemTid = self.model.chosenItemData and self.model.chosenItemData.tid or 0
      do return ItemDataUtils.GetItemEndTimeByTid end
      return ItemDataUtils.GetItemEndTimeByTid, itemTid
    end)
  end
  binder:BindToRaw(function(childBinder, desc)
    childBinder:SetText(self.ui.Text_Normal_Desc, desc)
    StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
  end, function()
    do return self.model.GetItemDesc end
    return self.model.GetItemDesc, self.model
  end)
  binder:BindCommonLockPrefab(self.ui.UI_Common_Btn_Lock, UI_Common_Btn_LockResource, function(isOn)
    self.model:ReqItemLock(isOn, function(lockState)
      if self.lockCb then
        self.lockCb(lockState)
      end
    end)
  end, function()
    do return self.model.GetItemLocked end
    return self.model.GetItemLocked, self.model
  end)
  binder:BindToRaw(function(childBinder, n)
    if not n or 0 == n then
      return
    end
    if firstInit then
      childBinder:SetActive(self.ui.uiNode, false)
      childBinder:SetActive(self.ui.uiNode, true)
      firstInit = false
    end
    self:JumpToUIBinder(childBinder)
    local contentUI = self.ui.Group_Resource.transform.parent.gameObject
    CS.Framework.UIUtilTool.RefreshLayout(contentUI)
  end, function()
    return self.model.chosenUid
  end)
  binder:BindToRaw(function(childBinder, itemData)
    if itemData then
      local itemCfg = ItemDataUtils.GetItemConfig(itemData.tid)
      if itemCfg.Type == CommonDefine.ItemType.Weapon then
        local item = itemData
        local weaponDetailModel = childBinder:createModel(WeaponDetailModel, item)
        weaponDetailModel:SetWeapon(item)
        childBinder:BindToRaw(function(_, attr)
          local uiName = self.ui.Text_Main_Property
          local uiValue = self.ui.Textt_Main_Property_Count
          self:_SetAttr(childBinder, uiName, uiValue, attr)
        end, function()
          do return weaponDetailModel.GetSecondaryAttr end
          return weaponDetailModel.GetSecondaryAttr, weaponDetailModel
        end, nil)
        childBinder:SetActive(self.ui.Text_Weapon_Prim_Attr_Name_1, false)
        childBinder:SetActive(self.ui.Text_Weapon_Prim_Attr_Name_2, false)
        childBinder:SetActive(self.ui.Text_Weapon_Prim_Attr_Name_3, false)
        childBinder:BindToRaw(function(_, refineLevel)
          local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
          local numStars = math.min(refineLevel, refineStage1MaxLevel)
          for i = 1, 3 do
            local obj = self.ui["Star_" .. i]
            if obj then
              childBinder:SetActive(obj, i <= numStars)
            end
          end
          if refineLevel > refineStage1MaxLevel then
            self.ui.Image_Max:SetActive(true)
            childBinder:SetText(self.ui.Text_Max, refineLevel - refineStage1MaxLevel)
          else
            self.ui.Image_Max:SetActive(false)
          end
        end, function()
          do return weaponDetailModel.GetWeaponlevel end
          return weaponDetailModel.GetWeaponlevel, weaponDetailModel
        end)
        if self.ui.Text_WeaponHave then
          childBinder:BindToVisible(self.ui.Text_WeaponHave, function()
            return self.model.showWeaponHave
          end)
          childBinder:BindToText(self.ui.Text_WeaponHave, function()
            if not self.model.showWeaponHave or not itemData then
              return ""
            end
            do return ItemDataUtils.GetWeaponOwnedDisplayText end
            return ItemDataUtils.GetWeaponOwnedDisplayText, itemData.tid
          end)
        end
        childBinder:BindToRaw(function(_, value)
          if "" == value then
            self.ui.Text_Weapon_Desc_1:SetActive(false)
            return
          end
          childBinder:SetText(self.ui.Text_Weapon_Desc_1, value)
          self.ui.Text_Weapon_Desc_1:SetActive(false)
          self.ui.Text_Weapon_Desc_1:SetActive(true)
        end, function()
          do return weaponDetailModel.GetStateDesc end
          return weaponDetailModel.GetStateDesc, weaponDetailModel
        end, nil)
        childBinder:BindToRaw(function(_, value)
          if "" == value then
            self.ui.Text_Weapon_Desc_2:SetActive(false)
            return
          end
          self.ui.Text_Weapon_Desc_2:SetActive(true)
          childBinder:SetText(self.ui.Text_Weapon_Desc_2, value)
        end, function()
          do return weaponDetailModel.GetExclusiveDesc end
          return weaponDetailModel.GetExclusiveDesc, weaponDetailModel
        end, nil)
        childBinder:BindToRaw(function(_, value)
          childBinder:SetActive(self.ui.Text_Desc_Sec, true)
          childBinder:SetText(self.ui.Text_Desc_Sec, value)
        end, function()
          do return weaponDetailModel.GetStory end
          return weaponDetailModel.GetStory, weaponDetailModel
        end)
        self.ui.Group_Weapon:SetActive(false)
        if self.ui then
          self.ui.Group_Weapon:SetActive(true)
          local contentUI = self.ui.Group_Weapon
          CS.Framework.UIUtilTool.RefreshLayout(contentUI)
        end
      end
    end
  end, function()
    return self.model.chosenItemData
  end, nil)
  binder:BindToVisible(self.ui.Group_Prop, function()
    return self.model.itemType == ItemType.Trinket and not self.model.isPreview
  end)
  binder:BindToText(self.ui.Text_Prop_Add, function()
    if self.model.itemType ~= ItemType.Trinket then
      return ""
    end
    local level = self.model:GetItemLevel() or 0
    do return string.format, "+%s" end
    return string.format, "+%s", level
  end)
  local objTrinketMainAttr = self.ui.Prop_1
  binder:BindToVisible(objTrinketMainAttr, function()
    if self.model.itemType ~= ItemType.Trinket then
      return false
    end
    local mainAttr = self.model:GetMainAttr()
    return nil ~= mainAttr
  end)
  binder:BindToRaw(function(childBinder, mainAttr, _)
    if not mainAttr then
      return
    end
    local attr = mainAttr
    if objTrinketMainAttr then
      local showAttr
      if attr and attr.tid and attr.count then
        local attrType = DT.ActorAttrType[attr.tid]
        showAttr = {
          textCount = AwakerTrinketDataUtils.GetAttrFmtString(attr),
          imageIcon = attrType.Icon,
          textName = LT.Text(attrType.Text)
        }
      end
      local itemData = {
        showAttr = showAttr,
        clientAttr = attr,
        level = "+" .. self.model:GetItemLevel(),
        resourceCls = UI_Awaker_Item_EntryResource,
        useDefaultIcon = true,
        useOriginDemical = true
      }
      childBinder:BindComponent(AwakerAttrItem(objTrinketMainAttr, itemData))
    end
  end, function()
    if self.model.itemType == ItemType.Trinket then
      do return self.model.GetMainAttr end
      return self.model.GetMainAttr, self.model
    end
    return nil
  end)
  for i = 2, 4 do
    local obj = self.ui["Prop_" .. i]
    if obj then
      binder:BindToVisible(obj, function()
        local data = self.model.chosenItemData
        if not data then
          return false
        end
        local subAttrNums = data.attrs and #data.attrs - 1 or 0
        if subAttrNums < 0 then
          subAttrNums = 0
        end
        return subAttrNums >= i - 1
      end)
    end
  end
  binder:BindToRaw(function(cb, subAttrs, _)
    if nil == subAttrs then
      return
    end
    for i = 2, 4 do
      local obj = self.ui["Prop_" .. i]
      local attr = subAttrs[i - 1]
      if obj then
        local showAttr
        if attr then
          local attrType = DT.ActorAttrType[attr.tid]
          showAttr = {
            textCount = AwakerTrinketDataUtils.GetAttrFmtStringWithMax(attr, 26),
            imageIcon = attrType.Icon,
            textName = LT.Text(attrType.Text)
          }
        end
        local itemData = {
          showAttr = showAttr,
          clientAttr = attr,
          resourceCls = UI_Awaker_Item_EntryResource,
          useDefaultIcon = true,
          useOriginDemical = true
        }
        cb:BindComponent(AwakerAttrItem(obj, itemData))
      end
    end
    local contentUI = self.ui.Group_Prop.transform.parent.gameObject
    CS.Framework.UIUtilTool.RefreshLayout(contentUI)
  end, function()
    if self.model.isPreview then
      return {}
    end
    local data = self.model.chosenItemData
    if not data then
      return {}
    end
    local subAttrs = {}
    if data.attrs then
      for _, attr in pairs(data.attrs) do
        if not attr or 1 == attr.index then
        else
          local subAttr = AwakerTrinketDataUtils.TrinketAttrToClientAttr(attr)
          table.insert(subAttrs, subAttr)
        end
      end
    end
    return subAttrs
  end)
  if self.ui.Group_AvatarInfo then
    binder:BindToVisible(self.ui.Group_AvatarInfo, function()
      local itemSubType = self.model.itemSubType
      return CommonDefine.ShowAvatarPreviewType[itemSubType]
    end)
    binder:BindButtonClick(self.ui.Btn_AvatarClick, function()
      UIManager.Instance:SetTempPanelLayer(Urls.UI_Bag_Panel_AppearancePreview, UIDefine.LayerCfg.TipPopRoot.name)
      UIManager.Instance:Reopen(Urls.UI_Bag_Panel_AppearancePreview, self.model.chosenItemData.tid)
    end)
  end
  local suitDescUI = UI_Awaker_Item_Trinket_SuitdescResource(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
  binder:BindToVisible(suitDescUI.uiNode, function()
    local itemType = self.model.itemType
    local itemSubType = self.model.itemSubType
    local isTrinket = itemType == ItemType.Trinket
    local isTrinketDropItem = itemType == ItemType.DropItem and itemSubType == ItemSubType.TrinketDropItem
    return isTrinket or isTrinketDropItem
  end)
  binder:BindToText(suitDescUI.Text_Suit_Name, function()
    local data = self.model.chosenItemData
    if not data then
      return ""
    end
    local suitId = data.suitId
    local itemType = self.model.itemType
    local itemSubType = self.model.itemSubType
    local isTrinketDropItem = itemType == ItemType.DropItem and itemSubType == ItemSubType.TrinketDropItem
    if self.model.isPreview and self.model.itemType == ItemType.Trinket then
      local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(self.model.chosenItemData.tid)
      suitId = trinketInfo and trinketInfo[2]
    elseif isTrinketDropItem then
      suitId = ItemDataUtils.GetTrinketDropItemSuit(self.model.chosenItemData.tid)
    end
    local descData = AwakerTrinketDataUtils.GetSuitDescData(suitId, 0, false, false)
    return descData and descData.suitEffectTitle or ""
  end)
  for i = 1, 3 do
    local textDescObj = suitDescUI["Text_Suit_Desc_" .. i]
    if not textDescObj then
    else
      binder:BindToText(textDescObj, function()
        textDescObj:SetActive(true)
        local data = self.model.chosenItemData
        if not data then
          textDescObj:SetActive(false)
          return ""
        end
        local suitId = data.suitId
        local itemType = self.model.itemType
        local itemSubType = self.model.itemSubType
        local isTrinketDropItem = itemType == ItemType.DropItem and itemSubType == ItemSubType.TrinketDropItem
        if self.model.isPreview and self.model.itemType == ItemType.Trinket then
          local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(self.model.chosenItemData.tid)
          suitId = trinketInfo and trinketInfo[2]
        elseif isTrinketDropItem then
          suitId = ItemDataUtils.GetTrinketDropItemSuit(self.model.chosenItemData.tid)
        end
        local descData = AwakerTrinketDataUtils.GetSuitDescData(suitId, 0)
        if not descData or not descData.effectDescList then
          textDescObj:SetActive(false)
          return ""
        end
        local descList = descData.effectDescList
        local desc = descList[i]
        if nil == desc or "" == desc then
          textDescObj:SetActive(false)
        end
        StrUtils.SetPreferredHeight(textDescObj, 30)
        return desc
      end)
    end
  end
  self.adjustPosTimer = binder:BindTimer(0.1, 0, nil, function()
    if self.parentNode then
      self:AdjustPosition()
      self.canvasGroup.alpha = 1
    end
  end)
  local descTmp = self.ui.Text_Desc_Sec:GetComponent(typeof(CS.TMPro.TMP_Text))
  local weaponDescTmp = self.ui.Text_Weapon_Desc_1:GetComponent(typeof(CS.TMPro.TMP_Text))
  local weaponDescTmp2 = self.ui.Text_Weapon_Desc_2:GetComponent(typeof(CS.TMPro.TMP_Text))
  local normalDescTmp = self.ui.Text_Normal_Desc:GetComponent(typeof(CS.TMPro.TMP_Text))
  local descLineCount = 0
  local weaponDescLineCount = 0
  local normalDesLineCount = 0
  binder:BindToRaw(function(childBinder, _, _)
    local contentUI = self.ui.Group_Prop.transform.parent.gameObject
    CS.Framework.UIUtilTool.RefreshLayout(contentUI)
  end, function()
    return self.model.chosenItemData
  end)
  binder:BindTimer(0.1, 0, nil, function()
    StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
    StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_1, 0)
    StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_2, 0)
    StrUtils.SetPreferredHeight(self.ui.Text_Normal_Desc, 0)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Normal)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Weapon)
    for i = 1, 3 do
      local textDescObj = suitDescUI["Text_Suit_Desc_" .. i]
      if not textDescObj then
      else
        StrUtils.SetPreferredHeight(textDescObj)
      end
    end
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(suitDescUI.Group_Suit)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Prop)
    if descTmp.textInfo then
      descLineCount = descTmp.textInfo.lineCount or 0
    end
    if weaponDescTmp.textInfo then
      weaponDescLineCount = weaponDescTmp.textInfo.lineCount or 0
    end
    if normalDescTmp.textInfo then
      normalDesLineCount = normalDescTmp.textInfo.lineCount or 0
    end
  end)
  binder:BindTimer(0.4, 0, nil, function()
    local isReLayout = false
    if descTmp.textInfo and descLineCount < descTmp.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
      isReLayout = true
    end
    if weaponDescTmp.textInfo and weaponDescLineCount < weaponDescTmp.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_1, 0)
      isReLayout = true
    end
    if weaponDescTmp2.textInfo and weaponDescTmp2.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_2, 0)
      isReLayout = true
    end
    if normalDescTmp.textInfo and normalDesLineCount < normalDescTmp.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Normal_Desc, 0)
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Normal)
    end
    if isReLayout then
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Weapon)
    end
  end)
  binder:onDestroy(function()
    AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_ITEMINFO_OFF")
  end)
  if self.parentNode then
    UIBackCommandStack.Push({
      uiPanel = tostring(self),
      Execute = function()
        self:OnMaskClicked()
      end
    })
  end
  if not self.ignoreCustomInput then
    local scrollView = self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
    local contentGo = scrollView and scrollView.content and scrollView.content.gameObject
    binder:BindUICustomInput(contentGo or self.ui.uiNode, function(hover)
      if UIManager.Instance:GetWindow(Urls.CommonCardKeyWorldDescPanel) then
        return
      end
      if not hover then
        self:OnMaskClicked()
      end
    end)
  end
end

function CommonItemDetailTipsItem:_SetAttr(binder, uiName, uiValue, attr)
  if attr.id then
    local attrConfig = DT.ActorAttrType[attr.id]
    local name = LT.Text(attrConfig.Text)
    local value = ItemDataUtils.RemoveDotZero(attr.value)
    value = attrConfig.Percentage and value .. "%" or value
    binder:SetText(uiName, name)
    binder:SetText(uiValue, value)
  else
    binder:SetText(uiName, "")
    binder:SetText(uiValue, "")
  end
end

function CommonItemDetailTipsItem:AdjustPosition()
  self._posAjusted = true
  self.binder:StopTimer(self.adjustPosTimer)
  UIUtils.AdjustTipsPosition(self.ui.uiNode, self.parentNode, self.posY, self.posX)
  if self.uiAnimController then
    self.uiAnimController:PlayState("UI_Common_Item_Detail_Open")
  end
end

function CommonItemDetailTipsItem:OnMaskClicked()
  EventMgr.Instance.CommonTipsCloseEvent:Dispatch()
  
  local function callBack()
    if self.model.isPreview then
      self.model:SetIsPreview(false)
    end
    if self.closeCb then
      self.closeCb()
    end
    self.binder:teardown()
  end
  
  if self._posAjusted and self.uiAnimController then
    self.uiAnimController:StopPlayableGraph()
    self.uiAnimController:PlayState("UI_Common_Item_Detail_Close", callBack)
  else
    callBack()
  end
end

function CommonItemDetailTipsItem:JumpToUIBinder(binder)
  local getsList = self.model:GetItemGets()
  binder:BindToVisible(self.ui.Image_Resource, function()
    return #getsList > 0
  end)
  binder:BindToVisible(self.ui.Group_Resource, function()
    return #getsList > 0
  end)
  local groupTf = self.ui.Group_Resource.transform
  local childCount = groupTf.childCount
  for i = 1, MAX_JUMP_BTN_NUM do
    local childTf = i <= childCount and groupTf:GetChild(i - 1)
    local gameObj = childTf and childTf.gameObject
    local getsId = getsList[i]
    if getsId then
      local itemData = {
        itemGetsId = getsId,
        clickCb = function()
          if self.parentNode then
            self:OnMaskClicked()
          end
        end,
        itemTid = self:GetJumpItemTid(),
        justShow = FuncJumpManager:IsJustShow(getsId)
      }
      gameObj = gameObj or binder:Instantiate(self.ui.UI_Common_Item_Exchange_1, groupTf)
      binder:BindComponent(CommonApproachItem(gameObj, itemData))
      binder:SetActive(gameObj, true)
    elseif not IsNil(gameObj) then
      binder:SetActive(gameObj, false)
    end
  end
end

function CommonItemDetailTipsItem:_OnBindKeeperSkillInfo()
  self.binder:BindToVisible(self.ui.Group_KeeperSkill, function()
    return self.model.itemType == ItemType.KeeperSkill
  end)
  self.binder:BindToText(self.ui.Text_KeeperSkill_Desc, function()
    if self.model.itemType ~= ItemType.KeeperSkill then
      return ""
    end
    if not (self.model.chosenItemData and self.model.chosenItemData.tid) or 0 == self.model.chosenItemData.tid then
      return ""
    end
    local tid = self.model.chosenItemData.tid
    do return LT.Text, KeeperSkillUtils.GetKeeperSkillDesc(tid) end
    return LT.Text, KeeperSkillUtils.GetKeeperSkillDesc(tid)
  end)
  StrUtils.SetPreferredHeight(self.ui.Text_KeeperSkill_Desc, 0)
end

function CommonItemDetailTipsItem:_OnBindAttrInfo()
  self.ui.Text_Main_Property:SetActive(not self.hideAttr)
  self.ui.Textt_Main_Property_Count:SetActive(not self.hideAttr)
end

function CommonItemDetailTipsItem:GetJumpItemTid()
  local rst
  if self.model.chosenItemData then
    rst = self.model.chosenItemData.tid
  end
  if not rst then
    return rst
  end
  local itemCfg = DT.Item[rst]
  if itemCfg and itemCfg.DropItemGets then
    rst = itemCfg.DropItemGets
  end
  return rst
end

function CommonItemDetailTipsItem:OnUnbind()
  GlobalDispatcher:RemoveListener(NotifyId.OnTrinketUpdategraded, self._OnTrinketUpdategraded, self)
  if self._iconLightComp then
    self._iconLightComp:OnExitComponent()
    self._iconLightComp = nil
  end
  Super.OnUnbind(self)
  CommonItemDetailTipsItem.Instance = nil
  UIBackCommandStack.Remove(tostring(self))
end

function CommonItemDetailTipsItem:_OnTrinketUpdategraded(targetUid)
  if self.model and self.model.chosenUid == targetUid then
    local itemType = self.model.itemType
    if itemType == ItemType.Trinket then
      local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.model.chosenUid)
      self.binder:SetText(self.ui.Textt_Main_Property_Count, completRate .. "%")
    end
  end
end

return CommonItemDetailTipsItem
