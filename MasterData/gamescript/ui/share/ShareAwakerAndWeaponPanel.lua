local ShareAwakerAndWeaponPanel, Super = System.NewClass("ShareAwakerAndWeaponPanel", UIBasePanel)
ShareAwakerAndWeaponPanel.uiResCls = UI_Summon_Panel_Share_RoleWeaponResource

function ShareAwakerAndWeaponPanel:ctor(awakerItemId, weaponItemId, poolId)
  Super.ctor(self)
  self.awakerItemId = awakerItemId
  self.weaponItemId = weaponItemId
  self.poolId = poolId
end

function ShareAwakerAndWeaponPanel:OnBind(binder)
  self.binder = binder
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  self:SetAwaker()
  self:SetWeapon()
  self:SetPlayerInfoVisible()
end

function ShareAwakerAndWeaponPanel:SetAwaker()
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.awakerItemId)
  local awakerCfg = DT.AwakerConfig[awakerTid]
  self.awakerDescCom = self.binder:BindComponent(ShareAwakerDescCom(self.ui.UI_Summon_Panel_Share_RoleText01, self.awakerItemId))
  self.awakerSloganCom = self.binder:BindComponent(ShareAwakerSloganCom(self.ui.UI_Summon_Panel_Share_RoleInfo01, self.awakerItemId))
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  self.binder:SetImageSync(self.ui.Basemap, poolCfg.BaseMap)
  local schoolId = awakerCfg.School
  local schoolImgMap = {
    [CommonDefine.AwakerSchool.Aequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_HunDun.png",
    [CommonDefine.AwakerSchool.Caro] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_XueRou.png",
    [CommonDefine.AwakerSchool.Dimension] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ChaoWei.png",
    [CommonDefine.AwakerSchool.NewAequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ShenHai.png"
  }
  self.binder:SetImageSync(self.ui.Basemap_2, schoolImgMap[schoolId])
  self.ui.Container_Awaker_01:SetActive(true)
  self.portaitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker_01, awakerTid))
end

function ShareAwakerAndWeaponPanel:SetWeapon()
  local itemCfg = DT.Item[self.weaponItemId]
  self.weaponDescCom = self.binder:BindComponent(ShareAwakerDescCom(self.ui.UI_Summon_Panel_Share_RoleText02, self.weaponItemId))
  self.binder:SetImageSync(self.ui.Image_Weapon2, itemCfg.SpIcon)
end

function ShareAwakerAndWeaponPanel:SetPlayerInfoVisible()
  self.ui.Image_Role:SetActive(true)
  local playerName = DataCenter.playerData.DRole.name
  local uid = DataCenter.playerData.DRole.uid
  local headRes = self:GetHeadRes()
  self.binder:SetImage(self.ui.Image_Awaker_Head, headRes)
  self.binder:SetText(self.ui.Text_Player_Name, playerName)
  self.binder:SetText(self.ui.Text_ID, uid)
end

function ShareAwakerAndWeaponPanel:GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareAwakerAndWeaponPanel:Close()
  Super.Close(self)
end

return ShareAwakerAndWeaponPanel
