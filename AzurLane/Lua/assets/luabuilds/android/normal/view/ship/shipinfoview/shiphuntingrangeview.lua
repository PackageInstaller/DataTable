class = var_0_10000

local var_0_0 = "ShipHuntingRangeView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShipHuntingRangeView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0.huntingRange = arg_2_0._tf
	setActive = var_1

	var_1(arg_2_0.huntingRange, false)

	local var_2_0 = arg_2_0.huntingRange

	arg_2_0.curLevel = var_1.Find(var_2_0, "frame/current_level")

	local var_2_1 = arg_2_0.huntingRange

	arg_2_0.showLevel = var_1.Find(var_2_1, "frame/level/Text")

	local var_2_2 = arg_2_0.huntingRange

	arg_2_0.tips = var_1.Find(var_2_2, "frame/tips")

	local var_2_3 = arg_2_0.huntingRange

	arg_2_0.closeBtn = var_1.Find(var_2_3, "frame/close_btn")

	local var_2_4 = arg_2_0.huntingRange

	arg_2_0.helpBtn = var_1.Find(var_2_4, "frame/help")

	local var_2_5 = arg_2_0.huntingRange

	arg_2_0.cellRoot = var_1.Find(var_2_5, "frame/range")
	arg_2_0.onSelected = false

	return
end

function var_0_1.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_1.GetShipVO(arg_4_0)
	if arg_4_0.shareData and arg_4_0.shareData.shipVO then
		return arg_4_0.shareData.shipVO
	end

	return nil
end

function var_0_1.DisplayHuntingRange(arg_5_0)
	arg_5_0.onSelected = true

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetShipVO(var_5_0)

	setActive = var_5_0

	var_5_0(arg_5_0.huntingRange, true)
	arg_5_0:UpdateHuntingRange(var_5_1, var_5_1:getHuntingLv())

	setText = var_2

	local var_5_2 = arg_5_0.curLevel
	local var_5_3 = "Lv."
	local var_5_4 = var_5_1

	var_2(var_5_2, var_5_3 .. var_5_1.getHuntingLv(var_5_4))

	setText = var_2

	local var_5_5 = arg_5_0.tips

	i18n = var_4

	var_2(var_5_5, var_4("ship_hunting_level_tips"))

	onButton = var_2

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.closeBtn

	local function var_5_8()
		local var_6_0 = arg_5_0

		var_0.HideHuntingRange(var_6_0)

		return
	end

	SFX_CANCEL = var_5_4

	var_2(var_5_6, var_5_7, var_5_8, var_5_4)

	onButton = var_2

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.helpBtn

	local function var_5_11()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_7_2.type = var_2_10003
		pg = var_2_10003
		var_7_2.helps = var_2_10003.gametip.help_shipinfo_hunting.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_5_4

	var_2(var_5_9, var_5_10, var_5_11, var_5_4)

	pg = var_2

	local var_5_12 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_5_12, arg_5_0.huntingRange)

	return
end

function var_0_1.UpdateHuntingRange(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.cellRoot

	for iter_8_0 = 0, var_8_0.childCount - 1 do
		local var_8_1 = var_8_0
		local var_8_2 = var_8_0.GetChild(var_8_1, iter_8_0)

		setActive = var_8_1

		var_8_1(var_8_2:Find("activate"), false)
	end

	local var_8_3 = arg_8_1
	local var_8_4 = arg_8_1.getHuntingRange(var_8_3, arg_8_2)

	_ = var_8_3

	var_8_3.each(var_8_4, function(arg_9_0)
		local var_9_0 = arg_9_0[1]
		local var_9_1 = arg_9_0[2]
		local var_9_2 = var_9_0 * 7 + var_9_1

		math = var_2_10004

		local var_9_3 = var_9_2 + var_2_10004.floor(24.5)
		local var_9_4 = var_8_0

		if var_4.GetChild(var_9_4, var_9_3) and var_9_3 ~= 24 then
			setActive = var_9_4

			var_9_4(var_4:Find("activate"), true)
		end

		return
	end)

	local var_8_5 = arg_8_0.huntingRange
	local var_8_6 = var_5.Find(var_8_5, "frame/last")
	local var_8_7 = arg_8_0.huntingRange
	local var_8_8 = var_6.Find(var_8_7, "frame/next")

	setActive = var_8_7

	var_8_7(var_8_6, arg_8_2 > 1)

	setActive = var_8_7

	var_8_7(var_8_8, arg_8_2 < #arg_8_1:getConfig("hunting_range"))

	setText = var_8_7

	var_8_7(arg_8_0.showLevel, "Lv." .. arg_8_2)

	onButton = var_8_7

	local var_8_9 = arg_8_0
	local var_8_10 = var_8_6

	local function var_8_11()
		local var_10_1

		if arg_8_2 - 1 == 0 then
			local var_10_0 = arg_8_1

			var_10_1 = #var_1.getConfig(var_10_0, "hunting_range")
		end

		local var_10_2 = arg_8_0

		var_1.UpdateHuntingRange(var_10_2, arg_8_1, var_10_1)

		return
	end

	SFX_PANEL = var_11

	var_8_7(var_8_9, var_8_10, var_8_11, var_11)

	onButton = var_8_7

	local var_8_12 = arg_8_0
	local var_8_13 = var_8_8

	local function var_8_14()
		local var_11_0 = arg_8_2 + 1
		local var_11_1 = arg_8_1

		if var_11_0 == #var_1.getConfig(var_11_1, "hunting_range") + 1 then
			var_11_0 = 1
		end

		local var_11_2 = arg_8_0

		var_1.UpdateHuntingRange(var_11_2, arg_8_1, var_11_0)

		return
	end

	SFX_PANEL = var_11

	var_8_7(var_8_12, var_8_13, var_8_14, var_11)

	return
end

function var_0_1.HideHuntingRange(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.huntingRange, false)

	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0.huntingRange, arg_12_0._tf)

	arg_12_0.onSelected = false

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0:HideHuntingRange()

	arg_13_0.shareData = nil

	return
end

return var_0_1
