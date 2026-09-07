local LevelStageTotalRewardPanelMediator = class("LevelStageTotalRewardPanelMediator", import("view.base.ContextMediator"))

function LevelStageTotalRewardPanelMediator:register()
	self:bind(LevelMediator2.ON_RETRACKING, function(arg_2_0, ...)
		self:sendNotification(LevelMediator2.ON_RETRACKING, (packEx(...)))

		return
	end)

	return
end

return LevelStageTotalRewardPanelMediator
