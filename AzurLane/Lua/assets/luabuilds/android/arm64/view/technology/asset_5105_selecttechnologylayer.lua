class = var_0_10000

local var_0_0 = "SelectTechnologyLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SelectTechnologyUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_1.init(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_4_0, arg_4_0._tf)

	local var_4_1 = arg_4_0._tf

	arg_4_0.bg = var_1.Find(var_4_1, "frame/bg")

	local var_4_2 = arg_4_0.bg

	arg_4_0.bluePrintBtn = var_1.Find(var_4_2, "blueprint_btn")

	local var_4_3 = arg_4_0.bluePrintBtn

	arg_4_0.bluePrintBtnTip = var_1.Find(var_4_3, "tip")

	local var_4_4 = arg_4_0.bg

	arg_4_0.technologyBtn = var_1.Find(var_4_4, "technology_btn")

	local var_4_5 = arg_4_0.technologyBtn

	arg_4_0.technologyBtnTip = var_1.Find(var_4_5, "tip")

	local var_4_6 = arg_4_0.bg

	arg_4_0.fleetBtn = var_1.Find(var_4_6, "fleet_btn")

	local var_4_7 = arg_4_0.fleetBtn

	arg_4_0.fleetBtnTip = var_1.Find(var_4_7, "tip")

	local var_4_8 = arg_4_0.bg

	arg_4_0.transformBtn = var_1.Find(var_4_8, "transform_btn")

	local var_4_9 = arg_4_0.transformBtn

	arg_4_0.transformBtnTip = var_1.Find(var_4_9, "tip")
	setActive = var_1

	local var_4_10 = arg_4_0.transformBtn

	LOCK_EQUIPMENT_TRANSFORM = var_4

	var_1(var_4_10, not var_4)

	local var_4_11 = arg_4_0.bg

	arg_4_0.metaBtn = var_1.Find(var_4_11, "meta_btn")

	local var_4_12 = arg_4_0.metaBtn

	arg_4_0.metaBtnTip = var_1.Find(var_4_12, "tip")
	setActive = var_1

	var_1(arg_4_0.metaBtn, true)

	local var_4_13 = arg_4_0._tf

	arg_4_0.helpBtn = var_1.Find(var_4_13, "help_btn")

	local var_4_14 = arg_4_0._tf

	arg_4_0.lockedTpl = var_1.Find(var_4_14, "lockedTpl")

	local var_4_15 = arg_4_0._tf

	arg_4_0.backBtn = var_1.Find(var_4_15, "blur_panel/adapt/top/back")
	OPEN_TEC_TREE_SYSTEM = var_1

	if not var_1 then
		setActive = var_1

		var_1(arg_4_0.fleetBtn, false)
	end

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:checkSystemOpen("ShipBluePrintMediator", arg_5_0.bluePrintBtn)
	arg_5_0:checkSystemOpen("TechnologyMediator", arg_5_0.technologyBtn)
	arg_5_0:checkSystemOpen("EquipmentTransformTreeMediator", arg_5_0.transformBtn)
	arg_5_0:checkSystemOpen("MetaCharacterMediator", arg_5_0.metaBtn)

	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.fleetBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		TechnologyConst = var_2_10003

		var_6_1(var_6_0, var_2_10003.OPEN_TECHNOLOGY_TREE_SCENE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.bluePrintBtn

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		SelectTechnologyMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_BLUEPRINT)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.technologyBtn

	local function var_5_8()
		local var_8_0 = arg_5_0
		local var_8_1 = var_0.emit

		SelectTechnologyMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.ON_TECHNOLOGY)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.transformBtn

	local function var_5_11()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.emit

		SelectTechnologyMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_TRANSFORM_EQUIPMENT)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_9, var_5_10, var_5_11, var_1_10006)

	onButton = var_1

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.metaBtn

	local function var_5_14()
		isActive = var_2_10000

		local var_10_0 = arg_5_0.metaBtn

		if var_2_10000(var_2.Find(var_10_0, "word")) then
			local var_10_1 = arg_5_0

			var_2_10001 = var_2_10001.emit
			SelectTechnologyMediator = var_10_0

			var_2_10001(var_10_1, var_10_0.ON_META)
		else
			pg = var_2_10001

			local var_10_2 = var_2_10001.TipsMgr.GetInstance()
			local var_10_3 = var_1.ShowTips

			i18n = var_10_0

			var_10_3(var_10_2, var_10_0("meta_sys_lock_tip"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_12, var_5_13, var_5_14, var_1_10006)

	onButton = var_1

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.backBtn

	local function var_5_17()
		local var_11_0 = arg_5_0

		var_0.emit(var_11_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_15, var_5_16, var_5_17, var_1_10006)

	onButton = var_1

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.helpBtn

	local function var_5_20()
		pg = var_2_10000

		local var_12_0 = var_2_10000.SystemOpenMgr.GetInstance()
		local var_12_1 = var_0.isOpenSystem(var_12_0, arg_5_0.playerVO.level, "ShipBluePrintMediator") and "help_technolog" or "help_technolog0"

		pg = var_12_0

		if var_12_0.gametip[var_12_1] then
			pg = var_2

			local var_12_2 = var_2.MsgboxMgr.GetInstance()
			local var_12_3 = var_2.ShowMsgBox
			local var_12_4 = {}

			MSGBOX_TYPE_HELP = var_2_10006
			var_12_4.type = var_2_10006
			pg = var_2_10006
			var_12_4.helps = var_2_10006.gametip[var_12_1].tip

			var_12_3(var_12_2, var_12_4)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_18, var_5_19, var_5_20, var_1_10006)

	return
end

function var_0_1.checkSystemOpen(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == "MetaCharacterMediator" then
		var_1_10003 = true
		setActive = var_1_10004

		var_1_10004(arg_13_2:Find("word"), var_1_10003)

		setGray = var_1_10004

		var_1_10004(arg_13_2, not var_1_10003)

		local var_13_0 = arg_13_2

		var_1_10004 = arg_13_2.GetComponent
		typeof = var_7
		Image = var_9
		var_1_10004 = var_1_10004(var_13_0, var_7(var_9))
		Color = var_1_10005
		var_1_10004.color = var_1_10005.New(1, 1, 1, var_1_10003 and 1 or 0.7)

		if arg_13_2:Find("locked") then
			setActive = var_5

			var_5(var_1_10004, false)
		end

		if not var_1_10003 then
			IsNil = var_5

			if var_5(var_1_10004) then
				cloneTplTo = var_5
				var_1_10004 = var_5(arg_13_0.lockedTpl, arg_13_2)
				Vector3 = var_5
				var_1_10004.localPosition = var_5.zero
			end

			setActive = var_5

			var_5(var_1_10004, true)
		end

		return
	end

	pg = var_1_10003

	local var_13_1 = var_1_10003.SystemOpenMgr.GetInstance()
	local var_13_2 = var_3.isOpenSystem(var_13_1, arg_13_0.playerVO.level, arg_13_1)

	setActive = var_1_10004

	var_1_10004(arg_13_2:Find("word"), var_13_2)

	setGray = var_1_10004

	var_1_10004(arg_13_2, not var_13_2)

	local var_13_3 = arg_13_2
	local var_13_4 = arg_13_2.GetComponent

	typeof = var_7
	Image = var_9

	local var_13_5 = var_13_4(var_13_3, var_7(var_9))

	Color = var_13_1
	var_13_5.color = var_13_1.New(1, 1, 1, var_13_2 and 1 or 0.7)

	if arg_13_2:Find("locked") then
		setActive = var_5

		var_5(var_13_6, false)
	end

	if not var_13_2 then
		IsNil = var_5

		local var_13_6

		if var_5(var_13_6) then
			cloneTplTo = var_5
			var_13_6 = var_5(arg_13_0.lockedTpl, arg_13_2)
			Vector3 = var_5
			var_13_6.localPosition = var_5.zero
		end

		setActive = var_5

		var_5(var_13_6, true)
	end

	return
end

function var_0_1.notifyTechnology(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.technologyBtnTip, arg_14_1)

	return
end

function var_0_1.notifyBlueprint(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.bluePrintBtnTip, arg_15_1)

	return
end

function var_0_1.notifyFleet(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0.fleetBtnTip, arg_16_1)

	return
end

function var_0_1.notifyTransform(arg_17_0, arg_17_1)
	setActive = var_1_10002

	var_1_10002(arg_17_0.transformBtnTip, arg_17_1)

	return
end

function var_0_1.notifyMeta(arg_18_0, arg_18_1)
	setActive = var_1_10002

	var_1_10002(arg_18_0.metaBtnTip, arg_18_1)

	return
end

function var_0_1.willExit(arg_19_0)
	return
end

return var_0_1
