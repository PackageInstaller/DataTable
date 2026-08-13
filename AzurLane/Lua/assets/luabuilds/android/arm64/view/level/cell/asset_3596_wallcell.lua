class = var_0_10000

local var_0_0 = "WallCell"

StereoCellView = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.direction = arg_1_3
	arg_1_0.anchor = arg_1_4
	arg_1_0.BanCount = 0
	arg_1_0.WallPrefabs = nil
	arg_1_0.girdParent = nil

	return
end

function var_0_1.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityFleet
end

function var_0_1.OverrideCanvas(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.ViewUtils.SetLayer

	tf = var_1_10003

	local var_3_1 = var_1_10003(arg_3_0.go)

	Layer = var_1_10004

	var_3_0(var_3_1, var_1_10004.UI)

	return
end

function var_0_1.ResetCanvasOrder(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.ViewUtils.SetSortingOrder
	local var_4_1 = arg_4_0.tf

	math = var_1_10004

	local var_4_2 = var_1_10004.floor(arg_4_0.line.row * 0.5)

	ChapterConst = var_1_10005

	var_4_0(var_4_1, var_4_2 * var_1_10005.PriorityPerRow + arg_4_0:GetOrder())

	return
end

function var_0_1.RefreshDirection(arg_5_0)
	setParent = var_1_10001

	var_1_10001(arg_5_0.tf, arg_5_0.girdParent.cellRoot)

	local var_5_0 = arg_5_0.tf

	Quaternion = var_1_10002
	var_5_0.localRotation = var_1_10002.Euler(arg_5_0.direction and 0.1 or -90, 90, -90)
	arg_5_0.tf.anchoredPosition3D = arg_5_0.anchor

	return
end

function var_0_1.SetAsset(arg_6_0, arg_6_1)
	if not arg_6_1 or #arg_6_1 == 0 then
		return
	end

	arg_6_0.assetName = arg_6_1

	arg_6_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_7_0)
	arg_7_0:UpdateGO("effect/" .. arg_7_0.assetName, arg_7_0.assetName)

	local var_7_0 = arg_7_0.buffer

	var_1.RefreshDirection(var_7_0)

	return
end

return var_0_1
