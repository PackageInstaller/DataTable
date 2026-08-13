class = var_0_10000

local var_0_0 = "Dorm3dSkinSelectMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.CHANGE_SKIN = "Dorm3dSkinSelectMediator:CHANGE_SKIN"
var_0_1.SWITCH_SKIN = "Dorm3dSkinSelectMediator:SWITCH_SKIN"
var_0_1.OPEN_SHOP_WINDOW = "Dorm3dSkinSelectMediator:OPEN_SHOP_WINDOW"
var_0_1.PLAY_ANIM = "Dorm3dSkinSelectMediator:PLAY_ANIM"
var_0_1.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dSkinSelectMediator:OPEN_ROOM_UNLOCK_WINDOW"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CHANGE_SKIN, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.APARTMENT_CHANGE_SKIN, {
			groupId = arg_2_1,
			skinId = arg_2_2
		})

		local var_2_2 = arg_1_0
		local var_2_3 = var_4.sendNotification

		GAME = var_6

		var_2_3(var_2_2, var_6.APARTMENT_SKIN_PART_HIDDEN, {
			groupId = arg_2_1,
			skinId = arg_2_2,
			partList = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ROOM_UNLOCK_WINDOW, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		Dorm3dRoomUnlockWindow = var_2_10007
		var_3_3.viewComponent = var_2_10007
		Dorm3dRoomUnlockWindowMediator = var_2_10007
		var_3_3.mediator = var_2_10007
		var_3_3.data = {
			roomId = arg_3_1,
			groupId = arg_3_2
		}

		function var_3_3.onRemoved()
			local var_4_0 = arg_1_0.viewComponent

			var_0.FlushSkinList(var_4_0)

			return
		end

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SHOP_WINDOW, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		Dorm3dShoppingConfirmWindow = var_2_10006
		var_5_3.viewComponent = var_2_10006
		Dorm3dShoppingConfirmWindowMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		var_5_3.data = arg_5_1

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_3

	var_1_1(var_1_0, var_3.SHOPPING, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.SHOPPING, arg_6_1)

		return
	end)

	local var_1_2 = arg_1_0.viewComponent
	local var_1_3 = var_1.SetApartment

	getProxy = var_3
	ApartmentProxy = var_4

	local var_1_4 = var_3(var_4)

	var_1_3(var_1_2, var_3.getApartment(var_1_4, arg_1_0.contextData.groupId))

	return
end

function var_0_1.initNotificationHandleDic(arg_7_0)
	local function var_7_0(arg_8_0)
		local var_8_0 = arg_7_0.viewComponent

		var_1.FlushSkinList(var_8_0)

		pg = var_1

		local var_8_1 = var_1.shop_template[arg_8_0].effect_args[1]

		ShipGroup = var_8_0

		local var_8_2 = var_8_0.getDefaultShipNameByGroupID(arg_7_0.contextData.groupId)

		pg = var_3

		local var_8_3 = var_3.dorm3d_resource[var_8_1].name

		pg = var_2_10004

		local var_8_4 = var_2_10004.NewStyleMsgboxMgr.GetInstance()
		local var_8_5 = var_4.Show

		pg = var_2_10006

		local var_8_6 = var_2_10006.NewStyleMsgboxMgr.TYPE_MSGBOX
		local var_8_7 = {}

		i18n = var_2_10008
		var_8_7.title = var_2_10008("title_info")
		i18n = var_8
		var_8_7.contentText = var_8("dorm3d_skin_equip", var_8_2, var_8_3)

		function var_8_7.onConfirm()
			local var_9_0 = arg_7_0.viewComponent

			var_0.ConfirmCurrentSkin(var_9_0)

			return
		end

		function var_8_7.onClose()
			local var_10_0 = arg_7_0.viewComponent

			var_0.CancelCurrentSkin(var_10_0)

			return
		end

		var_8_5(var_8_4, var_8_6, var_8_7)

		return
	end

	local var_7_1 = {}

	GAME = var_1_10003
	var_7_1[var_1_10003.SHOPPING_DONE] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_1:getBody()

		var_7_0(var_11_0.id)

		return
	end
	GAME = var_3
	var_7_1[var_3.APARTMENT_ROOM_INVITE_UNLOCK_DONE] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1
		local var_12_1 = arg_12_1.getBody(var_12_0)

		getProxy = var_12_0
		ApartmentProxy = var_2_10004

		local var_12_2 = var_12_0(var_2_10004)
		local var_12_3 = var_3.getRoom(var_12_2, var_12_1.roomId)
		local var_12_4 = var_3.getConfig(var_12_3, "invite_cost")

		Apartment = var_12_3

		local var_12_5 = var_12_3.getGroupConfig(var_12_1.groupId, var_12_4)

		var_7_0(var_12_5)

		return
	end
	ApartmentProxy = var_3
	var_7_1[var_3.UPDATE_APARTMENT] = function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0.viewComponent
		local var_13_1 = var_2.SetApartment

		getProxy = var_2_10004
		ApartmentProxy = var_2_10005

		local var_13_2 = var_2_10004(var_2_10005)

		var_13_1(var_13_0, var_4.getApartment(var_13_2, arg_13_0.contextData.groupId))

		local var_13_3 = arg_13_0.viewComponent

		var_2.FlushSkinList(var_13_3)

		return
	end
	arg_7_0.handleDic = var_7_1

	return
end

function var_0_1.remove(arg_14_0)
	return
end

return var_0_1
