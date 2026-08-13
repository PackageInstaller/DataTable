class = var_0_10000

local var_0_0 = "MaidAzurlanePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_4.Find(var_1_1, "help")

	local function var_1_3()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_2_2.type = var_2_10004
		pg = var_2_10004
		var_2_2.helps = var_2_10004.gametip.maid_task_tips1.tip

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_PANEL = var_1_1

	var_1(var_1_0, var_1_2, var_1_3, var_1_1)

	onButton = var_1

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bg
	local var_1_6 = var_4.Find(var_1_5, "ClickIron")

	local function var_1_7()
		Context = var_2_10000

		local var_3_0 = var_2_10000.New()

		SCENE = var_2_10001

		local var_3_1 = var_2_10001.SetSceneInfo
		local var_3_2 = var_3_0

		SCENE = var_2_10004

		var_3_1(var_3_2, var_2_10004.NEWYEAR_BACKHILL_2022)

		local var_3_3 = var_3_0
		local var_3_4 = var_3_0.addChild

		Context = var_4

		local var_3_5 = var_4.New
		local var_3_6 = {}

		BuildingUpgradeMediator = var_2_10007
		var_3_6.mediator = var_2_10007
		BuildingCafeUpgradeLayer = var_2_10007
		var_3_6.viewComponent = var_2_10007
		var_3_6.data = {
			buildingID = 18,
			isLayer = true
		}

		var_3_4(var_3_3, var_3_5(var_3_6))

		pg = var_3_4

		local var_3_7 = var_3_4.m02
		local var_3_8 = var_1.sendNotification

		GAME = var_4

		var_3_8(var_3_7, var_4.LOAD_SCENE, {
			context = var_3_0
		})

		return
	end

	SFX_PANEL = var_1_5

	var_1(var_1_4, var_1_6, var_1_7, var_1_5)

	onButton = var_1

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bg
	local var_1_10 = var_4.Find(var_1_9, "ClickRoyal")

	local function var_1_11()
		Context = var_2_10000

		local var_4_0 = var_2_10000.New()

		SCENE = var_2_10001

		local var_4_1 = var_2_10001.SetSceneInfo
		local var_4_2 = var_4_0

		SCENE = var_2_10004

		var_4_1(var_4_2, var_2_10004.NEWYEAR_BACKHILL_2022)

		local var_4_3 = var_4_0
		local var_4_4 = var_4_0.addChild

		Context = var_4

		local var_4_5 = var_4.New
		local var_4_6 = {}

		BuildingUpgradeMediator = var_2_10007
		var_4_6.mediator = var_2_10007
		BuildingCafeUpgradeLayer = var_2_10007
		var_4_6.viewComponent = var_2_10007
		var_4_6.data = {
			buildingID = 17,
			isLayer = true
		}

		var_4_4(var_4_3, var_4_5(var_4_6))

		pg = var_4_4

		local var_4_7 = var_4_4.m02
		local var_4_8 = var_1.sendNotification

		GAME = var_4

		var_4_8(var_4_7, var_4.LOAD_SCENE, {
			context = var_4_0
		})

		return
	end

	SFX_PANEL = var_1_9

	var_1(var_1_8, var_1_10, var_1_11, var_1_9)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	var_0_1.super.OnUpdateFlush(arg_5_0)

	setText = var_1

	local var_5_0 = arg_5_0.dayTF

	setColorStr = var_1_10004
	tostring = var_1_10006

	var_1(var_5_0, var_1_10004(var_1_10006(arg_5_0.nday), "#7B3B2C"))

	return
end

return var_0_1
