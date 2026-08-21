local var_0_0 = class("VoteFinalsRaceShipsPageForRank", import(".VoteFinalsRaceShipsPage"))

function var_0_0.getUIName(arg_1_0)
	return "FinalsRaceShipsRank"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.loadedPaintings = {}

	return
end

function var_0_0.UpdateTop3(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:ClearPaintings()
	var_0_0.super.UpdateTop3(arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	local var_3_0 = arg_3_1 and arg_3_0.voteGroup:GetVotes(arg_3_1) or 0

	setText(arg_3_0.num1TF:Find("Text"), i18n("vote_lable_ship_votes", var_3_0))

	return
end

function var_0_0.LoadPainting(arg_4_0, arg_4_1, arg_4_2)
	setPaintingPrefabAsync(arg_4_1, arg_4_2, "pifu", function()
		table.insert(arg_4_0.loadedPaintings, {
			tr = arg_4_1,
			painting = arg_4_2
		})

		return
	end)

	return
end

function var_0_0.ClearPaintings(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.loadedPaintings) do
		retPaintingPrefab(iter_6_1.tr, iter_6_1.painting)
	end

	arg_6_0.loadedPaintings = {}

	return
end

function var_0_0.OnDestroy(arg_7_0)
	var_0_0.super.OnDestroy(arg_7_0)
	arg_7_0:ClearPaintings()

	return
end

return var_0_0
