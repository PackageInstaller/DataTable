local NewSkinTBMediator = class("NewSkinTBMediator", import("..base.ContextMediator"))

NewSkinTBMediator.ON_EXIT = "NewSkinTBMediator:ON_EXIT"
NewSkinTBMediator.GO_SET_TB_SKIN = "NewSkinTBMediator:GO_SET_TB_SKIN"

function NewSkinTBMediator:register()
	self:bind(NewSkinTBMediator.GO_SET_TB_SKIN, function(arg_2_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.EDUCATE_DOCK, {
			OnSelected = function(arg_3_0)
				self:sendNotification(GAME.CHANGE_EDUCATE, {
					id = arg_3_0
				})

				return
			end,
			tbSkinId = self.contextData.skinId
		})

		return
	end)

	self.contextData.secId = NewEducateHelper.GetSecIdBySkinId(self.contextData.skinId)
	self.contextData.isClose = getProxy(PlayerProxy):getRawData():GetEducateCharacter() == self.contextData.secId

	self.viewComponent:setSkin(self.contextData.skinId)

	return
end

function NewSkinTBMediator:onUIAvalible()
	return
end

function NewSkinTBMediator:listNotificationInterests()
	return {}
end

function NewSkinTBMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return NewSkinTBMediator
