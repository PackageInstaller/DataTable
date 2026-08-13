class = var_0_10000

local var_0_0 = "ShipRotateLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ShipRotateUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_1

	if not arg_3_0.skin or not arg_3_0.skin.id then
		local var_3_0 = arg_3_0.shipGroup

		var_3_1 = var_1.GetSkin(var_3_0, arg_3_0.showTrans).id
	end

	arg_3_0:SetPainting(var_3_1, arg_3_0.showTrans)

	local var_3_2 = arg_3_0.paintingView

	var_2.setBGCallback(var_3_2, function()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end)

	local var_3_3 = arg_3_0.paintingView

	var_2.Start(var_3_3)

	setActive = var_2

	local var_3_4 = arg_3_0._tf

	var_2(var_3.Find(var_3_4, "Enc"), true)

	return
end

function var_0_1.willExit(arg_5_0)
	local var_5_0 = arg_5_0.paintingView

	var_1.Dispose(var_5_0)
	arg_5_0:RecyclePainting()

	return
end

function var_0_1.initData(arg_6_0)
	arg_6_0.paintingName = nil
	arg_6_0.shipGroup = arg_6_0.contextData.shipGroup
	arg_6_0.showTrans = arg_6_0.contextData.showTrans
	arg_6_0.skin = arg_6_0.contextData.skin

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.painting = var_1.Find(var_7_0, "paint")
	findTF = var_1
	arg_7_0.paintingFitter = var_1(arg_7_0.painting, "fitter")
	arg_7_0.paintingInitPos = arg_7_0.painting.transform.localPosition
	ShipProfilePaintingView = var_1
	arg_7_0.paintingView = var_1.New(arg_7_0._tf, arg_7_0.painting, true)

	return
end

function var_0_1.SetPainting(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0

	arg_8_0.RecyclePainting(var_8_0)

	pg = var_3

	local var_8_1 = var_3.ship_skin_template[arg_8_1].painting

	setPaintingPrefabAsync = var_8_0

	var_8_0(arg_8_0.painting, var_8_1, "chuanwu")

	arg_8_0.paintingName = var_8_1

	local var_8_2 = arg_8_0.painting.localEulerAngles

	setLocalEulerAngles = var_5

	var_5(arg_8_0.painting, {
		z = 90,
		x = var_8_2.x,
		y = var_8_2.y
	})

	return
end

function var_0_1.RecyclePainting(arg_9_0)
	if arg_9_0.paintingName then
		retPaintingPrefab = var_1

		var_1(arg_9_0.painting, arg_9_0.paintingName)
	end

	return
end

return var_0_1
