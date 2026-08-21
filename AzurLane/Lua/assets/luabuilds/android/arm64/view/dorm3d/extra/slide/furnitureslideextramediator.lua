local var_0_0 = class("FurnitureSlideExtraMediator", import("view.base.ContextMediator"))

var_0_0.OPEN_INVITE_LAYER = "FurnitureSlideExtraMediator.OPEN_INVITE_LAYER"
var_0_0.GO_SLIDE_PERFORMANCE = "FurnitureSlideExtraMediator.GO_SLIDE_PERFORMANCE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_INVITE_LAYER, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dSlideInviteLayer,
			mediator = Dorm3dInviteMediator,
			data = {
				groupIds = arg_2_1,
				roomId = SlideConst.ROOM_ID
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.GO_SLIDE_PERFORMANCE, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_SLIDE, {
			groupId = arg_3_1
		})

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	arg_4_0.handleDic = {
		[ApartmentProxy.UPDATE_SLIDE_INVITE_LIST] = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_1:getBody()

			arg_5_0.viewComponent:UpdateSlideInviteList(var_5_0.groupIds, var_5_0.addIds, var_5_0.removeIds)

			return
		end,
		[Dorm3dRoomScene.NOTIFY_UI_STATE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:HandleDormUIState((arg_6_1:getBody()))

			return
		end,
		[SlideExtraSystem.SHOW_INTERACTION] = function(arg_7_0, arg_7_1)
			arg_7_0.viewComponent:ShowInteraction()

			return
		end,
		[SlideExtraSystem.HIDE_INTERACTION] = function(arg_8_0, arg_8_1)
			arg_8_0.viewComponent:HideInteraction()

			return
		end,
		[SlideExtraSystem.SHOW_PERFORMANCE] = function(arg_9_0, arg_9_1)
			arg_9_0.viewComponent:ShowPerformance()

			return
		end,
		[SlideExtraSystem.HIDE_PERFORMANCE] = function(arg_10_0, arg_10_1)
			arg_10_0.viewComponent:HidePerformance()

			return
		end
	}

	return
end

return var_0_0
