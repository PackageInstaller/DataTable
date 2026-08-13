class = var_0_10000

local var_0_0 = "SecondaryPasswordMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.CONFIRM_PASSWORD = "SecondaryPasswordMediator:CONFIRM_PASSWORD"
var_0_1.SET_PASSWORD = "SecondaryPasswordMediator:SET_PASSWORD"
var_0_1.CANCEL_OPERATION = "SecondaryPasswordMediator:CANCEL_OPERATION"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CONFIRM_PASSWORD, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.contextData.type

		pg = var_2_10003

		if var_2_0 ~= var_2_10003.SecondaryPWDMgr.CHANGE_SETTING then
			local var_2_1 = arg_1_0.contextData.type

			pg = var_3

			if var_2_1 == var_3.SecondaryPWDMgr.CLOSE_PASSWORD then
				local var_2_2 = arg_1_0
				local var_2_3 = var_2.sendNotification

				GAME = var_2_10004

				var_2_3(var_2_2, var_2_10004.SET_PASSWORD_SETTINGS, {
					pwd = arg_2_1,
					settings = arg_1_0.contextData.settings
				})
			else
				local var_2_4 = arg_1_0
				local var_2_5 = var_2.sendNotification

				GAME = var_2_10004

				var_2_5(var_2_4, var_2_10004.CONFIRM_PASSWORD, {
					pwd = arg_2_1
				})
			end

			return
		end
	end)
	arg_1_0:bind(var_0_1.SET_PASSWORD, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_2 = var_0_1.ClipUnicodeStr(arg_3_2, 20)

		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_5

		var_3_1(var_3_0, var_5.SET_PASSWORD, {
			pwd = arg_3_1,
			tip = arg_3_2,
			settings = arg_1_0.contextData.settings
		})

		return
	end)
	arg_1_0:bind(var_0_1.CANCEL_OPERATION, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.CANCEL_LIMITED_OPERATION)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.CONFIRM_PASSWORD_DONE
	GAME = var_2
	var_5_0[2] = var_2.SET_PASSWORD_SETTINGS_DONE
	GAME = var_2
	var_5_0[3] = var_2.FETCH_PASSWORD_STATE_DONE
	GAME = var_2
	var_5_0[4] = var_2.SET_PASSWORD_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	getProxy = var_6_1
	SecondaryPWDProxy = var_1_10005

	local var_6_3 = var_6_1(var_1_10005)
	local var_6_4 = var_4.getRawData(var_6_3)

	GAME = var_6_3

	local var_6_6

	if var_6_0 == var_6_3.FETCH_PASSWORD_STATE_DONE then
		if not var_4:GetPermissionState() then
			local var_6_5 = arg_6_0

			var_6_6 = arg_6_0.sendNotification
			GAME = var_1_10008

			var_6_6(var_6_5, var_1_10008.CANCEL_LIMITED_OPERATION)

			var_6_6 = {
				title = "warning",
				mode = "showresttime",
				hideNo = true
			}
			MSGBOX_TYPE_SECONDPWD = var_6_5
			var_6_6.type = var_6_5

			function var_6_6.onPreShow()
				local var_7_0 = arg_6_0.viewComponent
				local var_7_1 = var_0.emit

				BaseUI = var_2_10002

				var_7_1(var_7_0, var_2_10002.ON_CLOSE)

				return
			end

			pg = var_7

			local var_6_7 = var_7.MsgboxMgr.GetInstance()

			var_7.ShowMsgBox(var_6_7, var_6_6)
		end

		goto label_6_0
	end

	GAME = var_6_6

	if var_6_0 ~= var_6_6.CONFIRM_PASSWORD_DONE then
		GAME = var_6_8

		do
			local var_6_8

			if var_6_0 == var_6_8.SET_PASSWORD_SETTINGS_DONE then
				var_6_8 = var_6_2.result

				if 0 < var_6_8 then
					local var_6_10

					if var_6_8 == 9 then
						var_6_4.fail_count = var_6_4.fail_count + 1

						if var_6_4.fail_count >= 5 then
							local var_6_9 = arg_6_0

							var_6_10 = arg_6_0.sendNotification
							GAME = var_1_10009

							var_6_10(var_6_9, var_1_10009.FETCH_PASSWORD_STATE)
						else
							pg = var_6_10

							local var_6_11 = var_6_10.TipsMgr.GetInstance()

							var_6_10 = var_6_10.ShowTips
							string = var_1_10009
							var_1_10009 = var_1_10009.format
							i18n = var_1_10010

							var_6_10(var_6_11, var_1_10009(var_1_10010("secondarypassword_incorrectpwd_error"), 5 - var_6_4.fail_count))
						end
					elseif var_6_8 == 40 or var_6_8 == 1 then
						local var_6_12 = arg_6_0

						var_6_10 = arg_6_0.sendNotification
						GAME = var_1_10009

						var_6_10(var_6_12, var_1_10009.FETCH_PASSWORD_STATE)
					else
						pg = var_6_10

						local var_6_13 = var_6_10.TipsMgr.GetInstance()
						local var_6_14 = var_7.ShowTips

						errorTip = var_1_10009

						var_6_14(var_6_13, var_1_10009("", var_6_8))
					end

					local var_6_15 = arg_6_0.viewComponent

					var_7.UpdateView(var_6_15)

					local var_6_16 = arg_6_0.viewComponent

					var_7.ClearInputs(var_6_16)
				else
					arg_6_0:CloseAndCallback()
				end
			else
				GAME = var_6_8

				if var_6_0 == var_6_8.SET_PASSWORD_DONE then
					local var_6_17 = var_6_2.result

					if 0 < var_6_17 then
						pg = var_7

						local var_6_18 = var_7.TipsMgr.GetInstance()
						local var_6_19 = var_7.ShowTips

						errorTip = var_1_10009

						var_6_19(var_6_18, var_1_10009("", var_6_17))

						local var_6_20 = arg_6_0
						local var_6_21 = arg_6_0.sendNotification

						GAME = var_9

						var_6_21(var_6_20, var_9.FETCH_PASSWORD_STATE)
					else
						arg_6_0:CloseAndCallback()
					end
				end
			end
		end

		::label_6_0::

		return
	end
end

function var_0_1.CloseAndCallback(arg_8_0)
	local var_8_0 = arg_8_0.contextData.callback
	local var_8_1 = arg_8_0.viewComponent
	local var_8_2 = var_2.emit

	BaseUI = var_1_10004

	var_8_2(var_8_1, var_1_10004.ON_CLOSE)

	if var_8_0 then
		var_8_0()
	end

	return
end

function var_0_1.ClipUnicodeStr(arg_9_0, arg_9_1)
	utf8_to_unicode = var_1_10002

	local var_9_0, var_9_1 = var_1_10002(arg_9_0)

	if arg_9_1 < var_9_1 then
		string = var_1_10004

		local var_9_2 = var_1_10004.sub(var_9_0, 1, -7)

		utf8_to_unicode = var_5
		unicode_to_utf8 = var_6

		local var_9_3, var_9_4 = var_5(var_6(var_9_2))

		while arg_9_1 < var_9_4 - 1 do
			string = var_9_5
			var_9_2 = var_9_5.sub(var_9_2, 1, -7)
			utf8_to_unicode = var_9_5
			unicode_to_utf8 = var_1_10008

			local var_9_5

			var_9_5, var_1_10008 = var_9_5(var_1_10008(var_9_2))
			var_9_4 = var_1_10008

			local var_9_6 = var_9_5
		end

		string = var_9_5

		local var_9_7 = var_9_5.sub

		unicode_to_utf8 = var_1_10008

		return var_9_7(var_1_10008(var_9_2), 1, -2)
	end

	return arg_9_0
end

return var_0_1
