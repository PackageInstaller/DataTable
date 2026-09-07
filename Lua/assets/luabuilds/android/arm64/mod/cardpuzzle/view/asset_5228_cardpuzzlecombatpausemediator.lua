local CardPuzzleCombatPauseMediator = class("CardPuzzleCombatPauseMediator", ContextMediator)

CardPuzzleCombatPauseMediator.QUIT_COMBAT = "QUIT_COMBAT"
CardPuzzleCombatPauseMediator.RESUME_COMBAT = "RESUME_COMBAT"

function CardPuzzleCombatPauseMediator:register()
	self:bind(CardPuzzleCombatPauseMediator.QUIT_COMBAT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.QUIT_BATTLE)

		return
	end)
	self:bind(CardPuzzleCombatPauseMediator.RESUME_COMBAT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.RESUME_BATTLE)

		return
	end)

	return
end

function CardPuzzleCombatPauseMediator:listNotificationInterests()
	return {}
end

function CardPuzzleCombatPauseMediator:remove()
	return
end

function CardPuzzleCombatPauseMediator:onBackPressed(arg_6_1)
	self:sendNotification(GAME.RESUME_BATTLE)
	CardPuzzleCombatPauseMediator.super.onBackPressed(self, arg_6_1)

	return
end

return CardPuzzleCombatPauseMediator
