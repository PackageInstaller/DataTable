return {
	init = function(arg_1_0)
		SDKManager.registerLogoutHandler(function(arg_2_0)
			print("Xiaoqi Logout Callback: ", arg_2_0)
			global_restart_game()
		end)
		SDKManager.registerLoginHandler(function(arg_3_0, arg_3_1)
			print("Xiaoqi Login Callback: ", arg_3_0, arg_3_1)

			local account_manager = require("controller.account_manager")

			if arg_3_0 == 0 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = uid

					account_manager.loginRequestingHandler(1, "", arg_3_1)
				end
			elseif account_manager.loginRequestingHandler then
				account_manager.loginRequestingHandler(2)
			end
		end)
	end,
	login = function(arg_4_0)
		SDKManager.login()
	end,
	onLoginSuccess = function(arg_5_0)
		local playermodel = require("model.playermodel")

		SDKManager:pushUserInfo(require("controller.account_manager"):getChannelUid(), playermodel.userid, playermodel.nickname, playermodel.level, playermodel.curLevel)
	end
}
