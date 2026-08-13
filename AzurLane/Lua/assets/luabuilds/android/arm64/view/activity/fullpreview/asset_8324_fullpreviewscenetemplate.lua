class = var_0_10000

local var_0_0 = "FullPreviewSceneTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return arg_1_0.UIName
end

function var_0_1.BindActivityShop(arg_2_0, arg_2_1)
	onButton = var_1_10002

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_1

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		FullPreviewMediatorTemplate = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_3_3 = var_2_10004.SHOP
		local var_3_4 = {}

		NewShopsScene = var_2_10006
		var_3_4.warp = var_2_10006.TYPE_ACTIVITY

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_2_0, var_2_1, var_2_2, var_1_10007)

	return
end

function var_0_1.BindSkinShop(arg_4_0, arg_4_1)
	onButton = var_1_10002

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_1

	local function var_4_2()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		FullPreviewMediatorTemplate = var_2_10003

		local var_5_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004.SKINSHOP)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_4_0, var_4_1, var_4_2, var_1_10007)

	return
end

function var_0_1.BindBuildShip(arg_6_0, arg_6_1)
	onButton = var_1_10002

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_1

	local function var_6_2()
		local var_7_0

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_7_1 = var_2_10001(var_2_10003)
		local var_7_2 = var_1.getActivityByType

		ActivityConst = var_2_10004

		local var_7_3 = var_7_2(var_7_1, var_2_10004.ACTIVITY_TYPE_BUILDSHIP_1)

		getProxy = var_2_10002
		ActivityProxy = var_4

		local var_7_4 = var_2_10002(var_4)
		local var_7_5 = var_2.getActivityByType

		ActivityConst = var_2_10005

		local var_7_6 = var_7_5(var_7_4, var_2_10005.ACTIVITY_TYPE_BUILD)

		if var_7_3 and not var_7_3:isEnd() then
			BuildShipScene = var_7_1
			var_7_0 = var_7_1.PROJECTS.ACTIVITY
		elseif var_7_6 and not var_7_6:isEnd() then
			var_7_1 = {}
			BuildShipScene = var_7_4
			var_7_1[1] = var_7_4.PROJECTS.SPECIAL
			BuildShipScene = var_4
			var_7_1[2] = var_4.PROJECTS.LIGHT
			BuildShipScene = var_4
			var_7_1[3] = var_4.PROJECTS.HEAVY
			var_2_10006 = var_7_6
			var_7_0 = var_7_1[var_7_6.getConfig(var_2_10006, "config_client").id]
		else
			pg = var_7_1

			local var_7_7 = var_7_1.TipsMgr.GetInstance()
			local var_7_8 = var_3.ShowTips

			i18n = var_2_10006

			var_7_8(var_7_7, var_2_10006("common_activity_end"))

			return
		end

		local var_7_9 = arg_6_0
		local var_7_10 = var_3.emit

		FullPreviewMediatorTemplate = var_2_10006

		local var_7_11 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		local var_7_12 = var_2_10007.GETBOAT
		local var_7_13 = {}

		BuildShipScene = var_2_10009
		var_7_13.page = var_2_10009.PAGE_BUILD
		var_7_13.projectName = var_7_0

		var_7_10(var_7_9, var_7_11, var_7_12, var_7_13)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_6_0, var_6_1, var_6_2, var_1_10007)

	return
end

function var_0_1.BindBattle(arg_8_0, arg_8_1)
	onButton = var_1_10002

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_1

	local function var_8_2()
		getProxy = var_2_10000
		ChapterProxy = var_2_10002

		local var_9_0 = var_2_10000(var_2_10002)
		local var_9_1, var_9_2 = var_0.getLastMapForActivity(var_9_0)

		if var_9_1 then
			local var_9_3 = var_0:getMapById(var_9_1)

			if not var_9_0.isUnlock(var_9_3) then
				pg = var_9_0

				local var_9_4 = var_9_0.TipsMgr.GetInstance()
				local var_9_5 = var_3.ShowTips

				i18n = var_2_10006

				var_9_5(var_9_4, var_2_10006("common_activity_end"))
			else
				local var_9_6 = arg_8_0
				local var_9_7 = var_3.emit

				FullPreviewMediatorTemplate = var_2_10006

				local var_9_8 = var_2_10006.GO_SCENE

				SCENE = var_2_10007

				var_9_7(var_9_6, var_9_8, var_2_10007.LEVEL, {
					chapterId = var_9_2,
					mapIdx = var_9_1
				})
			end

			return
		end
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_8_0, var_8_1, var_8_2, var_1_10007)

	return
end

function var_0_1.BindMiniGame(arg_10_0, arg_10_1, arg_10_2)
	onButton = var_1_10003

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_1

	local function var_10_2()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.emit

		FullPreviewMediatorTemplate = var_2_10003

		var_11_1(var_11_0, var_2_10003.GO_MINIGAME, arg_10_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_10_0, var_10_1, var_10_2, var_1_10008)

	return
end

function var_0_1.UpdateView(arg_12_0)
	return
end

function var_0_1.IsMiniGameTip(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.mini_game[arg_13_0].hub_id

	getProxy = var_1_10002
	MiniGameProxy = var_1_10004

	local var_13_1 = var_1_10002(var_1_10004)

	if var_2.GetHubByHubId(var_13_1, var_13_0).count > 0 then
		return true
	end

	if var_2:getConfig("reward") ~= 0 and var_2.usedtime >= var_2:getConfig("reward_need") and var_2.ultimate == 0 then
		return true
	end

	return false
end

function var_0_1.IsShowMainTip(arg_14_0)
	assert = var_1_10001

	var_1_10001(false, "需要实现主界面入口红点逻辑")

	return
end

return var_0_1
