pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.TipsMgr = var_0_10001("TipsMgr")

local var_0_1 = var_0.TipsMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0._go = nil

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	print = var_1_10002

	var_1_10002("initializing tip manager...")

	arg_2_0._count = 0
	arg_2_0._tipTable = {}
	LoadAndInstantiateAsync = var_2

	var_2("ui", "TipPanel", function(arg_3_0)
		arg_2_0._go = arg_3_0

		local var_3_0 = arg_2_0._go

		var_1.SetActive(var_3_0, false)

		GameObject = var_1

		local var_3_1 = var_1.Find("Overlay/UIOverlay")
		local var_3_2 = arg_2_0._go.transform

		var_2.SetParent(var_3_2, var_3_1.transform, false)

		local var_3_3 = arg_2_0
		local var_3_4 = arg_2_0._go.transform

		var_3_3._tips = var_3.Find(var_3_4, "toolTip")

		local var_3_5 = arg_2_0
		local var_3_6 = arg_2_0._go.transform

		var_3_5._picTips = var_3.Find(var_3_6, "toolPicTip")

		local var_3_7 = arg_2_0
		local var_3_8 = arg_2_0._go.transform

		var_3_7._grid = var_3.Find(var_3_8, "Grid")

		arg_2_1()

		return
	end, true)

	return
end

function var_0_1.ShowTips(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = var_0.CriMgr.GetInstance()
	local var_4_1 = var_4.PlaySoundEffect_V3

	if not arg_4_3 then
		::label_4_0::

		SFX_UI_TIP = var_1_10007
	end

	var_4_1(var_4_0, var_1_10007)

	local var_4_2 = arg_4_0._go.transform

	var_4.SetAsLastSibling(var_4_2)

	SetActive = var_4

	var_4(arg_4_0._go, true)

	arg_4_0._count = arg_4_0._count + 1
	cloneTplTo = var_4

	local var_4_3 = var_4(arg_4_0._tips, arg_4_0._grid)
	local var_4_4 = arg_4_2 or "white"

	setText = var_6

	local var_4_5 = var_4_3.transform

	var_6(var_8.Find(var_4_5, "Text"), "<color=" .. var_4_4 .. ">" .. arg_4_1 .. "</color>")

	local var_4_6 = var_4_3.transform

	Vector3 = var_7
	var_4_6.localScale = var_7(0, 0.1, 1)
	LeanTween = var_4_6

	local var_4_7 = var_4_6.scale
	local var_4_8 = var_4_3

	Vector3 = var_9

	local var_4_9 = var_4_7(var_4_8, var_9(1.8, 0.1, 1), 0.1)

	var_6.setUseEstimatedTime(var_4_9, true)

	LeanTween = var_6

	local var_4_10 = var_6.scale
	local var_4_11 = var_4_3

	Vector3 = var_9

	local var_4_12 = var_4_10(var_4_11, var_9(1.1, 1.1, 1), 0.1)
	local var_4_13 = var_6.setDelay(var_4_12, 0.1)

	var_6.setUseEstimatedTime(var_4_13, true)

	local function var_4_14(arg_5_0, arg_5_1)
		GetOrAddComponent = var_2_10002

		local var_5_0 = var_2_10002(arg_5_0, "CanvasGroup")

		Timer = var_2_10003

		local var_5_1 = var_2_10003.New(function()
			IsNil = var_3_10000

			if var_3_10000(arg_5_0) then
				return
			end

			LeanTween = var_0

			local var_6_0 = var_0.scale
			local var_6_1 = arg_5_0

			Vector3 = var_3_10003

			local var_6_2 = var_6_0(var_6_1, var_3_10003(0.1, 1.5, 1), 0.1)
			local var_6_3 = var_0.setUseEstimatedTime(var_6_2, true)
			local var_6_4 = var_0.setOnComplete

			System = var_3

			var_6_4(var_6_3, var_3.Action(function()
				LeanTween = var_4_10000

				local var_7_0 = var_4_10000.scale
				local var_7_1 = arg_5_0

				Vector3 = var_4_10003

				local var_7_2 = var_7_0(var_7_1, var_4_10003.zero, 0.1)
				local var_7_3 = var_0.setUseEstimatedTime(var_7_2, true)
				local var_7_4 = var_0.setOnComplete

				System = var_3

				var_7_4(var_7_3, var_3.Action(function()
					Destroy = var_5_10000

					var_5_10000(arg_5_0)

					pairs = var_5_10000

					for iter_8_0, iter_8_1 in var_5_10000(arg_4_0._tipTable) do
						if iter_8_1 == arg_5_0 then
							table = var_5

							var_5.remove(arg_4_0._tipTable, iter_8_0)
						end
					end

					arg_4_0._count = arg_4_0._count - 1

					if arg_4_0._count == 0 then
						SetActive = var_0

						var_0(arg_4_0._go, false)
					end

					return
				end))

				return
			end))

			return
		end, 3)

		var_3.Start(var_5_1)

		return
	end

	local var_4_15

	if arg_4_0._count <= 3 then
		var_4_15 = arg_4_0._tipTable
		var_4_15[arg_4_0._count] = var_4_3

		var_4_14(var_4_3, arg_4_0._count)
	else
		Destroy = var_4_15

		var_4_15(arg_4_0._tipTable[1])

		table = var_4_15

		var_4_15.remove(arg_4_0._tipTable, 1)

		arg_4_0._count = 3
		arg_4_0._tipTable[3] = var_4_3

		var_4_14(var_4_3, arg_4_0._count)
	end

	return
end

function var_0_1.ShowPicTips(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0.CriMgr.GetInstance()
	local var_9_1 = var_5.PlaySoundEffect_V3

	if not arg_9_4 then
		::label_9_0::

		SFX_UI_TIP = var_1_10008
	end

	var_9_1(var_9_0, var_1_10008)

	local var_9_2 = arg_9_0._go.transform

	var_5.SetAsLastSibling(var_9_2)

	SetActive = var_5

	var_5(arg_9_0._go, true)

	arg_9_0._count = arg_9_0._count + 1
	cloneTplTo = var_5

	local var_9_3 = var_5(arg_9_0._picTips, arg_9_0._grid)
	local var_9_4 = arg_9_3 or "white"

	setText = var_7

	local var_9_5 = var_9_3.transform

	var_7(var_9.Find(var_9_5, "Text"), "<color=" .. var_9_4 .. ">\"" .. arg_9_1 .. "\" x" .. arg_9_2 .. "</color>")

	local function var_9_6(arg_10_0)
		GetOrAddComponent = var_2_10001

		local var_10_0 = var_2_10001(arg_10_0, "CanvasGroup")

		var_10_0.alpha = 1
		LeanTween = var_2

		local var_10_1 = var_2.alphaCanvas(var_10_0, 0, 5)
		local var_10_2 = var_2.setUseEstimatedTime(var_10_1, true)
		local var_10_3 = var_2.setOnComplete

		System = var_5

		local var_10_4 = var_10_3(var_10_2, var_5.Action(function()
			Destroy = var_3_10000

			var_3_10000(arg_10_0)

			pairs = var_3_10000

			for iter_11_0, iter_11_1 in var_3_10000(arg_9_0._tipTable) do
				if iter_11_1 == arg_10_0 then
					table = var_5

					var_5.remove(arg_9_0._tipTable, iter_11_0)
				end
			end

			arg_9_0._count = arg_9_0._count - 1

			if arg_9_0._count == 0 then
				SetActive = var_0

				var_0(arg_9_0._go, false)
			end

			return
		end))

		return
	end

	local var_9_7

	if arg_9_0._count <= 3 then
		var_9_7 = arg_9_0._tipTable
		var_9_7[arg_9_0._count] = var_9_3

		var_9_6(var_9_3)
	else
		Destroy = var_9_7

		var_9_7(arg_9_0._tipTable[1])

		table = var_9_7

		var_9_7.remove(arg_9_0._tipTable, 1)

		arg_9_0._count = 3
		arg_9_0._tipTable[3] = var_9_3

		var_9_6(var_9_3)
	end

	return
end

return
