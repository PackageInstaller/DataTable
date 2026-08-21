local var_0_0 = class("WSMapItem", import("...BaseEntity"))

var_0_0.Fields = {
	cell = "table",
	theme = "table",
	rtArtifacts = "userdata",
	transform = "userdata"
}

function var_0_0.GetResName()
	return "world_cell_item"
end

function var_0_0.GetName(arg_2_0, arg_2_1)
	return "item_" .. arg_2_0 .. "_" .. arg_2_1
end

function var_0_0.Setup(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.cell = arg_3_1
	arg_3_0.theme = arg_3_2

	arg_3_0:Init()

	return
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:Clear()

	return
end

function var_0_0.Init(arg_5_0)
	arg_5_0.transform.name = var_0_0.GetName(arg_5_0.cell.row, arg_5_0.cell.column)
	arg_5_0.transform.anchoredPosition = arg_5_0.theme:GetLinePosition(arg_5_0.cell.row, arg_5_0.cell.column)
	arg_5_0.transform.sizeDelta = arg_5_0.theme.cellSize
	arg_5_0.rtArtifacts = arg_5_0.transform:Find("artifacts")
	arg_5_0.rtArtifacts.localEulerAngles = Vector3(-arg_5_0.theme.angle, 0, 0)

	return
end

return var_0_0
