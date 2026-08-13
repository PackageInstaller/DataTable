class = var_0_10000

local var_0_0 = "InstagramMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.OPEN_CHAT = "InstagramMainMediator:OPEN_CHAT"
var_0_1.OPEN_JUUS = "InstagramMainMediator:OPEN_JUUS"
var_0_1.CLOSE_CHAT = "InstagramMainMediator:CLOSE_CHAT"
var_0_1.CLOSE_JUUS = "InstagramMainMediator:CLOSE_JUUS"
var_0_1.CHANGE_JUUS_TIP = "InstagramMainMediator:CHANGE_JUUS_TIP"
var_0_1.CHANGE_CHAT_TIP = "InstagramMainMediator:CHANGE_CHAT_TIP"
var_0_1.CLOSE_ALL = "InstagramMainMediator:CLOSE_ALL"
var_0_1.CLOSE_JUUS_DETAIL = "InstagramMainMediator:CLOSE_JUUS_DETAIL"
var_0_1.JUUS_BACK_PRESSED = "InstagramMainMediator:JUUS_BACK_PRESSED"
var_0_1.INS_BACK_PRESSED = "InstagramMainMediator:INS_BACK_PRESSED"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_CHAT, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		InstagramChatLayer = var_2_10007
		var_2_3.viewComponent = var_2_10007
		InstagramChatMediator = var_2_10007
		var_2_3.mediator = var_2_10007

		local var_2_4 = {}
		local var_2_5 = arg_1_0.viewComponent

		var_2_4.groupName = var_8.getGroupName(var_2_5)
		var_2_3.data = var_2_4

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_JUUS, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		InstagramLayer = var_2_10007
		var_3_3.viewComponent = var_2_10007
		InstagramMediator = var_2_10007
		var_3_3.mediator = var_2_10007

		local var_3_4 = {}
		local var_3_5 = arg_1_0.viewComponent

		var_3_4.groupName = var_8.getGroupName(var_3_5)
		var_3_3.data = var_3_4

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_CHAT, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.removeSubLayers

		InstagramChatMediator = var_2_10004

		var_4_1(var_4_0, var_2_10004)

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_JUUS, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.removeSubLayers

		InstagramMediator = var_2_10004

		var_5_1(var_5_0, var_2_10004)

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_JUUS_DETAIL, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.sendNotification

		InstagramMediator = var_2_10004

		var_6_1(var_6_0, var_2_10004.CLOSE_DETAIL)

		return
	end)
	arg_1_0:bind(var_0_1.JUUS_BACK_PRESSED, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.sendNotification

		InstagramChatMediator = var_2_10004

		var_7_1(var_7_0, var_2_10004.BACK_PRESSED)

		return
	end)
	arg_1_0:bind(var_0_1.INS_BACK_PRESSED, function(arg_8_0)
		local var_8_0 = arg_1_0
		local var_8_1 = var_1.sendNotification

		InstagramMediator = var_2_10004

		var_8_1(var_8_0, var_2_10004.BACK_PRESSED)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	return {
		var_0_1.CHANGE_CHAT_TIP,
		var_0_1.CHANGE_JUUS_TIP,
		var_0_1.CLOSE_ALL
	}
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == var_0_1.CHANGE_CHAT_TIP then
		local var_10_2 = arg_10_0.viewComponent

		var_4.ChangeChatTip(var_10_2)
	elseif var_10_0 == var_0_1.CHANGE_JUUS_TIP then
		local var_10_3 = arg_10_0.viewComponent

		var_4.ChangeJuusTip(var_10_3)
	elseif var_10_0 == var_0_1.CLOSE_ALL then
		local var_10_4 = arg_10_0.viewComponent

		var_4.closeView(var_10_4)
	end

	return
end

return var_0_1
