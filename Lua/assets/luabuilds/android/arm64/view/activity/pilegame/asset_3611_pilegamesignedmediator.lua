local PileGameSignedMediator = class("PileGameSignedMediator", import("...base.ContextMediator"))

PileGameSignedMediator.ON_GET_AWARD = "PileGameSignedMediator:ON_GET_AWARD"
PileGameSignedMediator.MINIGAME_ID = 5

function PileGameSignedMediator:register()
	self:bind(PileGameSignedMediator.ON_GET_AWARD, function(arg_2_0)
		self:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = PileGameSignedMediator.MINIGAME_ID,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})

		return
	end)
	self.viewComponent:SetData((getProxy(MiniGameProxy):GetHubByHubId(PileGameSignedMediator.MINIGAME_ID)))

	return
end

function PileGameSignedMediator:listNotificationInterests()
	return {
		MiniGameProxy.ON_HUB_DATA_UPDATE
	}
end

function PileGameSignedMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == MiniGameProxy.ON_HUB_DATA_UPDATE then
		self.viewComponent:SetData((arg_4_1:getBody()))
		self.viewComponent:UpdateSigned()
	end

	return
end

return PileGameSignedMediator
