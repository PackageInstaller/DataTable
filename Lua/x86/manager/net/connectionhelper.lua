local var_0_0 = {}

function var_0_0.OnTimeOut(arg_1_0, arg_1_1)
	print("connection", arg_1_0, arg_1_1)

	if arg_1_1 ~= "game" then
		return
	end

	arg_1_0:Disconnect()
	var_0_0.ShowReturnToLoginTip()
end

function var_0_0.OnWaitServerReturn(arg_2_0)
	return
end

local var_0_1 = 3

function var_0_0.OnErrorHandling(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	print("OnErrorHandling", arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	if arg_3_1 ~= "game" then
		return
	end

	if arg_3_3 ~= nil and (arg_3_3 == "ConnectionReset" or arg_3_3 == "DisconnectByServer" or arg_3_3 == "ConnectionAborted") and var_0_0.DealWithNetError(arg_3_0, arg_3_1, arg_3_2, arg_3_3) then
		return
	end

	if arg_3_2 < var_0_1 then
		if whereami ~= "battle" and whereami ~= "battleResult" then
			arg_3_0:ResetReconnectTime()

			return
		end

		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			content = GetTips("CANNOT_CONNECT_CHECK"),
			OkCallback = function()
				arg_3_0:ResetReconnectTime()
			end,
			CancelCallback = function()
				return
			end
		})
	elseif arg_3_2 == var_0_1 then
		var_0_0.ShowReturnToLoginTip()
	end
end

function var_0_0.DealWithNetError(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 == "ConnectionReset" or arg_6_3 == "DisconnectByServer" or arg_6_3 == "ConnectionAborted" then
		print("connection:GetSendingPacketNum()", arg_6_0:GetSendingPacketNum())

		if arg_6_0:GetSendingPacketNum() > 0 then
			var_0_0.ShowReturnToLoginTip()

			return true
		end
	end

	return false
end

local var_0_2 = 202001
local var_0_3 = 202002
local var_0_4 = 202003
local var_0_5 = 202005
local var_0_6 = 202006

function var_0_0.OnBattleServerConnectError(arg_7_0, arg_7_1)
	if arg_7_0 == var_0_5 then
		if arg_7_1 < var_0_1 then
			ShowMessageBox({
				isTop = true,
				ButtonType = "SingleBtn",
				content = GetTips("CANNOT_CONNECT_BATTLE"),
				OkCallback = function()
					TryToStartBattle()
				end,
				CancelCallback = function()
					return
				end
			})
		elseif arg_7_1 == var_0_1 then
			var_0_0.ShowReturnToLoginTip()
		end
	else
		var_0_0.ShowReturnToLoginTip()
	end
end

var_0_0.IsDealWithError = false

function var_0_0.GetIsDealWithError()
	return var_0_0.IsDealWithError
end

function var_0_0.ShowReturnToLoginTip(arg_11_0)
	manager.net:Disconnect()
	ActivityAction.OnLogout()
	BulletinData.OnLogout()
	manager.rollTips:OnLogout()
	SetForceShowQuanquan(false)

	var_0_0.IsDealWithError = true

	ShowMessageBox({
		isTop = true,
		ButtonType = "SingleBtn",
		content = GetTips(LoginConst.KICK_REASON[arg_11_0] or "CANNOT_CONNECT_QUIT"),
		OkCallback = function()
			_G.BATTLE_SERVER_ERROR_TIME = 0
			var_0_0.IsDealWithError = false

			ReconnectLogic.ReconnectError()
		end,
		CancelCallback = function()
			return
		end
	})
end

return var_0_0
