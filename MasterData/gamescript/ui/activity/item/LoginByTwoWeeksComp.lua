local LoginByTwoWeeksComp, Super = System.NewClass("LoginByTwoWeeksComp", LoginByMonthComp)

function LoginByTwoWeeksComp:OnBind(binder)
  Super.OnBind(self, binder)
  self:_BindSkinTaskComp({isHideTime = true})
end

function LoginByTwoWeeksComp:_InitUIRes(res)
  self.ui = UI_Events_Panel_TwoWeekSignResource(res)
end

return LoginByTwoWeeksComp
