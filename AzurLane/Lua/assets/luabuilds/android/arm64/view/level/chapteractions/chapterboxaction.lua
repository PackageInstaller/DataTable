class = var_0_10000

local var_0_0 = "ChapterBoxAction"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ChapterCommonAction"))

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
	local var_2_1 = arg_2_1:getChapterCell(var_2_0.row, var_2_0.column)

	pg = var_1_10006

	local var_2_2 = var_1_10006.box_data_template[var_2_1.attachmentId]

	seriesAsync = var_7

	var_7({
		function(arg_3_0)
			local var_3_0 = var_2_2.type

			ChapterConst = var_2_10002

			if var_3_0 == var_2_10002.BoxAirStrike then
				local var_3_1 = arg_2_2.viewComponent
				local var_3_2 = var_1.doPlayAirStrike

				ChapterConst = var_2_10004

				var_3_2(var_3_1, var_2_10004.SubjectChampion, false, arg_3_0)

				return
			else
				local var_3_3 = var_2_2.type

				ChapterConst = var_2

				if var_3_3 == var_2.BoxTorpedo then
					local var_3_4 = arg_2_1.fleet

					if var_1.canClearTorpedo(var_3_4) then
						pg = var_1

						local var_3_5 = var_1.TipsMgr.GetInstance()
						local var_3_6 = var_1.ShowTips

						i18n = var_2_10004

						var_3_6(var_3_5, var_2_10004("levelScene_destroy_torpedo"))
					else
						local var_3_7 = arg_2_2.viewComponent

						var_1.doPlayTorpedo(var_3_7, arg_3_0)

						return
					end
				else
					local var_3_8 = var_2_2.type

					ChapterConst = var_2

					if var_3_8 == var_2.BoxBanaiDamage then
						local var_3_9 = arg_2_2.viewComponent
						local var_3_10 = var_1.doPlayAirStrike

						ChapterConst = var_2_10004

						var_3_10(var_3_9, var_2_10004.SubjectChampion, false, arg_3_0)

						return
					else
						local var_3_11 = var_2_2.type

						ChapterConst = var_2

						if var_3_11 == var_2.BoxLavaDamage then
							pg = var_3_11

							local var_3_12 = var_3_11.CriMgr.GetInstance()

							var_1.PlaySE_V3(var_3_12, "ui-magma")

							local var_3_13 = arg_2_2.viewComponent

							var_1.doPlayAnim(var_3_13, "AirStrikeLava", function(arg_4_0)
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
