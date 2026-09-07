local ChallengePreCombatMediator = class("ChallengePreCombatMediator", import("..base.ContextMediator"))

ChallengePreCombatMediator.ON_START = "ChallengePreCombatMediator:ON_START"
ChallengePreCombatMediator.ON_SWITCH_SHIP = "ChallengePreCombatMediator:ON_SWITCH_SHIP"
ChallengePreCombatMediator.ON_AUTO = "ChallengePreCombatMediator:ON_AUTO"
ChallengePreCombatMediator.ON_SUB_AUTO = "ChallengePreCombatMediator:ON_SUB_AUTO"

function ChallengePreCombatMediator:register()
	local var_1_0 = self.contextData.mode
	local var_1_1 = getProxy(ChallengeProxy):getUserChallengeInfo(self.contextData.mode)

	self:bind(ChallengePreCombatMediator.ON_AUTO, function(arg_2_0, arg_2_1)
		self:onAutoBtn(arg_2_1)

		return
	end)
	self:bind(ChallengePreCombatMediator.ON_SUB_AUTO, function(arg_3_0, arg_3_1)
		self:onAutoSubBtn(arg_3_1)

		return
	end)
	self:bind(ChallengePreCombatMediator.ON_START, function(arg_4_0)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_CHALLENGE,
			mode = var_1_0
		})

		return
	end)
	self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getData())
	self.viewComponent:setSubFlag(#var_1_1:getSubmarineFleet():getShipsByTeam(TeamType.Submarine, false) > 0)
	self.viewComponent:updateChallenge(var_1_1)

	return
end

function ChallengePreCombatMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_ERRO,
		GAME.BEGIN_STAGE_DONE,
		ChallengeProxy.CHALLENGE_UPDATED
	}
end

function ChallengePreCombatMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getData())
	elseif var_6_0 == GAME.BEGIN_STAGE_ERRO then
		if var_6_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					self.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_6_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_6_1)
	end

	return
end

function ChallengePreCombatMediator:onAutoBtn(arg_8_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_8_1.isOn,
		toggle = arg_8_1.toggle
	})

	return
end

function ChallengePreCombatMediator:onAutoSubBtn(arg_9_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_9_1.isOn,
		toggle = arg_9_1.toggle
	})

	return
end

return ChallengePreCombatMediator
