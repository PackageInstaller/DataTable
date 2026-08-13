class = var_0_10000

local var_0_0 = var_0_10000("ChapterAIAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.line = {
		row = arg_1_1.ai_pos.row,
		column = arg_1_1.ai_pos.column
	}
	arg_1_0.stgId = arg_1_1.strategy_id

	if arg_1_1.target_pos then
		arg_1_0.stgTarget = {
			row = arg_1_1.target_pos.row,
			column = arg_1_1.target_pos.column
		}
	end

	_ = var_2
	arg_1_0.movePath = var_2.map(arg_1_1.move_path, function(arg_2_0)
		return {
			row = arg_2_0.row,
			column = arg_2_0.column
		}
	end)
	_ = var_2
	arg_1_0.shipUpdate = var_2.map(arg_1_1.ship_update, function(arg_3_0)
		return {
			id = arg_3_0.id,
			hpRant = arg_3_0.hp_rant
		}
	end)
	arg_1_0.cellUpdates = {}
	_ = var_2

	var_2.each(arg_1_1.map_update, function(arg_4_0)
		local var_4_0 = arg_4_0.item_type

		ChapterConst = var_2_10002

		if var_4_0 ~= var_2_10002.AttachNone then
			local var_4_1 = arg_4_0.item_type

			ChapterConst = var_2

			if var_4_1 ~= var_2.AttachBorn then
				local var_4_2 = arg_4_0.item_type

				ChapterConst = var_2

				if var_4_2 ~= var_2.AttachBorn_Sub then
					local var_4_3 = arg_4_0.item_type

					ChapterConst = var_2

					if var_4_3 == var_2.AttachStory then
						local var_4_4 = arg_4_0.item_data

						ChapterConst = var_2

						if var_4_4 ~= var_2.StoryTrigger then
							local var_4_5 = arg_4_0.item_type

							ChapterConst = var_2

							if var_4_5 == var_2.AttachChampion then
								ChapterChampionPackage = var_4_5

								if not var_4_5.New(arg_4_0) then
									ChapterCell = var_4_5
									var_4_5 = var_4_5.New(arg_4_0)
								end

								table = var_2

								var_2.insert(arg_1_0.cellUpdates, var_4_5)

								return
							end
						end
					end
				end
			end
		end
	end)

	arg_1_0.actType = arg_1_1.act_type
	arg_1_0.hp_del = arg_1_1.hp_del

	return
end

function var_0_0.PlayAIAction(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1:getChapterCell(arg_5_0.line.row, arg_5_0.line.column) then
		local var_5_0 = var_4.attachment

		ChapterConst = var_6

		if var_5_0 == var_6.AttachLandbase then
			table = var_5_0

			if not var_5_0.equal(arg_5_0.stgTarget, {
				row = 9999,
				columns = 9999
			}) then
				pg = var_5

				local var_5_1 = var_5.land_based_template[var_4.attachmentId].type

				ChapterConst = var_7

				local var_5_2

				if var_5_1 == var_7.LBCoastalGun then
					var_5_2 = arg_5_2.viewComponent

					var_6.doPlayAnim(var_5_2, "coastalgun", function(arg_6_0)
						setActive = var_2_10001

						var_2_10001(arg_6_0, false)
						arg_5_3()

						return
					end)
				else
					local var_5_3 = var_5.type

					ChapterConst = var_5_2

					local var_5_4

					if var_5_3 == var_5_2.LBHarbor then
						if not arg_5_0.hp_del or arg_5_0.hp_del <= 0 then
							arg_5_3()
						end

						var_5_4 = arg_5_2.viewComponent.grid

						local var_5_5 = var_6.PlayAttachmentEffect
						local var_5_6 = var_4.row
						local var_5_7 = var_4.column
						local var_5_8 = "huoqiubaozha"

						Vector2 = var_1_10011

						var_5_5(var_5_4, var_5_6, var_5_7, var_5_8, var_1_10011.zero)
						arg_5_3()
					else
						local var_5_9 = var_5.type

						ChapterConst = var_5_4

						if var_5_9 == var_5_4.LBDock then
							arg_5_3()
						else
							local var_5_10 = var_5.type

							ChapterConst = var_7

							if var_5_10 == var_7.LBAntiAir then
								local var_5_11 = arg_5_2.viewComponent

								var_5_10.doPlayAnim(var_5_11, "AntiAirFire", function(arg_7_0)
									setActive = var_2_10001

									var_2_10001(arg_7_0, false)

									local var_7_0 = arg_5_2.viewComponent.grid
									local var_7_1 = var_1.PlayAttachmentEffect
									local var_7_2 = arg_5_0.stgTarget.row
									local var_7_3 = arg_5_0.stgTarget.column
									local var_7_4 = "huoqiubaozha"

									Vector2 = var_2_10006

									var_7_1(var_7_0, var_7_2, var_7_3, var_7_4, var_2_10006.zero, arg_5_3)

									return
								end)
							else
								assert = var_5_10

								var_5_10(false)
							end
						end
					end
				end

				return
			end
		end
	end

	local var_5_12 = arg_5_0.stgId

	if 0 < var_5_12 then
		local var_5_13 = arg_5_0.stgId

		ChapterConst = var_6

		if var_5_13 == var_6.StrategySonarDetect then
			var_5_13 = {}
			_ = var_6

			var_6.each(arg_5_0.cellUpdates, function(arg_8_0)
				isa = var_2_10001

				local var_8_0 = arg_8_0

				ChapterChampionPackage = var_2_10003

				if var_2_10001(var_8_0, var_2_10003) then
					table = var_1

					var_1.insert(var_5_13, arg_8_0)
				end

				return
			end)

			local var_5_14 = arg_5_2.viewComponent.grid

			var_6.PlaySonarDetectAnim(var_5_14, var_5_13, arg_5_3)
		else
			assert = var_5_13

			var_5_13(false)
		end

		return
	end

	local var_5_15 = arg_5_1:getChampion(arg_5_0.line.row, arg_5_0.line.column)
	local var_5_16 = arg_5_1:getChampionIndex(arg_5_0.line.row, arg_5_0.line.column)
	local var_5_17

	if not arg_5_0.movePath[#arg_5_0.movePath] then
		var_5_17 = arg_5_0.line
	end

	if var_5_16 then
		seriesAsync = var_8

		var_8({
			function(arg_9_0)
				if #arg_5_0.movePath > 0 then
					local var_9_0 = arg_5_2.viewComponent.grid
					local var_9_1 = var_1.moveChampion
					local var_9_2 = var_5_16
					local var_9_3 = arg_5_0.movePath

					Clone = var_2_10005

					var_9_1(var_9_0, var_9_2, var_9_3, var_2_10005(arg_5_0.movePath), arg_9_0)
				else
					arg_9_0()
				end

				return
			end,
			function(arg_10_0)
				if #arg_5_0.shipUpdate > 0 then
					local var_10_0 = arg_5_2.viewComponent

					var_1.doPlayEnemyAnim(var_10_0, var_5_15, "SubSairenTorpedoUI", arg_10_0)
				else
					arg_10_0()
				end

				return
			end,
			function(arg_11_0)
				local var_11_0 = false
				local var_11_1 = arg_5_0.actType

				ChapterConst = var_2_10003

				if var_11_1 == var_2_10003.ActType_SubmarineHunting and #arg_5_0.cellUpdates > 0 then
					_ = var_2

					var_2.each(arg_5_0.cellUpdates, function(arg_12_0)
						if var_5_17.row == arg_12_0.row and var_5_17.column == arg_12_0.column then
							isa = var_1

							local var_12_0 = arg_12_0

							ChapterChampionPackage = var_3_10003

							if var_1(var_12_0, var_3_10003) then
								local var_12_1 = arg_5_0

								var_1.TryPlayChampionSubAnim(var_12_1, arg_5_2, arg_12_0, var_5_15, arg_11_0)

								var_11_0 = true
							end
						end

						return
					end)
				end

				if not var_11_0 then
					arg_11_0()
				end

				return
			end,
			function(arg_13_0)
				arg_5_3()

				return
			end
		})

		return
	end

	assert = var_8

	var_8(false)

	return
end

function var_0_0.TryPlayChampionSubAnim(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_2.flag

	ChapterConst = var_1_10006

	if var_14_0 ~= var_1_10006.CellFlagDiving then
		local var_14_1 = arg_14_3.flag

		ChapterConst = var_6

		if var_14_1 == var_6.CellFlagDiving then
			local var_14_2 = arg_14_2.flag

			ChapterConst = var_6

			if var_14_2 ~= var_6.CellFlagActive then
				local var_14_3 = arg_14_3.flag

				ChapterConst = var_6

				if var_14_3 == var_6.CellFlagActive then
					local var_14_4 = arg_14_2.flag

					ChapterConst = var_6

					local var_14_5 = var_14_4 == var_6.CellFlagDiving
					local var_14_6 = arg_14_1.viewComponent.grid

					var_6.PlayChampionSubmarineAnimation(var_14_6, arg_14_3, var_14_5, arg_14_4)

					return
				end

				arg_14_4()

				return
			end
		end
	end
end

function var_0_0.applyTo(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1:getChapterCell(arg_15_0.line.row, arg_15_0.line.column) then
		local var_15_0 = var_3.attachment

		ChapterConst = var_5

		if var_15_0 == var_5.AttachLandbase then
			table = var_15_0

			if not var_15_0.equal(arg_15_0.stgTarget, {
				row = 9999,
				column = 9999
			}) then
				pg = var_4

				local var_15_1 = var_4.land_based_template[var_3.attachmentId].type

				ChapterConst = var_6

				local var_15_2

				if var_15_1 == var_6.LBCoastalGun then
					var_15_2 = arg_15_0

					return arg_15_0.applyToCoastalGun(var_15_2, arg_15_1, var_3, arg_15_2)
				else
					local var_15_3 = var_4.type

					ChapterConst = var_15_2

					local var_15_4

					if var_15_3 == var_15_2.LBHarbor then
						var_15_4 = arg_15_0

						return arg_15_0.applyToHarbor(var_15_4, arg_15_1, var_3, arg_15_2)
					else
						local var_15_5 = var_4.type

						ChapterConst = var_15_4

						local var_15_6

						if var_15_5 == var_15_4.LBDock then
							var_15_6 = arg_15_0

							return arg_15_0.applyToDock(var_15_6, arg_15_1, var_3, arg_15_2)
						else
							local var_15_7 = var_4.type

							ChapterConst = var_15_6

							if var_15_7 == var_15_6.LBAntiAir then
								return arg_15_0:applyToAntiAir(arg_15_1, var_3, arg_15_2)
							else
								return false, "Trouble with Attach LandBased"
							end
						end
					end
				end
			end
		end
	end

	if arg_15_0.stgId > 0 then
		return arg_15_0:applyToStrategy(arg_15_1, arg_15_0.stgId, arg_15_2)
	end

	if arg_15_1:getChampion(arg_15_0.line.row, arg_15_0.line.column) then
		return arg_15_0:applyToChampion(arg_15_1, var_4, arg_15_2)
	end

	return false, "can not find any object at: [" .. arg_15_0.line.row .. ", " .. arg_15_0.line.column .. "]"
end

function var_0_0.applyToChampion(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_2.flag

	ChapterConst = var_1_10005

	if var_16_0 == var_1_10005.CellFlagDisabled then
		return false, "can not apply ai to dead champion at: [" .. arg_16_0.line.row .. ", " .. arg_16_0.line.column .. "]"
	end

	local var_16_1 = 0
	local var_16_2 = 0
	local var_16_3 = arg_16_0.line

	if arg_16_0.stgId > 0 then
		pg = var_7

		if not var_7.strategy_data_template[arg_16_0.stgId] then
			return false, "can not find strategy: " .. arg_16_0.stgId
		end
	end

	if #arg_16_0.movePath > 0 then
		var_16_3 = arg_16_0.movePath[#arg_16_0.movePath]
		_ = var_7

		if var_7.any(arg_16_0.movePath, function(arg_17_0)
			local var_17_0 = arg_16_1

			return not var_1.getChapterCell(var_17_0, arg_17_0.row, arg_17_0.column) or not var_1:IsWalkable()
		end) then
			return false, "invalide move path"
		end
	end

	if #arg_16_0.shipUpdate > 0 then
		local var_16_4 = arg_16_1
		local var_16_5 = arg_16_1.getFleet

		FleetType = var_1_10009

		if not var_16_5(var_16_4, var_1_10009.Normal, var_16_3.row, var_16_3.column) then
			return false, "can not find fleet at: [" .. arg_16_0.line.row .. ", " .. arg_16_0.line.column .. "]"
		end
	end

	if not arg_16_3 then
		if #arg_16_0.movePath > 0 then
			arg_16_2.row = var_16_3.row
			arg_16_2.column = var_16_3.column
			bit = var_7

			local var_16_6 = var_7.bor
			local var_16_7 = var_16_1

			ChapterConst = var_1_10009
			var_16_1 = var_16_6(var_16_7, var_1_10009.DirtyChampionPosition)
		end

		local var_16_8 = arg_16_1
		local var_16_9 = arg_16_1.existFleet

		FleetType = var_1_10009

		if var_16_9(var_16_8, var_1_10009.Submarine, arg_16_2.row, arg_16_2.column) then
			bit = var_7

			local var_16_10 = var_7.bor

			var_16_8 = var_16_1
			ChapterConst = var_9
			var_16_1 = var_16_10(var_16_8, var_9.DirtyFleet)
		end

		local var_16_11 = arg_16_0.actType

		ChapterConst = var_16_8

		if var_16_11 == var_16_8.ActType_SubmarineHunting and arg_16_1:getChapterCell(var_16_3.row, var_16_3.column) then
			local var_16_12 = var_7.attachment

			ChapterConst = var_9

			if var_16_12 == var_9.AttachBarrier then
				ChapterConst = var_16_12
				var_7.flag = var_16_12.CellFlagDisabled

				arg_16_1:mergeChapterCell(var_7)

				bit = var_8

				local var_16_13 = var_8.bor
				local var_16_14 = var_16_1

				ChapterConst = var_10
				var_16_1 = var_16_13(var_16_14, var_10.DirtyAttachment)
			end
		end

		if #arg_16_0.shipUpdate > 0 then
			_ = var_7

			var_7.each(arg_16_0.shipUpdate, function(arg_18_0)
				local var_18_0 = arg_16_1

				var_1.updateFleetShipHp(var_18_0, arg_18_0.id, arg_18_0.hpRant)

				return
			end)

			bit = var_7

			local var_16_15 = var_7.bor
			local var_16_16 = var_16_1

			ChapterConst = var_9
			var_16_1 = var_16_15(var_16_16, var_9.DirtyFleet)
		end

		if #arg_16_0.cellUpdates > 0 then
			_ = var_7

			var_7.each(arg_16_0.cellUpdates, function(arg_19_0)
				isa = var_2_10001

				local var_19_0 = arg_19_0

				ChapterChampionPackage = var_2_10003

				if var_2_10001(var_19_0, var_2_10003) then
					local var_19_1 = arg_16_1

					if var_1.mergeChampion(var_19_1, arg_19_0) then
						ChapterConst = var_19_1

						if not var_19_1.DirtyChampionPosition then
							ChapterConst = var_19_1
							var_19_1 = var_19_1.DirtyChampion
						end

						bit = var_3
						var_16_1 = var_3.bor(var_16_1, var_19_1)

						if false then
							local var_19_2 = arg_16_1

							var_1.mergeChapterCell(var_19_2, arg_19_0)

							bit = var_1

							local var_19_3 = var_1.bor
							local var_19_4 = var_16_1

							ChapterConst = var_3
							var_16_1 = var_19_3(var_19_4, var_3.DirtyAttachment)
						end

						return
					end
				end
			end)

			bit = var_7

			local var_16_17 = var_7.bor
			local var_16_18 = var_16_2

			ChapterConst = var_9
			var_16_2 = var_16_17(var_16_18, var_9.DirtyAutoAction)
		end
	end

	return true, var_16_1, var_16_2
end

function var_0_0.applyToStrategy(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	pg = var_1_10004

	if not var_1_10004.strategy_data_template[arg_20_2] then
		return false, "can not find strategy: " .. arg_20_2
	end

	local var_20_0 = 0

	if not arg_20_3 then
		local var_20_1 = arg_20_0.stgId

		ChapterConst = var_1_10007

		if var_20_1 == var_1_10007.StrategySonarDetect then
			_ = var_20_1

			var_20_1.each(arg_20_0.cellUpdates, function(arg_21_0)
				isa = var_2_10001

				local var_21_0 = arg_21_0

				ChapterChampionPackage = var_2_10003

				if var_2_10001(var_21_0, var_2_10003) then
					local var_21_1 = arg_20_1

					var_1.mergeChampion(var_21_1, arg_21_0)

					bit = var_1

					local var_21_2 = var_1.bor
					local var_21_3 = var_20_0

					ChapterConst = var_3
					var_20_0 = var_21_2(var_21_3, var_3.DirtyChampion)
				else
					local var_21_4 = arg_20_1

					var_1.mergeChapterCell(var_21_4, arg_21_0)

					bit = var_1

					local var_21_5 = var_1.bor
					local var_21_6 = var_20_0

					ChapterConst = var_3
					var_20_0 = var_21_5(var_21_6, var_3.DirtyAttachment)
				end

				return
			end)
		end
	end

	return true, var_20_0
end

function var_0_0.applyToCoastalGun(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_2.flag

	ChapterConst = var_1_10005

	if var_22_0 == var_1_10005.CellFlagDisabled then
		return false, "can not apply ai to dead coastalgun at: [" .. arg_22_0.line.row .. ", " .. arg_22_0.line.column .. "]"
	end

	local var_22_1 = 0
	local var_22_2 = 0
	local var_22_3 = arg_22_1
	local var_22_4 = arg_22_1.getFleet

	FleetType = var_1_10008

	if not var_22_4(var_22_3, var_1_10008.Normal, arg_22_0.stgTarget.row, arg_22_0.stgTarget.column) then
		return false, "can not find fleet at: [" .. arg_22_0.stgTarget.row .. ", " .. arg_22_0.stgTarget.column .. "]"
	end

	if not arg_22_3 then
		var_6:increaseSlowSpeedFactor()

		bit = var_7

		local var_22_5 = var_7.bor
		local var_22_6 = var_22_1

		ChapterConst = var_9
		var_22_1 = var_22_5(var_22_6, var_9.DirtyFleet)
		_ = var_7

		var_7.each(arg_22_0.cellUpdates, function(arg_23_0)
			isa = var_2_10001

			local var_23_0 = arg_23_0

			ChapterChampionPackage = var_2_10003

			if var_2_10001(var_23_0, var_2_10003) then
				local var_23_1 = arg_22_1

				var_1.mergeChampion(var_23_1, arg_23_0)

				bit = var_1

				local var_23_2 = var_1.bor
				local var_23_3 = var_22_1

				ChapterConst = var_3
				var_22_1 = var_23_2(var_23_3, var_3.DirtyChampion)
			else
				local var_23_4 = arg_22_1

				var_1.mergeChapterCell(var_23_4, arg_23_0)

				bit = var_1

				local var_23_5 = var_1.bor
				local var_23_6 = var_22_1

				ChapterConst = var_3
				var_22_1 = var_23_5(var_23_6, var_3.DirtyAttachment)
			end

			return
		end)

		if #arg_22_0.cellUpdates > 0 then
			bit = var_7

			local var_22_7 = var_7.bor
			local var_22_8 = var_22_2

			ChapterConst = var_9
			var_22_2 = var_22_7(var_22_8, var_9.DirtyAutoAction)
		end
	end

	return true, var_22_1, var_22_2
end

function var_0_0.applyToHarbor(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_2.flag

	ChapterConst = var_1_10005

	if var_24_0 == var_1_10005.CellFlagDisabled then
		return false, "can not apply ai to dead Harbor at: [" .. arg_24_0.line.row .. ", " .. arg_24_0.line.column .. "]"
	end

	local var_24_1 = 0
	local var_24_2 = 0
	local var_24_3 = arg_24_1

	if not arg_24_1.getChampion(var_24_3, arg_24_0.stgTarget.row, arg_24_0.stgTarget.column) then
		return false, "can not find champion at: [" .. arg_24_0.stgTarget.row .. ", " .. arg_24_0.stgTarget.column .. "]"
	end

	if not arg_24_3 then
		math = var_24_3
		arg_24_1.BaseHP = var_24_3.max(arg_24_1.BaseHP - arg_24_0.hp_del, 0)

		arg_24_1:RemoveChampion(var_6)

		bit = var_7

		local var_24_4 = var_7.bor
		local var_24_5 = var_24_1

		ChapterConst = var_9

		local var_24_6 = var_9.DirtyBase

		ChapterConst = var_1_10010
		var_24_1 = var_24_4(var_24_5, var_24_6, var_1_10010.DirtyChampion)
		bit = var_7

		local var_24_7 = var_7.bor
		local var_24_8 = var_24_2

		ChapterConst = var_24_6
		var_24_2 = var_24_7(var_24_8, var_24_6.DirtyAutoAction)

		if #arg_24_0.cellUpdates > 0 then
			_ = var_7

			var_7.each(arg_24_0.cellUpdates, function(arg_25_0)
				isa = var_2_10001

				local var_25_0 = arg_25_0

				ChapterChampionPackage = var_2_10003

				if var_2_10001(var_25_0, var_2_10003) then
					local var_25_1 = arg_24_1
					local var_25_2 = var_1.mergeChampion(var_25_1, arg_25_0)

					bit = var_25_1

					local var_25_3 = var_25_1.bor
					local var_25_4 = var_24_1

					ChapterConst = var_2_10004
					var_24_1 = var_25_3(var_25_4, var_2_10004.DirtyChampion)
				else
					local var_25_5 = arg_24_1

					var_1.mergeChapterCell(var_25_5, arg_25_0)

					bit = var_1

					local var_25_6 = var_1.bor
					local var_25_7 = var_24_1

					ChapterConst = var_3
					var_24_1 = var_25_6(var_25_7, var_3.DirtyAttachment)
				end

				return
			end)
		end
	end

	return true, var_24_1, var_24_2
end

function var_0_0.applyToDock(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_2.flag

	ChapterConst = var_1_10005

	if var_26_0 == var_1_10005.CellFlagDisabled then
		return false, "can not apply ai to dead Dock at: [" .. arg_26_0.line.row .. ", " .. arg_26_0.line.column .. "]"
	end

	local var_26_1 = 0
	local var_26_2 = 0
	local var_26_3 = arg_26_1
	local var_26_4 = arg_26_1.getFleet

	FleetType = var_1_10008

	if not var_26_4(var_26_3, var_1_10008.Normal, arg_26_0.stgTarget.row, arg_26_0.stgTarget.column) then
		return false, "can not find fleet at: [" .. arg_26_0.stgTarget.row .. ", " .. arg_26_0.stgTarget.column .. "]"
	end

	if not arg_26_3 then
		_ = var_26_3

		var_26_3.each(arg_26_0.cellUpdates, function(arg_27_0)
			isa = var_2_10001

			local var_27_0 = arg_27_0

			ChapterCell = var_2_10003

			if var_2_10001(var_27_0, var_2_10003) then
				local var_27_1 = arg_26_1

				var_1.mergeChapterCell(var_27_1, arg_27_0)

				bit = var_1

				local var_27_2 = var_1.bor
				local var_27_3 = var_26_1

				ChapterConst = var_3
				var_26_1 = var_27_2(var_27_3, var_3.DirtyAttachment)
			end

			return
		end)

		_ = var_7

		var_7.each(arg_26_0.shipUpdate, function(arg_28_0)
			local var_28_0 = arg_26_1

			var_1.updateFleetShipHp(var_28_0, arg_28_0.id, arg_28_0.hpRant)

			return
		end)

		bit = var_7

		local var_26_5 = var_7.bor
		local var_26_6 = var_26_1

		ChapterConst = var_9
		var_26_1 = var_26_5(var_26_6, var_9.DirtyFleet)
	end

	return true, var_26_1
end

function var_0_0.applyToAntiAir(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_2.flag

	ChapterConst = var_1_10005

	if var_29_0 == var_1_10005.CellFlagDisabled then
		return false, "can not apply ai to dead antiairGun at: [" .. arg_29_0.line.row .. ", " .. arg_29_0.line.column .. "]"
	end

	local var_29_1 = 0
	local var_29_2 = 0

	if not arg_29_1:getChampion(arg_29_0.stgTarget.row, arg_29_0.stgTarget.column) then
		return false, "can not find champion at: [" .. arg_29_0.stgTarget.row .. ", " .. arg_29_0.stgTarget.column .. "]"
	end

	if not arg_29_3 then
		arg_29_1:RemoveChampion(var_6)

		bit = var_7

		local var_29_3 = var_7.bor
		local var_29_4 = var_29_1

		ChapterConst = var_9

		local var_29_5 = var_9.DirtyChampion

		ChapterConst = var_1_10010
		var_29_1 = var_29_3(var_29_4, var_29_5, var_1_10010.DirtyAttachment)
		_ = var_7

		var_7.each(arg_29_0.cellUpdates, function(arg_30_0)
			isa = var_2_10001

			local var_30_0 = arg_30_0

			ChapterChampionPackage = var_2_10003

			if var_2_10001(var_30_0, var_2_10003) then
				local var_30_1 = arg_29_1
				local var_30_2 = var_1.mergeChampion(var_30_1, arg_30_0)
			else
				local var_30_3 = arg_29_1

				var_1.mergeChapterCell(var_30_3, arg_30_0)

				bit = var_1

				local var_30_4 = var_1.bor
				local var_30_5 = var_29_1

				ChapterConst = var_3
				var_29_1 = var_30_4(var_30_5, var_3.DirtyAttachment)
			end

			return
		end)
	end

	return true, var_29_1, var_29_2
end

return var_0_0
