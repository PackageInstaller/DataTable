local MonopolyPage = class("MonopolyPage", import("....base.BaseActivityPage"))

MonopolyPage.ON_START = "MonopolyGame:ON_START"
MonopolyPage.ON_MOVE = "MonopolyGame:ON_MOVE"
MonopolyPage.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
MonopolyPage.ON_AWARD = "MonopolyGame:ON_AWARD"

function MonopolyPage:OnInit()
	self.bg = self._tf:Find("AD")

	self:bind(MonopolyPage.ON_START, function(arg_2_0, arg_2_1, arg_2_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_2_2
		})

		return
	end)
	self:bind(MonopolyPage.ON_MOVE, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_3_2
		})

		return
	end)
	self:bind(MonopolyPage.ON_TRIGGER, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_4_2
		})

		return
	end)
	self:bind(MonopolyPage.ON_AWARD, function(arg_5_0)
		self:emit(ActivityMediator.OPEN_LAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer
		}))

		return
	end)

	return
end

function MonopolyPage:OnFirstFlush()
	return
end

function MonopolyPage:OnUpdateFlush()
	if not self.game then
		self.game = import("view.activity.subPages.Monopoly.game.MomopolyGame").New()

		self.game:SetUp(self, self.activity)
	else
		self.game:NetActivity(self.activity)
	end

	return
end

function MonopolyPage:OnDestroy()
	self.game:Destroy()

	return
end

return MonopolyPage
