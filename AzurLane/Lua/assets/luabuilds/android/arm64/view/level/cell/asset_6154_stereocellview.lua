class = var_0_10000

local var_0_0 = "StereoCellView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.LevelCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.assetName = nil
	arg_1_0.line = {
		row = arg_1_1,
		column = arg_1_2
	}
	FuncBuffer = var_3
	arg_1_0.buffer = var_3.New()

	return
end

function var_0_1.UpdateGO(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:GetLoader()

	if var_3.GetRequestPackage(var_2_0, "main") and var_3.name == arg_2_0.assetName then
		return
	end

	local var_2_1 = arg_2_0.buffer

	var_4.Clear(var_2_1)

	local var_2_2 = arg_2_0.buffer

	var_4.SetNotifier(var_2_2, nil)

	local var_2_3 = arg_2_0:GetLoader()

	var_4.GetPrefab(var_2_3, arg_2_1, arg_2_2, function(arg_3_0)
		arg_2_0.go = arg_3_0
		arg_2_0.tf = arg_2_0.go.transform

		local var_3_0 = arg_2_0

		var_1.OnLoaded(var_3_0, arg_3_0)

		local var_3_1 = arg_2_0.buffer

		var_1.SetNotifier(var_3_1, arg_2_0)

		local var_3_2 = arg_2_0.buffer

		var_1.ExcuteAll(var_3_2)

		local var_3_3 = arg_2_0

		var_1.OverrideCanvas(var_3_3)

		local var_3_4 = arg_2_0

		var_1.ResetCanvasOrder(var_3_4)

		return
	end, "main")

	return
end

function var_0_1.OnLoaded(arg_4_0, arg_4_1)
	return
end

return var_0_1
