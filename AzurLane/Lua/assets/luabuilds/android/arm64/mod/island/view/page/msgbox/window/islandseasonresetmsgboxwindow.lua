local var_0_0 = class("IslandSeasonResetMsgBoxWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForSeasonReset"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.emptyTF = arg_2_0._tf:Find("info_empty")
	arg_2_0.awardTF = arg_2_0._tf:Find("info_award")

	setText(arg_2_0._tf:Find("confirm/Text"), i18n("word_ok"))

	return
end

function var_0_0.OnShow(arg_3_0)
	var_0_0.super.OnShow(arg_3_0)
	arg_3_0:FlushResetInfo()

	return
end

function var_0_0.FlushBtn(arg_4_0, arg_4_1)
	setActive(arg_4_0.cancelBtn, false)
	setActive(arg_4_0.confirmBtn, true)

	return
end

function var_0_0.FlushResetInfo(arg_5_0)
	local var_5_0 = arg_5_0.settings.body
	local var_5_1 = arg_5_0.settings.body.awards

	setActive(arg_5_0.emptyTF, #arg_5_0.settings.body.awards == 0)
	setActive(arg_5_0.awardTF, #var_5_1 > 0)

	if #var_5_1 == 0 then
		setText(var_5_2:Find("reset/name/Text"), i18n("island_season_window_pt", pg.island_season[var_5_0.seasonId].name))
		setText(var_5_2:Find("reset/value/Text"), var_5_0.pt)
		setText(var_5_2:Find("rank/name/Text"), i18n("island_season_window_ranking"))

		local var_5_4 = var_5_2:Find("rank/value")

		if var_5_0.rank > 0 then
			local var_5_5 = var_5_0.rank or i18n("island_season_window_out")

			var_5_3(var_5_4, var_5_5)

			if #var_5_1 > 0 then
				setText(var_5_2:Find("award/name/Text"), i18n("island_season_window_award"))
				UIItemList.StaticAlign(var_5_2:Find("award/list"), var_5_2:Find("award/list/tpl"), #var_5_1, function(arg_6_0, arg_6_1, arg_6_2)
					if arg_6_0 == UIItemList.EventUpdate then
						updateCustomDrop(arg_6_2, var_5_1[arg_6_1 + 1])
					end

					return
				end)
			end

			return
		end
	end
end

return var_0_0
