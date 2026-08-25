local ShareTwoWeaponView, Super = NewClass("ShareTwoWeaponView", BaseView)
ShareTwoWeaponView.uiResCls = UI_Summon_Panel_Share_Weapon2Resource

function ShareTwoWeaponView:ctor(itemId, itemId2, poolId)
  Super.ctor(self)
  self.itemId = itemId
  self.itemId2 = itemId2
  self.poolId = poolId
end

function ShareTwoWeaponView:OnBuildView()
  Super.OnBuildView(self)
  self.awakerDescComp = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleText01, ShareAwakerDescComp, self.itemId)
  self.awakerDescComp02 = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleText02, ShareAwakerDescComp, self.itemId2)
end

function ShareTwoWeaponView:RegisterNotifications()
  Super.RegisterNotifications(self)
end

function ShareTwoWeaponView:RegisterEvents()
  Super.RegisterEvents(self)
end

function ShareTwoWeaponView:OnEnterView()
  Super.OnEnterView(self)
  self.hasSchoolImgMap = self:_GetSchoolImgMap()
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
end

function ShareTwoWeaponView:OnExitView()
  Super.OnExitView(self)
end

function ShareTwoWeaponView:_RefreshText()
  local playerName = DataCenter.playerData.DRole.name
  self:SetText(self.ui.Text_Player_Name, playerName)
  local uid = DataCenter.playerData.DRole.uid
  self:SetText(self.ui.Text_ID, uid)
end

function ShareTwoWeaponView:_RefreshImage()
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  self:SetImageSync(self.ui.Basemap, poolCfg.BaseMap)
  if self.hasSchoolImgMap then
    self:SetImageSync(self.ui.Basemap_2, self.hasSchoolImgMap)
  end
  local itemCfg = DT.Item[self.itemId]
  self:SetImageSync(self.ui.Image_Weapon1, itemCfg.SpIcon)
  itemCfg = DT.Item[self.itemId2]
  self:SetImageSync(self.ui.Image_Weapon2, itemCfg.SpIcon)
  local headRes = self:_GetHeadRes()
  self:SetImage(self.ui.Image_Awaker_Head, headRes)
end

function ShareTwoWeaponView:_RefreshVisible()
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  if not self.hasSchoolImgMap then
    self.ui.Basemap_2:SetActive(false)
  end
  self:_SetSchoolInfoImgVisible()
  self.ui.Image_Role:SetActive(true)
end

function ShareTwoWeaponView:_GetSchoolImgMap()
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  local schoolId = poolCfg.ShowSchool
  local schoolImgMap = {
    [CommonDefine.AwakerSchool.Aequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_HunDun.png",
    [CommonDefine.AwakerSchool.Caro] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_XueRou.png",
    [CommonDefine.AwakerSchool.Dimension] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ChaoWei.png",
    [CommonDefine.AwakerSchool.NewAequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ShenHai.png"
  }
  local path = schoolImgMap[schoolId]
  return path
end

function ShareTwoWeaponView:_GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareTwoWeaponView:_SetSchoolInfoImgVisible()
  local schoolInfoImg = {
    [CommonDefine.AwakerSchool.Aequor] = self.ui.Group_Line_HunDun,
    [CommonDefine.AwakerSchool.Caro] = self.ui.Group_Line_XueRou,
    [CommonDefine.AwakerSchool.Dimension] = self.ui.Group_Line_ChaoWei,
    [CommonDefine.AwakerSchool.NewAequor] = self.ui.Group_Line_ShenHai
  }
  for school, v in pairs(schoolInfoImg) do
    v:SetActive(false)
  end
end

function ShareTwoWeaponView:Close()
  Super.Close(self)
end

return ShareTwoWeaponView
