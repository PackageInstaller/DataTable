class = var_0_10000

local var_0_0 = "ActiveStarlightHomepage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_1.Find(var_1_1, "bg/Build")

	arg_1_0.Build = var_1.GetComponent(var_1_2, "Button")

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_1.Find(var_1_3, "bg/Level")

	arg_1_0.Level = var_1.GetComponent(var_1_4, "Button")

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_1.Find(var_1_5, "bg/Shop")

	arg_1_0.Shop = var_1.GetComponent(var_1_6, "Button")

	local var_1_7 = arg_1_0._tf
	local var_1_8 = var_1.Find(var_1_7, "bg/Manual")

	arg_1_0.Manual = var_1.GetComponent(var_1_8, "Button")

	local var_1_9 = arg_1_0._tf

	arg_1_0.image = var_1.Find(var_1_9, "bg/Manual/image")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "time")

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.Build

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		local var_4_3 = var_2_10003.GETBOAT
		local var_4_4 = {}

		BuildShipScene = var_2_10005
		var_4_4.page = var_2_10005.PAGE_NEWSERVER

		var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.Level

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.Shop

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.GO_CHANGE_SHOP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.Manual

	local function var_3_11()
		Context = var_2_10000

		local var_7_0 = var_2_10000.New
		local var_7_1 = {}

		MedalAlbumTemplateMediator = var_2_10002
		var_7_1.mediator = var_2_10002
		StarLightMedalAlbumView = var_2_10002
		var_7_1.viewComponent = var_2_10002

		local var_7_2 = var_7_0(var_7_1)
		local var_7_3 = arg_3_0
		local var_7_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_7_4(var_7_3, var_2_10003.ON_ADD_SUBLAYER, var_7_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

return var_0_1
