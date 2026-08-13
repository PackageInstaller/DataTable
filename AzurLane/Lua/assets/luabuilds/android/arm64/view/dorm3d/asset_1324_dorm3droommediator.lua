class = var_0_10000

local var_0_0 = "Dorm3dRoomMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Core.Dorm3dBaseMediator"))

var_0_1.TRIGGER_FAVOR = "Dorm3dRoomMediator.TRIGGER_FAVOR"
var_0_1.FAVOR_LEVEL_UP = "Dorm3dRoomMediator.FAVOR_LEVEL_UP"
var_0_1.TALKING_EVENT_FINISH = "Dorm3dRoomMediator.TALKING_EVENT_FINISH"
var_0_1.DO_TALK = "Dorm3dRoomMediator.DO_TALK"
var_0_1.COLLECTION_ITEM = "Dorm3dRoomMediator.COLLECTION_ITEM"
var_0_1.OPEN_FURNITURE_SELECT = "Dorm3dRoomMediator.OPEN_FURNITURE_SELECT"
var_0_1.OPEN_LEVEL_LAYER = "Dorm3dRoomMediator.OPEN_LEVEL_LAYER"
var_0_1.OPEN_GIFT_LAYER = "Dorm3dRoomMediator.OPEN_GIFT_LAYER"
var_0_1.OPEN_CAMERA_LAYER = "Dorm3dRoomMediator.OPEN_CAMERA_LAYER"
var_0_1.OPEN_DROP_LAYER = "Dorm3dRoomMediator.OPEN_DROP_LAYER"
var_0_1.OPEN_COLLECTION_LAYER = "Dorm3dRoomMediator.OPEN_COLLECTION_LAYER"
var_0_1.OPEN_INVITE_WINDOW = "Dorm3dRoomMediator.OPEN_INVITE_WINDOW"
var_0_1.OPEN_ACCOMPANY_WINDOW = "Dorm3dRoomMediator.OPEN_ACCOMPANY_WINDOW"
var_0_1.OPEN_MINIGAME_WINDOW = "Dorm3dRoomMediator.OPEN_MINIGAME_WINDOW"
var_0_1.OPEN_SKIN_SELECT_LAYER = "Dorm3dRoomMediator.OPEN_SKIN_SELECT_LAYER"
var_0_1.OPEN_SETTING_LAYER = "Dorm3dRoomMediator.OPEN_SETTING_LAYER"
var_0_1.ON_LEVEL_UP_FINISH = "Dorm3dRoomMediator.ON_LEVEL_UP_FINISH"
var_0_1.ON_CLICK_FURNITURE_SLOT = "Dorm3dRoomMediator.ON_CLICK_FURNITURE_SLOT"
var_0_1.OTHER_DO_TALK = "Dorm3dRoomMediator.OTHER_DO_TALK"
var_0_1.OTHER_POP_UNLOCK = "Dorm3dRoomMediator.OTHER_POP_UNLOCK"
var_0_1.CHAMGE_TIME_RELOAD_SCENE = "Dorm3dRoomMediator.CHAMGE_TIME_RELOAD_SCENE"
var_0_1.GUIDE_CLICK_LADY = "Dorm3dRoomMediator.GUIDE_CLICK_LADY"
var_0_1.GUIDE_CHECK_GUIDE = "Dorm3dRoomMediator.GUIDE_CHECK_GUIDE"
var_0_1.GUIDE_CHECK_LEVEL_UP = "Dorm3dRoomMediator.GUIDE_CHECK_LEVEL_UP"
var_0_1.Camera_Pinch_Value_Change = "Dorm3dRoomMediator.Camera_Pinch_Value_Change"
var_0_1.ENTER_VOLLEYBALL = "Dorm3dRoomMediator.ENTER_VOLLEYBALL"
var_0_1.ENTER_DANCE = "Dorm3dRoomMediator.ENTER_DANCE"
var_0_1.ENTER_CARWASH = "Dorm3dRoomMediator.ENTER_CARWASH"
var_0_1.ON_DROP_CLIENT = "Dorm3dRoomMediator.ON_DROP_CLIENT"
var_0_1.UPDATE_FAVOR_DISPLAY = "Dorm3dRoomMediator.UPDATE_FAVOR_DISPLAY"
var_0_1.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE = "Dorm3dRoomMediator.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE"
var_0_1.REFRESH_FURNITURE_AND_SLOTS_DONE = "Dorm3dRoomMediator.REFRESH_FURNITURE_AND_SLOTS_DONE"
var_0_1.REMOVE_EXTRA_SYSTEM = "Dorm3dRoomMediator.REMOVE_EXTRA_SYSTEM"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.TRIGGER_FAVOR, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.APARTMENT_TRIGGER_FAVOR, {
			groupId = arg_2_1,
			triggerId = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.FAVOR_LEVEL_UP, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.APARTMENT_LEVEL_UP, {
			groupId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.TALKING_EVENT_FINISH, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0

		var_3.sendNotification(var_4_0, arg_4_1, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_FURNITURE_SELECT, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_5_2 = var_2_10006.New
		local var_5_3 = {}

		Dorm3dFurnitureSelectMediator = var_2_10009
		var_5_3.mediator = var_2_10009
		Dorm3dFurnitureSelectLayer = var_2_10009
		var_5_3.viewComponent = var_2_10009
		var_5_3.data = arg_5_1

		function var_5_3.onRemoved()
			local var_6_0 = arg_1_0.viewComponent
			local var_6_1 = var_0.InitExtraSystem
			local var_6_2 = {}

			SlideExtraSystem = var_3_10004
			var_6_2[1] = var_3_10004

			var_6_1(var_6_0, var_6_2)

			local var_6_3 = arg_1_0.viewComponent

			var_0.TempHideUI(var_6_3, false, arg_5_2)

			arg_1_0.viewComponent.isInFurnitureSelect = false

			return
		end

		var_5_1(var_5_0, var_5_2(var_5_3), nil, function()
			local var_7_0 = arg_1_0.viewComponent

			var_0.TempHideUI(var_7_0, true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_FURNITURE_SLOT, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0

		var_2.sendNotification(var_8_0, arg_8_0, arg_8_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_LEVEL_LAYER, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_1_0
		local var_9_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_9_2 = var_2_10006.New
		local var_9_3 = {}

		Dorm3dLevelLayer = var_2_10009
		var_9_3.viewComponent = var_2_10009
		Dorm3dLevelMediator = var_2_10009
		var_9_3.mediator = var_2_10009
		var_9_3.data = arg_9_1

		function var_9_3.onRemoved()
			local var_10_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_10_0, "inLockLayer", false)

			local var_10_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_10_1, false, arg_9_2)

			return
		end

		var_9_1(var_9_0, var_9_2(var_9_3), nil, function()
			local var_11_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_11_0, "inLockLayer", true)

			local var_11_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_11_1, true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_GIFT_LAYER, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_1_0
		local var_12_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_12_2 = var_2_10006.New
		local var_12_3 = {}

		Dorm3dGiftLayer = var_2_10009
		var_12_3.viewComponent = var_2_10009
		Dorm3dGiftMediator = var_2_10009
		var_12_3.mediator = var_2_10009
		var_12_3.data = arg_12_1

		function var_12_3.onRemoved()
			local var_13_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_13_0, "inLockLayer", false)

			local var_13_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_13_1, false, arg_12_2)

			return
		end

		var_12_1(var_12_0, var_12_2(var_12_3), nil, function()
			local var_14_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_14_0, "inLockLayer", true)

			local var_14_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_14_1, true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CAMERA_LAYER, function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		local var_15_0 = arg_1_0
		local var_15_1 = var_4.addSubLayers

		Context = var_2_10007

		local var_15_2 = var_2_10007.New
		local var_15_3 = {}

		Dorm3dPhotoLayer = var_2_10010
		var_15_3.viewComponent = var_2_10010
		Dorm3dPhotoMediator = var_2_10010
		var_15_3.mediator = var_2_10010
		var_15_3.data = {
			groupId = arg_15_2,
			view = arg_15_1
		}

		var_15_1(var_15_0, var_15_2(var_15_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DROP_LAYER, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_1_0
		local var_16_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_16_2 = var_2_10006.New
		local var_16_3 = {}

		Dorm3dAwardInfoLayer = var_2_10009
		var_16_3.viewComponent = var_2_10009
		Dorm3dAwardInfoMediator = var_2_10009
		var_16_3.mediator = var_2_10009
		var_16_3.data = {
			items = arg_16_1
		}
		var_16_3.onRemoved = arg_16_2

		var_16_1(var_16_0, var_16_2(var_16_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_COLLECTION_LAYER, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_1_0
		local var_17_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_17_2 = var_2_10005.New
		local var_17_3 = {}

		Dorm3dCollectionLayer = var_2_10008
		var_17_3.viewComponent = var_2_10008
		Dorm3dCollectionMediator = var_2_10008
		var_17_3.mediator = var_2_10008
		var_17_3.data = {
			roomId = arg_17_1
		}

		var_17_1(var_17_0, var_17_2(var_17_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_INVITE_WINDOW, function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		local var_18_0 = arg_1_0
		local var_18_1 = var_4.addSubLayers

		Context = var_2_10007

		local var_18_2 = var_2_10007.New
		local var_18_3 = {}

		Dorm3dInviteLayer = var_2_10010
		var_18_3.viewComponent = var_2_10010
		Dorm3dInviteMediator = var_2_10010
		var_18_3.mediator = var_2_10010
		var_18_3.data = {
			roomId = arg_18_1,
			groupIds = arg_18_2
		}

		function var_18_3.onRemoved()
			local var_19_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_19_0, "inLockLayer", false)

			local var_19_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_19_1, false, arg_18_3)

			return
		end

		var_18_1(var_18_0, var_18_2(var_18_3), nil, function()
			local var_20_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_20_0, "inLockLayer", true)

			local var_20_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_20_1, true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SKIN_SELECT_LAYER, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
		local var_21_0 = arg_1_0
		local var_21_1 = var_6.addSubLayers

		Context = var_2_10009

		local var_21_2 = var_2_10009.New
		local var_21_3 = {}

		Dorm3dSkinSelectLayer = var_2_10012
		var_21_3.viewComponent = var_2_10012
		Dorm3dSkinSelectMediator = var_2_10012
		var_21_3.mediator = var_2_10012
		var_21_3.data = {
			groupId = arg_21_1,
			ladyEnv = arg_21_2,
			onSwitchSkin = arg_21_3
		}
		var_21_3.onRemoved = arg_21_5 and arg_21_4 or function()
			local var_22_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_22_0, "inLockLayer", false)

			local var_22_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_22_1, false, arg_21_4)

			return
		end

		var_21_1(var_21_0, var_21_2(var_21_3), nil, not arg_21_5 and function()
			local var_23_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_23_0, "inLockLayer", true)

			local var_23_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_23_1, true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ACCOMPANY_WINDOW, function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_1_0
		local var_24_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_24_2 = var_2_10006.New
		local var_24_3 = {}

		Dorm3dAccompanyLayer = var_2_10009
		var_24_3.viewComponent = var_2_10009
		Dorm3dAccompanyMediator = var_2_10009
		var_24_3.mediator = var_2_10009
		var_24_3.data = arg_24_1

		function var_24_3.onRemoved()
			local var_25_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_25_0, "inLockLayer", false)

			local var_25_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_25_1, false, arg_24_2)

			return
		end

		var_24_1(var_24_0, var_24_2(var_24_3), nil, function()
			local var_26_0 = arg_1_0.viewComponent

			var_0.SetAllBlackbloardValue(var_26_0, "inLockLayer", true)

			local var_26_1 = arg_1_0.viewComponent

			var_0.TempHideUI(var_26_1, true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_MINIGAME_WINDOW, function(arg_27_0, arg_27_1, arg_27_2)
		switch = var_2_10003

		local var_27_0 = var_2_10003(arg_27_1.minigameId, {
			[67] = function()
				EatFoodLayer = var_3_10000

				return var_3_10000
			end,
			[70] = function()
				NengDaiScheduleGameView = var_3_10000

				return var_3_10000
			end,
			[75] = function()
				RPSGameLayer = var_3_10000

				return var_3_10000
			end
		}, function()
			assert = var_3_10000

			var_3_10000(false, "without dorm minigame config in id:" .. arg_27_1.minigameId)

			return
		end)
		local var_27_1 = arg_1_0
		local var_27_2 = var_4.addSubLayers

		Context = var_7

		local var_27_3 = var_7.New
		local var_27_4 = {
			viewComponent = var_27_0
		}

		Dorm3dMiniGameMediator = var_2_10010
		var_27_4.mediator = var_2_10010
		var_27_4.data = arg_27_1
		var_27_4.onRemoved = arg_27_2

		var_27_2(var_27_1, var_27_3(var_27_4))

		return
	end)
	arg_1_0:bind(var_0_1.ADD_EXTRA_SYSTEM_FURNITURE_SLIDE, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_1_0
		local var_32_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_32_2 = var_2_10005.New
		local var_32_3 = {}

		FurnitureSlideExtraLayer = var_2_10008
		var_32_3.viewComponent = var_2_10008
		FurnitureSlideExtraMediator = var_2_10008
		var_32_3.mediator = var_2_10008
		var_32_3.data = arg_32_1

		var_32_1(var_32_0, var_32_2(var_32_3))

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_FURNITURE_AND_SLOTS_DONE, function(arg_33_0)
		local var_33_0 = arg_1_0

		var_1.sendNotification(var_33_0, var_0_1.REFRESH_FURNITURE_AND_SLOTS_DONE)

		return
	end)
	arg_1_0:bind(var_0_1.REMOVE_EXTRA_SYSTEM, function(arg_34_0, arg_34_1)
		local var_34_0 = arg_1_0

		var_2.removeSubLayers(var_34_0, arg_34_1)

		return
	end)
	arg_1_0:bind(var_0_1.DO_TALK, function(arg_35_0, arg_35_1, arg_35_2)
		local var_35_0 = arg_1_0
		local var_35_1 = var_3.sendNotification

		GAME = var_2_10006

		var_35_1(var_35_0, var_2_10006.APARTMENT_DO_TALK, {
			talkId = arg_35_1,
			callback = arg_35_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.COLLECTION_ITEM, function(arg_36_0, arg_36_1)
		local var_36_0 = arg_1_0
		local var_36_1 = var_2.sendNotification

		GAME = var_2_10005

		var_36_1(var_36_0, var_2_10005.APARTMENT_COLLECTION_ITEM, arg_36_1)

		return
	end)
	arg_1_0:bind(var_0_1.Camera_Pinch_Value_Change, function(arg_37_0, arg_37_1)
		local var_37_0 = arg_1_0
		local var_37_1 = var_2.sendNotification

		Dorm3dPhotoMediator = var_2_10005

		var_37_1(var_37_0, var_2_10005.Camera_Pinch_Value_Change, {
			value = arg_37_1
		})

		return
	end)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	Dorm3dPhotoMediator = var_4

	var_1_1(var_1_0, var_4.CAMERA_LIFT_CHANGED, function(arg_38_0, arg_38_1)
		local var_38_0 = arg_1_0
		local var_38_1 = var_2.sendNotification

		Dorm3dPhotoMediator = var_2_10005

		var_38_1(var_38_0, var_2_10005.CAMERA_LIFT_CHANGED, {
			value = arg_38_1
		})

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	Dorm3dPhotoMediator = var_4

	var_1_3(var_1_2, var_4.CAMERA_STICK_MOVE, function(arg_39_0, arg_39_1)
		local var_39_0 = arg_1_0
		local var_39_1 = var_2.sendNotification

		Dorm3dPhotoMediator = var_2_10005

		var_39_1(var_39_0, var_2_10005.CAMERA_STICK_MOVE, arg_39_1)

		return
	end)
	arg_1_0:bind(var_0_1.ENTER_VOLLEYBALL, function(arg_40_0, arg_40_1)
		local var_40_0 = arg_1_0
		local var_40_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_40_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_40_1(var_40_0, var_40_2, var_2_10006.DORM3D_VOLLEYBALL, {
			groupId = arg_40_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ENTER_DANCE, function(arg_41_0, arg_41_1)
		local var_41_0 = arg_1_0
		local var_41_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_41_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_41_1(var_41_0, var_41_2, var_2_10006.DORM3D_DANCE, {
			groupId = arg_41_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ENTER_CARWASH, function(arg_42_0, arg_42_1)
		local var_42_0 = arg_1_0
		local var_42_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_42_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_42_1(var_42_0, var_42_2, var_2_10006.DORM3D_CAR_WASH, {
			groupId = arg_42_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_DROP_CLIENT, function(arg_43_0, arg_43_1)
		pg = var_2_10002

		local var_43_0 = var_2_10002.NewStyleMsgboxMgr.GetInstance()
		local var_43_1 = var_2.Show

		pg = var_2_10005

		var_43_1(var_43_0, var_2_10005.NewStyleMsgboxMgr.TYPE_DROP_CLIENT, arg_43_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SETTING_LAYER, function(arg_44_0)
		local var_44_0 = arg_1_0
		local var_44_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_44_2 = var_2_10004.New
		local var_44_3 = {}

		Dorm3dSettingScene = var_2_10007
		var_44_3.viewComponent = var_2_10007
		NewSettingsMediator = var_2_10007
		var_44_3.mediator = var_2_10007

		var_44_1(var_44_0, var_44_2(var_44_3))

		return
	end)

	local var_1_4 = arg_1_0.viewComponent
	local var_1_5 = var_1.SetRoom

	getProxy = var_4
	ApartmentProxy = var_1_10006

	local var_1_6 = var_4(var_1_10006)

	var_1_5(var_1_4, var_4.getRoom(var_1_6, arg_1_0.contextData.roomId))

	local var_1_7 = arg_1_0.viewComponent.room

	if var_1.isPersonalRoom(var_1_7) then
		getProxy = var_1_9
		ApartmentProxy = var_1_7

		local var_1_8 = var_1_9(var_1_7)
		local var_1_9 = var_1_9.getApartment(var_1_8, arg_1_0.contextData.groupIds[1])
		local var_1_10 = arg_1_0.viewComponent

		var_2.SetApartment(var_1_10, var_1_9)
	end

	Dorm3dFurniture = var_1_9

	var_1_9.RecordLastTimelimitShopFurniture()

	return
end

function var_0_1.initNotificationHandleDic(arg_45_0)
	local var_45_0 = {}

	GAME = var_1_10002
	var_45_0[var_1_10002.APARTMENT_TRIGGER_FAVOR_DONE] = function(arg_46_0, arg_46_1)
		local var_46_0 = arg_46_1:getBody()
		local var_46_1 = arg_46_0.viewComponent

		var_3.PopFavorTrigger(var_46_1, var_46_0)

		return
	end
	GAME = var_2
	var_45_0[var_2.APARTMENT_LEVEL_UP_DONE] = function(arg_47_0, arg_47_1)
		local var_47_0 = arg_47_1:getBody()

		seriesAsync = var_2_10003

		var_2_10003({
			function(arg_48_0)
				local var_48_0 = arg_47_0.viewComponent

				var_1.SetAllBlackbloardValue(var_48_0, "inLockLayer", true)

				local var_48_1 = arg_47_0.viewComponent

				var_1.PopFavorLevelUp(var_48_1, var_47_0.apartment, var_47_0.award, arg_48_0)

				return
			end
		}, function()
			local var_49_0 = arg_47_0.viewComponent

			var_0.SetAllBlackbloardValue(var_49_0, "inLockLayer", false)

			local var_49_1 = arg_47_0.viewComponent

			var_0.CheckQueue(var_49_1)

			local var_49_2 = arg_47_0

			var_0.sendNotification(var_49_2, var_0_1.ON_LEVEL_UP_FINISH)

			return
		end)

		return
	end
	STORY_EVENT = var_2
	var_45_0[var_2.TEST] = function(arg_50_0, arg_50_1)
		local var_50_0 = arg_50_1:getBody()
		local var_50_1 = arg_50_0.viewComponent

		var_3.TalkingEventHandle(var_50_1, var_50_0)

		return
	end
	ApartmentProxy = var_2
	var_45_0[var_2.UPDATE_APARTMENT] = function(arg_51_0, arg_51_1)
		local var_51_0 = arg_51_1:getBody()

		if arg_51_0.viewComponent.apartment and var_3:GetConfigID() == var_51_0:GetConfigID() then
			local var_51_1 = arg_51_0.viewComponent

			var_4.SetApartment(var_51_1, var_51_0)
		end

		return
	end
	var_45_0[var_0_1.OTHER_DO_TALK] = function(arg_52_0, arg_52_1)
		local var_52_0 = arg_52_1:getBody()

		arg_52_0.viewComponent.inReplayTalk = true

		local var_52_1 = arg_52_0.viewComponent

		var_3.DoTalk(var_52_1, var_52_0.talkId, function()
			local var_53_0 = arg_52_0.viewComponent

			var_53_0.inReplayTalk = false
			existCall = var_53_0

			var_53_0(var_52_0.callback)

			return
		end)

		return
	end
	var_45_0[var_0_1.OTHER_POP_UNLOCK] = function(arg_54_0, arg_54_1)
		local var_54_0 = arg_54_1:getBody()
		local var_54_1 = arg_54_0.viewComponent

		var_3.AddUnlockDisplay(var_54_1, var_54_0)

		return
	end
	GAME = var_2
	var_45_0[var_2.APARTMENT_DO_TALK_DONE] = function(arg_55_0, arg_55_1)
		local var_55_0 = arg_55_0.viewComponent

		var_2.UpdateBtnState(var_55_0)

		return
	end
	GAME = var_2
	var_45_0[var_2.APARTMENT_COLLECTION_ITEM_DONE] = function(arg_56_0, arg_56_1)
		local var_56_0 = arg_56_1:getBody()
		local var_56_1 = arg_56_0
		local var_56_2 = arg_56_0.addSubLayers

		Context = var_2_10006

		local var_56_3 = var_2_10006.New
		local var_56_4 = {}

		Dorm3dCollectAwardLayer = var_2_10009
		var_56_4.viewComponent = var_2_10009
		Dorm3dCollectAwardMediator = var_2_10009
		var_56_4.mediator = var_2_10009
		var_56_4.data = {
			itemId = var_56_0.itemId,
			isNew = var_56_0.isNew
		}

		var_56_2(var_56_1, var_56_3(var_56_4))

		local var_56_5 = arg_56_0.viewComponent

		var_3.UpdateBtnState(var_56_5)

		return
	end
	var_45_0[var_0_1.CHAMGE_TIME_RELOAD_SCENE] = function(arg_57_0, arg_57_1)
		local var_57_0 = arg_57_1:getBody()

		arg_57_0.contextData.timeIndex = var_57_0.timeIndex

		local var_57_1 = arg_57_0.viewComponent

		var_3.SwitchDayNight(var_57_1, arg_57_0.contextData.timeIndex)

		onNextTick = var_3

		var_3(function()
			local var_58_0 = arg_57_0.viewComponent

			var_0.RefreshSlots(var_58_0)

			return
		end)

		local var_57_2 = arg_57_0.viewComponent

		var_3.UpdateContactState(var_57_2)

		return
	end
	GAME = var_2
	var_45_0[var_2.APARTMENT_GIVE_GIFT_DONE] = function(arg_59_0, arg_59_1)
		local var_59_0 = arg_59_1:getBody()
		local var_59_1 = arg_59_0.viewComponent

		var_3.PlayHeartFX(var_59_1, var_59_0.groupId)

		local var_59_2 = arg_59_0.viewComponent

		var_3.UpdateBtnState(var_59_2)

		getProxy = var_3
		Dorm3dChatProxy = var_59_2

		local var_59_3 = var_3(var_59_2)

		var_3.TriggerEvent(var_59_3, {
			{
				value = 1,
				event_type = arg_59_0.contextData.timeIndex == 1 and 113 or 118,
				ship_id = var_59_0.groupId
			}
		})

		return
	end
	var_45_0[var_0_1.GUIDE_CLICK_LADY] = function(arg_60_0, arg_60_1)
		warning = var_2_10002

		var_2_10002("this.GUIDE_CLICK_LADY")

		local var_60_0 = arg_60_0.viewComponent

		var_2.EnterWatchMode(var_60_0)

		return
	end
	var_45_0[var_0_1.GUIDE_CHECK_GUIDE] = function(arg_61_0, arg_61_1)
		local var_61_0 = arg_61_0.viewComponent

		var_2.CheckGuide(var_61_0)

		return
	end
	var_45_0[var_0_1.GUIDE_CHECK_LEVEL_UP] = function(arg_62_0, arg_62_1)
		local var_62_0 = arg_62_0.viewComponent

		var_2.CheckLevelUp(var_62_0)

		return
	end
	ApartmentProxy = var_2
	var_45_0[var_2.UPDATE_ROOM] = function(arg_63_0, arg_63_1)
		local var_63_0 = arg_63_1:getBody()
		local var_63_1 = var_2.GetConfigID(var_63_0)
		local var_63_2 = arg_63_0.viewComponent.room

		if var_63_1 == var_4.GetConfigID(var_63_2) then
			local var_63_3 = arg_63_0.viewComponent

			var_3.SetRoom(var_63_3, var_2)
		end

		return
	end
	Dorm3dInviteMediator = var_2
	var_45_0[var_2.ON_DORM] = function(arg_64_0, arg_64_1)
		local var_64_0 = arg_64_1:getBody()
		local var_64_1 = arg_64_0
		local var_64_2 = arg_64_0.sendNotification

		GAME = var_2_10006

		local var_64_3 = var_2_10006.CHANGE_SCENE

		SCENE = var_2_10007

		var_64_2(var_64_1, var_64_3, var_2_10007.DORM3D_ROOM, var_64_0)

		return
	end
	Dorm3dMiniGameMediator = var_2
	var_45_0[var_2.OPERATION] = function(arg_65_0, arg_65_1)
		local var_65_0 = arg_65_1:getBody()
		local var_65_1 = arg_65_0.viewComponent
		local var_65_2 = var_3.HandleGameNotification

		Dorm3dMiniGameMediator = var_2_10006

		var_65_2(var_65_1, var_2_10006.OPERATION, var_65_0)

		return
	end
	ApartmentProxy = var_2
	var_45_0[var_2.ZERO_HOUR_REFRESH] = function(arg_66_0, arg_66_1)
		local var_66_0 = arg_66_1:getBody()
		local var_66_1 = arg_66_0.viewComponent

		var_3.UpdateFavorDisplay(var_66_1)

		return
	end
	var_45_0[var_0_1.UPDATE_FAVOR_DISPLAY] = function(arg_67_0, arg_67_1)
		local var_67_0 = arg_67_0.viewComponent

		var_2.UpdateFavorDisplay(var_67_0)

		return
	end
	ApartmentProxy = var_2
	var_45_0[var_2.UPDATE_ROOM_INVITE_LIST] = function(arg_68_0, arg_68_1)
		local var_68_0 = arg_68_1:getBody()

		ipairs = var_2_10003

		for iter_68_0, iter_68_1 in var_2_10003(var_68_0.addIds) do
			table = var_2_10008

			var_2_10008.insert(arg_68_0.contextData.groupIds, iter_68_1)
		end

		local var_68_1 = arg_68_0.viewComponent

		var_3.LoadCharacterAdditionally(var_68_1, var_68_0.addIds, var_68_0.callback)

		return
	end
	arg_45_0.handleDic = var_45_0

	return
end

function var_0_1.remove(arg_69_0)
	return
end

return var_0_1
