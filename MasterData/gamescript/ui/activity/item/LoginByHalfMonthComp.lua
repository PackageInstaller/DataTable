local LoginByHalfMonthComp, Super = System.NewClass("LoginByHalfMonthComp", LoginByMonthComp)

function LoginByHalfMonthComp:OnBind(binder)
  Super.OnBind(self, binder)
  self:_BindSkinTaskComp()
end

function LoginByHalfMonthComp:_InitUIRes(res)
  self.ui = UI_Events_Panel_TwoWeekSignResource(res)
end

return LoginByHalfMonthComp
