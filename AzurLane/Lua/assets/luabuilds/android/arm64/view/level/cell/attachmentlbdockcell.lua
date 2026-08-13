class = var_0_10000

local var_0_0 = "AttachmentLBDockCell"

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
		arg_2_0:PrepareBase("dock")

		local var_2_1 = arg_2_0:GetLoader()

		var_2.GetPrefab(var_2_1, "leveluiview/Tpl_Dockyard", "Tpl_Dockyard", function(arg_3_0)
			setParent = var_2_10001

			var_2_10001(arg_3_0, arg_2_0.tf)

			tf = var_2_10001

			local var_3_0 = var_2_10001(arg_3_0)

			Vector3 = var_2_10002
			var_3_0.anchoredPosition3D = var_2_10002(0, 10, 0)

			local var_3_1 = arg_2_0

			tf = var_2
			var_3_1.dock = var_2(arg_3_0)

			local var_3_2 = arg_2_0

			var_1.Update(var_3_2)

			return
		end)
	end

	local var_2_2

	if arg_2_0.dock then
		pg = var_2_2
		var_2_2 = var_2_2.land_based_template[var_2_0.attachmentId]
		assert = var_3

		var_3(var_2_2, "land_based_template not exist: " .. var_2_0.attachmentId)

		local var_2_3 = arg_2_0.chapter
		local var_2_4 = var_3.getRoundNum(var_2_3)

		var_1_10006 = arg_2_0.dock

		local var_2_5 = var_4.Find(var_1_10006, "text")

		math = var_2_3

		local var_2_6 = var_2_3.ceil(var_2_0.data / 2)

		setActive = var_1_10006

		var_1_10006(var_2_5, var_2_4 < var_2_6)

		local var_2_7 = arg_2_0.dock
		local var_2_8 = var_1_10006.Find(var_2_7, "Slider")

		var_1_10006 = var_1_10006.GetComponent
		typeof = var_9
		Slider = var_1_10011
		var_1_10006 = var_1_10006(var_2_8, var_9(var_1_10011))

		local var_2_9 = var_2_2.function_args[2]

		math = var_2_8
		var_1_10006.value = var_2_8.max(var_2_4 - var_2_6 + var_2_9, 0) / var_2_9
	end

	setActive = var_2_2

	local var_2_10 = arg_2_0.tf
	local var_2_11 = var_2_0.flag

	ChapterConst = var_1_10006

	var_2_2(var_2_10, var_2_11 == var_1_10006.CellFlagActive)

	return
end

return var_0_1
