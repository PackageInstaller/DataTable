local Monopoly3thRePage = class("Monopoly3thRePage", import("....base.BaseActivityPage"))

Monopoly3thRePage.ON_START = "MonopolyGame:ON_START"
Monopoly3thRePage.ON_MOVE = "MonopolyGame:ON_MOVE"
Monopoly3thRePage.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
Monopoly3thRePage.ON_AWARD = "MonopolyGame:ON_AWARD"
Monopoly3thRePage.MONOPOLY_OP_LAST = "MonopolyGame:MONOPOLY_OP_LAST"
Monopoly3thRePage.ON_STOP = "MonopolyGame:MONOPOLY_ON_STOP"
Monopoly3thRePage.AWARDS = {}

function Monopoly3thRePage:OnInit()
	self:bind(Monopoly3thRePage.ON_STOP, function(arg_2_0, arg_2_1, arg_2_2)
		if not self.gameUI.autoFlag and #Monopoly3thRePage.AWARDS > 0 then
			self:emit(BaseUI.ON_ACHIEVE, Monopoly3thRePage.AWARDS, arg_2_2)

			Monopoly3thRePage.AWARDS = {}
		end

		return
	end)
	self:bind(Monopoly3thRePage.MONOPOLY_OP_LAST, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_LAST,
			callback = arg_3_2
		})

		return
	end)
	self:bind(Monopoly3thRePage.ON_START, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_4_2
		})

		return
	end)
	self:bind(Monopoly3thRePage.ON_MOVE, function(arg_5_0, arg_5_1, arg_5_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_5_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_5_2
		})

		return
	end)
	self:bind(Monopoly3thRePage.ON_TRIGGER, function(arg_6_0, arg_6_1, arg_6_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_6_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_6_2
		})

		return
	end)
	self:bind(Monopoly3thRePage.ON_AWARD, function(arg_7_0)
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.REDPACKEY)

		return
	end)

	return
end

function Monopoly3thRePage.getLeftRpCount()
	local var_8_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	return var_8_0.data2_list[1] - var_8_0.data2_list[2]
end

function Monopoly3thRePage:onAward(arg_9_1, arg_9_2)
	for iter_9_0 = 1, #arg_9_1 do
		table.insert(Monopoly3thRePage.AWARDS, arg_9_1[iter_9_0])
	end

	if self.gameUI.autoFlag then
		self.gameUI:addAwards(arg_9_1)

		if arg_9_2 then
			arg_9_2()
		end
	else
		self:emit(BaseUI.ON_ACHIEVE, Monopoly3thRePage.AWARDS, arg_9_2)

		Monopoly3thRePage.AWARDS = {}
	end

	return
end

function Monopoly3thRePage:OnUpdateFlush()
	self:updateGameUI()

	return
end

function Monopoly3thRePage:updateGameUI()
	if not self.activity then
		return
	end

	if self.gameUI then
		self.gameUI:updataActivity(self.activity)
	else
		self.gameUI = Monopoly3thReGame.New(self, findTF(self._tf, "AD"), self.event, 4)

		self.gameUI:firstUpdata(self.activity)

		if not self.gameUI.autoFlag and #Monopoly3thRePage.AWARDS > 0 then
			self:emit(BaseUI.ON_ACHIEVE, Monopoly3thRePage.AWARDS, function()
				return
			end)

			Monopoly3thRePage.AWARDS = {}
		end
	end

	return
end

function Monopoly3thRePage:OnDestroy()
	if self.gameUI then
		Monopoly3thRePage.AWARDS = {}

		self.gameUI:dispose()

		self.gameUI = nil
	end

	return
end

function Monopoly3thRePage:OnHideFlush()
	if self.gameUI then
		Monopoly3thRePage.AWARDS = {}

		self.gameUI:dispose()

		self.gameUI = nil
	end

	return
end

return Monopoly3thRePage
