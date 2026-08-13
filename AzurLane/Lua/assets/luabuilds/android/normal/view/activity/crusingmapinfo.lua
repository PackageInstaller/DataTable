class = var_0_10000

local var_0_0 = var_0_10000("CrusingMapInfo")

var_0_0.MapInfo = {
	CrusingMap_0 = {
		all = 1260,
		frame = {
			[0] = 1080,
			[0] = 95,
			[1185] = 100,
			[1260] = 90
		}
	},
	CrusingMap_1 = {
		all = 410,
		frame = {
			[0] = 410,
			30,
			120,
			[0] = nil,
			[5] = 60,
			[240] = 63,
			[267] = 40,
			[155] = 70,
			[311] = 74,
			[340] = 50,
			[200] = 54,
			[214] = 90,
			[391] = 80,
			[362] = 62,
			[261] = 82,
			[369] = 10,
			[40] = 100
		}
	},
	CrusingMap_2 = {
		all = 900,
		frame = {
			[0] = 772,
			[410] = 30,
			[530] = 40,
			[570] = 20,
			[490] = 70,
			[716] = 10,
			[450] = 50,
			[606] = 100,
			[860] = 90,
			[812] = 60,
			[664] = 80
		}
	}
}

function var_0_0.GetPhaseFrame(arg_1_0)
	local var_1_0 = var_0_0.MapInfo[arg_1_0]

	setmetatable = var_1_10002
	Clone = var_1_10003

	return var_1_10002(var_1_10003(var_1_0.frame), {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = 0
			local var_2_1 = 100

			pairs = var_2_10004

			for iter_2_0, iter_2_1 in var_2_10004(arg_2_0) do
				if iter_2_0 < arg_2_1 and var_2_0 < iter_2_0 then
					var_2_0 = iter_2_0
				end

				if arg_2_1 < iter_2_0 and iter_2_0 < var_2_1 then
					var_2_1 = iter_2_0
				end
			end

			return (1 - (arg_2_1 - var_2_0) / (var_2_1 - var_2_0)) * arg_2_0[var_2_0] + var_4 * arg_2_0[var_2_1]
		end
	}), var_1_0.all
end

return var_0_0
