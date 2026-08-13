class = var_0_10000

local var_0_0 = var_0_10000("ShipLoad")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.meshImageList = {}
	arg_1_0.meshCallback = arg_1_1
	arg_1_0.l2dCallback = arg_1_2
	arg_1_0.spineCallback = arg_1_3

	return
end

function var_0_0.LoadShip(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1, var_2_2 = arg_2_0:GetShipPaintingName(arg_2_1)

	if arg_2_0.spineCallback then
		MainPaintingView = var_7

		if var_7.Live2dIsDownload(var_2_1) then
			checkABExist = var_7

			if var_7(var_2_1) then
				if arg_2_0.live2dClass then
					local var_2_3 = arg_2_0.live2dClass

					var_7.Dispose(var_2_3)

					arg_2_0.live2dClass = nil
				end

				Live2DPainting = var_7

				local var_2_4 = var_7.GenerateData(arg_2_2)

				Live2DPainting = var_1_10008
				arg_2_0.live2dClass = var_1_10008.New(var_2_4, function(arg_3_0)
					if arg_2_0.exit == true then
						return
					end

					arg_2_0.l2dCallback(arg_3_0)

					return
				end)

				goto label_2_0
			end
		end
	end

	if arg_2_0.l2dCallback then
		checkABExist = var_7

		if var_7(var_2_2) then
			if arg_2_0.spinePaintingClass then
				local var_2_5 = arg_2_0.spinePaintingClass

				var_7.Dispose(var_2_5)

				arg_2_0.spinePaintingClass = nil
			end

			SpinePainting = var_7

			local var_2_6 = var_7.GenerateData(arg_2_3)

			SpinePainting = var_1_10008
			arg_2_0.spinePaintingClass = var_1_10008.New(var_2_6, function(arg_4_0)
				local var_4_0 = arg_2_0.exit

				ture = var_2_10002

				if var_4_0 == var_2_10002 then
					return
				end

				arg_2_0.spineCallback(arg_4_0)

				return
			end)

			goto label_2_0
		end
	end

	arg_2_0:LoadMeshShip(arg_2_1, arg_2_0.meshCallback)

	::label_2_0::

	return
end

function var_0_0.LoadMeshShip(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetShipPaintingName(arg_5_1)

	PoolMgr = var_1_10004

	local var_5_1 = var_1_10004:GetInstance()

	var_4.GetPainting(var_5_1, var_5_0, true, function(arg_6_0)
		if arg_5_0.exit then
			local var_6_0 = arg_5_0

			var_1.ReturnPainting(var_6_0, arg_5_1)

			return
		end

		arg_5_0.meshImageList[var_5_0] = arg_6_0

		arg_5_2(arg_6_0)

		return
	end)

	return
end

function var_0_0.ReturnPainting(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetShipPaintingName(arg_7_1)

	PoolMgr = var_1_10003

	local var_7_1 = var_1_10003.GetInstance()

	var_3.ReturnPainting(var_7_1, arg_7_0.paintingName, arg_7_0.actorPainting)

	return
end

function var_0_0.GetLive2dClass(arg_8_0)
	return arg_8_0.live2dClass
end

function var_0_0.GetSpinePaintingClass(arg_9_0)
	return arg_9_0.spinePaintingClass
end

function var_0_0.GetShipPaintingName(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_10_0 = var_1_10002(var_1_10004)
	local var_10_1 = var_2.getShipById(var_10_0, arg_10_1)
	local var_10_2 = var_2.getPainting(var_10_1)

	if arg_10_0:IsHideMeshBg(var_10_2) then
		string = var_5
		var_10_2 = var_5.format("%s_n", var_3)
	end

	HXSet = var_5

	local var_10_3 = var_5.autoHxShiftPath(var_10_2)

	HXSet = var_5

	local var_10_4 = var_5.autoHxShiftPath

	string = var_7

	local var_10_5 = var_10_4(var_7.format("spinepainting/%s", var_10_3))

	HXSet = var_1_10006

	local var_10_6 = var_1_10006.autoHxShiftPath

	string = var_8

	local var_10_7 = var_10_6(var_8.format("live2d/%s", var_10_3))

	return var_10_3, var_10_7, var_10_5
end

function var_0_0.IsHideMeshBg(arg_11_0, arg_11_1)
	checkABExist = var_1_10002
	string = var_1_10004

	local var_11_0

	if var_1_10002(var_1_10004.format("painting/%s_n", arg_11_1)) then
		PlayerPrefs = var_11_0
		var_11_0 = var_11_0.GetInt
		string = var_4
		var_11_0 = var_11_0(var_4.format("paint_hide_other_obj_%s", arg_11_1), 0) ~= 0
	end

	return var_11_0
end

function var_0_0.ClearShip(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.meshImageList) do
		PoolMgr = var_1_10006

		local var_12_0 = var_1_10006.GetInstance()

		var_1_10006.ReturnPainting(var_12_0, iter_12_0, iter_12_1)
	end

	arg_12_0.meshImageList = {}

	if arg_12_0.live2dClass then
		local var_12_1 = arg_12_0.live2dClass

		var_1.Dispose(var_12_1)

		arg_12_0.live2dClass = nil
	end

	if arg_12_0.spinePaintingClass then
		local var_12_2 = arg_12_0.spinePaintingClass

		var_1.Dispose(var_12_2)

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
