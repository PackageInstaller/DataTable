local ShareAwakerAndWeaponView, Super = NewClass("ShareAwakerAndWeaponView", BaseView)
ShareAwakerAndWeaponView.uiResCls = UI_Summon_Panel_Share_RoleWeaponResource

function ShareAwakerAndWeaponView:ctor(awakerItemId, weaponItemId, poolId)
  Super.ctor(self)
  self.awakerItemId = awakerItemId
  self.weaponItemId = weaponItemId
  self.poolId = poolId
  self.awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.awakerItemId)
end

function ShareAwakerAndWeaponView:OnBuildView()
  Super.OnBuildView(self)
  self.awakerDescComp = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleText01, ShareAwakerDescComp, self.awakerItemId)
  self.awakerSloganComp = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleInfo01, ShareAwakerSloganComp, self.awakerItemId)
  self.portaitComp = self:AddViewComponent(self.ui.Container_Awaker_01, UICompAwakerPortrait, {
    awakerTid = self.awakerTid,
    portraitType = CommonDefine.PortraitType.Middle,
    allowFaceChange = true
  })
  self.weaponDescComp = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleText02, ShareAwakerDescComp, self.weaponItemId)
end

function ShareAwakerAndWeaponView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
end

function ShareAwakerAndWeaponView:OnExitView()
  Super.OnExitView(self)
end

function ShareAwakerAndWeaponView:_RefreshText()
  local playerName = DataCenter.playerData.DRole.name
  self:SetText(self.ui.Text_Player_Name, playerName)
  local uid = DataCenter.playerData.DRole.uid
  self:SetText(self.ui.Text_ID, uid)
end

function ShareAwakerAndWeaponView:_RefreshImage()
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  self:SetImageSync(self.ui.Basemap, poolCfg.BaseMap)
  local awakerCfg = DT.AwakerConfig[self.awakerTid]
  local schoolId = awakerCfg.School
  local schoolImgMap = {
    [CommonDefine.AwakerSchool.Aequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_HunDun.png",
    [CommonDefine.AwakerSchool.Caro] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_XueRou.png",
    [CommonDefine.AwakerSchool.Dimension] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ChaoWei.png",
    [CommonDefine.AwakerSchool.NewAequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ShenHai.png"
  }
  self:SetImageSync(self.ui.Basemap_2, schoolImgMap[schoolId])
  local itemCfg = DT.Item[self.weaponItemId]
  self:SetImageSync(self.ui.Image_Weapon2, itemCfg.SpIcon)
  local headRes = self:_GetHeadRes()
  self:SetImage(self.ui.Image_Awaker_Head, headRes)
end

function ShareAwakerAndWeaponView:_RefreshVisible()
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  self.ui.Container_Awaker_01:SetActive(true)
  self.ui.Image_Role:SetActive(true)
end

function ShareAwakerAndWeaponView:_GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareAwakerAndWeaponView:Close()
  Super.Close(self)
end

return ShareAwakerAndWeaponView
