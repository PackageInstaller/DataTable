local ItemAwardType = CommonDefine.ItemAwardType
local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local CompPublicIconItemType2, Super = NewViewComponent("CompPublicIconItemType2")
local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
local TabTextOverflowThreshold = 145

function CompPublicIconItemType2:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_WuPin_Type2Resource(uiNode)
  self.itemTid = data.itemTid
  self.itemUid = data.itemUid
  self.itemType = data.itemTid and ItemDataUtils.GetItemType(data.itemTid)
  self.weaponLevel = data.weaponLevel
  self.itemCount = data.itemCount
  self.awakerId = data.awakerId
  self.extraOrigin = data.extraOrigin
  self.itemAwardType = data.itemAwardType
  self.icon = data.icon
  self.extraDesc = data.extraDesc
  self.clickFunc = data.clickFunc
  self.subSelectFunc = data.subSelectFunc
  self.redFunc = data.redFunc
  self.relicTid = data.relicTid
  self.isShowBpDouble = data.isShowBpDouble
  self.isShowRing = data.isShowRing
  self.isGot = data.isGot
  self.showGetIcon = data.showGetIcon == nil and true or data.showGetIcon
  self.isSelect = data.isSelect
  self.isSubSelect = data.isSubSelect
  self.isLock = data.isLock
  self.isShowFlowingLight = data.isShowFlowingLight
  self.isShowDarkMask = data.isShowDarkMask
  self.relicBg = data.relicBg
  self.isRelicGray = data.isRelicGray
  self.isShowEffect = data.isShowEffect
  self.isHideQuality = data.isHideQuality
  self.extraDescBgType = data.extraDescBgType
  self.curSkin = data.curSkin
  self.groupFullText = data.groupFullText
end

function CompPublicIconItemType2:OnEnterComponent()
  self.uiAnimationController = self.ui.uiNode:GetComponent(TYPEOF_UIAnimationController)
  self:SetLongPressButtonIntervalTime(self.ui.Btn_Click, tonumber(DT.GetConstant("ItemAddPressTime")))
  self:AddShortPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
  self:SetActive(self.ui.Image_Receive, false)
  self:SetActive(self.ui.Icon_Common, not self:_IsAwakerImage())
  self:SetActive(self.ui.Group_Expression, self:_IsEmojiItem())
  self:SetActive(self.ui.Image_Quality, self:_GetQualityVisible())
  self:SetText(self.ui.Text_Article_Number, LT.Text(self.itemCount))
  self:SetImage(self.ui.Icon_Common, self:_GetIconCommonImage())
  self:SetImage(self.ui.Image_Quality, self:_GetImageQualityImage())
  self:SetActive(self.ui.Icon_Role, self:_IsAwakerImage())
  self:SetActive(self.ui.Group_First, self:_GetGroupFirstVisible())
  self:SetActive(self.ui.Group_Sub_Awaker_Head, self:_OnExtraOriginVisible())
  self:SetActive(self.ui.Group_Tab_Special, self:_OnExtraDescVisible())
  self:SetActive(self.ui.Group_Tab_Double, self.isShowBpDouble)
  self:SetActive(self.ui.Group_VX_Streamer, self.isShowRing)
  if self.ui.Image_AwakerFavor_Max then
    local awakerTid = self:_GetAwakerTid()
    local showFavor = nil ~= awakerTid and FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, AwakerDataUtils.GetAwakerData(awakerTid)) or false
    self:SetActive(self.ui.Image_AwakerFavor_Max, showFavor)
  end
  self:SetActive(self.ui.Group_Get, self.isGot)
  self:SetActive(self.ui.Image_Get_Icon, self.showGetIcon)
  self:SetActive(self.ui.Image_Occupation, self.awakerId)
  self:SetActive(self.ui.Image_Select, self.isSelect)
  self:SetActive(self.ui.Image_Look, self.isLock)
  self:SetActive(self.ui.Image_Claimed, self.isShowDarkMask)
  self:SetActive(self.ui.Image_Mask, self.isRelicGray)
  self:SetActive(self.ui.Text_Article_Number, true)
  if self.ui.Group_Sub_Select then
    self:SetActive(self.ui.Group_Sub_Select, self.isSubSelect)
    self.view:SetLongPressButtonIntervalTime(self.ui.Btn_Sub_Subtract, tonumber(DT.GetConstant("Role_Press_Time")))
    self:AddShortPressButtonListener(self.ui.Btn_Sub_Subtract, System.fn(self, self.OnSubClick))
  end
  self:SetActive(self.ui.Image_Pointing, nil ~= self.relicBg)
  if nil ~= self.isShowEffect then
    self:SetActive(self.ui.UI_BGEffect, self.isShowEffect)
    self:SetActive(self.ui.UI_Effect, self.isShowEffect)
    if self.isShowEffect then
      self:CreateUIEffect()
    end
  end
  if nil ~= self:_GetExtraDescTextVisible() then
    self:_CheckTabTextOverflow(self:_GetExtraDescText())
  end
  if nil ~= self.itemAwardType then
    self:SetText(self.ui.Text_C_First_Tips, self:_GetAwardTypeDesc())
  end
  self:_RefreshBoundTrinketLight()
  if nil ~= self.relicBg then
    self:SetImage(self.ui.Image_Pointing, self.relicBg)
  end
  if nil ~= self:_GetIconRoleImage() then
    self:SetImage(self.ui.Icon_Role, self:_GetIconRoleImage())
  end
  if nil ~= self:_GetImageOccupationImage() then
    self:SetImage(self.ui.Image_Occupation, self:_GetImageOccupationImage())
  end
  if nil ~= self:_GetExtraOriginAwakerIcon() then
    self:SetImage(self.ui.Icon_Awaker, self:_GetExtraOriginAwakerIcon())
  end
  if nil ~= self.redFunc then
    self:_AddRedComp()
  end
  if nil ~= self.isShowFlowingLight then
    self:PlayRebrushAnim()
  end
  self:_InitExtraDescBg()
  self:_RefreshSkinItem()
  self:_RefreshWeaponStarGroup()
  if self.groupFullText then
    self:SetActive(self.ui.Group_Full, true)
    self:SetText(self.ui.Text_C_Full, self.groupFullText)
  end
end

function CompPublicIconItemType2:_RefreshBoundTrinketLight()
  if not (self.itemType == CommonDefine.ItemType.Trinket and self.itemUid) or 0 == self.itemUid then
    return
  end
  local lightComp = self:AddViewComponentOnce(self.ui.Icon_Common, UICompTrinketIconMat)
  local partIndex = AwakerTrinketDataUtils.GetTrinketLightPartIndex(self.itemTid)
  lightComp:EnableLight(AwakerTrinketDataUtils.IsTrinketBoundForLight(self.itemUid), partIndex)
end

function CompPublicIconItemType2:_RefreshWeaponStarGroup()
  if self.itemType ~= CommonDefine.ItemType.Weapon or not self.weaponLevel then
    self:SetActive(self.ui.Group_Stars, false)
    return
  end
  self:SetActive(self.ui.Text_Article_Number, false)
  self:SetActive(self.ui.Group_Stars, true)
  local level = self.weaponLevel
  local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  local numStars = math.min(level, refineStage1MaxLevel)
  for i = 1, 5 do
    local obj = self.ui["Star_" .. i]
    if obj then
      self:SetActive(obj, i <= numStars)
    end
  end
  if level > refineStage1MaxLevel then
    self:SetActive(self.ui.Image_Max, true)
    self:SetText(self.ui.Text_Max, level - refineStage1MaxLevel)
  else
    self:SetActive(self.ui.Image_Max, false)
  end
end

function CompPublicIconItemType2:_RefreshSkinItem()
  local skinTid = AwakerSkinUtils.GetSkinByItem(self.itemTid)
  if not skinTid then
    self:SetActive(self.ui.Group_Skin, false)
    return
  end
  self:SetActive(self.ui.Text_Article_Number, false)
  self:SetActive(self.ui.Group_Skin, true)
  self:SetActive(self.ui.Image_SkinQuality, true)
  self:SetImage(self.ui.Image_SkinQuality, AwakerSkinCfgUtils.GetSkinItemQualityBottomImage(skinTid))
  AwakerUiUtils.RefreshAwakerSkinStarGroup(self, self.binder, skinTid)
end

function CompPublicIconItemType2:_InitExtraDescBg()
  if not self.extraDescBgType then
    return
  end
  local goName = CommonDefine.ExtraDescBgType2GoNameMap[self.extraDescBgType]
  if not goName then
    return
  end
  local go = self.ui[goName]
  if not go then
    return
  end
  self:SetActive(self.ui.Group_Tab_Special_Bg_Default, false)
  self:SetActive(go, true)
end

function CompPublicIconItemType2:OnBtnClick()
  if self.clickFunc then
    self.clickFunc()
    return
  end
  if self.relicTid then
    return
  end
  if self.itemTid then
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.itemTid)
  end
end

function CompPublicIconItemType2:OnSubClick()
  if self.subSelectFunc then
    self.subSelectFunc()
  end
end

function CompPublicIconItemType2:_GetAwakerTid()
  if self.awakerId then
    return self.awakerId
  end
  if self:_IsAwakerImage() then
    do return ItemDataUtils.GetAwakerTidByItemTid end
    return ItemDataUtils.GetAwakerTidByItemTid, self.itemTid
  end
  return nil
end

function CompPublicIconItemType2:_IsAwakerImage()
  if self.awakerId then
    return true
  end
  local isAwakerItem = false
  if self.relicTid then
    return false
  end
  if self.itemTid and 0 ~= self.itemTid then
    isAwakerItem = self.itemType == CommonDefine.ItemType.AwakerItem
  end
  return isAwakerItem
end

function CompPublicIconItemType2:_IsEmojiItem()
  local specType = false
  local emojiType = false
  if self.itemTid and 0 ~= self.itemTid then
    specType = self.itemType == CommonDefine.ItemType.Special
    emojiType = ItemDataUtils.GetItemSubType(self.itemTid) == CommonDefine.ItemSubType.Emoji
  end
  return specType and emojiType
end

function CompPublicIconItemType2:_GetQualityVisible()
  if self.isHideQuality then
    return false
  end
  do return self._GetConfig end
  return self._GetConfig, self
end

function CompPublicIconItemType2:_GetIconCommonImage()
  if self.icon then
    return self.icon
  end
  if self.relicTid then
    do return RelicDataUtils.GetRelicIcon end
    return RelicDataUtils.GetRelicIcon, self.relicTid
  end
  if self.itemTid then
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, self.itemTid
  end
  return nil
end

function CompPublicIconItemType2:_GetImageQualityImage()
  local config = DT.Item[self.itemTid]
  if self.awakerId then
    config = DT.AwakerConfig[self.awakerId]
  elseif self.relicTid then
    config = RelicDataUtils.GetRelicConfig(self.relicTid)
  end
  if config then
    do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
    return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
  end
  return ""
end

function CompPublicIconItemType2:_GetIconRoleImage()
  if self.relicTid then
    return nil
  end
  if self.icon then
    return self.icon
  end
  if self.awakerId then
    if self.curSkin then
      do return AwakerDataUtils.GetLittleIcon, self.awakerId, true end
      return AwakerDataUtils.GetLittleIcon, self.awakerId, true, self.curSkin
    end
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, self.awakerId, true, self.curSkin
  end
  if self.itemTid then
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, self.itemTid, true, self.curSkin
  end
  return nil
end

function CompPublicIconItemType2:_GetExtraDescTextVisible()
  if self.itemTid == CommonDefine.CurrencyType.FreePayMoney then
    return true
  end
  return self.extraDesc or self.extraOrigin
end

function CompPublicIconItemType2:_GetExtraDescText()
  if self.itemTid == CommonDefine.CurrencyType.FreePayMoney then
    do return LT.Text end
    return LT.Text, "GiveAwayItem"
  end
  if self.extraDesc then
    return self.extraDesc
  end
  do return AwakerDataUtils.GetSpecialSkillOriginDescByAwaker end
  return AwakerDataUtils.GetSpecialSkillOriginDescByAwaker, self.extraOrigin
end

function CompPublicIconItemType2:_CheckTabTextOverflow(text)
  if not text then
    return
  end
  if not self.ui.TabView or not self.ui.Text_View_Tab then
    self:SetActive(self.ui.Text_Tab_Special, true)
    self:SetText(self.ui.Text_Tab_Special, text)
    return
  end
  self:SetText(self.ui.Text_Tab_Special, text)
  local tmpComp = self.ui.Text_Tab_Special:GetComponent(TYPEOF_TMP_Text)
  if not tmpComp then
    return
  end
  tmpComp:ForceMeshUpdate()
  if tmpComp.preferredWidth <= TabTextOverflowThreshold then
    self:SetActive(self.ui.Text_Tab_Special, true)
    self:SetActive(self.ui.TabView, false)
  else
    self:SetActive(self.ui.Text_Tab_Special, false)
    self:SetActive(self.ui.TabView, true)
    self:SetText(self.ui.Text_View_Tab, text)
    local scrollComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_View_Tab.gameObject, 0, 0, 5, 15, false)
    if scrollComp then
      scrollComp:SetBtn(self.ui.Btn_Click)
      scrollComp.waitingTime = 2
    end
  end
end

function CompPublicIconItemType2:_GetImageOccupationImage()
  if self.awakerId then
    local awakerConfig = DT.AwakerConfig[self.awakerId]
    local schoolConfig = DT.SchoolConfig[awakerConfig.School]
    return schoolConfig.Icon
  end
  return nil
end

function CompPublicIconItemType2:_AddRedComp()
  self:AddViewComponentOnce(self.ui.Group_Sub_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, self.redFunc)
end

function CompPublicIconItemType2:_GetExtraOriginAwakerIcon()
  if not self:_OnExtraOriginVisible() then
    return nil
  end
  do return AwakerDataUtils.GetCircleHeadIcon end
  return AwakerDataUtils.GetCircleHeadIcon, self.extraOrigin
end

function CompPublicIconItemType2:_OnExtraOriginVisible()
  return self.extraOrigin and self.extraOrigin > 0
end

function CompPublicIconItemType2:_OnExtraDescVisible()
  if self.extraDesc then
    return self.extraDesc ~= ""
  end
  do return self._OnExtraOriginVisible end
  return self._OnExtraOriginVisible, self
end

function CompPublicIconItemType2:_GetGroupFirstVisible()
  return self.itemAwardType and self.itemAwardType ~= ItemAwardType.Normal
end

function CompPublicIconItemType2:PlayRebrushAnim()
  self.uiAnimationController:StopPlayableGraph()
  self.uiAnimationController:PlayState("UI_Vx_Common_Item_WuPin_Type2_Refurbish_01")
end

function CompPublicIconItemType2:_GetConfig()
  local config = DT.Item[self.itemTid]
  if self.awakerId then
    config = DT.AwakerConfig[self.awakerId].Quality
  elseif self.relicTid then
    config = RelicDataUtils.GetRelicConfig(self.relicTid)
  end
  return config
end

function CompPublicIconItemType2:_GetAwardTypeDesc()
  if not self.itemAwardType then
    return ""
  end
  local topLabelStr = itemAwardTypeDescMap[self.itemAwardType]
  do return LT.Text end
  return LT.Text, topLabelStr
end

function CompPublicIconItemType2:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompPublicIconItemType2:UpdateClickFunc(clickFunc)
  self.clickFunc = clickFunc
end

function CompPublicIconItemType2:SpecialShowCntDesc(cntDesc)
  self:SetText(self.ui.Text_Article_Number, cntDesc)
end

function CompPublicIconItemType2:CreateUIEffect()
  self:SetActive(self.ui.UI_BGEffect, true)
  self:SetActive(self.ui.UI_Effect, true)
  local cfg = self:_GetConfig()
  local quality = cfg.Quality
  if not quality then
    return
  end
  local topEffectPath = CommonDefine.Quality2CommonItemTopEffectMap[quality]
  if topEffectPath then
    self:_InstantiateUIEffect(self.ui.UI_Effect, topEffectPath)
  end
end

function CompPublicIconItemType2:_InstantiateUIEffect(targetGo, effectPath)
  local childCount = targetGo.transform.childCount
  for i = 0, childCount - 1 do
    local obj = targetGo.transform:GetChild(i).gameObject
    GameObject.Destroy(obj)
  end
  local obj = ResLoadMgr.LoadAsset(effectPath, self)
  GameObject.Instantiate(obj, targetGo.transform)
end

return CompPublicIconItemType2
