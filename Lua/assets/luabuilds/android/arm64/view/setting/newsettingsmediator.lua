local var_0_0 = class("NewSettingsMediator", import("..base.ContextMediator"))

var_0_0.SHOW_DESC = "NewSettingsMediator:SHOW_DESC"
var_0_0.ON_LOGOUT = "NewSettingsMediator:ON_LOGOUT"
var_0_0.ON_SECON_PWD_STATE_CHANGE = "NewSettingsMediator:ON_SECON_PWD_STATE_CHANGE"
var_0_0.OPEN_YOSTAR_ALERT_VIEW = "NewSettingsMediator:OPEN_YOSTAR_ALERT_VIEW"
var_0_0.SelectGraphicSettingLevel = "NewSettingsMediator:SelectGraphicSettingLevel"
var_0_0.SelectCustomGraphicSetting = "NewSettingsMediator:SelectCustomGraphicSetting"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_LOGOUT, function(arg_2_0)
		arg_1_0:sendNotification(GAME.LOGOUT, {
			code = 0
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		var_0_0.SHOW_DESC,
		var_0_0.ON_SECON_PWD_STATE_CHANGE,
		var_0_0.OPEN_YOSTAR_ALERT_VIEW,
		var_0_0.SelectGraphicSettingLevel,
		var_0_0.SelectCustomGraphicSetting,
		GAME.EXCHANGECODE_USE_SUCCESS,
		GAME.ON_GET_TRANSCODE,
		GAME.ON_SOCIAL_LINKED,
		GAME.ON_SOCIAL_UNLINKED,
		GAME.CHANGE_RANDOM_SHIP_MODE_DONE,
		GAME.ON_APPLICATION_PAUSE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == var_0_0.SHOW_DESC then
		arg_4_0.viewComponent:OnShowDescWindow(var_4_1)
	elseif var_4_0 == GAME.EXCHANGECODE_USE_SUCCESS then
		arg_4_0.viewComponent:OnClearExchangeCode()
	elseif var_4_0 == GAME.ON_GET_TRANSCODE then
		arg_4_0.viewComponent:OnShowTranscode(var_4_1.transcode)
	elseif var_4_0 == GAME.ON_SOCIAL_LINKED or var_4_0 == GAME.ON_SOCIAL_UNLINKED then
		arg_4_0.viewComponent:OnCheckAllAccountState()
		arg_4_0.viewComponent:CloseYostarAlertView()
		pg.UIMgr.GetInstance():LoadingOff()
	elseif var_4_0 == var_0_0.ON_SECON_PWD_STATE_CHANGE then
		arg_4_0.viewComponent:OnSecondPwdStateChange()
	elseif var_4_0 == var_0_0.OPEN_YOSTAR_ALERT_VIEW then
		arg_4_0.viewComponent:OpenYostarAlertView()
	elseif var_4_0 == GAME.CHANGE_RANDOM_SHIP_MODE_DONE then
		arg_4_0.viewComponent:OnRandomFlagShipModeUpdate()
	elseif var_4_0 == var_0_0.SelectGraphicSettingLevel then
		arg_4_0.viewComponent:OnSelectGraphicSettingLevel()
	elseif var_4_0 == var_0_0.SelectCustomGraphicSetting then
		arg_4_0.viewComponent:OnSelectCustomGraphicSetting()
	elseif var_4_0 == GAME.ON_APPLICATION_PAUSE then
		arg_4_0.viewComponent:OnApplicationPause()
	end

	return
end

return var_0_0
