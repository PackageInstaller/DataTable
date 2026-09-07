local AnniversaryIslandComposite2023Mediator = class("AnniversaryIslandComposite2023Mediator", import("view.base.ContextMediator"))

AnniversaryIslandComposite2023Mediator.OPEN_FORMULA = "OPEN_FORMULA"
AnniversaryIslandComposite2023Mediator.OPEN_STOREHOUSE = "AnniversaryIslandComposite2023Mediator:OPEN_STOREHOUSE"
AnniversaryIslandComposite2023Mediator.OPEN_UPGRADE_PANEL = "AnniversaryIslandComposite2023Mediator:OPEN_UPGRADE_PANEL"

function AnniversaryIslandComposite2023Mediator:register()
	self:bind(GAME.WORKBENCH_COMPOSITE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.WORKBENCH_COMPOSITE, {
			formulaId = arg_2_1,
			repeats = arg_2_2
		})

		return
	end)
	self:bind(AnniversaryIslandComposite2023Mediator.OPEN_STOREHOUSE, function(arg_3_0)
		self:addSubLayers(Context.New({
			mediator = AnniversaryIslandStoreHouse2023Mediator,
			viewComponent = AnniversaryIslandStoreHouse2023Window
		}))

		return
	end)
	self:bind(AnniversaryIslandComposite2023Mediator.OPEN_UPGRADE_PANEL, function(arg_4_0)
		self:addSubLayers(Context.New({
			mediator = AnniversaryIslandBuildingUpgrade2023WindowMediator,
			viewComponent = AnniversaryIslandBuildingUpgrade2023Window,
			data = {
				buildingID = table.keyof(AnniversaryIsland2023Scene.Buildings, "craft")
			}
		}), true)

		return
	end)
	self:bind(WorkBenchItemDetailMediator.SHOW_DETAIL, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			mediator = WorkBenchItemDetailMediator,
			viewComponent = WorkBenchItemDetailLayer,
			data = {
				material = arg_5_1
			}
		}))

		return
	end)
	getProxy(SettingsProxy):SetWorkbenchDailyTip()

	return
end

function AnniversaryIslandComposite2023Mediator:listNotificationInterests()
	return {
		GAME.WORKBENCH_COMPOSITE_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		AnniversaryIslandComposite2023Mediator.OPEN_FORMULA
	}
end

function AnniversaryIslandComposite2023Mediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.WORKBENCH_COMPOSITE_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1)
	elseif var_7_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_7_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_WORKBENCH or var_7_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG or var_7_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2 then
			self.viewComponent:BuildActivityEnv()
			self.viewComponent:UpdateView()
		end
	elseif var_7_0 == AnniversaryIslandComposite2023Mediator.OPEN_FORMULA then
		if not var_7_1 then
			return
		end

		self.viewComponent:OnReceiveFormualRequest(var_7_1)
	end

	return
end

function AnniversaryIslandComposite2023Mediator:remove()
	return
end

return AnniversaryIslandComposite2023Mediator
