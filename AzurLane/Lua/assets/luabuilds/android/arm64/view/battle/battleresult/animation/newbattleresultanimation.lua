class = var_0_10000

local var_0_0 = var_0_10000("NewBattleResultAnimation")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10005
	Image = var_1_10007
	arg_1_0.bgImage = var_1_1(var_1_0, var_1_10005(var_1_10007))

	local var_1_2 = arg_1_0._tf

	arg_1_0.paintingTr = var_2.Find(var_1_2, "painting/painting")

	local var_1_3 = arg_1_0._tf

	arg_1_0.mask = var_2.Find(var_1_3, "mask")
	arg_1_0.items = {}
	Vector2 = var_2
	arg_1_0.paintingPosition = var_2(698, 0)
	Vector2 = var_2
	arg_1_0.paintingSizeDelta = var_2(625, 1080)

	arg_1_0:Start()

	return
end

function var_0_0.CollectionItems(arg_2_0, arg_2_1)
	eachChild = var_1_10002

	var_1_10002(arg_2_0._tf, function(arg_3_0)
		if arg_3_0 ~= arg_2_0.mask then
			table = var_1

			var_1.insert(arg_2_1, {
				position = arg_3_0.position,
				tr = arg_3_0
			})
		end

		return
	end)

	return
end

function var_0_0.Start(arg_4_0)
	if not arg_4_0.handle then
		UpdateBeat = var_1
		arg_4_0.handle = var_1:CreateListener(arg_4_0.Update, arg_4_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_4_0.handle)

	return
end

function var_0_0.Play(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.setUp = true
	setActive = var_3

	var_3(arg_5_0.mask, true)
	arg_5_0:CollectionItems(arg_5_0.items)
	arg_5_0:MaskItems()

	parallelAsync = var_3

	var_3({
		function(arg_6_0)
			local var_6_0 = arg_5_0

			var_1.ZoomMask(var_6_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			if not arg_5_1 then
				return arg_7_0()
			end

			local var_7_0 = arg_5_0

			var_1.ZoomPainting(var_7_0, arg_5_1, arg_7_0)

			return
		end
	}, function()
		arg_5_0.setUp = false

		local var_8_0 = arg_5_0

		var_0.RevertItems(var_8_0)

		setActive = var_0

		var_0(arg_5_0.mask, false)

		local var_8_1 = arg_5_0

		var_0.Clear(var_8_1)
		arg_5_2()

		return
	end)

	return
end

function var_0_0.ZoomPainting(arg_9_0, arg_9_1, arg_9_2)
	local function var_9_0()
		if arg_9_0.exited then
			return
		end

		local var_10_0 = arg_9_0.paintingTr
		local var_10_1 = var_0.Find(var_10_0, "fitter")
		local var_10_2 = var_0.GetComponent

		typeof = var_2_10004
		PaintingScaler = var_2_10006
		var_10_2(var_10_1, var_2_10004(var_2_10006)).enabled = false

		local var_10_3 = arg_9_1.position
		local var_10_4 = arg_9_1.scale
		local var_10_5 = arg_9_1.pivot
		local var_10_6 = var_0:GetChild(0)
		local var_10_7 = arg_9_0

		var_6.SetPivot(var_10_7, var_10_6, var_10_5)

		LeanTween = var_6

		local var_10_8 = var_6.value
		local var_10_9 = var_10_6.gameObject

		Vector2 = var_9

		local var_10_10 = var_10_8(var_10_9, var_9(var_10_6.position.x, var_10_6.position.y), var_10_3, 0.2)
		local var_10_11 = var_6.setOnUpdate

		System = var_9

		var_10_11(var_10_10, var_9.Action_UnityEngine_Vector2(function(arg_11_0)
			local var_11_0 = var_10_6

			Vector3 = var_3_10002
			var_11_0.position = var_3_10002(arg_11_0.x, arg_11_0.y, 0)

			local var_11_1 = var_10_6

			Vector3 = var_2
			var_11_1.localPosition = var_2(var_10_6.localPosition.x, var_10_6.localPosition.y, 0)

			return
		end))

		LeanTween = var_10_11

		local var_10_12 = var_10_11.value
		local var_10_13 = var_10_6.gameObject

		Vector2 = var_9

		local var_10_14 = var_10_12(var_10_13, var_9(var_10_6.localScale.x, var_10_6.localScale.y), var_10_4, 0.2)
		local var_10_15 = var_6.setOnUpdate

		System = var_9

		local var_10_16 = var_10_15(var_10_14, var_9.Action_UnityEngine_Vector2(function(arg_12_0)
			local var_12_0 = var_10_6

			Vector3 = var_3_10002
			var_12_0.localScale = var_3_10002(arg_12_0.x, arg_12_0.y, 1)

			return
		end))
		local var_10_17 = var_6.setOnComplete

		System = var_9

		var_10_17(var_10_16, var_9.Action(arg_9_2))

		return
	end

	onNextTick = var_1_10004

	var_1_10004(var_9_0)

	return
end

function var_0_0.SetPivot(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.rect.size
	local var_13_1 = arg_13_1.pivot - arg_13_2

	Vector3 = var_1_10005

	local var_13_2 = var_1_10005(var_13_1.x * var_13_0.x, var_13_1.y * var_13_0.y)

	arg_13_1.pivot = arg_13_2
	arg_13_1.localPosition = arg_13_1.localPosition - var_13_2

	return
end

local function var_0_1(arg_14_0, arg_14_1)
	return arg_14_0:InverseTransformPoint(arg_14_1)
end

function var_0_0.RevertItems(arg_15_0)
	for iter_15_0 = #arg_15_0.items, 1, -1 do
		local var_15_0 = arg_15_0.items[iter_15_0].tr
		local var_15_1 = var_5.position

		setParent = var_1_10008

		var_1_10008(var_15_0, arg_15_0._tf, true)

		var_15_0.localPosition = var_0_1(arg_15_0._tf, var_15_1)
	end

	return
end

function var_0_0.ZoomMask(arg_16_0, arg_16_1)
	LeanTween = var_1_10002

	local var_16_0 = var_1_10002.value
	local var_16_1 = arg_16_0.mask.gameObject

	Vector2 = var_1_10005

	local var_16_2 = var_1_10005(418, 936)

	Vector2 = var_1_10006

	local var_16_3 = var_16_0(var_16_1, var_16_2, var_1_10006(4180, 2000), 0.4)
	local var_16_4 = var_2.setOnUpdate

	System = var_16_2

	local var_16_5 = var_16_4(var_16_3, var_16_2.Action_UnityEngine_Vector2(function(arg_17_0)
		arg_16_0.mask.sizeDelta = arg_17_0

		return
	end))
	local var_16_6 = var_2.setOnComplete

	System = var_5

	var_16_6(var_16_5, var_5.Action(arg_16_1))

	return
end

function var_0_0.MaskItems(arg_18_0)
	for iter_18_0 = #arg_18_0.items, 1, -1 do
		local var_18_0 = arg_18_0.items[iter_18_0].tr

		setParent = var_1_10006

		var_1_10006(var_18_0, arg_18_0.mask, true)
	end

	return
end

function var_0_0.Update(arg_19_0)
	if arg_19_0.setUp then
		arg_19_0:SynItemsPosition()
	end

	return
end

function var_0_0.SynItemsPosition(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.items) do
		local var_20_0 = iter_20_1.tr
		local var_20_1 = iter_20_1.position

		var_20_0.localPosition = var_0_1(arg_20_0.mask, var_20_1)
	end

	return
end

function var_0_0.Clear(arg_21_0)
	if arg_21_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_21_0.handle)

		arg_21_0.handle = nil
	end

	LeanTween = var_1

	if var_1.isTweening(arg_21_0.mask.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_21_0.mask.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_21_0.paintingTr.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_21_0.paintingTr.gameObject)
	end

	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.exited = true

	arg_22_0:Clear()

	return
end

return var_0_0
