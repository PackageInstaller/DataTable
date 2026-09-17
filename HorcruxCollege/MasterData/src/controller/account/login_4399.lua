return {
	init = function(arg_1_0)
		SDKManager.registerLogoutHandler(function()
			global_restart_game()
		end)
		SDKManager.registerSwitchUserAccountHandler(function()
			global_restart_game()
		end)
		SDKManager.registerLoginHandler(function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
			print("4399 Login Callback: ", arg_4_0, arg_4_1, arg_4_2)

			local account_manager = require("controller.account_manager")

			if arg_4_0 == 1 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = arg_4_1

					account_manager.loginRequestingHandler(1, arg_4_1, arg_4_2)
				end
			elseif account_manager.loginRequestingHandler then
				account_manager.loginRequestingHandler(2)
			end
		end)
	end,
	login = function(arg_5_0)
		SDKManager.login()
	end
}
