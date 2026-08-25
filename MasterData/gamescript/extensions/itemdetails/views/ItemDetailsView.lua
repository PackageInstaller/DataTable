local ItemType = CommonDefine.ItemType
local ItemSubType = CommonDefine.ItemSubType
local MAX_JUMP_BTN_NUM = 15
local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local ItemDetailsView, Super = NewClass("ItemDetailsView", BaseView)
ItemDetailsView.uiResCls = UI_Common_Item_DetailResource

function ItemDetailsView:ctor(openParams)
  Super.ctor(self)
  self._openParams = openParams or {}
  self._posAdjusted = false
  self._banJumperClick = false
end

function ItemDetailsView:OnBuildView()
  self.transform = self.ui.uiNode.transform
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.trinketSuitdesc = UI_Awaker_Item_Trinket_SuitdescResource(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
  self.lockComp = self:AddViewComponent(self.ui.UI_Common_Btn_Lock, UICompCommonLockPrefab)
  self.canvasGroup = self.ui.uiNode:GetComponent(T_CanvasGroup)
end

function ItemDetailsView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnItemDetailsDataChanged, self._OnDataChanged, self)
  self:RegisterNotify(NotifyId.OnItemDetailLockStates, self._OnLockStateChanged, self)
  self:RegisterNotify(NotifyId.OnTrinketUpdategraded, self._OnTrinketUpgraded, self)
  self:BindEvent(EventMgr.Instance.CommonTipsCloseEvent, function()
    self._banJumperClick = true
  end)
end

function ItemDetailsView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_AvatarClick, System.fn(self, self._OnAvatarPreviewClick))
end

function ItemDetailsView:OnEnterView()
  Super.OnEnterView(self)
  self._posAdjusted = false
  self._banJumperClick = false
  self:_TryAdjustPosition()
  AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_ITEMINFO_ON")
  self:_RefreshAll()
  self:_RegisterBackCommand()
  self:_RegisterOutsideClickClose()
end

function ItemDetailsView:_RegisterBackCommand()
  if not self._openParams.parentNode then
    return
  end
  UIBackCommandStack.Push({
    uiPanel = tostring(self),
    Execute = function()
      self:_OnMaskClicked()
    end
  })
end

function ItemDetailsView:_RegisterOutsideClickClose()
  if self._openParams.ignoreCustomInput then
    return
  end
  local scrollView = self.ui.ScrollView:GetComponent(T_ScrollRect)
  local contentGo = scrollView and scrollView.content and scrollView.content.gameObject
  self:AddUICustomInputlistener(contentGo or self.ui.uiNode, function(hover)
    if UIManager.Instance:GetWindow(Urls.CommonCardKeyWorldDescPanel) then
      return
    end
    if not hover then
      self:_OnMaskClicked()
    end
  end)
end

function ItemDetailsView:OnExitView()
  AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_ITEMINFO_OFF")
  UIBackCommandStack.Remove(tostring(self))
  ItemDetailsController.Instance._curShowTipsTag = nil
  Super.OnExitView(self)
end

function ItemDetailsView:_OnDataChanged()
  self:_RefreshAll()
end

function ItemDetailsView:_OnLockStateChanged(uid)
  local chosenUid = ItemDetailsModel.Instance:GetChosenUid()
  if uid ~= chosenUid then
    return
  end
  self.lockComp:RefreshItemDetailLockStates(uid)
end

function ItemDetailsView:_OnTrinketUpgraded(targetUid)
  local chosenUid = ItemDetailsModel.Instance:GetChosenUid()
  if chosenUid ~= targetUid then
    return
  end
  local itemType = ItemDetailsModel.Instance:GetItemType()
  if itemType == ItemType.Trinket then
    local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(chosenUid)
    self:SetText(self.ui.Textt_Main_Property_Count, completRate .. "%")
  end
end

function ItemDetailsView:_RefreshAll()
  local itemData = ItemDetailsModel.Instance:GetChosenItemData()
  if not itemData then
    return
  end
  self:_RefreshBasicInfo(itemData)
  self:_RefreshAttrVisibility()
  self:_RefreshWeaponInfo(itemData)
  self:_RefreshTrinketInfo(itemData)
  self:_RefreshCommonMaterials(itemData)
  self:_RefreshKeeperSkillInfo(itemData)
  self:_RefreshItemSources(itemData)
  self:_RefreshCountDownInfo(itemData)
  self:_RefreshAvatarInfo(itemData)
  self:_RefreshLockState(itemData)
  self:_RefreshLayout()
end

function ItemDetailsView:_RefreshBasicInfo(itemData)
  local tid = itemData.tid
  local itemType = ItemDetailsModel.Instance:GetItemType()
  self:SetActive(self.ui.Image_Icon, true)
  self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetIcon(tid))
  self:_RefreshIconBoundLight(itemData)
  local boundCheckUid
  if not ItemDetailsModel.Instance:IsPreviewData() then
    boundCheckUid = itemData.uid
  end
  self:SetImage(self.ui.Image_Bg_Quality, ItemDataUtils.GetBgQualityFramePath(tid, boundCheckUid))
  self:SetImage(self.ui.Image_Title_Quality, ItemDataUtils.GetTitleQualityFramePath(tid, boundCheckUid))
  local bgColor = ItemDataUtils.IsBoundTrinketTips(boundCheckUid) and "#ffffff" or "#000000"
  self:SetImageColorByHtml(self.ui.bg1, bgColor)
  local name = ItemDataUtils.GetItemName(tid)
  self:SetText(self.ui.Text_Name, name)
  local boundTextColor = "#ffffff"
  if ItemDataUtils.IsBoundTrinketTips(boundCheckUid) then
    boundTextColor = "#000000"
  end
  self:SetTextColorByHtml(self.ui.Text_Name, boundTextColor)
  local subTypeName = ItemDataUtils.GetItemSubTypeName(tid)
  self:SetText(self.ui.Text_Type, subTypeName)
  self:SetTextColorByHtml(self.ui.Text_Type, boundTextColor)
  self:SetTextColorByHtml(self.ui.Textt_Main_Property_Count, boundTextColor)
  local showOwnTxtTypeGroup = DT.GetOriginalConstant("ItemTipsNum")
  local showOwn = table.contains(showOwnTxtTypeGroup, itemType)
  self.ui.Image_Possess:SetActive(showOwn)
  if showOwn then
    local ownNum = ItemDataUtils.IsPayMoneyType(tid) and ItemDataUtils.GetPayMoneyTotalNum() or ItemDataUtils.GetItemNum(tid)
    self:SetText(self.ui.Text_Possess, LT.Textf("CommonTipsOwnedText", ownNum))
    self:SetTextColorByHtml(self.ui.Text_Possess, boundTextColor)
  end
  local itemSubType = ItemDetailsModel.Instance:GetItemSubType()
  local isShowFrame = itemSubType == ItemSubType.PlayerAvatar or itemSubType == ItemSubType.AwakerSkin
  self.ui.Image_PlayerAvatar:SetActive(isShowFrame)
  local story = ItemDataUtils.GetItemStory(tid)
  if string.isempty(story) then
    self.ui.Text_Desc_Sec:SetActive(false)
  else
    self.ui.Text_Desc_Sec:SetActive(true)
    self:SetText(self.ui.Text_Desc_Sec, story)
  end
  StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
end

function ItemDetailsView:_RefreshAttrVisibility()
  local hideAttr = self._openParams.hideAttr
  self.ui.Text_Main_Property:SetActive(not hideAttr)
  self.ui.Textt_Main_Property_Count:SetActive(not hideAttr)
end

function ItemDetailsView:_RefreshWeaponInfo(itemData)
  local itemType = ItemDetailsModel.Instance:GetItemType()
  if itemType ~= ItemType.Weapon then
    self.ui.Group_Weapon:SetActive(false)
    return
  end
  self.ui.Group_Weapon:SetActive(true)
  self.ui.Group_Normal:SetActive(false)
  self.ui.Group_Prop:SetActive(false)
  self.ui.Text_Main_Property:SetActive(true)
  self.ui.Text_Weapon_Prim_Attr_Name_1:SetActive(false)
  self.ui.Text_Weapon_Prim_Attr_Name_2:SetActive(false)
  self.ui.Text_Weapon_Prim_Attr_Name_3:SetActive(false)
  local secAttr = ItemDataUtils.GetWeaponSecAttr(itemData)
  self:_SetWeaponAttr(self.ui.Text_Main_Property, self.ui.Textt_Main_Property_Count, secAttr)
  local refineLevel = itemData.level or 0
  local numStars = math.min(refineLevel, RefineStage1MaxLevel)
  for i = 1, 3 do
    local obj = self.ui["Star_" .. i]
    if obj then
      obj:SetActive(i <= numStars)
    end
  end
  if refineLevel > RefineStage1MaxLevel then
    self.ui.Image_Max:SetActive(true)
    self:SetText(self.ui.Text_Max, refineLevel - RefineStage1MaxLevel)
  else
    self.ui.Image_Max:SetActive(false)
  end
  if self.ui.Text_WeaponHave then
    local showWeaponHave = self._openParams.showWeaponHave == true
    self.ui.Text_WeaponHave:SetActive(showWeaponHave)
    if showWeaponHave then
      self:SetText(self.ui.Text_WeaponHave, ItemDataUtils.GetWeaponOwnedDisplayText(itemData.tid))
    end
  end
  local desc1 = SkillUtils.GetWeaponStateDesc(itemData.tid, itemData.level)
  if "" == desc1 then
    self.ui.Text_Weapon_Desc_1:SetActive(false)
  else
    self:SetText(self.ui.Text_Weapon_Desc_1, desc1)
    self.ui.Text_Weapon_Desc_1:SetActive(false)
    self.ui.Text_Weapon_Desc_1:SetActive(true)
  end
  local desc2 = BagItemDetailsModel:GetWeaponExclusiveDesc(itemData)
  if "" == desc2 then
    self.ui.Text_Weapon_Desc_2:SetActive(false)
  else
    self.ui.Text_Weapon_Desc_2:SetActive(true)
    self:SetText(self.ui.Text_Weapon_Desc_2, desc2)
  end
  local itemConfig = DT.Item[itemData.tid]
  if itemConfig and not string.isempty(itemConfig.StoryDesc) then
    self.ui.Text_Desc_Sec:SetActive(true)
    self:SetText(self.ui.Text_Desc_Sec, itemConfig.StoryDesc)
  else
    self.ui.Text_Desc_Sec:SetActive(false)
  end
  StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_1, 0)
  StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_2, 0)
  StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Weapon)
end

function ItemDetailsView:_RefreshTrinketInfo(itemData)
  local itemType = ItemDetailsModel.Instance:GetItemType()
  local itemSubType = ItemDetailsModel.Instance:GetItemSubType()
  local isPreview = self._openParams.isPreview
  local suitDescUI = self.trinketSuitdesc
  local isTrinket = itemType == ItemType.Trinket
  local isTrinketDropItem = itemType == ItemType.DropItem and itemSubType == ItemSubType.TrinketDropItem
  self.ui.Group_Prop:SetActive(isTrinket and not isPreview)
  suitDescUI.uiNode:SetActive(isTrinket or isTrinketDropItem)
  if not isTrinket and not isTrinketDropItem then
    return
  end
  if isTrinket and not isPreview then
    self.ui.Group_Weapon:SetActive(false)
    local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(itemData.uid)
    self:SetText(self.ui.Text_Main_Property, "")
    self:SetText(self.ui.Textt_Main_Property_Count, completRate .. "%")
    local mainAttr = AwakerTrinketDataUtils.GetClientMainAttr(itemData.uid)
    self:_AddTrinketAttrComp(self.ui.Prop_1, mainAttr, true, itemData)
    local subAttrs = AwakerTrinketDataUtils.GetClientSubAttrs(itemData.uid)
    for i = 2, 4 do
      self:_AddTrinketAttrComp(self.ui["Prop_" .. i], subAttrs[i - 1], false, nil)
    end
  end
  local suitId = itemData.suitId
  if isPreview and isTrinket then
    local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(itemData.tid)
    suitId = trinketInfo and trinketInfo[2]
  elseif isTrinketDropItem then
    suitId = ItemDataUtils.GetTrinketDropItemSuit(itemData.tid)
  end
  local descData = AwakerTrinketDataUtils.GetSuitDescData(suitId, 0, false, false)
  self:SetText(suitDescUI.Text_Suit_Name, descData and descData.suitEffectTitle or "")
  local descList = descData and descData.effectDescList or {}
  for i = 1, 3 do
    local textDescObj = suitDescUI["Text_Suit_Desc_" .. i]
    if textDescObj then
      local desc = descList[i]
      if nil == desc or "" == desc then
        textDescObj:SetActive(false)
      else
        textDescObj:SetActive(true)
        self:SetText(textDescObj, desc)
        StrUtils.SetPreferredHeight(textDescObj, 30)
      end
    end
  end
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Prop)
  if suitDescUI.Group_Suit then
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(suitDescUI.Group_Suit)
  end
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
end

function ItemDetailsView:_RefreshCommonMaterials(itemData)
  local itemType = ItemDetailsModel.Instance:GetItemType()
  if itemType == ItemType.Trinket or itemType == ItemType.Weapon then
    self.ui.Group_Normal:SetActive(false)
    self.ui.Textt_Main_Property_Count:SetActive(true)
    return
  end
  if itemType == ItemType.KeeperSkill then
    self.ui.Textt_Main_Property_Count:SetActive(false)
    self.ui.Group_Normal:SetActive(false)
    return
  end
  self.ui.Textt_Main_Property_Count:SetActive(false)
  self.ui.Group_Normal:SetActive(true)
  local itemDesc = self:_GetItemDesc(itemData.tid)
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

function ItemDetailsView:_RefreshKeeperSkillInfo(itemData)
  local itemType = ItemDetailsModel.Instance:GetItemType()
  if itemType ~= ItemType.KeeperSkill then
    self.ui.Group_KeeperSkill:SetActive(false)
    return
  end
  self.ui.Group_KeeperSkill:SetActive(true)
  local tid = itemData.tid
  local desc = LT.Text(KeeperSkillUtils.GetKeeperSkillDesc(tid))
  if "" == desc then
    self.ui.Text_KeeperSkill_Desc:SetActive(false)
  else
    self.ui.Text_KeeperSkill_Desc:SetActive(true)
    self:SetText(self.ui.Text_KeeperSkill_Desc, desc)
  end
  StrUtils.SetPreferredHeight(self.ui.Text_KeeperSkill_Desc, 0)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_KeeperSkill)
end

function ItemDetailsView:_RefreshItemSources(itemData)
  local itemType = ItemDetailsModel.Instance:GetItemType()
  local isKeeperSkill = itemType == ItemType.KeeperSkill
  local getsList = ItemDetailsModel.Instance:GetItemGets()
  local existedJumper = #getsList > 0
  self.ui.Image_Resource:SetActive(existedJumper and not isKeeperSkill)
  self.ui.Group_Resource:SetActive(existedJumper and not isKeeperSkill)
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
      go = go or self:Instantiate(self.ui.UI_Common_Item_Exchange_1, groupTf)
      self:_RefreshJumperItem(go, getsId, itemData)
      self:SetActive(go, true)
    elseif not IsNil(go) then
      self:SetActive(go, false)
    end
  end
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Resource)
end

function ItemDetailsView:_RefreshJumperItem(uiNode, getsId, itemData)
  local uiRes = UI_Common_Item_ExchangeResource(uiNode)
  local itemGetsConfig = DT.ItemGets[getsId]
  local itemTid = self:_GetJumpItemTid(itemData)
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
    if self._banJumperClick then
      return
    end
    local parentNode = self._openParams.parentNode
    if parentNode then
      self:_OnMaskClicked()
    end
    FuncJumpManager.Instance:JumpFunc(getsId, itemTid)
  end)
end

function ItemDetailsView:_RefreshCountDownInfo(itemData)
  if not self.ui.Text_C_Time or not self.ui.Text_Normal_Time then
    return
  end
  local itemConfig = DT.Item[itemData.tid]
  local isBackTrack = itemConfig and itemConfig.SubType == ItemSubType.BackTrack
  local isExpiredItem = table.contains(CommonDefine.ExpiredItemTidList, itemData.tid)
  if not isBackTrack and not isExpiredItem then
    self.ui.Text_C_Time:SetActive(false)
    return
  end
  local showText = isExpiredItem and LT.Text("InheritConsumeDrawItemConvertTips") or LT.Text("RemainValidTime")
  self:SetText(self.ui.Text_C_Time, showText)
  local battlePassEndTime = BattlePassDataUtils.GetItemEndTs()
  local backTrackEndTime = BackTrackDataUtils.GetEndTime()
  local endTime = isExpiredItem and battlePassEndTime or backTrackEndTime
  if not endTime or 0 == endTime then
    self.ui.Text_C_Time:SetActive(false)
    return
  end
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
  StrUtils.SetPreferredHeight(self.ui.Text_C_Time, timeDescHeight)
  self._countdownTimer = self:BindTimer(1, -1, function()
    tickCall()
  end)
end

function ItemDetailsView:_RefreshAvatarInfo(itemData)
  if not self.ui.Group_AvatarInfo then
    return
  end
  local itemSubType = ItemDataUtils.GetItemSubType(itemData.tid)
  local showPreview = CommonDefine.ShowAvatarPreviewType[itemSubType]
  self:SetActive(self.ui.Group_AvatarInfo, showPreview)
end

function ItemDetailsView:_RefreshLockState(itemData)
  if not self.lockComp then
    return
  end
  if self._openParams.banLock or self._openParams.isPreview then
    self.ui.UI_Common_Btn_Lock:SetActive(false)
    return
  end
  self.lockComp:RefreshItemDetailLockStates(itemData.uid)
end

function ItemDetailsView:_RefreshLayout()
  self:BindTimer(0.1, 0, nil, function()
    StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
    StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_1, 0)
    StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_2, 0)
    StrUtils.SetPreferredHeight(self.ui.Text_Normal_Desc, 0)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Normal)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Weapon)
    local suitDescUI = self.trinketSuitdesc
    for i = 1, 3 do
      local textDescObj = suitDescUI["Text_Suit_Desc_" .. i]
      if textDescObj then
        StrUtils.SetPreferredHeight(textDescObj)
      end
    end
    if suitDescUI.Group_Suit then
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(suitDescUI.Group_Suit)
    end
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Prop)
  end)
  local descTmp = self.ui.Text_Desc_Sec:GetComponent(typeof(CS.TMPro.TMP_Text))
  local weaponDescTmp = self.ui.Text_Weapon_Desc_1:GetComponent(typeof(CS.TMPro.TMP_Text))
  local weaponDescTmp2 = self.ui.Text_Weapon_Desc_2:GetComponent(typeof(CS.TMPro.TMP_Text))
  local descLineCount = descTmp and descTmp.textInfo and descTmp.textInfo.lineCount or 0
  local weaponDescLineCount = weaponDescTmp and weaponDescTmp.textInfo and weaponDescTmp.textInfo.lineCount or 0
  self:BindTimer(0.4, 0, nil, function()
    local isReLayout = false
    if descTmp and descTmp.textInfo and descLineCount < descTmp.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 0)
      isReLayout = true
    end
    if weaponDescTmp and weaponDescTmp.textInfo and weaponDescLineCount < weaponDescTmp.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_1, 0)
      isReLayout = true
    end
    if weaponDescTmp2 and weaponDescTmp2.textInfo and weaponDescTmp2.textInfo.lineCount then
      StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_2, 0)
      isReLayout = true
    end
    if isReLayout then
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Weapon)
    end
    local normalDescTmp = self.ui.Text_Normal_Desc:GetComponent(typeof(CS.TMPro.TMP_Text))
    if normalDescTmp and normalDescTmp.textInfo then
      StrUtils.SetPreferredHeight(self.ui.Text_Normal_Desc, 0)
      CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Normal)
    end
  end)
end

function ItemDetailsView:_TryAdjustPosition()
  if not self._openParams.parentNode then
    return
  end
  if self.canvasGroup then
    self.canvasGroup.alpha = 0
  end
  self.transform.localPosition = CS.UnityEngine.Vector3(0, -10000, 0)
  self._adjustTimer = self:BindTimer(0.1, 0, nil, function()
    self:_AdjustPosition()
  end)
end

function ItemDetailsView:_AdjustPosition()
  self._posAdjusted = true
  if self._adjustTimer then
    self:StopTimer(self._adjustTimer)
    self._adjustTimer = nil
  end
  local parentNode = self._openParams.parentNode
  local posY = self._openParams.posY
  local posX = self._openParams.posX
  UIUtils.AdjustTipsPosition(self.ui.uiNode, parentNode, posY, posX)
  if self.canvasGroup then
    self.canvasGroup.alpha = 1
  end
  if self.uiAnimController then
    self.uiAnimController:PlayState("UI_Common_Item_Detail_Open")
  end
end

function ItemDetailsView:_OnMaskClicked()
  EventMgr.Instance.CommonTipsCloseEvent:Dispatch()
  
  local function doClose()
    local isPreview = self._openParams.isPreview
    if isPreview then
      self._openParams.isPreview = false
    end
    local closeCb = self._openParams.closeCb
    if closeCb then
      closeCb()
    end
    self:Close()
  end
  
  if self._posAdjusted and self.uiAnimController then
    self.uiAnimController:StopPlayableGraph()
    self.uiAnimController:PlayState("UI_Common_Item_Detail_Close", doClose)
  else
    doClose()
  end
end

function ItemDetailsView:_OnAvatarPreviewClick()
  local itemData = ItemDetailsModel.Instance:GetChosenItemData()
  if not itemData then
    return
  end
  UIManager.Instance:SetTempPanelLayer(Urls.UI_Bag_Panel_AppearancePreview, UIDefine.LayerCfg.TipPopRoot.name)
  ItemDataUtils.OnClickBoxItemShow(itemData.tid)
end

function ItemDetailsView:_RefreshIconBoundLight(itemData)
  local itemType = ItemDetailsModel.Instance:GetItemType()
  if itemType ~= ItemType.Trinket then
    if self._iconLightComp then
      self._iconLightComp:EnableLight(false)
    end
    return
  end
  self._iconLightComp = self:AddViewComponentOnce(self.ui.Image_Icon, UICompTrinketIconMat)
  local partIndex = AwakerTrinketDataUtils.GetTrinketLightPartIndex(itemData.tid)
  self._iconLightComp:EnableLight(AwakerTrinketDataUtils.IsTrinketBoundForLight(itemData.uid), partIndex)
end

function ItemDetailsView:_GetItemDesc(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  if ItemDataUtils.IsPayMoneyType(tid) and config then
    local payMoneyNum = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.PayMoney, true)
    local freePayMoneyNum = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.FreePayMoney, true)
    do return LT.Textf, config.Desc, payMoneyNum end
    return LT.Textf, config.Desc, payMoneyNum, freePayMoneyNum, nil, nil, nil, nil, nil
  end
  if config and config.SubType == ItemSubType.ActivityShowDropItem then
    local dropCfg = DT.Drop[config.SpParam and config.SpParam[1] or 0]
    if dropCfg and dropCfg.data_list then
      local minItemCount = 9999999
      for _, data in pairs(dropCfg.data_list) do
        if data and data.DropNum then
          minItemCount = math.min(data.DropNum, minItemCount)
        end
      end
      do return LT.Textf, config.Desc end
      return LT.Textf, config.Desc, minItemCount, pairs(dropCfg.data_list)
    end
  end
  do return ItemDataUtils.GetItemDesc end
  return ItemDataUtils.GetItemDesc, tid, LT.Textf, config.Desc, minItemCount, pairs(dropCfg.data_list)
end

function ItemDetailsView:_GetMainAttr()
  local chosenItemData = ItemDetailsModel.Instance:GetChosenItemData()
  if not chosenItemData or self._openParams.isPreview then
    return nil
  end
  local mainAttr
  for _, attr in pairs(chosenItemData.attrs) do
    if attr and 1 == attr.index then
      mainAttr = attr
      break
    end
  end
  local clientAttr = AwakerTrinketDataUtils.TrinketAttrToClientAttr(mainAttr)
  return clientAttr
end

function ItemDetailsView:_GetMainAttrName()
  local chosenItemData = ItemDetailsModel.Instance:GetChosenItemData()
  if not chosenItemData or self._openParams.isPreview then
    return ""
  end
  local itemType = ItemDetailsModel.Instance:GetItemType()
  local tid = chosenItemData.tid
  if itemType == ItemType.Weapon then
    do return ItemDataUtils.GetWeaponAttrName end
    return ItemDataUtils.GetWeaponAttrName, tid
  elseif itemType == ItemType.Trinket then
    local attr = self:_GetMainAttr()
    return attr and attr.name or ""
  end
  return ""
end

function ItemDetailsView:_GetMainAttrValue()
  local chosenItemData = ItemDetailsModel.Instance:GetChosenItemData()
  if not chosenItemData or self._openParams.isPreview then
    return ""
  end
  local itemType = ItemDetailsModel.Instance:GetItemType()
  local tid = chosenItemData.tid
  if itemType == ItemType.Weapon then
    do return ItemDataUtils.GetWeaponAttrValue end
    return ItemDataUtils.GetWeaponAttrValue, tid, nil, nil
  elseif itemType == ItemType.Trinket then
    local attr = self:_GetMainAttr()
    local attrValue = attr and attr.count or ""
    if attr and attr.isPercent then
      attrValue = attrValue .. "%"
    end
    return attrValue
  end
  return ""
end

function ItemDetailsView:_SetWeaponAttr(uiName, uiValue, attr)
  if attr and attr.id then
    local attrConfig = DT.ActorAttrType[attr.id]
    local name = LT.Text(attrConfig.Text)
    local value = ItemDataUtils.RemoveDotZero(attr.value)
    value = attrConfig.Percentage and value .. "%" or value
    self:SetText(uiName, name)
    self:SetText(uiValue, value)
  else
    self:SetText(uiName, "")
    self:SetText(uiValue, "")
  end
end

function ItemDetailsView:_AddTrinketAttrComp(obj, attr, isMainAttr, itemData)
  if not obj then
    return
  end
  if not attr or not attr.tid then
    obj:SetActive(false)
    return
  end
  obj:SetActive(true)
  local showAttr
  if attr.tid and attr.count then
    local attrType = DT.ActorAttrType[attr.tid]
    local textCount = AwakerTrinketDataUtils.GetAttrFmtStringWithMax(attr)
    if isMainAttr and AwakerTrinketDataUtils.IsTrinketBindBonusActive(itemData) then
      textCount = AwakerTrinketDataUtils.GetAttrFmtStringByValue(AwakerTrinketDataUtils.GetBindBonusDisplayCount(attr.count, attr.isPercent), attr.isPercent)
      textCount = AwakerTrinketDataUtils.GetBindBonusAttrText(textCount)
    end
    showAttr = {
      textCount = textCount,
      imageIcon = attrType.Icon,
      textName = LT.Text(attrType.Text)
    }
  end
  local compData = {
    showAttr = showAttr,
    clientAttr = attr,
    resourceCls = UI_Awaker_Item_EntryResource,
    useDefaultIcon = true,
    useOriginDemical = true
  }
  if itemData and itemData.level and isMainAttr then
    compData.level = "+" .. itemData.level
  end
  self:AddViewComponentOnce(obj, UICompAwakerAttrItem, compData)
end

function ItemDetailsView:_GetJumpItemTid(itemData)
  local rst = itemData and itemData.tid
  if not rst then
    return rst
  end
  local itemCfg = DT.Item[rst]
  if itemCfg and itemCfg.DropItemGets then
    rst = itemCfg.DropItemGets
  end
  return rst
end

return ItemDetailsView
