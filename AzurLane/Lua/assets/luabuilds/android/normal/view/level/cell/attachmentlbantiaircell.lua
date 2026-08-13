class = var_0_10000

local var_0_0 = "AttachmentLBAntiAirCell"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.level.cell.StaticCellView"))

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	IsNil = var_1_10002

	local var_2_1

	if var_1_10002(arg_2_0.go) then
		var_2_1 = arg_2_0

		arg_2_0.PrepareBase(var_2_1, "antiAir")

		pg = var_2

		local var_2_2 = var_2.land_based_template[var_2_0.attachmentId]

		assert = var_2_1

		var_2_1(var_2_2, "land_based_template not exist: " .. var_2_0.attachmentId)

		local var_2_3 = arg_2_0:GetLoader()

		var_2_1.GetPrefab(var_2_3, "leveluiview/Tpl_AntiAirGun", "Tpl_AntiAirGun", function(arg_3_0)
			setParent = var_2_10001

			var_2_10001(arg_3_0, arg_2_0.tf)

			tf = var_2_10001

			local var_3_0 = var_2_10001(arg_3_0)

			Vector3 = var_2
			var_3_0.anchoredPosition3D = var_2(0, 10, 0)
			arg_2_0.antiAirGun = arg_3_0

			local var_3_1 = arg_2_0

			var_1.Update(var_3_1)

			return
		end)

		local var_2_4 = arg_2_0:GetLoader()

		var_2_1.GetPrefab(var_2_4, "leveluiview/Tpl_AntiAirGunArea", "Tpl_AntiAirGunArea", function(arg_4_0)
			setParent = var_2_10001

			var_2_10001(arg_4_0, arg_2_0.grid.restrictMap)

			arg_4_0.name = "chapter_cell_mark_" .. var_2_0.row .. "_" .. var_2_0.column .. "#AntiAirGunArea"

			local var_4_0 = arg_2_0.chapter.theme
			local var_4_1 = var_1.GetLinePosition(var_4_0, arg_2_0.line.row, arg_2_0.line.column)
			local var_4_2 = arg_2_0.grid.restrictMap.anchoredPosition

			tf = var_4

			local var_4_3 = var_4(arg_4_0)

			Vector2 = var_5
			var_4_3.anchoredPosition = var_5(var_4_1.x - var_4_2.x, var_4_1.y - var_4_2.y)

			local var_4_4 = (var_2_2.function_args[1] * 2 + 1) * var_1.cellSize.x + var_4 * 2 * var_1.cellSpace.x
			local var_4_5 = (var_4 * 2 + 1) * var_1.cellSize.y + var_4 * 2 * var_1.cellSpace.y

			tf = var_7

			local var_4_6 = var_7(arg_4_0)

			Vector2 = var_8
			var_4_6.sizeDelta = var_8(var_4_4, var_4_5)

			return
		end)
	end

	local var_2_5

	if arg_2_0.antiAirGun then
		var_2_5 = var_2_0.flag
		ChapterConst = var_2_1

		if var_2_5 ~= var_2_1.CellFlagDisabled then
			math = var_2_5
			var_2_5 = var_2_5.ceil(var_2_0.data / 2)
			pg = var_3

			local var_2_6 = var_3.land_based_template[var_2_0.attachmentId]

			assert = var_4

			var_4(var_2_6, "land_based_template not exist: " .. var_2_0.attachmentId)

			local var_2_7 = var_2_6.function_args[2]
			local var_2_8 = arg_2_0.chapter

			var_1_10005 = var_1_10005.getRoundNum(var_2_8)
			tf = var_2_8

			local var_2_9 = var_2_8(arg_2_0.antiAirGun)
			local var_2_10 = var_6.Find(var_2_9, "text")

			setActive = var_2_9

			var_2_9(var_2_10, var_1_10005 < var_2_5)

			tf = var_2_9

			local var_2_11 = var_2_9(arg_2_0.antiAirGun)
			local var_2_12 = var_7.Find(var_2_11, "Slider")
			local var_2_13 = var_7.GetComponent

			typeof = var_9
			Slider = var_1_10010

			local var_2_14 = var_2_13(var_2_12, var_9(var_1_10010))

			math = var_2_12
			var_2_14.value = var_2_12.max(var_1_10005 - var_2_5 + var_2_7, 0) / var_2_7
		end
	end

	setActive = var_2_5

	local var_2_15 = arg_2_0.tf
	local var_2_16 = var_2_0.flag

	ChapterConst = var_1_10005

	var_2_5(var_2_15, var_2_16 ~= var_1_10005.CellFlagDisabled)

	return
end

return var_0_1
