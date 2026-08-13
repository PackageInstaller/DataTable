class = var_0_10000

local var_0_0 = "SVSalvageResult"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.HideView = "SVSalvageResult.HideView"

function var_0_1.getUIName(arg_1_0)
	return "SVSalvageResult"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rtPanel = var_1.Find(var_3_0, "window/display_panel")
	setText = var_1

	local var_3_1 = arg_3_0.rtPanel
	local var_3_2 = var_2.Find(var_3_1, "info/Text")

	i18n = var_3_1

	var_1(var_3_2, var_3_1("world_catsearch_help_1"))

	setText = var_1

	local var_3_3 = arg_3_0.rtPanel
	local var_3_4 = var_2.Find(var_3_3, "info/items_btn/Text")

	i18n = var_3_3

	var_1(var_3_4, var_3_3("world_catsearch_help_2"))

	onButton = var_1

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.rtPanel
	local var_3_7 = var_3.Find(var_3_6, "info/items_btn")

	local function var_3_8()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10002

		local var_4_2 = var_2_10002.ON_DROP_LIST
		local var_4_3 = {
			item2Row = true
		}

		_ = var_2_10004

		local var_4_4 = var_2_10004.map

		pg = var_2_10005
		var_4_3.itemList = var_4_4(var_2_10005.gameset.world_catsearchdrop_show.description, function(arg_5_0)
			return {
				type = arg_5_0[1],
				id = arg_5_0[2],
				count = arg_5_0[3]
			}
		end)
		i18n = var_4
		var_4_3.content = var_4("world_catsearch_help_6")

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_5, var_3_7, var_3_8, var_5)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0._tf
	local var_3_11 = var_3.Find(var_3_10, "bg")

	local function var_3_12()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_3_9, var_3_11, var_3_12, var_5)

	local var_3_13 = arg_3_0._tf

	arg_3_0.btnBack = var_1.Find(var_3_13, "window/top/btnBack")
	onButton = var_1

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.btnBack

	local function var_3_16()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_3_14, var_3_15, var_3_16, var_5)

	local var_3_17 = arg_3_0._tf

	arg_3_0.btnCanel = var_1.Find(var_3_17, "window/button_container/custom_button_2")
	onButton = var_1

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.btnCanel

	local function var_3_20()
		local var_8_0 = arg_3_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_3_18, var_3_19, var_3_20, var_5)

	local var_3_21 = arg_3_0.rtPanel

	arg_3_0.btnHelp = var_1.Find(var_3_21, "info/help")
	onButton = var_1

	local var_3_22 = arg_3_0
	local var_3_23 = arg_3_0.btnHelp

	local function var_3_24()
		local var_9_0 = arg_3_0

		var_0.Hide(var_9_0)

		local var_9_1 = arg_3_0
		local var_9_2 = var_0.emit

		WorldScene = var_2_10002

		local var_9_3 = var_2_10002.SceneOp
		local var_9_4 = "OpOpenLayer"

		Context = var_2_10004

		local var_9_5 = var_2_10004.New
		local var_9_6 = {}

		WorldHelpMediator = var_2_10006
		var_9_6.mediator = var_2_10006
		WorldHelpLayer = var_2_10006
		var_9_6.viewComponent = var_2_10006
		var_9_6.data = {
			titleId = 3,
			pageId = 10
		}

		var_9_2(var_9_1, var_9_3, var_9_4, var_9_5(var_9_6))

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_22, var_3_23, var_3_24, var_5)

	local var_3_25 = arg_3_0._tf

	arg_3_0.btnConfirm = var_1.Find(var_3_25, "window/button_container/custom_button_1")
	onButton = var_1

	local var_3_26 = arg_3_0
	local var_3_27 = arg_3_0.btnConfirm

	local function var_3_28()
		local var_10_0 = arg_3_0

		var_0.Hide(var_10_0)

		local var_10_1 = arg_3_0
		local var_10_2 = var_0.emit

		WorldScene = var_2_10002

		var_10_2(var_10_1, var_2_10002.SceneOp, "OpReqCatSalvage", arg_3_0.fleetId)

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_3_26, var_3_27, var_3_28, var_5)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

function var_0_1.Show(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0._tf, true)

	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_12_0, arg_12_0._tf)

	return
end

function var_0_1.Hide(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)

	setActive = var_1

	var_1(arg_13_0._tf, false)

	return
end

function var_0_1.Setup(arg_14_0, arg_14_1)
	arg_14_0.fleetId = arg_14_1

	return
end

return var_0_1
