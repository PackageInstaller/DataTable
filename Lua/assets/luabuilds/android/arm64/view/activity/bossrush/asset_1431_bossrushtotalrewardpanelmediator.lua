local BossRushTotalRewardPanelMediator = class("BossRushTotalRewardPanelMediator", import("view.activity.worldboss.ActivityBossTotalRewardPanelMediator"))

BossRushTotalRewardPanelMediator.ON_WILL_EXIT = "BossRushTotalRewardPanelMediator:ON_WILL_EXIT"
BossRushTotalRewardPanelMediator.GET_NEW_SHIP = "BossRushTotalRewardPanelMediator:GET_NEW_SHIP"

function BossRushTotalRewardPanelMediator:register()
	self:bind(BossRushTotalRewardPanelMediator.GET_NEW_SHIP, function(arg_2_0, arg_2_1, arg_2_2)
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

return BossRushTotalRewardPanelMediator
