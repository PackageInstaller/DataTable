class = var_0_10000

local var_0_0 = "VoteGroupRaceShipPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..PreRace.VotePreRaceShipPage"))

function var_0_1.getUIName(arg_1_0)
	return "GroupRaceShips"
end

function var_0_1.onInitItem(arg_2_0, arg_2_1)
	var_0_1.super.onInitItem(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0.voteItems[arg_2_1]

	onButton = var_1_10003

	local var_2_1 = arg_2_0
	local var_2_2 = var_2_0.go

	local function var_2_3()
		if arg_2_0.CallBack then
			local var_3_0 = arg_2_0.phase

			VoteGroup = var_2_10001

			if var_3_0 == var_2_10001.VOTE_STAGE then
				arg_2_0.CallBack(var_2_0, var_2_0.voteShip.votes)
			end
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_2_1, var_2_2, var_2_3, var_1_10008)

	return
end

function var_0_1.UpdateShips(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.scrollRect

	var_3.SetTotalCount(var_4_0, #arg_4_0.displays)

	return
end

function var_0_1.OnDestroy(arg_5_0)
	return
end

return var_0_1
