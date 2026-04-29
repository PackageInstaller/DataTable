_class("UIDemoPrepare", UIController)
UIDemoPrepare = UIDemoPrepare

function UIDemoPrepare:OnShow(uiParams)
  local txtWp = self:GetUIComponent("UILocalizationText", "txtChangeWeapon")
  local txtName1 = self:GetUIComponent("UILocalizationText", "name1")
  txtName1:SetText(StringTable.Get("str_pet_config_name_narcissus"))
  local txtName2 = self:GetUIComponent("UILocalizationText", "name2")
  txtName2:SetText(StringTable.Get("str_pet_config_name_nord"))
  local txtName3 = self:GetUIComponent("UILocalizationText", "name3")
  txtName3:SetText(StringTable.Get("str_pet_config_name_erato"))
  local txtName4 = self:GetUIComponent("UILocalizationText", "name4")
  txtName4:SetText(StringTable.Get("str_pet_config_name_castor"))
end

function UIDemoPrepare:BtnBackOnClick(go)
  self:CloseDialog()
end

function UIDemoPrepare:BtnStartOnClick(go)
  local game = GameGlobal.GetModule(GameMatchModule)
  local info = MissionCreateInfo:New()
  info.mission_id = 4000001
  game:StartMatch(MatchType.MT_Mission, 1, info)
end
