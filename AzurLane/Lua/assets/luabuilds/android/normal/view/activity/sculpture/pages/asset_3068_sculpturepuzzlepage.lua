class = var_0_10000

local var_0_0 = "SculpturePuzzlePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculpturePuzzleUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.lineTr = var_1.Find(var_2_1, "frame/line")

	local var_2_2 = arg_2_0._tf

	arg_2_0.frameTr = var_1.Find(var_2_2, "frame")

	local var_2_3 = arg_2_0._tf

	arg_2_0.tipBtn = var_1.Find(var_2_3, "frame/tip")

	local var_2_4 = arg_2_0._tf

	arg_2_0.tipGrayBtn = var_1.Find(var_2_4, "frame/tip_gray")

	local var_2_5 = arg_2_0.tipGrayBtn
	local var_2_6 = var_1.Find(var_2_5, "Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.tipGrayBtnTxt = var_2_7(var_2_6, var_3(var_1_10004))
	setActive = var_1

	var_1(arg_2_0.tipGrayBtn, false)

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "frame/tip_text")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("sculpture_puzzle_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.slots = {}

	return
end

function var_0_1.Show(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	var_0_1.super.Show(arg_4_0)
	arg_4_0:Clear()

	arg_4_0.id = arg_4_1
	arg_4_0.activity = arg_4_2

	if arg_4_3 then
		arg_4_3()
	end

	seriesAsync = var_4

	var_4({
		function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.LoadLine(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.LoadPuzzle(var_6_0, arg_6_0)

			return
		end
	}, function()
		local var_7_0 = arg_4_0

		var_0.RegisterEvent(var_7_0)

		return
	end)

	pg = var_4

	local var_4_0 = var_4.BgmMgr.GetInstance()

	var_4.Push(var_4_0, arg_4_0.__cname, "bar-soft")

	return
end

function var_0_1.LoadLine(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_2.GetResorceName(var_8_0, arg_8_0.id)

	ResourceMgr = var_8_0

	local var_8_2 = var_8_0.Inst
	local var_8_3 = var_3.getAssetAsync
	local var_8_4 = "ui/" .. var_8_1 .. "_puzzle_line"
	local var_8_5 = ""

	UnityEngine = var_7

	var_8_3(var_8_2, var_8_4, var_8_5, var_7.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		Object = var_2_10001

		local var_9_0 = var_2_10001.Instantiate(arg_9_0, arg_8_0.lineTr)

		eachChild = var_2

		var_2(var_9_0, function(arg_10_0)
			arg_8_0.slots[arg_10_0.gameObject.name] = {
				flag = false,
				tr = arg_10_0
			}

			return
		end)

		arg_8_0.puzzleLine = var_9_0

		arg_8_1()

		return
	end), true, true)

	return
end

local function var_0_2(arg_11_0, arg_11_1)
	GameObject = var_1_10002

	local var_11_0 = var_1_10002.Find("UICamera")
	local var_11_1 = var_2.GetComponent(var_11_0, "Camera")
	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.GetComponent(var_11_2, "RectTransform")

	LuaHelper = var_11_2

	return (var_11_2.ScreenToLocal(var_11_3, arg_11_1, var_11_1))
end

local var_0_3 = Screen2Local

local function var_0_4(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0 == arg_12_1 then
		return arg_12_2
	else
		local var_12_0 = arg_12_0:TransformPoint(arg_12_2)
		local var_12_1 = arg_12_1
		local var_12_2 = arg_12_1.InverseTransformPoint(var_12_1, var_12_0)

		Vector3 = var_12_1

		return var_12_1(var_12_2.x, var_12_2.y, 0)
	end

	return
end

local var_0_5 = TrPosition2LocalPos

function var_0_1.HandlePuzzlePart(arg_13_0, arg_13_1)
	eachChild = var_1_10002

	var_1_10002(arg_13_1, function(arg_14_0)
		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.GetComponent

		typeof = var_2_10003
		EventTriggerListener = var_2_10004

		local var_14_2 = var_14_1(var_14_0, var_2_10003(var_2_10004))
		local var_14_3
		local var_14_4

		var_14_2:AddBeginDragFunc(function()
			local var_15_0 = arg_14_0

			var_14_4 = var_0.GetSiblingIndex(var_15_0)

			local var_15_1 = arg_14_0

			var_0.SetAsLastSibling(var_15_1)

			var_14_3 = arg_14_0.localPosition

			return
		end)
		var_14_2:AddDragFunc(function(arg_16_0, arg_16_1)
			Screen2Local = var_3_10002

			local var_16_0 = var_3_10002(arg_14_0.parent, arg_16_1.position)

			arg_14_0.localPosition = var_16_0

			return
		end)
		var_14_2:AddDragEndFunc(function(arg_17_0, arg_17_1)
			local var_17_0 = arg_13_0.slots[arg_14_0.gameObject.name].tr

			TrPosition2LocalPos = var_3

			local var_17_1 = var_3(var_17_0.parent, arg_14_0.parent, var_17_0.localPosition)

			Vector2 = var_4

			if var_4.Distance(var_17_1, arg_14_0.localPosition) < 50 then
				arg_13_0.slots[arg_14_0.gameObject.name].flag = true

				local var_17_2 = arg_14_0

				var_17_2.localPosition = var_17_1
				ClearEventTrigger = var_17_2

				var_17_2(var_14_2)

				Object = var_17_2

				var_17_2.Destroy(var_14_2)

				local var_17_3 = arg_13_0

				if var_4.IsFinishAll(var_17_3) then
					local var_17_4 = arg_13_0
					local var_17_5 = var_4.emit

					SculptureMediator = var_6

					var_17_5(var_17_4, var_6.ON_JOINT_SCULPTURE, arg_13_0.id)
				end
			else
				arg_14_0.localPosition = var_14_3
			end

			local var_17_6 = arg_14_0

			var_4.SetSiblingIndex(var_17_6, var_14_4)

			return
		end)

		return
	end)

	return
end

function var_0_1.IsFinishAll(arg_18_0)
	pairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.slots) do
		if iter_18_1.flag == false then
			return false
		end
	end

	return true
end

function var_0_1.LoadPuzzle(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.activity
	local var_19_1 = var_2.GetResorceName(var_19_0, arg_19_0.id)

	ResourceMgr = var_19_0

	local var_19_2 = var_19_0.Inst
	local var_19_3 = var_3.getAssetAsync
	local var_19_4 = "ui/" .. var_19_1 .. "_puzzle"
	local var_19_5 = ""

	UnityEngine = var_7

	var_19_3(var_19_2, var_19_4, var_19_5, var_7.Events.UnityAction_UnityEngine_Object(function(arg_20_0)
		Object = var_2_10001

		local var_20_0 = var_2_10001.Instantiate(arg_20_0, arg_19_0.frameTr)
		local var_20_1 = arg_19_0

		var_2.HandlePuzzlePart(var_20_1, var_20_0.transform)

		arg_19_0.puzzle = var_20_0

		arg_19_1()

		return
	end), true, true)

	return
end

function var_0_1.RegisterEvent(arg_21_0)
	onButton = var_1_10001

	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.backBtn

	local function var_21_2()
		local var_22_0 = arg_21_0.contextData.miniMsgBox
		local var_22_1 = var_0.ExecuteAction
		local var_22_2 = "Show"
		local var_22_3 = {
			showNo = true
		}

		i18n = var_2_10004
		var_22_3.content = var_2_10004("sculpture_drawline_exit")

		function var_22_3.onYes()
			local var_23_0 = arg_21_0

			var_0.Hide(var_23_0)

			return
		end

		var_22_1(var_22_0, var_22_2, var_22_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_21_0, var_21_1, var_21_2, var_1_10005)

	local var_21_3 = 0

	onButton = var_21_0

	local var_21_4 = arg_21_0
	local var_21_5 = arg_21_0.tipBtn

	local function var_21_6()
		local var_24_0 = arg_21_0

		if not var_0.IsFinishAll(var_24_0) then
			local var_24_1 = var_21_3

			if 0 < var_24_1 then
				return
			end

			local var_24_2 = {}

			pairs = var_24_0

			for iter_24_0, iter_24_1 in var_24_0(arg_21_0.slots) do
				if iter_24_1.flag == false then
					table = var_6

					var_6.insert(var_24_2, iter_24_1.tr)
				end
			end

			if #var_24_2 == 0 then
				return
			end

			var_21_3 = 10
			math = var_1

			local var_24_3 = var_1.random(1, #var_24_2)
			local var_24_4 = arg_21_0

			var_2.BlinkSlots(var_24_4, {
				var_24_2[var_24_3]
			})

			setActive = var_2

			var_2(arg_21_0.tipBtn, false)

			setActive = var_2

			var_2(arg_21_0.tipGrayBtn, true)

			local var_24_5 = arg_21_0

			var_2.AddTimer(var_24_5, function()
				var_21_3 = 0
				setActive = var_3_10000

				var_3_10000(arg_21_0.tipBtn, true)

				setActive = var_3_10000

				var_3_10000(arg_21_0.tipGrayBtn, false)

				return
			end)

			return
		end
	end

	SFX_PANEL = var_1_10006

	var_21_0(var_21_4, var_21_5, var_21_6, var_1_10006)

	return
end

function var_0_1.AddTimer(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0

	arg_26_0.ClearTimer(var_26_0)

	local var_26_1 = 11

	Timer = var_26_0
	arg_26_0.timer = var_26_0.New(function()
		var_26_1 = var_26_1 - 1
		arg_26_0.tipGrayBtnTxt.text = var_26_1 .. "s"

		if var_26_1 <= 0 then
			arg_26_1()
		end

		return
	end, 1, 10)

	arg_26_0.timer.func()

	local var_26_2 = arg_26_0.timer

	var_3.Start(var_26_2)

	return
end

function var_0_1.ClearTimer(arg_28_0)
	if arg_28_0.timer then
		local var_28_0 = arg_28_0.timer

		var_1.Stop(var_28_0)

		arg_28_0.timer = nil
	end

	return
end

function var_0_1.BlinkSlots(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {}

	ipairs = var_1_10004

	for iter_29_0, iter_29_1 in var_1_10004(arg_29_1) do
		local var_29_1 = iter_29_1
		local var_29_2 = iter_29_1.GetComponent

		typeof = var_1_10011
		Image = var_1_10012

		local var_29_3 = var_29_2(var_29_1, var_1_10011(var_1_10012)).color

		table = var_1_10011

		var_1_10011.insert(var_29_0, function(arg_30_0)
			LeanTween = var_2_10001

			local var_30_0 = var_2_10001.value(iter_29_1.gameObject, 0.5, 1, 0.3)
			local var_30_1 = var_1.setLoopPingPong(var_30_0, 3)
			local var_30_2 = var_1.setOnUpdate

			System = var_3

			local var_30_3 = var_30_2(var_30_1, var_3.Action_float(function(arg_31_0)
				local var_31_0 = var_0

				Color = var_3_10002
				var_31_0.color = var_3_10002.New(var_29_3.r, var_29_3.g, var_29_3.b, arg_31_0)

				return
			end))
			local var_30_4 = var_1.setOnComplete

			System = var_3

			var_30_4(var_30_3, var_3.Action(function()
				local var_32_0 = var_0

				Color = var_3_10001
				var_32_0.color = var_3_10001.New(var_29_3.r, var_29_3.g, var_29_3.b, 0)

				arg_30_0()

				return
			end))

			return
		end)
	end

	parallelAsync = var_4

	var_4(var_29_0, arg_29_2)

	return
end

function var_0_1.Clear(arg_33_0)
	if arg_33_0.puzzleLine then
		Object = var_1

		var_1.Destroy(arg_33_0.puzzleLine.gameObject)

		arg_33_0.puzzleLine = nil
	end

	if arg_33_0.puzzle then
		Object = var_1

		var_1.Destroy(arg_33_0.puzzle.gameObject)

		arg_33_0.puzzle = nil
	end

	arg_33_0.slots = {}

	return
end

function var_0_1.Hide(arg_34_0)
	var_0_1.super.Hide(arg_34_0)

	pg = var_1

	local var_34_0 = var_1.BgmMgr.GetInstance()

	var_1.Pop(var_34_0, arg_34_0.__cname)

	return
end

function var_0_1.OnDestroy(arg_35_0)
	arg_35_0:ClearTimer()

	pairs = var_1

	for iter_35_0, iter_35_1 in var_1(arg_35_0.slots) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_35_1.tr.gameObject) then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_35_1.tr.gameObject)
		end
	end

	return
end

return var_0_1
