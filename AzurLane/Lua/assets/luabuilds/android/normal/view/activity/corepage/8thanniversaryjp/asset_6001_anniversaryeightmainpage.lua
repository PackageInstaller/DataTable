class = var_0_10000

local var_0_0 = "AnniversaryEightMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	return
end

function var_0_1.OnDataSetting(arg_2_0)
	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0

	findTF = var_1_10003

	local var_3_1 = var_1_10003(arg_3_0._tf, "AD/btn_act")

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_4_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.CITY_REBUILD_MAP)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_1, var_3_2, var_5)

	onButton = var_1_10001

	local var_3_3 = arg_3_0

	findTF = var_3_1

	local var_3_4 = var_3_1(arg_3_0._tf, "AD/btn_hotspring")

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_5_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.EIGHTH_HOTSPRING)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_3, var_3_4, var_3_5, var_5)

	setText = var_1_10001
	findTF = var_3_3

	local var_3_6 = var_3_3(arg_3_0._tf, "AD/desc")

	i18n = var_3

	var_1_10001(var_3_6, var_3("anniversary_eight_main_page_desc"))

	CityRebuildBookLayer = var_1_10001

	if not var_1_10001.ShouldShowTip() then
		CityRebuildTasksLayer = var_1

		if var_1.ShouldShowTip() then
			setActive = var_1
			findTF = var_3_6

			var_1(var_3_6(arg_3_0._tf, "AD/btn_act/red"), true)
		else
			setActive = var_1
			findTF = var_3_6

			var_1(var_3_6(arg_3_0._tf, "AD/btn_act/red"), false)
		end

		return
	end
end

function var_0_1.OnUpdateFlush(arg_6_0)
	return
end

return var_0_1
