local PVPCollectionType = CommonDefine.PVPCollectionType
local UICompPvpCollectionIcon, Super = NewViewComponent("UICompPvpCollectionIcon")

function UICompPvpCollectionIcon:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Item_List_2Resource(uiNode)
  self:_InitViewData(viewData)
end

function UICompPvpCollectionIcon:OnEnterComponent()
  self:_RefreshView()
end

function UICompPvpCollectionIcon:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
end

function UICompPvpCollectionIcon:_OnClick()
  if self._clickCb then
    self._clickCb(self._collectTid)
  end
end

function UICompPvpCollectionIcon:_InitViewData(viewData)
  self._collectTid = viewData.collectTid
  self._clickCb = viewData.clickCb
  self._collectType = PvpCollectCfgUtils.GetCollectionType(self._collectTid)
end

function UICompPvpCollectionIcon:_GetKeeperSkillCollectionIcon()
  do return PVPCollectionDataUtils.GetKeeperSkillCollectionPortrait end
  return PVPCollectionDataUtils.GetKeeperSkillCollectionPortrait, self._collectTid
end

function UICompPvpCollectionIcon:_GetAwakerCollectionIcon()
  local awakerTid = PvpCollectCfgUtils.GetAwakerTidByCollectTid(self._collectTid)
  if awakerTid then
    do return AwakerDataUtils.GetLittleIcon, awakerTid end
    return AwakerDataUtils.GetLittleIcon, awakerTid, false
  end
  do return PvpCollectCfgUtils.GetCollectionFormationImage end
  return PvpCollectCfgUtils.GetCollectionFormationImage, self._collectTid, false
end

function UICompPvpCollectionIcon:_GetWeaponCollectionIcon()
  do return PvpCollectCfgUtils.GetCollectionFormationImage end
  return PvpCollectCfgUtils.GetCollectionFormationImage, self._collectTid
end

function UICompPvpCollectionIcon:_IsSelected()
  return PvpCollectionModel.Instance:GetSelectCollectionTid() == self._collectTid
end

function UICompPvpCollectionIcon:_RefreshView()
  if self._collectType == PVPCollectionType.Awaker then
    self:_RefreshAwakerCollection()
  elseif self._collectType == PVPCollectionType.Weapon then
    self:_RefreshWeaponCollection()
  elseif self._collectType == PVPCollectionType.KeeperSkill then
    self:_RefreshKeeperSkillCollection()
  end
  self:_RefreshSelectState()
  self:_RefreshUnlockState()
end

function UICompPvpCollectionIcon:_RefreshUnlockState()
  self:SetActive(self.ui.TemporaryUnLock, PVPCollectionDataUtils.IsUnlockByBattlePass(self._collectTid))
  self:SetActive(self.ui.Group_None, not PVPCollectionDataUtils.HasOwnedCollection(self._collectTid))
end

function UICompPvpCollectionIcon:_RefreshSelectState()
  self:SetActive(self.ui.Image_Select, self:_IsSelected())
end

function UICompPvpCollectionIcon:_RefreshAwakerCollection()
  self:SetActive(self.ui.Image_Awaker, true)
  self:SetActive(self.ui.Image_Weapon, false)
  self:SetActive(self.ui.Image_Weapon_Mask, false)
  self:SetImage(self.ui.Image_Awaker, self:_GetAwakerCollectionIcon())
end

function UICompPvpCollectionIcon:_RefreshWeaponCollection()
  self:SetActive(self.ui.Image_Awaker, false)
  self:SetActive(self.ui.Image_Weapon, true)
  self:SetActive(self.ui.Image_Weapon_Mask, true)
  self:SetImage(self.ui.Image_Weapon, self:_GetWeaponCollectionIcon())
end

function UICompPvpCollectionIcon:_RefreshKeeperSkillCollection()
  self:SetActive(self.ui.Image_Awaker, true)
  self:SetActive(self.ui.Image_Weapon, false)
  self:SetActive(self.ui.Image_Weapon_Mask, false)
  self:SetImage(self.ui.Image_Awaker, self:_GetKeeperSkillCollectionIcon())
end

return UICompPvpCollectionIcon
