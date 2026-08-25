local ShareAwakerDescComp, Super = NewViewComponent("ShareAwakerDescComp")

function ShareAwakerDescComp:ctor(uiNode, view, itemId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Summon_Panel_Share_RoleTextResource(uiNode)
  self.itemId = itemId
  self.itemCfg = DT.Item[self.itemId]
  self.awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemId)
  self.awakerCfg = DT.AwakerConfig[self.awakerTid]
end

function ShareAwakerDescComp:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshText()
  self:_RefreshImage()
end

function ShareAwakerDescComp:OnExitComponent()
  Super.OnExitComponent(self)
end

function ShareAwakerDescComp:_RefreshText()
  local itemType = self.itemCfg.Type
  if itemType == CommonDefine.ItemType.Weapon then
    self:SetText(self.ui.Text_Name, LT.Text(self.itemCfg.Name))
    self:SetText(self.ui.Text_Name_type, "")
  elseif itemType == CommonDefine.ItemType.SkinItem then
    self:SetText(self.ui.Text_Name, LT.Text(self.itemCfg.Name))
    self:SetText(self.ui.Text_Name_type, LT.Text("AwakerSkinTypeName"))
  else
    self:SetText(self.ui.Text_Name, LT.Text(self.awakerCfg.Name))
    self:SetText(self.ui.Text_Name_type, LT.Text(DT.CommonID[self.awakerCfg.Type].Desc))
  end
end

function ShareAwakerDescComp:_RefreshImage()
  local itemType = self.itemCfg.Type
  if itemType == CommonDefine.ItemType.Weapon then
    local itemLogo = CommonDefine.SummonItemLogo[self.itemCfg.Quality]
    self:SetImageSync(self.ui.Image_Positioning, itemLogo.NormalSmall)
  elseif itemType == CommonDefine.ItemType.SkinItem then
    self:SetImageSync(self.ui.Image_Positioning, CommonRes.SummonSkin.Normal)
  else
    local schoolCfg = DT.SchoolConfig[self.awakerCfg.School]
    local schoolLogo = AwakerDataUtils.GetSummonSchoolLogo(schoolCfg.NameEn, self.awakerCfg.Quality)
    self:SetImageSync(self.ui.Image_Positioning, schoolLogo.NormalSmall)
  end
end

return ShareAwakerDescComp
