local var_0_0 = class("Dorm3dStockingView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_0.TIP_WAIT_TIME = 5

function var_0_0.Init(arg_1_0)
	arg_1_0.controlTF = arg_1_0._tf:Find("StockingControl")
	arg_1_0.uiTF = arg_1_0._tf:Find("UI/stocking")
	arg_1_0.tipTF = arg_1_0.controlTF:Find("Tips")
	arg_1_0.clickTF = arg_1_0.controlTF:Find("ClickTips")

	onButton(arg_1_0, arg_1_0.uiTF:Find("btn_back"), function()
		arg_1_0:emit(Dorm3dStockingMgr.EXIT_STOCKING_STATUS)

		return
	end, SFX_CANCEL)
	arg_1_0:InitDragEvent()
	arg_1_0:InitHint()
	arg_1_0:Hide()

	return
end

function var_0_0.InitDragEvent(arg_3_0)
	local var_3_0 = arg_3_0.controlTF:Find("ControlLayer"):GetComponent(typeof(SlideController))

	var_3_0:AddBeginDragFunc(function(arg_4_0, arg_4_1)
		setActive(arg_3_0.tipTF, false)
		arg_3_0.timer:Stop()
		arg_3_0:emit(Dorm3dStockingMgr.ON_BEGIN_DRAG, arg_4_0, arg_4_1)

		return
	end)
	var_3_0:AddDragFunc(function(arg_5_0, arg_5_1)
		arg_3_0:emit(Dorm3dStockingMgr.ON_DRAG, arg_5_0, arg_5_1)

		return
	end)
	var_3_0:AddDragEndFunc(function(arg_6_0, arg_6_1)
		arg_3_0.timer:Start()
		arg_3_0:emit(Dorm3dStockingMgr.ON_END_DRAG, arg_6_0, arg_6_1)

		return
	end)

	return
end

function var_0_0.InitHint(arg_7_0)
	arg_7_0.time = var_0_0.TIP_WAIT_TIME
	arg_7_0.timer = Timer.New(function()
		if arg_7_0.time <= 0 then
			arg_7_0.time = var_0_0.TIP_WAIT_TIME

			if isActive(arg_7_0.tipTF) == false then
				setActive(arg_7_0.tipTF, true)
				setActive(arg_7_0.clickTF, true)
				arg_7_0:FlushHint()
			end
		else
			arg_7_0.time = arg_7_0.time - 0.1
		end

		return
	end, 0.1, -1)

	return
end

function var_0_0.FlushHint(arg_9_0)
	arg_9_0:emit(Dorm3dStockingMgr.GET_TIP_SHOW_INFO, {})

	local var_9_0 = ({})[2]

	UIItemList.StaticAlign(arg_9_0.tipTF, arg_9_0.tipTF:GetChild(0), #({})[1], function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_10_1 = arg_10_1 + 1

		setLocalPosition(arg_10_2, LuaHelper.ScreenToLocal(arg_9_0.tipTF, var_0[arg_10_1].pos, pg.UIMgr.GetInstance().uiCameraComp))
		setLocalRotation(arg_10_2, Quaternion.Euler(0, 0, Mathf.Atan2(var_0[arg_10_1].dir.y, var_0[arg_10_1].dir.x) * Mathf.Rad2Deg - 90))

		return
	end)
	UIItemList.StaticAlign(arg_9_0.clickTF, arg_9_0.clickTF:GetChild(0), #({})[2], function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_11_1 = arg_11_1 + 1

		setLocalPosition(arg_11_2, LuaHelper.ScreenToLocal(arg_9_0.clickTF, var_9_0[arg_11_1].pos, pg.UIMgr.GetInstance().uiCameraComp))

		return
	end)

	return
end

function var_0_0.Show(arg_12_0)
	setActive(arg_12_0.controlTF, true)
	setActive(arg_12_0.uiTF, true)
	arg_12_0.timer:Start()

	return
end

function var_0_0.Hide(arg_13_0)
	setActive(arg_13_0.controlTF, false)
	setActive(arg_13_0.uiTF, false)
	arg_13_0.timer:Stop()

	return
end

return var_0_0
