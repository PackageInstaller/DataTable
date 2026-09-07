local FullPreviewSceneTemplate = class("FullPreviewSceneTemplate", import("view.base.BaseUI"))

function FullPreviewSceneTemplate:getUIName()
	return self.UIName
end

function FullPreviewSceneTemplate:BindActivityShop(arg_2_1)
	onButton(self, arg_2_1, function()
		self:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end, SFX_PANEL)

	return
end

function FullPreviewSceneTemplate:BindSkinShop(arg_4_1)
	onButton(self, arg_4_1, function()
		self:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)

	return
end

function FullPreviewSceneTemplate:BindBuildShip(arg_6_1)
	onButton(self, arg_6_1, function()
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

		self:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = var_7_0
		})

		return
	end, SFX_PANEL)

	return
end

function FullPreviewSceneTemplate:BindBattle(arg_8_1)
	onButton(self, arg_8_1, function()
		local var_9_0 = getProxy(ChapterProxy)
		local var_9_1, var_9_2 = var_9_0:getLastMapForActivity()

		if var_9_1 then
			if not var_9_0:getMapById(var_9_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				goto label_9_0
			end
		end

		self:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_9_2,
			mapIdx = var_9_1
		})

		::label_9_0::

		return
	end, SFX_PANEL)

	return
end

function FullPreviewSceneTemplate:BindMiniGame(arg_10_1, arg_10_2)
	onButton(self, arg_10_1, function()
		self:emit(FullPreviewMediatorTemplate.GO_MINIGAME, arg_10_2)

		return
	end, SFX_PANEL)

	return
end

function FullPreviewSceneTemplate:UpdateView()
	return
end

function FullPreviewSceneTemplate:IsMiniGameTip()
	local var_13_0 = getProxy(MiniGameProxy):GetHubByHubId(pg.mini_game[self].hub_id)

	if var_13_0.count > 0 then
		return true
	end

	if var_13_0:getConfig("reward") ~= 0 and var_13_0.usedtime >= var_13_0:getConfig("reward_need") and var_13_0.ultimate == 0 then
		return true
	end

	return false
end

function FullPreviewSceneTemplate:IsShowMainTip()
	assert(false, "需要实现主界面入口红点逻辑")

	return
end

return FullPreviewSceneTemplate
