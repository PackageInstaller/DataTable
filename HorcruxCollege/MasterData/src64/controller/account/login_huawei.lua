return {
	init = function(arg_1_0)
		SDKManager.registerLoginHandler(function(arg_2_0, arg_2_1, arg_2_2)
			print("huawei Login Callback: ", arg_2_0, arg_2_1, arg_2_2)

			arg_2_2 = arg_2_2 and string.urlencode(arg_2_2)

			local account_manager = require("controller.account_manager")

			if arg_2_0 == 0 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = arg_2_1

					account_manager.loginRequestingHandler(1, arg_2_1, arg_2_2)
				end
			elseif account_manager.loginRequestingHandler then
				account_manager.loginRequestingHandler(2)
			end
		end)
		SDKManager.registerPushInfoHandler(function(arg_3_0)
			if arg_3_0 == 0 then
				print("huawei push user info success")
			end
		end)
	end,
	login = function(arg_4_0)
		SDKManager.login()
	end,
	onLoginSuccess = function(arg_5_0)
		local playermodel = require("model.playermodel")

		SDKManager.pushPlayerInfo(playermodel.playerid, playermodel.nickname, "1", "1", require("controller.account_manager").accountInfo.uid)
		SDKManager.ownedPurchasesReqHuawei()
	end
}
