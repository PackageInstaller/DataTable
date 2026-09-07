local SuperBulinPopMediator = class("SuperBulinPopMediator", import("..base.ContextMediator"))

SuperBulinPopMediator.ON_SIMULATION_COMBAT = "event simulation combat"

function SuperBulinPopMediator:register()
	self:bind(SuperBulinPopMediator.ON_SIMULATION_COMBAT, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SIMULATION,
			stageId = arg_2_1.stageId,
			warnMsg = arg_2_1.warnMsg,
			exitCallback = arg_2_2
		})

		return
	end)

	return
end

return SuperBulinPopMediator
