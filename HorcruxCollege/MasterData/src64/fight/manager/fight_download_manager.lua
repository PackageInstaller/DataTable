local var_0_0 = _G
local var_0_4 = table
local var_0_9 = pairs
local var_0_10 = ipairs
local file_check_manager = require("controller.filedownloader.file_check_manager")

return function(arg_1_0)
	return setfenv(function()
		function checkPlayerSpineRes()
			local var_3_0 = {}

			for iter_3_0, iter_3_1 in var_0_9((getPlayerConf())) do
				local var_3_1 = file_check_manager:checkBattleSpineByModel(iter_3_1.modelid)

				if var_3_1 then
					for iter_3_2, iter_3_3 in var_0_10(var_3_1) do
						var_0_4.insert(var_3_0, iter_3_3)
					end
				end
			end

			return var_3_0
		end

		function checkEnemySpineRes()
			local var_4_0 = {}

			for iter_4_0, iter_4_1 in var_0_9((getEnemyConf())) do
				local var_4_1 = file_check_manager:checkBattleSpineByModel(iter_4_1.modelid)

				if var_4_1 then
					for iter_4_2, iter_4_3 in var_0_10(var_4_1) do
						var_0_4.insert(var_4_0, iter_4_3)
					end
				end
			end

			return var_4_0
		end

		function checkSpineRes()
			local var_5_0 = {}

			if var_0_0.config._DEVELOP_MODE == "FIGHTDEV" then
				return var_5_0
			end

			for iter_5_0, iter_5_1 in var_0_9((getPlayerConf())) do
				local var_5_1 = file_check_manager:checkBattleSpineByModel(iter_5_1.modelid)

				if var_5_1 then
					for iter_5_2, iter_5_3 in var_0_10(var_5_1) do
						var_0_4.insert(var_5_0, iter_5_3)
					end
				end
			end

			for iter_5_4, iter_5_5 in var_0_9((getEnemyConf())) do
				local var_5_2 = file_check_manager:checkBattleSpineByModel(iter_5_5.modelid)

				if var_5_2 then
					for iter_5_6, iter_5_7 in var_0_10(var_5_2) do
						var_0_4.insert(var_5_0, iter_5_7)
					end
				end
			end

			return var_5_0
		end
	end, arg_1_0)
end
