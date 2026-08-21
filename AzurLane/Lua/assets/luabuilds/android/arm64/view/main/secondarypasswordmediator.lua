local var_0_0 = class("SecondaryPasswordMediator", import("view.base.ContextMediator"))

var_0_0.CONFIRM_PASSWORD = "SecondaryPasswordMediator:CONFIRM_PASSWORD"
var_0_0.SET_PASSWORD = "SecondaryPasswordMediator:SET_PASSWORD"
var_0_0.CANCEL_OPERATION = "SecondaryPasswordMediator:CANCEL_OPERATION"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.CONFIRM_PASSWORD, function(arg_2_0, arg_2_1)
		if arg_1_0.contextData.type == pg.SecondaryPWDMgr.CHANGE_SETTING or arg_1_0.contextData.type == pg.SecondaryPWDMgr.CLOSE_PASSWORD then
			arg_1_0:sendNotification(GAME.SET_PASSWORD_SETTINGS, {
				pwd = arg_2_1,
				settings = arg_1_0.contextData.settings
			})
		else
			arg_1_0:sendNotification(GAME.CONFIRM_PASSWORD, {
				pwd = arg_2_1
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.SET_PASSWORD, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_2 = var_0_0.ClipUnicodeStr(arg_3_2, 20)

		arg_1_0:sendNotification(GAME.SET_PASSWORD, {
			pwd = arg_3_1,
			tip = arg_3_2,
			settings = arg_1_0.contextData.settings
		})

		return
	end)
	arg_1_0:bind(var_0_0.CANCEL_OPERATION, function()
		arg_1_0:sendNotification(GAME.CANCEL_LIMITED_OPERATION)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.CONFIRM_PASSWORD_DONE,
		GAME.SET_PASSWORD_SETTINGS_DONE,
		GAME.FETCH_PASSWORD_STATE_DONE,
		GAME.SET_PASSWORD_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()
	local var_6_2 = getProxy(SecondaryPWDProxy)
	local var_6_3 = var_6_2:getRawData()

	if var_6_0 == GAME.FETCH_PASSWORD_STATE_DONE then
		if not var_6_2:GetPermissionState() then
			arg_6_0:sendNotification(GAME.CANCEL_LIMITED_OPERATION)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				title = "warning",
				mode = "showresttime",
				hideNo = true,
				type = MSGBOX_TYPE_SECONDPWD,
				onPreShow = function()
					arg_6_0.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_6_0 == GAME.CONFIRM_PASSWORD_DONE or var_6_0 == GAME.SET_PASSWORD_SETTINGS_DONE then
		local var_6_4 = var_6_1.result

		if var_6_1.result > 0 then
			if var_6_4 == 9 then
				var_6_3.fail_count = var_6_3.fail_count + 1

				if var_6_3.fail_count >= 5 then
					arg_6_0:sendNotification(GAME.FETCH_PASSWORD_STATE)
				else
					pg.TipsMgr.GetInstance():ShowTips(string.format(i18n("secondarypassword_incorrectpwd_error"), 5 - var_6_3.fail_count))
				end
			elseif var_6_4 == 40 or var_6_4 == 1 then
				arg_6_0:sendNotification(GAME.FETCH_PASSWORD_STATE)
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("", var_6_4))
			end

			arg_6_0.viewComponent:UpdateView()
			arg_6_0.viewComponent:ClearInputs()
		else
			arg_6_0:CloseAndCallback()
		end
	elseif var_6_0 == GAME.SET_PASSWORD_DONE then
		if var_6_1.result > 0 then
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", var_6_1.result))
			arg_6_0:sendNotification(GAME.FETCH_PASSWORD_STATE)
		else
			arg_6_0:CloseAndCallback()
		end
	end

	return
end

function var_0_0.CloseAndCallback(arg_8_0)
	arg_8_0.viewComponent:emit(BaseUI.ON_CLOSE)

	if arg_8_0.contextData.callback then
		arg_8_0.contextData.callback()
	end

	return
end

function var_0_0.ClipUnicodeStr(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = utf8_to_unicode(arg_9_0)

	if arg_9_1 < var_9_1 then
		local var_9_2 = string.sub(var_9_0, 1, -7)
		local var_9_3, var_9_4 = utf8_to_unicode(unicode_to_utf8(var_9_2))

		while arg_9_1 < var_9_4 - 1 do
			var_9_2 = string.sub(var_9_2, 1, -7)

			local var_9_5

			var_9_5, var_9_4 = utf8_to_unicode(unicode_to_utf8(var_9_2))
		end

		return string.sub(unicode_to_utf8(var_9_2), 1, -2)
	end

	return arg_9_0
end

return var_0_0
