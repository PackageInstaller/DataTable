class = var_0_10000

local var_0_0 = "SculptureDrawLinePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculptureDrawLineUI"
end

function var_0_1.OnLoaded(arg_2_0)
	GetOrAddComponent = var_1_10001

	local var_2_0 = arg_2_0._parentTf

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	arg_2_0.cg = var_1_10001(var_2_0, var_1_10004(var_1_10006))

	local var_2_1 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_1, "back")

	local var_2_2 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_2, "help")

	local var_2_3 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_3, "frame")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	EventTriggerListener = var_1_10006
	arg_2_0.eventTrigger = var_2_6(var_2_5, var_4(var_1_10006))
	pg = var_1

	local var_2_7 = var_1.UIMgr.GetInstance().uiCamera

	arg_2_0.uiCam = var_1.GetComponent(var_2_7, "Camera")

	local var_2_8 = arg_2_0.frame

	arg_2_0.oneKeyBtn = var_1.Find(var_2_8, "onekey")

	local var_2_9 = arg_2_0.frame

	arg_2_0.penTpl = var_1.Find(var_2_9, "pen")
	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "tip")

	i18n = var_4

	var_1(var_2_11, var_4("sculpture_drawline_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.points = {}
	arg_3_0.index = 0

	return
end

function var_0_1.Show(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.Show(arg_4_0)

	arg_4_0.id = arg_4_1
	arg_4_0.activity = arg_4_2
	seriesAsync = var_3

	var_3({
		function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.Clear(var_5_0)

			local var_5_1 = arg_4_0

			var_1.InitLine(var_5_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.InitOneKey(var_6_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_4_0

			var_1.InitLineRendering(var_7_0)

			local var_7_1 = arg_4_0

			var_1.RegisterEvent(var_7_1, arg_7_0)

			return
		end
	})

	pg = var_3

	local var_4_0 = var_3.BgmMgr.GetInstance()

	var_3.Push(var_4_0, arg_4_0.__cname, "bar-soft")

	return
end

function var_0_1.InitLine(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_2.GetResorceName(var_8_0, arg_8_0.id)

	ResourceMgr = var_1_10003

	local var_8_2 = var_1_10003.Inst
	local var_8_3 = var_3.getAssetAsync
	local var_8_4 = "ui/" .. var_8_1 .. "_line"
	local var_8_5 = ""

	UnityEngine = var_8

	var_8_3(var_8_2, var_8_4, var_8_5, var_8.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		local var_9_0 = arg_8_0

		Object = var_2_10002
		var_9_0.tracker = var_2_10002.Instantiate(arg_9_0, arg_8_0.frame).transform

		local var_9_1 = arg_8_0
		local var_9_2 = arg_8_0.tracker

		var_9_1.trackerCollider = var_2.GetComponent(var_9_2, "EdgeCollider2D")

		arg_8_1()

		return
	end), true, true)

	return
end

function var_0_1.InitOneKey(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.activity
	local var_10_1 = var_2.GetResorceName(var_10_0, arg_10_0.id)

	ResourceMgr = var_1_10003

	local var_10_2 = var_1_10003.Inst
	local var_10_3 = var_3.getAssetAsync
	local var_10_4 = "ui/" .. var_10_1 .. "_onekey"
	local var_10_5 = ""

	UnityEngine = var_8

	var_10_3(var_10_2, var_10_4, var_10_5, var_8.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
		Object = var_2_10001

		local var_11_0 = var_2_10001.Instantiate(arg_11_0, arg_10_0.frame).transform

		arg_10_0.onekeyTrack = var_11_0:GetComponent("EdgeCollider2D")

		arg_10_1()

		return
	end), true, true)

	return
end

function var_0_1.InitLineRendering(arg_12_0)
	local var_12_0 = arg_12_0.eventTrigger

	var_1.AddPointDownFunc(var_12_0, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_12_0

		var_2.OnPointDown(var_13_0, arg_13_1)

		return
	end)

	local var_12_1 = arg_12_0.eventTrigger

	var_1.AddPointUpFunc(var_12_1, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_12_0

		var_2.OnPointUp(var_14_0)

		return
	end)

	local var_12_2 = arg_12_0.eventTrigger

	var_1.AddDragFunc(var_12_2, function(arg_15_0, arg_15_1)
		arg_12_0.index = arg_12_0.index + 1

		if arg_12_0.index % 5 ~= 0 then
			return
		end

		local var_15_0 = arg_12_0

		var_2.OnDrag(var_15_0, arg_15_1)

		return
	end)

	return
end

function var_0_1.OnPointDown(arg_16_0, arg_16_1)
	arg_16_0.points = {}

	arg_16_0:AddPoint(arg_16_1.position)

	local var_16_0 = arg_16_0.points[#arg_16_0.points]

	Object = var_3

	local var_16_1 = var_3.Instantiate
	local var_16_2 = arg_16_0.penTpl
	local var_16_3 = var_16_0

	Quaternion = var_1_10007
	arg_16_0.pen = var_16_1(var_16_2, var_16_3, var_1_10007.New(0, 0, 0, 0), arg_16_0.frame)
	setActive = var_3

	var_3(arg_16_0.pen, true)

	return
end

function var_0_1.OnPointUp(arg_17_0)
	if not arg_17_0.pen then
		return
	end

	if #arg_17_0.points <= 2 then
		arg_17_0.points = {}

		return
	end

	local var_17_0 = true

	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_0.points) do
		local var_17_1 = arg_17_0.trackerCollider

		if not var_7.OverlapPoint(var_17_1, iter_17_1) then
			var_17_0 = false

			break
		end
	end

	if var_17_0 then
		if not (#arg_17_0.points < 20) then
			Vector2 = var_2

			if var_2.Distance(arg_17_0.points[1], arg_17_0.points[#arg_17_0.points]) > 2 then
				var_17_0 = false
			end

			if not var_17_0 then
				local var_17_2 = arg_17_0.contextData.tipPage

				var_2.ExecuteAction(var_17_2, "Show")
			else
				arg_17_0:OnPass()
			end

			Object = var_2

			var_2.Destroy(arg_17_0.pen.gameObject)

			arg_17_0.pen = nil

			return
		end
	end
end

function var_0_1.OnPass(arg_18_0)
	local var_18_0 = arg_18_0.contextData.miniMsgBox
	local var_18_1 = var_1.ExecuteAction
	local var_18_2 = "Show"
	local var_18_3 = {
		model = true,
		effect = true,
		yes_text = "btn_next"
	}

	i18n = var_1_10006
	var_18_3.content = var_1_10006("sculpture_drawline_done")

	function var_18_3.onYes()
		local var_19_0 = arg_18_0
		local var_19_1 = var_0.emit

		SculptureMediator = var_2_10003

		var_19_1(var_19_0, var_2_10003.ON_DRAW_SCULPTURE, arg_18_0.id)

		return
	end

	var_18_1(var_18_0, var_18_2, var_18_3)

	return
end

function var_0_1.OnDrag(arg_20_0, arg_20_1)
	if not arg_20_0.pen then
		return
	end

	arg_20_0:AddPoint(arg_20_1.position)

	local var_20_0 = arg_20_0.points[#arg_20_0.points]

	arg_20_0.pen.position = var_20_0

	return
end

function var_0_1.AddPoint(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.uiCam
	local var_21_1 = var_2.ScreenToWorldPoint(var_21_0, arg_21_1)

	Vector3 = var_1_10003

	local var_21_2 = var_1_10003(var_21_1.x, var_21_1.y, -1)

	table = var_21_0

	var_21_0.insert(arg_21_0.points, var_21_2)

	return
end

function var_0_1.RegisterEvent(arg_22_0, arg_22_1)
	onButton = var_1_10002

	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.backBtn

	local function var_22_2()
		local var_23_0 = arg_22_0.contextData.miniMsgBox
		local var_23_1 = var_0.ExecuteAction
		local var_23_2 = "Show"
		local var_23_3 = {
			showNo = true
		}

		i18n = var_2_10005
		var_23_3.content = var_2_10005("sculpture_drawline_exit")

		function var_23_3.onYes()
			local var_24_0 = arg_22_0

			var_0.Hide(var_24_0)

			return
		end

		var_23_1(var_23_0, var_23_2, var_23_3)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_22_0, var_22_1, var_22_2, var_1_10007)

	onButton = var_1_10002

	local var_22_3 = arg_22_0
	local var_22_4 = arg_22_0.oneKeyBtn

	local function var_22_5()
		local var_25_0 = arg_22_0

		var_0.OnOneKey(var_25_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_22_3, var_22_4, var_22_5, var_1_10007)

	onButton = var_1_10002

	local var_22_6 = arg_22_0
	local var_22_7 = arg_22_0.helpBtn

	local function var_22_8()
		pg = var_2_10000

		local var_26_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_26_1 = var_0.ShowMsgBox
		local var_26_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_26_2.type = var_2_10004
		pg = var_2_10004
		var_26_2.helps = var_2_10004.gametip.gift_act_help.tip

		var_26_1(var_26_0, var_26_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_22_6, var_22_7, var_22_8, var_1_10007)

	return
end

function var_0_1.OnOneKey(arg_27_0)
	arg_27_0.points = {}
	ipairs = var_1

	local var_27_0 = arg_27_0.onekeyTrack.points

	for iter_27_0, iter_27_1 in var_1(var_3.ToTable(var_27_0)) do
		local var_27_1 = arg_27_0.tracker
		local var_27_2 = var_6.TransformPoint(var_27_1, iter_27_1)

		Vector3 = var_1_10007
		var_1_10007 = var_1_10007(var_27_2.x, var_27_2.y, -1)
		table = var_27_1

		var_27_1.insert(arg_27_0.points, var_1_10007)
	end

	local function var_27_3(arg_28_0)
		if not arg_27_0.pen then
			local var_28_0 = arg_27_0

			Object = var_2_10002

			local var_28_1 = var_2_10002.Instantiate
			local var_28_2 = arg_27_0.penTpl
			local var_28_3 = arg_28_0

			Quaternion = var_2_10006
			var_28_0.pen = var_28_1(var_28_2, var_28_3, var_2_10006.New(0, 0, 0, 0), arg_27_0.frame)
		else
			arg_27_0.pen.position = arg_28_0
		end

		return
	end

	local var_27_4 = {}

	for iter_27_2 = 1, #arg_27_0.points do
		table = var_1_10007

		var_1_10007.insert(var_27_4, function(arg_29_0)
			var_27_3(arg_27_0.points[iter_27_2])

			onNextTick = var_1

			var_1(arg_29_0)

			return
		end)
	end

	local var_27_5 = arg_27_0.cg

	var_27_5.blocksRaycasts = false
	seriesAsync = var_27_5

	var_27_5(var_27_4, function()
		local var_30_0 = arg_27_0

		var_0.OnPass(var_30_0)

		arg_27_0.cg.blocksRaycasts = true

		if arg_27_0.pen then
			Object = var_0

			var_0.Destroy(arg_27_0.pen.gameObject)

			arg_27_0.pen = nil
		end

		return
	end)

	return
end

function var_0_1.Clear(arg_31_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_31_0.tracker) then
		Object = var_1

		var_1.Destroy(arg_31_0.tracker.gameObject)
	end

	arg_31_0.points = {}
	arg_31_0.tracker = nil
	removeOnButton = var_1

	var_1(arg_31_0.oneKeyBtn)

	return
end

function var_0_1.Hide(arg_32_0)
	var_0_1.super.Hide(arg_32_0)

	pg = var_1

	local var_32_0 = var_1.BgmMgr.GetInstance()

	var_1.Pop(var_32_0, arg_32_0.__cname)
	arg_32_0:Clear()

	return
end

function var_0_1.OnDestroy(arg_33_0)
	arg_33_0.exited = true

	return
end

return var_0_1
