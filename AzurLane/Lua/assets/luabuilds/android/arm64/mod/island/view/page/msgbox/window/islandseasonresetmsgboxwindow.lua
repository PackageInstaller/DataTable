class = var_0_10000

local var_0_0 = "IslandSeasonResetMsgBoxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForSeasonReset"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.emptyTF = var_1.Find(var_2_0, "info_empty")

	local var_2_1 = arg_2_0._tf

	arg_2_0.awardTF = var_1.Find(var_2_1, "info_award")
	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "confirm/Text")

	i18n = var_4

	var_1(var_2_3, var_4("word_ok"))

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)
	arg_3_0:FlushResetInfo()

	return
end

function var_0_1.FlushBtn(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0.cancelBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_4_0.confirmBtn, true)

	return
end

function var_0_1.FlushResetInfo(arg_5_0)
	local var_5_0 = arg_5_0.settings.body.awards

	setActive = var_1_10003

	var_1_10003(arg_5_0.emptyTF, #var_5_0 == 0)

	setActive = var_1_10003

	var_1_10003(arg_5_0.awardTF, #var_5_0 > 0)

	local var_5_1

	if #var_5_0 ~= 0 or not arg_5_0.emptyTF then
		var_5_1 = arg_5_0.awardTF
	end

	pg = var_1_10004

	local var_5_2 = var_1_10004.island_season[var_1.seasonId].name

	setText = var_5

	local var_5_3 = var_5_1:Find("reset/name/Text")

	i18n = var_1_10008

	var_5(var_5_3, var_1_10008("island_season_window_pt", var_5_2))

	setText = var_5

	var_5(var_5_1:Find("reset/value/Text"), var_1.pt)

	setText = var_5

	local var_5_4 = var_5_1:Find("rank/name/Text")

	i18n = var_8

	var_5(var_5_4, var_8("island_season_window_ranking"))

	setText = var_5

	local var_5_5 = var_5_1:Find("rank/value")
	local var_5_6

	if not (var_1.rank > 0) or not var_1.rank then
		i18n = var_5_6
		var_5_6 = var_5_6("island_season_window_out")
	end

	var_5(var_5_5, var_5_6)

	if #var_5_0 > 0 then
		setText = var_5

		local var_5_7 = var_5_1:Find("award/name/Text")

		i18n = var_5_6

		var_5(var_5_7, var_5_6("island_season_window_award"))

		UIItemList = var_5

		var_5.StaticAlign(var_5_1:Find("award/list"), var_5_1:Find("award/list/tpl"), #var_5_0, function(arg_6_0, arg_6_1, arg_6_2)
			UIItemList = var_2_10003

			if arg_6_0 == var_2_10003.EventUpdate then
				updateCustomDrop = var_3

				var_3(arg_6_2, var_5_0[arg_6_1 + 1])
			end

			return
		end)
	end

	return
end

return var_0_1
