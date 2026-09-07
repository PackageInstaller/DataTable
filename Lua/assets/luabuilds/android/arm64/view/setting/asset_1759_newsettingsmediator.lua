local NewSettingsMediator = class("NewSettingsMediator", import("..base.ContextMediator"))

NewSettingsMediator.SHOW_DESC = "NewSettingsMediator:SHOW_DESC"
NewSettingsMediator.ON_LOGOUT = "NewSettingsMediator:ON_LOGOUT"
NewSettingsMediator.ON_SECON_PWD_STATE_CHANGE = "NewSettingsMediator:ON_SECON_PWD_STATE_CHANGE"
NewSettingsMediator.OPEN_YOSTAR_ALERT_VIEW = "NewSettingsMediator:OPEN_YOSTAR_ALERT_VIEW"
NewSettingsMediator.SelectGraphicSettingLevel = "NewSettingsMediator:SelectGraphicSettingLevel"
NewSettingsMediator.SelectCustomGraphicSetting = "NewSettingsMediator:SelectCustomGraphicSetting"

function NewSettingsMediator:register()
	self:bind(NewSettingsMediator.ON_LOGOUT, function(arg_2_0)
		self:sendNotification(GAME.LOGOUT, {
			code = 0
		})

		return
	end)

	return
end

function NewSettingsMediator:listNotificationInterests()
	return {
		NewSettingsMediator.SHOW_DESC,
		NewSettingsMediator.ON_SECON_PWD_STATE_CHANGE,
		NewSettingsMediator.OPEN_YOSTAR_ALERT_VIEW,
		NewSettingsMediator.SelectGraphicSettingLevel,
		NewSettingsMediator.SelectCustomGraphicSetting,
		GAME.EXCHANGECODE_USE_SUCCESS,
		GAME.ON_GET_TRANSCODE,
		GAME.ON_SOCIAL_LINKED,
		GAME.ON_SOCIAL_UNLINKED,
		GAME.CHANGE_RANDOM_SHIP_MODE_DONE,
		GAME.ON_APPLICATION_PAUSE
	}
end

function NewSettingsMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == NewSettingsMediator.SHOW_DESC then
		self.viewComponent:OnShowDescWindow(var_4_1)
	elseif var_4_0 == GAME.EXCHANGECODE_USE_SUCCESS then
		self.viewComponent:OnClearExchangeCode()
	elseif var_4_0 == GAME.ON_GET_TRANSCODE then
		self.viewComponent:OnShowTranscode(var_4_1.transcode)
	elseif var_4_0 == GAME.ON_SOCIAL_LINKED or var_4_0 == GAME.ON_SOCIAL_UNLINKED then
		self.viewComponent:OnCheckAllAccountState()
		self.viewComponent:CloseYostarAlertView()
		pg.UIMgr.GetInstance():LoadingOff()
	elseif var_4_0 == NewSettingsMediator.ON_SECON_PWD_STATE_CHANGE then
		self.viewComponent:OnSecondPwdStateChange()
	elseif var_4_0 == NewSettingsMediator.OPEN_YOSTAR_ALERT_VIEW then
		self.viewComponent:OpenYostarAlertView()
	elseif var_4_0 == GAME.CHANGE_RANDOM_SHIP_MODE_DONE then
		self.viewComponent:OnRandomFlagShipModeUpdate()
	elseif var_4_0 == NewSettingsMediator.SelectGraphicSettingLevel then
		self.viewComponent:OnSelectGraphicSettingLevel()
	elseif var_4_0 == NewSettingsMediator.SelectCustomGraphicSetting then
		self.viewComponent:OnSelectCustomGraphicSetting()
	elseif var_4_0 == GAME.ON_APPLICATION_PAUSE then
		self.viewComponent:OnApplicationPause()
	end

	return
end

return NewSettingsMediator
