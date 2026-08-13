class = var_0_10000

local var_0_0 = "FurnitureSlideExtraMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.OPEN_INVITE_LAYER = "FurnitureSlideExtraMediator.OPEN_INVITE_LAYER"
var_0_1.GO_SLIDE_PERFORMANCE = "FurnitureSlideExtraMediator.GO_SLIDE_PERFORMANCE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_INVITE_LAYER, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		Dorm3dSlideInviteLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		Dorm3dInviteMediator = var_2_10006
		var_2_3.mediator = var_2_10006

		local var_2_4 = {
			groupIds = arg_2_1
		}

		SlideConst = var_2_10007
		var_2_4.roomId = var_2_10007.ROOM_ID
		var_2_3.data = var_2_4

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.GO_SLIDE_PERFORMANCE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_3_1(var_3_0, var_3_2, var_2_10005.DORM3D_SLIDE, {
			groupId = arg_3_1
		})

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	ApartmentProxy = var_1_10002
	var_4_0[var_1_10002.UPDATE_SLIDE_INVITE_LIST] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getBody()
		local var_5_1 = arg_5_0.viewComponent

		var_3.UpdateSlideInviteList(var_5_1, var_5_0.groupIds, var_5_0.addIds, var_5_0.removeIds)

		return
	end
	Dorm3dRoomScene = var_2
	var_4_0[var_2.NOTIFY_UI_STATE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1:getBody()
		local var_6_1 = arg_6_0.viewComponent

		var_3.HandleDormUIState(var_6_1, var_6_0)

		return
	end
	SlideExtraSystem = var_2
	var_4_0[var_2.SHOW_INTERACTION] = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.viewComponent

		var_2.ShowInteraction(var_7_0)

		return
	end
	SlideExtraSystem = var_2
	var_4_0[var_2.HIDE_INTERACTION] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0.viewComponent

		var_2.HideInteraction(var_8_0)

		return
	end
	SlideExtraSystem = var_2
	var_4_0[var_2.SHOW_PERFORMANCE] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0.viewComponent

		var_2.ShowPerformance(var_9_0)

		return
	end
	SlideExtraSystem = var_2
	var_4_0[var_2.HIDE_PERFORMANCE] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.viewComponent

		var_2.HidePerformance(var_10_0)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

return var_0_1
