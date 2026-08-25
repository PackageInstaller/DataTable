local ShareTwoAwakerView, Super = NewClass("ShareTwoAwakerView", BaseView)
ShareTwoAwakerView.uiResCls = UI_Summon_Panel_Share_Role2Resource

function ShareTwoAwakerView:ctor(itemId, itemId2, poolId)
  Super.ctor(self)
  self.itemId = itemId
  self.itemId2 = itemId2
  self.poolId = poolId
  self.awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemId)
  self.awakerTid2 = ItemDataUtils.GetAwakerTidByItemTid(self.itemId2)
end

function ShareTwoAwakerView:OnBuildView()
  Super.OnBuildView(self)
  self.awakerDescCom = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleText, ShareAwakerDescComp, self.itemId)
  self.awakerDescCom02 = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleText02, ShareAwakerDescComp, self.itemId2)
  self.awakerSloganCom = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleInfo01, ShareAwakerSloganComp, self.itemId)
  self.awakerSloganCom02 = self:AddViewComponent(self.ui.UI_Summon_Panel_Share_RoleInfo02, ShareAwakerSloganComp, self.itemId2)
  self.portaitComp = self:AddViewComponent(self.ui.Container_Awaker, UICompAwakerPortrait, {
    awakerTid = self.awakerTid,
    portraitType = CommonDefine.PortraitType.Middle,
    allowFaceChange = true
  })
  self.portaitComp02 = self:AddViewComponent(self.ui.Container_Awaker_02, UICompAwakerPortrait, {
    awakerTid = self.awakerTid2,
    portraitType = CommonDefine.PortraitType.Middle,
    allowFaceChange = true
  })
end

function ShareTwoAwakerView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
end

function ShareTwoAwakerView:OnExitView()
  Super.OnExitView(self)
end

function ShareTwoAwakerView:_RefreshText()
  local playerName = DataCenter.playerData.DRole.name
  self:SetText(self.ui.Text_Player_Name, playerName)
  local uid = DataCenter.playerData.DRole.uid
  self:SetText(self.ui.Text_ID, uid)
end

function ShareTwoAwakerView:_RefreshImage()
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
  local headRes = self:_GetHeadRes()
  self:SetImage(self.ui.Image_Awaker_Head, headRes)
end

function ShareTwoAwakerView:_RefreshVisible()
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  self.ui.Container_Awaker:SetActive(true)
  self.ui.Container_Awaker_02:SetActive(true)
  self.ui.Image_Role:SetActive(true)
end

function ShareTwoAwakerView:_GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareTwoAwakerView:Close()
  Super.Close(self)
end

return ShareTwoAwakerView
