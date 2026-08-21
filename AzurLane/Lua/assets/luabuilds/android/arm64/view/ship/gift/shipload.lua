local var_0_0 = class("ShipLoad")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.meshImageList = {}
	arg_1_0.meshCallback = arg_1_1
	arg_1_0.l2dCallback = arg_1_2
	arg_1_0.spineCallback = arg_1_3

	return
end

function var_0_0.LoadShip(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1, var_2_2 = arg_2_0:GetShipPaintingName(arg_2_1)

	if arg_2_0.spineCallback and MainPaintingView.Live2dIsDownload(var_2_1) and checkABExist(var_2_1) then
		if arg_2_0.live2dClass then
			arg_2_0.live2dClass:Dispose()

			arg_2_0.live2dClass = nil
		end

		arg_2_0.live2dClass = Live2DPainting.New(Live2DPainting.GenerateData(arg_2_2), function(arg_3_0)
			if arg_2_0.exit == true then
				return
			end

			arg_2_0.l2dCallback(arg_3_0)

			return
		end)
	elseif arg_2_0.l2dCallback and checkABExist(var_2_2) then
		if arg_2_0.spinePaintingClass then
			arg_2_0.spinePaintingClass:Dispose()

			arg_2_0.spinePaintingClass = nil
		end

		arg_2_0.spinePaintingClass = SpinePainting.New(SpinePainting.GenerateData(arg_2_3), function(arg_4_0)
			if arg_2_0.exit == ture then
				return
			end

			arg_2_0.spineCallback(arg_4_0)

			return
		end)
	else
		arg_2_0:LoadMeshShip(arg_2_1, arg_2_0.meshCallback)
	end

	return
end

function var_0_0.LoadMeshShip(arg_5_0, arg_5_1, arg_5_2)
	PoolMgr:GetInstance():GetPainting(arg_5_0:GetShipPaintingName(arg_5_1), true, function(arg_6_0)
		if arg_5_0.exit then
			arg_5_0:ReturnPainting(arg_5_1)

			return
		end

		arg_5_0.meshImageList[var_0] = arg_6_0

		arg_5_2(arg_6_0)

		return
	end)

	return
end

function var_0_0.ReturnPainting(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetShipPaintingName(arg_7_1)

	PoolMgr.GetInstance():ReturnPainting(arg_7_0.paintingName, arg_7_0.actorPainting)

	return
end

function var_0_0.GetLive2dClass(arg_8_0)
	return arg_8_0.live2dClass
end

function var_0_0.GetSpinePaintingClass(arg_9_0)
	return arg_9_0.spinePaintingClass
end

function var_0_0.GetShipPaintingName(arg_10_0, arg_10_1)
	local var_10_0 = getProxy(BayProxy):getShipById(arg_10_1):getPainting()
	local var_10_1 = var_10_0

	if arg_10_0:IsHideMeshBg(var_10_0) then
		var_10_1 = string.format("%s_n", var_10_0)
	end

	local var_10_2 = HXSet.autoHxShiftPath(var_10_1)

	return var_10_2, HXSet.autoHxShiftPath(string.format("live2d/%s", var_10_2)), (HXSet.autoHxShiftPath(string.format("spinepainting/%s", var_10_2)))
end

function var_0_0.IsHideMeshBg(arg_11_0, arg_11_1)
	return checkABExist(string.format("painting/%s_n", arg_11_1)) and PlayerPrefs.GetInt(string.format("paint_hide_other_obj_%s", arg_11_1), 0) ~= 0
end

function var_0_0.ClearShip(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.meshImageList) do
		PoolMgr.GetInstance():ReturnPainting(iter_12_0, iter_12_1)
	end

	arg_12_0.meshImageList = {}

	if arg_12_0.live2dClass then
		arg_12_0.live2dClass:Dispose()

		arg_12_0.live2dClass = nil
	end

	if arg_12_0.spinePaintingClass then
		arg_12_0.spinePaintingClass:Dispose()

		arg_12_0.spinePaintingClass = nil
	end

	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.exit = true

	arg_13_0:ClearShip()

	return
end

return var_0_0
