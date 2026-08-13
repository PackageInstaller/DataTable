class = var_0_10000

local var_0_0 = "FeastMakeTicketPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FeastPuzzlePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.back = var_1.Find(var_2_0, "back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.finishTr = var_1.Find(var_2_1, "finish")

	local var_2_2 = arg_2_0.finishTr
	local var_2_3 = var_1.Find(var_2_2, "envelopes")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	SpineAnimUI = var_1_10004
	arg_2_0.envelopesAnim = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0.finishTr

	arg_2_0.sendBtn = var_1.Find(var_2_5, "send")

	local var_2_6 = arg_2_0.finishTr

	arg_2_0.titleTr = var_1.Find(var_2_6, "label1")

	local var_2_7 = arg_2_0._tf

	arg_2_0.failedTip = var_1.Find(var_2_7, "failed_tip")

	local var_2_8 = arg_2_0._tf

	arg_2_0.descTr = var_1.Find(var_2_8, "desc_panel")

	local var_2_9 = arg_2_0.descTr
	local var_2_10 = var_1.Find(var_2_9, "frame/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_12, "home")

	local var_2_13 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_13, "help")

	local var_2_14 = arg_2_0._tf

	arg_2_0.tipTopTr = var_1.Find(var_2_14, "tip")
	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "tip/Text")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("feast_label_make_ticket_tip"))

	setText = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "tip/label")

	i18n = var_2_17

	var_1(var_2_18, var_2_17("feast_label_make_ticket_click_tip"))

	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_2.Find(var_2_19, "failed_tip/Text")

	i18n = var_2_19

	var_1(var_2_20, var_2_19("feast_label_make_ticket_failed_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	FeastScene = var_1_10003

	var_3_1(var_3_0, var_1_10003.ON_MAKE_TICKET, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0

		var_2.OnMakeTicket(var_4_0, arg_4_1)

		return
	end)

	return
end

function var_0_1.OnMakeTicket(arg_5_0, arg_5_1)
	if arg_5_0.feastShip and arg_5_0.feastShip.id == arg_5_1 then
		setActive = var_2

		var_2(arg_5_0.finishTr, true)

		setActive = var_2

		var_2(arg_5_0.tipTopTr, false)

		local var_5_0 = arg_5_0.sendBtn

		Vector3 = var_3
		var_5_0.localScale = var_3.zero

		local var_5_1 = arg_5_0.titleTr

		Vector3 = var_3
		var_5_1.localScale = var_3.zero

		local var_5_2 = arg_5_0.envelopesAnim

		var_2.SetActionCallBack(var_5_2, function(arg_6_0)
			if arg_6_0 == "finish" then
				LeanTween = var_2_10001

				local var_6_0 = var_2_10001.scale
				local var_6_1 = arg_5_0.sendBtn

				Vector3 = var_2_10003

				var_6_0(var_6_1, var_2_10003(1, 1, 1), 0.3)

				LeanTween = var_6_0

				local var_6_2 = var_6_0.scale
				local var_6_3 = arg_5_0.titleTr

				Vector3 = var_3

				var_6_2(var_6_3, var_3(1, 1, 1), 0.3)

				local var_6_4 = arg_5_0.envelopesAnim

				var_1.SetActionCallBack(var_6_4, nil)

				local var_6_5 = arg_5_0.envelopesAnim

				var_1.SetAction(var_6_5, "action2", 0)
			end

			return
		end)

		local var_5_3 = arg_5_0.envelopesAnim

		var_2.SetAction(var_5_3, "action1", 0)
	end

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	Input = var_1_10002
	var_1_10002.multiTouchEnabled = false

	var_0_1.super.Show(arg_7_0)
	arg_7_0:CloseTip()

	setActive = var_2

	var_2(arg_7_0.tipTopTr, true)

	setActive = var_2

	var_2(arg_7_0.finishTr, false)

	arg_7_0.feastShip = arg_7_1
	seriesAsync = var_2

	var_2({
		function(arg_8_0)
			local var_8_0 = arg_7_0
			local var_8_1 = var_1.LoadPuzzleRes
			local var_8_2 = arg_7_1

			var_8_1(var_8_0, var_3.GetPrefab(var_8_2), arg_8_0)

			return
		end
	}, function()
		local var_9_0 = arg_7_0

		var_0.InitPuzzle(var_9_0)

		local var_9_1 = arg_7_0

		var_0.RegisterEvent(var_9_1)

		return
	end)

	return
end

function var_0_1.LoadPuzzleRes(arg_10_0, arg_10_1, arg_10_2)
	ResourceMgr = var_1_10003

	local var_10_0 = var_1_10003.Inst
	local var_10_1 = var_3.getAssetAsync
	local var_10_2 = "FeastPuzzle/" .. arg_10_1
	local var_10_3 = ""

	typeof = var_1_10007
	GameObject = var_1_10008

	local var_10_4 = var_1_10007(var_1_10008)

	UnityEngine = var_1_10008

	var_10_1(var_10_0, var_10_2, var_10_3, var_10_4, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
		if arg_10_0.exited then
			return
		end

		local var_11_0 = arg_10_0

		Object = var_2_10002

		local var_11_1 = var_2_10002.Instantiate
		local var_11_2 = arg_11_0
		local var_11_3 = arg_10_0._tf

		var_11_0.puzzleGo = var_11_1(var_11_2, var_4.Find(var_11_3, "container"))

		local var_11_4 = arg_10_0
		local var_11_5 = arg_10_0.puzzleGo.transform

		var_11_4.rect = var_2.Find(var_11_5, "nodes")

		local var_11_6 = arg_10_0

		var_11_6.items = {}
		eachChild = var_11_6

		var_11_6(arg_10_0.rect, function(arg_12_0)
			tonumber = var_3_10001

			local var_12_0 = var_3_10001(arg_12_0.name) == 1

			table = var_3_10003

			var_3_10003.insert(arg_10_0.items, {
				level = var_1,
				tr = arg_12_0,
				isCompletion = var_12_0
			})

			return
		end)
		arg_10_2()

		return
	end), true, true)

	return
end

local function var_0_2(arg_13_0, arg_13_1)
	pg = var_1_10002

	local var_13_0 = var_1_10002.UIMgr.GetInstance().overlayCameraComp
	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0.GetComponent(var_13_1, "RectTransform")

	LuaHelper = var_13_1

	return (var_13_1.ScreenToLocal(var_13_2, arg_13_1, var_13_0))
end

function var_0_1.InitPuzzle(arg_14_0, arg_14_1)
	arg_14_0.dragging = false
	ipairs = var_2

	for iter_14_0, iter_14_1 in var_2(arg_14_0.items) do
		local var_14_0 = iter_14_1.tr
		local var_14_1 = var_7.GetComponent

		typeof = var_1_10009
		EventTriggerListener = var_1_10010

		local var_14_2 = var_14_1(var_14_0, var_1_10009(var_1_10010))

		Vector3 = var_14_0

		local var_14_3 = var_14_0.zero

		var_1_10010 = var_14_2

		var_14_2.AddBeginDragFunc(var_1_10010, function(arg_15_0, arg_15_1)
			arg_14_0.dragging = true
			var_14_3 = iter_14_1.tr.localPosition

			local var_15_0 = iter_14_1.tr

			var_2.SetAsLastSibling(var_15_0)

			return
		end)

		var_1_10010 = var_14_2

		var_14_2.AddDragFunc(var_1_10010, function(arg_16_0, arg_16_1)
			local var_16_0 = var_0_2(arg_14_0.rect, arg_16_1.position)

			iter_14_1.tr.localPosition = var_16_0

			return
		end)

		var_1_10010 = var_14_2

		var_14_2.AddDragEndFunc(var_1_10010, function(arg_17_0, arg_17_1)
			arg_14_0.dragging = false

			local var_17_0 = arg_14_0

			if var_2.FindMatcher(var_17_0, iter_14_1) then
				local var_17_1 = arg_14_0

				var_3.Merge(var_17_1, iter_14_1, var_2, var_14_3)

				local var_17_2 = arg_14_0

				if var_3.CheckFinish(var_17_2) then
					local var_17_3 = arg_14_0

					var_3.OnPass(var_17_3)
				end
			else
				local var_17_4 = arg_14_0

				var_3.ShowTip(var_17_4)

				iter_14_1.tr.localPosition = var_14_3
			end

			return
		end)

		var_1_10010 = var_14_2

		var_14_2.AddPointUpFunc(var_1_10010, function(arg_18_0, arg_18_1)
			if arg_14_0.dragging then
				return
			end

			local var_18_0 = arg_14_0

			var_2.ShowDesc(var_18_0, iter_14_1)

			return
		end)
	end

	return
end

function var_0_1.ShowTip(arg_19_0)
	arg_19_0:CloseTip()

	setActive = var_1

	var_1(arg_19_0.failedTip, true)

	Timer = var_1
	arg_19_0.timer = var_1.New(function()
		local var_20_0 = arg_19_0

		var_0.CloseTip(var_20_0)

		return
	end, 2, 1)

	local var_19_0 = arg_19_0.timer

	var_1.Start(var_19_0)

	return
end

function var_0_1.CloseTip(arg_21_0)
	if arg_21_0.timer then
		setActive = var_1

		var_1(arg_21_0.failedTip, false)

		local var_21_0 = arg_21_0.timer

		var_1.Stop(var_21_0)

		arg_21_0.timer = nil
	end

	return
end

function var_0_1.CheckFinish(arg_22_0)
	return arg_22_0.rect.childCount == 1
end

function var_0_1.Merge(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0

	if arg_23_2.level < arg_23_1.level then
		var_23_0 = arg_23_1.tr
		var_23_0.localPosition = arg_23_3
		setParent = var_23_0

		local var_23_1 = arg_23_2.tr
		local var_23_2 = arg_23_1.tr

		var_23_0(var_23_1, var_6.Find(var_23_2, "slot"))

		var_23_0 = arg_23_2.tr
		Vector3 = var_23_1
		var_23_0.localPosition = var_23_1.zero

		arg_23_0:ClearEvent(arg_23_2.tr)

		arg_23_1.isCompletion = true
	else
		setParent = var_23_0

		local var_23_3 = arg_23_1.tr
		local var_23_4 = arg_23_2.tr

		var_23_0(var_23_3, var_6.Find(var_23_4, "slot"))

		local var_23_5 = arg_23_1.tr

		Vector3 = var_23_3
		var_23_5.localPosition = var_23_3.zero

		arg_23_0:ClearEvent(arg_23_1.tr)

		arg_23_2.isCompletion = true
	end

	return
end

local function var_0_3(arg_24_0, arg_24_1)
	getBounds = var_1_10002

	local var_24_0 = var_1_10002(arg_24_0.tr)

	getBounds = var_3

	local var_24_1 = var_3(arg_24_1.tr)

	return var_24_0:Intersects(var_24_1)
end

local function var_0_4(arg_25_0, arg_25_1)
	if arg_25_0.level < arg_25_1.level then
		return arg_25_0.isCompletion
	else
		return arg_25_1.isCompletion
	end

	return
end

function var_0_1.FindMatcher(arg_26_0, arg_26_1)
	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.items) do
		if (arg_26_1.level + 1 == iter_26_1.level or arg_26_1.level - 1 == iter_26_1.level) and var_0_4(arg_26_1, iter_26_1) and var_0_3(arg_26_1, iter_26_1) then
			return iter_26_1
		end
	end

	return nil
end

function var_0_1.OnPass(arg_27_0)
	ipairs = var_1_10001

	for iter_27_0, iter_27_1 in var_1_10001(arg_27_0.items) do
		arg_27_0:ClearEvent(iter_27_1.tr)
	end

	setActive = var_1

	var_1(arg_27_0.rect, false)

	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.emit

	FeastMediator = var_3

	var_27_1(var_27_0, var_3.MAKE_TICKET, arg_27_0.feastShip.tid)

	return
end

function var_0_1.RegisterEvent(arg_28_0, arg_28_1)
	onButton = var_1_10002

	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.back

	local function var_28_2()
		local var_29_0 = arg_28_0

		var_0.Hide(var_29_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_28_0, var_28_1, var_28_2, var_1_10006)

	onButton = var_1_10002

	local var_28_3 = arg_28_0
	local var_28_4 = arg_28_0.sendBtn

	local function var_28_5()
		local var_30_0 = arg_28_0

		var_0.Hide(var_30_0)

		local var_30_1 = arg_28_0
		local var_30_2 = var_0.emit

		FeastScene = var_2_10002

		var_30_2(var_30_1, var_2_10002.ON_SKIP_GIVE_GIFT, arg_28_0.feastShip)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_28_3, var_28_4, var_28_5, var_1_10006)

	onButton = var_1_10002

	local var_28_6 = arg_28_0
	local var_28_7 = arg_28_0.helpBtn

	local function var_28_8()
		pg = var_2_10000

		local var_31_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_31_1 = var_0.ShowMsgBox
		local var_31_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_31_2.type = var_2_10003
		pg = var_2_10003
		var_31_2.helps = var_2_10003.gametip.feast_make_invitation_tip.tip

		var_31_1(var_31_0, var_31_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_28_6, var_28_7, var_28_8, var_1_10006)

	onButton = var_1_10002

	local var_28_9 = arg_28_0
	local var_28_10 = arg_28_0.homeBtn

	local function var_28_11()
		local var_32_0 = arg_28_0
		local var_32_1 = var_0.emit

		BaseUI = var_2_10002

		var_32_1(var_32_0, var_2_10002.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_28_9, var_28_10, var_28_11, var_1_10006)

	return
end

function var_0_1.ShowDesc(arg_33_0, arg_33_1)
	arg_33_0.isShowDesc = true
	pg = var_2

	local var_33_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_33_0, arg_33_0.descTr)

	setActive = var_2

	var_2(arg_33_0.descTr, true)

	Object = var_2
	arg_33_0.descNode = var_2.Instantiate(arg_33_1.tr.gameObject, arg_33_0.descTr)

	local var_33_1 = arg_33_0.descNode.transform

	Vector3 = var_3
	var_33_1.localPosition = var_3(0, 100, 0)

	local var_33_2 = arg_33_0.descTxt

	i18n = var_3
	var_33_2.text = var_3("feast_invitation_part" .. arg_33_1.level)
	onButton = var_33_2

	local var_33_3 = arg_33_0
	local var_33_4 = arg_33_0.descTr

	local function var_33_5()
		local var_34_0 = arg_33_0

		var_0.HideDesc(var_34_0)

		return
	end

	SFX_PANEL = var_6

	var_33_2(var_33_3, var_33_4, var_33_5, var_6)

	return
end

function var_0_1.HideDesc(arg_35_0)
	if not arg_35_0.isShowDesc then
		return
	end

	arg_35_0.isShowDesc = false
	pg = var_1

	local var_35_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_35_0, arg_35_0.descTr, arg_35_0._tf)

	if arg_35_0.descNode then
		Object = var_1

		var_1.Destroy(arg_35_0.descNode.gameObject)

		arg_35_0.descNode = nil
	end

	setActive = var_1

	var_1(arg_35_0.descTr, false)

	return
end

function var_0_1.Clear(arg_36_0)
	local var_36_0 = arg_36_0.envelopesAnim

	var_1.SetActionCallBack(var_36_0, nil)
	arg_36_0:CloseTip()

	ipairs = var_1

	for iter_36_0, iter_36_1 in var_1(arg_36_0.items) do
		arg_36_0:ClearEvent(iter_36_1.tr)
	end

	arg_36_0.items = {}

	if arg_36_0.puzzleGo then
		Object = var_1

		var_1.Destroy(arg_36_0.puzzleGo)

		arg_36_0.puzzleGo = nil
	end

	removeOnButton = var_1

	var_1(arg_36_0.back)

	LeanTween = var_1

	if var_1.isTweening(arg_36_0.sendBtn.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_36_0.sendBtn.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_36_0.titleTr.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_36_0.titleTr.gameObject)
	end

	arg_36_0:HideDesc()

	return
end

function var_0_1.ClearEvent(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1
	local var_37_1 = arg_37_1.GetComponent

	typeof = var_1_10004
	EventTriggerListener = var_1_10005

	local var_37_2 = var_37_1(var_37_0, var_1_10004(var_1_10005))

	var_2.AddBeginDragFunc(var_37_2, nil)
	var_2:AddDragFunc(nil)
	var_2:AddDragEndFunc(nil)
	var_2:AddPointUpFunc(nil)

	local var_37_3 = arg_37_1
	local var_37_4 = arg_37_1.GetComponentsInChildren

	typeof = var_5
	Image = var_1_10006

	local var_37_5 = var_37_4(var_37_3, var_5(var_1_10006))
	local var_37_6 = var_3.ToTable(var_37_5)

	ipairs = var_37_5

	for iter_37_0, iter_37_1 in var_37_5(var_37_6) do
		iter_37_1.raycastTarget = false
	end

	return
end

function var_0_1.Hide(arg_38_0)
	Input = var_1_10001
	var_1_10001.multiTouchEnabled = true

	var_0_1.super.Hide(arg_38_0)
	arg_38_0:Clear()

	return
end

function var_0_1.OnDestroy(arg_39_0)
	arg_39_0.exited = true

	arg_39_0:Clear()

	if arg_39_0:isShowing() then
		arg_39_0:Hide()
	end

	return
end

return var_0_1
