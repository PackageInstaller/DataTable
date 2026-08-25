local ScarletTipPanel, Super = System.NewClass("ScarletTipPanel", UIBasePanel)
ScarletTipPanel.uiResCls = Panel_Information_TentacleResource

function ScarletTipPanel:ctor(role)
  Super.ctor(self)
  self.role = role
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function ScarletTipPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Button_Mask, function()
    self:Close()
  end)
  binder:SetText(self.ui.Text_Tentacle_Desc, self.role:GetSchoolTips(cd.SchoolId.Blood))
  binder:SetText(self.ui.Text_Tentacle_Name, LT.Text("Battle_Tips_BloodName", true))
  binder:SetImage(self.ui.Image_Tentacle_Icon, "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_Image_D_Blood_Active.png")
end

function ScarletTipPanel:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

return ScarletTipPanel
