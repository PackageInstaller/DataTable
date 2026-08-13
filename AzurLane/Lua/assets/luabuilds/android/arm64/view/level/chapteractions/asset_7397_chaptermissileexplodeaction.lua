class = var_0_10000

local var_0_0 = var_0_10000("ChapterMissileExplodeAction")

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

function var_0_0.SetTargetLine(arg_6_0, arg_6_1)
	arg_6_0.targetLine = arg_6_1
	arg_6_0.flagStrategy = true

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
					ChapterCell = var_2_10002
					var_8_1 = var_2_10002.New(arg_8_0)
				end

				local var_8_2 = arg_7_1

				var_2.updateChapterCell(var_8_2, var_8_1)

				return
			end)

			bit = var_5

			local var_7_2 = var_5.bor
			local var_7_3 = var_7_0

			ChapterConst = var_8

			local var_7_4 = var_8.DirtyCellFlag

			ChapterConst = var_1_10009
			var_7_0 = var_7_2(var_7_3, var_7_4, var_1_10009.DirtyWeather)
		end

		if #arg_7_0.cellUpdates > 0 then
			_ = var_5

			var_5.each(arg_7_0.cellUpdates, function(arg_9_0)
				isa = var_2_10001

				local var_9_0 = arg_9_0

				ChapterChampionPackage = var_2_10004

				if var_2_10001(var_9_0, var_2_10004) then
					local var_9_1 = arg_7_1

					if var_1.mergeChampion(var_9_1, arg_9_0) then
						ChapterConst = var_2_10002

						if not var_2_10002.DirtyChampionPosition then
							ChapterConst = var_2_10002
							var_2_10002 = var_2_10002.DirtyChampion
						end

						bit = var_9_1
						var_7_0 = var_9_1.bor(var_7_0, var_2_10002)

						if false then
							local var_9_2 = arg_7_1

							var_1.mergeChapterCell(var_9_2, arg_9_0)

							bit = var_1

							local var_9_3 = var_1.bor
							local var_9_4 = var_7_0

							ChapterConst = var_4
							var_7_0 = var_9_3(var_9_4, var_4.DirtyAttachment)
						end

						return
					end
				end
			end)

			bit = var_5

			local var_7_5 = var_5.bor
			local var_7_6 = var_7_1

			ChapterConst = var_8
			var_7_1 = var_7_5(var_7_6, var_8.DirtyAutoAction)
		end

		if #arg_7_0.shipUpdate > 0 then
			_ = var_5

			var_5.each(arg_7_0.shipUpdate, function(arg_10_0)
				local var_10_0 = arg_7_1

				var_1.updateFleetShipHp(var_10_0, arg_10_0.id, arg_10_0.hpRant)

				return
			end)

			bit = var_5

			local var_7_7 = var_5.bor
			local var_7_8 = var_7_0

			ChapterConst = var_8
			var_7_0 = var_7_7(var_7_8, var_8.DirtyFleet)
		end

		return true, var_7_0, var_7_1
	end

	return true
end

function var_0_0.PlayAIAction(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0
	local var_11_1

	if arg_11_0.targetLine then
		var_11_0 = {
			arg_11_0.targetLine
		}
	else
		function var_11_1(arg_12_0)
			local var_12_0 = arg_11_1

			if var_1.GetRawChapterCell(var_12_0, arg_12_0.row, arg_12_0.column) then
				::label_12_0::

				table = var_2_10002
				var_2_10002 = var_2_10002.contains

				local var_12_1 = var_1:GetFlagList()

				ChapterConst = var_5

				if var_2_10002(var_12_1, var_5.FlagMissleAiming) then
					table = var_2_10002
					var_2_10002 = var_2_10002.contains

					local var_12_2 = arg_12_0.flag_list

					ChapterConst = var_5
					var_2_10002 = not var_2_10002(var_12_2, var_5.FlagMissleAiming)
				end
			end

			return var_2_10002
		end

		_ = var_1_10006
		var_11_0 = var_1_10006.filter(arg_11_0.cellFlagUpdates, function(arg_13_0)
			return var_11_1(arg_13_0)
		end)
	end

	seriesAsync = var_11_1

	var_11_1({
		function(arg_14_0)
			if not arg_11_0.flagStrategy then
				return arg_14_0()
			end

			local var_14_0 = arg_11_2.viewComponent

			var_1.doPlayAnim(var_14_0, "MissileStrikeBar", function(arg_15_0)
				setActive = var_3_10001

				var_3_10001(arg_15_0, false)
				arg_14_0()

				return
			end)

			return
		end,
		function(arg_16_0)
			table = var_2_10001

			var_2_10001.ParallelIpairsAsync(var_11_0, function(arg_17_0, arg_17_1, arg_17_2)
				local var_17_0 = arg_11_2.viewComponent.grid

				var_3.PlayMissileExplodAnim(var_17_0, arg_17_1, arg_17_2)

				return
			end, arg_16_0)

			return
		end,
		function(arg_18_0)
			table = var_2_10001

			var_2_10001.ParallelIpairsAsync(arg_11_0.cellUpdates, function(arg_19_0, arg_19_1, arg_19_2)
				ChapterConst = var_3_10003

				if var_3_10003.IsBossCell(arg_19_1) then
					local var_19_0 = arg_11_2.viewComponent.grid

					var_3.PlayShellFx(var_19_0, arg_19_1)
					arg_19_2()
				else
					local var_19_1 = arg_11_1
					local var_19_2

					if not var_3.GetRawChapterCell(var_19_1, arg_19_1.row, arg_19_1.column) or not var_3.data then
						var_19_2 = 0
					end

					local var_19_3 = "-" .. (arg_19_1.data - var_19_2) / 100 .. "%"
					local var_19_4 = arg_11_2.viewComponent

					var_6.strikeEnemy(var_19_4, arg_19_1, var_19_3, arg_19_2)
				end

				return
			end, arg_18_0)

			return
		end,
		function(arg_20_0)
			local var_20_0 = arg_11_2.viewComponent.levelStageView

			var_1.SwitchBottomStagePanel(var_20_0, false)

			local var_20_1 = arg_11_2.viewComponent.grid

			var_1.HideMissileAimingMark(var_20_1)
			arg_20_0()

			return
		end,
		arg_11_3
	})

	return
end

return var_0_0
