local CultivatingPlantMediator = class("CultivatingPlantMediator", import("view.base.ContextMediator"))

CultivatingPlantMediator.GO_SCENE = "CultivatingPlantMediator::GO_SCENE"
CultivatingPlantMediator.ON_TASK_SUBMIT = "CultivatingPlantMediator::ON_TASK_SUBMIT"

function CultivatingPlantMediator:register()
	self:bind(CultivatingPlantMediator.GO_SCENE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.NEW_EDUCATE_SELECT)

		return
	end)
	self:bind(CultivatingPlantMediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK_V2, arg_3_1.id)

		return
	end)

	return
end

function CultivatingPlantMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.SUBMIT_ACTIVITY_TASK_V2_DONE] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:RefreshSubmitTaskDone()

			return
		end
	}

	return
end

function CultivatingPlantMediator:remove()
	return
end

return CultivatingPlantMediator
