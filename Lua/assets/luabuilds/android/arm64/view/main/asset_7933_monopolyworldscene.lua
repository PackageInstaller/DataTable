local MonopolyWorldScene = class("MonopolyWorldScene", import("..base.BaseUI"))

MonopolyWorldScene.ON_START = "MonopolyGame:ON_START"
MonopolyWorldScene.ON_MOVE = "MonopolyGame:ON_MOVE"
MonopolyWorldScene.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
MonopolyWorldScene.ON_AWARD = "MonopolyGame:ON_AWARD"
MonopolyWorldScene.ON_CLOSE = "MonopolyGame:ON_CLOSE"

function MonopolyWorldScene:getUIName()
	return "MonopolyWorldUI"
end

function MonopolyWorldScene:init()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	self:bind(MonopolyWorldScene.ON_START, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_3_2
		})

		return
	end)
	self:bind(MonopolyWorldScene.ON_MOVE, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_4_2
		})

		return
	end)
	self:bind(MonopolyWorldScene.ON_TRIGGER, function(arg_5_0, arg_5_1, arg_5_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_5_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_5_2
		})

		return
	end)
	self:bind(MonopolyWorldScene.ON_AWARD, function(arg_6_0)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = self.activity.id,
			cmd = ActivityConst.MONOPOLY_OP_AWARD
		})

		return
	end)

	self.gameUI = MonopolyWorldGame.New(self, findTF(self._tf, "AD"), self.event)

	self.gameUI:firstUpdata(self.activity)

	return
end

function MonopolyWorldScene:willExit()
	if self.gameUI then
		self.gameUI:dispose()
	end

	return
end

function MonopolyWorldScene:onBackPressed()
	if self.gameUI.inAnimatedFlag then
		return
	end

	self:emit(MonopolyWorldScene.ON_BACK_PRESSED)

	return
end

return MonopolyWorldScene
