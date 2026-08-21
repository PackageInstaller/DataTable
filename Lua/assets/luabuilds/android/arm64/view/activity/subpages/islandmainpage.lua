local var_0_0 = class("IslandMainPage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.initBtn(arg_1_0)
	var_0_0.super.initBtn(arg_1_0)

	function arg_1_0.btnFuncList.shop(arg_2_0)
		onButton(arg_1_0, arg_2_0, function()
			local var_3_0 = underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_4_0)
				return arg_4_0:getConfig("config_id") == 3
			end)

			if not var_3_0 or var_3_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

				return
			end

			local var_3_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)

			if var_3_1 and not var_3_1:isEnd() then
				arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
					wraps = SixthAnniversaryIslandScene.SHOP
				})
			else
				arg_1_0:emit(ActivityMediator.OPEN_LAYER, Context.New({
					mediator = SixthAnniversaryIslandShopMediator,
					viewComponent = SixthAnniversaryIslandShopLayer
				}))
			end

			return
		end, SFX_PANEL)

		return
	end

	function arg_1_0.btnFuncList.activity(arg_5_0)
		onButton(arg_1_0, arg_5_0, function()
			local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)

			if not var_6_0 or var_6_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

				return
			end

			arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA)

			return
		end, SFX_PANEL)

		return
	end

	function arg_1_0.btnFuncList.mountain(arg_7_0)
		onButton(arg_1_0, arg_7_0, function()
			local var_8_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

			if not var_8_0 or var_8_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

				return
			end

			arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ANNIVERSARY_ISLAND_BACKHILL_2023)

			return
		end, SFX_PANEL)

		return
	end

	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	for iter_9_0, iter_9_1 in pairs({
		shop = function()
			return underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_11_0)
				return arg_11_0:getConfig("config_id") == 3
			end)
		end,
		activity = function()
			return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)
		end,
		mountain = function()
			return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)
		end
	}) do
		local var_9_0 = iter_9_1()

		setButtonEnabled(arg_9_0.btnList:Find(iter_9_0), tobool(var_9_0 and not var_9_0:isEnd()))
	end

	return
end

return var_0_0
