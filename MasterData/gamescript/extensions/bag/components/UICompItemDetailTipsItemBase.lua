local ItemType = CommonDefine.ItemType
local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local MAX_JUMP_BTN_NUM = 15
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local UICompItemDetailTipsItemBase, Super = NewViewComponent("UICompItemDetailTipsItemBase")

function UICompItemDetailTipsItemBase:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnBagItemDetailChanged, self._OnBagItemDetailChanged, self)
  self:RegisterNotify(NotifyId.OnTrinketUpdategraded, self._OnTrinketUpdategraded, self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
end

function UICompItemDetailTipsItemBase:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_AvatarClick, function()
    UIManager.Instance:SetTempPanelLayer(Urls.UI_Bag_Panel_AppearancePreview, UIDefine.LayerCfg.TipPopRoot.name)
    ItemDataUtils.OnClickBoxItemShow(self.itemData.tid)
  end)
end

function UICompItemDetailTipsItemBase:OnExitComponent()
  self:_ClearTimer()
  if self._frameWaiter then
    FrameWaiter.RemoveWaiter(self._frameWaiter)
    self._frameWaiter = nil
  end
  Super.OnExitComponent(self)
end

function UICompItemDetailTipsItemBase:Refresh()
  self.itemData = self:_GetItemData()
  if not self.itemData then
    self.ui.uiNode:SetActive(false)
    return
  end
  local config = DT.Item[self.itemData.tid]
  local itemType = config and config.Type or nil
  self.itemConfig = config
  self.itemType = itemType
  self.showDetailPreview = false
  if self.ui.Image_Exhibit then
    self.ui.Image_Exhibit:SetActive(true)
  end
  self:_RefreshBase()
  self:_RefreshIconBoundLight()
  self:_RefreshWeaponInfo()
  self:_RefreshKeeperSkillInfo()
  self:_RefreshTrinket()
  self:_RefreshCommonMaterials()
  self:_RefreshJumpers()
  self:_RefreshCountDownInfo()
  self:_RefreshExpiredTime()
  self:_RefreshAvatarInfo()
  self:SetContrast(nil)
  self.lockCompent:RefreshItemDetailLockStates(self.itemData.uid)
  local showOwnTxtTypeGroup = DT.GetOriginalConstant("ItemTipsNum")
  self.ui.Image_Possess:SetActive(table.contains(showOwnTxtTypeGroup, itemType))
  self.ui.uiNode:SetActive(true)
  self:_RefreshTextHeight()
  self:RefreshLayout()
end

function UICompItemDetailTipsItemBase:SetContrast(contrast)
  if not self.ui.Btn_Contrast then
    return
  end
  if not contrast then
    self.ui.Btn_Contrast:SetActive(false)
    return
  end
  local contrasting = contrast.contrasting
  self:_RefreshContrastStatus(contrasting)
  self:AddButtonClickListener(self.ui.Btn_Contrast_Click, function()
    contrasting = not contrasting
    self:_RefreshContrastStatus(contrasting)
    if contrast.callback then
      contrast.callback(contrasting)
    end
  end)
end

function UICompItemDetailTipsItemBase:_RefreshContrastStatus(contrasting)
  self.ui.Btn_Contrast:SetActive(not contrasting)
  if contrasting then
    self:SetText(self.ui.Btn_Contrast_Text, LT.Text("TrinketStow"))
  else
    self:SetText(self.ui.Btn_Contrast_Text, LT.Text("TrinketContrast"))
  end
end

function UICompItemDetailTipsItemBase:SetBeingEquiped(equiping)
  if self.ui.Btn_Equipped then
    if equiping then
      self.ui.Image_Exhibit:SetActive(true)
    end
    self.ui.Btn_Equipped:SetActive(equiping)
    self:SetText(self.ui.Text_C_Equipped, LT.Text("ItemEquipping"))
  end
end

function UICompItemDetailTipsItemBase:RefreshLayout()
  local contentUI = self.ui.Group_Prop.transform.parent.gameObject
  if self.refreshLayoutImmediate then
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(contentUI)
    return
  end
  self.ui.uiNode:SetActive(false)
  CS.Framework.TransformUtil.SetAnchoredPos(contentUI.transform.parent, 0, -99999)
  self._frameWaiter = FrameWaiter.OnNextFrame(function()
    self._frameWaiter = nil
    self.ui.uiNode:SetActive(true)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(contentUI)
    CS.Framework.TransformUtil.SetAnchoredPos(contentUI.transform.parent, 0, 0)
  end, 2)
end

function UICompItemDetailTipsItemBase:_RefreshKeeperSkillInfo()
  if self.itemType ~= ItemType.KeeperSkill then
    self.ui.Group_KeeperSkill:SetActive(false)
    return
  end
  self.ui.Group_KeeperSkill:SetActive(true)
  local tid = self.itemData.tid
  local desc1 = ItemDataUtils.GetKeeperSkillDesc(tid)
  if "" == desc1 then
    self.ui.Text_KeeperSkill_Desc:SetActive(false)
  else
    self.ui.Text_KeeperSkill_Desc:SetActive(true)
    self.view:SetText(self.ui.Text_KeeperSkill_Desc, desc1)
  end
  local desc2 = ItemDataUtils.GetKeeperSkillStoryDesc(tid)
  if "" == desc2 then
    self.ui.Text_KeeperSkill_Desc:SetActive(false)
  else
    self.ui.Text_KeeperSkill_Desc:SetActive(true)
    self.view:SetText(self.ui.Text_KeeperSkill_Desc, desc2)
  end
  StrUtils.SetPreferredHeight(self.ui.Text_KeeperSkill_Desc, 0)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_KeeperSkill)
end

function UICompItemDetailTipsItemBase:_RefreshWeaponInfo()
  if self.itemType ~= ItemType.Weapon then
    self.ui.Group_Weapon:SetActive(false)
    self.ui.Text_Main_Property:SetActive(false)
    return
  end
  self.ui.Group_Prop:SetActive(false)
  self.ui.Text_Main_Property:SetActive(true)
  self.ui.Group_Weapon:SetActive(true)
  self.view:SetText(self.ui.Text_Prop_Add, "")
  self.ui.UI_Awaker_Item_Trinket_Suitdesc:SetActive(false)
  self.ui.Text_Weapon_Prim_Attr_Name_1:SetActive(false)
  self.ui.Text_Weapon_Prim_Attr_Name_2:SetActive(false)
  self.ui.Text_Weapon_Prim_Attr_Name_3:SetActive(false)
  local secAttr = ItemDataUtils.GetWeaponSecAttr(self.itemData)
  self:_SetAttr(self.ui.Text_Main_Property, self.ui.Textt_Main_Property_Count, secAttr)
  local refineLevel = self.itemData and (self.itemData.level or 0) or 0
  local numStars = math.min(refineLevel, RefineStage1MaxLevel)
  for i = 1, 3 do
    local obj = self.ui["Star_" .. i]
    if obj then
      obj:SetActive(i <= numStars)
    end
  end
  if refineLevel > RefineStage1MaxLevel then
    self.ui.Image_Max:SetActive(true)
    self.view:SetText(self.ui.Text_Max, refineLevel - RefineStage1MaxLevel)
  else
    self.ui.Image_Max:SetActive(false)
  end
  local desc1 = SkillUtils.GetWeaponStateDesc(self.itemData.tid, self.itemData.level)
  if "" == desc1 then
    self.ui.Text_Weapon_Desc_1:SetActive(false)
  else
    self.view:SetText(self.ui.Text_Weapon_Desc_1, desc1)
    self.ui.Text_Weapon_Desc_1:SetActive(false)
    self.ui.Text_Weapon_Desc_1:SetActive(true)
  end
  local desc2 = BagItemDetailsModel:GetWeaponExclusiveDesc(self.itemData)
  if "" == desc2 then
    self.ui.Text_Weapon_Desc_2:SetActive(false)
  else
    self.ui.Text_Weapon_Desc_2:SetActive(true)
    self.view:SetText(self.ui.Text_Weapon_Desc_2, desc2)
  end
  if string.isempty(self.itemConfig.StoryDesc) then
    self.ui.Text_Desc_Sec:SetActive(false)
  else
    self.ui.Text_Desc_Sec:SetActive(true)
    self.view:SetText(self.ui.Text_Desc_Sec, self.itemConfig.StoryDesc)
  end
  StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_1, 0)
  StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
  StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_2, 0)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Weapon)
end

function UICompItemDetailTipsItemBase:_RefreshCountDownInfo()
  if not self.ui.Text_C_Time or not self.ui.Text_Normal_Time then
    return
  end
  local endTime = ItemDataUtils.GetItemEndTimeByTid(self.itemData.tid)
  if not endTime or 0 == endTime then
    self.ui.Text_C_Time:SetActive(false)
    return
  end
  local isExpiredItem = table.contains(CommonDefine.ExpiredItemTidList, self.itemData.tid)
  local showText = isExpiredItem and LT.Text("InheritConsumeDrawItemConvertTips") or LT.Text("RemainValidTime")
  self:SetText(self.ui.Text_C_Time, showText)
  self.ui.Text_C_Time:SetActive(true)
  local timeDescHeight = 0
  
  local function tickCall()
    if endTime < TimeUtils.GetServerTime() then
      self:SetText(self.ui.Text_Normal_Time, LT.Text("ActivityTimeExpired"))
      timeDescHeight = StrUtils.GetPreferredHeight(self.ui.Text_Normal_Time)
      return
    end
    local tickStr = TimeUtils.format(endTime - TimeUtils.GetServerTime(), CommonDefine.TimeParseType.dhms)
    self:SetText(self.ui.Text_Normal_Time, tickStr)
    timeDescHeight = StrUtils.GetPreferredHeight(self.ui.Text_Normal_Time)
  end
  
  tickCall()
  self:_ClearTimer()
  StrUtils.SetPreferredHeight(self.ui.Text_C_Time, timeDescHeight)
  self.timer = self:BindTimer(1, -1, function()
    tickCall()
  end)
end

local filterSubTypeList = {
  cd.ItemSubType.SkinVoucher
}

function UICompItemDetailTipsItemBase:_RefreshExpiredTime()
  if not self.ui.Text_C_Time or not self.ui.Text_Normal_Time then
    return
  end
  if not self.itemConfig then
    return
  end
  if self.itemConfig.SubType == CommonDefine.ItemSubType.BackTrack then
    return
  end
  if not table.contains(filterSubTypeList, self.itemConfig.SubType) then
    return
  end
  local expiredTime = ItemDataUtils.GetExpiredItemByUid(self.itemData.uid)
  if not expiredTime then
    self.ui.Text_C_Time:SetActive(false)
    return
  end
  self.ui.Text_C_Time:SetActive(true)
  
  local function tickCall()
    if expiredTime < TimeUtils.GetServerTime() then
      self:SetText(self.ui.Text_Normal_Time, LT.Text("ActivityTimeExpired"))
      return
    end
    local tickStr = TimeUtils.format(expiredTime - TimeUtils.GetServerTime(), CommonDefine.TimeParseType.dhms)
    self:SetText(self.ui.Text_Normal_Time, tickStr)
  end
  
  tickCall()
  self:_ClearTimer()
  self.timer = self:BindTimer(1, -1, function()
    tickCall()
  end)
end

function UICompItemDetailTipsItemBase:_RefreshAvatarInfo()
  self.showDetailPreview = false
  local itemTypeShowText
  local itemSubType = ItemDataUtils.GetItemSubType(self.itemData.tid)
  if itemSubType == cd.ItemSubType.CosmeticsRandChest or itemSubType == cd.ItemSubType.CosmeticsChest then
    self.showDetailPreview = true
    itemTypeShowText = "ItemType_HeadAndEmoji"
  elseif itemSubType == cd.ItemSubType.WeaponChest or itemSubType == cd.ItemSubType.WeaponRandomChest then
    self.showDetailPreview = true
    itemTypeShowText = "ItemType_Weapon"
  elseif itemSubType == cd.ItemSubType.AwakerChest or itemSubType == cd.ItemSubType.AwakerRandomChest then
    self.showDetailPreview = true
    itemTypeShowText = "ItemType_Awaker"
  elseif itemSubType == cd.ItemSubType.AwakerChipChest then
    self.showDetailPreview = true
    itemTypeShowText = "AwakerChipTypeName"
  elseif itemSubType == cd.ItemSubType.Chest then
    self.showDetailPreview = true
    itemTypeShowText = "ItemType_Material"
  end
  self.view:SetActive(self.ui.Group_AvatarInfo, self.showDetailPreview)
  if self.showDetailPreview then
    self.view:SetText(self.ui.Text_C_AavtarName, LT.Text(itemTypeShowText))
  end
end

function UICompItemDetailTipsItemBase:_SetAttr(uiName, uiValue, attr)
  if attr.id then
    local attrConfig = DT.ActorAttrType[attr.id]
    local name = LT.Text(attrConfig.Text)
    local value = ItemDataUtils.RemoveDotZero(attr.value)
    value = attrConfig.Percentage and value .. "%" or value
    self.view:SetText(uiName, name)
    self.view:SetText(uiValue, value)
  else
    self.view:SetText(uiName, "")
    self.view:SetText(uiValue, "")
  end
end

function UICompItemDetailTipsItemBase:_AddTrinkAttrComp(obj, attr, isMainAttr)
  if not obj then
    return
  end
  if not attr or not attr.tid then
    obj:SetActive(false)
    return
  end
  obj:SetActive(true)
  local showAttr
  if attr and attr.tid and attr.count then
    local attrType = DT.ActorAttrType[attr.tid]
    local textCount = AwakerTrinketDataUtils.GetAttrFmtStringWithMax(attr)
    if isMainAttr and AwakerTrinketDataUtils.IsTrinketBindBonusActive(self.itemData) then
      textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(AwakerTrinketDataUtils.GetBindBonusDisplayCount(attr.count, attr.isPercent), attr.isPercent)
      textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount)
    end
    showAttr = {
      textCount = textCount,
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
  if self.itemData.level and isMainAttr then
    itemData.level = "+" .. self.itemData.level
  end
  self:AddViewComponentOnce(obj, UICompAwakerAttrItem, itemData)
end

function UICompItemDetailTipsItemBase:_RefreshTrinket()
  local suitDescUI = self.trinketSuitdesc
  if self.itemType ~= ItemType.Trinket then
    self.ui.Group_Prop:SetActive(false)
    suitDescUI.uiNode:SetActive(false)
    return
  end
  self.ui.Group_Prop:SetActive(true)
  suitDescUI.uiNode:SetActive(true)
  self.ui.Group_Weapon:SetActive(false)
  local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.itemData.uid)
  self.view:SetText(self.ui.Text_Main_Property, "")
  self.view:SetText(self.ui.Textt_Main_Property_Count, completRate .. "%")
  local mainAttr = AwakerTrinketDataUtils.GetClientMainAttr(self.itemData.uid)
  self:_AddTrinkAttrComp(self.ui.Prop_1, mainAttr, true)
  local subAttrs = AwakerTrinketDataUtils.GetClientSubAttrs(self.itemData.uid)
  for i = 2, 4 do
    self:_AddTrinkAttrComp(self.ui["Prop_" .. i], subAttrs[i - 1])
  end
  local suitId = self.itemData.suitId
  local descData = AwakerTrinketDataUtils.GetSuitDescData(suitId, 0, false, false)
  self:SetText(suitDescUI.Text_Suit_Name, descData and descData.suitEffectTitle or "")
  local descList = descData.effectDescList
  for i = 1, 3 do
    local textDescObj = suitDescUI["Text_Suit_Desc_" .. i]
    if not textDescObj then
    else
      local desc = descList[i]
      if nil == desc or "" == desc then
        textDescObj:SetActive(false)
      end
      self:SetText(textDescObj, desc)
    end
  end
end

function UICompItemDetailTipsItemBase:_RefreshBase()
  local isKeeperSkill = self.itemType == ItemType.KeeperSkill
  self:SetImage(self.ui.Image_Bg_Quality, ItemDataUtils.GetBgQualityFramePath(self.itemData.tid, self.itemData.uid))
  self:SetImage(self.ui.Image_Title_Quality, ItemDataUtils.GetTitleQualityFramePath(self.itemData.tid, self.itemData.uid))
  if self.ui.Image_KeeperSkill then
    self:SetActive(self.ui.Image_KeeperSkill, self.itemType == ItemType.KeeperSkill)
    if isKeeperSkill then
      self:SetImage(self.ui.Image_Bg_KeeperSkill, ItemDataUtils.GetKeeperSkillIconPath(self.itemData.tid))
    end
  end
  self:SetActive(self.ui.Image_Icon, not isKeeperSkill)
  self:SetImage(self.ui.Image_Icon, BagItemDetailsModel.Instance:GetItemIcon(self.itemData))
  self:SetText(self.ui.Text_Name, ItemDataUtils.GetItemName(self.itemData.tid))
  self:SetText(self.ui.Text_Type, ItemDataUtils.GetItemSubTypeName(self.itemData.tid))
  self:SetText(self.ui.Text_Possess, LT.Textf("CommonTipsOwnedText", ItemDataUtils.GetItemNum(self.itemData.tid) or 0))
  local textColor = ItemDataUtils.IsBoundTrinketTips(self.itemData.uid) and "#000000" or "#ffffff"
  self:SetTextColorByHtml(self.ui.Text_Name, textColor)
  self:SetTextColorByHtml(self.ui.Text_Type, textColor)
  self:SetTextColorByHtml(self.ui.Textt_Main_Property_Count, textColor)
  if self.ui.bg1 then
    local bgColor = ItemDataUtils.IsBoundTrinketTips(self.itemData.uid) and "#ffffff" or "#000000"
    self:SetImageColorByHtml(self.ui.bg1, bgColor)
  end
  local subType = ItemDataUtils.GetItemSubType(self.itemData.tid)
  local isShowFrame = subType == CommonDefine.ItemSubType.PlayerAvatar or subType == CommonDefine.ItemSubType.AwakerSkin
  self.ui.Image_PlayerAvatar:SetActive(isShowFrame)
end

function UICompItemDetailTipsItemBase:_RefreshIconBoundLight()
  if self.itemType ~= ItemType.Trinket then
    if self._iconLightComp then
      self._iconLightComp:EnableLight(false)
    end
    return
  end
  self._iconLightComp = self:AddViewComponentOnce(self.ui.Image_Icon, UICompTrinketIconMat)
  local partIndex = AwakerTrinketDataUtils.GetTrinketLightPartIndex(self.itemData.tid)
  self._iconLightComp:EnableLight(AwakerTrinketDataUtils.IsTrinketBoundForLight(self.itemData.uid), partIndex)
end

function UICompItemDetailTipsItemBase:_RefreshCommonMaterials()
  if self.itemType == ItemType.Trinket or self.itemType == ItemType.Weapon then
    self.ui.Group_Normal:SetActive(false)
    self.ui.Textt_Main_Property_Count:SetActive(true)
    return
  end
  if self.itemType == ItemType.KeeperSkill then
    self.ui.Textt_Main_Property_Count:SetActive(false)
    self.ui.Group_Normal:SetActive(false)
    return
  end
  self.ui.Textt_Main_Property_Count:SetActive(false)
  self.ui.Group_Normal:SetActive(true)
  local itemDesc = ItemDataUtils.GetItemDesc(self.itemData.tid)
  self:SetText(self.ui.Text_Normal_Desc, itemDesc)
  StrUtils.SetPreferredHeight(self.ui.Text_Normal_Desc, 30)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Normal)
  local normalDescTmp = self.ui.Text_Normal_Desc:GetComponent(typeof(CS.TMPro.TMP_Text))
  local norTextInfo = normalDescTmp and normalDescTmp.textInfo
  local normalDesLineCount = norTextInfo and norTextInfo.lineCount or 0
  self:BindTimer(0.4, 0, nil, function()
    local textInfo = normalDescTmp and normalDescTmp.textInfo
    if textInfo and normalDesLineCount < textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Normal_Desc, 0)
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Normal)
    end
  end)
end

function UICompItemDetailTipsItemBase:_RefreshTextHeight()
  local descTmp = self.ui.Text_Desc_Sec:GetComponent(typeof(CS.TMPro.TMP_Text))
  local weaponDescTmp = self.ui.Text_Weapon_Desc_1:GetComponent(typeof(CS.TMPro.TMP_Text))
  local weaponDescTmp2 = self.ui.Text_Weapon_Desc_2:GetComponent(typeof(CS.TMPro.TMP_Text))
  local descLineCount = 0
  local weaponDescLineCount = 0
  local weaponDescLineCount2 = 0
  if descTmp.textInfo then
    descLineCount = descTmp.textInfo.lineCount or 0
  end
  if weaponDescTmp.textInfo then
    weaponDescLineCount = weaponDescTmp.textInfo.lineCount or 0
  end
  if weaponDescTmp2.textInfo then
    weaponDescLineCount2 = weaponDescTmp2.textInfo.lineCount or 0
  end
  if self.itemType == ItemType.Trinket then
    self:BindTimer(0.2, 0, nil, function()
      local suitDescUI = self.trinketSuitdesc
      for i = 1, 3 do
        local textDescObj = suitDescUI["Text_Suit_Desc_" .. i]
        if not textDescObj then
        else
          StrUtils.SetPreferredHeight(textDescObj)
        end
      end
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.trinketSuitdesc.Group_Suit)
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Prop)
    end)
  end
  self:BindTimer(0.4, 0, nil, function()
    local isReLayout = false
    if descTmp.textInfo and descLineCount < descTmp.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
      isReLayout = true
    end
    if weaponDescTmp.textInfo and weaponDescLineCount < weaponDescTmp.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_1, 0)
      isReLayout = true
    end
    if weaponDescTmp2.textInfo and weaponDescLineCount2 < weaponDescTmp2.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_2, 0)
      isReLayout = true
    end
    if isReLayout then
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Weapon)
    end
  end)
end

function UICompItemDetailTipsItemBase:_GetJumpItemTid()
  local rst = self.itemData.tid
  local itemCfg = DT.Item[rst]
  if itemCfg and itemCfg.DropItemGets then
    rst = itemCfg.DropItemGets
  end
  return rst
end

function UICompItemDetailTipsItemBase:_RefreshJumpers()
  local isNotKeeperSkill = self.itemType ~= ItemType.KeeperSkill
  local getsList = BagExtModel.Instance:GetItemGets(self.itemData.tid)
  local existedJumper = #getsList > 0
  self.ui.Image_Resource:SetActive(existedJumper and isNotKeeperSkill)
  self.ui.Group_Resource:SetActive(existedJumper and isNotKeeperSkill)
  if not existedJumper then
    return
  end
  local groupTf = self.ui.Group_Resource.transform
  local childCount = groupTf.childCount
  for i = 1, MAX_JUMP_BTN_NUM do
    local childTf = i <= childCount and groupTf:GetChild(i - 1)
    local go = childTf and childTf.gameObject
    local getsId = getsList[i]
    if getsId then
      go = go or self.view:Instantiate(self.ui.UI_Common_Item_Exchange_1, groupTf)
      self:_RefreshJumperItem(go, getsId)
      self.view:SetActive(go, true)
    elseif not IsNil(go) then
      self.view:SetActive(go, false)
    end
  end
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Resource)
end

function UICompItemDetailTipsItemBase:_RefreshJumperItem(uiNode, getsId)
  local uiRes = UI_Common_Item_ExchangeResource(uiNode)
  local itemGetsConfig = DT.ItemGets[getsId]
  local itemTid = self:_GetJumpItemTid()
  local canJumped = FuncJumpManager.Instance:CanJump(getsId, itemTid)
  local justShow = FuncJumpManager.Instance:IsJustShow(getsId)
  self:SetText(uiRes.Text_Name, itemGetsConfig and itemGetsConfig.Desc or "")
  self:SetTextColorType(uiRes.Text_Name, canJumped and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
  uiRes.Group_Select:SetActive(canJumped)
  uiRes.Image_Arrow:SetActive(not justShow)
  uiRes.Group_Normal:SetActive(not canJumped)
  self:AddButtonClickListener(uiRes.Btn_Click, function()
    if justShow then
      return
    end
    FuncJumpManager.Instance:JumpFunc(getsId, itemTid)
  end)
end

function UICompItemDetailTipsItemBase:OnBuildComponent()
  self.view.binder:UpdateLocalizedTextAndResouce(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
  self.lockCompent = self:AddViewComponentOnce(self.ui.UI_Common_Btn_Lock, UICompCommonLockPrefab)
  if self.ui.ScrollView_Detail then
    self.scrollView = self.ui.ScrollView_Detail:GetComponent(T_ScrollRect)
  end
  if not self.scrollView then
    self.scrollView = self.ui.Group_Prop:GetComponentInParent(T_ScrollRect)
  end
end

function UICompItemDetailTipsItemBase:OnEnterComponent()
  self:Refresh()
end

function UICompItemDetailTipsItemBase:_OnBagItemDetailChanged()
  self:Refresh()
  self:_ResetScrollPosition()
end

function UICompItemDetailTipsItemBase:_ResetScrollPosition()
  if self.scrollView then
    self.scrollView:StopMovement()
    self.scrollView.verticalNormalizedPosition = 1
  end
  local contentUI = self.ui.Group_Prop.transform.parent
  CS.Framework.TransformUtil.SetAnchoredPos(contentUI, 0, 0)
end

function UICompItemDetailTipsItemBase:_OnTrinketUpdategraded(targetUid)
  if not self.itemData or self.itemData.uid ~= targetUid then
    return
  end
  self:Refresh()
end

function UICompItemDetailTipsItemBase:_OnBagItemDataChanged(targetUid)
  if not self.itemData or self.itemData.uid ~= targetUid then
    return
  end
  self:Refresh()
end

function UICompItemDetailTipsItemBase:_ClearTimer()
  if self.timer then
    self:StopTimer(self.timer)
    self.timer = nil
  end
end

function UICompItemDetailTipsItemBase:_GetItemData()
end

return UICompItemDetailTipsItemBase
