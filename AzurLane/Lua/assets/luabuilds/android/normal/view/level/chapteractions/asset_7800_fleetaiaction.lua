class = var_0_10000

local var_0_0 = var_0_10000("FleetAIAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.actType = arg_1_1.act_type
	arg_1_0.line = {
		row = arg_1_1.ai_pos.row,
		column = arg_1_1.ai_pos.column
	}

	if arg_1_1.target_pos and arg_1_1.target_pos.row < 9999 and arg_1_1.target_pos.column < 9999 then
		arg_1_0.target = {
			row = arg_1_1.target_pos.row,
			column = arg_1_1.target_pos.column
		}
	end

	_ = var_2
	arg_1_0.shipUpdate = var_2.map(arg_1_1.ship_update, function(arg_2_0)
		return {
			id = arg_2_0.id,
			hpRant = arg_2_0.hp_rant
		}
	end)
	arg_1_0.cellUpdates = {}
	_ = var_2

	var_2.each(arg_1_1.map_update, function(arg_3_0)
		local var_3_0 = arg_3_0.item_type

		ChapterConst = var_2_10002

		if var_3_0 ~= var_2_10002.AttachNone then
			local var_3_1 = arg_3_0.item_type

			ChapterConst = var_2

			if var_3_1 ~= var_2.AttachBorn then
				local var_3_2 = arg_3_0.item_type

				ChapterConst = var_2

				if var_3_2 ~= var_2.AttachBorn_Sub then
					local var_3_3 = arg_3_0.item_type

					ChapterConst = var_2

					if var_3_3 == var_2.AttachStory then
						local var_3_4 = arg_3_0.item_data

						ChapterConst = var_2

						if var_3_4 ~= var_2.StoryTrigger then
							local var_3_5 = arg_3_0.item_type

							ChapterConst = var_2

							if var_3_5 == var_2.AttachChampion then
								ChapterChampionPackage = var_3_5

								if not var_3_5.New(arg_3_0) then
									ChapterCell = var_3_5
									var_3_5 = var_3_5.New(arg_3_0)
								end

								table = var_2

								var_2.insert(arg_1_0.cellUpdates, var_3_5)

								return
							end
						end
					end
				end
			end
		end
	end)

	arg_1_0.commanderSkillEffectId = arg_1_1.commander_skill_effect_id

	return
end

function var_0_0.applyTo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getFleet

	FleetType = var_1_10005

	if var_4_1(var_4_0, var_1_10005.Normal, arg_4_0.line.row, arg_4_0.line.column) then
		return arg_4_0:applyToFleet(arg_4_1, var_3, arg_4_2)
	end

	return false, "can not find any fleet at: [" .. arg_4_0.line.row .. ", " .. arg_4_0.line.column .. "]"
end

function var_0_0.applyToFleet(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_2:isValid() then
		return false, "fleet " .. arg_5_2.id .. " is invalid."
	end

	local var_5_0 = 0

	if arg_5_1:isPlayingWithBombEnemy() then
		if not arg_5_3 then
			_ = var_5

			var_5.each(arg_5_0.cellUpdates, function(arg_6_0)
				local var_6_0 = arg_5_1
				local var_6_1 = var_1.getChapterCell(var_6_0, arg_6_0.row, arg_6_0.column).flag

				ChapterConst = var_3

				if var_6_1 == var_3.CellFlagActive then
					local var_6_2 = arg_6_0.flag

					ChapterConst = var_3

					if var_6_2 == var_3.CellFlagDisabled then
						pg = var_6_2

						local var_6_3 = var_6_2.specialunit_template[var_1.attachmentId]

						assert = var_3

						var_3(var_6_3, "specialunit_template not exist: " .. var_1.attachmentId)

						arg_5_1.modelCount = arg_5_1.modelCount + var_6_3.enemy_point
					end
				end

				local var_6_4 = arg_5_1

				var_2.mergeChapterCell(var_6_4, arg_6_0)

				bit = var_2

				local var_6_5 = var_2.bor
				local var_6_6 = var_5_0

				ChapterConst = var_4
				var_5_0 = var_6_5(var_6_6, var_4.DirtyAttachment)

				return
			end)
		end
	elseif arg_5_0.target then
		_ = var_5

		local var_5_1 = var_5.detect(arg_5_0.cellUpdates, function(arg_7_0)
			return arg_7_0.row == arg_5_0.target.row and arg_7_0.column == arg_5_0.target.column
		end)

		if not arg_5_3 then
			local var_5_2

			if arg_5_0.shipUpdate then
				_ = var_5_2

				var_5_2.each(arg_5_0.shipUpdate, function(arg_8_0)
					local var_8_0 = arg_5_1

					var_1.updateFleetShipHp(var_8_0, arg_8_0.id, arg_8_0.hpRant)

					return
				end)

				bit = var_5_2
				var_5_2 = var_5_2.bor

				local var_5_3 = var_5_0

				ChapterConst = var_1_10008
				var_5_0 = var_5_2(var_5_3, var_1_10008.DirtyFleet)
			end

			if var_5_1 then
				isa = var_5_2

				local var_5_4 = var_5_1

				ChapterChampionPackage = var_1_10008

				local var_5_5

				if var_5_2(var_5_4, var_1_10008) then
					arg_5_1:mergeChampion(var_5_1)

					bit = var_5_5
					var_5_5 = var_5_5.bor

					local var_5_6 = var_5_0

					ChapterConst = var_1_10008
					var_5_0 = var_5_5(var_5_6, var_1_10008.DirtyChampion)
				else
					arg_5_1:mergeChapterCell(var_5_1)

					bit = var_5_5
					var_5_5 = var_5_5.bor

					local var_5_7 = var_5_0

					ChapterConst = var_1_10008
					var_5_0 = var_5_5(var_5_7, var_1_10008.DirtyAttachment)
				end

				bit = var_5_5

				local var_5_8 = var_5_5.bor
				local var_5_9 = var_5_0

				ChapterConst = var_1_10008
				var_5_0 = var_5_8(var_5_9, var_1_10008.DirtyFleet)
			end
		end
	end

	return true, var_5_0
end

function var_0_0.PlayAIAction(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getFleetIndex

	FleetType = var_1_10006

	local var_9_2 = var_9_1(var_9_0, var_1_10006.Normal, arg_9_0.line.row, arg_9_0.line.column)

	assert = var_9_0

	var_9_0(var_9_2)

	local var_9_3 = arg_9_1

	if arg_9_1.isPlayingWithBombEnemy(var_9_3) then
		local var_9_4 = arg_9_1.fleets[var_9_2]

		var_9_3 = arg_9_1:getMapShip(var_9_4)

		local var_9_5 = arg_9_2.viewComponent

		var_7.doPlayStrikeAnim(var_9_5, var_9_3, var_9_3:GetMapStrikeAnim(), arg_9_3)
	else
		local var_9_6 = arg_9_0.actType

		ChapterConst = var_9_3

		if var_9_6 == var_9_3.ActType_Poison then
			arg_9_3()
		elseif arg_9_0.target then
			local var_9_7 = arg_9_1.fleets[var_9_2]

			_ = var_6

			local var_9_8 = var_6.detect(arg_9_0.cellUpdates, function(arg_10_0)
				return arg_10_0.row == arg_9_0.target.row and arg_10_0.column == arg_9_0.target.column
			end)

			assert = var_7

			var_7(var_9_8, "can not find cell")

			local var_9_9 = var_9_8.attachment

			ChapterConst = var_8

			if var_9_9 == var_8.AttachLandbase then
				pg = var_9_9

				local var_9_10 = var_9_9.land_based_template[var_9_8.attachmentId].type

				ChapterConst = var_9

				if var_9_10 == var_9.LBCoastalGun then
					var_9_10 = arg_9_1:getMapShip(var_9_7)

					local var_9_11 = arg_9_2.viewComponent

					var_9.doPlayStrikeAnim(var_9_11, var_9_10, var_9_10:GetMapStrikeAnim(), arg_9_3)
				else
					assert = var_9_10

					var_9_10(false)
				end

				return
			end

			local var_9_12 = "-" .. var_9_8.data / 100 .. "%"
			local var_9_13 = arg_9_0.commanderSkillEffectId
			local var_9_14 = var_9_7
			local var_9_15 = var_9_7.getSkill(var_9_14, var_9_13)

			assert = var_9_14

			var_9_14(var_9_15, "can not find skill: " .. var_9_13)

			local var_9_16 = var_9_7
			local var_9_17 = var_9_7.findCommanderBySkillId(var_9_16, var_9_13)

			assert = var_9_16

			var_9_16(var_9_17, "command can not find by skill id: " .. var_9_13)

			local var_9_18 = arg_9_2.viewComponent

			var_11.doPlayCommander(var_9_18, var_9_17, function()
				local var_11_0 = var_9_15
				local var_11_1 = var_0.GetType(var_11_0)

				FleetSkill = var_11_0

				if var_11_1 == var_11_0.TypeAirStrikeDodge then
					local var_11_2 = arg_9_2.viewComponent

					var_0.easeAvoid(var_11_2, arg_9_2.viewComponent.grid.cellFleets[var_9_7.id].tf.position, arg_9_3)

					return
				else
					local var_11_3 = var_9_15
					local var_11_4 = var_0.GetType(var_11_3)

					FleetSkill = var_11_3

					if var_11_4 == var_11_3.TypeAttack then
						local var_11_5 = var_9_15

						var_11_4 = var_11_4.GetArgs(var_11_5)

						local var_11_6

						switch = var_2_10002

						var_2_10002(var_11_4[1], {
							airfight = function()
								var_11_6 = "AirStrikeUI"

								return
							end,
							torpedo = function()
								var_11_6 = "SubTorpedoUI"

								return
							end,
							cannon = function()
								var_11_6 = "CannonUI"

								return
							end
						})

						assert = var_2_10002

						var_2_10002(var_11_6)

						local var_11_7 = arg_9_2.viewComponent
						local var_11_8 = var_2.doPlayStrikeAnim
						local var_11_9 = arg_9_1

						var_11_8(var_11_7, var_4.getStrikeAnimShip(var_11_9, var_9_7, var_11_6), var_11_6, function()
							local var_15_0 = arg_9_2.viewComponent

							var_0.strikeEnemy(var_15_0, arg_9_0.target, var_9_12, arg_9_3)

							return
						end)

						return
					else
						assert = var_11_4

						var_11_4(false)
					end
				end

				return
			end)
		else
			arg_9_3()
		end
	end

	return
end

return var_0_0
