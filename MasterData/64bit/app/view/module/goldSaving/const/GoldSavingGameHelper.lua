return {
	openGame = function(self, arg_1_1, arg_1_2)
		if self.type == 1 then
			g.core.model.User.goldSavingData:onS2CGoldSavingGameStart(arg_1_1)
			g.core.module.ModuleManager:pushModule(g.view.entrance.GOLD_SAVING_TURN_CARD, {
				cfg = self,
				content = arg_1_1,
				actId = arg_1_2
			})
		elseif self.type == 2 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.RED_PACKET_RAIN, {
				cfg = self,
				content = arg_1_1,
				actId = arg_1_2
			})
		elseif self.type == 3 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.GOLD_SAVING_TURN_GAME, {
				cfg = self,
				content = arg_1_1,
				actId = arg_1_2
			})
		elseif self.type == 4 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.GOLD_SAVING_TURN_GAME, {
				cfg = self,
				actId = arg_1_2
			})
		end
	end
}
