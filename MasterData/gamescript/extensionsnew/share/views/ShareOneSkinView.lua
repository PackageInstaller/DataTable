local ShareOneSkinView, Super = NewClass("ShareOneSkinView", BaseView)
ShareOneSkinView.uiResCls = UI_Summon_Panel_Share_Role1Resource

function ShareOneSkinView:ctor(itemId, _, _)
  Super.ctor(self)
  self.skinTid = itemId
end

function ShareOneSkinView:OnBuildView()
  Super.OnBuildView(self)
  self.awakerDescComp = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleText, ShareAwakerDescComp, self.skinTid)
  self.awakerSloganComp = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleInfo, ShareAwakerSloganComp, self.skinTid)
  local skinResNum = AwakerSkinUtils.GetSkinResNum(self.skinTid)
  self.portaitComp = self:AddViewComponent(self.ui.Container_Awaker, UICompAwakerPortrait, {
    portraitNo = skinResNum,
    portraitType = CommonDefine.PortraitType.Middle
  })
end

function ShareOneSkinView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
end

function ShareOneSkinView:OnExitView()
  Super.OnExitView(self)
end

function ShareOneSkinView:_RefreshText()
  local playerName = DataCenter.playerData.DRole.name
  self:SetText(self.ui.Text_Player_Name, playerName)
  local uid = DataCenter.playerData.DRole.uid
  self:SetText(self.ui.Text_ID, uid)
end

function ShareOneSkinView:_RefreshImage()
  local awakerTid = AwakerSkinUtils.GetAwakerTidBySkin(self.skinTid)
  local awakerCfg = DT.AwakerConfig[awakerTid]
  local schoolId = awakerCfg.School
  local schoolImgMap = {
    [CommonDefine.AwakerSchool.Aequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_HunDun.png",
    [CommonDefine.AwakerSchool.Caro] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_XueRou.png",
    [CommonDefine.AwakerSchool.Dimension] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ChaoWei.png",
    [CommonDefine.AwakerSchool.NewAequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ShenHai.png"
  }
  self:SetImageSync(self.ui.Basemap_2, schoolImgMap[schoolId])
  local headRes = self:_GetHeadRes()
  self:SetImage(self.ui.Image_Awaker_Head, headRes)
end

function ShareOneSkinView:_RefreshVisible()
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  self.ui.Image_Role:SetActive(true)
end

function ShareOneSkinView:_GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareOneSkinView:Close()
  Super.Close(self)
end

return ShareOneSkinView
