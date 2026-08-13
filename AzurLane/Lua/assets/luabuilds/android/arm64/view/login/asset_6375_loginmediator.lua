class = var_0_10000

local var_0_0 = "LoginMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_LOGIN = "LoginMediator:ON_LOGIN"
var_0_1.ON_REGISTER = "LoginMediator:ON_REGISTER"
var_0_1.ON_SERVER = "LoginMediator:ON_SERVER"
var_0_1.ON_LOGIN_PROCESS = "LoginMediator:ON_LOGIN_PROCESS"
var_0_1.ON_SEARCH_ACCOUNT = "LoginMediator:ON_SEARCH_ACCOUNT"
var_0_1.CHECK_RES = "LoginMediator:CHECK_RES"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_LOGIN, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.USER_LOGIN, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_REGISTER, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.USER_REGISTER, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SERVER, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SERVER_LOGIN, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_LOGIN_PROCESS, function(arg_5_0)
		PLATFORM_CODE = var_2_10001
		PLATFORM_CHT = var_2_10002

		if var_2_10001 == var_2_10002 then
			CSharpVersion = var_2_10001

			if var_2_10001 ~= 31 then
				CSharpVersion = var_2_10001

				if var_2_10001 ~= 32 then
					CSharpVersion = var_2_10001

					if var_2_10001 ~= 33 then
						CSharpVersion = var_2_10001

						if var_2_10001 == 34 then
							pg = var_2_10001

							local var_5_0 = var_2_10001.MsgboxMgr.GetInstance()

							var_1.ShowMsgBox(var_5_0, {
								modal = true,
								hideNo = true,
								content = "檢測到版本更新，需要手動下載更新包，是否前往下載？",
								hideClose = true,
								onYes = function()
									YongshiSdkMgr = var_3_10000

									if var_3_10000.inst.channelUID == "0" then
										Application = var_3_10001

										var_3_10001.OpenURL("https://play.google.com/store/apps/details?id=com.hkmanjuu.azurlane.gp")
									elseif var_0 == "1" then
										Application = var_3_10001

										var_3_10001.OpenURL("https://apps.apple.com/app/id1479022429")
									elseif var_0 == "2" then
										Application = var_3_10001

										var_3_10001.OpenURL("http://www.mygame.com.tw/MyGameAD/Accept.aspx?P=YAS3ZA2RSR&S=QUNRMMN7HY")
									end

									Application = var_3_10001

									var_3_10001.Quit()

									return
								end,
								onClose = function()
									Application = var_3_10000

									var_3_10000.Quit()

									return
								end
							})

							goto label_5_0
						end

						do
							local var_5_1 = arg_1_0

							var_1.loginProcessHandler(var_5_1)
						end

						::label_5_0::

						return
					end
				end
			end
		end
	end)
	arg_1_0:bind(var_0_1.ON_SEARCH_ACCOUNT, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.ACCOUNT_SEARCH, arg_8_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHECK_RES, function(arg_9_0)
		local var_9_0 = arg_1_0

		var_1.checkPaintingRes(var_9_0)

		return
	end)

	pg = var_1

	local var_1_0 = var_1.SdkMgr.GetInstance()

	var_1.EnterLoginScene(var_1_0)

	return
end

function var_0_1.remove(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.SdkMgr.GetInstance()

	var_1.ExitLoginScene(var_10_0)

	return
end

function var_0_1.loginProcessHandler(arg_11_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)

	pg = var_1_10002

	local var_11_1 = var_1_10002.SdkMgr.GetInstance()
	local var_11_2 = var_2.GetLoginType(var_11_1)

	assert = var_1_10003

	var_1_10003(var_11_2)

	coroutine = var_1_10003
	arg_11_0.process = var_1_10003.wrap(function()
		local var_12_0 = arg_11_0.viewComponent

		var_0.switchSubView(var_12_0, {})

		local var_12_1 = var_11_0

		if var_0.CheckNeedUserAgreement(var_12_1) then
			var_12_1 = arg_11_0.viewComponent

			var_0.showUserAgreement(var_12_1, arg_11_0.process)

			coroutine = var_0

			var_0.yield()

			var_12_1 = var_11_0

			var_0.SetUserAgreement(var_12_1)
		end

		local var_12_2
		local var_12_3 = var_11_2

		LoginType = var_12_1

		if var_12_3 == var_12_1.PLATFORM then
			local var_12_4 = arg_11_0.viewComponent

			var_1.switchToServer(var_12_4)

			goto label_12_0
		end

		local var_12_5 = var_11_2

		LoginType = var_2

		if var_12_5 == var_2.PLATFORM_TENCENT then
			local var_12_6 = arg_11_0.viewComponent

			var_1.switchToTencentLogin(var_12_6)

			goto label_12_0
		end

		local var_12_7 = var_11_2

		LoginType = var_2

		if var_12_7 == var_2.PLATFORM_INNER then
			local var_12_8 = arg_11_0.viewComponent

			var_1.switchToLogin(var_12_8)

			getProxy = var_1
			UserProxy = var_12_8

			local var_12_9 = var_1(var_12_8)

			var_12_2 = var_1.getLastLoginUser(var_12_9)

			local var_12_10 = arg_11_0.viewComponent

			var_2.setLastLogin(var_12_10, var_12_2)

			goto label_12_0
		end

		local var_12_11 = var_11_2

		LoginType = var_2

		if var_12_11 ~= var_2.PLATFORM_YOSTARJP then
			do
				local var_12_12 = var_11_2

				LoginType = var_2

				if var_12_12 == var_2.PLATFORM_YOSTARUS then
					local var_12_13 = arg_11_0.viewComponent

					var_1.switchToAiriLogin(var_12_13)
				end
			end

			::label_12_0::

			local var_12_14 = arg_11_0

			var_1.CheckMaintain(var_12_14)

			if arg_11_0.contextData.code then
				if arg_11_0.contextData.code ~= 0 then
					local var_12_15 = arg_11_0.contextData.code

					SDK_EXIT_CODE = var_2

					if var_12_15 == var_2 then
						-- block empty
					else
						pg = var_12_15

						local var_12_16 = var_12_15.MsgboxMgr.GetInstance()
						local var_12_17 = var_1.ShowMsgBox
						local var_12_18 = {
							modal = true,
							hideNo = true
						}
						local var_12_19 = {}

						i18n = var_2_10006
						var_12_19[1] = var_2_10006("login_loginMediator_kickOtherLogin")
						i18n = var_6
						var_12_19[2] = var_6("login_loginMediator_kickServerClose")
						i18n = var_6
						var_12_19[3] = var_6("login_loginMediator_kickIntError")
						i18n = var_6
						var_12_19[4] = var_6("login_loginMediator_kickTimeError")
						i18n = var_6
						var_12_19[5] = var_6("login_loginMediator_kickLoginOut")
						i18n = var_6
						var_12_19[6] = var_6("login_loginMediator_serverLoginErro")
						i18n = var_6
						var_12_19[7] = var_6("login_loginMediator_vertifyFail")
						i18n = var_6
						var_12_19[199] = var_6("login_loginMediator_dataExpired")

						local var_12_20

						if not var_12_19[arg_11_0.contextData.code] then
							i18n = var_12_20
							var_12_20 = var_12_20("login_loginMediator_kickUndefined", arg_11_0.contextData.code)
						end

						var_12_18.content = var_12_20

						function var_12_18.onYes()
							arg_11_0.process()

							return
						end

						var_12_17(var_12_16, var_12_18)

						coroutine = var_12_17

						var_12_17.yield()
					end
				end

				if var_12_2 then
					if var_12_2.type == 1 then
						var_12_2.arg3 = ""
					elseif var_12_2.type == 2 then
						var_12_2.arg2 = ""
					end

					local var_12_21 = arg_11_0.viewComponent

					var_1.setLastLogin(var_12_21, var_12_2)
				end
			else
				local var_12_22 = arg_11_0.viewComponent

				var_1.setAutoLogin(var_12_22)
			end

			local var_12_23 = var_11_2

			LoginType = var_2

			if var_12_23 == var_2.PLATFORM then
				pg = var_12_23

				local var_12_24 = var_12_23.SdkMgr.GetInstance()

				var_1.LoginSdk(var_12_24)
			else
				local var_12_25 = var_11_2

				LoginType = var_2

				if var_12_25 == var_2.PLATFORM_TENCENT then
					pg = var_12_25

					local var_12_26 = var_12_25.SdkMgr.GetInstance()

					var_1.TryLoginSdk(var_12_26)
				else
					local var_12_27 = var_11_2

					LoginType = var_2

					if var_12_27 == var_2.PLATFORM_INNER then
						-- block empty
					end
				end
			end

			local var_12_28 = arg_11_0.viewComponent

			var_1.autoLogin(var_12_28)

			return
		end
	end)

	arg_11_0.process()

	return
end

function var_0_1.CheckMaintain(arg_14_0)
	ServerStateChecker = var_1_10001

	local var_14_0 = var_1_10001.New()

	var_1.Execute(var_14_0, function(arg_15_0)
		if arg_15_0 then
			pg = var_2_10001

			local var_15_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_15_1 = var_1.ShowMsgBox
			local var_15_2 = {}

			i18n = var_2_10005
			var_15_2.content = var_2_10005("login_loginMediator_kickServerClose")

			function var_15_2.onNo()
				arg_14_0.process()

				return
			end

			function var_15_2.onYes()
				arg_14_0.process()

				return
			end

			var_15_1(var_15_0, var_15_2)
		else
			arg_14_0.process()
		end

		return
	end)

	coroutine = var_1

	var_1.yield()

	return
end

function var_0_1.listNotificationInterests(arg_18_0)
	local var_18_0 = {}

	GAME = var_1_10002
	var_18_0[1] = var_1_10002.USER_LOGIN_SUCCESS
	GAME = var_2
	var_18_0[2] = var_2.USER_LOGIN_FAILED
	GAME = var_2
	var_18_0[3] = var_2.USER_REGISTER_SUCCESS
	GAME = var_2
	var_18_0[4] = var_2.USER_REGISTER_FAILED
	GAME = var_2
	var_18_0[5] = var_2.SERVER_LOGIN_SUCCESS
	GAME = var_2
	var_18_0[6] = var_2.SERVER_LOGIN_FAILED
	GAME = var_2
	var_18_0[7] = var_2.LOAD_PLAYER_DATA_DONE
	ServerProxy = var_2
	var_18_0[8] = var_2.SERVERS_UPDATED
	GAME = var_2
	var_18_0[9] = var_2.PLATFORM_LOGIN_DONE
	GAME = var_2
	var_18_0[10] = var_2.SERVER_LOGIN_WAIT
	GAME = var_2
	var_18_0[11] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_18_0[12] = var_2.SERVER_LOGIN_FAILED_USER_BANNED
	GAME = var_2
	var_18_0[13] = var_2.ON_SOCIAL_LINKED

	return var_18_0
end

function var_0_1.handleNotification(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.getName(var_19_0)
	local var_19_2 = arg_19_1
	local var_19_3 = arg_19_1.getBody(var_19_2)

	ServerProxy = var_19_0

	if var_19_1 == var_19_0.SERVERS_UPDATED then
		local var_19_4 = arg_19_0.viewComponent

		var_4.updateServerList(var_19_4, var_19_3)
	else
		GAME = var_4

		local var_19_6

		if var_19_1 == var_4.USER_LOGIN_SUCCESS then
			pg = var_19_6

			local var_19_5 = var_19_6.TipsMgr.GetInstance()

			var_19_6 = var_19_6.ShowTips
			i18n = var_1_10007

			var_19_6(var_19_5, var_1_10007("login_loginMediator_loginSuccess"))

			getProxy = var_19_6
			ServerProxy = var_19_5
			var_1_10007 = var_19_6(var_19_5)
			var_19_2 = var_19_6.getLastServer(var_1_10007, var_19_3.id)
			var_1_10008 = arg_19_0.viewComponent

			var_6.setLastLoginServer(var_1_10008, var_19_2)

			var_1_10008 = arg_19_0.viewComponent

			var_6.switchToServer(var_1_10008)

			getProxy = var_6
			UserProxy = var_1_10008

			local var_19_7 = var_6(var_1_10008)

			PLATFORM_CODE = var_1_10007
			PLATFORM_JP = var_1_10008

			if var_1_10007 == var_1_10008 then
				var_1_10009 = arg_19_0.viewComponent

				var_1_10007.setUserData(var_1_10009, var_19_7.getLastLoginUser())
			end

			getProxy = var_1_10007
			GatewayNoticeProxy = var_1_10009

			local var_19_8 = var_1_10007(var_1_10009)
			local var_19_9

			if #var_1_10007.getGatewayNotices(var_19_8, false) > 0 then
				var_19_9 = arg_19_0
				var_1_10009 = arg_19_0.addSubLayers
				Context = var_1_10012

				local var_19_10 = var_1_10012.New
				local var_19_11 = {}

				GatewayNoticeMediator = var_1_10015
				var_19_11.mediator = var_1_10015
				GatewayNoticeLayer = var_1_10015
				var_19_11.viewComponent = var_1_10015

				var_1_10009(var_19_9, var_19_10(var_19_11))
			end

			getProxy = var_1_10009
			UserProxy = var_19_9

			if var_1_10009(var_19_9).data.limitServerIds and #var_1_10009.data.limitServerIds > 0 then
				local var_19_12 = arg_19_0.viewComponent

				var_10.fillterRefundServer(var_19_12)

				local var_19_13 = arg_19_0.viewComponent

				var_10.setLastLoginServer(var_19_13, nil)
			end

			local var_19_14 = arg_19_0.viewComponent.switchGatewayBtn

			var_10.Flush(var_19_14)
		else
			GAME = var_19_6

			local var_19_16

			if var_19_1 == var_19_6.USER_REGISTER_SUCCESS then
				pg = var_19_16

				local var_19_15 = var_19_16.MsgboxMgr.GetInstance()

				var_19_16 = var_19_16.ShowMsgBox
				var_1_10007 = {
					modal = true,
					hideNo = true
				}
				i18n = var_1_10008
				var_1_10007.content = var_1_10008("login_loginMediator_quest_RegisterSuccess")

				function var_1_10007.onYes()
					local var_20_0 = arg_19_0
					local var_20_1 = var_0.sendNotification

					GAME = var_2_10003

					var_20_1(var_20_0, var_2_10003.USER_LOGIN, var_19_3)

					return
				end

				var_19_16(var_19_15, var_1_10007)
			else
				GAME = var_19_16

				local var_19_18

				if var_19_1 == var_19_16.SERVER_LOGIN_SUCCESS then
					if var_19_3.uid == 0 then
						EPILOGUE_SKIPPABLE = var_19_18

						if var_19_18 then
							local var_19_17 = arg_19_0

							var_19_18 = arg_19_0.sendNotification
							GAME = var_1_10007
							var_1_10007 = var_1_10007.GO_SCENE
							SCENE = var_1_10008

							var_19_18(var_19_17, var_1_10007, var_1_10008.CREATE_PLAYER)
						else
							local var_19_19 = arg_19_0

							var_19_18 = arg_19_0.sendNotification
							GAME = var_1_10007
							var_1_10007 = var_1_10007.BEGIN_STAGE
							var_1_10008 = {}
							SYSTEM_PROLOGUE = var_1_10009
							var_1_10008.system = var_1_10009

							var_19_18(var_19_19, var_1_10007, var_1_10008)
						end
					else
						local var_19_20 = arg_19_0.facade

						var_19_18 = var_19_18.sendNotification
						GAME = var_1_10007

						var_19_18(var_19_20, var_1_10007.LOAD_PLAYER_DATA, {
							id = var_19_3.uid
						})
					end
				else
					GAME = var_19_18

					local var_19_22

					if var_19_1 == var_19_18.USER_REGISTER_FAILED then
						pg = var_19_22

						local var_19_21 = var_19_22.MsgboxMgr.GetInstance()

						var_19_22 = var_19_22.ShowMsgBox
						var_1_10007 = {
							modal = true,
							hideNo = true
						}
						errorTip = var_1_10008
						var_1_10007.content = var_1_10008("login_loginMediator_registerFail", var_19_3)

						var_19_22(var_19_21, var_1_10007)
					else
						GAME = var_19_22

						local var_19_24

						if var_19_1 == var_19_22.USER_LOGIN_FAILED then
							pg = var_19_24

							local var_19_23 = var_19_24.MsgboxMgr.GetInstance()

							var_19_24 = var_19_24.ShowMsgBox
							var_1_10007 = {
								modal = true,
								hideNo = true
							}
							errorTip = var_1_10008
							var_1_10007.content = var_1_10008("login_loginMediator_userLoginFail_error", var_19_3)

							function var_1_10007.onYes()
								pg = var_2_10000

								local var_21_0 = var_2_10000.SdkMgr.GetInstance()
								local var_21_1 = var_0.GetLoginType(var_21_0)

								if var_19_3 == 20 then
									local var_21_2 = arg_19_0.viewComponent

									var_1.switchToRegister(var_21_2)

									goto label_21_0
								end

								if var_19_3 == 3 or var_19_3 == 6 then
									local var_21_3 = arg_19_0.viewComponent

									var_1.switchToServer(var_21_3)

									goto label_21_0
								end

								if var_19_3 == 1 or var_19_3 == 9 or var_19_3 == 11 or var_19_3 == 12 then
									LoginType = var_1

									if var_21_1 ~= var_1.PLATFORM_YOSTARJP then
										LoginType = var_1

										if var_21_1 == var_1.PLATFORM_YOSTARUS then
											local var_21_4 = arg_19_0.viewComponent

											var_1.switchToAiriLogin(var_21_4)
										else
											local var_21_5 = arg_19_0.viewComponent

											var_1.switchToLogin(var_21_5)
										end

										goto label_21_0

										LoginType = var_1

										if var_21_1 ~= var_1.PLATFORM then
											LoginType = var_1

											if var_21_1 == var_1.PLATFORM_TENCENT then
												local var_21_6 = arg_19_0.viewComponent

												var_1.switchToServer(var_21_6)

												goto label_21_0
											end

											LoginType = var_1

											if var_21_1 ~= var_1.PLATFORM_YOSTARJP then
												LoginType = var_1

												if var_21_1 == var_1.PLATFORM_YOSTARUS then
													local var_21_7 = arg_19_0.viewComponent

													var_1.switchToAiriLogin(var_21_7)
												else
													local var_21_8 = arg_19_0.viewComponent

													var_1.switchToLogin(var_21_8)
												end

												::label_21_0::

												return
											end
										end
									end
								end
							end

							var_19_24(var_19_23, var_1_10007)
						else
							GAME = var_19_24

							local var_19_26

							if var_19_1 == var_19_24.SERVER_LOGIN_FAILED then
								pg = var_19_26

								local var_19_25 = var_19_26.MsgboxMgr.GetInstance()

								var_19_26 = var_19_26.ShowMsgBox
								var_1_10007 = {
									modal = true,
									hideNo = true
								}
								errorTip = var_1_10008
								var_1_10007.content = var_1_10008("login_loginMediator_serverLoginFail", var_19_3)

								function var_1_10007.onYes()
									pg = var_2_10000

									local var_22_0 = var_2_10000.SdkMgr.GetInstance()
									local var_22_1 = var_0.GetLoginType(var_22_0)

									LoginType = var_2_10001

									if var_22_1 ~= var_2_10001.PLATFORM then
										LoginType = var_1

										if var_1.PLATFORM_TENCENT then
											local var_22_2 = arg_19_0.viewComponent

											var_1.switchToServer(var_22_2)

											goto label_22_0
										end

										LoginType = var_1

										if var_22_1 ~= var_1.PLATFORM_YOSTARJP then
											LoginType = var_1

											if var_22_1 == var_1.PLATFORM_YOSTARUS then
												local var_22_3 = arg_19_0.viewComponent

												var_1.switchToAiriLogin(var_22_3)
											else
												local var_22_4 = arg_19_0.viewComponent

												var_1.switchToLogin(var_22_4)
											end

											::label_22_0::

											return
										end
									end
								end

								var_19_26(var_19_25, var_1_10007)
							else
								GAME = var_19_26

								if var_19_1 == var_19_26.LOAD_PLAYER_DATA_DONE then
									arg_19_0:checkPaintingRes()
								else
									GAME = var_4

									if var_19_1 == var_4.BEGIN_STAGE_DONE then
										arg_19_0:checkLoadingPicRes(function()
											local var_23_0 = arg_19_0.viewComponent

											var_0.unloadExtraVoice(var_23_0)

											local var_23_1 = arg_19_0
											local var_23_2 = var_0.sendNotification

											GAME = var_2_10003

											local var_23_3 = var_2_10003.GO_SCENE

											SCENE = var_2_10004

											var_23_2(var_23_1, var_23_3, var_2_10004.COMBATLOAD, var_19_3)

											return
										end)
									else
										GAME = var_4

										local var_19_28

										if var_19_1 == var_4.PLATFORM_LOGIN_DONE then
											local var_19_27 = arg_19_0

											var_19_28 = arg_19_0.sendNotification
											GAME = var_1_10007

											var_19_28(var_19_27, var_1_10007.USER_LOGIN, var_19_3.user)
										else
											GAME = var_19_28

											if var_19_1 == var_19_28.SERVER_LOGIN_WAIT then
												local var_19_29 = arg_19_0.viewComponent

												var_4.SwitchToWaitPanel(var_19_29, var_19_3)
											else
												GAME = var_4

												local var_19_31

												if var_19_1 == var_4.SERVER_LOGIN_FAILED_USER_BANNED then
													if var_19_3 == 0 then
														pg = var_19_31

														local var_19_30 = var_19_31.MsgboxMgr.GetInstance()

														var_19_31 = var_19_31.ShowMsgBox

														local var_19_32 = {
															hideNo = true
														}

														i18n = var_1_10008
														var_19_32.content = var_1_10008("user_is_forever_banned")

														var_19_31(var_19_30, var_19_32)
													else
														pg = var_19_31

														local var_19_33 = var_19_31.TimeMgr.GetInstance()

														var_19_31 = var_19_31.STimeDescS(var_19_33, var_19_3, "%Y-%m-%d %H:%M")
														pg = var_19_2

														local var_19_34 = var_19_2.MsgboxMgr.GetInstance()
														local var_19_35 = var_5.ShowMsgBox
														local var_19_36 = {
															hideNo = true
														}

														i18n = var_1_10009
														var_19_36.content = var_1_10009("user_is_banned", var_19_31)

														var_19_35(var_19_34, var_19_36)
													end
												else
													GAME = var_19_31

													if var_19_1 == var_19_31.ON_SOCIAL_LINKED then
														local var_19_37 = arg_19_0.viewComponent

														var_4.closeYostarAlertView(var_19_37)
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.checkPaintingRes(arg_24_0)
	local function var_24_0()
		local var_25_0 = arg_24_0.viewComponent

		var_0.onLoadDataDone(var_25_0)

		return
	end

	local function var_24_1()
		arg_24_0.viewComponent.isNeedResCheck = true

		return
	end

	local function var_24_2()
		AppreciatePicConst = var_2_10000

		var_2_10000.checkDownloadMissingPic(var_24_0)

		return
	end

	pg = var_1_10004

	local var_24_3 = var_1_10004.FileDownloadMgr.GetInstance()

	var_4.SetRemind(var_24_3, false)

	PaintingGroupConst = var_4

	local var_24_4 = var_4.GetPaintingNameListInLogin()
	local var_24_5 = {
		isShowBox = true,
		paintingNameList = var_24_4,
		finishFunc = var_24_2,
		onNo = var_24_1,
		onClose = var_24_1
	}

	PaintingGroupConst = var_24_3

	var_24_3.PaintingDownload(var_24_5)

	return
end

function var_0_1.checkLoadingPicRes(arg_28_0, arg_28_1)
	local function var_28_0()
		if arg_28_1 then
			arg_28_1()
		end

		return
	end

	AppreciatePicConst = var_1_10003

	var_1_10003.checkDownloadMissingPic(var_28_0)

	return
end

return var_0_1
