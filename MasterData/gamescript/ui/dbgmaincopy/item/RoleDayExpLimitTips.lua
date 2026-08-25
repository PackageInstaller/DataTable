local RoleDayExpLimitTips, Super = System.NewComponent("RoleDayExpLimitTips")

function RoleDayExpLimitTips:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Pvp_Out_ManifestationResource(uiNode)
end

function RoleDayExpLimitTips:OnBind(binder)
  binder:SetText(self.ui.Text_Description, LT.Text("RoleDayExpLimit"))
  binder:BindToRaw(function()
    local dayExp = PlayerDataUtils.GetRoleData().dayExp or 0
    local dayLimit = PlayerDataUtils.GetRoleDayExpLimit()
    binder:SetText(self.ui.Text_Quantity, string.format("%s/%s", dayExp, dayLimit))
  end, function()
    return {
      PlayerDataUtils.GetRoleData().dayExp,
      PlayerDataUtils.GetRoleDayExpLimit()
    }
  end)
  self.ui.Group_Icon:SetActive(true)
  binder:BindButtonClick(self.ui.Btn_Icon, function()
    local title = LT.Text("RoleDayExpLimit")
    local content = LT.Textf("PVPandDailyChallengeExpTips", PlayerDataUtils.GetRoleDayExpLimit(), PlayerDataUtils.GetRoleData().dayExp or 0)
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
  end)
end

return RoleDayExpLimitTips
