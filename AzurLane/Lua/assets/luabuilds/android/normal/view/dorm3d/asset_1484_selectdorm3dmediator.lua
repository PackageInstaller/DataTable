class = var_0_10000

local var_0_0 = "SelectDorm3DMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_DORM = "SelectDorm3DMediator.ON_DORM"
var_0_1.ON_UNLOCK_DORM_ROOM = "SelectDorm3DMediator.ON_UNLOCK_DORM_ROOM"
var_0_1.ON_SUBMIT_TASK = "SelectDorm3DMediator.ON_SUBMIT_TASK"
var_0_1.OPEN_INVITE_LAYER = "SelectDorm3DMediator.OPEN_INVITE_LAYER"
var_0_1.OPEN_ROOM_UNLOCK_WINDOW = "SelectDorm3DMediator.OPEN_ROOM_UNLOCK_WINDOW"
var_0_1.OPEN_INS_LAYER = "SelectDorm3DMediator.OPEN_INS_LAYER"
var_0_1.OPEN_SHOP_LAYER = "SelectDorm3DMediator.OPEN_SHOP_LAYER"
var_0_1.OPEN_SETTING_LAYER = "SelectDorm3DMediator.OPEN_SETTING_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_DORM, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_2_1(var_2_0, var_2_2, var_2_10005.DORM3D_ROOM, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_UNLOCK_DORM_ROOM, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.APARTMENT_ROOM_UNLOCK, {
			roomId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT_TASK, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.SUBMIT_TASK, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ROOM_UNLOCK_WINDOW, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		Dorm3dRoomUnlockWindow = var_2_10006
		var_5_3.viewComponent = var_2_10006
		Dorm3dRoomUnlockWindowMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		var_5_3.data = {
			roomId = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_INVITE_LAYER, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = arg_1_0
		local var_6_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_6_2 = var_2_10006.New
		local var_6_3 = {}

		Dorm3dInviteLayer = var_2_10008
		var_6_3.viewComponent = var_2_10008
		Dorm3dInviteMediator = var_2_10008
		var_6_3.mediator = var_2_10008
		var_6_3.data = {
			roomId = arg_6_1,
			groupIds = arg_6_2
		}
		var_6_3.onRemoved = arg_6_3

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_INS_LAYER, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		Dorm3dInsMainLayer = var_2_10006
		var_7_3.viewComponent = var_2_10006
		Dorm3dInsMainMediator = var_2_10006
		var_7_3.mediator = var_2_10006
		var_7_3.data = {
			isPhone = arg_7_1
		}

		function var_7_3.onRemoved()
			local var_8_0 = arg_1_0.viewComponent

			var_0.FlushInsBtn(var_8_0)

			return
		end

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SHOP_LAYER, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_9_2 = var_2_10004.New
		local var_9_3 = {}

		Dorm3dShopUI = var_2_10006
		var_9_3.viewComponent = var_2_10006
		Dorm3dShopMediator = var_2_10006
		var_9_3.mediator = var_2_10006
		var_9_3.onRemoved = arg_9_1

		var_9_1(var_9_0, var_9_2(var_9_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SETTING_LAYER, function(arg_10_0)
		local var_10_0 = arg_1_0
		local var_10_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_10_2 = var_2_10003.New
		local var_10_3 = {}

		Dorm3dSettingScene = var_2_10005
		var_10_3.viewComponent = var_2_10005
		NewSettingsMediator = var_2_10005
		var_10_3.mediator = var_2_10005

		var_10_1(var_10_0, var_10_2(var_10_3))

		return
	end)

	if not arg_1_0.contextData.hasEnterCheck then
		arg_1_0.contextData.hasEnterCheck = true

		local var_1_0 = arg_1_0
		local var_1_1 = arg_1_0.sendNotification

		GAME = var_3

		var_1_1(var_1_0, var_3.SELECT_DORM_ENTER)
	end

	return
end

function var_0_1.initNotificationHandleDic(arg_11_0)
	local var_11_0 = {}

	DormGroupConst = var_1_10002
	var_11_0[var_1_10002.NotifyDormDownloadStart] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1:getBody()
		local var_12_1 = arg_12_0.viewComponent
		local var_12_2 = var_3.DownloadUpdate

		DormGroupConst = var_2_10005

		var_12_2(var_12_1, var_2_10005.DormDownloadLock.roomId, "start")

		return
	end
	DormGroupConst = var_2
	var_11_0[var_2.NotifyDormDownloadProgress] = function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1:getBody()
		local var_13_1 = arg_13_0.viewComponent
		local var_13_2 = var_3.DownloadUpdate

		DormGroupConst = var_2_10005

		var_13_2(var_13_1, var_2_10005.DormDownloadLock.roomId, "loading")

		return
	end
	DormGroupConst = var_2
	var_11_0[var_2.NotifyDormDownloadFinish] = function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.viewComponent

		var_2.DownloadUpdate(var_14_0, arg_14_1:getBody(), "finish")

		return
	end
	Dorm3dInsMainMediator = var_2
	var_11_0[var_2.NotifyDormDelete] = function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0.viewComponent

		var_2.DownloadUpdate(var_15_0, arg_15_1:getBody(), "delete")

		return
	end
	GAME = var_2
	var_11_0[var_2.APARTMENT_ROOM_UNLOCK_DONE] = function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_1:getBody()
		local var_16_1 = arg_16_0.viewComponent

		var_3.AfterRoomUnlock(var_16_1, var_16_0)

		return
	end
	PlayerProxy = var_2
	var_11_0[var_2.UPDATED] = function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_1:getBody()
		local var_17_1 = arg_17_0.viewComponent

		var_3.UpdateRes(var_17_1)

		return
	end
	GAME = var_2
	var_11_0[var_2.SUBMIT_TASK_DONE] = function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_1:getBody()
		local var_18_1 = arg_18_1:getType()[1]

		getDorm3dGameset = var_2_10005

		if var_18_1 == var_2_10005("drom3d_weekly_task")[1] then
			if #var_18_0 > 0 then
				local var_18_2 = arg_18_0.viewComponent
				local var_18_3 = var_4.emit

				BaseUI = var_6

				var_18_3(var_18_2, var_6.ON_ACHIEVE, var_18_0, function()
					local var_19_0 = arg_18_0.viewComponent

					var_0.UpdateWeekTask(var_19_0)

					return
				end)
			else
				local var_18_4 = arg_18_0.viewComponent

				var_4.UpdateWeekTask(var_18_4)
			end
		end

		return
	end
	Dorm3dInviteMediator = var_2
	var_11_0[var_2.ON_DORM] = function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_1:getBody()
		local var_20_1 = arg_20_0
		local var_20_2 = arg_20_0.sendNotification

		GAME = var_2_10005

		local var_20_3 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_20_2(var_20_1, var_20_3, var_2_10006.DORM3D_ROOM, var_20_0)

		return
	end
	ApartmentProxy = var_2
	var_11_0[var_2.ZERO_HOUR_REFRESH] = function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_1:getBody()
		local var_21_1 = arg_21_0.viewComponent

		var_3.UpdateStamina(var_21_1)

		return
	end
	GAME = var_2
	var_11_0[var_2.APARTMENT_ROOM_INVITE_UNLOCK_DONE] = function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_1
		local var_22_1 = arg_22_1.getBody(var_22_0)

		getProxy = var_22_0
		PlayerProxy = var_2_10004

		local var_22_2 = var_22_0(var_2_10004)
		local var_22_3 = var_3.getRawData(var_22_2).id

		PlayerPrefs = var_22_2

		var_22_2.SetInt(var_22_3 .. "_dorm3dRoomInviteSuccess_" .. var_22_1.roomId, 0)

		PlayerPrefs = var_4

		var_4.SetInt(var_22_3 .. "_dorm3dRoomInviteSuccess_" .. var_22_1.roomId .. "_" .. var_22_1.groupId, 0)

		local var_22_4 = arg_22_0.viewComponent

		var_4.FlushFloor(var_22_4)

		return
	end
	arg_11_0.handleDic = var_11_0

	return
end

return var_0_1
