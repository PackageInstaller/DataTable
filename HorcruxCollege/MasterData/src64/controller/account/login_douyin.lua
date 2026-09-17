return {
	init = function(arg_1_0)
		SDKManager.registerLoginHandler(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
			print("Douyin Login Callback: ", arg_2_0, arg_2_1, arg_2_2, arg_2_3)

			local var_2_0 = require("controller.account_manager").loginRequestingHandler

			if arg_2_0 == 0 then
				if var_2_0 then
					require("controller.account_manager").loginRequestingHandler(1, "", arg_2_1)
				end
			elseif var_2_0 then
				require("controller.account_manager").loginRequestingHandler(2)
			end
		end)
		SDKManager.registerSwitchAccountHandler(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
			account_manager.accountInfo.uid = nil
			account_manager.accountInfo.token = arg_3_1

			global_logout("feiyuswitchaccount")
		end)
		SDKManager.registerLogoutHandler(function(arg_4_0)
			require("controller.l2utils"):performWithDelay(function()
				account_manager.accountInfo.uid = nil

				global_logout("feiyulogoutaccount")
			end, 1)
		end)
	end,
	login = function(arg_6_0)
		SDKManager.login()
	end
}
