return {
	init = function(arg_1_0)
		SDKManager.registerLogoutHandler(function()
			global_restart_game()
		end)
		SDKManager.registerSwitchaccountHandler(function()
			global_restart_game()
		end)
		SDKManager.registerLoginHandler(function(arg_4_0, arg_4_1)
			print("jiuyou Login Callback: ", arg_4_0, arg_4_1)

			local account_manager = require("controller.account_manager")

			if arg_4_0 == 0 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = uid

					account_manager.loginRequestingHandler(1, uid, arg_4_1)
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
