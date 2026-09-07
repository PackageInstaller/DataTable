local InstagramMainMediator = class("InstagramMainMediator", import("...base.ContextMediator"))

InstagramMainMediator.OPEN_CHAT = "InstagramMainMediator:OPEN_CHAT"
InstagramMainMediator.OPEN_JUUS = "InstagramMainMediator:OPEN_JUUS"
InstagramMainMediator.CLOSE_CHAT = "InstagramMainMediator:CLOSE_CHAT"
InstagramMainMediator.CLOSE_JUUS = "InstagramMainMediator:CLOSE_JUUS"
InstagramMainMediator.CHANGE_JUUS_TIP = "InstagramMainMediator:CHANGE_JUUS_TIP"
InstagramMainMediator.CHANGE_CHAT_TIP = "InstagramMainMediator:CHANGE_CHAT_TIP"
InstagramMainMediator.CLOSE_ALL = "InstagramMainMediator:CLOSE_ALL"
InstagramMainMediator.CLOSE_JUUS_DETAIL = "InstagramMainMediator:CLOSE_JUUS_DETAIL"
InstagramMainMediator.JUUS_BACK_PRESSED = "InstagramMainMediator:JUUS_BACK_PRESSED"
InstagramMainMediator.INS_BACK_PRESSED = "InstagramMainMediator:INS_BACK_PRESSED"

function InstagramMainMediator:register()
	self:bind(InstagramMainMediator.OPEN_CHAT, function(arg_2_0)
		self:addSubLayers(Context.New({
			viewComponent = InstagramChatLayer,
			mediator = InstagramChatMediator,
			data = {
				groupName = self.viewComponent:getGroupName()
			}
		}))

		return
	end)
	self:bind(InstagramMainMediator.OPEN_JUUS, function(arg_3_0)
		self:addSubLayers(Context.New({
			viewComponent = InstagramLayer,
			mediator = InstagramMediator,
			data = {
				groupName = self.viewComponent:getGroupName()
			}
		}))

		return
	end)
	self:bind(InstagramMainMediator.CLOSE_CHAT, function(arg_4_0)
		self:removeSubLayers(InstagramChatMediator)

		return
	end)
	self:bind(InstagramMainMediator.CLOSE_JUUS, function(arg_5_0)
		self:removeSubLayers(InstagramMediator)

		return
	end)
	self:bind(InstagramMainMediator.CLOSE_JUUS_DETAIL, function(arg_6_0)
		self:sendNotification(InstagramMediator.CLOSE_DETAIL)

		return
	end)
	self:bind(InstagramMainMediator.JUUS_BACK_PRESSED, function(arg_7_0)
		self:sendNotification(InstagramChatMediator.BACK_PRESSED)

		return
	end)
	self:bind(InstagramMainMediator.INS_BACK_PRESSED, function(arg_8_0)
		self:sendNotification(InstagramMediator.BACK_PRESSED)

		return
	end)

	return
end

function InstagramMainMediator:listNotificationInterests()
	return {
		InstagramMainMediator.CHANGE_CHAT_TIP,
		InstagramMainMediator.CHANGE_JUUS_TIP,
		InstagramMainMediator.CLOSE_ALL
	}
end

function InstagramMainMediator:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == InstagramMainMediator.CHANGE_CHAT_TIP then
		self.viewComponent:ChangeChatTip()
	elseif var_10_0 == InstagramMainMediator.CHANGE_JUUS_TIP then
		self.viewComponent:ChangeJuusTip()
	elseif var_10_0 == InstagramMainMediator.CLOSE_ALL then
		self.viewComponent:closeView()
	end

	return
end

return InstagramMainMediator
