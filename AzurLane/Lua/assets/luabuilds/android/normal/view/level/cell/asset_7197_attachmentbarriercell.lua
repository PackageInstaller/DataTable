class = var_0_10000

local var_0_0 = "AttachmentBarrierCell"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.level.cell.StaticCellView"))

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	IsNil = var_1_10002

	if var_1_10002(arg_2_0.go) then
		arg_2_0:PrepareBase("zulanwangheng")

		local var_2_1 = arg_2_0:GetLoader()

		var_2.GetPrefab(var_2_1, "chapter/zulanwangheng", "zulanwangheng", function(arg_3_0)
			setParent = var_2_10001

			var_2_10001(arg_3_0, arg_2_0.tf)

			setActive = var_2_10001

			var_2_10001(arg_3_0, true)

			arg_2_0.barrier = arg_3_0

			local var_3_0 = arg_2_0

			var_1.Update(var_3_0)

			return
		end)
	end

	setActive = var_2

	local var_2_2 = arg_2_0.tf
	local var_2_3 = var_2_0.flag

	ChapterConst = var_1_10005

	var_2(var_2_2, var_2_3 == var_1_10005.CellFlagActive)

	return
end

return var_0_1
