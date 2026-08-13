class = var_0_10000

local var_0_0 = "AttachmentLBAntiAirCell"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.StaticCellView"))

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	IsNil = var_1_10002

	if var_1_10002(arg_2_0.go) then
		arg_2_0:PrepareBase("antiAir")

		pg = var_2

		local var_2_1 = var_2.land_based_template[var_2_0.attachmentId]

		assert = var_1_10003

		var_1_10003(var_2_1, "land_based_template not exist: " .. var_2_0.attachmentId)

		local var_2_2 = arg_2_0:GetLoader()

		var_1_10003.GetPrefab(var_2_2, "leveluiview/Tpl_AntiAirGun", "Tpl_AntiAirGun", function(arg_3_0)
			setParent = var_2_10001

			var_2_10001(arg_3_0, arg_2_0.tf)

			tf = var_2_10001

			local var_3_0 = var_2_10001(arg_3_0)

			Vector3 = var_2_10002
			var_3_0.anchoredPosition3D = var_2_10002(0, 10, 0)
			arg_2_0.antiAirGun = arg_3_0

			local var_3_1 = arg_2_0

			var_1.Update(var_3_1)

			return
		end)

		local var_2_3 = arg_2_0:GetLoader()

		var_1_10003.GetPrefab(var_2_3, "leveluiview/Tpl_AntiAirGunArea", "Tpl_AntiAirGunArea", function(arg_4_0)
			setParent = var_2_10001

			var_2_10001(arg_4_0, arg_2_0.grid.restrictMap)

			arg_4_0.name = "chapter_cell_mark_" .. var_2_0.row .. "_" .. var_2_0.column .. "#AntiAirGunArea"

			local var_4_0 = arg_2_0.chapter.theme
			local var_4_1 = var_1.GetLinePosition(var_4_0, arg_2_0.line.row, arg_2_0.line.column)
			local var_4_2 = arg_2_0.grid.restrictMap.anchoredPosition

			tf = var_4_0

			local var_4_3 = var_4_0(arg_4_0)

			Vector2 = var_5
			var_4_3.anchoredPosition = var_5(var_4_1.x - var_4_2.x, var_4_1.y - var_4_2.y)

			local var_4_4 = (var_2_1.function_args[1] * 2 + 1) * var_1.cellSize.x + var_4 * 2 * var_1.cellSpace.x
			local var_4_5 = (var_4 * 2 + 1) * var_1.cellSize.y + var_4 * 2 * var_1.cellSpace.y

			tf = var_7

			local var_4_6 = var_7(arg_4_0)

			Vector2 = var_8
			var_4_6.sizeDelta = var_8(var_4_4, var_4_5)

			return
		end)
	end

	local var_2_4

	if arg_2_0.antiAirGun then
		var_2_4 = var_2_0.flag
		ChapterConst = var_1_10003

		if var_2_4 ~= var_1_10003.CellFlagDisabled then
			math = var_2_4
			var_2_4 = var_2_4.ceil(var_2_0.data / 2)
			pg = var_3

			local var_2_5 = var_3.land_based_template[var_2_0.attachmentId]

			assert = var_4

			var_4(var_2_5, "land_based_template not exist: " .. var_2_0.attachmentId)

			local var_2_6 = var_2_5.function_args[2]
			local var_2_7 = arg_2_0.chapter
			local var_2_8 = var_5.getRoundNum(var_2_7)

			tf = var_1_10006

			local var_2_9 = var_1_10006(arg_2_0.antiAirGun)

			var_1_10006 = var_1_10006.Find(var_2_9, "text")
			setActive = var_2_7

			var_2_7(var_1_10006, var_2_8 < var_2_4)

			tf = var_2_7

			local var_2_10 = var_2_7(arg_2_0.antiAirGun)
			local var_2_11 = var_7.Find(var_2_10, "Slider")
			local var_2_12 = var_7.GetComponent

			typeof = var_10
			Slider = var_1_10012

			local var_2_13 = var_2_12(var_2_11, var_10(var_1_10012))

			math = var_2_9
			var_2_13.value = var_2_9.max(var_2_8 - var_2_4 + var_2_6, 0) / var_2_6
		end
	end

	setActive = var_2_4

	local var_2_14 = arg_2_0.tf
	local var_2_15 = var_2_0.flag

	ChapterConst = var_1_10006

	var_2_4(var_2_14, var_2_15 ~= var_1_10006.CellFlagDisabled)

	return
end

return var_0_1
