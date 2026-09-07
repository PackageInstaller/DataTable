local ContinuousOperationMediator = class("ContinuousOperationMediator", import("view.base.ContextMediator"))

ContinuousOperationMediator.CONTINUE_OPERATION = "ContinuousOperationMediator:CONTINUE_OPERATION"
ContinuousOperationMediator.ON_REENTER = "ContinuousOperationMediator:ON_REENTER"

function ContinuousOperationMediator:register()
	self:bind(GAME.PAUSE_BATTLE, function()
		self:sendNotification(GAME.PAUSE_BATTLE)

		return
	end)
	self:bind(ContinuousOperationMediator.ON_REENTER, function()
		self:sendNotification(ContinuousOperationMediator.ON_REENTER, {
			autoFlag = self.contextData.autoFlag
		})

		return
	end)
	self:bind(BattleMediator.HIDE_ALL_BUTTONS, function(arg_4_0, arg_4_1)
		self:sendNotification(BattleMediator.HIDE_ALL_BUTTONS, arg_4_1)

		if not arg_4_1 then
			local var_4_0 = ys.Battle.BattleState.GetInstance()

			if not var_4_0.IsAutoBotActive(SYSTEM_ACT_BOSS) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_auto_on"))
				self:sendNotification(GAME.AUTO_BOT, {
					isActiveBot = false
				})
				self:sendNotification(GAME.AUTO_SUB, {
					isActiveSub = false
				})
				var_4_0:ActiveBot(var_4_0.IsAutoBotActive(SYSTEM_ACT_BOSS))
			end
		end

		return
	end)

	return
end

function ContinuousOperationMediator:listNotificationInterests()
	return {
		NewBattleResultMediator.ON_ENTER_BATTLE_RESULT,
		NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT
	}
end

function ContinuousOperationMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == NewBattleResultMediator.ON_ENTER_BATTLE_RESULT then
		self:sendNotification(NewBattleResultMediator.SET_SKIP_FLAG, true)
		self.viewComponent:OnEnterBattleResult()
	elseif var_6_0 == NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT then
		self.viewComponent:AnimatingSlider()
	end

	return
end

function ContinuousOperationMediator:remove()
	return
end

return ContinuousOperationMediator
