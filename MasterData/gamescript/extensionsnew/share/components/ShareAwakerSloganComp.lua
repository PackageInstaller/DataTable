local ShareAwakerSloganComp, Super = NewViewComponent("ShareAwakerSloganComp")

function ShareAwakerSloganComp:ctor(uiNode, view, itemId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Summon_Panel_Share_RoleInfoResource(uiNode)
  self.itemId = itemId
  self.awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemId)
  self.awakerCfg = DT.AwakerConfig[self.awakerTid]
end

function ShareAwakerSloganComp:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshText()
  self:_RefreshVisible()
end

function ShareAwakerSloganComp:OnExitComponent()
  Super.OnExitComponent(self)
end

function ShareAwakerSloganComp:_RefreshText()
  local SummonSlogan = LT.Text(self.awakerCfg.SummonSlogan or "")
  self:SetText(self.ui.Text_Info_01, SummonSlogan)
end

function ShareAwakerSloganComp:_RefreshVisible()
  self:_SetRoleInfoImgVisible()
end

function ShareAwakerSloganComp:_SetRoleInfoImgVisible()
  local roleInfoImg = {
    [CommonDefine.AwakerSchool.Aequor] = self.ui.Image_HunDun,
    [CommonDefine.AwakerSchool.Caro] = self.ui.Image_XueRou,
    [CommonDefine.AwakerSchool.Dimension] = self.ui.Image_ChaoWei,
    [CommonDefine.AwakerSchool.NewAequor] = self.ui.Image_ShenHai
  }
  for school, v in pairs(roleInfoImg) do
    v:SetActive(school == self.awakerCfg.School)
  end
end

return ShareAwakerSloganComp
