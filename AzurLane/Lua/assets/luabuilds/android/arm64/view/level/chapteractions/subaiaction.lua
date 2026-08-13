class = var_0_10000

local var_0_0 = var_0_10000("SubAIAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
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
	arg_1_0.movePath = var_2.map(arg_1_1.move_path, function(arg_2_0)
		return {
			row = arg_2_0.row,
			column = arg_2_0.column
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

	return
end

function var_0_0.applyTo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getFleet

	FleetType = var_1_10006

	if var_4_1(var_4_0, var_1_10006.Submarine, arg_4_0.line.row, arg_4_0.line.column) then
		return arg_4_0:applyToFleet(arg_4_1, var_3, arg_4_2)
	end

	return false, "can not find any submarine at: [" .. arg_4_0.line.row .. ", " .. arg_4_0.line.column .. "]"
end

function var_0_0.applyToFleet(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 0

	if not arg_5_2:isValid() then
		return false, "fleet " .. arg_5_2.id .. " is invalid."
	end

	if arg_5_0.target then
		if arg_5_2.restAmmo <= 0 then
			return false, "lack ammo of fleet."
		end

		_ = var_5

		if not var_5.detect(arg_5_0.cellUpdates, function(arg_6_0)
			return arg_6_0.row == arg_5_0.target.row and arg_6_0.column == arg_5_0.target.column
		end) then
			return false, "can not find cell update at: [" .. arg_5_0.target.row .. ", " .. arg_5_0.target.column .. "]"
		end

		if not arg_5_3 then
			isa = var_6

			local var_5_1 = var_5

			ChapterChampionPackage = var_1_10009

			if var_6(var_5_1, var_1_10009) then
				arg_5_1:mergeChampion(var_5)

				bit = var_6

				local var_5_2 = var_6.bor
				local var_5_3 = var_5_0

				ChapterConst = var_1_10009
				var_5_0 = var_5_2(var_5_3, var_1_10009.DirtyChampion)
			else
				arg_5_1:mergeChapterCell(var_5)

				bit = var_6

				local var_5_4 = var_6.bor
				local var_5_5 = var_5_0

				ChapterConst = var_1_10009
				var_5_0 = var_5_4(var_5_5, var_1_10009.DirtyAttachment)
			end

			arg_5_2.restAmmo = arg_5_2.restAmmo - 1
			bit = var_6

			local var_5_6 = var_6.bor
			local var_5_7 = var_5_0

			ChapterConst = var_1_10009
			var_5_0 = var_5_6(var_5_7, var_1_10009.DirtyFleet)
		end
	elseif #arg_5_0.movePath > 0 then
		_ = var_5

		if var_5.any(arg_5_0.movePath, function(arg_7_0)
			local var_7_0 = arg_5_1

			return not var_1.getChapterCell(var_7_0, arg_7_0.row, arg_7_0.column) or not var_1:IsWalkable()
		end) then
			return false, "invalide move path"
		end

		if not arg_5_3 then
			local var_5_8 = arg_5_0.movePath[#arg_5_0.movePath]

			arg_5_2.line = {
				row = var_5_8.row,
				column = var_5_8.column
			}
			bit = var_6

			local var_5_9 = var_6.bor
			local var_5_10 = var_5_0

			ChapterConst = var_1_10009
			var_5_0 = var_5_9(var_5_10, var_1_10009.DirtyFleet)
		end
	end

	return true, var_5_0
end

function var_0_0.PlayAIAction(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getFleetIndex

	FleetType = var_1_10007

	if var_8_1(var_8_0, var_1_10007.Submarine, arg_8_0.line.row, arg_8_0.line.column) then
		if arg_8_0.target then
			local var_8_2 = arg_8_1.fleets[var_4]

			_ = var_8_0

			local var_8_3 = var_8_0.detect(arg_8_0.cellUpdates, function(arg_9_0)
				return arg_9_0.row == arg_8_0.target.row and arg_9_0.column == arg_8_0.target.column
			end)
			local var_8_4

			if not arg_8_1:GetRawChapterCell(var_8_3.row, var_8_3.column) or not var_7.data then
				var_8_4 = 0
			end

			local var_8_5 = "-" .. (var_8_3.data - var_8_4) / 100 .. "%"
			local var_8_6 = var_8_2:getShips(false)[1]
			local var_8_7 = arg_8_2.viewComponent

			var_11.doPlayStrikeAnim(var_8_7, var_8_6, var_8_6:GetMapStrikeAnim(), function()
				local var_10_0 = arg_8_2.viewComponent

				var_0.strikeEnemy(var_10_0, arg_8_0.target, var_8_5, arg_8_3)

				return
			end)
		elseif #arg_8_0.movePath > 0 then
			local var_8_8 = arg_8_2.viewComponent.grid

			var_5.moveSub(var_8_8, var_4, arg_8_0.movePath, nil, arg_8_3)
		else
			arg_8_3()
		end
	end

	return
end

return var_0_0
