class = var_0_10000

local var_0_0 = "IslandShipFirstDressupPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseDressupPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommanderMainUI"
end

function var_0_1.CanEsc(arg_2_0)
	return false
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.leftPlane = var_1.Find(var_3_0, "adapt/left_panel")

	local var_3_1 = arg_3_0._tf

	arg_3_0.backBtn = var_1.Find(var_3_1, "adapt/left_panel/back")

	local var_3_2 = arg_3_0._tf

	arg_3_0.homeBtn = var_1.Find(var_3_2, "adapt/home")
	setText = var_1

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_3.Find(var_3_3, "adapt/left_panel/title/Text")

	i18n = var_4

	var_1(var_3_4, var_4("island_dressup_titile"))

	setActive = var_1

	var_1(arg_3_0.leftPlane, false)

	setActive = var_1

	var_1(arg_3_0.homeBtn, false)

	return
end

function var_0_1.AddListeners(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.AddListener

	GAME = var_1_10004

	var_4_1(var_4_0, var_1_10004.ISLAND_CHANGE_COMMANDER_DRESS_DONE, arg_4_0.OnDressUpDone)

	return
end

function var_0_1.RemoveListeners(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.RemoveListener

	GAME = var_1_10004

	var_5_1(var_5_0, var_1_10004.ISLAND_CHANGE_COMMANDER_DRESS_DONE, arg_5_0.OnDressUpDone)

	return
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.homeBtn

	local function var_6_2()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		BaseUI = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.backBtn

	local function var_6_5()
		local var_8_0 = arg_6_0

		if var_0.CheckDressIsDirty(var_8_0) then
			local var_8_1 = arg_6_0
			local var_8_2 = var_0.ShowMsgBox
			local var_8_3 = {}

			IslandMsgBox = var_2_10004
			var_8_3.type = var_2_10004.TYPE_COMMON
			i18n = var_4
			var_8_3.content = var_4("island_dressup_tip_1")

			function var_8_3.onYes()
				local var_9_0 = arg_6_0.currentChildPage

				var_0.SaveDressUpData(var_9_0)

				local var_9_1 = arg_6_0

				var_0.Hide(var_9_1)

				return
			end

			function var_8_3.onNo()
				local var_10_0 = arg_6_0

				var_0.Hide(var_10_0)

				return
			end

			var_8_2(var_8_1, var_8_3)
		else
			local var_8_4 = arg_6_0

			var_0.Hide(var_8_4)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	return
end

function var_0_1.Show(arg_11_0, arg_11_1)
	arg_11_0.callback = arg_11_1

	var_0_1.super.Show(arg_11_0)
	arg_11_0:Flush()

	IslandShipDressHelperNew = var_2
	arg_11_0.shipDressHelper = var_2.New()

	local var_11_0 = arg_11_0.shipDressHelper

	var_2.SetShipId(var_11_0, 0)

	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_0.OpenPage

	IslandShipDressUpPageNew = var_5
	arg_11_0.currentChildPage = var_11_2(var_11_1, var_5, 0, true, arg_11_0.shipDressHelper)
	pg = var_2

	local var_11_3 = var_2.island_unit_character[0]

	arg_11_0:LoadCharacter({
		model = var_11_3.model,
		animator = var_11_3.animator
	})

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

	return
end

function var_0_1.OnDressUpDone(arg_16_0)
	arg_16_0:Hide()
	arg_16_0:ClearCharacterScene(arg_16_0.callback)

	return
end

function var_0_1.CheckDressIsDirty(arg_17_0)
	local var_17_0 = arg_17_0.currentChildPage

	return var_1.CheckDressIsDirty(var_17_0)
end

function var_0_1.OnDestroy(arg_18_0)
	return
end

return var_0_1
