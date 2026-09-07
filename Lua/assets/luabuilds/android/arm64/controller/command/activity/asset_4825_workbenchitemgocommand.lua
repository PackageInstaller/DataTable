local WorkBenchItemGoCommand = class("WorkBenchItemGoCommand", pm.SimpleCommand)

function WorkBenchItemGoCommand:execute(arg_1_1)
	local var_1_0 = WorkBenchItem.New({
		configId = arg_1_1.body
	}):GetSource()

	if var_1_0.islandNodes then
		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(SixthAnniversaryIslandMediator) then
			self:sendNotification(SixthAnniversaryIslandMediator.DISPLAY_NODES, var_1_0.islandNodes)
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
				nodeIds = var_1_0.islandNodes
			})
		end
	elseif var_1_0.islandShop then
		local var_1_1 = getProxy(ContextProxy):getCurrentContext()

		if var_1_1:getContextByMediator(SixthAnniversaryIslandShopMediator) then
			return
		end

		if var_1_1:getContextByMediator(SixthAnniversaryIslandMediator) then
			self:sendNotification(SixthAnniversaryIslandMediator.DISPLAY_SHOP)
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
				wraps = SixthAnniversaryIslandScene.SHOP
			})
		end
	elseif var_1_0.recipeid then
		local var_1_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH)

		if not var_1_2 or var_1_2:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		local var_1_3 = WorkBenchFormula.New({
			configId = var_1_0.recipeid
		})

		var_1_3:BuildFromActivity()

		if not var_1_3:IsAvaliable() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips1"))

			return
		end

		if not var_1_3:IsUnlock() then
			local var_1_4 = var_1_3:GetLockLimit()

			pg.TipsMgr.GetInstance():ShowTips(i18n("workbench_tips4", var_1_4 and var_1_4[3]))

			return
		end

		if getProxy(ContextProxy):getCurrentContext():getContextByMediator(AnniversaryIslandComposite2023Mediator) then
			self:sendNotification(AnniversaryIslandComposite2023Mediator.OPEN_FORMULA, var_1_0.recipeid)
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_WORKBENCH, {
				formulaId = var_1_0.recipeid
			})
		end
	elseif var_1_0.taskid then
		local var_1_5 = getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_TASK_ID)

		if not var_1_5 or var_1_5:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		local var_1_6 = getProxy(ContextProxy):getCurrentContext()

		if var_1_6:getContextByMediator(IslandTaskMediator) then
			return
		end

		self:sendNotification(GAME.LOAD_LAYERS, {
			parentContext = var_1_6,
			context = Context.New({
				mediator = IslandTaskMediator,
				viewComponent = IslandTaskScene,
				data = {
					task_ids = var_1_0.taskid
				}
			})
		})
	elseif var_1_0.minigame then
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_1_0.minigame)
	end

	return
end

return WorkBenchItemGoCommand
