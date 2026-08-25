local LoginByThreeWeeksComp, Super = System.NewClass("LoginByThreeWeeksComp", LoginByMonthComp)

function LoginByThreeWeeksComp:OnBind(binder)
  Super.OnBind(self, binder)
  self:_BindSkinTaskComp()
end

function LoginByThreeWeeksComp:_InitUIRes(res)
  self.ui = UI_Events_Panel_ThreeWeekResource(res)
end

return LoginByThreeWeeksComp
