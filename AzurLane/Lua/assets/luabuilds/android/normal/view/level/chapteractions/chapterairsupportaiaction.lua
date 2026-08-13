class = var_0_10000

local var_0_0 = "ChapterAirSupportAIAction"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ChapterMissileExplodeAction"))

function var_0_1.PlayAIAction(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_2_0)
			local var_2_0 = arg_1_2.viewComponent

			var_1.doPlayAnim(var_2_0, "AirStrikeBar", function(arg_3_0)
				setActive = var_3_10001

				var_3_10001(arg_3_0, false)
				arg_2_0()

				return
			end)

			return
		end,
		function(arg_4_0)
			table = var_2_10001

			var_2_10001.ParallelIpairsAsync(arg_1_0.cellUpdates, function(arg_5_0, arg_5_1, arg_5_2)
				local var_5_0 = arg_1_1
				local var_5_1

				if not var_3.GetRawChapterCell(var_5_0, arg_5_1.row, arg_5_1.column) or not var_3.data then
					var_5_1 = 0
				end

				local var_5_2 = "-" .. (arg_5_1.data - var_5_1) / 100 .. "%"
				local var_5_3 = arg_1_2.viewComponent

				var_6.strikeEnemy(var_5_3, arg_5_1, var_5_2, arg_5_2)

				return
			end, arg_4_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_1_2.viewComponent.levelStageView

			var_1.SwitchBottomStagePanel(var_6_0, false)

			local var_6_1 = arg_1_2.viewComponent.grid

			var_1.HideAirSupportAimingMark(var_6_1)
			arg_6_0()

			return
		end,
		arg_1_3
	})

	return
end

return var_0_1
