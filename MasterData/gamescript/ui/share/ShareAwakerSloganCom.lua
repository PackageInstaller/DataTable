local ShareAwakerSloganCom, Super = System.NewComponent("ShareAwakerSloganCom")

function ShareAwakerSloganCom:ctor(uiNode, itemId)
  Super.ctor(self)
  self.ui = UI_Summon_Panel_Share_RoleInfoResource(uiNode)
  self.itemId = itemId
end

function ShareAwakerSloganCom:OnBind(binder)
  self.binder = binder
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemId)
  local awakerCfg = DT.AwakerConfig[awakerTid]
  local schoolId = awakerCfg.School
  local roleInfoImg = {
    [CommonDefine.AwakerSchool.Aequor] = self.ui.Image_HunDun,
    [CommonDefine.AwakerSchool.Caro] = self.ui.Image_XueRou,
    [CommonDefine.AwakerSchool.Dimension] = self.ui.Image_ChaoWei,
    [CommonDefine.AwakerSchool.NewAequor] = self.ui.Image_ShenHai
  }
  for school, v in pairs(roleInfoImg) do
    v:SetActive(school == schoolId)
  end
  binder:SetText(self.ui.Text_Info_01, LT.Text(awakerCfg.SummonSlogan or ""))
end

return ShareAwakerSloganCom
