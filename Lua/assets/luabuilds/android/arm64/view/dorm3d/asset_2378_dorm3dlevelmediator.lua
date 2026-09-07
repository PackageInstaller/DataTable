local Dorm3dLevelMediator = class("Dorm3dLevelMediator", import("view.base.ContextMediator"))

Dorm3dLevelMediator.CHANGE_SKIN = "Dorm3dLevelMediator.CHANGE_SKIN"
Dorm3dLevelMediator.CHAMGE_TIME = "Dorm3dLevelMediator.CHAMGE_TIME"
Dorm3dLevelMediator.ON_DROP_CLIENT = "Dorm3dLevelMediator.ON_DROP_CLIENT"
Dorm3dLevelMediator.RENAME = "Dorm3dLevelMediator.RENAME"
Dorm3dLevelMediator.RENAME_RESET = "Dorm3dLevelMediator.RENAME_RESET"
Dorm3dLevelMediator.UPDATE_FAVOR_DISPLAY = "UpdateFavorDisplay"

function Dorm3dLevelMediator:register()
	self:bind(Dorm3dLevelMediator.CHANGE_SKIN, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.APARTMENT_CHANGE_SKIN, {
			groupId = arg_2_1,
			skinId = arg_2_2
		})
		self.viewComponent:closeView()

		return
	end)
	self:bind(Dorm3dLevelMediator.CHAMGE_TIME, function(arg_3_0, arg_3_1)
		self:sendNotification(Dorm3dRoomMediator.CHAMGE_TIME_RELOAD_SCENE, {
			timeIndex = arg_3_1
		})
		self.viewComponent:closeView()

		return
	end)
	self:bind(Dorm3dLevelMediator.ON_DROP_CLIENT, function(arg_4_0, arg_4_1)
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_DROP_CLIENT, arg_4_1)

		return
	end)
	self:bind(Dorm3dLevelMediator.RENAME, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.DORM_SET_CALL, {
			groupId = arg_5_1,
			callName = arg_5_2
		})

		return
	end)
	self:bind(Dorm3dLevelMediator.RENAME_RESET, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.DORM_SET_CALL, {
			callName = "",
			groupId = arg_6_1
		})

		return
	end)
	self:bind(Dorm3dLevelMediator.UPDATE_FAVOR_DISPLAY, function(arg_7_0)
		self:sendNotification(Dorm3dRoomMediator.UPDATE_FAVOR_DISPLAY)

		return
	end)
	self.viewComponent:SetApartment(self.contextData.apartment)

	return
end

function Dorm3dLevelMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.DORM_SET_CALL_DONE] = function(arg_9_0, arg_9_1)
			arg_9_0.viewComponent:SetApartment(arg_9_1:getBody().apartment)
			arg_9_0.viewComponent:CloseRenameWindow()

			return
		end
	}

	return
end

function Dorm3dLevelMediator:remove()
	return
end

return Dorm3dLevelMediator
