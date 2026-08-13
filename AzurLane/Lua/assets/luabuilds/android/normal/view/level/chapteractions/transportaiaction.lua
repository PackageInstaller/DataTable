class = var_0_10000

local var_0_0 = var_0_10000("TransportAIAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.line = {
		row = arg_1_1.ai_pos.row,
		column = arg_1_1.ai_pos.column
	}
	_ = var_2
	arg_1_0.movePath = var_2.map(arg_1_1.move_path, function(arg_2_0)
		return {
			row = arg_2_0.row,
			column = arg_2_0.column
		}
	end)
	_ = var_2
	arg_1_0.hp = var_2.detect(arg_1_1.map_update, function(arg_3_0)
		local var_3_0 = arg_3_0.item_type

		ChapterConst = var_2_10002

		return var_3_0 == var_2_10002.AttachTransport
	end) and var_2.item_data

	return
end

function var_0_0.applyTo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getFleet

	FleetType = var_1_10005

	if var_4_1(var_4_0, var_1_10005.Transport, arg_4_0.line.row, arg_4_0.line.column) then
		return arg_4_0:applyToFleet(arg_4_1, var_3, arg_4_2)
	end

	return false, "can not find any transport at: [" .. arg_4_0.line.row .. ", " .. arg_4_0.line.column .. "]"
end

function var_0_0.applyToFleet(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 0

	if not arg_5_2:isValid() then
		return false, "fleet " .. arg_5_2.id .. " is invalid."
	end

	local var_5_1 = 0

	if #arg_5_0.movePath > 0 then
		_ = var_6

		if var_6.any(arg_5_0.movePath, function(arg_6_0)
			local var_6_0 = arg_5_1

			return not var_1.getChapterCell(var_6_0, arg_6_0.row, arg_6_0.column) or not var_1:IsWalkable()
		end) then
			return false, "invalide move path"
		end

		if not arg_5_3 then
			local var_5_2 = arg_5_0.movePath[#arg_5_0.movePath]

			arg_5_2.line = {
				row = var_5_2.row,
				column = var_5_2.column
			}
			bit = var_7

			local var_5_3 = var_7.bor
			local var_5_4 = var_5_1

			ChapterConst = var_1_10009

			local var_5_5 = var_1_10009.DirtyFleet

			ChapterConst = var_1_10010

			local var_5_6 = var_1_10010.DirtyAttachment

			ChapterConst = var_1_10011
			var_5_1 = var_5_3(var_5_4, var_5_5, var_5_6, var_1_10011.DirtyChampionPosition)
		end
	end

	if arg_5_0.hp and not arg_5_3 then
		arg_5_2:setRestHp(arg_5_0.hp)

		bit = var_6

		local var_5_7 = var_6.bor
		local var_5_8 = var_5_1

		ChapterConst = var_8
		var_5_1 = var_5_7(var_5_8, var_8.DirtyFleet)

		if arg_5_1:getChapterCell(arg_5_2.line.row, arg_5_2.line.column) then
			local var_5_9 = var_6.attachment

			ChapterConst = var_8

			if var_5_9 == var_8.AttachBox then
				local var_5_10 = var_6.flag

				ChapterConst = var_8

				if var_5_10 ~= var_8.CellFlagDisabled then
					pg = var_5_10

					local var_5_11 = var_5_10.box_data_template[var_6.attachmentId].type

					ChapterConst = var_9

					if var_5_11 == var_9.BoxTorpedo then
						ChapterConst = var_5_11
						var_6.flag = var_5_11.CellFlagDisabled

						arg_5_1:clearChapterCell(var_6.row, var_6.column)

						bit = var_8

						local var_5_12 = var_8.bor
						local var_5_13 = var_5_1

						ChapterConst = var_10
						var_5_1 = var_5_12(var_5_13, var_10.DirtyAttachment)
					end
				end
			end
		end
	end

	return true, var_5_1
end

function var_0_0.PlayAIAction(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getFleetIndex

	FleetType = var_1_10006

	if var_7_1(var_7_0, var_1_10006.Transport, arg_7_0.line.row, arg_7_0.line.column) then
		if #arg_7_0.movePath > 0 then
			local var_7_2 = arg_7_2.viewComponent.grid
			local var_7_3 = var_5.moveTransport
			local var_7_4 = var_4
			local var_7_5 = arg_7_0.movePath

			Clone = var_1_10009

			var_7_3(var_7_2, var_7_4, var_7_5, var_1_10009(arg_7_0.movePath), arg_7_3)
		else
			local var_7_6 = arg_7_1.fleets[var_4]

			if arg_7_1:getChapterCell(var_7_6.line.row, var_7_6.line.column) then
				local var_7_7 = var_6.attachment

				ChapterConst = var_8

				if var_7_7 == var_8.AttachBox then
					local var_7_8 = var_6.flag

					ChapterConst = var_8

					if var_7_8 ~= var_8.CellFlagDisabled then
						pg = var_7_8

						local var_7_9 = var_7_8.box_data_template[var_6.attachmentId].type

						ChapterConst = var_9

						if var_7_9 == var_9.BoxTorpedo then
							local var_7_10 = arg_7_2.viewComponent

							var_8.doPlayTorpedo(var_7_10, arg_7_3)

							return
						end
					end
				end
			end

			arg_7_3()
		end
	end

	return
end

return var_0_0
