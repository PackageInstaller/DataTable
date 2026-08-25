local UI_Common_Item_WuPin_Type2Resource = require("UI.UIPackages.UI_Common_Item_WuPin_Type2Resource")
local System = require("System.System")
local LT = require("System.LangTable")
local DT = require("System.DataTable")
local CommonDefine = require("World.Enums.CommonDefine")
local ItemDataUtils = require("Data.ItemDataUtils")
local RelicDataUtils = require("Data.RelicDataUtils")
local UIAnimationController = CS.Z1Client.UIAnimationController
local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local CommonIconItemType2, Super = System.NewComponent("CommonIconItemType2")
local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
local extraDescBgType2GoNameMap = CommonDefine.ExtraDescBgType2GoNameMap
local TabTextOverflowThreshold = 145

function CommonIconItemType2:ctor(uiNode, itemData)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type2Resource(uiNode)
  self.itemTid = Vue.ref(itemData.itemTid)
  self.itemCount = Vue.ref(itemData.itemCount)
  self.isGot = itemData.isGot
  self.clickFunc = itemData.clickFunc
  self.itemAwardType = itemData.itemAwardType
  self.awakerId = itemData.awakerId
  self.curSkin = itemData.curSkin
  self.extraOrigin = itemData.extraOrigin
  self.extraDescFunc = itemData.extraDescFunc
  self.selectFunc = itemData.selectFunc
  self.lockFunc = itemData.lockFunc
  self.isGotFunc = itemData.isGotFunc
  self.isShowRing = itemData.isShowRing
  self.redFunc = itemData.redFunc
  self.isRelic = itemData.isRelic
  self.bpDoubleFunc = itemData.bpDoubleFunc
  self.darkShowFunc = itemData.darkShowFunc
  self.icon = itemData.icon
  self.showFlowingLightFunc = itemData.showFlowingLightFunc
  self.tipPosY = itemData.tipPosY
  self.tipPosX = itemData.tipPosX
  self.extraDescBgType = itemData.extraDescBgType
  self.extraDesc = itemData.extraDesc
  self.itemAwardTypeDesc = itemData.itemAwardTypeDesc
  self.isPreview = itemData.isPreview
  self.isolateStreamerMaterialForRectMask = itemData.isolateStreamerMaterialForRectMask
  self.groupFullText = itemData.groupFullText
end

function CommonIconItemType2:OnBind(binder)
  self.binder = binder
  if self.isolateStreamerMaterialForRectMask and self.ui.Group_VX_Streamer then
    local vxRoot = self.ui.Group_VX_Streamer
    local vxGo = vxRoot.gameObject and vxRoot.gameObject or vxRoot
    UIParticleStreamerMaterialUtil.TryIsolateStreamerGroup(vxGo)
  end
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:BindLongPressButton(self.ui.Btn_Click, function()
  end, System.fn(self, self.OnClickItem), tonumber(DT.GetConstant("ItemAddPressTime")))
  if self.ui.Text_Article_Number then
    binder:BindToText(self.ui.Text_Article_Number, function()
      if self.isPreview then
        self:SpecialShowCntDesc("")
        return
      else
        do return LT.Text end
        return LT.Text, self.itemCount.value, ""
      end
    end)
  end
  if self.ui.Text_C_First_Tips then
    binder:BindToText(self.ui.Text_C_First_Tips, function()
      if self.itemAwardTypeDesc then
        return self.itemAwardTypeDesc
      end
      if not self.itemAwardType then
        return ""
      end
      local topLabelStr = itemAwardTypeDescMap[self.itemAwardType]
      do return LT.Text end
      return LT.Text, topLabelStr
    end)
  end
  binder:BindToVisible(self.ui.Icon_Role, function()
    do return self._IsAwakerImage end
    return self._IsAwakerImage, self
  end)
  binder:BindToVisible(self.ui.Icon_Common, function()
    return not self:_IsAwakerImage()
  end)
  binder:BindToVisible(self.ui.Group_Expression, function()
    do return self._IsEmojiItem end
    return self._IsEmojiItem, self
  end)
  binder:BindToImage(self.ui.Icon_Role, function()
    if not self:_IsAwakerImage() then
      return ""
    end
    if self.isRelic then
      return ""
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
    if self.itemTid and self.itemTid.value then
      do return ItemDataUtils.GetItemIcon end
      return ItemDataUtils.GetItemIcon, self.itemTid.value, true, self.curSkin
    end
    return ""
  end)
  binder:BindToImage(self.ui.Icon_Common, function()
    if self:_IsAwakerImage() then
      return ""
    end
    if self.icon then
      return self.icon
    end
    if self.itemTid and self.itemTid.value then
      if self.isRelic then
        do return RelicDataUtils.GetRelicIcon end
        return RelicDataUtils.GetRelicIcon, self.itemTid.value
      end
      do return ItemDataUtils.GetItemIcon end
      return ItemDataUtils.GetItemIcon, self.itemTid.value
    end
    return ""
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local config = DT.Item[self.itemTid.value]
    if self.awakerId then
      config = DT.AwakerConfig[self.awakerId]
    elseif self.isRelic then
      config = RelicDataUtils.GetRelicConfig(self.itemTid.value)
    end
    if config then
      do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
      return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
    end
    return ""
  end)
  binder:BindToImage(self.ui.Image_Occupation, function()
    if self.awakerId then
      local awakerConfig = DT.AwakerConfig[self.awakerId]
      local schoolConfig = DT.SchoolConfig[awakerConfig.School]
      return schoolConfig.Icon or ""
    end
    return ""
  end)
  if self.bpDoubleFunc then
    binder:BindToVisible(self.ui.Group_Tab_Double, self.bpDoubleFunc)
  end
  binder:BindToVisible(self.ui.Group_VX_Streamer, function()
    return self.isShowRing and self.isShowRing() or false
  end)
  if self.ui.Image_AwakerFavor_Max then
    binder:BindToVisible(self.ui.Image_AwakerFavor_Max, function()
      local awakerTid = self:_GetAwakerTid()
      if not awakerTid then
        return false
      end
      do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid, AwakerDataUtils.GetAwakerData(awakerTid) end
      return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid, AwakerDataUtils.GetAwakerData(awakerTid)
    end)
  end
  binder:BindToVisible(self.ui.Group_Get, function()
    if self.isGotFunc then
      do return end
      return self.isGotFunc, nil
    end
    return self.isGot
  end)
  binder:BindToVisible(self.ui.Group_First, function()
    return self.itemAwardType and self.itemAwardType ~= CommonDefine.ItemAwardType.Normal
  end)
  binder:BindToVisible(self.ui.Image_Occupation, function()
    return self.awakerId
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    if self.selectFunc then
      do return end
      return self.selectFunc, nil
    end
    return false
  end)
  binder:BindToVisible(self.ui.Image_Look, function()
    if self.lockFunc then
      do return end
      return self.lockFunc, nil
    end
    return false
  end)
  if self.showFlowingLightFunc then
    binder:BindToRaw(function(_, nVal)
      if true == nVal then
        self.uiAnimationController:StopPlayableGraph()
        self.uiAnimationController:PlayState("UI_Vx_Common_Item_WuPin_Type2_Refurbish_01")
      end
    end, self.showFlowingLightFunc)
  end
  binder:BindComponent(require("UI.Common.RedDotComponent")(self.ui.Group_Sub_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    if self.redFunc then
      do return end
      return self.redFunc, nil
    end
    return false
  end))
  binder:BindToVisible(self.ui.Image_Claimed, System.fn(self, self._OnDarkImageVisible))
  binder:BindToVisible(self.ui.Group_Sub_Awaker_Head, System.fn(self, self._OnExtraOriginVisible))
  binder:BindToVisible(self.ui.Group_Tab_Special, System.fn(self, self._OnExtraDescVisible))
  binder:BindToImage(self.ui.Icon_Awaker, System.fn(self, self._GetExtraOriginAwakerIcon))
  binder:BindToRaw(function(_, nVal)
    local text = self:_GetExtraDescText()
    self:_CheckTabTextOverflow(text)
  end, function()
    return self.itemTid.value
  end)
  self:_OnBindBottomQualityFrame()
  self:OnBindExtraDescBg()
  self:_OnBindSkinItem()
  self:_OnBindGroupFull()
end

function CommonIconItemType2:_OnBindSkinItem()
  local skinTid = AwakerSkinUtils.GetSkinByItem(self.itemTid.value)
  if not skinTid then
    self.binder:SetActive(self.ui.Text_Article_Number, true)
    self.binder:SetActive(self.ui.Group_Skin, false)
    return
  end
  self.binder:SetActive(self.ui.Text_Article_Number, false)
  self.binder:SetActive(self.ui.Group_Skin, true)
  self.binder:SetActive(self.ui.Image_SkinQuality, true)
  self.binder:BindToImage(self.ui.Image_SkinQuality, function()
    do return AwakerSkinCfgUtils.GetSkinItemQualityBottomImage end
    return AwakerSkinCfgUtils.GetSkinItemQualityBottomImage, skinTid
  end)
  AwakerUiUtils.RefreshAwakerSkinStarGroup(self, self.binder, skinTid)
end

function CommonIconItemType2:_OnBindBottomQualityFrame()
  self.binder:BindToVisible(self.ui.Image_Quality, function()
    local config = DT.Item[self.itemTid.value]
    if self.awakerId then
      config = DT.AwakerConfig[self.awakerId].Quality
    elseif self.isRelic then
      config = RelicDataUtils.GetRelicConfig(self.itemTid.value)
    end
    return config
  end)
end

function CommonIconItemType2:_OnDarkImageVisible()
  if self.darkShowFunc then
    do return end
    return self.darkShowFunc
  end
  return false
end

function CommonIconItemType2:_OnExtraDescVisible()
  if self.extraDesc or self.extraDescFunc then
    return true
  end
  if self.itemTid and self.itemTid.value == CommonDefine.CurrencyType.FreePayMoney then
    return true
  end
  do return self._OnExtraOriginVisible end
  return self._OnExtraOriginVisible, self
end

function CommonIconItemType2:_OnExtraOriginVisible()
  return self.extraOrigin and self.extraOrigin > 0
end

function CommonIconItemType2:_GetExtraOriginAwakerIcon()
  if not self.extraOrigin or self.extraOrigin <= 0 then
    return
  end
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  do return AwakerDataUtils.GetCircleHeadIcon end
  return AwakerDataUtils.GetCircleHeadIcon, self.extraOrigin
end

function CommonIconItemType2:_GetExtraDescText()
  if self.extraDesc then
    return self.extraDesc
  end
  if self.extraDescFunc then
    do return end
    return self.extraDescFunc, nil
  end
  if self.itemTid and self.itemTid.value == CommonDefine.CurrencyType.FreePayMoney then
    do return LT.Text end
    return LT.Text, "GiveAwayItem"
  end
  do return self._GetExtraOriginDesc end
  return self._GetExtraOriginDesc, self
end

function CommonIconItemType2:_CheckTabTextOverflow(text)
  if not text then
    return
  end
  if not self.ui.TabView or not self.ui.Text_View_Tab then
    self.binder:SetActive(self.ui.Text_Tab_Special, true)
    self.binder:SetText(self.ui.Text_Tab_Special, text)
    return
  end
  self.binder:SetText(self.ui.Text_Tab_Special, text)
  local tmpComp = self.ui.Text_Tab_Special:GetComponent(TYPEOF_TMP_Text)
  if not tmpComp then
    return
  end
  tmpComp:ForceMeshUpdate()
  if tmpComp.preferredWidth <= TabTextOverflowThreshold then
    self.binder:SetActive(self.ui.Text_Tab_Special, true)
    self.binder:SetActive(self.ui.TabView, false)
  else
    self.binder:SetActive(self.ui.Text_Tab_Special, false)
    self.binder:SetActive(self.ui.TabView, true)
    self.binder:SetText(self.ui.Text_View_Tab, text)
    local scrollComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_View_Tab.gameObject, 0, 0, 5, 15, false)
    if scrollComp then
      scrollComp:SetBtn(self.ui.Btn_Click)
      scrollComp.waitingTime = 2
    end
  end
end

function CommonIconItemType2:_GetExtraOriginDesc()
  if not self.extraOrigin or self.extraOrigin <= 0 then
    return
  end
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  do return AwakerDataUtils.GetSpecialSkillOriginDescByAwaker end
  return AwakerDataUtils.GetSpecialSkillOriginDescByAwaker, self.extraOrigin
end

function CommonIconItemType2:OnClickItem()
  if self.clickFunc then
    self.clickFunc()
    return
  end
  if self.isRelic then
    return
  end
  if self.itemTid.value then
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.itemTid.value, nil, {
      posY = self.tipPosY,
      posX = self.tipPosX
    })
  end
end

function CommonIconItemType2:UpdateItemTid(itemTid)
  itemTid = itemTid or 0
  self.itemTid.value = itemTid
end

function CommonIconItemType2:UpdateItemCount(count)
  if not count then
    return
  end
  self.itemCount.value = count
end

function CommonIconItemType2:UpdateClickFunc(clickFunc)
  self.clickFunc = clickFunc
end

function CommonIconItemType2:UpdateSelectFunc(selectFunc)
  self.selectFunc = selectFunc
end

function CommonIconItemType2:SetActive(active)
  self.binder:SetActive(self.ui.uiNode, active)
end

function CommonIconItemType2:OnBindExtraDescBg()
  if not self.extraDescBgType then
    return
  end
  local goName = extraDescBgType2GoNameMap[self.extraDescBgType]
  if not goName then
    return
  end
  local go = self.ui[goName]
  if not go then
    return
  end
  self.ui.Group_Tab_Special_Bg_Default:SetActive(false)
  go:SetActive(true)
end

function CommonIconItemType2:_GetAwakerTid()
  if self.awakerId then
    return self.awakerId
  end
  if self:_IsAwakerImage() then
    do return ItemDataUtils.GetAwakerTidByItemTid end
    return ItemDataUtils.GetAwakerTidByItemTid, self.itemTid.value
  end
  return nil
end

function CommonIconItemType2:_IsAwakerImage()
  if self.awakerId then
    return true
  end
  local isAwakerItem = false
  if self.isRelic then
    return false
  end
  if self.itemTid and self.itemTid.value and 0 ~= self.itemTid.value then
    isAwakerItem = ItemDataUtils.GetItemType(self.itemTid.value) == CommonDefine.ItemType.AwakerItem
  end
  return isAwakerItem
end

function CommonIconItemType2:_IsEmojiItem()
  local specType = false
  local emojiType = false
  if self.itemTid and self.itemTid.value and 0 ~= self.itemTid.value then
    specType = ItemDataUtils.GetItemType(self.itemTid.value) == CommonDefine.ItemType.Special
    emojiType = ItemDataUtils.GetItemSubType(self.itemTid.value) == CommonDefine.ItemSubType.Emoji
  end
  return specType and emojiType
end

function CommonIconItemType2:SpecialShowCntDesc(cntDesc)
  self.binder:SetText(self.ui.Text_Article_Number, cntDesc)
end

function CommonIconItemType2:SetIsGot(isGot)
  self.isGot = isGot
  self.ui.Group_Get:SetActive(isGot)
end

function CommonIconItemType2:SetShowRing(isShow)
  self.ui.Group_VX_Streamer:SetActive(isShow)
end

function CommonIconItemType2:_OnBindGroupFull()
  self.binder:SetText(self.ui.Text_C_Full, self.groupFullText)
  self.binder:SetActive(self.ui.Group_Full, self.groupFullText)
end

return CommonIconItemType2
