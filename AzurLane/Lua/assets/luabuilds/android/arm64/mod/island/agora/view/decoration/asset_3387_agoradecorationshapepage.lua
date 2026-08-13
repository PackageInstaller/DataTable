class = var_0_10000

local var_0_0 = var_0_10000("AgoraDecorationShapePage")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.tr = arg_1_1
	arg_1_0.parentTr = arg_1_1.parent

	local var_1_0 = {}

	IslandConst = var_1_10003

	local var_1_1 = var_1_10003.AGORA_TILE_SHAPE_ALL
	local var_1_2 = arg_1_0.tr

	var_1_0[var_1_1] = var_4.Find(var_1_2, "bg/list/1")
	IslandConst = var_1_1

	local var_1_3 = var_1_1.AGORA_TILE_SHAPE_FAN
	local var_1_4 = arg_1_0.tr

	var_1_0[var_1_3] = var_4.Find(var_1_4, "bg/list/2")
	IslandConst = var_1_3

	local var_1_5 = var_1_3.AGORA_TILE_SHAPE_TRIANGLE
	local var_1_6 = arg_1_0.tr

	var_1_0[var_1_5] = var_4.Find(var_1_6, "bg/list/3")
	IslandConst = var_1_5

	local var_1_7 = var_1_5.AGORA_TILE_SHAPE_ARC
	local var_1_8 = arg_1_0.tr

	var_1_0[var_1_7] = var_4.Find(var_1_8, "bg/list/4")
	arg_1_0.shapes = var_1_0

	arg_1_0:InitShapes()

	arg_1_0.bgTr = arg_1_1:Find("bg")
	arg_1_0.localPosition = arg_1_0.bgTr.localPosition

	return
end

function var_0_0.InitShapes(arg_2_0)
	pairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0.shapes) do
		onButton = var_1_10006

		local var_2_0 = arg_2_0
		local var_2_1 = iter_2_1

		local function var_2_2()
			if arg_2_0.callback then
				arg_2_0.callback(iter_2_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_2_0, var_2_1, var_2_2, var_1_10011)
	end

	return
end

function var_0_0.Show(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.callback = arg_4_2

	local var_4_0 = arg_4_1._go.transform
	local var_4_1 = var_3.GetSiblingIndex(var_4_0) + 1

	setParent = var_1_10004

	var_1_10004(arg_4_0.tr, arg_4_1._go.transform.parent)

	local var_4_2 = arg_4_0.tr

	var_4.SetSiblingIndex(var_4_2, var_4_1)

	setActive = var_4

	var_4(arg_4_0.tr, true)
	arg_4_0:AdjustPosition(arg_4_1._go.transform.parent)

	return
end

function var_0_0.AdjustPosition(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.GetComponent

	typeof = var_1_10005
	HorizontalLayoutGroup = var_1_10007

	local var_5_2 = var_5_1(var_5_0, var_1_10005(var_1_10007)).spacing
	local var_5_3 = arg_5_0.bgTr
	local var_5_4 = arg_5_0.localPosition

	Vector3 = var_1_10006
	var_5_3.localPosition = var_5_4 - var_1_10006(var_5_2, 0, 0)

	return
end

function var_0_0.Hide(arg_6_0)
	arg_6_0.callback = nil
	setParent = var_1

	var_1(arg_6_0.tr, arg_6_0.parentTr)

	setActive = var_1

	var_1(arg_6_0.tr, false)

	return
end

function var_0_0.Destroy(arg_7_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_7_0)

	return
end

return var_0_0
