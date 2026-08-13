class = var_0_10000

local var_0_0 = "ApartmentRoom"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.unlockCharacter = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.ships then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		arg_1_0.unlockCharacter[iter_1_1] = true
	end

	arg_1_0.furnitures = {}
	table = var_2

	local var_1_1 = var_2.Ipairs
	local var_1_2

	if not arg_1_1.furnitures then
		var_1_2 = {}
	end

	var_1_1(var_1_2, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.furnitures

		Dorm3dFurniture = var_2_10003
		var_2_0[arg_2_0] = var_2_10003.New({
			configId = arg_2_1.furniture_id,
			slotId = arg_2_1.slot_id
		})

		return
	end)

	arg_1_0.slotDic = {}
	table = var_2

	var_2.Ipairs(arg_1_0:GetSlotIDList(), function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0.slotDic

		Dorm3dFurnitureSlot = var_2_10003
		var_3_0[arg_3_1] = var_2_10003.New({
			configId = arg_3_1
		})

		return
	end)

	arg_1_0.zoneDic = {}
	table = var_2

	var_2.Ipairs(arg_1_0:GetZoneIDList(), function(arg_4_0, arg_4_1)
		Dorm3dZone = var_2_10002

		local var_4_0 = var_2_10002.New({
			configId = arg_4_1
		})
		local var_4_1 = var_2.GetWatchCameraName(var_4_0)

		arg_1_0.zoneDic[var_4_1] = var_2

		local var_4_2 = var_2
		local var_4_3 = var_2.SetSlots

		_ = var_2_10007

		var_4_3(var_4_2, var_2_10007.map(var_2:GetSlotIDList(), function(arg_5_0)
			return arg_1_0.slotDic[arg_5_0]
		end))

		return
	end)
	arg_1_0:UpdateFurnitureReplaceConfig()

	_ = var_2
	arg_1_0.cameraZones = var_2.map(arg_1_0:GetCameraZoneIDList(), function(arg_6_0)
		Dorm3dCameraZone = var_2_10001

		return var_2_10001.New({
			configId = arg_6_0
		})
	end)
	arg_1_0.collectItemDic = {}
	ipairs = var_2

	local var_1_3

	if not arg_1_1.collections then
		var_1_3 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_3) do
		arg_1_0.collectItemDic[iter_1_3] = true
	end

	arg_1_0.shipArAnimationDic = {}

	if arg_1_0:getConfig("ar_anim") then
		ipairs = var_3

		for iter_1_4, iter_1_5 in var_3(var_2) do
			local var_1_4 = iter_1_5[1]
			local var_1_5 = iter_1_5[2]

			_ = var_1_10010
			var_1_10010 = var_1_10010.map(var_1_5, function(arg_7_0)
				Dorm3dCameraAnim = var_2_10001

				return var_2_10001.New({
					configId = arg_7_0
				})
			end)
			arg_1_0.shipArAnimationDic[var_1_4] = var_1_10010
		end
	end

	return
end

function var_0_1.bindConfigTable(arg_8_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_rooms
end

function var_0_1.getDownloadNameList(arg_9_0)
	DormGroupConst = var_1_10001

	local var_9_0 = var_1_10001.GetDownloadResourceDic()

	string = var_1_10002

	local var_9_1 = var_1_10002.lower(arg_9_0:getConfig("resource_name"))
	local var_9_2 = {}

	switch = var_4

	var_4(arg_9_0:getConfig("type"), {
		function()
			var_9_2 = {
				"room_" .. var_9_1,
				"common"
			}

			return
		end,
		function()
			var_9_2 = {
				"room_" .. var_9_1,
				"apartment_" .. var_9_1,
				"common"
			}

			return
		end
	}, function()
		assert = var_2_10000

		local var_12_0 = false
		local var_12_1 = "without room type:"
		local var_12_2 = arg_9_0

		var_2_10000(var_12_0, var_12_1 .. var_4.getConfig(var_12_2, "type"))

		return
	end)

	local var_9_3 = {}

	ipairs = var_1_10005

	for iter_9_0, iter_9_1 in var_1_10005(var_9_2) do
		table = var_1_10010
		var_1_10010 = var_1_10010.insertto

		local var_9_4 = var_9_3
		local var_9_5

		if not var_9_0[iter_9_1] then
			var_9_5 = {}
		end

		var_1_10010(var_9_4, var_9_5)
	end

	return var_9_3
end

function var_0_1.needDownload(arg_13_0)
	return #arg_13_0:getDownloadNameList() > 0
end

function var_0_1.getDownloadNeedSize(arg_14_0)
	DormGroupConst = var_1_10001

	local var_14_0, var_14_1 = var_1_10001.CalcDormListSize(arg_14_0:getDownloadNameList())

	return var_14_0, var_14_1
end

function var_0_1.getState(arg_15_0)
	DormGroupConst = var_1_10001

	if var_1_10001.DormDownloadLock then
		DormGroupConst = var_1

		if var_1.DormDownloadLock.roomId == arg_15_0.configId then
			do return "loading" end

			goto label_15_0
		end
	end

	if arg_15_0:needDownload() then
		return "download"
	else
		return "complete"
	end

	::label_15_0::

	return
end

function var_0_1.isPersonalRoom(arg_16_0)
	return arg_16_0:getConfig("type") == 2
end

function var_0_1.getPersonalGroupId(arg_17_0)
	assert = var_1_10001

	var_1_10001(arg_17_0:isPersonalRoom())

	return arg_17_0:getConfig("character")[1]
end

function var_0_1.getInviteList(arg_18_0)
	table = var_1_10001

	return var_1_10001.mergeArray(arg_18_0:getConfig("character"), arg_18_0:getConfig("character_pay"))
end

function var_0_1.getInteractRange(arg_19_0)
	unpack = var_1_10001

	local var_19_0, var_19_1 = var_1_10001(arg_19_0:getConfig("character_range"))

	var_19_1 = var_19_1 or var_19_0

	return var_19_0, var_19_1
end

function var_0_1.getRoomName(arg_20_0)
	return arg_20_0:getConfig("room")
end

function var_0_1.GetZoneIDList(arg_21_0)
	pg = var_1_10001

	local var_21_0

	if not var_1_10001.dorm3d_zone_template.get_id_list_by_room_id[arg_21_0.configId] then
		var_21_0 = {}
	end

	return var_21_0
end

function var_0_1.GetSlotIDList(arg_22_0)
	pg = var_1_10001

	local var_22_0

	if not var_1_10001.dorm3d_furniture_slot_template.get_id_list_by_room_id[arg_22_0.configId] then
		var_22_0 = {}
	end

	return var_22_0
end

function var_0_1.GetFurnitureZoneIDList(arg_23_0)
	return arg_23_0:getConfig("furniture_zones")
end

function var_0_1.GetCameraZoneIDList(arg_24_0)
	pg = var_1_10001

	local var_24_0

	if not var_1_10001.dorm3d_camera_zone_template.get_id_list_by_room_id[arg_24_0.configId] then
		var_24_0 = {}
	end

	return var_24_0
end

function var_0_1.GetZones(arg_25_0)
	underscore = var_1_10001

	local var_25_0 = var_1_10001(arg_25_0.zoneDic)
	local var_25_1 = var_1.chain(var_25_0)
	local var_25_2 = var_1.values(var_25_1)
	local var_25_3 = var_1.sort

	CompareFuncs = var_1_10004

	local var_25_4 = var_25_3(var_25_2, var_1_10004({
		function(arg_26_0)
			return arg_26_0.configId
		end
	}))

	return var_1.value(var_25_4)
end

function var_0_1.GetFurnitureZones(arg_27_0)
	local var_27_0 = arg_27_0:GetFurnitureZoneIDList()

	underscore = var_1_10002

	return var_1_10002.map(var_27_0, function(arg_28_0)
		table = var_2_10001

		return (var_2_10001.Find(arg_27_0.zoneDic, function(arg_29_0, arg_29_1)
			return arg_29_1:GetConfigID() == arg_28_0
		end))
	end)
end

function var_0_1.GetCameraZones(arg_30_0)
	return arg_30_0.cameraZones
end

function var_0_1.GetSlots(arg_31_0)
	underscore = var_1_10001

	local var_31_0 = var_1_10001(arg_31_0.slotDic)
	local var_31_1 = var_1.chain(var_31_0)
	local var_31_2 = var_1.values(var_31_1)
	local var_31_3 = var_1.sort

	CompareFuncs = var_1_10004

	local var_31_4 = var_31_3(var_31_2, var_1_10004({
		function(arg_32_0)
			return arg_32_0.configId
		end
	}))

	return var_1.value(var_31_4)
end

function var_0_1.GetFurnitureIDList(arg_33_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_furniture_template.get_id_list_by_room_id[arg_33_0.configId]
end

function var_0_1.GetFurnitures(arg_34_0)
	return arg_34_0.furnitures
end

function var_0_1.HasFurniture(arg_35_0, arg_35_1)
	_ = var_1_10002

	return var_1_10002.any(arg_35_0.furnitures, function(arg_36_0)
		return arg_36_0:GetConfigID() == arg_35_1
	end)
end

function var_0_1.AddFurnitureByID(arg_37_0, arg_37_1)
	table = var_1_10002

	local var_37_0 = var_1_10002.insert
	local var_37_1 = arg_37_0.furnitures

	Dorm3dFurniture = var_1_10005

	var_37_0(var_37_1, var_1_10005.New({
		configId = arg_37_1
	}))

	return
end

function var_0_1.ReplaceFurnitures(arg_38_0, arg_38_1)
	_ = var_1_10002

	var_1_10002.each(arg_38_1, function(arg_39_0)
		local var_39_0 = arg_38_0

		var_1.ReplaceFurniture(var_39_0, arg_39_0.slotId, arg_39_0.furnitureId)

		return
	end)
	arg_38_0:UpdateFurnitureReplaceConfig()

	return
end

function var_0_1.ReplaceFurniture(arg_40_0, arg_40_1, arg_40_2)
	if 0 < arg_40_1 then
		_ = var_3

		if var_3.detect(arg_40_0.furnitures, function(arg_41_0)
			return arg_41_0:GetSlotID() == arg_40_1
		end) then
			var_3:SetSlotID(0)
		end
	end

	if 0 < arg_40_2 then
		_ = var_3

		if var_3.detect(arg_40_0.furnitures, function(arg_42_0)
			return arg_42_0:GetConfigID() == arg_40_2 and arg_42_0:GetSlotID() == 0
		end) then
			var_3:SetSlotID(arg_40_1)
		end
	end

	return
end

function var_0_1.IsFurnitureSetIn(arg_43_0, arg_43_1)
	ipairs = var_1_10002

	for iter_43_0, iter_43_1 in var_1_10002(arg_43_0.furnitures) do
		if iter_43_1:GetConfigID() == arg_43_1 and iter_43_1.slotId > 0 then
			return true
		end
	end

	return false
end

function var_0_1.UpdateFurnitureReplaceConfig(arg_44_0)
	local var_44_0 = {}

	ipairs = var_1_10002

	for iter_44_0, iter_44_1 in var_1_10002(arg_44_0.furnitures) do
		if iter_44_1.slotId ~= 0 then
			var_44_0[iter_44_1.slotId] = iter_44_1
		end
	end

	return
end

var_0_1.ITEM_LOCK = 0
var_0_1.ITEM_UNLOCK = 1
var_0_1.ITEM_ACTIVE = 2
var_0_1.ITEM_FIRST = 3

function var_0_1.getTriggerableCollectItemDic(arg_45_0, arg_45_1)
	local var_45_0 = {}

	ipairs = var_1_10003
	pg = var_1_10005

	local var_45_1

	if not var_1_10005.dorm3d_collection_template.get_id_list_by_room_id[arg_45_0.configId] then
		var_45_1 = {}
	end

	for iter_45_0, iter_45_1 in var_1_10003(var_45_1) do
		pg = var_1_10008

		if var_1_10008.dorm3d_collection_template[iter_45_1].time == 0 or var_1_10008.time == arg_45_1 then
			ApartmentProxy = var_9

			if not var_9.CheckUnlockConfig(var_1_10008.unlock) then
				var_45_0[iter_45_1] = var_0_1.ITEM_LOCK
			elseif arg_45_0.collectItemDic[iter_45_1] then
				var_45_0[iter_45_1] = var_0_1.ITEM_ACTIVE
			else
				var_45_0[iter_45_1] = var_0_1.ITEM_FIRST
			end
		end
	end

	return var_45_0
end

function var_0_1.getNormalZoneNames(arg_46_0)
	underscore = var_1_10001

	local var_46_0 = var_1_10001(arg_46_0.zoneDic)
	local var_46_1 = var_1.chain(var_46_0)
	local var_46_2 = var_1.values(var_46_1)
	local var_46_3 = var_1.select(var_46_2, function(arg_47_0)
		return not arg_47_0:IsGlobal()
	end)
	local var_46_4 = var_1.map(var_46_3, function(arg_48_0)
		return arg_48_0:GetWatchCameraName()
	end)

	return var_1.value(var_46_4)
end

function var_0_1.getZoneConfig(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_0.zoneDic[arg_49_1]

	return var_3.getConfig(var_49_0, arg_49_2)
end

function var_0_1.getApartmentZoneConfig(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	Apartment = var_1_10004

	return var_1_10004.getGroupConfig(arg_50_3, arg_50_0:getZoneConfig(arg_50_1, arg_50_2))
end

function var_0_1.getAllARAnimationListByShip(arg_51_0, arg_51_1)
	return arg_51_0.shipArAnimationDic[arg_51_1]
end

function var_0_1.getMiniGames(arg_52_0)
	underscore = var_1_10001

	local var_52_0 = var_1_10001.rest

	pg = var_1_10003

	local var_52_1

	if not var_1_10003.dorm3d_minigame.get_id_list_by_room_id[arg_52_0.configId] then
		var_52_1 = {}
	end

	return var_52_0(var_52_1, 1)
end

function var_0_1.unlockAllInvite(arg_53_0)
	ipairs = var_1_10001

	for iter_53_0, iter_53_1 in var_1_10001(arg_53_0:getConfig("character_pay")) do
		if not arg_53_0.unlockCharacter[iter_53_1] then
			return false
		end
	end

	return true
end

function var_0_1.GetAllTouchIDByZone(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = {}

	if arg_54_0:getApartmentZoneConfig(arg_54_1, "touch_id", arg_54_2) then
		table = var_1_10005

		var_1_10005.insert(var_54_0, {
			touchId = var_4
		})
	end

	pairs = var_1_10005

	for iter_54_0, iter_54_1 in var_1_10005(arg_54_0.furnitures) do
		if iter_54_1:GetSlotID() > 0 and arg_54_0.slotDic[iter_54_1:GetSlotID()] then
			pg = var_11

			if var_11.dorm3d_zone_template[var_10:GetZoneID()].watch_camera == arg_54_1 then
				local var_54_1 = iter_54_1
				local var_54_2 = iter_54_1.GetName(var_54_1)

				Apartment = var_12

				local var_54_3 = var_12.getGroupConfig(arg_54_2, iter_54_1:getConfig("touch_id"))

				if var_54_2 and var_54_3 then
					table = var_54_1

					var_54_1.insert(var_54_0, {
						touchId = var_54_3,
						furnitureName = var_54_2
					})
				end
			end
		end
	end

	return var_54_0
end

return var_0_1
