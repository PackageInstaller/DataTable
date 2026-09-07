local IslandTaskGoCommand = class("IslandTaskGoCommand", pm.SimpleCommand)

function IslandTaskGoCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1.body.taskVO:getConfig("scene")

	if var_1_0 and #var_1_0 > 0 then
		if var_1_0[1] == "ANNIVERSARY_ISLAND_SEA" then
			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(SixthAnniversaryIslandMediator) then
				self:sendNotification(SixthAnniversaryIslandMediator.DISPLAY_NODES, var_1_0[2].nodeIds)
			else
				self:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
					nodeIds = var_1_0[2].nodeIds
				})
			end
		elseif var_1_0[1] == "ANNIVERSARY_ISLAND_WORKBENCH" then
			local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH)

			if not var_1_1 or var_1_1:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			local var_1_2 = AcessWithinNull(var_1_0[2], "formulaId")

			if var_1_2 and var_1_2 > 0 then
				local var_1_3 = WorkBenchFormula.New({
					configId = var_1_2
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
			end

			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(AnniversaryIslandComposite2023Mediator) then
				self:sendNotification(AnniversaryIslandComposite2023Mediator.OPEN_FORMULA, var_1_2)
			else
				self:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_WORKBENCH, {
					formulaId = var_1_2
				})
			end
		elseif var_1_0[1] == "ISLAND_BUILDING" then
			local var_1_5 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(AnniversaryIsland2023Mediator)
			local var_1_6 = Context.New({
				mediator = AnniversaryIslandBuildingUpgrade2023WindowMediator,
				viewComponent = AnniversaryIslandBuildingUpgrade2023Window,
				data = {
					isLayer = true,
					buildingID = var_1_0[2].build
				}
			})

			if var_1_5 then
				self:sendNotification(GAME.LOAD_LAYERS, {
					parentContext = var_1_5,
					context = var_1_6
				})
			else
				local var_1_7 = Context.New()

				SCENE.SetSceneInfo(var_1_7, SCENE.ANNIVERSARY_ISLAND_BACKHILL_2023)
				var_1_7:addChild(var_1_6)
				print("load scene: " .. SCENE.ANNIVERSARY_ISLAND_BACKHILL_2023)
				self:sendNotification(GAME.LOAD_SCENE, {
					context = var_1_7
				})
			end
		else
			local var_1_8 = Context.New()

			SCENE.SetSceneInfo(var_1_8, SCENE[var_1_0[1]])

			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(var_1_8.mediator) then
				warning("Enter Current Context")

				return
			end

			self:sendNotification(GAME.GO_SCENE, SCENE[var_1_0[1]], var_1_0[2])
		end
	end

	return
end

return IslandTaskGoCommand
