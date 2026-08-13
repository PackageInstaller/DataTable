class = var_0_10000

local var_0_0 = "WSMapItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	cell = "table",
	theme = "table",
	rtArtifacts = "userdata",
	transform = "userdata"
}

function var_0_1.GetResName()
	return "world_cell_item"
end

function var_0_1.GetName(arg_2_0, arg_2_1)
	return "item_" .. arg_2_0 .. "_" .. arg_2_1
end

function var_0_1.Setup(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.cell = arg_3_1
	arg_3_0.theme = arg_3_2

	arg_3_0:Init()

	return
end

function var_0_1.Dispose(arg_4_0)
	arg_4_0:Clear()

	return
end

function var_0_1.Init(arg_5_0)
	local var_5_0 = arg_5_0.cell
	local var_5_1 = arg_5_0.transform

	var_5_1.name = var_0_1.GetName(var_5_0.row, var_5_0.column)

	local var_5_2 = arg_5_0.theme

	var_5_1.anchoredPosition = var_3.GetLinePosition(var_5_2, var_5_0.row, var_5_0.column)
	var_5_1.sizeDelta = arg_5_0.theme.cellSize

	local var_5_3 = var_5_1

	arg_5_0.rtArtifacts = var_5_1.Find(var_5_3, "artifacts")

	local var_5_4 = arg_5_0.rtArtifacts

	Vector3 = var_5_3
	var_5_4.localEulerAngles = var_5_3(-arg_5_0.theme.angle, 0, 0)

	return
end

return var_0_1
