class = var_0_10000

local var_0_0 = "CipherTestLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CipherTest"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.nextBtn = var_1.Find(var_2_0, "Next")

	local var_2_1 = arg_2_0._tf

	arg_2_0.gcBtn = var_1.Find(var_2_1, "GC")

	local var_2_2 = arg_2_0._tf

	arg_2_0.live2dContainer = var_1.Find(var_2_2, "Painting/Live2D")
	arg_2_0.l2dList = arg_2_0:GetL2DList()
	arg_2_0.curIndex = 0
	arg_2_0.live2dChar = nil
	arg_2_0.skinID = nil

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.nextBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.ClearL2dPainting(var_4_0)

		arg_3_0.curIndex = arg_3_0.curIndex + 1
		arg_3_0.curL2D = arg_3_0.l2dList[arg_3_0.curIndex]

		local var_4_1 = arg_3_0

		var_0.LoadL2dPainting(var_4_1, arg_3_0.curL2D)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.gcBtn

	local function var_3_5()
		gcAll = var_2_10000

		var_2_10000()

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.willExit(arg_6_0)
	return
end

function var_0_1.GetL2DList(arg_7_0)
	local var_7_0 = {}

	pg = var_1_10002

	local var_7_1 = var_1_10002.ship_skin_template.all

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(var_7_1) do
		ShipSkin = var_1_10008

		local var_7_2 = var_1_10008.New({
			id = iter_7_1
		})

		if var_1_10008.IsLive2d(var_7_2) then
			table = var_9

			var_9.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_1.LoadL2dPainting(arg_8_0, arg_8_1)
	pg = var_1_10002

	local var_8_0 = var_1_10002.ship_skin_template[arg_8_1].ship_group

	ShipGroup = var_1_10003

	local var_8_1 = var_1_10003.getDefaultShipConfig(var_8_0)

	Live2DPainting = var_4

	local var_8_2 = var_4.GenerateData
	local var_8_3 = {}

	Ship = var_1_10006
	var_8_3.ship = var_1_10006.New({
		id = 999,
		configId = var_8_1.id,
		skin_id = arg_8_1
	})
	Vector3 = var_6
	var_8_3.position = var_6(0, 0, -1)
	var_8_3.parent = arg_8_0.live2dContainer

	local var_8_4 = var_8_2(var_8_3)

	var_8_4.shopPreView = true
	pg = var_5

	local var_8_5 = var_5.UIMgr.GetInstance()

	var_5.LoadingOn(var_8_5)

	local var_8_6

	Live2DPainting = var_8_5
	var_8_6 = var_8_5.New(var_8_4, function(arg_9_0)
		arg_9_0:IgonreReactPos(true)

		local var_9_0 = arg_8_0

		var_1.ClearL2dPainting(var_9_0)

		pg = var_1

		local var_9_1 = var_1.UIMgr.GetInstance()

		var_1.LoadingOff(var_9_1)

		arg_8_0.live2dChar = var_8_6

		return
	end)

	return
end

function var_0_1.ClearL2dPainting(arg_10_0)
	if arg_10_0.live2dChar then
		local var_10_0 = arg_10_0.live2dChar

		var_1.Dispose(var_10_0)

		arg_10_0.live2dChar = nil
	end

	return
end

return var_0_1
