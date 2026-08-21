local var_0_0 = class("ChapterAirSupportAIAction", import(".ChapterMissileExplodeAction"))

function var_0_0.PlayAIAction(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	seriesAsync({
		function(arg_2_0)
			arg_1_2.viewComponent:doPlayAnim("AirStrikeBar", function(arg_3_0)
				setActive(arg_3_0, false)
				arg_2_0()

				return
			end)

			return
		end,
		function(arg_4_0)
			table.ParallelIpairsAsync(arg_1_0.cellUpdates, function(arg_5_0, arg_5_1, arg_5_2)
				local var_5_0 = arg_1_1:GetRawChapterCell(arg_5_1.row, arg_5_1.column)

				if var_5_0 then
					local var_5_1 = var_5_0.data or 0

					arg_1_2.viewComponent:strikeEnemy(arg_5_1, "-" .. (arg_5_1.data - var_5_1) / 100 .. "%", arg_5_2)

					return
				end
			end, arg_4_0)

			return
		end,
		function(arg_6_0)
			arg_1_2.viewComponent.levelStageView:SwitchBottomStagePanel(false)
			arg_1_2.viewComponent.grid:HideAirSupportAimingMark()
			arg_6_0()

			return
		end,
		arg_1_3
	})

	return
end

return var_0_0
