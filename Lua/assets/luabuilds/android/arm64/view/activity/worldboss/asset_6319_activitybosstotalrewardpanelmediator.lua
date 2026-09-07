local ActivityBossTotalRewardPanelMediator = class("ActivityBossTotalRewardPanelMediator", import("view.base.ContextMediator"))

ActivityBossTotalRewardPanelMediator.GET_NEW_SHIP = "ActivityBossTotalRewardPanelMediator:GET_NEW_SHIP"

function ActivityBossTotalRewardPanelMediator:register()
	self:bind(ActivityBossTotalRewardPanelMediator.GET_NEW_SHIP, function(arg_2_0, arg_2_1, arg_2_2)
		self:addSubLayers(Context.New({
			mediator = NewShipMediator,
			viewComponent = NewShipLayer,
			data = {
				ship = arg_2_1
			},
			onRemoved = arg_2_2
		}))

		return
	end)
	getProxy(SettingsProxy):ResetContinuousOperationAutoSub()

	return
end

return ActivityBossTotalRewardPanelMediator
