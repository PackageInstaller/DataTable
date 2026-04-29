_class("UISetDataCopyController", UIController)
UISetDataCopyController = UISetDataCopyController

function UISetDataCopyController:OnShow(uiParams)
  self._nameLabel = self:GetUIComponent("UILocalizationText", "NameValue")
  self._levelLabel = self:GetUIComponent("UILocalizationText", "LevelValue")
  self._idLabel = self:GetUIComponent("UILocalizationText", "IdValue")
  self._zoneLabel = self:GetUIComponent("UILocalizationText", "ZoneValue")
  local roleModule = GameGlobal.GetModule(RoleModule)
  local loginModule = GameGlobal.GetModule(LoginModule)
  self._name = roleModule:GetName()
  self._id = loginModule:GetRoleShowID()
  self._level = roleModule:GetLevel()
  local zoneInfo = LoginLuaHelper.GetZoneInfo()
  self._zone = zoneInfo.zone_name
  self._nameLabel.text = self._name
  self._levelLabel.text = self._level
  self._idLabel.text = self._id
  self._zoneLabel.text = self._zone
  self._info = StringTable.Get("str_set_data_copy_name_title") .. self._name .. "\n" .. StringTable.Get("str_set_data_copy_level_title") .. self._level .. "\n" .. StringTable.Get("str_set_data_copy_id_title") .. self._id .. "\n" .. StringTable.Get("str_set_data_copy_zone_title") .. self._zone
end

function UISetDataCopyController:CancelBtnOnClick()
  self:CloseDialog()
end

function UISetDataCopyController:CopyBtnOnClick()
  HelperProxy:GetInstance():CopyTextToClipboard(self._info)
  self:CloseDialog()
end
