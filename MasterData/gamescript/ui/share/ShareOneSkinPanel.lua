local ShareOneSkinPanel, Super = System.NewClass("ShareOneSkinPanel", UIBasePanel)
ShareOneSkinPanel.uiResCls = UI_Summon_Panel_Share_Role1Resource

function ShareOneSkinPanel:ctor(itemId, _, _)
  Super.ctor(self)
  self.skinTid = itemId
end

function ShareOneSkinPanel:OnBind(binder)
  self.binder = binder
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  local awakerTid = AwakerSkinUtils.GetAwakerTidBySkin(self.skinTid)
  local awakerCfg = DT.AwakerConfig[awakerTid]
  self.awakerDescCom = binder:BindComponent(ShareAwakerDescCom(self.ui.UI_Summon_Panel_Share_RoleText, self.skinTid))
  self.awakerSloganCom = binder:BindComponent(ShareAwakerSloganCom(self.ui.UI_Summon_Panel_Share_RoleInfo, self.skinTid))
  local schoolId = awakerCfg.School
  local schoolImgMap = {
    [CommonDefine.AwakerSchool.Aequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_HunDun.png",
    [CommonDefine.AwakerSchool.Caro] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_XueRou.png",
    [CommonDefine.AwakerSchool.Dimension] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ChaoWei.png",
    [CommonDefine.AwakerSchool.NewAequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ShenHai.png"
  }
  binder:SetImageSync(self.ui.Basemap_2, schoolImgMap[schoolId])
  local skinResNum = AwakerSkinUtils.GetSkinResNum(self.skinTid)
  self.portaitComp = binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, nil, skinResNum))
  self:SetPlayerInfoVisible()
end

function ShareOneSkinPanel:SetPlayerInfoVisible()
  self.ui.Image_Role:SetActive(true)
  local playerName = DataCenter.playerData.DRole.name
  local uid = DataCenter.playerData.DRole.uid
  local headRes = self:GetHeadRes()
  self.binder:SetImage(self.ui.Image_Awaker_Head, headRes)
  self.binder:SetText(self.ui.Text_Player_Name, playerName)
  self.binder:SetText(self.ui.Text_ID, uid)
end

function ShareOneSkinPanel:GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareOneSkinPanel:Close()
  Super.Close(self)
end

return ShareOneSkinPanel
