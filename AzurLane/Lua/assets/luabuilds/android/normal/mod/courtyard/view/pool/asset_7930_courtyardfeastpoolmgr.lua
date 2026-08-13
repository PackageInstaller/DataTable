class = var_0_10000

local var_0_0 = "CourtYardFeastPoolMgr"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardPoolMgr"))

function var_0_1.GenPool(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.super.GenPool(arg_1_0, arg_1_1)
	local var_1_1 = {
		"chengbao_aixin",
		"chengbao_xinxin",
		"chengbao_yinfu",
		"chengbao_ZZZ"
	}

	ipairs = var_4

	for iter_1_0, iter_1_1 in var_4(var_1_1) do
		table = var_1_10009

		var_1_10009.insert(var_1_0, function(arg_2_0)
			ResourceMgr = var_2_10001

			local var_2_0 = var_2_10001.Inst
			local var_2_1 = var_1.getAssetAsync
			local var_2_2 = "Effect/" .. iter_1_1
			local var_2_3 = ""

			typeof = var_2_10005
			Object = var_2_10006

			local var_2_4 = var_2_10005(var_2_10006)

			UnityEngine = var_2_10006

			var_2_1(var_2_0, var_2_2, var_2_3, var_2_4, var_2_10006.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
				if arg_1_0.exited then
					return
				end

				if arg_3_0 then
					local var_3_0 = arg_1_0.pools
					local var_3_1 = iter_1_1

					CourtYardEffectPool = var_3_10003

					local var_3_2 = var_3_10003.New
					local var_3_3 = arg_1_1
					local var_3_4 = arg_3_0
					local var_3_5 = 0
					local var_3_6 = 3

					CourtYardConst = var_3_10008
					var_3_0[var_3_1] = var_3_2(var_3_3, var_3_4, var_3_5, var_3_6, var_3_10008.FEAST_EFFECT_TIME)
				end

				arg_2_0()

				return
			end), true, true)

			return
		end)
	end

	return var_1_0
end

return var_0_1
