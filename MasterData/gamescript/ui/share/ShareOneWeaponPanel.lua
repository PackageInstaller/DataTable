local ShareOneWeaponPanel, Super = System.NewClass("ShareOneWeaponPanel", UIBasePanel)
ShareOneWeaponPanel.uiResCls = UI_Summon_Panel_Share_Weapon1Resource

function ShareOneWeaponPanel:ctor(itemId, _, poolId)
  Super.ctor(self)
  self.itemId = itemId
  self.poolId = poolId
end

function ShareOneWeaponPanel:OnBind(binder)
  self.binder = binder
  self.ui.Image_Text:SetActive(not Utils.IsLangEN())
  self.ui.Image_Text_EN:SetActive(Utils.IsLangEN())
  self.awakerDescCom = binder:BindComponent(ShareAwakerDescCom(self.ui.UI_Summon_Panel_Share_RoleText, self.itemId))
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
  binder:SetImageSync(self.ui.Image_Weapon, itemCfg.SpIcon)
  local schoolInfoImg = {
    [CommonDefine.AwakerSchool.Aequor] = {
      self.ui.Group_Bg_HunDun,
      self.ui.Group_HunDun
    },
    [CommonDefine.AwakerSchool.Caro] = {
      self.ui.Group_Bg_XueRou,
      self.ui.Group_XueRou
    },
    [CommonDefine.AwakerSchool.Dimension] = {
      self.ui.Group_Bg_ChaoWei,
      self.ui.Group_ChaoWei
    },
    [CommonDefine.AwakerSchool.NewAequor] = {
      self.ui.Group_Bg_ShenHai,
      self.ui.Group_ShenHai
    }
  }
  for school, v in pairs(schoolInfoImg) do
    v[1]:SetActive(false)
    v[2]:SetActive(false)
  end
  self:SetPlayerInfoVisible()
end

function ShareOneWeaponPanel:SetPlayerInfoVisible()
  self.ui.Image_Role:SetActive(true)
  local playerName = DataCenter.playerData.DRole.name
  local uid = DataCenter.playerData.DRole.uid
  local headRes = self:GetHeadRes()
  self.binder:SetImage(self.ui.Image_Awaker_Head, headRes)
  self.binder:SetText(self.ui.Text_Player_Name, playerName)
  self.binder:SetText(self.ui.Text_ID, uid)
end

function ShareOneWeaponPanel:GetHeadRes()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  else
    do return end
    return GenderDataUtils.GetMainHeadRes, avatarItemTid
  end
end

function ShareOneWeaponPanel:Close()
  Super.Close(self)
end

return ShareOneWeaponPanel
