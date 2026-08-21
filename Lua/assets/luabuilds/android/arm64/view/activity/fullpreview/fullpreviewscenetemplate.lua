local var_0_0 = class("FullPreviewSceneTemplate", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return arg_1_0.UIName
end

function var_0_0.BindActivityShop(arg_2_0, arg_2_1)
	onButton(arg_2_0, arg_2_1, function()
		arg_2_0:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.BindSkinShop(arg_4_0, arg_4_1)
	onButton(arg_4_0, arg_4_1, function()
		arg_4_0:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.BindBuildShip(arg_6_0, arg_6_1)
	onButton(arg_6_0, arg_6_1, function()
		local var_7_0
		local var_7_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1)
		local var_7_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILD)

		if var_7_1 and not var_7_1:isEnd() then
			var_7_0 = BuildShipScene.PROJECTS.ACTIVITY
		elseif var_7_2 and not var_7_2:isEnd() then
			var_7_0 = ({
				BuildShipScene.PROJECTS.SPECIAL,
				BuildShipScene.PROJECTS.LIGHT,
				BuildShipScene.PROJECTS.HEAVY
			})[var_7_2:getConfig("config_client").id]
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_6_0:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_7_0
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.BindBattle(arg_8_0, arg_8_1)
	onButton(arg_8_0, arg_8_1, function()
		local var_9_0 = getProxy(ChapterProxy)
		local var_9_1, var_9_2 = var_9_0:getLastMapForActivity()

		if var_9_1 then
			if not var_9_0:getMapById(var_9_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
			else
				arg_8_0:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.LEVEL, {
					chapterId = var_9_2,
					mapIdx = var_9_1
				})
			end

			return
		end
	end, SFX_PANEL)

	return
end

function var_0_0.BindMiniGame(arg_10_0, arg_10_1, arg_10_2)
	onButton(arg_10_0, arg_10_1, function()
		arg_10_0:emit(FullPreviewMediatorTemplate.GO_MINIGAME, arg_10_2)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateView(arg_12_0)
	return
end

function var_0_0.IsMiniGameTip(arg_13_0)
	local var_13_0 = getProxy(MiniGameProxy):GetHubByHubId(pg.mini_game[arg_13_0].hub_id)

	if var_13_0.count > 0 then
		return true
	end

	if var_13_0:getConfig("reward") ~= 0 and var_13_0.usedtime >= var_13_0:getConfig("reward_need") and var_13_0.ultimate == 0 then
		return true
	end

	return false
end

function var_0_0.IsShowMainTip(arg_14_0)
	assert(false, "需要实现主界面入口红点逻辑")

	return
end

return var_0_0
