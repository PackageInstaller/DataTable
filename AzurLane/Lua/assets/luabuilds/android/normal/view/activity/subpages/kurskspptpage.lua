class = var_0_10000

local var_0_0 = "KurskSPPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.battleBtn

	local function var_1_2()
		local var_2_0
		local var_2_1
		local var_2_2 = arg_1_0.activity

		if var_2.getConfig(var_2_2, "config_client").linkActID then
			getProxy = var_2_5
			ActivityProxy = var_2_2

			local var_2_3 = var_2_5(var_2_2)

			var_2_1 = var_2_5.getActivityById(var_2_3, var_0)
		end

		local var_2_5, var_2_6

		if not var_0 then
			local var_2_4 = arg_1_0

			var_2_5 = var_2_5.emit
			ActivityMediator = var_2_6
			var_2_6 = var_2_6.EVENT_GO_SCENE
			SCENE = var_2_10005

			var_2_5(var_2_4, var_2_6, var_2_10005.BOSSRUSH_MAIN)
		elseif var_2_1 and not var_2_1:isEnd() then
			local var_2_7 = arg_1_0

			var_2_5 = var_2_5.emit
			ActivityMediator = var_2_6
			var_2_6 = var_2_6.EVENT_GO_SCENE
			SCENE = var_2_10005

			var_2_5(var_2_7, var_2_6, var_2_10005.BOSSRUSH_MAIN)
		else
			pg = var_2_5

			local var_2_8 = var_2_5.TipsMgr.GetInstance()
			local var_2_9 = var_2.ShowTips

			i18n = var_2_6

			var_2_9(var_2_8, var_2_6("challenge_end_tip"))
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_0, var_1_1, var_1_2, var_1_10005)

	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.bg
	local var_1_5 = var_3.Find(var_1_4, "build_btn")

	local function var_1_6()
		local var_3_0
		local var_3_1
		local var_3_2 = arg_1_0.activity

		if var_2.getConfig(var_3_2, "config_client").linkActID then
			getProxy = var_3_5
			ActivityProxy = var_3_2

			local var_3_3 = var_3_5(var_3_2)

			var_3_1 = var_3_5.getActivityById(var_3_3, var_0)
		end

		local var_3_5, var_3_6

		if not var_0 then
			local var_3_4 = arg_1_0

			var_3_5 = var_3_5.emit
			ActivityMediator = var_3_6
			var_3_6 = var_3_6.EVENT_GO_SCENE
			SCENE = var_2_10005
			var_2_10005 = var_2_10005.GETBOAT

			local var_3_7 = {}

			BuildShipScene = var_2_10007
			var_3_7.page = var_2_10007.PAGE_BUILD
			BuildShipScene = var_2_10007
			var_3_7.projectName = var_2_10007.PROJECTS.ACTIVITY

			var_3_5(var_3_4, var_3_6, var_2_10005, var_3_7)
		elseif var_3_1 and not var_3_1:isEnd() then
			local var_3_8 = arg_1_0

			var_3_5 = var_3_5.emit
			ActivityMediator = var_3_6
			var_3_6 = var_3_6.EVENT_GO_SCENE
			SCENE = var_2_10005

			local var_3_9 = var_2_10005.GETBOAT
			local var_3_10 = {}

			BuildShipScene = var_2_10007
			var_3_10.page = var_2_10007.PAGE_BUILD
			BuildShipScene = var_7
			var_3_10.projectName = var_7.PROJECTS.ACTIVITY

			var_3_5(var_3_8, var_3_6, var_3_9, var_3_10)
		else
			pg = var_3_5

			local var_3_11 = var_3_5.TipsMgr.GetInstance()
			local var_3_12 = var_2.ShowTips

			i18n = var_3_6

			var_3_12(var_3_11, var_3_6("challenge_end_tip"))
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_3, var_1_5, var_1_6, var_5)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	var_0_1.super.OnUpdateFlush(arg_4_0)

	setActive = var_1

	var_1(arg_4_0.battleBtn, true)

	return
end

return var_0_1
