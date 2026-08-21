local var_0_0 = class("WallCell", StereoCellView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.direction = arg_1_3
	arg_1_0.anchor = arg_1_4
	arg_1_0.BanCount = 0
	arg_1_0.WallPrefabs = nil
	arg_1_0.girdParent = nil

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityFleet
end

function var_0_0.OverrideCanvas(arg_3_0)
	pg.ViewUtils.SetLayer(tf(arg_3_0.go), Layer.UI)

	return
end

function var_0_0.ResetCanvasOrder(arg_4_0)
	pg.ViewUtils.SetSortingOrder(arg_4_0.tf, math.floor(arg_4_0.line.row * 0.5) * ChapterConst.PriorityPerRow + arg_4_0:GetOrder())

	return
end

function var_0_0.RefreshDirection(arg_5_0)
	setParent(arg_5_0.tf, arg_5_0.girdParent.cellRoot)

	arg_5_0.tf.localRotation = Quaternion.Euler(arg_5_0.direction and 0.1 or -90, 90, -90)
	arg_5_0.tf.anchoredPosition3D = arg_5_0.anchor

	return
end

function var_0_0.SetAsset(arg_6_0, arg_6_1)
	if not arg_6_1 or #arg_6_1 == 0 then
		return
	end

	arg_6_0.assetName = arg_6_1

	arg_6_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0:UpdateGO("effect/" .. arg_7_0.assetName, arg_7_0.assetName)
	arg_7_0.buffer:RefreshDirection()

	return
end

return var_0_0
