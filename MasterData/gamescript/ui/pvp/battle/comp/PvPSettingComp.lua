local PvPSettingComp, Super = System.NewComponent("PvPSettingComp")

function PvPSettingComp:ctor(uiNode, mainModel)
  Super.ctor(self)
  self.ui = UI_Pvp_Panel_MainResource(uiNode)
  self.model = mainModel
end

function PvPSettingComp:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Setting, System.fn(self, self._OnClickBtnSetting))
end

function PvPSettingComp:_OnClickBtnSetting()
  UIManager.Instance:Reopen(Urls.SettingMainPanel)
end

return PvPSettingComp
