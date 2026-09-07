local FullPreviewMediatorTemplate = class("FullPreviewMediatorTemplate", import("view.base.ContextMediator"))

FullPreviewMediatorTemplate.GO_SCENE = "FullPreviewMediator.TemplateGO_SCENE"
FullPreviewMediatorTemplate.CHANGE_SCENE = "FullPreviewMediatorTemplate.CHANGE_SCENE"
FullPreviewMediatorTemplate.GO_SUBLAYER = "FullPreviewMediatorTemplate.GO_SUBLAYER"
FullPreviewMediatorTemplate.GO_MINIGAME = "FullPreviewMediatorTemplate.GO_MINIGAME"

function FullPreviewMediatorTemplate:register()
	self:BindEvent()

	return
end

function FullPreviewMediatorTemplate:BindEvent()
	self:bind(FullPreviewMediatorTemplate.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(FullPreviewMediatorTemplate.CHANGE_SCENE, function(arg_4_0, arg_4_1, ...)
		self:sendNotification(GAME.CHANGE_SCENE, arg_4_1, ...)

		return
	end)
	self:bind(FullPreviewMediatorTemplate.GO_SUBLAYER, function(arg_5_0, arg_5_1, arg_5_2)
		self:addSubLayers(arg_5_1, nil, arg_5_2)

		return
	end)
	self:bind(FullPreviewMediatorTemplate.GO_MINIGAME, function(arg_6_0, arg_6_1, ...)
		self:sendNotification(GAME.GO_MINI_GAME, arg_6_1, ...)

		return
	end)

	return
end

function FullPreviewMediatorTemplate:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function FullPreviewMediatorTemplate:handleNotification(arg_8_1)
	if arg_8_1:getName() == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:UpdateView((arg_8_1:getBody()))
	end

	return
end

return FullPreviewMediatorTemplate
