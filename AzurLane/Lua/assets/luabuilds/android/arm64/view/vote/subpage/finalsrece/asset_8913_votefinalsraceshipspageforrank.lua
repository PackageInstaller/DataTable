class = var_0_10000

local var_0_0 = "VoteFinalsRaceShipsPageForRank"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".VoteFinalsRaceShipsPage"))

function var_0_1.getUIName(arg_1_0)
	return "FinalsRaceShipsRank"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	arg_2_0.loadedPaintings = {}

	return
end

function var_0_1.UpdateTop3(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:ClearPaintings()
	var_0_1.super.UpdateTop3(arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	setText = var_4

	local var_3_0 = arg_3_0.num1TF
	local var_3_1 = var_6.Find(var_3_0, "Text")

	i18n = var_7

	local var_3_2 = "vote_lable_ship_votes"

	if arg_3_1 then
		local var_3_3 = arg_3_0.voteGroup
		local var_3_4

		if not var_10.GetVotes(var_3_3, arg_3_1) then
			var_3_4 = 0
		end

		var_4(var_3_1, var_7(var_3_2, var_3_4))

		return
	end
end

function var_0_1.LoadPainting(arg_4_0, arg_4_1, arg_4_2)
	setPaintingPrefabAsync = var_1_10003

	var_1_10003(arg_4_1, arg_4_2, "pifu", function()
		table = var_2_10000

		var_2_10000.insert(arg_4_0.loadedPaintings, {
			tr = arg_4_1,
			painting = arg_4_2
		})

		return
	end)

	return
end

function var_0_1.ClearPaintings(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.loadedPaintings) do
		local var_6_0 = iter_6_1.tr
		local var_6_1 = iter_6_1.painting

		retPaintingPrefab = var_1_10008

		var_1_10008(var_6_0, var_6_1)
	end

	arg_6_0.loadedPaintings = {}

	return
end

function var_0_1.OnDestroy(arg_7_0)
	var_0_1.super.OnDestroy(arg_7_0)
	arg_7_0:ClearPaintings()

	return
end

return var_0_1
