class = var_0_10000

local var_0_0 = "NewSystemSubmarineRunResultGradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..dodgem.NewDodgemResultGradePage"))

function var_0_1.GetFlagShip(arg_1_0)
	Ship = var_1_10001

	return var_1_10001.New({
		id = 9999,
		configId = 900180,
		skin_id = 900180
	})
end

function var_0_1.RegisterEvent(arg_2_0, arg_2_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.LoadPainitingContainer(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.MovePainting(var_4_0, arg_4_0)

			return
		end
	}, function()
		onButton = var_2_10000

		local var_5_0 = arg_2_0
		local var_5_1 = arg_2_0._tf

		local function var_5_2()
			arg_2_1()

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10000(var_5_0, var_5_1, var_5_2, var_2_10005)

		return
	end)

	return
end

function var_0_1.GetGetObjectives(arg_7_0)
	return {}
end

return var_0_1
