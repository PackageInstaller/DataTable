class = var_0_10000

local var_0_0 = "ALYMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.AD

	arg_1_0.list = var_1.Find(var_1_1, "list")

	local var_1_2 = arg_1_0.list

	arg_1_0.build = var_1.Find(var_1_2, "build")

	local var_1_3 = arg_1_0.list

	arg_1_0.fight = var_1.Find(var_1_3, "fight")

	local var_1_4 = arg_1_0.list

	arg_1_0.shop = var_1.Find(var_1_4, "shop")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.build

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_3_3 = var_2_10004.GETBOAT
		local var_3_4 = {}

		BuildShipScene = var_2_10006
		var_3_4.page = var_2_10006.PAGE_BUILD
		BuildShipScene = var_6
		var_3_4.projectName = var_6.PROJECTS.ACTIVITY

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.fight

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.SKIP_ACTIVITY_MAP, 6)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.shop

	local function var_2_8()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.GO_CHANGE_SHOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10006)

	setText = var_1_10001

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "Text (Legacy)", arg_2_0.build)

	i18n = var_2_7

	var_1_10001(var_2_10, var_2_7("yumia_main_tip_1"))

	setText = var_1_10001

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "Text (Legacy)", arg_2_0.fight)

	i18n = var_4

	var_1_10001(var_2_12, var_4("yumia_main_tip_2"))

	setText = var_1_10001

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "Text (Legacy)", arg_2_0.shop)

	i18n = var_4

	var_1_10001(var_2_14, var_4("yumia_main_tip_3"))

	return
end

function var_0_1.OnDestroy(arg_6_0)
	if arg_6_0.camEventId then
		pg = var_1

		local var_6_0 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_6_0, arg_6_0.camEventId)

		arg_6_0.camEventId = nil
	end

	return
end

return var_0_1
