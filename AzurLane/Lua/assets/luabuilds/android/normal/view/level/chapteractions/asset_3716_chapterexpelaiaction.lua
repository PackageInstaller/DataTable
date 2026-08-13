class = var_0_10000

local var_0_0 = var_0_10000("ChapterExpelAIAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.actType = arg_1_1.act_type
	arg_1_0.line = {
		row = arg_1_1.ai_pos.row,
		column = arg_1_1.ai_pos.column
	}
	_ = var_2
	arg_1_0.shipUpdate = var_2.map(arg_1_1.ship_update, function(arg_2_0)
		return {
			id = arg_2_0.id,
			hpRant = arg_2_0.hp_rant
		}
	end)
	_ = var_2
	arg_1_0.cellFlagUpdates = var_2.map(arg_1_1.cell_flag_list, function(arg_3_0)
		local var_3_0 = {
			row = arg_3_0.pos.row,
			column = arg_3_0.pos.column
		}

		_ = var_2
		var_3_0.flag_list = var_2.map(arg_3_0.flag_list, function(arg_4_0)
			return arg_4_0
		end)

		return var_3_0
	end)
	_ = var_2
	arg_1_0.cellUpdates = var_2.map(arg_1_1.map_update, function(arg_5_0)
		local var_5_0 = arg_5_0.item_type

		ChapterConst = var_2_10002

		if var_5_0 ~= var_2_10002.AttachNone then
			local var_5_1 = arg_5_0.item_type

			ChapterConst = var_2

			if var_5_1 ~= var_2.AttachBorn then
				local var_5_2 = arg_5_0.item_type

				ChapterConst = var_2

				if var_5_2 ~= var_2.AttachBorn_Sub then
					local var_5_3 = arg_5_0.item_type

					ChapterConst = var_2

					if var_5_3 == var_2.AttachStory then
						local var_5_4 = arg_5_0.item_data

						ChapterConst = var_2

						if var_5_4 ~= var_2.StoryTrigger then
							local var_5_5 = arg_5_0.item_type

							ChapterConst = var_2

							if var_5_5 == var_2.AttachChampion then
								ChapterChampionPackage = var_5_5

								if not var_5_5.New(arg_5_0) then
									ChapterCell = var_5_5
									var_5_5 = var_5_5.New(arg_5_0)
								end

								do return var_5_5 end
								return
							end
						end
					end
				end
			end
		end
	end)

	return
end

function var_0_0.SetTargetLine(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.sourceLine = arg_6_1
	arg_6_0.targetLine = arg_6_2

	return
end

function var_0_0.applyTo(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 then
		local var_7_0 = 0
		local var_7_1 = 0

		if #arg_7_0.cellFlagUpdates > 0 then
			_ = var_5

			var_5.each(arg_7_0.cellFlagUpdates, function(arg_8_0)
				local var_8_0 = arg_7_1
				local var_8_1

				if var_1.getChapterCell(var_8_0, arg_8_0.row, arg_8_0.column) then
					var_8_1:updateFlagList(arg_8_0)
				else
					ChapterCell = var_8_0
					var_8_1 = var_8_0.New(arg_8_0)
				end

				local var_8_2 = arg_7_1

				var_2.updateChapterCell(var_8_2, var_8_1)

				return
			end)

			bit = var_5

			local var_7_2 = var_5.bor
			local var_7_3 = var_7_0

			ChapterConst = var_7

			local var_7_4 = var_7.DirtyCellFlag

			ChapterConst = var_1_10008
			var_7_0 = var_7_2(var_7_3, var_7_4, var_1_10008.DirtyWeather)
		end

		if #arg_7_0.cellUpdates > 0 then
			_ = var_5

			var_5.each(arg_7_0.cellUpdates, function(arg_9_0)
				isa = var_2_10001

				local var_9_0 = arg_9_0

				ChapterChampionPackage = var_2_10003

				if var_2_10001(var_9_0, var_2_10003) then
					local var_9_1 = arg_7_1

					if var_1.mergeChampion(var_9_1, arg_9_0, true) then
						ChapterConst = var_9_1

						if not var_9_1.DirtyChampionPosition then
							ChapterConst = var_9_1
							var_9_1 = var_9_1.DirtyChampion
						end

						bit = var_3
						var_7_0 = var_3.bor(var_7_0, var_9_1)

						if false then
							local var_9_2 = arg_7_1

							var_1.mergeChapterCell(var_9_2, arg_9_0, true)

							bit = var_1

							local var_9_3 = var_1.bor
							local var_9_4 = var_7_0

							ChapterConst = var_3
							var_7_0 = var_9_3(var_9_4, var_3.DirtyAttachment)
						end

						return
					end
				end
			end)
			arg_7_1:clearChapterCell(arg_7_0.sourceLine.row, arg_7_0.sourceLine.column)

			local var_7_5 = arg_7_1

			if arg_7_1.getChampion(var_7_5, arg_7_0.sourceLine.row, arg_7_0.sourceLine.column) then
				arg_7_1:RemoveChampion(var_5)
			end

			bit = var_7_5

			local var_7_6 = var_7_5.bor
			local var_7_7 = var_7_0

			ChapterConst = var_8
			var_7_0 = var_7_6(var_7_7, var_8.DirtyAttachment)
			bit = var_6

			local var_7_8 = var_6.bor
			local var_7_9 = var_7_1

			ChapterConst = var_8
			var_7_1 = var_7_8(var_7_9, var_8.DirtyAutoAction)
		end

		if #arg_7_0.shipUpdate > 0 then
			_ = var_5

			var_5.each(arg_7_0.shipUpdate, function(arg_10_0)
				local var_10_0 = arg_7_1

				var_1.updateFleetShipHp(var_10_0, arg_10_0.id, arg_10_0.hpRant)

				return
			end)

			bit = var_5

			local var_7_10 = var_5.bor
			local var_7_11 = var_7_0

			ChapterConst = var_7
			var_7_0 = var_7_10(var_7_11, var_7.DirtyFleet)
		end

		return true, var_7_0, var_7_1
	end

	return true
end

function var_0_0.PlayAIAction(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_12_0)
			local var_12_0 = arg_11_2.viewComponent.levelStageView

			var_1.SwitchBottomStagePanel(var_12_0, false)

			local var_12_1 = arg_11_2.viewComponent.grid

			var_1.HideAirExpelAimingMark(var_12_1)
			arg_12_0()

			return
		end,
		arg_11_3
	})

	return
end

return var_0_0
