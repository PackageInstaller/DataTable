local var_0_0 = class("LoginMediator", import("..base.ContextMediator"))

var_0_0.ON_LOGIN = "LoginMediator:ON_LOGIN"
var_0_0.ON_REGISTER = "LoginMediator:ON_REGISTER"
var_0_0.ON_SERVER = "LoginMediator:ON_SERVER"
var_0_0.ON_LOGIN_PROCESS = "LoginMediator:ON_LOGIN_PROCESS"
var_0_0.ON_SEARCH_ACCOUNT = "LoginMediator:ON_SEARCH_ACCOUNT"
var_0_0.CHECK_RES = "LoginMediator:CHECK_RES"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_LOGIN, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.USER_LOGIN, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_REGISTER, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.USER_REGISTER, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SERVER, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.SERVER_LOGIN, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_LOGIN_PROCESS, function(arg_5_0)
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
			arg_1_0:loginProcessHandler()
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_SEARCH_ACCOUNT, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.ACCOUNT_SEARCH, arg_8_1)

		return
	end)
	arg_1_0:bind(var_0_0.CHECK_RES, function(arg_9_0)
		arg_1_0:checkPaintingRes()

		return
	end)
	pg.SdkMgr.GetInstance():EnterLoginScene()

	return
end

function var_0_0.remove(arg_10_0)
	pg.SdkMgr.GetInstance():ExitLoginScene()

	return
end

function var_0_0.loginProcessHandler(arg_11_0)
	local var_11_0 = getProxy(SettingsProxy)

	assert((pg.SdkMgr.GetInstance():GetLoginType()))

	arg_11_0.process = coroutine.wrap(function()
		arg_11_0.viewComponent:switchSubView({})

		if var_11_0:CheckNeedUserAgreement() then
			arg_11_0.viewComponent:showUserAgreement(arg_11_0.process)
			coroutine.yield()
			var_11_0:SetUserAgreement()
		end

		local var_12_0

		if var_0 == LoginType.PLATFORM then
			arg_11_0.viewComponent:switchToServer()
		elseif var_0 == LoginType.PLATFORM_TENCENT then
			arg_11_0.viewComponent:switchToTencentLogin()
		elseif var_0 == LoginType.PLATFORM_INNER then
			arg_11_0.viewComponent:switchToLogin()

			var_12_0 = getProxy(UserProxy):getLastLoginUser()

			arg_11_0.viewComponent:setLastLogin(var_12_0)
		elseif var_0 == LoginType.PLATFORM_YOSTARJP or var_0 == LoginType.PLATFORM_YOSTARUS then
			arg_11_0.viewComponent:switchToAiriLogin()
		end

		arg_11_0:CheckMaintain()

		if arg_11_0.contextData.code then
			if arg_11_0.contextData.code == 0 or arg_11_0.contextData.code == SDK_EXIT_CODE then
				-- block empty
			else
				local var_12_1 = pg.MsgboxMgr.GetInstance()

				;({
					modal = true,
					hideNo = true
				}).content = ({
					i18n("login_loginMediator_kickOtherLogin"),
					i18n("login_loginMediator_kickServerClose"),
					i18n("login_loginMediator_kickIntError"),
					i18n("login_loginMediator_kickTimeError"),
					i18n("login_loginMediator_kickLoginOut"),
					i18n("login_loginMediator_serverLoginErro"),
					i18n("login_loginMediator_vertifyFail"),
					[199] = i18n("login_loginMediator_dataExpired")
				})[arg_11_0.contextData.code] or i18n("login_loginMediator_kickUndefined", arg_11_0.contextData.code)
				;({
					modal = true,
					hideNo = true
				}).onYes = function()
					arg_11_0.process()

					return
				end

				var_12_1:ShowMsgBox({
					modal = true,
					hideNo = true
				})
				coroutine.yield()
			end

			if var_12_0 then
				if var_12_0.type == 1 then
					var_12_0.arg3 = ""
				elseif var_12_0.type == 2 then
					var_12_0.arg2 = ""
				end

				arg_11_0.viewComponent:setLastLogin(var_12_0)
			end
		else
			arg_11_0.viewComponent:setAutoLogin()
		end

		if var_0 == LoginType.PLATFORM then
			pg.SdkMgr.GetInstance():LoginSdk()
		elseif var_0 == LoginType.PLATFORM_TENCENT then
			pg.SdkMgr.GetInstance():TryLoginSdk()
		elseif var_0 == LoginType.PLATFORM_INNER then
			-- block empty
		end

		arg_11_0.viewComponent:autoLogin()

		return
	end)

	arg_11_0.process()

	return
end

function var_0_0.CheckMaintain(arg_14_0)
	ServerStateChecker.New():Execute(function(arg_15_0)
		if arg_15_0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("login_loginMediator_kickServerClose"),
				onNo = function()
					arg_14_0.process()

					return
				end,
				onYes = function()
					arg_14_0.process()

					return
				end
			})
		else
			arg_14_0.process()
		end

		return
	end)
	coroutine.yield()

	return
end

function var_0_0.listNotificationInterests(arg_18_0)
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

function var_0_0.handleNotification(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1:getName()
	local var_19_1 = arg_19_1:getBody()

	if var_19_0 == ServerProxy.SERVERS_UPDATED then
		arg_19_0.viewComponent:updateServerList(var_19_1)
	elseif var_19_0 == GAME.USER_LOGIN_SUCCESS then
		pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginMediator_loginSuccess"))
		arg_19_0.viewComponent:setLastLoginServer((getProxy(ServerProxy):getLastServer(var_19_1.id)))
		arg_19_0.viewComponent:switchToServer()

		if PLATFORM_CODE == PLATFORM_JP then
			arg_19_0.viewComponent:setUserData(getProxy(UserProxy).getLastLoginUser())
		end

		local var_19_2 = getProxy(GatewayNoticeProxy)

		if #var_19_2:getGatewayNotices(false) > 0 then
			arg_19_0:addSubLayers(Context.New({
				mediator = GatewayNoticeMediator,
				viewComponent = GatewayNoticeLayer
			}))
		end

		local var_19_3 = getProxy(UserProxy)

		if var_19_3.data.limitServerIds and #var_19_3.data.limitServerIds > 0 then
			arg_19_0.viewComponent:fillterRefundServer()
			arg_19_0.viewComponent:setLastLoginServer(nil)
		end

		arg_19_0.viewComponent.switchGatewayBtn:Flush()
	elseif var_19_0 == GAME.USER_REGISTER_SUCCESS then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			content = i18n("login_loginMediator_quest_RegisterSuccess"),
			onYes = function()
				arg_19_0:sendNotification(GAME.USER_LOGIN, var_19_1)

				return
			end
		})
	elseif var_19_0 == GAME.SERVER_LOGIN_SUCCESS then
		if var_19_1.uid == 0 then
			if EPILOGUE_SKIPPABLE then
				arg_19_0:sendNotification(GAME.GO_SCENE, SCENE.CREATE_PLAYER)
			else
				arg_19_0:sendNotification(GAME.BEGIN_STAGE, {
					system = SYSTEM_PROLOGUE
				})
			end
		else
			arg_19_0.facade:sendNotification(GAME.LOAD_PLAYER_DATA, {
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
					arg_19_0.viewComponent:switchToRegister()
				elseif var_19_1 == 3 or var_19_1 == 6 then
					arg_19_0.viewComponent:switchToServer()
				elseif var_19_1 == 1 or var_19_1 == 9 or var_19_1 == 11 or var_19_1 == 12 then
					if var_21_0 == LoginType.PLATFORM_YOSTARJP or var_21_0 == LoginType.PLATFORM_YOSTARUS then
						arg_19_0.viewComponent:switchToAiriLogin()
					else
						arg_19_0.viewComponent:switchToLogin()
					end
				elseif var_21_0 == LoginType.PLATFORM or var_21_0 == LoginType.PLATFORM_TENCENT then
					arg_19_0.viewComponent:switchToServer()
				elseif var_21_0 == LoginType.PLATFORM_YOSTARJP or var_21_0 == LoginType.PLATFORM_YOSTARUS then
					arg_19_0.viewComponent:switchToAiriLogin()
				else
					arg_19_0.viewComponent:switchToLogin()
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
					arg_19_0.viewComponent:switchToServer()
				elseif var_22_0 == LoginType.PLATFORM_YOSTARJP or var_22_0 == LoginType.PLATFORM_YOSTARUS then
					arg_19_0.viewComponent:switchToAiriLogin()
				else
					arg_19_0.viewComponent:switchToLogin()
				end

				return
			end
		})
	elseif var_19_0 == GAME.LOAD_PLAYER_DATA_DONE then
		arg_19_0:checkPaintingRes()
	elseif var_19_0 == GAME.BEGIN_STAGE_DONE then
		arg_19_0:checkLoadingPicRes(function()
			arg_19_0.viewComponent:unloadExtraVoice()
			arg_19_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_19_1)

			return
		end)
	elseif var_19_0 == GAME.PLATFORM_LOGIN_DONE then
		arg_19_0:sendNotification(GAME.USER_LOGIN, var_19_1.user)
	elseif var_19_0 == GAME.SERVER_LOGIN_WAIT then
		arg_19_0.viewComponent:SwitchToWaitPanel(var_19_1)
	elseif var_19_0 == GAME.SERVER_LOGIN_FAILED_USER_BANNED then
		if var_19_1 == 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("user_is_forever_banned")
			})
		else
			local var_19_4 = pg.TimeMgr.GetInstance()

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("user_is_banned", (var_19_4:STimeDescS(var_19_1, "%Y-%m-%d %H:%M")))
			})
		end
	elseif var_19_0 == GAME.ON_SOCIAL_LINKED then
		arg_19_0.viewComponent:closeYostarAlertView()
	end

	return
end

function var_0_0.checkPaintingRes(arg_24_0)
	local function var_24_0()
		arg_24_0.viewComponent:onLoadDataDone()

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
		onNo = function()
			arg_24_0.viewComponent.isNeedResCheck = true

			return
		end,
		onClose = function()
			arg_24_0.viewComponent.isNeedResCheck = true

			return
		end
	})

	return
end

function var_0_0.checkLoadingPicRes(arg_28_0, arg_28_1)
	AppreciatePicConst.checkDownloadMissingPic(function()
		if arg_28_1 then
			arg_28_1()
		end

		return
	end)

	return
end

return var_0_0
