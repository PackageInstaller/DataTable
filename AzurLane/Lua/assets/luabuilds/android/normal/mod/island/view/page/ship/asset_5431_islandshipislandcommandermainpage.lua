class = var_0_10000

local var_0_0 = "IslandShipIslandCommanderMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseShipDisplayPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommanderMainUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "adapt/left_panel/back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_1, "adapt/home")
	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "adapt/left_panel/title/Text")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("island_dressup_titile"))

	setActive = var_1

	var_1(arg_2_0.homeBtn, false)

	return
end

function var_0_1.AddListeners(arg_3_0)
	return
end

function var_0_1.RemoveListeners(arg_4_0)
	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.homeBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.backBtn

	local function var_5_5()
		local var_7_0 = arg_5_0

		if var_0.CheckDressIsDirty(var_7_0) then
			local var_7_1 = arg_5_0
			local var_7_2 = var_0.ShowMsgBox
			local var_7_3 = {}

			IslandMsgBox = var_2_10003
			var_7_3.type = var_2_10003.TYPE_COMMON
			i18n = var_3
			var_7_3.content = var_3("island_dressup_tip_1")

			function var_7_3.onYes()
				local var_8_0 = arg_5_0.currentChildPage

				var_0.SaveDressUpData(var_8_0)

				local var_8_1 = arg_5_0

				var_0.Hide(var_8_1)

				return
			end

			function var_7_3.onNo()
				local var_9_0 = arg_5_0

				var_0.Hide(var_9_0)

				return
			end

			var_7_2(var_7_1, var_7_3)
		else
			local var_7_4 = arg_5_0

			var_0.Hide(var_7_4)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	return
end

function var_0_1.Show(arg_10_0)
	var_0_1.super.Show(arg_10_0)

	local var_10_0 = arg_10_0

	arg_10_0.Flush(var_10_0)

	pg = var_1

	local var_10_1 = var_1.island_unit_character[0]

	IslandShipDressHelperNew = var_10_0
	arg_10_0.shipDressHelper = var_10_0.New()

	local var_10_2 = arg_10_0.shipDressHelper

	var_2.SetShipId(var_10_2, 0)
	arg_10_0:LoadCharacter({
		model = var_10_1.model,
		animator = var_10_1.animator
	}, true)

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.OpenPage

	IslandShipDressUpPageNew = var_4
	arg_10_0.currentChildPage = var_10_4(var_10_3, var_4, 0, false, arg_10_0.shipDressHelper, function(arg_11_0)
		local var_11_0 = arg_10_0

		var_1.SetObjInitRotaion(var_11_0, arg_11_0)

		return
	end)

	return
end

function var_0_1.Flush(arg_12_0)
	return
end

function var_0_1.GetSmoothRotateObject(arg_13_0)
	local var_13_0 = arg_13_0._tf

	return var_1.Find(var_13_0, "adapt/char")
end

function var_0_1.OnCharLoaded(arg_14_0)
	local var_14_0 = arg_14_0.shipDressHelper

	var_1.OnRoleLoaded(var_14_0, arg_14_0.role.transform)

	return
end

function var_0_1.Hide(arg_15_0)
	local var_15_0 = arg_15_0.currentChildPage

	var_1.Destroy(var_15_0)

	local var_15_1 = arg_15_0.shipDressHelper

	var_1.Destroy(var_15_1)
	var_0_1.super.Hide(arg_15_0)

	if arg_15_0.timer then
		local var_15_2 = arg_15_0.timer

		var_1.Stop(var_15_2)
	end

	return
end

function var_0_1.OnDestroy(arg_16_0)
	return
end

function var_0_1.SetObjInitRotaion(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0
	local var_17_1

	var_17_1, GetOrAddComponent = arg_17_0.GetSmoothRotateObject(var_17_0), var_17_0
	typeof = var_1_10005
	SmoothRotateObject = var_1_10006

	local var_17_2 = var_17_0(var_17_1, var_1_10005(var_1_10006))

	var_17_2.rotationSpeed = 5
	ReflectionHelp = var_4

	local var_17_3 = var_4.RefSetProperty

	typeof = var_5
	SmoothRotateObject = var_1_10006

	var_17_3(var_5(var_1_10006), "targetRotation", var_17_2, arg_17_1)

	if arg_17_0.timer then
		local var_17_4 = arg_17_0.timer

		var_4.Stop(var_17_4)
	end

	Timer = var_4
	arg_17_0.timer = var_4.New(function()
		pg = var_2_10000

		local var_18_0 = var_2_10000.island_set.character_detail_camera_speed.key_value_int

		var_17_2.rotationSpeed = var_18_0

		return
	end, 0.5, 1)

	local var_17_5 = arg_17_0.timer

	var_4.Start(var_17_5)

	return
end

function var_0_1.CheckDressIsDirty(arg_19_0)
	local var_19_0 = arg_19_0.currentChildPage

	return var_1.CheckDressIsDirty(var_19_0)
end

function var_0_1.CanEsc(arg_20_0)
	if not arg_20_0:CheckDressIsDirty() then
		return true
	end

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.ShowMsgBox
	local var_20_2 = {}

	IslandMsgBox = var_1_10004
	var_20_2.type = var_1_10004.TYPE_COMMON
	i18n = var_4
	var_20_2.content = var_4("island_dressup_tip_1")

	function var_20_2.onYes()
		local var_21_0 = arg_20_0.currentChildPage

		var_0.SaveDressUpData(var_21_0)

		local var_21_1 = arg_20_0

		var_0.Hide(var_21_1)

		return
	end

	function var_20_2.onNo()
		local var_22_0 = arg_20_0

		var_0.Hide(var_22_0)

		return
	end

	var_20_1(var_20_0, var_20_2)

	return
end

return var_0_1
