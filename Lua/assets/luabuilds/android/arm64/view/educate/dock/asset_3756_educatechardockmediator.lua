local EducateCharDockMediator = class("EducateCharDockMediator", import("view.base.ContextMediator"))

EducateCharDockMediator.GO_PROFILE = "EducateCharDockMediator:GO_PROFILE"
EducateCharDockMediator.ON_SELECTED = "EducateCharDockMediator:ON_SELECTED"
EducateCharDockMediator.ON_SKIN_SHOP = "EducateCharDockMediator.ON_SKIN_SHOP"

function EducateCharDockMediator:register()
	self:bind(EducateCharDockMediator.ON_SELECTED, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.CHANGE_EDUCATE, {
			id = arg_2_1
		})

		return
	end)
	self:bind(EducateCharDockMediator.GO_PROFILE, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.EDUCATE_PROFILE, {
			selectedCharacterId = arg_3_1
		})

		return
	end)
	self:bind(EducateCharDockMediator.ON_SKIN_SHOP, function(arg_4_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP, {
			skinId = arg_4_0
		})

		return
	end)

	return
end

function EducateCharDockMediator:listNotificationInterests()
	return {
		GAME.CLEAR_EDUCATE_TIP
	}
end

function EducateCharDockMediator:handleNotification(arg_6_1)
	if arg_6_1:getName() == GAME.CLEAR_EDUCATE_TIP then
		self.viewComponent:emit(EducateCharDockScene.MSG_CLEAR_TIP, arg_6_1:getBody().id)
	end

	return
end

return EducateCharDockMediator
