local ReconnectLogic = class("ReconnectLogic")
local LoginConst = import("game.const.LoginConst")
local JumpTools = import("game.tools.JumpTools")

ReconnectLogic.reconnectRetryCount = 3
ReconnectLogic.loginRetryCount = 0

function ReconnectLogic:ReconnectError()
	_G.isLogining = false

	if self == LoginConst.NEED_UPDATE then
		ReconnectLogic.NeedToUpdate()

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

		ReconnectLogic.loginRetryCount = 0

		JumpTools.OpenPageUntilLoaded("/login")

		local function var_2_0()
			ReduxFactory.GetInstance():ClearCacheViews()

			if self then
				local var_3_0 = {
					isTop = true,
					title = GetTips("PROMPT")
				}

				var_3_0.content = GetTips(LoginConst.KICK_REASON[self] or "DATA_ERROR_TO_LOGIN")

				function var_3_0.OkCallback()
					if GameToSDK.IsPCPlatform() and self == 2 then
						Quit()
					end
				end

				function var_3_0.CancelCallback()
					Quit()
				end

				ShowMessageBox(var_3_0)
			end

			manager.ui:SetUIDText("")
		end

		if LuaExchangeHelper.GetSceneIsHanding() then
			_G.OnLoadedCallBack_ = var_2_0
		else
			var_2_0()
		end
	end, 0.2, -1)

	;(nil):Start()
end

function ReconnectLogic.NeedToUpdate()
	ShowNeedUpdateWindow()
end

function ReconnectLogic:CheckChatConnectStatusAndTryReconnect()
	local var_7_0 = manager.net:GetChatTCPState()

	if var_7_0 == "disconnected" then
		ReconnectLogic.TryToReconnectChat(nil, nil, self)
	elseif var_7_0 == "connected" then
		self:resolve()
	else
		self:reject("unexpect tcp state:" .. var_7_0)
	end
end

function ReconnectLogic:TryToReconnectChat(arg_8_1, arg_8_2)
	if arg_8_1 then
		print("TryReconnect error ", self, tostring(arg_8_1))

		if type(arg_8_1) == "table" then
			print_r(arg_8_1)
		end
	end

	if self == "error" and arg_8_1 == SocketError.ConnectionReset then
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

return ReconnectLogic
