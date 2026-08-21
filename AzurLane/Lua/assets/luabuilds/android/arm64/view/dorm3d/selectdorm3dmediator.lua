local var_0_0 = class("SelectDorm3DMediator", import("view.base.ContextMediator"))

var_0_0.ON_DORM = "SelectDorm3DMediator.ON_DORM"
var_0_0.ON_UNLOCK_DORM_ROOM = "SelectDorm3DMediator.ON_UNLOCK_DORM_ROOM"
var_0_0.ON_SUBMIT_TASK = "SelectDorm3DMediator.ON_SUBMIT_TASK"
var_0_0.OPEN_INVITE_LAYER = "SelectDorm3DMediator.OPEN_INVITE_LAYER"
var_0_0.OPEN_ROOM_UNLOCK_WINDOW = "SelectDorm3DMediator.OPEN_ROOM_UNLOCK_WINDOW"
var_0_0.OPEN_INS_LAYER = "SelectDorm3DMediator.OPEN_INS_LAYER"
var_0_0.OPEN_SHOP_LAYER = "SelectDorm3DMediator.OPEN_SHOP_LAYER"
var_0_0.OPEN_SETTING_LAYER = "SelectDorm3DMediator.OPEN_SETTING_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_DORM, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_ROOM, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_UNLOCK_DORM_ROOM, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.APARTMENT_ROOM_UNLOCK, {
			roomId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SUBMIT_TASK, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ROOM_UNLOCK_WINDOW, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dRoomUnlockWindow,
			mediator = Dorm3dRoomUnlockWindowMediator,
			data = {
				roomId = arg_5_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_INVITE_LAYER, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dInviteLayer,
			mediator = Dorm3dInviteMediator,
			data = {
				roomId = arg_6_1,
				groupIds = arg_6_2
			},
			onRemoved = arg_6_3
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_INS_LAYER, function(arg_7_0, arg_7_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dInsMainLayer,
			mediator = Dorm3dInsMainMediator,
			data = {
				isPhone = arg_7_1
			},
			onRemoved = function()
				arg_1_0.viewComponent:FlushInsBtn()

				return
			end
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SHOP_LAYER, function(arg_9_0, arg_9_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dShopUI,
			mediator = Dorm3dShopMediator,
			onRemoved = arg_9_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SETTING_LAYER, function(arg_10_0)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = Dorm3dSettingScene,
			mediator = NewSettingsMediator
		}))

		return
	end)

	if not arg_1_0.contextData.hasEnterCheck then
		arg_1_0.contextData.hasEnterCheck = true

		arg_1_0:sendNotification(GAME.SELECT_DORM_ENTER)
	end

	return
end

function var_0_0.initNotificationHandleDic(arg_11_0)
	arg_11_0.handleDic = {
		[DormGroupConst.NotifyDormDownloadStart] = function(arg_12_0, arg_12_1)
			local var_12_0 = arg_12_1:getBody()

			arg_12_0.viewComponent:DownloadUpdate(DormGroupConst.DormDownloadLock.roomId, "start")

			return
		end,
		[DormGroupConst.NotifyDormDownloadProgress] = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_1:getBody()

			arg_13_0.viewComponent:DownloadUpdate(DormGroupConst.DormDownloadLock.roomId, "loading")

			return
		end,
		[DormGroupConst.NotifyDormDownloadFinish] = function(arg_14_0, arg_14_1)
			arg_14_0.viewComponent:DownloadUpdate(arg_14_1:getBody(), "finish")

			return
		end,
		[Dorm3dInsMainMediator.NotifyDormDelete] = function(arg_15_0, arg_15_1)
			arg_15_0.viewComponent:DownloadUpdate(arg_15_1:getBody(), "delete")

			return
		end,
		[GAME.APARTMENT_ROOM_UNLOCK_DONE] = function(arg_16_0, arg_16_1)
			arg_16_0.viewComponent:AfterRoomUnlock((arg_16_1:getBody()))

			return
		end,
		[PlayerProxy.UPDATED] = function(arg_17_0, arg_17_1)
			local var_17_0 = arg_17_1:getBody()

			arg_17_0.viewComponent:UpdateRes()

			return
		end,
		[GAME.SUBMIT_TASK_DONE] = function(arg_18_0, arg_18_1)
			local var_18_0 = arg_18_1:getBody()

			if arg_18_1:getType()[1] == getDorm3dGameset("drom3d_weekly_task")[1] then
				if #var_18_0 > 0 then
					arg_18_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_18_0, function()
						arg_18_0.viewComponent:UpdateWeekTask()

						return
					end)
				else
					arg_18_0.viewComponent:UpdateWeekTask()
				end
			end

			return
		end,
		[Dorm3dInviteMediator.ON_DORM] = function(arg_20_0, arg_20_1)
			arg_20_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3D_ROOM, (arg_20_1:getBody()))

			return
		end,
		[ApartmentProxy.ZERO_HOUR_REFRESH] = function(arg_21_0, arg_21_1)
			local var_21_0 = arg_21_1:getBody()

			arg_21_0.viewComponent:UpdateStamina()

			return
		end,
		[GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE] = function(arg_22_0, arg_22_1)
			local var_22_0 = arg_22_1:getBody()
			local var_22_1 = getProxy(PlayerProxy):getRawData().id

			PlayerPrefs.SetInt(var_22_1 .. "_dorm3dRoomInviteSuccess_" .. var_22_0.roomId, 0)
			PlayerPrefs.SetInt(var_22_1 .. "_dorm3dRoomInviteSuccess_" .. var_22_0.roomId .. "_" .. var_22_0.groupId, 0)
			arg_22_0.viewComponent:FlushFloor()

			return
		end
	}

	return
end

return var_0_0
