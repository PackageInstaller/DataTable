local ReversePacmanGameMediator = class("ReversePacmanGameMediator", import("view.base.ContextMediator"))

ReversePacmanGameMediator.GO_SCENE = "ReversePacmanGameMediator.GO_SCENE"
ReversePacmanGameMediator.GO_SUBLAYER = "ReversePacmanGameMediator.GO_SUBLAYER"
ReversePacmanGameMediator.SETTLE_GAME = "ReversePacmanGameMediator.SETTLE_GAME"

function ReversePacmanGameMediator:register()
	self:bind(ReversePacmanGameMediator.GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	self:bind(ReversePacmanGameMediator.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	self:bind(ReversePacmanGameMediator.SETTLE_GAME, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.REVERSE_PACMAN_PASS_LEVEL, {
			actId = arg_4_1.actId,
			levelId = arg_4_1.levelId,
			time = arg_4_1.time
		})

		return
	end)

	return
end

function ReversePacmanGameMediator:listNotificationInterests()
	return {
		GAME.REVERSE_PACMAN_PASS_LEVEL_DONE
	}
end

function ReversePacmanGameMediator:handleNotification(arg_6_1)
	if arg_6_1:getName() == GAME.REVERSE_PACMAN_PASS_LEVEL_DONE then
		self.viewComponent:ShowSettlePanel(arg_6_1:getBody().awards)
	end

	return
end

return ReversePacmanGameMediator
