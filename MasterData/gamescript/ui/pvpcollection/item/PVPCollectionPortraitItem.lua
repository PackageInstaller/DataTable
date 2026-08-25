local PVPCollectionType = CommonDefine.PVPCollectionType
local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local PVPCollectionPortraitItem, Super = System.NewComponent("PVPCollectionPortraitItem")

function PVPCollectionPortraitItem:ctor(uiNode, collectTid, clickCallback)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_Cards_BaseResource(uiNode)
  self.collectTid = collectTid
  self.clickCallback = clickCallback
end

function PVPCollectionPortraitItem:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Image_Icon, System.fn(self, self._GetAwakerCollectionIcon))
  binder:BindToImage(self.ui.Image_Weapon, System.fn(self, self._GetWeaponCollectionIcon))
  binder:BindToImage(self.ui.Image_Key, System.fn(self, self._GetKeeperSkillCollectionIcon))
  binder:SetImage(self.ui.Image_Name_Frame, self:_GetColorFrame())
  binder:BindToText(self.ui.Text_Name, System.fn(self, self._GetCollectionName))
  binder:BindToVisible(self.ui.Image_Icon, System.fn(self, self._IsAwakerIconShow))
  binder:BindToVisible(self.ui.Container_Weapon, System.fn(self, self._IsWeaponIconShow))
  binder:BindToVisible(self.ui.Image_Key, System.fn(self, self._IsKeeperSkillIconShow))
  binder:BindToVisible(self.ui.Image_Mask, System.fn(self, self._IsCollectionLocked))
  binder:BindToVisible(self.ui.TemporaryUnLock, function()
    do return PVPCollectionDataUtils.IsUnlockByBattlePass end
    return PVPCollectionDataUtils.IsUnlockByBattlePass, self.collectTid
  end)
  binder:BindButtonClick(self.ui.uiNode, System.fn(self, self._OnClick))
  self.autoAdaptionTextComp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name, 0, 0, 0, nil, true)
  if self.autoAdaptionTextComp then
    self.autoAdaptionTextComp:SetBtn(self.ui.uiNode)
    local cfg_adaption = {
      fontSize = 34,
      autoSizeCN = true,
      autoSizeOther = true,
      alignmentCN = TextAlignmentOptions.Center,
      alignmentOther = TextAlignmentOptions.Center,
      widthCN = 246,
      widthOther = 246,
      height = 44,
      x = 0,
      y = 0,
      pivotX = 0.5,
      pivotY = 0.5,
      anchorX = 0.5,
      anchorY = 0.5,
      contentSize = 246
    }
    local cfg_init = {
      fontSize = 34,
      autoSizeCN = true,
      autoSizeOther = true,
      alignmentCN = TextAlignmentOptions.Center,
      alignmentOther = TextAlignmentOptions.Left,
      widthCN = 246,
      widthOther = 246,
      height = 44,
      x = 0,
      y = 0,
      pivotX = 0,
      pivotY = 0.5,
      anchorX = 0,
      anchorY = 0.5,
      contentSize = 246
    }
    if self.OnDrag and self.OnBeginDrag then
      self.autoAdaptionTextComp:SetDragDelegate(self)
    end
    self.autoAdaptionTextComp:ForceUpdate({
      limitPercent = 1,
      lineLimit = 4,
      miniFontSize = 18,
      maxFontSize = 34,
      initCfg = cfg_init,
      adaptionCfg = cfg_adaption
    })
  end
end

function PVPCollectionPortraitItem:_GetAwakerCollectionIcon()
  if not self:_IsAwakerIconShow() then
    return
  end
  do return PVPCollectionDataUtils.GetCollectionPotrait end
  return PVPCollectionDataUtils.GetCollectionPotrait, self.collectTid
end

function PVPCollectionPortraitItem:_GetWeaponCollectionIcon()
  if not self:_IsWeaponIconShow() then
    return
  end
  do return PVPCollectionDataUtils.GetCollectionPotrait end
  return PVPCollectionDataUtils.GetCollectionPotrait, self.collectTid
end

function PVPCollectionPortraitItem:_GetKeeperSkillCollectionIcon()
  if not self:_IsKeeperSkillIconShow() then
    return
  end
  do return PVPCollectionDataUtils.GetCollectionPotrait end
  return PVPCollectionDataUtils.GetCollectionPotrait, self.collectTid
end

function PVPCollectionPortraitItem:_GetCollectionName()
  if self:_IsKeeperSkillIconShow() and self:_IsCollectionLocked() then
    do return PvpCollectCfgUtils.GetKeeperSkillPosseUnknowDesc end
    return PvpCollectCfgUtils.GetKeeperSkillPosseUnknowDesc, self.collectTid
  end
  do return PvpCollectCfgUtils.GetCollectionName end
  return PvpCollectCfgUtils.GetCollectionName, self.collectTid
end

function PVPCollectionPortraitItem:_GetColorFrame()
  do return PVPCollectionDataUtils.GetCollectionNameFrameImage end
  return PVPCollectionDataUtils.GetCollectionNameFrameImage, self.collectTid
end

function PVPCollectionPortraitItem:_IsAwakerIconShow()
  local collectType = PvpCollectCfgUtils.GetCollectionType(self.collectTid)
  if not collectType then
    return false
  end
  return collectType == PVPCollectionType.Awaker
end

function PVPCollectionPortraitItem:_IsWeaponIconShow()
  local collectType = PvpCollectCfgUtils.GetCollectionType(self.collectTid)
  if not collectType then
    return false
  end
  return collectType == PVPCollectionType.Weapon
end

function PVPCollectionPortraitItem:_IsKeeperSkillIconShow()
  local collectType = PvpCollectCfgUtils.GetCollectionType(self.collectTid)
  if not collectType then
    return false
  end
  return collectType == PVPCollectionType.KeeperSkill
end

function PVPCollectionPortraitItem:_IsCollectionLocked()
  return not PVPCollectionDataUtils.HasOwnedCollection(self.collectTid)
end

function PVPCollectionPortraitItem:_OnClick()
  if self.clickCallback then
    self.clickCallback()
  end
end

return PVPCollectionPortraitItem
