local var_0_0 = class("VoteFinalsRaceRankPage", import("..GroupRace.VoteGroupRaceRankPage"))

function var_0_0.getUIName(arg_1_0)
	return "FinalsRaceRank"
end

function var_0_0.NewCard(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.transform

	return {
		Update = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
			setActive(var_2_0:Find("1"), arg_3_1 == 1)
			setActive(var_2_0:Find("2"), arg_3_1 == 2)
			setActive(var_2_0:Find("3"), arg_3_1 == 3)
			setText(var_2_0:Find("number"), arg_3_1)
			setText(var_2_0:Find("name"), shortenString(arg_3_0:getShipName(), 6))
			setText(var_2_0:Find("Text"), arg_3_2)

			return
		end
	}
end

function var_0_0.OnDestroy(arg_4_0)
	return
end

return var_0_0
