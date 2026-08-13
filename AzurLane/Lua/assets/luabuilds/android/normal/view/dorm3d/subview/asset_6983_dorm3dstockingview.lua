class = var_0_10000

local var_0_0 = "Dorm3dStockingView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_1.TIP_WAIT_TIME = 5

function var_0_1.Init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.controlTF = var_1.Find(var_1_0, "StockingControl")

	local var_1_1 = arg_1_0._tf

	arg_1_0.uiTF = var_1.Find(var_1_1, "UI/stocking")

	local var_1_2 = arg_1_0.controlTF

	arg_1_0.tipTF = var_1.Find(var_1_2, "Tips")

	local var_1_3 = arg_1_0.controlTF

	arg_1_0.clickTF = var_1.Find(var_1_3, "ClickTips")
	onButton = var_1

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.uiTF
	local var_1_6 = var_3.Find(var_1_5, "btn_back")

	local function var_1_7()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		Dorm3dStockingMgr = var_2_10002

		var_2_1(var_2_0, var_2_10002.EXIT_STOCKING_STATUS)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_1_4, var_1_6, var_1_7, var_5)
	arg_1_0:InitDragEvent()
	arg_1_0:InitHint()
	arg_1_0:Hide()

	return
end

function var_0_1.InitDragEvent(arg_3_0)
	local var_3_0 = arg_3_0.controlTF
	local var_3_1 = var_1.Find(var_3_0, "ControlLayer")
	local var_3_2 = var_1.GetComponent

	typeof = var_3
	SlideController = var_1_10004

	local var_3_3 = var_3_2(var_3_1, var_3(var_1_10004))

	var_1.AddBeginDragFunc(var_3_3, function(arg_4_0, arg_4_1)
		setActive = var_2_10002

		var_2_10002(arg_3_0.tipTF, false)

		local var_4_0 = arg_3_0.timer

		var_2.Stop(var_4_0)

		local var_4_1 = arg_3_0
		local var_4_2 = var_2.emit

		Dorm3dStockingMgr = var_4

		var_4_2(var_4_1, var_4.ON_BEGIN_DRAG, arg_4_0, arg_4_1)

		return
	end)
	var_1:AddDragFunc(function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0
		local var_5_1 = var_2.emit

		Dorm3dStockingMgr = var_2_10004

		var_5_1(var_5_0, var_2_10004.ON_DRAG, arg_5_0, arg_5_1)

		return
	end)
	var_1:AddDragEndFunc(function(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0.timer

		var_2.Start(var_6_0)

		local var_6_1 = arg_3_0
		local var_6_2 = var_2.emit

		Dorm3dStockingMgr = var_2_10004

		var_6_2(var_6_1, var_2_10004.ON_END_DRAG, arg_6_0, arg_6_1)

		return
	end)

	return
end

function var_0_1.InitHint(arg_7_0)
	arg_7_0.time = var_0_1.TIP_WAIT_TIME
	Timer = var_1
	arg_7_0.timer = var_1.New(function()
		if arg_7_0.time <= 0 then
			local var_8_0 = arg_7_0

			var_8_0.time = var_0_1.TIP_WAIT_TIME
			isActive = var_8_0

			if var_8_0(arg_7_0.tipTF) == false then
				setActive = var_0

				var_0(arg_7_0.tipTF, true)

				setActive = var_0

				var_0(arg_7_0.clickTF, true)

				local var_8_1 = arg_7_0

				var_0.FlushHint(var_8_1)
			end
		else
			arg_7_0.time = arg_7_0.time - 0.1
		end

		return
	end, 0.1, -1)

	return
end

function var_0_1.FlushHint(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = arg_9_0
	local var_9_2 = arg_9_0.emit

	Dorm3dStockingMgr = var_1_10004

	var_9_2(var_9_1, var_1_10004.GET_TIP_SHOW_INFO, var_9_0)

	local var_9_3 = var_9_0[1]
	local var_9_4 = var_9_0[2]

	UIItemList = var_4

	local var_9_5 = var_4.StaticAlign
	local var_9_6 = arg_9_0.tipTF
	local var_9_7 = arg_9_0.tipTF

	var_9_5(var_9_6, var_6.GetChild(var_9_7, 0), #var_9_3, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_10_1 = arg_10_1 + 1
		setLocalPosition = var_3

		local var_10_0 = arg_10_2

		LuaHelper = var_2_10005

		local var_10_1 = var_2_10005.ScreenToLocal
		local var_10_2 = arg_9_0.tipTF
		local var_10_3 = var_9_3[arg_10_1].pos

		pg = var_2_10008

		var_3(var_10_0, var_10_1(var_10_2, var_10_3, var_2_10008.UIMgr.GetInstance().uiCameraComp))

		Mathf = var_3

		local var_10_4 = var_3.Atan2(var_9_3[arg_10_1].dir.y, var_9_3[arg_10_1].dir.x)

		Mathf = var_4

		local var_10_5 = var_10_4 * var_4.Rad2Deg

		setLocalRotation = var_4

		local var_10_6 = arg_10_2

		Quaternion = var_10_2

		var_4(var_10_6, var_10_2.Euler(0, 0, var_10_5 - 90))

		return
	end)

	UIItemList = var_9_5

	local var_9_8 = var_9_5.StaticAlign
	local var_9_9 = arg_9_0.clickTF
	local var_9_10 = arg_9_0.clickTF

	var_9_8(var_9_9, var_6.GetChild(var_9_10, 0), #var_9_4, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_11_1 = arg_11_1 + 1
		setLocalPosition = var_3

		local var_11_0 = arg_11_2

		LuaHelper = var_2_10005

		local var_11_1 = var_2_10005.ScreenToLocal
		local var_11_2 = arg_9_0.clickTF
		local var_11_3 = var_9_4[arg_11_1].pos

		pg = var_2_10008

		var_3(var_11_0, var_11_1(var_11_2, var_11_3, var_2_10008.UIMgr.GetInstance().uiCameraComp))

		return
	end)

	return
end

function var_0_1.Show(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.controlTF, true)

	setActive = var_1_10001

	var_1_10001(arg_12_0.uiTF, true)

	local var_12_0 = arg_12_0.timer

	var_1.Start(var_12_0)

	return
end

function var_0_1.Hide(arg_13_0)
	setActive = var_1_10001

	var_1_10001(arg_13_0.controlTF, false)

	setActive = var_1_10001

	var_1_10001(arg_13_0.uiTF, false)

	local var_13_0 = arg_13_0.timer

	var_1.Stop(var_13_0)

	return
end

return var_0_1
