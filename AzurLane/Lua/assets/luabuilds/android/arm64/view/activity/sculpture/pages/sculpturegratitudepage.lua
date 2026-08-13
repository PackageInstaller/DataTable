class = var_0_10000

local var_0_0 = "SculptureGratitudePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculptureGratitudeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.roleImg = var_1.Find(var_2_1, "char/Image")

	local var_2_2 = arg_2_0._tf

	arg_2_0.container = var_1.Find(var_2_2, "frame/gift")

	local var_2_3 = arg_2_0._tf

	arg_2_0.awards = var_1.Find(var_2_3, "frame/awards")

	local var_2_4 = arg_2_0._tf

	arg_2_0.giftBg = var_1.Find(var_2_4, "frame/Image")

	local var_2_5 = arg_2_0._tf

	arg_2_0.wordTxtScr = var_1.Find(var_2_5, "frame/scrollrect")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/scrollrect/content/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.wordTxt = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "frame/scrollrect/content/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Typewriter = var_1_10006
	arg_2_0.typer = var_2_11(var_2_10, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_12 = var_1.New
	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "frame/awards")
	local var_2_15 = arg_2_0._tf

	arg_2_0.uilist = var_2_12(var_2_14, var_4.Find(var_2_15, "frame/awards/tpl"))

	local var_2_16 = arg_2_0._tf

	arg_2_0.arrLeft = var_1.Find(var_2_16, "frame/arr")

	local var_2_17 = arg_2_0._tf

	arg_2_0.arrRight = var_1.Find(var_2_17, "frame/arr (1)")

	return
end

function var_0_1.OnInit(arg_3_0)
	return
end

function var_0_1.Show(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:Clear()

	setText = var_4

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_6.Find(var_4_0, "tip")

	i18n = var_1_10007

	var_4(var_4_1, var_1_10007("sculpture_gratitude_tip"))
	var_0_1.super.Show(arg_4_0)

	setActive = var_4

	var_4(arg_4_0.giftBg, true)

	setAnchoredPosition = var_4

	var_4(arg_4_0.arrLeft, {
		x = 338
	})

	setAnchoredPosition = var_4

	var_4(arg_4_0.arrRight, {
		x = 675
	})

	if arg_4_3 then
		arg_4_3()
	end

	arg_4_0.id = arg_4_1
	arg_4_0.activity = arg_4_2

	arg_4_0:SetScrollTxt(arg_4_2:getDataConfig(arg_4_0.id, "words"))

	seriesAsync = var_4

	var_4({
		function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.LoadChar(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.LoadSculpture(var_6_0, arg_6_0)

			return
		end
	}, function()
		local var_7_0 = arg_4_0

		var_0.RegisterEvent(var_7_0)

		return
	end)

	pg = var_4

	local var_4_2 = var_4.BgmMgr.GetInstance()

	var_4.Push(var_4_2, arg_4_0.__cname, "story-richang-8")

	return
end

function var_0_1.Flush(arg_8_0, arg_8_1)
	arg_8_0.activity = arg_8_1

	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_2.GetSculptureState(var_8_0, arg_8_0.id)

	SculptureActivity = var_1_10003

	if var_8_1 == var_1_10003.STATE_FINSIH then
		arg_8_0:Clear()

		local var_8_2, var_8_3, var_8_4 = arg_8_0:State2CharNameAndActionName(var_8_1)

		arg_8_0:UpdateRole(var_8_2, var_8_3, var_8_4)

		setActive = var_6

		var_6(arg_8_0.container, false)

		setActive = var_6

		var_6(arg_8_0.awards, true)
		arg_8_0:InitAwards()
		arg_8_0:SetScrollTxt(arg_8_1:getDataConfig(arg_8_0.id, "thankwords"))

		setText = var_6

		local var_8_5 = arg_8_0._tf

		var_6(var_8.Find(var_8_5, "tip"), "")

		setActive = var_6

		var_6(arg_8_0.giftBg, false)

		setAnchoredPosition = var_6

		var_6(arg_8_0.arrLeft, {
			x = 260
		})

		setAnchoredPosition = var_6

		var_6(arg_8_0.arrRight, {
			x = 745
		})
	end

	return
end

function var_0_1.SetScrollTxt(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.typer

	var_2.setSpeed(var_9_0, 31)

	local var_9_1 = arg_9_0.wordTxt

	HXSet = var_1_10003
	var_9_1.text = var_1_10003.hxLan(arg_9_1)

	local var_9_2 = arg_9_0.typer

	var_2.setSpeed(var_9_2, 0.06)

	function arg_9_0.typer.endFunc()
		local var_10_0 = arg_9_0

		var_0.RemoveTimer(var_10_0)

		return
	end

	local var_9_3 = arg_9_0.typer

	var_2.Play(var_9_3)
	arg_9_0:RemoveTimer()

	Timer = var_2
	arg_9_0.timer = var_2.New(function()
		scrollToBottom = var_2_10000

		var_2_10000(arg_9_0.wordTxtScr)

		return
	end, 0.1, -1)

	local var_9_4 = arg_9_0.timer

	var_2.Start(var_9_4)

	return
end

function var_0_1.RemoveTimer(arg_12_0)
	if arg_12_0.timer then
		local var_12_0 = arg_12_0.timer

		var_1.Stop(var_12_0)

		arg_12_0.timer = nil
	end

	return
end

function var_0_1.InitAwards(arg_13_0)
	local var_13_0 = arg_13_0.activity
	local var_13_1 = var_1.getDataConfig(var_13_0, arg_13_0.id, "reward_display")
	local var_13_2 = arg_13_0.uilist

	var_2.make(var_13_2, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_13_1[arg_14_1 + 1]
			local var_14_1 = {
				type = var_14_0[1],
				id = var_14_0[2],
				count = var_14_0[3]
			}

			updateDrop = var_5

			var_5(arg_14_2, var_14_1)

			onButton = var_5

			local var_14_2 = arg_13_0
			local var_14_3 = arg_14_2

			local function var_14_4()
				local var_15_0 = arg_13_0
				local var_15_1 = var_0.emit

				BaseUI = var_3_10003

				var_15_1(var_15_0, var_3_10003.ON_DROP, var_14_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_14_2, var_14_3, var_14_4, var_2_10010)
		end

		return
	end)

	local var_13_3 = arg_13_0.uilist

	var_2.align(var_13_3, #var_13_1)

	return
end

function var_0_1.LoadChar(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.activity
	local var_16_1 = var_2.GetSculptureState(var_16_0, arg_16_0.id)
	local var_16_2, var_16_3, var_16_4 = arg_16_0:State2CharNameAndActionName(var_16_1)

	arg_16_0:UpdateRole(var_16_2, var_16_3, var_16_4, arg_16_1)

	return
end

function var_0_1.State2CharNameAndActionName(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.activity
	local var_17_1 = var_2.GetResorceName(var_17_0, arg_17_0.id)

	SculptureActivity = var_1_10003

	if arg_17_1 == var_1_10003.STATE_FINSIH then
		return var_17_1, "gift_get_", "take_wait_"
	else
		return var_17_1, "gift_wait_"
	end

	return
end

function var_0_1.LoadSculpture(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.activity
	local var_18_1 = var_2.GetResorceName(var_18_0, arg_18_0.id)

	ResourceMgr = var_1_10003

	local var_18_2 = var_1_10003.Inst
	local var_18_3 = var_3.getAssetAsync
	local var_18_4 = "ui/" .. var_18_1 .. "_puzzle_whole"
	local var_18_5 = ""

	UnityEngine = var_8

	var_18_3(var_18_2, var_18_4, var_18_5, var_8.Events.UnityAction_UnityEngine_Object(function(arg_19_0)
		Object = var_2_10001

		local var_19_0 = var_2_10001.Instantiate(arg_19_0, arg_18_0.container).transform
		local var_19_1 = arg_18_0.activity

		var_19_0.localScale = var_3.GetScale(var_19_1, arg_18_0.id)

		local var_19_2 = arg_18_0

		var_2.InitSculpture(var_19_2, var_1.transform)

		arg_18_0.puzzle = var_1

		arg_18_1()

		return
	end), true, true)

	return
end

function var_0_1.InitSculpture(arg_20_0, arg_20_1)
	GetOrAddComponent = var_1_10002

	local var_20_0 = arg_20_1

	typeof = var_1_10005
	EventTriggerListener = var_1_10007

	local var_20_1 = var_1_10002(var_20_0, var_1_10005(var_1_10007))
	local var_20_2

	var_20_1:AddBeginDragFunc(function()
		local var_21_0 = arg_20_1

		var_0.SetAsLastSibling(var_21_0)

		var_20_2 = arg_20_1.localPosition

		return
	end)
	var_20_1:AddDragFunc(function(arg_22_0, arg_22_1)
		Screen2Local = var_2_10002

		local var_22_0 = var_2_10002(arg_20_1.parent, arg_22_1.position)

		arg_20_1.localPosition = var_22_0

		return
	end)
	var_20_1:AddDragEndFunc(function(arg_23_0, arg_23_1)
		local var_23_0 = arg_20_0.roleImg.gameObject.transform

		getBounds = var_2_10003

		local var_23_1 = var_2_10003(var_23_0)

		getBounds = var_2_10004

		local var_23_2 = var_2_10004(arg_20_1)

		if var_23_1:Intersects(var_23_2) then
			local var_23_3 = arg_20_1

			TrPosition2LocalPos = var_6
			var_23_3.localPosition = var_6(var_23_0.parent, arg_20_1.parent, var_23_0.localPosition)

			local var_23_4 = arg_20_0
			local var_23_5 = var_5.emit

			SculptureMediator = var_8

			var_23_5(var_23_4, var_8.ON_FINSIH_SCULPTURE, arg_20_0.id)
		else
			arg_20_1.localPosition = var_20_2
		end

		return
	end)

	return
end

function var_0_1.UpdateRole(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_0.charName == arg_24_1 then
		return
	end

	arg_24_0:ClearChar()

	PoolMgr = var_5

	local var_24_0 = var_5.GetInstance()

	var_5.GetSpineChar(var_24_0, "takegift_" .. arg_24_1, true, function(arg_25_0)
		local var_25_0 = arg_25_0.transform

		var_1.SetParent(var_25_0, arg_24_0.roleImg.gameObject.transform.parent)

		local var_25_1 = arg_25_0.transform

		Vector3 = var_2_10002
		var_25_1.localScale = var_2_10002(1, 1, 0)

		local var_25_2 = arg_25_0.transform

		Vector3 = var_2
		var_25_2.localPosition = var_2(0, 0, 0)

		local var_25_3 = arg_25_0
		local var_25_4 = arg_25_0.GetComponent

		typeof = var_4
		SpineAnimUI = var_6

		local var_25_5 = var_25_4(var_25_3, var_4(var_6))

		var_1.SetAction(var_25_5, arg_24_2 .. arg_24_1, 0)

		if arg_24_3 then
			var_1:SetActionCallBack(function(arg_26_0)
				if arg_26_0 == "finish" then
					local var_26_0 = var_0

					var_1.SetActionCallBack(var_26_0, nil)

					local var_26_1 = var_0

					var_1.SetAction(var_26_1, arg_24_3 .. arg_24_1, 0)
				end

				return
			end)
		end

		arg_24_0.spineAnimUI = var_1
		arg_24_0.charGo = arg_25_0

		if arg_24_4 then
			arg_24_4()
		end

		return
	end)

	arg_24_0.charName = arg_24_1

	return
end

function var_0_1.ClearChar(arg_27_0)
	if arg_27_0.charName and arg_27_0.charGo then
		if arg_27_0.spineAnimUI then
			local var_27_0 = arg_27_0.spineAnimUI

			var_1.SetActionCallBack(var_27_0, nil)

			arg_27_0.spineAnimUI = nil
		end

		PoolMgr = var_1

		local var_27_1 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_27_1, arg_27_0.charName, arg_27_0.charGo)

		arg_27_0.charName = nil
		arg_27_0.charGo = nil
	end

	return
end

function var_0_1.RegisterEvent(arg_28_0)
	onButton = var_1_10001

	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.backBtn

	local function var_28_2()
		local var_29_0 = arg_28_0

		var_0.Hide(var_29_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_28_0, var_28_1, var_28_2, var_1_10006)

	return
end

function var_0_1.Clear(arg_30_0)
	if arg_30_0.puzzle then
		local var_30_0 = arg_30_0.puzzle
		local var_30_1 = var_1.GetComponent

		typeof = var_1_10004
		EventTriggerListener = var_1_10006

		local var_30_2 = var_30_1(var_30_0, var_1_10004(var_1_10006))

		ClearEventTrigger = var_1_10002

		var_1_10002(var_30_2)

		Object = var_1_10002

		var_1_10002.Destroy(arg_30_0.puzzle.gameObject)

		arg_30_0.puzzle = nil
	end

	arg_30_0:ClearChar()

	setActive = var_1

	var_1(arg_30_0.container, true)

	setActive = var_1

	var_1(arg_30_0.awards, false)

	return
end

function var_0_1.Hide(arg_31_0)
	var_0_1.super.Hide(arg_31_0)

	pg = var_1

	local var_31_0 = var_1.BgmMgr.GetInstance()

	var_1.Pop(var_31_0, arg_31_0.__cname)
	arg_31_0:RemoveTimer()

	return
end

function var_0_1.OnDestroy(arg_32_0)
	arg_32_0:Clear()

	return
end

return var_0_1
