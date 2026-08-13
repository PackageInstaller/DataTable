class = var_0_10000

local var_0_0 = "VoteFinalsRaceRankPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..GroupRace.VoteGroupRaceRankPage"))

function var_0_1.getUIName(arg_1_0)
	return "FinalsRaceRank"
end

function var_0_1.NewCard(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.transform

	return {
		Update = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
			setActive = var_2_10004

			local var_3_0 = var_2_0

			var_2_10004(var_6.Find(var_3_0, "1"), arg_3_1 == 1)

			setActive = var_2_10004

			local var_3_1 = var_2_0

			var_2_10004(var_6.Find(var_3_1, "2"), arg_3_1 == 2)

			setActive = var_2_10004

			local var_3_2 = var_2_0

			var_2_10004(var_6.Find(var_3_2, "3"), arg_3_1 == 3)

			setText = var_2_10004

			local var_3_3 = var_2_0

			var_2_10004(var_6.Find(var_3_3, "number"), arg_3_1)

			setText = var_2_10004

			local var_3_4 = var_2_0
			local var_3_5 = var_6.Find(var_3_4, "name")

			shortenString = var_7

			var_2_10004(var_3_5, var_7(arg_3_0:getShipName(), 6))

			setText = var_2_10004

			local var_3_6 = var_2_0

			var_2_10004(var_6.Find(var_3_6, "Text"), arg_3_2)

			return
		end
	}
end

function var_0_1.OnDestroy(arg_4_0)
	return
end

return var_0_1
