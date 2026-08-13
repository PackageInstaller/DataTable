class = var_0_10000

local var_0_0 = "CommanderReservePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderReserveUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg1 = var_1.Find(var_2_0, "frame/bg1")
	setActive = var_1

	var_1(arg_2_0.bg1, true)

	local var_2_1 = arg_2_0.bg1

	arg_2_0.minusBtn = var_1.Find(var_2_1, "count/min")

	local var_2_2 = arg_2_0.bg1

	arg_2_0.addBtn = var_1.Find(var_2_2, "count/add")

	local var_2_3 = arg_2_0.bg1
	local var_2_4 = var_1.Find(var_2_3, "count/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.countTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0.bg1
	local var_2_7 = var_1.Find(var_2_6, "price/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.consumeTxt = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0.bg1
	local var_2_10 = var_1.Find(var_2_9, "price_all/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.totalTxt = var_2_11(var_2_10, var_4(var_1_10006))

	local var_2_12 = arg_2_0.bg1

	arg_2_0.firstTip = var_1.Find(var_2_12, "firstTip")

	local var_2_13 = arg_2_0.bg1

	arg_2_0.confirmBtn = var_1.Find(var_2_13, "Button")

	local var_2_14 = arg_2_0.bg1

	arg_2_0.maxBtn = var_1.Find(var_2_14, "max")

	local var_2_15 = arg_2_0._tf

	arg_2_0.bg2 = var_1.Find(var_2_15, "frame/bg2")

	local var_2_16 = arg_2_0.bg2
	local var_2_17 = var_1.Find(var_2_16, "boxes/1")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.box1 = var_2_18(var_2_17, var_4(var_1_10006))

	local var_2_19 = arg_2_0.bg2
	local var_2_20 = var_1.Find(var_2_19, "boxes/2")
	local var_2_21 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.box2 = var_2_21(var_2_20, var_4(var_1_10006))

	local var_2_22 = arg_2_0.bg2
	local var_2_23 = var_1.Find(var_2_22, "boxes/3")
	local var_2_24 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.box3 = var_2_24(var_2_23, var_4(var_1_10006))

	local var_2_25 = arg_2_0.bg2
	local var_2_26 = var_1.Find(var_2_25, "boxes/4")
	local var_2_27 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.box4 = var_2_27(var_2_26, var_4(var_1_10006))

	local var_2_28 = arg_2_0.bg2

	arg_2_0.skipBtn = var_1.Find(var_2_28, "Button")

	local var_2_29 = arg_2_0.bg2
	local var_2_30 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.animtion = var_2_30(var_2_29, var_4(var_1_10006))

	local var_2_31 = arg_2_0.bg2
	local var_2_32 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.aniEvt = var_2_32(var_2_31, var_4(var_1_10006))

	local var_2_33 = arg_2_0.bg2

	arg_2_0.boxes = var_1.Find(var_2_33, "boxes")

	local var_2_34 = arg_2_0._tf

	arg_2_0.closeBg = var_1.Find(var_2_34, "bg")

	local var_2_35 = arg_2_0.bg2

	arg_2_0.boxTF = var_1.Find(var_2_35, "box")

	local var_2_36 = arg_2_0.bg2

	arg_2_0.boxMove = var_1.Find(var_2_36, "boxMove")
	arg_2_0.tweenList = {}
	setActive = var_1

	var_1(arg_2_0.bg2, false)

	arg_2_0.skip = false
	arg_2_0.block = false
	onButton = var_1

	local var_2_37 = arg_2_0
	local var_2_38 = arg_2_0.closeBg

	local function var_2_39()
		if arg_2_0.block then
			return
		end

		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_37, var_2_38, var_2_39, var_1_10006)

	pressPersistTrigger = var_1

	local var_2_40 = arg_2_0.minusBtn
	local var_2_41 = 0.5

	local function var_2_42(arg_4_0)
		if arg_2_0.currCnt == 1 then
			arg_4_0()

			return
		end

		arg_2_0.currCnt = arg_2_0.currCnt - 1

		local var_4_0 = arg_2_0

		var_1.updateValue(var_4_0)

		return
	end

	local var_2_43
	local var_2_44 = true
	local var_2_45 = true
	local var_2_46 = 0.1

	SFX_PANEL = var_1_10010

	var_1(var_2_40, var_2_41, var_2_42, var_2_43, var_2_44, var_2_45, var_2_46, var_1_10010)

	pressPersistTrigger = var_1

	local var_2_47 = arg_2_0.addBtn
	local var_2_48 = 0.5

	local function var_2_49(arg_5_0)
		local var_5_0 = arg_2_0.currCnt

		CommanderConst = var_2_10002

		if var_5_0 > var_2_10002.MAX_GETBOX_CNT - arg_2_0.count - 1 then
			arg_5_0()

			return
		end

		arg_2_0.currCnt = arg_2_0.currCnt + 1

		local var_5_1 = arg_2_0

		var_1.updateValue(var_5_1)

		return
	end

	local var_2_50
	local var_2_51 = true
	local var_2_52 = true
	local var_2_53 = 0.1

	SFX_PANEL = var_1_10010

	var_1(var_2_47, var_2_48, var_2_49, var_2_50, var_2_51, var_2_52, var_2_53, var_1_10010)

	onButton = var_1

	local var_2_54 = arg_2_0
	local var_2_55 = arg_2_0.skipBtn

	local function var_2_56()
		arg_2_0.skip = true

		local var_6_0 = arg_2_0.animtion

		var_0.Stop(var_6_0)

		local var_6_1 = arg_2_0

		var_0.endAnim(var_6_1)

		return
	end

	SFX_PANEL = var_2_50

	var_1(var_2_54, var_2_55, var_2_56, var_2_50)

	onButton = var_1

	local var_2_57 = arg_2_0
	local var_2_58 = arg_2_0.maxBtn

	local function var_2_59()
		CommanderConst = var_2_10000

		local var_7_0 = var_2_10000.MAX_GETBOX_CNT - arg_2_0.count

		getProxy = var_1
		PlayerProxy = var_2_10003

		local var_7_1 = var_1(var_2_10003)
		local var_7_2 = var_1.getRawData(var_7_1)
		local var_7_3 = var_1.getResById(var_7_2, 1)
		local var_7_4 = 0
		local var_7_5 = 0
		local var_7_6 = arg_2_0.count + var_7_0

		for iter_7_0 = arg_2_0.count, var_7_6 - 1 do
			CommanderConst = var_2_10009

			if var_7_3 < var_7_5 + var_2_10009.getBoxComsume(iter_7_0) then
				break
			else
				var_7_4 = var_7_4 + 1
			end
		end

		local var_7_7 = arg_2_0

		math = var_6
		var_7_7.currCnt = var_6.max(1, var_7_4)

		local var_7_8 = arg_2_0

		var_5.updateValue(var_7_8)

		return
	end

	SFX_PANEL = var_2_50

	var_1(var_2_57, var_2_58, var_2_59, var_2_50)

	onButton = var_1

	local var_2_60 = arg_2_0
	local var_2_61 = arg_2_0.confirmBtn

	local function var_2_62()
		if arg_2_0.currCnt > 0 then
			arg_2_0.skip = false

			local var_8_0 = arg_2_0

			var_0.OnConfirm(var_8_0, arg_2_0.total, arg_2_0.currCnt)
		end

		return
	end

	SFX_PANEL = var_2_50

	var_1(var_2_60, var_2_61, var_2_62, var_2_50)

	setText = var_1

	local var_2_63 = arg_2_0._tf
	local var_2_64 = var_3.Find(var_2_63, "frame/bg1/tip")

	i18n = var_2_61

	var_1(var_2_64, var_2_61("commander_build_rate_tip"))

	setText = var_1

	local var_2_65 = arg_2_0._tf
	local var_2_66 = var_3.Find(var_2_65, "frame/bg1/label")

	i18n = var_4

	var_1(var_2_66, var_4("commander_get_box_tip"))

	setText = var_1

	local var_2_67 = arg_2_0._tf
	local var_2_68 = var_3.Find(var_2_67, "frame/bg1/label1")

	i18n = var_4

	var_1(var_2_68, var_4("commander_total_gold"))

	setText = var_1

	local var_2_69 = arg_2_0._tf
	local var_2_70 = var_3.Find(var_2_69, "frame/bg1/Text")

	i18n = var_4

	var_1(var_2_70, var_4("commander_get_box_tip_1"))

	return
end

function var_0_1.OnConfirm(arg_9_0, arg_9_1, arg_9_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_9_0 = var_1_10003(var_1_10005)

	if arg_9_1 > var_3.getRawData(var_9_0).gold then
		local var_9_1 = arg_9_0
		local var_9_2 = arg_9_0.GoShoppingMsgBox

		i18n = var_1_10007

		local var_9_3 = "switch_to_shop_tip_2"

		i18n = var_1_10010

		local var_9_4 = var_1_10007(var_9_3, var_1_10010("word_gold"))

		ChargeScene = var_1_10008

		var_9_2(var_9_1, var_9_4, var_1_10008.TYPE_ITEM, {
			{
				59001,
				arg_9_1 - var_3.gold,
				arg_9_1
			}
		})

		return
	end

	local var_9_5 = arg_9_1 <= 0 and "commander_get_1" or "commander_get"
	local var_9_6 = arg_9_0.contextData.msgBox
	local var_9_7 = var_5.ExecuteAction
	local var_9_8 = "Show"
	local var_9_9 = {}

	i18n = var_1_10010
	var_9_9.content = var_1_10010(var_9_5, arg_9_1, arg_9_2)

	function var_9_9.onYes()
		local var_10_0 = arg_9_0
		local var_10_1 = var_0.emit

		CommanderCatMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.RESERVE_BOX, arg_9_2)

		return
	end

	var_9_7(var_9_6, var_9_8, var_9_9)

	return
end

function var_0_1.GoShoppingMsgBox(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 then
		var_1_10004 = ""
		ipairs = var_1_10005

		for iter_11_0, iter_11_1 in var_1_10005(arg_11_3) do
			Item = var_1_10010
			var_1_10010 = var_1_10010.getConfigData(iter_11_1[1]).name

			local var_11_0 = var_1_10004

			i18n = var_12
			var_1_10004 = var_11_0 .. var_12(iter_11_1[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", var_1_10010, iter_11_1[2])

			if iter_11_0 < #arg_11_3 then
				local var_11_1 = var_1_10004

				i18n = var_12
				var_1_10004 = var_11_1 .. var_12("text_noRes_info_tip_link")
			end
		end

		if var_1_10004 ~= "" then
			local var_11_2 = arg_11_1
			local var_11_3 = "\n"

			i18n = var_7
			arg_11_1 = var_11_2 .. var_11_3 .. var_7("text_noRes_tip", var_1_10004)
		end
	end

	pg = var_1_10004

	local var_11_4 = var_1_10004.MsgboxMgr.GetInstance()
	local var_11_5 = var_4.ShowMsgBox
	local var_11_6 = {}

	rtf = iter_11_0
	pg = var_1_10010
	var_11_6.parent = iter_11_0(var_1_10010.UIMgr.GetInstance().OverlayToast)
	var_11_6.content = arg_11_1

	function var_11_6.onYes()
		gotoChargeScene = var_2_10000

		var_2_10000(arg_11_2, arg_11_3)

		return
	end

	var_11_5(var_11_4, var_11_6)

	return
end

function var_0_1.OnLoaded(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.bind

	CommanderCatScene = var_1_10004

	var_13_1(var_13_0, var_1_10004.MSG_RESERVE_BOX, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0

		var_2.OnReserveDone(var_14_0, arg_14_1)

		return
	end)

	return
end

function var_0_1.OnReserveDone(arg_15_0, arg_15_1)
	arg_15_0.block = true
	seriesAsync = var_2

	var_2({
		function(arg_16_0)
			local var_16_0 = arg_15_0

			var_1.PlayAnim(var_16_0, arg_15_1, arg_16_0)

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_15_0

			var_1.Update(var_17_0)

			local var_17_1 = arg_15_0
			local var_17_2 = var_1.emit

			BaseUI = var_2_10004

			var_17_2(var_17_1, var_2_10004.ON_AWARD, {
				items = arg_15_1
			})
			arg_17_0()

			return
		end
	}, function()
		arg_15_0.block = false

		return
	end)

	return
end

function var_0_1.updateValue(arg_19_0)
	arg_19_0.countTxt.text = arg_19_0.currCnt

	local var_19_0 = arg_19_0.count + arg_19_0.currCnt - 1

	CommanderConst = var_2

	local var_19_1 = var_2.getBoxComsume(var_19_0)

	arg_19_0.consumeTxt.text = var_19_1
	arg_19_0.total = 0

	for iter_19_0 = arg_19_0.count, var_19_0 do
		local var_19_2 = arg_19_0.total

		CommanderConst = var_1_10008
		arg_19_0.total = var_19_2 + var_1_10008.getBoxComsume(iter_19_0)
	end

	getProxy = var_3
	PlayerProxy = var_5

	local var_19_3 = var_3(var_5)
	local var_19_4 = var_3.getRawData(var_19_3)
	local var_19_5 = arg_19_0.totalTxt

	if var_19_4.gold < arg_19_0.total then
		local var_19_6 = "<color="

		COLOR_RED = var_6

		local var_19_7

		if not (var_19_6 .. var_6 .. ">" .. arg_19_0.total .. "</color>") then
			var_19_7 = arg_19_0.total
		end

		var_19_5.text = var_19_7

		return
	end
end

function var_0_1.Update(arg_20_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)

	arg_20_0.count = var_1.getBoxUseCnt(var_20_0)
	arg_20_0.currCnt = 1
	arg_20_0.total = 0

	arg_20_0:updateValue()

	setActive = var_1

	var_1(arg_20_0.firstTip, arg_20_0.count <= 0)
	arg_20_0:Show()

	return
end

function var_0_1.endAnim(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.bg1, true)

	setActive = var_1_10001

	var_1_10001(arg_21_0.bg2, false)

	for iter_21_0 = 0, arg_21_0.boxMove.childCount - 1 do
		local var_21_0 = arg_21_0.boxMove
		local var_21_1 = var_5.GetChild(var_21_0, iter_21_0)

		Destroy = var_1_10006

		var_1_10006(var_21_1)
	end

	ipairs = var_1

	for iter_21_1, iter_21_2 in var_1(arg_21_0.tweenList) do
		if iter_21_2 then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_21_2)
		end
	end

	arg_21_0.tweenList = {}
	arg_21_0.skip = false

	if arg_21_0.callback then
		arg_21_0.callback()

		arg_21_0.callback = nil
	end

	return
end

function var_0_1.PlayAnim(arg_22_0, arg_22_1, arg_22_2)
	assert = var_1_10003

	var_1_10003(arg_22_2)

	arg_22_0.callback = arg_22_2
	setActive = var_1_10003

	var_1_10003(arg_22_0.bg1, false)

	setActive = var_1_10003

	var_1_10003(arg_22_0.bg2, true)

	setActive = var_1_10003

	var_1_10003(arg_22_0.boxes, true)

	if arg_22_0.skip then
		arg_22_0:endAnim()
	else
		local var_22_0 = arg_22_0.animtion

		var_3.Play(var_22_0, "reserve")

		local var_22_1 = 0
		local var_22_2 = 0
		local var_22_3 = arg_22_0.aniEvt

		var_5.SetTriggerEvent(var_22_3, function(arg_23_0)
			ipairs = var_2_10001

			for iter_23_0, iter_23_1 in var_2_10001(arg_22_1) do
				var_22_1 = var_22_1 + iter_23_0
			end

			ipairs = var_1

			for iter_23_2, iter_23_3 in var_1(arg_22_1) do
				for iter_23_4 = 1, iter_23_3.count do
					LeanTween = var_2_10010
					var_2_10010 = var_2_10010.delayedCall

					local var_23_0 = 0.2 + 1 * var_22_2 + 1 * (iter_23_4 - 1)

					System = var_13
					var_2_10010 = var_2_10010(var_23_0, var_13.Action(function()
						local var_24_0 = arg_22_0

						var_0.playBoxMove(var_24_0, iter_23_3)

						return
					end)).uniqueId
					table = var_2_10011

					var_2_10011.insert(arg_22_0.tweenList, var_2_10010)
				end

				var_22_2 = var_22_2 + iter_23_3.count
			end

			table = var_1

			local var_23_1 = var_1.insert
			local var_23_2 = arg_22_0.tweenList

			LeanTween = iter_23_2

			local var_23_3 = iter_23_2.delayedCall
			local var_23_4 = 0.2 + 1 * (var_22_2 - 1)

			System = var_2_10007

			var_23_1(var_23_2, var_23_3(var_23_4, var_2_10007.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_22_0.boxes, false)

				return
			end)).uniqueId)

			table = var_23_1

			local var_23_5 = var_23_1.insert
			local var_23_6 = arg_22_0.tweenList

			LeanTween = var_4

			local var_23_7 = var_4.delayedCall
			local var_23_8 = 0.2 + 1 * (var_22_2 - 1) + 2

			System = var_7

			var_23_5(var_23_6, var_23_7(var_23_8, var_7.Action(function()
				local var_26_0 = arg_22_0

				var_0.endAnim(var_26_0)

				return
			end)).uniqueId)

			return
		end)
	end

	return
end

function var_0_1.Show(arg_27_0)
	setActive = var_1_10001

	var_1_10001(arg_27_0._tf, true)

	setActive = var_1_10001

	var_1_10001(arg_27_0.bg1, true)

	setActive = var_1_10001

	var_1_10001(arg_27_0.bg2, false)

	arg_27_0.skip = false
	pg = var_1

	local var_27_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_27_0, arg_27_0._tf)

	return
end

function var_0_1.Hide(arg_28_0)
	var_0_1.super.Hide(arg_28_0)

	pg = var_1

	local var_28_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_28_0, arg_28_0._tf, arg_28_0._parentTf)

	return
end

function var_0_1.playBoxMove(arg_29_0, arg_29_1)
	cloneTplTo = var_1_10002

	local var_29_0 = var_1_10002(arg_29_0.boxTF, arg_29_0.boxMove)

	if arg_29_1.id == 20011 then
		local var_29_1 = var_29_0
		local var_29_2 = var_29_0.GetComponent

		typeof = var_1_10006
		Image = var_1_10008
		var_29_2(var_29_1, var_1_10006(var_1_10008)).sprite = arg_29_0.box1.sprite
	elseif arg_29_1.id == 20012 then
		local var_29_3 = var_29_0
		local var_29_4 = var_29_0.GetComponent

		typeof = var_1_10006
		Image = var_1_10008
		var_29_4(var_29_3, var_1_10006(var_1_10008)).sprite = arg_29_0.box2.sprite
	elseif arg_29_1.id == 20013 then
		local var_29_5 = var_29_0
		local var_29_6 = var_29_0.GetComponent

		typeof = var_1_10006
		Image = var_1_10008
		var_29_6(var_29_5, var_1_10006(var_1_10008)).sprite = arg_29_0.box3.sprite
	end

	local var_29_7 = var_29_0
	local var_29_8 = var_29_0.GetComponent

	typeof = var_1_10006
	DftAniEvent = var_1_10008

	local var_29_9 = var_29_8(var_29_7, var_1_10006(var_1_10008))

	var_3.SetEndEvent(var_29_9, function()
		Destroy = var_2_10000
		go = var_2_10002

		var_2_10000(var_2_10002(var_29_0))

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_31_0)
	if arg_31_0:isShowing() then
		arg_31_0:Hide()
	end

	return
end

return var_0_1
