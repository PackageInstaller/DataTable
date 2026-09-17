return {
	init = function(arg_1_0)
		SDKManager.registerLoginHandler(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
			print("Bilibili Login Callback: ", arg_2_0, arg_2_1, arg_2_2, arg_2_3)

			local account_manager = require("controller.account_manager")

			if arg_2_0 == 0 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = arg_2_1

					account_manager.loginRequestingHandler(1, arg_2_1, arg_2_3)
				end
			elseif account_manager.loginRequestingHandler then
				account_manager.loginRequestingHandler(2)
			end
		end)
		SDKManager.registerLogoutHandler(function(arg_3_0)
			print("SDK Logout Callback: ", arg_3_0)
			global_restart_game()
		end)
	end,
	login = function(arg_4_0)
		SDKManager.login()
	end
}
