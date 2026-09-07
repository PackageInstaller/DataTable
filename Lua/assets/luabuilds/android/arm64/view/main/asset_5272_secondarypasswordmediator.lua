local SecondaryPasswordMediator = class("SecondaryPasswordMediator", import("view.base.ContextMediator"))

SecondaryPasswordMediator.CONFIRM_PASSWORD = "SecondaryPasswordMediator:CONFIRM_PASSWORD"
SecondaryPasswordMediator.SET_PASSWORD = "SecondaryPasswordMediator:SET_PASSWORD"
SecondaryPasswordMediator.CANCEL_OPERATION = "SecondaryPasswordMediator:CANCEL_OPERATION"

function SecondaryPasswordMediator:register()
	self:bind(SecondaryPasswordMediator.CONFIRM_PASSWORD, function(arg_2_0, arg_2_1)
		if self.contextData.type == pg.SecondaryPWDMgr.CHANGE_SETTING or self.contextData.type == pg.SecondaryPWDMgr.CLOSE_PASSWORD then
			self:sendNotification(GAME.SET_PASSWORD_SETTINGS, {
				pwd = arg_2_1,
				settings = self.contextData.settings
			})
		else
			self:sendNotification(GAME.CONFIRM_PASSWORD, {
				pwd = arg_2_1
			})
		end

		return
	end)
	self:bind(SecondaryPasswordMediator.SET_PASSWORD, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_2 = SecondaryPasswordMediator.ClipUnicodeStr(arg_3_2, 20)

		self:sendNotification(GAME.SET_PASSWORD, {
			pwd = arg_3_1,
			tip = arg_3_2,
			settings = self.contextData.settings
		})

		return
	end)
	self:bind(SecondaryPasswordMediator.CANCEL_OPERATION, function()
		self:sendNotification(GAME.CANCEL_LIMITED_OPERATION)

		return
	end)

	return
end

function SecondaryPasswordMediator:listNotificationInterests()
	return {
		GAME.CONFIRM_PASSWORD_DONE,
		GAME.SET_PASSWORD_SETTINGS_DONE,
		GAME.FETCH_PASSWORD_STATE_DONE,
		GAME.SET_PASSWORD_DONE
	}
end

function SecondaryPasswordMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()
	local var_6_2 = getProxy(SecondaryPWDProxy)
	local var_6_3 = var_6_2:getRawData()

	if var_6_0 == GAME.FETCH_PASSWORD_STATE_DONE then
		if not var_6_2:GetPermissionState() then
			self:sendNotification(GAME.CANCEL_LIMITED_OPERATION)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				title = "warning",
				mode = "showresttime",
				hideNo = true,
				type = MSGBOX_TYPE_SECONDPWD,
				onPreShow = function()
					self.viewComponent:emit(BaseUI.ON_CLOSE)

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
					self:sendNotification(GAME.FETCH_PASSWORD_STATE)
				else
					pg.TipsMgr.GetInstance():ShowTips(string.format(i18n("secondarypassword_incorrectpwd_error"), 5 - var_6_3.fail_count))
				end
			elseif var_6_4 == 40 or var_6_4 == 1 then
				self:sendNotification(GAME.FETCH_PASSWORD_STATE)
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("", var_6_4))
			end

			self.viewComponent:UpdateView()
			self.viewComponent:ClearInputs()
		else
			self:CloseAndCallback()
		end
	elseif var_6_0 == GAME.SET_PASSWORD_DONE then
		if var_6_1.result > 0 then
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", var_6_1.result))
			self:sendNotification(GAME.FETCH_PASSWORD_STATE)
		else
			self:CloseAndCallback()
		end
	end

	return
end

function SecondaryPasswordMediator:CloseAndCallback()
	self.viewComponent:emit(BaseUI.ON_CLOSE)

	if self.contextData.callback then
		self.contextData.callback()
	end

	return
end

function SecondaryPasswordMediator:ClipUnicodeStr(arg_9_1)
	local var_9_0, var_9_1 = utf8_to_unicode(self)

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

	return self
end

return SecondaryPasswordMediator
