local ShareTwoWeaponPanel, Super = System.NewClass("ShareTwoWeaponPanel", UIBasePanel)
ShareTwoWeaponPanel.uiResCls = UI_Summon_Panel_Share_Weapon2Resource

function ShareTwoWeaponPanel:ctor(itemId, itemId2, poolId)
  Super.ctor(self)
  self.itemId = itemId
  self.itemId2 = itemId2
  self.poolId = poolId
end

function ShareTwoWeaponPanel:OnBind(binder)
  self.binder = binder
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  self.awakerDescCom = binder:BindComponent(ShareAwakerDescCom(self.ui.UI_Summon_Panel_Share_RoleText01, self.itemId))
  self.awakerDescCom02 = binder:BindComponent(ShareAwakerDescCom(self.ui.UI_Summon_Panel_Share_RoleText02, self.itemId2))
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  binder:SetImageSync(self.ui.Basemap, poolCfg.BaseMap)
  local schoolId = poolCfg.ShowSchool
  local schoolImgMap = {
    [CommonDefine.AwakerSchool.Aequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_HunDun.png",
    [CommonDefine.AwakerSchool.Caro] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_XueRou.png",
    [CommonDefine.AwakerSchool.Dimension] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ChaoWei.png",
    [CommonDefine.AwakerSchool.NewAequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ShenHai.png"
  }
  local path = schoolImgMap[schoolId]
  if path then
    binder:SetImageSync(self.ui.Basemap_2, path)
  else
    self.ui.Basemap_2:SetActive(false)
  end
  local itemCfg = DT.Item[self.itemId]
  binder:SetImageSync(self.ui.Image_Weapon1, itemCfg.SpIcon)
  itemCfg = DT.Item[self.itemId2]
  binder:SetImageSync(self.ui.Image_Weapon2, itemCfg.SpIcon)
  local schoolInfoImg = {
    [CommonDefine.AwakerSchool.Aequor] = self.ui.Group_Line_HunDun,
    [CommonDefine.AwakerSchool.Caro] = self.ui.Group_Line_XueRou,
    [CommonDefine.AwakerSchool.Dimension] = self.ui.Group_Line_ChaoWei,
    [CommonDefine.AwakerSchool.NewAequor] = self.ui.Group_Line_ShenHai
  }
  for school, v in pairs(schoolInfoImg) do
    v:SetActive(false)
  end
  self:SetPlayerInfoVisible()
end

function ShareTwoWeaponPanel:Close()
  Super.Close(self)
end

function ShareTwoWeaponPanel:SetPlayerInfoVisible()
  self.ui.Image_Role:SetActive(true)
  local playerName = DataCenter.playerData.DRole.name
  local uid = DataCenter.playerData.DRole.uid
  local headRes = self:GetHeadRes()
  self.binder:SetImage(self.ui.Image_Awaker_Head, headRes)
  self.binder:SetText(self.ui.Text_Player_Name, playerName)
  self.binder:SetText(self.ui.Text_ID, uid)
end

function ShareTwoWeaponPanel:GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

return ShareTwoWeaponPanel
