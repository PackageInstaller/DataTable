class = var_0_10000

local var_0_0 = "NewSettingsMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.SHOW_DESC = "NewSettingsMediator:SHOW_DESC"
var_0_1.ON_LOGOUT = "NewSettingsMediator:ON_LOGOUT"
var_0_1.ON_SECON_PWD_STATE_CHANGE = "NewSettingsMediator:ON_SECON_PWD_STATE_CHANGE"
var_0_1.OPEN_YOSTAR_ALERT_VIEW = "NewSettingsMediator:OPEN_YOSTAR_ALERT_VIEW"
var_0_1.SelectGraphicSettingLevel = "NewSettingsMediator:SelectGraphicSettingLevel"
var_0_1.SelectCustomGraphicSetting = "NewSettingsMediator:SelectCustomGraphicSetting"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_LOGOUT, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.LOGOUT, {
			code = 0
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {
		var_0_1.SHOW_DESC,
		var_0_1.ON_SECON_PWD_STATE_CHANGE,
		var_0_1.OPEN_YOSTAR_ALERT_VIEW,
		var_0_1.SelectGraphicSettingLevel,
		var_0_1.SelectCustomGraphicSetting
	}

	GAME = var_2
	var_3_0[6] = var_2.EXCHANGECODE_USE_SUCCESS
	GAME = var_2
	var_3_0[7] = var_2.ON_GET_TRANSCODE
	GAME = var_2
	var_3_0[8] = var_2.ON_SOCIAL_LINKED
	GAME = var_2
	var_3_0[9] = var_2.ON_SOCIAL_UNLINKED
	GAME = var_2
	var_3_0[10] = var_2.CHANGE_RANDOM_SHIP_MODE_DONE
	GAME = var_2
	var_3_0[11] = var_2.ON_APPLICATION_PAUSE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == var_0_1.SHOW_DESC then
		local var_4_2 = arg_4_0.viewComponent

		var_4.OnShowDescWindow(var_4_2, var_4_1)

		goto label_4_0
	end

	GAME = var_4

	if var_4_0 == var_4.EXCHANGECODE_USE_SUCCESS then
		local var_4_3 = arg_4_0.viewComponent

		var_4.OnClearExchangeCode(var_4_3)

		goto label_4_0
	end

	GAME = var_4

	if var_4_0 == var_4.ON_GET_TRANSCODE then
		local var_4_4 = arg_4_0.viewComponent

		var_4.OnShowTranscode(var_4_4, var_4_1.transcode)

		goto label_4_0
	end

	GAME = var_4

	if var_4_0 ~= var_4.ON_SOCIAL_LINKED then
		GAME = var_4

		if var_4_0 == var_4.ON_SOCIAL_UNLINKED then
			local var_4_5 = arg_4_0.viewComponent

			var_4.OnCheckAllAccountState(var_4_5)

			local var_4_6 = arg_4_0.viewComponent

			var_4.CloseYostarAlertView(var_4_6)

			pg = var_4

			local var_4_7 = var_4.UIMgr.GetInstance()

			var_4.LoadingOff(var_4_7)
		elseif var_4_0 == var_0_1.ON_SECON_PWD_STATE_CHANGE then
			local var_4_8 = arg_4_0.viewComponent

			var_4.OnSecondPwdStateChange(var_4_8)
		elseif var_4_0 == var_0_1.OPEN_YOSTAR_ALERT_VIEW then
			local var_4_9 = arg_4_0.viewComponent

			var_4.OpenYostarAlertView(var_4_9)
		else
			GAME = var_4

			if var_4_0 == var_4.CHANGE_RANDOM_SHIP_MODE_DONE then
				local var_4_10 = arg_4_0.viewComponent

				var_4.OnRandomFlagShipModeUpdate(var_4_10)
			elseif var_4_0 == var_0_1.SelectGraphicSettingLevel then
				local var_4_11 = arg_4_0.viewComponent

				var_4.OnSelectGraphicSettingLevel(var_4_11)
			elseif var_4_0 == var_0_1.SelectCustomGraphicSetting then
				local var_4_12 = arg_4_0.viewComponent

				var_4.OnSelectCustomGraphicSetting(var_4_12)
			else
				GAME = var_4

				if var_4_0 == var_4.ON_APPLICATION_PAUSE then
					local var_4_13 = arg_4_0.viewComponent

					var_4.OnApplicationPause(var_4_13)
				end
			end
		end

		::label_4_0::

		return
	end
end

return var_0_1
