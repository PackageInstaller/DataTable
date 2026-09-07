local LinerBackHillMediator = class("LinerBackHillMediator", import("..TemplateMV.BackHillMediatorTemplate"))

LinerBackHillMediator.GO_MINIGAME = "GO_MINIGAME"

function LinerBackHillMediator:register()
	self:BindEvent()
	self:bind(LinerBackHillMediator.GO_MINIGAME, function(arg_2_0, arg_2_1, ...)
		self:sendNotification(GAME.GO_MINI_GAME, arg_2_1, ...)

		return
	end)

	return
end

function LinerBackHillMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.ACTIVITY_LINER_OP_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:UpdateView()

			return
		end
	}

	return
end

return LinerBackHillMediator
