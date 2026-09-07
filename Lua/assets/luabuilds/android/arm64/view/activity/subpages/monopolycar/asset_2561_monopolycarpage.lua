local MonopolyCarPage = class("MonopolyCarPage", import("....base.BaseActivityPage"))

MonopolyCarPage.ON_START = "MonopolyGame:ON_START"
MonopolyCarPage.ON_MOVE = "MonopolyGame:ON_MOVE"
MonopolyCarPage.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
MonopolyCarPage.ON_AWARD = "MonopolyGame:ON_AWARD"

function MonopolyCarPage:OnInit()
	self:bind(MonopolyCarPage.ON_START, function(arg_2_0, arg_2_1, arg_2_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_2_2
		})

		return
	end)
	self:bind(MonopolyCarPage.ON_MOVE, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_3_2
		})

		return
	end)
	self:bind(MonopolyCarPage.ON_TRIGGER, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_4_2
		})

		return
	end)
	self:bind(MonopolyCarPage.ON_AWARD, function(arg_5_0)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = self.activity.id,
			cmd = ActivityConst.MONOPOLY_OP_AWARD
		})

		return
	end)

	return
end

function MonopolyCarPage:OnFirstFlush()
	return
end

function MonopolyCarPage:OnUpdateFlush()
	if self.gameUI then
		self.gameUI:updataActivity(self.activity)
	else
		self.gameUI = MonopolyCarGame.New(self, findTF(self._tf, "AD"), self.event)

		self.gameUI:firstUpdata(self.activity)
	end

	return
end

function MonopolyCarPage:OnDestroy()
	return
end

return MonopolyCarPage
