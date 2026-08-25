local ShareTwoAwakerPanel, Super = System.NewClass("ShareTwoAwakerPanel", UIBasePanel)
ShareTwoAwakerPanel.uiResCls = UI_Summon_Panel_Share_Role2Resource

function ShareTwoAwakerPanel:ctor(itemId, itemId2, poolId)
  Super.ctor(self)
  self.itemId = itemId
  self.itemId2 = itemId2
  self.poolId = poolId
end

function ShareTwoAwakerPanel:OnBind(binder)
  self.binder = binder
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemId)
  local awakerCfg = DT.AwakerConfig[awakerTid]
  self.awakerDescCom = binder:BindComponent(ShareAwakerDescCom(self.ui.UI_Summon_Panel_Share_RoleText, self.itemId))
  self.awakerDescCom02 = binder:BindComponent(ShareAwakerDescCom(self.ui.UI_Summon_Panel_Share_RoleText02, self.itemId2))
  self.awakerSloganCom = binder:BindComponent(ShareAwakerSloganCom(self.ui.UI_Summon_Panel_Share_RoleInfo01, self.itemId))
  self.awakerSloganCom02 = binder:BindComponent(ShareAwakerSloganCom(self.ui.UI_Summon_Panel_Share_RoleInfo02, self.itemId2))
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  binder:SetImageSync(self.ui.Basemap, poolCfg.BaseMap)
  local schoolId = awakerCfg.School
  local schoolImgMap = {
    [CommonDefine.AwakerSchool.Aequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_HunDun.png",
    [CommonDefine.AwakerSchool.Caro] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_XueRou.png",
    [CommonDefine.AwakerSchool.Dimension] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ChaoWei.png",
    [CommonDefine.AwakerSchool.NewAequor] = "Icon/Summon_Mask/UI_Summon_Bg_Mask_ShenHai.png"
  }
  binder:SetImageSync(self.ui.Basemap_2, schoolImgMap[schoolId])
  self.ui.Container_Awaker:SetActive(true)
  self.portaitComp = binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, awakerTid))
  local awakerTid2 = ItemDataUtils.GetAwakerTidByItemTid(self.itemId2)
  self.ui.Container_Awaker_02:SetActive(true)
  self.portaitComp02 = binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker_02, awakerTid2))
  self:SetPlayerInfoVisible()
end

function ShareTwoAwakerPanel:SetPlayerInfoVisible()
  self.ui.Image_Role:SetActive(true)
  local playerName = DataCenter.playerData.DRole.name
  local uid = DataCenter.playerData.DRole.uid
  local headRes = self:GetHeadRes()
  self.binder:SetImage(self.ui.Image_Awaker_Head, headRes)
  self.binder:SetText(self.ui.Text_Player_Name, playerName)
  self.binder:SetText(self.ui.Text_ID, uid)
end

function ShareTwoAwakerPanel:GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareTwoAwakerPanel:Close()
  Super.Close(self)
end

return ShareTwoAwakerPanel
