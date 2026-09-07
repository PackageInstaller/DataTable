local LoginMediator = class("LoginMediator", import("..base.ContextMediator"))

LoginMediator.ON_LOGIN = "LoginMediator:ON_LOGIN"
LoginMediator.ON_REGISTER = "LoginMediator:ON_REGISTER"
LoginMediator.ON_SERVER = "LoginMediator:ON_SERVER"
LoginMediator.ON_LOGIN_PROCESS = "LoginMediator:ON_LOGIN_PROCESS"
LoginMediator.ON_SEARCH_ACCOUNT = "LoginMediator:ON_SEARCH_ACCOUNT"
LoginMediator.CHECK_RES = "LoginMediator:CHECK_RES"

function LoginMediator:register()
	self:bind(LoginMediator.ON_LOGIN, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.USER_LOGIN, arg_2_1)

		return
	end)
	self:bind(LoginMediator.ON_REGISTER, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.USER_REGISTER, arg_3_1)

		return
	end)
	self:bind(LoginMediator.ON_SERVER, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.SERVER_LOGIN, arg_4_1)

		return
	end)
	self:bind(LoginMediator.ON_LOGIN_PROCESS, function(arg_5_0)
		if PLATFORM_CODE == PLATFORM_CHT and (CSharpVersion == 31 or CSharpVersion == 32 or CSharpVersion == 33 or CSharpVersion == 34) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = true,
				hideNo = true,
				content = "檢測到版本更新，需要手動下載更新包，是否前往下載？",
				hideClose = true,
				onYes = function()
					if YongshiSdkMgr.inst.channelUID == "0" then
						Application.OpenURL("https://play.google.com/store/apps/details?id=com.hkmanjuu.azurlane.gp")
					elseif YongshiSdkMgr.inst.channelUID == "1" then
						Application.OpenURL("https://apps.apple.com/app/id1479022429")
					elseif YongshiSdkMgr.inst.channelUID == "2" then
						Application.OpenURL("http://www.mygame.com.tw/MyGameAD/Accept.aspx?P=YAS3ZA2RSR&S=QUNRMMN7HY")
					end

					Application.Quit()

					return
				end,
				onClose = function()
					Application.Quit()

					return
				end
			})
		else
			self:loginProcessHandler()
		end

		return
	end)
	self:bind(LoginMediator.ON_SEARCH_ACCOUNT, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.ACCOUNT_SEARCH, arg_8_1)

		return
	end)
	self:bind(LoginMediator.CHECK_RES, function(arg_9_0)
		self:checkPaintingRes()

		return
	end)
	pg.SdkMgr.GetInstance():EnterLoginScene()

	return
end

function LoginMediator:remove()
	pg.SdkMgr.GetInstance():ExitLoginScene()

	return
end

function LoginMediator:loginProcessHandler()
	local var_11_0 = getProxy(SettingsProxy)
	local var_11_1 = pg.SdkMgr.GetInstance():GetLoginType()

	assert(var_11_1)

	self.process = coroutine.wrap(function()
		self.viewComponent:switchSubView({})

		if var_11_0:CheckNeedUserAgreement() then
			self.viewComponent:showUserAgreement(self.process)
			coroutine.yield()
			var_11_0:SetUserAgreement()
		end

		local var_12_0

		if var_11_1 == LoginType.PLATFORM then
			self.viewComponent:switchToServer()
		elseif var_11_1 == LoginType.PLATFORM_TENCENT then
			self.viewComponent:switchToTencentLogin()
		elseif var_11_1 == LoginType.PLATFORM_INNER then
			self.viewComponent:switchToLogin()

			var_12_0 = getProxy(UserProxy):getLastLoginUser()

			self.viewComponent:setLastLogin(var_12_0)
		elseif var_11_1 == LoginType.PLATFORM_YOSTARJP or var_11_1 == LoginType.PLATFORM_YOSTARUS then
			self.viewComponent:switchToAiriLogin()
		end

		self:CheckMaintain()

		if self.contextData.code then
			if self.contextData.code == 0 or self.contextData.code == SDK_EXIT_CODE then
				-- block empty
			else
				local var_12_1 = pg.MsgboxMgr.GetInstance()
				local var_12_2 = {
					modal = true,
					hideNo = true
				}

				var_12_2.content = ({
					i18n("login_loginMediator_kickOtherLogin"),
					i18n("login_loginMediator_kickServerClose"),
					i18n("login_loginMediator_kickIntError"),
					i18n("login_loginMediator_kickTimeError"),
					i18n("login_loginMediator_kickLoginOut"),
					i18n("login_loginMediator_serverLoginErro"),
					i18n("login_loginMediator_vertifyFail"),
					[199] = i18n("login_loginMediator_dataExpired")
				})[self.contextData.code] or i18n("login_loginMediator_kickUndefined", self.contextData.code)

				function var_12_2.onYes()
					self.process()

					return
				end

				var_12_1:ShowMsgBox(var_12_2)
				coroutine.yield()
			end

			if var_12_0 then
				if var_12_0.type == 1 then
					var_12_0.arg3 = ""
				elseif var_12_0.type == 2 then
					var_12_0.arg2 = ""
				end

				self.viewComponent:setLastLogin(var_12_0)
			end
		else
			self.viewComponent:setAutoLogin()
		end

		if var_11_1 == LoginType.PLATFORM then
			pg.SdkMgr.GetInstance():LoginSdk()
		elseif var_11_1 == LoginType.PLATFORM_TENCENT then
			pg.SdkMgr.GetInstance():TryLoginSdk()
		elseif var_11_1 == LoginType.PLATFORM_INNER then
			-- block empty
		end

		self.viewComponent:autoLogin()

		return
	end)

	self.process()

	return
end

function LoginMediator:CheckMaintain()
	ServerStateChecker.New():Execute(function(arg_15_0)
		if arg_15_0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("login_loginMediator_kickServerClose"),
				onNo = function()
					self.process()

					return
				end,
				onYes = function()
					self.process()

					return
				end
			})
		else
			self.process()
		end

		return
	end)
	coroutine.yield()

	return
end

function LoginMediator:listNotificationInterests()
	return {
		GAME.USER_LOGIN_SUCCESS,
		GAME.USER_LOGIN_FAILED,
		GAME.USER_REGISTER_SUCCESS,
		GAME.USER_REGISTER_FAILED,
		GAME.SERVER_LOGIN_SUCCESS,
		GAME.SERVER_LOGIN_FAILED,
		GAME.LOAD_PLAYER_DATA_DONE,
		ServerProxy.SERVERS_UPDATED,
		GAME.PLATFORM_LOGIN_DONE,
		GAME.SERVER_LOGIN_WAIT,
		GAME.BEGIN_STAGE_DONE,
		GAME.SERVER_LOGIN_FAILED_USER_BANNED,
		GAME.ON_SOCIAL_LINKED
	}
end

function LoginMediator:handleNotification(arg_19_1)
	local var_19_0 = arg_19_1:getName()
	local var_19_1 = arg_19_1:getBody()

	if var_19_0 == ServerProxy.SERVERS_UPDATED then
		self.viewComponent:updateServerList(var_19_1)
	elseif var_19_0 == GAME.USER_LOGIN_SUCCESS then
		pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginMediator_loginSuccess"))
		self.viewComponent:setLastLoginServer((getProxy(ServerProxy):getLastServer(var_19_1.id)))
		self.viewComponent:switchToServer()

		if PLATFORM_CODE == PLATFORM_JP then
			self.viewComponent:setUserData(getProxy(UserProxy).getLastLoginUser())
		end

		if #getProxy(GatewayNoticeProxy):getGatewayNotices(false) > 0 then
			self:addSubLayers(Context.New({
				mediator = GatewayNoticeMediator,
				viewComponent = GatewayNoticeLayer
			}))
		end

		local var_19_2 = getProxy(UserProxy)

		if var_19_2.data.limitServerIds and #var_19_2.data.limitServerIds > 0 then
			self.viewComponent:fillterRefundServer()
			self.viewComponent:setLastLoginServer(nil)
		end

		self.viewComponent.switchGatewayBtn:Flush()
	elseif var_19_0 == GAME.USER_REGISTER_SUCCESS then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			content = i18n("login_loginMediator_quest_RegisterSuccess"),
			onYes = function()
				self:sendNotification(GAME.USER_LOGIN, var_19_1)

				return
			end
		})
	elseif var_19_0 == GAME.SERVER_LOGIN_SUCCESS then
		if var_19_1.uid == 0 then
			if EPILOGUE_SKIPPABLE then
				self:sendNotification(GAME.GO_SCENE, SCENE.CREATE_PLAYER)
			else
				self:sendNotification(GAME.BEGIN_STAGE, {
					system = SYSTEM_PROLOGUE
				})
			end
		else
			self.facade:sendNotification(GAME.LOAD_PLAYER_DATA, {
				id = var_19_1.uid
			})
		end
	elseif var_19_0 == GAME.USER_REGISTER_FAILED then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			content = errorTip("login_loginMediator_registerFail", var_19_1)
		})
	elseif var_19_0 == GAME.USER_LOGIN_FAILED then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			content = errorTip("login_loginMediator_userLoginFail_error", var_19_1),
			onYes = function()
				local var_21_0 = pg.SdkMgr.GetInstance():GetLoginType()

				if var_19_1 == 20 then
					self.viewComponent:switchToRegister()
				elseif var_19_1 == 3 or var_19_1 == 6 then
					self.viewComponent:switchToServer()
				elseif var_19_1 == 1 or var_19_1 == 9 or var_19_1 == 11 or var_19_1 == 12 then
					if var_21_0 == LoginType.PLATFORM_YOSTARJP or var_21_0 == LoginType.PLATFORM_YOSTARUS then
						self.viewComponent:switchToAiriLogin()
					else
						self.viewComponent:switchToLogin()
					end
				elseif var_21_0 == LoginType.PLATFORM or var_21_0 == LoginType.PLATFORM_TENCENT then
					self.viewComponent:switchToServer()
				elseif var_21_0 == LoginType.PLATFORM_YOSTARJP or var_21_0 == LoginType.PLATFORM_YOSTARUS then
					self.viewComponent:switchToAiriLogin()
				else
					self.viewComponent:switchToLogin()
				end

				return
			end
		})
	elseif var_19_0 == GAME.SERVER_LOGIN_FAILED then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			content = errorTip("login_loginMediator_serverLoginFail", var_19_1),
			onYes = function()
				local var_22_0 = pg.SdkMgr.GetInstance():GetLoginType()

				if var_22_0 == LoginType.PLATFORM or LoginType.PLATFORM_TENCENT then
					self.viewComponent:switchToServer()
				elseif var_22_0 == LoginType.PLATFORM_YOSTARJP or var_22_0 == LoginType.PLATFORM_YOSTARUS then
					self.viewComponent:switchToAiriLogin()
				else
					self.viewComponent:switchToLogin()
				end

				return
			end
		})
	elseif var_19_0 == GAME.LOAD_PLAYER_DATA_DONE then
		self:checkPaintingRes()
	elseif var_19_0 == GAME.BEGIN_STAGE_DONE then
		self:checkLoadingPicRes(function()
			self.viewComponent:unloadExtraVoice()
			self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_19_1)

			return
		end)
	elseif var_19_0 == GAME.PLATFORM_LOGIN_DONE then
		self:sendNotification(GAME.USER_LOGIN, var_19_1.user)
	elseif var_19_0 == GAME.SERVER_LOGIN_WAIT then
		self.viewComponent:SwitchToWaitPanel(var_19_1)
	elseif var_19_0 == GAME.SERVER_LOGIN_FAILED_USER_BANNED then
		if var_19_1 == 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("user_is_forever_banned")
			})
		else
			local var_19_3 = pg.TimeMgr.GetInstance()

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("user_is_banned", (var_19_3:STimeDescS(var_19_1, "%Y-%m-%d %H:%M")))
			})
		end
	elseif var_19_0 == GAME.ON_SOCIAL_LINKED then
		self.viewComponent:closeYostarAlertView()
	end

	return
end

function LoginMediator:checkPaintingRes()
	local function var_24_0()
		self.viewComponent:onLoadDataDone()

		return
	end

	local function var_24_1()
		self.viewComponent.isNeedResCheck = true

		return
	end

	pg.FileDownloadMgr.GetInstance():SetRemind(false)
	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = PaintingGroupConst.GetPaintingNameListInLogin(),
		finishFunc = function()
			AppreciatePicConst.checkDownloadMissingPic(var_24_0)

			return
		end,
		onNo = var_24_1,
		onClose = var_24_1
	})

	return
end

function LoginMediator:checkLoadingPicRes(arg_28_1)
	AppreciatePicConst.checkDownloadMissingPic(function()
		if arg_28_1 then
			arg_28_1()
		end

		return
	end)

	return
end

return LoginMediator
