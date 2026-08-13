class = var_0_10000

local var_0_0 = "MainLiveAreaOldPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MainLiveAreaOldUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._academyBtn = var_1.Find(var_2_0, "school_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0._haremBtn = var_1.Find(var_2_1, "backyard_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0._commanderBtn = var_1.Find(var_2_2, "commander_btn")
	pg = var_1

	local var_2_3 = var_1.EasyRedDotMgr.GetInstance()
	local var_2_4 = arg_2_0._haremBtn

	arg_2_0._haremTip = var_2.Find(var_2_4, "tip")

	local var_2_5 = arg_2_0._academyBtn

	arg_2_0._academyTip = var_2.Find(var_2_5, "tip")

	local var_2_6 = arg_2_0._commanderBtn

	arg_2_0._commanderTip = var_2.Find(var_2_6, "tip")

	var_2_3:RegisterRedDot(arg_2_0._haremTip, {
		"COURTYARD"
	}, function(arg_3_0)
		setActive = var_2_10001

		local var_3_0 = arg_3_0

		getProxy = var_2_10003
		DormProxy = var_2_10004

		local var_3_1 = var_2_10003(var_2_10004)

		var_2_10001(var_3_0, var_3.IsShowRedDot(var_3_1))

		return
	end)
	var_2_3:RegisterRedDot(arg_2_0._academyTip, {
		"SCHOOL"
	}, function(arg_4_0)
		setActive = var_2_10001

		local var_4_0 = arg_4_0

		getProxy = var_2_10003
		NavalAcademyProxy = var_2_10004

		local var_4_1 = var_2_10003(var_2_10004)

		var_2_10001(var_4_0, var_3.IsShowTip(var_4_1))

		return
	end)
	var_2_3:RegisterRedDot(arg_2_0._commanderTip, {
		"COMMANDER"
	}, function(arg_5_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		local var_5_0 = var_2_10001(var_2_10002)

		if var_1.getRawData(var_5_0).level < 40 then
			setActive = var_1

			var_1(arg_5_0, false)

			return
		end

		getProxy = var_1
		CommanderProxy = var_2

		local var_5_1 = var_1(var_2)
		local var_5_2 = var_1.IsFinishAllBox(var_5_1)

		LOCK_CATTERY = var_5_1

		if not var_5_1 then
			setActive = var_5_1

			local var_5_3 = arg_5_0

			if not var_5_2 then
				::label_5_0::

				getProxy = var_2_10004
				CommanderProxy = var_2_10005

				local var_5_4 = var_2_10004(var_2_10005)

				if not var_2_10004.AnyCatteryExistOP(var_5_4) then
					getProxy = var_2_10004
					CommanderProxy = var_5_4

					local var_5_5 = var_2_10004(var_5_4)

					var_2_10004 = var_2_10004.AnyCatteryCanUse(var_5_5)
				end
			end

			var_5_1(var_5_3, var_2_10004)
		else
			setActive = var_5_1

			var_5_1(arg_5_0, var_5_2)
		end

		return
	end)

	return
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._commanderBtn

	local function var_6_2()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		NewMainMediator = var_2_10002

		local var_7_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_7_3 = var_2_10003.COMMANDERCAT
		local var_7_4 = {
			fromMain = true
		}

		CommanderCatScene = var_2_10005
		var_7_4.fleetType = var_2_10005.FLEET_TYPE_COMMON

		var_7_1(var_7_0, var_7_2, var_7_3, var_7_4)

		local var_7_5 = arg_6_0

		var_0.Hide(var_7_5)

		return
	end

	SFX_MAIN = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0._haremBtn

	local function var_6_5()
		local var_8_0 = arg_6_0
		local var_8_1 = var_0.emit

		NewMainMediator = var_2_10002

		local var_8_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.COURTYARD)

		local var_8_3 = arg_6_0

		var_0.Hide(var_8_3)

		return
	end

	SFX_MAIN = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	onButton = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0._academyBtn

	local function var_6_8()
		local var_9_0 = arg_6_0
		local var_9_1 = var_0.emit

		NewMainMediator = var_2_10002

		local var_9_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_9_1(var_9_0, var_9_2, var_2_10003.NAVALACADEMYSCENE)

		local var_9_3 = arg_6_0

		var_0.Hide(var_9_3)

		return
	end

	SFX_MAIN = var_1_10005

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10005)

	onButton = var_1_10001

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0._tf

	local function var_6_11()
		local var_10_0 = arg_6_0

		var_0.Hide(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_9, var_6_10, var_6_11, var_1_10005)

	return
end

function var_0_1.Show(arg_11_0)
	var_0_1.super.Show(arg_11_0)

	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_11_0, arg_11_0._tf, {
		staticBlur = true
	})

	getProxy = var_1
	PlayerProxy = var_11_0

	local var_11_1 = var_1(var_11_0)
	local var_11_2 = var_1.getRawData(var_11_1)

	pg = var_11_1

	local var_11_3 = var_11_1.SystemOpenMgr.GetInstance()

	if not var_2.isOpenSystem(var_11_3, var_11_2.level, "CommanderCatMediator") then
		local var_11_4 = arg_11_0._commanderBtn

		var_11_3 = var_11_3.GetComponent
		typeof = var_5
		Image = var_1_10006
		var_11_3 = var_11_3(var_11_4, var_5(var_1_10006))
		Color = var_11_4
		var_11_3.color = var_11_4(0.3, 0.3, 0.3, 1)
	else
		local var_11_5 = arg_11_0._commanderBtn

		var_11_3 = var_11_3.GetComponent
		typeof = var_5
		Image = var_1_10006
		var_11_3 = var_11_3(var_11_5, var_5(var_1_10006))
		Color = var_11_5
		var_11_3.color = var_11_5(1, 1, 1, 1)
	end

	pg = var_11_3

	local var_11_6 = var_11_3.SystemOpenMgr.GetInstance()

	if not var_3.isOpenSystem(var_11_6, var_11_2.level, "CourtYardMediator") then
		local var_11_7 = arg_11_0._haremBtn
		local var_11_8 = var_4.GetComponent

		typeof = var_6
		Image = var_1_10007

		local var_11_9 = var_11_8(var_11_7, var_6(var_1_10007))

		Color = var_11_7
		var_11_9.color = var_11_7(0.3, 0.3, 0.3, 1)
	else
		local var_11_10 = arg_11_0._haremBtn
		local var_11_11 = var_4.GetComponent

		typeof = var_6
		Image = var_1_10007

		local var_11_12 = var_11_11(var_11_10, var_6(var_1_10007))

		Color = var_11_10
		var_11_12.color = var_11_10(1, 1, 1, 1)
	end

	return
end

function var_0_1.Hide(arg_12_0)
	if arg_12_0:isShowing() then
		var_0_1.super.Hide(arg_12_0)

		pg = var_1

		local var_12_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_12_0, arg_12_0._tf, arg_12_0._parentTf)
	end

	return
end

function var_0_1.OnDestroy(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.EasyRedDotMgr.GetInstance()

	var_1.UnRegisterRedDot(var_13_0, arg_13_0._haremTip)
	var_1:UnRegisterRedDot(arg_13_0._academyTip)
	var_1:UnRegisterRedDot(arg_13_0._commanderTip)
	arg_13_0:Hide()

	return
end

return var_0_1
