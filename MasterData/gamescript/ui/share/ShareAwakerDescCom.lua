local ShareAwakerDescCom, Super = System.NewComponent("ShareAwakerDescCom")

function ShareAwakerDescCom:ctor(uiNode, itemId)
  Super.ctor(self)
  self.ui = UI_Summon_Panel_Share_RoleTextResource(uiNode)
  self.itemId = itemId
end

function ShareAwakerDescCom:OnBind(binder)
  self.binder = binder
  local itemCfg = DT.Item[self.itemId]
  if itemCfg.Type == CommonDefine.ItemType.Weapon then
    self.binder:SetText(self.ui.Text_Name, LT.Text(itemCfg.Name))
    self.binder:SetText(self.ui.Text_Name_type, "")
    local itemLogo = CommonDefine.SummonItemLogo[itemCfg.Quality]
    self.binder:SetImageSync(self.ui.Image_Positioning, itemLogo.NormalSmall)
  elseif itemCfg.Type == cd.ItemType.SkinItem then
    self.binder:SetText(self.ui.Text_Name, LT.Text(itemCfg.Name))
    self.binder:SetText(self.ui.Text_Name_type, LT.Text("AwakerSkinTypeName"))
    self.binder:SetImageSync(self.ui.Image_Positioning, CommonRes.SummonSkin.Normal)
  else
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemId)
    local awakerCfg = DT.AwakerConfig[awakerTid]
    self.binder:SetText(self.ui.Text_Name, LT.Text(awakerCfg.Name))
    self.binder:SetText(self.ui.Text_Name_type, LT.Text(DT.CommonID[awakerCfg.Type].Desc))
    local schoolCfg = DT.SchoolConfig[awakerCfg.School]
    local schoolLogo = AwakerDataUtils.GetSummonSchoolLogo(schoolCfg.NameEn, awakerCfg.Quality)
    self.binder:SetImageSync(self.ui.Image_Positioning, schoolLogo.NormalSmall)
  end
end

return ShareAwakerDescCom
