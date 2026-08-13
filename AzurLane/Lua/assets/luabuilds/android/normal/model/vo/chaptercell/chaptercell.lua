class = var_0_10000

local var_0_0 = "ChapterCell"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".LevelCellData"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.walkable = true
	ChapterConst = var_2
	arg_1_0.forbiddenDirections = var_2.ForbiddenNone
	arg_1_0.row = arg_1_1.pos.row
	arg_1_0.column = arg_1_1.pos.column
	arg_1_0.attachment = arg_1_1.item_type
	arg_1_0.attachmentId = arg_1_1.item_id
	arg_1_0.flag = arg_1_1.item_flag
	arg_1_0.data = arg_1_1.item_data
	ChapterConst = var_2
	arg_1_0.trait = var_2.TraitNone
	arg_1_0.item = nil
	arg_1_0.itemOffset = nil
	arg_1_0.flagList = {}

	if arg_1_1.flag_list then
		ipairs = var_2

		for iter_1_0, iter_1_1 in var_2(arg_1_1.flag_list) do
			table = var_1_10007

			var_1_10007.insert(arg_1_0.flagList, iter_1_1)
		end
	end

	return
end

function var_0_1.updateFlagList(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0.flagList then
		var_2_0 = {}
	end

	arg_2_0.flagList = var_2_0
	table = var_2_0

	var_2_0.clear(arg_2_0.flagList)

	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.flag_list) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.flagList, iter_2_1)
	end

	return
end

function var_0_1.GetFlagList(arg_3_0)
	return arg_3_0.flagList
end

function var_0_1.GetWeatherFlagList(arg_4_0)
	underscore = var_1_10001

	local var_4_0 = var_1_10001.filter(arg_4_0:GetFlagList(), function(arg_5_0)
		tobool = var_2_10001
		pg = var_2_10002

		return var_2_10001(var_2_10002.weather_data_template[arg_5_0])
	end)

	if not arg_4_0:IsVisible() then
		table = var_2

		local var_4_1 = var_2.insert
		local var_4_2 = var_4_0

		ChapterConst = var_1_10004

		var_4_1(var_4_2, var_1_10004.FlagWeatherFogVisible)
	end

	return var_4_0
end

function var_0_1.checkHadFlag(arg_6_0, arg_6_1)
	table = var_1_10002

	return var_1_10002.contains(arg_6_0.flagList, arg_6_1)
end

function var_0_1.Line2Name(arg_7_0, arg_7_1)
	return "chapter_cell_" .. arg_7_0 .. "_" .. arg_7_1
end

function var_0_1.Line2QuadName(arg_8_0, arg_8_1)
	return "chapter_cell_quad_" .. arg_8_0 .. "_" .. arg_8_1
end

function var_0_1.Line2MarkName(arg_9_0, arg_9_1, arg_9_2)
	return "chapter_cell_mark_" .. arg_9_0 .. "_" .. arg_9_1 .. "#" .. arg_9_2
end

function var_0_1.MinMaxLine2QuadName(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return "chapter_cell_quad_" .. arg_10_0 .. "_" .. arg_10_1 .. "_" .. arg_10_2 .. "_" .. arg_10_3
end

function var_0_1.Line2RivalName(arg_11_0, arg_11_1, arg_11_2)
	return "rival_" .. arg_11_1 .. "_" .. arg_11_2
end

function var_0_1.LineAround(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0 = -arg_12_2, arg_12_2 do
		for iter_12_1 = -arg_12_2, arg_12_2 do
			math = var_1_10012
			var_1_10012 = var_1_10012.abs(iter_12_0)
			math = var_13

			if var_1_10012 + var_13.abs(iter_12_1) <= arg_12_2 then
				table = var_1_10012

				var_1_10012.insert(var_12_0, {
					row = arg_12_0 + iter_12_0,
					column = arg_12_1 + iter_12_1
				})
			end
		end
	end

	return var_12_0
end

function var_0_1.SetWalkable(arg_13_0, arg_13_1)
	tobool = var_1_10002
	arg_13_0.walkable = var_1_10002(arg_13_1)
	type = var_2

	if var_2(arg_13_1) == "boolean" then
		if arg_13_1 then
			ChapterConst = var_13_0

			local var_13_0

			if not var_13_0.ForbiddenNone then
				ChapterConst = var_13_0
				var_13_0 = var_13_0.ForbiddenAll
			end

			arg_13_0.forbiddenDirections = var_13_0

			if false then
				type = var_13_0

				if var_13_0(arg_13_1) == "number" then
					bit = var_2

					local var_13_1 = var_2.band
					local var_13_2 = arg_13_1

					ChapterConst = var_1_10004
					arg_13_0.forbiddenDirections = var_13_1(var_13_2, var_1_10004.ForbiddenAll)
				end
			end

			return
		end
	end
end

function var_0_1.IsWalkable(arg_14_0)
	return arg_14_0.walkable
end

function var_0_1.InitVisible(arg_15_0)
	arg_15_0.visible = {}

	return
end

function var_0_1.UpdateVisible(arg_16_0, arg_16_1, arg_16_2)
	table = var_1_10003

	local var_16_0 = var_1_10003.contains(arg_16_0.visible, arg_16_1)

	assert = var_4

	local var_16_1

	if arg_16_0.visible then
		var_16_1 = not arg_16_2 == var_16_0
	end

	var_4(var_16_1)

	if arg_16_2 then
		table = var_4

		var_4.insert(arg_16_0.visible, arg_16_1)
	else
		table = var_4

		var_4.removebyvalue(arg_16_0.visible, arg_16_1)
	end

	return
end

function var_0_1.IsVisible(arg_17_0)
	if arg_17_0.visible then
		return #arg_17_0.visible > 0
	else
		return true
	end

	return
end

return var_0_1
