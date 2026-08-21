local var_0_0 = class("TransportAIAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.line = {
		row = arg_1_1.ai_pos.row,
		column = arg_1_1.ai_pos.column
	}
	arg_1_0.movePath = _.map(arg_1_1.move_path, function(arg_2_0)
		return {
			row = arg_2_0.row,
			column = arg_2_0.column
		}
	end)

	local var_1_0 = _.detect(arg_1_1.map_update, function(arg_3_0)
		return arg_3_0.item_type == ChapterConst.AttachTransport
	end)

	arg_1_0.hp = var_1_0 and var_1_0.item_data

	return
end

function var_0_0.applyTo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getFleet(FleetType.Transport, arg_4_0.line.row, arg_4_0.line.column)

	if var_4_0 then
		return arg_4_0:applyToFleet(arg_4_1, var_4_0, arg_4_2)
	end

	return false, "can not find any transport at: [" .. arg_4_0.line.row .. ", " .. arg_4_0.line.column .. "]"
end

function var_0_0.applyToFleet(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_2:isValid() then
		return false, "fleet " .. arg_5_2.id .. " is invalid."
	end

	local var_5_1 = 0

	if #arg_5_0.movePath > 0 then
		if _.any(arg_5_0.movePath, function(arg_6_0)
			local var_6_0 = arg_5_1:getChapterCell(arg_6_0.row, arg_6_0.column)

			return not var_6_0 or not var_6_0:IsWalkable()
		end) then
			return false, "invalide move path"
		end

		if not arg_5_3 then
			arg_5_2.line = {
				row = arg_5_0.movePath[#arg_5_0.movePath].row,
				column = arg_5_0.movePath[#arg_5_0.movePath].column
			}
			var_5_1 = bit.bor(var_5_1, ChapterConst.DirtyFleet, ChapterConst.DirtyAttachment, ChapterConst.DirtyChampionPosition)
		end
	end

	if arg_5_0.hp and not arg_5_3 then
		arg_5_2:setRestHp(arg_5_0.hp)

		var_5_1 = bit.bor(var_5_1, ChapterConst.DirtyFleet)

		local var_5_2 = arg_5_1:getChapterCell(arg_5_2.line.row, arg_5_2.line.column)

		if var_5_2 and var_5_2.attachment == ChapterConst.AttachBox and var_5_2.flag ~= ChapterConst.CellFlagDisabled and pg.box_data_template[var_5_2.attachmentId].type == ChapterConst.BoxTorpedo then
			var_5_2.flag = ChapterConst.CellFlagDisabled

			arg_5_1:clearChapterCell(var_5_2.row, var_5_2.column)

			var_5_1 = bit.bor(var_5_1, ChapterConst.DirtyAttachment)
		end
	end

	return true, var_5_1
end

function var_0_0.PlayAIAction(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1:getFleetIndex(FleetType.Transport, arg_7_0.line.row, arg_7_0.line.column)

	if var_7_0 then
		if #arg_7_0.movePath > 0 then
			arg_7_2.viewComponent.grid:moveTransport(var_7_0, arg_7_0.movePath, Clone(arg_7_0.movePath), arg_7_3)
		else
			local var_7_1 = arg_7_1:getChapterCell(arg_7_1.fleets[var_7_0].line.row, arg_7_1.fleets[var_7_0].line.column)

			if var_7_1 and var_7_1.attachment == ChapterConst.AttachBox and var_7_1.flag ~= ChapterConst.CellFlagDisabled and pg.box_data_template[var_7_1.attachmentId].type == ChapterConst.BoxTorpedo then
				arg_7_2.viewComponent:doPlayTorpedo(arg_7_3)

				return
			end

			arg_7_3()
		end
	end

	return
end

return var_0_0
