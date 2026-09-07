local Monopoly3thPage = class("Monopoly3thPage", import("....base.BaseActivityPage"))

Monopoly3thPage.ON_START = "MonopolyGame:ON_START"
Monopoly3thPage.ON_MOVE = "MonopolyGame:ON_MOVE"
Monopoly3thPage.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
Monopoly3thPage.ON_AWARD = "MonopolyGame:ON_AWARD"
Monopoly3thPage.MONOPOLY_OP_LAST = "MonopolyGame:MONOPOLY_OP_LAST"

function Monopoly3thPage:OnInit()
	self:bind(Monopoly3thPage.MONOPOLY_OP_LAST, function(arg_2_0, arg_2_1, arg_2_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_LAST,
			callback = arg_2_2
		})

		return
	end)
	self:bind(Monopoly3thPage.ON_START, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_3_2
		})

		return
	end)
	self:bind(Monopoly3thPage.ON_MOVE, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_4_2
		})

		return
	end)
	self:bind(Monopoly3thPage.ON_TRIGGER, function(arg_5_0, arg_5_1, arg_5_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_5_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_5_2
		})

		return
	end)
	self:bind(Monopoly3thPage.ON_AWARD, function(arg_6_0)
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.REDPACKEY)

		return
	end)

	return
end

function Monopoly3thPage.getLeftRpCount()
	local var_7_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	return var_7_0.data2_list[1] - var_7_0.data2_list[2]
end

function Monopoly3thPage:OnFirstFlush()
	return
end

function Monopoly3thPage:OnUpdateFlush()
	self:updateGameUI()

	return
end

function Monopoly3thPage:updateGameUI()
	if not self.activity then
		return
	end

	if self.gameUI then
		self.gameUI:updataActivity(self.activity)
	else
		self.gameUI = Monopoly3thGame.New(self, findTF(self._tf, "AD"), self.event, 4)

		self.gameUI:firstUpdata(self.activity)
	end

	return
end

function Monopoly3thPage:OnDestroy()
	self.gameUI:dispose()

	return
end

return Monopoly3thPage
