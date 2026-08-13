class = var_0_10000

local var_0_0 = "SofmapPTPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

var_0_1.FADE_TIME = 0.5
var_0_1.SHOW_TIME = 1
var_0_1.FADE_OUT_TIME = 0.5
var_0_1.SpineActionByStep = {
	4,
	8,
	12,
	16,
	20
}

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.shop = var_1.Find(var_1_0, "shop")
	GetComponent = var_1
	arg_1_0.shopAnim = var_1(arg_1_0.shop, "SpineAnimUI")

	local var_1_1 = arg_1_0.bg

	arg_1_0.sdContainer = var_1.Find(var_1_1, "sdcontainer")
	arg_1_0.spine = nil
	GetSpineRequestPackage = var_1

	local var_1_2 = var_1.New("mingshi_5", function(arg_2_0)
		SetParent = var_2_10001

		var_2_10001(arg_2_0, arg_1_0.sdContainer)

		arg_1_0.spine = arg_2_0

		local var_2_0 = arg_1_0.spine.transform

		Vector3 = var_2_10002
		var_2_0.localScale = var_2_10002.one

		local var_2_1 = arg_1_0.spine

		if var_1.GetComponent(var_2_1, "SpineAnimUI") then
			var_1:SetAction("stand", 0)
		end

		arg_1_0.spineLRQ = nil

		return
	end)

	arg_1_0.spineLRQ = var_1.Start(var_1_2)
	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.bg
	local var_1_5 = var_4.Find(var_1_4, "sdBtn")

	local function var_1_6()
		local var_3_0 = arg_1_0

		var_0.showBubble(var_3_0)

		return
	end

	SFX_PANEL = var_1_4

	var_1(var_1_3, var_1_5, var_1_6, var_1_4)

	local var_1_7 = arg_1_0.bg

	arg_1_0.levelBtn = var_1.Find(var_1_7, "level_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.ptBtn = var_1.Find(var_1_8, "pt_btn")

	local var_1_9 = arg_1_0.bg

	arg_1_0.bubble = var_1.Find(var_1_9, "bubble")

	local var_1_10 = arg_1_0.bubble

	arg_1_0.bubbleText = var_1.Find(var_1_10, "Text")
	GetComponent = var_1
	arg_1_0.bubbleCG = var_1(arg_1_0.bubble, "CanvasGroup")
	arg_1_0.showBubbleTag = false
	onButton = var_1

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.getBtn

	local function var_1_13()
		local var_4_0 = arg_1_0.ptData
		local var_4_1, var_4_2 = var_0.GetResProgress(var_4_0)
		local var_4_3 = arg_1_0
		local var_4_4 = var_2.emit

		ActivityMediator = var_2_10005

		local var_4_5 = var_2_10005.EVENT_PT_OPERATION
		local var_4_6 = {
			cmd = 1
		}
		local var_4_7 = arg_1_0.ptData

		var_4_6.activity_id = var_7.GetId(var_4_7)
		var_4_6.arg1 = var_4_2

		function var_4_6.callback()
			local var_5_0 = arg_1_0
			local var_5_1 = var_0.showBubble

			i18n = var_3_10003

			var_5_1(var_5_0, var_3_10003("sofmapsd_3"))

			return
		end

		var_4_4(var_4_3, var_4_5, var_4_6)

		return
	end

	SFX_PANEL = var_1_4

	var_1(var_1_11, var_1_12, var_1_13, var_1_4)

	onButton = var_1

	local var_1_14 = arg_1_0
	local var_1_15 = arg_1_0.levelBtn

	local function var_1_16()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.sofmap_attention.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_4

	var_1(var_1_14, var_1_15, var_1_16, var_1_4)

	local var_1_17 = {
		count = 0
	}

	DROP_TYPE_RESOURCE = var_1_10002
	var_1_17.type = var_1_10002
	var_1_17.id = arg_1_0.ptData.resId
	onButton = var_2

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.ptBtn

	local function var_1_20()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_SINGLE_ITEM = var_2_10004
		var_7_2.type = var_2_10004
		var_7_2.drop = var_1_17

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_7

	var_2(var_1_18, var_1_19, var_1_20, var_7)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	var_0_1.super.OnUpdateFlush(arg_8_0)

	local var_8_0 = arg_8_0.ptData
	local var_8_1, var_8_2, var_8_3 = var_1.GetResProgress(var_8_0)

	setText = var_1_10004

	local var_8_4 = arg_8_0.progress

	if 1 <= var_8_3 then
		setColorStr = var_7

		local var_8_5

		if not var_7(var_8_1, "#68E9F4FF") then
			var_8_5 = var_8_1
		end

		var_1_10004(var_8_4, var_8_5 .. "/" .. var_8_2)

		local var_8_6 = arg_8_0.ptData
		local var_8_7, var_8_8, var_8_9 = var_4.GetLevelProgress(var_8_6)

		if var_8_7 <= var_0_1.SpineActionByStep[1] then
			local var_8_10 = arg_8_0.shopAnim

			var_7.SetAction(var_8_10, "stand2", 0)
		elseif var_8_7 <= var_0_1.SpineActionByStep[2] then
			local var_8_11 = arg_8_0.shopAnim

			var_7.SetAction(var_8_11, "stand1", 0)
		elseif var_8_7 <= var_0_1.SpineActionByStep[3] then
			local var_8_12 = arg_8_0.shopAnim

			var_7.SetAction(var_8_12, "stand1x2", 0)
		elseif var_8_7 <= var_0_1.SpineActionByStep[4] then
			local var_8_13 = arg_8_0.shopAnim

			var_7.SetAction(var_8_13, "stand1x4", 0)
		elseif var_8_7 <= var_0_1.SpineActionByStep[5] then
			local var_8_14 = arg_8_0.shopAnim

			var_7.SetAction(var_8_14, "stand1x8", 0)
		end

		if not arg_8_0.showBubbleTag then
			arg_8_0:showBubble()

			arg_8_0.showBubbleTag = true
		end

		return
	end
end

function var_0_1.OnDestroy(arg_9_0)
	if arg_9_0.spineLRQ then
		local var_9_0 = arg_9_0.spineLRQ

		var_1.Stop(var_9_0)

		arg_9_0.spineLRQ = nil
	end

	if arg_9_0.spine then
		local var_9_1 = arg_9_0.spine.transform

		Vector3 = var_1_10002
		var_9_1.localScale = var_1_10002.one
		pg = var_9_1

		local var_9_2 = var_9_1.PoolMgr.GetInstance()

		var_1.ReturnSpineChar(var_9_2, "mingshi_5", arg_9_0.spine)

		arg_9_0.spine = nil
	end

	return
end

function var_0_1.showBubble(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_1 then
		isActive = var_1_10003

		if var_1_10003(arg_10_0.battleBtn) then
			i18n = var_1_10003
			var_10_0 = var_1_10003("sofmapsd_1")
		else
			isActive = var_1_10003

			if var_1_10003(arg_10_0.getBtn) then
				i18n = var_1_10003
				var_10_0 = var_1_10003("sofmapsd_2")
			else
				isActive = var_1_10003

				if var_1_10003(arg_10_0.gotBtn) then
					i18n = var_1_10003
					var_10_0 = var_1_10003("sofmapsd_4")
				end
			end
		end
	else
		var_10_0 = arg_10_1
	end

	setText = var_1_10003

	var_1_10003(arg_10_0.bubbleText, var_10_0)

	local function var_10_1(arg_11_0)
		local var_11_0 = arg_10_0.bubbleCG

		var_11_0.alpha = arg_11_0
		setLocalScale = var_11_0

		local var_11_1 = arg_10_0.bubble

		Vector3 = var_2_10004

		var_11_0(var_11_1, var_2_10004.one * arg_11_0)

		return
	end

	local function var_10_2()
		LeanTween = var_2_10000

		local var_12_0 = var_2_10000.value

		go = var_2_10002

		local var_12_1 = var_12_0(var_2_10002(arg_10_0.bubble), 1, 0, var_0_1.FADE_OUT_TIME)
		local var_12_2 = var_0.setOnUpdate

		System = var_3

		local var_12_3 = var_12_2(var_12_1, var_3.Action_float(var_10_1))
		local var_12_4 = var_0.setOnComplete

		System = var_3

		var_12_4(var_12_3, var_3.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_10_0.bubble, false)

			return
		end))

		return
	end

	LeanTween = var_5

	local var_10_3 = var_5.cancel

	go = var_1_10007

	var_10_3(var_1_10007(arg_10_0.bubble))

	setActive = var_10_3

	var_10_3(arg_10_0.bubble, true)

	LeanTween = var_10_3

	local var_10_4 = var_10_3.value

	go = var_7

	local var_10_5 = var_10_4(var_7(arg_10_0.bubble), 0, 1, var_0_1.FADE_TIME)
	local var_10_6 = var_5.setOnUpdate

	System = var_8

	local var_10_7 = var_10_6(var_10_5, var_8.Action_float(var_10_1))
	local var_10_8 = var_5.setOnComplete

	System = var_8

	var_10_8(var_10_7, var_8.Action(function()
		LeanTween = var_2_10000

		local var_14_0 = var_2_10000.delayedCall

		go = var_2_10002

		local var_14_1 = var_2_10002(arg_10_0.bubble)
		local var_14_2 = var_0_1.SHOW_TIME

		System = var_4

		var_14_0(var_14_1, var_14_2, var_4.Action(var_10_2))

		return
	end))

	return
end

return var_0_1
