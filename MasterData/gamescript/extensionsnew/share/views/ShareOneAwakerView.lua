local ShareOneAwakerView, Super = NewClass("ShareOneAwakerView", BaseView)
ShareOneAwakerView.uiResCls = UI_Summon_Panel_Share_Role1Resource

function ShareOneAwakerView:ctor(itemId, _, poolId)
  Super.ctor(self)
  self.itemId = itemId
  self.poolId = poolId
  self.awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemId)
end

function ShareOneAwakerView:OnBuildView()
  Super.OnBuildView(self)
  self.awakerDescComp = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleText, ShareAwakerDescComp, self.itemId)
  self.awakerSloganCom = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleInfo, ShareAwakerSloganComp, self.itemId)
  self.portaitComp = self:AddViewComponent(self.ui.Container_Awaker, UICompAwakerPortrait, {
    awakerTid = self.awakerTid,
    portraitType = CommonDefine.PortraitType.Middle,
    allowFaceChange = true
  })
  self:LoadAllLangFont(self.ui.Text_Player_Name)
end

function ShareOneAwakerView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
end

function ShareOneAwakerView:OnExitView()
  Super.OnExitView(self)
end

function ShareOneAwakerView:_RefreshText()
  local playerName = DataCenter.playerData.DRole.name
  self:SetText(self.ui.Text_Player_Name, playerName)
  local uid = DataCenter.playerData.DRole.uid
  self:SetText(self.ui.Text_ID, uid)
end

function ShareOneAwakerView:_RefreshImage()
  local awakerCfg = DT.AwakerConfig[self.awakerTid]
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  self:SetImageSync(self.ui.Basemap, poolCfg.BaseMap)
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

function ShareOneAwakerView:_RefreshVisible()
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  self.ui.Image_Role:SetActive(true)
end

function ShareOneAwakerView:_GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareOneAwakerView:Close()
  Super.Close(self)
end

return ShareOneAwakerView
