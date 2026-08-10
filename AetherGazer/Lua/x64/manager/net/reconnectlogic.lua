local var_0_0 = class("ReconnectLogic")
local var_0_1 = import("game.const.LoginConst")
local var_0_2 = import("game.tools.JumpTools")

var_0_0.reconnectRetryCount = 3
var_0_0.loginRetryCount = 0

function var_0_0.ReconnectError(arg_1_0)
	_G.isLogining = false

	if arg_1_0 == var_0_1.NEED_UPDATE then
		var_0_0.NeedToUpdate()

		return
	end

	local var_1_0

	var_1_0 = Timer.New(function()
		manager.windowBar:ClearWhereTag()

		if LuaExchangeHelper.GetSceneIsHanding() then
			return
		end

		var_1_0:Stop()
		print("whereami", whereami)

		if whereami == "battle" or whereami == "battleResult" then
			gameContext:DestroyCurRoutes()

			gameContext.oldRoutes_ = {}
		end

		GameToSDK.UpUserEvent("{\"eventType\" : \"End\"}")
		DisposeData()
		manager.video:Dispose()
		manager.story:Dispose()
		manager.net:Disconnect()
		manager.net:ChatDisconnect()
		manager.messageBox:HideAll()
		manager.guide:OnLogout()
		manager.uiTime:OnLogout()
		ActivityAction.OnLogout()
		GuildActivityAction.OnLogout()
		GuildActivitySPAction.OnLogout()
		BulletinData.OnLogout()
		manager.rollTips:OnLogout()
		OnLogoutQWorld()

		if manager.ChessManager then
			manager.ChessManager:Dispose()

			manager.ChessManager = nil
		end

		if manager.NewChessManager then
			manager.NewChessManager:Dispose()

			manager.NewChessManager = nil
		end

		if manager.ChessBoardManager then
			manager.ChessBoardManager:Dispose()

			manager.ChessBoardManager = nil
		end

		SetForceShowQuanquan(false)
		manager.ui:UIEventEnabledByUI(true, false)
		ResetSceneDataForExcehange()
		ResetMasterSkillDataForExcehange()
		_G.gameTimer:Dispose()

		if table.nums(gameContext.oldRoutes_) == 0 and not LuaExchangeHelper.GetSceneIsHanding() then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
		end

		var_0_0.loginRetryCount = 0

		var_0_2.OpenPageUntilLoaded("/login")

		local function var_2_0()
			ReduxFactory.GetInstance():ClearCacheViews()

			if arg_1_0 then
				ShowMessageBox({
					isTop = true,
					title = GetTips("PROMPT"),
					content = GetTips(var_0_1.KICK_REASON[arg_1_0] or "DATA_ERROR_TO_LOGIN"),
					OkCallback = function()
						if GameToSDK.IsPCPlatform() and arg_1_0 == 2 then
							Quit()
						end
					end,
					CancelCallback = function()
						Quit()
					end
				})
			end

			manager.ui:SetUIDText("")
		end

		if LuaExchangeHelper.GetSceneIsHanding() then
			_G.OnLoadedCallBack_ = var_2_0
		else
			var_2_0()
		end
	end, 0.2, -1)

	var_1_0:Start()
end

function var_0_0.NeedToUpdate()
	ShowNeedUpdateWindow()
end

function var_0_0.CheckChatConnectStatusAndTryReconnect(arg_7_0)
	local var_7_0 = manager.net:GetChatTCPState()

	if var_7_0 == "disconnected" then
		var_0_0.TryToReconnectChat(nil, nil, arg_7_0)
	elseif var_7_0 == "connected" then
		arg_7_0:resolve()
	else
		arg_7_0:reject("unexpect tcp state:" .. var_7_0)
	end
end

function var_0_0.TryToReconnectChat(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		print("TryReconnect error ", arg_8_0, tostring(arg_8_1))

		if type(arg_8_1) == "table" then
			print_r(arg_8_1)
		end
	end

	if arg_8_0 == "error" and arg_8_1 == SocketError.ConnectionReset then
		ShowTips("CANNOT_CONNECT_CHAT")

		return
	end

	ActionCreators.ChatReconnect():next(function(arg_9_0)
		arg_8_2:resolve()
	end, function(arg_10_0, arg_10_1)
		ShowTips("CANNOT_CONNECT_CHAT")
		arg_8_2:reject("can not connect to chat server")
	end)
end

return var_0_0
