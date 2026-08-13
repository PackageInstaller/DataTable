class = var_0_10000

local var_0_0 = "ChapterBoxAction"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ChapterCommonAction"))

function var_0_1.applyTo(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2 then
		return true
	end

	arg_1_0.command.chapter = arg_1_1

	local var_1_0 = arg_1_0.command

	var_3.doOpenBox(var_1_0)

	return var_0_1.super.applyTo(arg_1_0, arg_1_1, arg_1_2)
end

function var_0_1.PlayAIAction(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_1.fleet.line
	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.getChapterCell(var_2_1, var_2_0.row, var_2_0.column)

	pg = var_2_1

	local var_2_3 = var_2_1.box_data_template[var_2_2.attachmentId]

	seriesAsync = var_7

	var_7({
		function(arg_3_0)
			local var_3_0 = var_2_3.type

			ChapterConst = var_2_10002

			local var_3_1

			if var_3_0 == var_2_10002.BoxAirStrike then
				var_3_1 = arg_2_2.viewComponent

				local var_3_2 = var_1.doPlayAirStrike

				ChapterConst = var_2_10003

				var_3_2(var_3_1, var_2_10003.SubjectChampion, false, arg_3_0)

				return
			else
				local var_3_3 = var_2_3.type

				ChapterConst = var_3_1

				local var_3_4

				if var_3_3 == var_3_1.BoxTorpedo then
					var_3_4 = arg_2_1.fleet

					if var_1.canClearTorpedo(var_3_4) then
						pg = var_1
						var_3_4 = var_1.TipsMgr.GetInstance()

						local var_3_5 = var_1.ShowTips

						i18n = var_2_10003

						var_3_5(var_3_4, var_2_10003("levelScene_destroy_torpedo"))
					else
						var_3_4 = arg_2_2.viewComponent

						var_1.doPlayTorpedo(var_3_4, arg_3_0)

						return
					end
				else
					local var_3_6 = var_2_3.type

					ChapterConst = var_3_4

					local var_3_7

					if var_3_6 == var_3_4.BoxBanaiDamage then
						var_3_7 = arg_2_2.viewComponent

						local var_3_8 = var_1.doPlayAirStrike

						ChapterConst = var_2_10003

						var_3_8(var_3_7, var_2_10003.SubjectChampion, false, arg_3_0)

						return
					else
						local var_3_9 = var_2_3.type

						ChapterConst = var_3_7

						if var_3_9 == var_3_7.BoxLavaDamage then
							pg = var_3_9

							local var_3_10 = var_3_9.CriMgr.GetInstance()

							var_1.PlaySE_V3(var_3_10, "ui-magma")

							local var_3_11 = arg_2_2.viewComponent

							var_1.doPlayAnim(var_3_11, "AirStrikeLava", function(arg_4_0)
								setActive = var_3_10001

								var_3_10001(arg_4_0, false)
								arg_3_0()

								return
							end)

							return
						end
					end
				end
			end

			arg_3_0()

			return
		end,
		arg_2_3
	})

	return
end

return var_0_1
