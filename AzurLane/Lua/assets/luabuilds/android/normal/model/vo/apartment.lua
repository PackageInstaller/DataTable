class = var_0_10000

local var_0_0 = "Apartment"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.ship_group
	arg_1_0.level = arg_1_1.favor_lv
	arg_1_0.favor = arg_1_1.favor_exp
	arg_1_0.daily = arg_1_1.daily_favor
	arg_1_0.skinId = arg_1_1.cur_skin
	arg_1_0.callName = arg_1_1.name
	arg_1_0.setCallCd = arg_1_1.name_cd
	pg = var_2

	local var_1_0 = var_2.TimeMgr.GetInstance()

	arg_1_0.setCallTimeStamp = var_2.GetServerTime(var_1_0)
	arg_1_0.visitTime = arg_1_1.visit_time
	arg_1_0.skinList = {}
	arg_1_0.hiddenInfo = {}
	table = var_2

	var_2.insert(arg_1_0.skinList, arg_1_0:getConfig("skin_model"))

	ipairs = var_2

	local var_1_1

	if not arg_1_1.skins then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_1) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.skinList, iter_1_1)
	end

	ipairs = var_2

	local var_1_2

	if not arg_1_1.hidden_parts then
		var_1_2 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_2) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.hiddenInfo, {
			skin_id = iter_1_3.id,
			hidden_parts = {}
		})

		ipairs = var_1_10007

		local var_1_3

		if not iter_1_3.hidden_parts then
			var_1_3 = {}
		end

		for iter_1_4, iter_1_5 in var_1_10007(var_1_3) do
			table = var_1_10012

			var_1_10012.insert(arg_1_0.hiddenInfo[#arg_1_0.hiddenInfo].hidden_parts, iter_1_5)
		end
	end

	table = var_2

	var_2.sort(arg_1_0.skinList)

	setmetatable = var_2
	arg_1_0.triggerCountDic = var_2({}, {
		__index = function(arg_2_0, arg_2_1)
			return 0
		end
	})
	ipairs = var_2

	local var_1_4

	if not arg_1_1.regular_trigger then
		var_1_4 = {}
	end

	for iter_1_6, iter_1_7 in var_2(var_1_4) do
		arg_1_0.triggerCountDic[iter_1_7] = arg_1_0.triggerCountDic[iter_1_7] + 1
	end

	arg_1_0.talkDic = {}
	ipairs = var_2

	local var_1_5

	if not arg_1_1.dialogues then
		var_1_5 = {}
	end

	for iter_1_8, iter_1_9 in var_2(var_1_5) do
		arg_1_0.talkDic[iter_1_9] = true
	end

	return
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_dorm_template
end

function var_0_1.getFavorConfig(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or arg_4_0.level
	pg = var_1_10003

	local var_4_0 = var_1_10003.dorm3d_favor.get_id_list_by_char_id[arg_4_0.configId]

	pg = var_4

	return var_4.dorm3d_favor[var_4_0[arg_4_2]][arg_4_1]
end

function var_0_1.getFavor(arg_5_0)
	local var_5_0 = arg_5_0.favor
	local var_5_1 = arg_5_0:getNextFavor()
end

function var_0_1.getNextFavor(arg_6_0)
	local var_6_0 = arg_6_0.level

	getDorm3dGameset = var_1_10002

	if var_6_0 < var_1_10002("favor_level")[1] then
		return arg_6_0:getFavorConfig("favor_exp", arg_6_0.level + 1)
	else
		return 2147483647
	end

	return
end

function var_0_1.getMaxFavor(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = arg_7_0.level + 1

	getDorm3dGameset = var_1_10003

	for iter_7_0 = var_7_1, var_1_10003("favor_level")[1] do
		var_7_0 = var_7_0 + arg_7_0:getFavorConfig("favor_exp", iter_7_0)
	end

	return var_7_0
end

function var_0_1.isMaxFavor(arg_8_0)
	local var_8_0 = arg_8_0.level

	getDorm3dGameset = var_1_10002

	return var_8_0 >= var_1_10002("favor_level")[1] or arg_8_0.favor >= arg_8_0:getMaxFavor()
end

function var_0_1.getLevel(arg_9_0)
	local var_9_0 = arg_9_0.level

	getDorm3dGameset = var_1_10002

	return var_9_0, var_1_10002("favor_level")[1]
end

function var_0_1.canLevelUp(arg_10_0)
	local var_10_0 = arg_10_0.level

	getDorm3dGameset = var_1_10002

	return var_10_0 < var_1_10002("favor_level")[1] and arg_10_0.favor >= arg_10_0:getNextFavor()
end

function var_0_1.addLevel(arg_11_0)
	assert = var_1_10001

	var_1_10001(arg_11_0:canLevelUp())

	arg_11_0.favor = arg_11_0.favor - arg_11_0:getNextFavor()
	arg_11_0.level = arg_11_0.level + 1

	return
end

function var_0_1.addSkin(arg_12_0, arg_12_1)
	table = var_1_10002

	var_1_10002.insert(arg_12_0.skinList, arg_12_1)

	table = var_2

	var_2.sort(arg_12_0.skinList)

	return
end

function var_0_1.GetCurSkinId(arg_13_0)
	if arg_13_0.skinId == 0 then
		return arg_13_0:getConfig("skin_model")
	else
		return arg_13_0.skinId
	end

	return
end

function var_0_1.GetSkinModelID(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.getConfig(var_14_0, "skin_model")

	if arg_14_1 and arg_14_1 ~= "" then
		underscore = var_14_0

		local var_14_2 = var_14_0.detect

		pg = var_4

		local var_14_3

		if not var_4.dorm3d_resource.get_id_list_by_ship_group[arg_14_0.configId] then
			var_14_3 = {}
		end

		var_14_1 = var_14_2(var_14_3, function(arg_15_0)
			table = var_2_10001

			local var_15_0 = var_2_10001.contains

			pg = var_2_10002

			return var_15_0(var_2_10002.dorm3d_resource[arg_15_0].tags, arg_14_1)
		end)
	end

	return var_14_1
end

function var_0_1.GetCallName(arg_16_0)
	local var_16_0

	if not arg_16_0.callName or not (#arg_16_0.callName > 0) or not arg_16_0.callName then
		pg = var_16_0
		var_16_0 = var_16_0.dorm3d_dorm_template[arg_16_0.configId].default_appellation
	end

	return var_16_0
end

function var_0_1.GetSetCallCd(arg_17_0)
	if arg_17_0.setCallCd then
		pg = var_1
		var_1_10002 = var_1.TimeMgr.GetInstance()

		local var_17_0 = var_1.GetServerTime(var_1_10002)

		if arg_17_0.setCallCd <= var_17_0 then
			return 0
		end

		local var_17_1 = arg_17_0.setCallCd

		pg = var_1_10002

		local var_17_2 = var_1_10002.TimeMgr.GetInstance()

		return var_17_1 - var_2.GetServerTime(var_17_2)
	end
end

function var_0_1.GetHiddenParts(arg_18_0, arg_18_1)
	underscore = var_1_10002

	if not var_1_10002.detect(arg_18_0.hiddenInfo, function(arg_19_0)
		return arg_19_0.skin_id == arg_18_1
	end) then
		PlayerPrefs = var_3

		if var_3.GetInt(var_0_1.GetSetSkinKey(arg_18_1), 0) == 0 then
			return arg_18_0:GetDefaultHiddenParts(arg_18_1)
		end

		return {}
	end

	local var_18_0

	if not var_2.hidden_parts then
		var_18_0 = {}
	end

	return var_18_0
end

function var_0_1.GetSetSkinKey(arg_20_0)
	local var_20_0 = "dorm3d_apartment_set_skin_"
	local var_20_1 = arg_20_0
	local var_20_2 = "_"

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_20_3 = var_1_10004(var_1_10005)

	return var_20_0 .. var_20_1 .. var_20_2 .. var_4.getRawData(var_20_3).id
end

function var_0_1.GetDefaultHiddenParts(arg_21_0, arg_21_1)
	pg = var_1_10002

	local var_21_0

	if not var_1_10002.dorm3d_default_hidden_part.get_id_list_by_skin_id[arg_21_1] then
		var_21_0 = {}
	end

	return var_21_0
end

function var_0_1.SetHiddenParts(arg_22_0, arg_22_1, arg_22_2)
	PlayerPrefs = var_1_10003

	var_1_10003.SetInt(var_0_1.GetSetSkinKey(arg_22_1), 1)

	underscore = var_3

	if not var_3.detect(arg_22_0.hiddenInfo, function(arg_23_0)
		return arg_23_0.skin_id == arg_22_1
	end) then
		table = var_4

		var_4.insert(arg_22_0.hiddenInfo, {
			skin_id = arg_22_1,
			hidden_parts = arg_22_2
		})
	else
		var_3.hidden_parts = arg_22_2
	end

	return
end

function var_0_1.getTalkingList(arg_24_0, arg_24_1)
	underscore = var_1_10002

	local var_24_0 = var_1_10002.filter

	pg = var_1_10003

	local var_24_1

	if not var_1_10003.dorm3d_dialogue_group.get_id_list_by_char_id[arg_24_0.configId] then
		var_24_1 = {}
	end

	return var_24_0(var_24_1, function(arg_25_0)
		pg = var_2_10001

		local var_25_0 = var_2_10001.dorm3d_dialogue_group[arg_25_0]

		if arg_24_1.typeDic then
			tobool = var_25_1

			if var_25_1(arg_24_1.typeDic[var_25_0.type]) then
				if (not arg_24_1.roomId or var_25_0.room_id == 0 or arg_24_1.roomId == var_25_0.room_id) and (not arg_24_1.unplay or not arg_24_0.talkDic[arg_25_0]) then
					local var_25_1

					if arg_24_1.unlock then
						ApartmentProxy = var_25_1
						var_25_1 = var_25_1.CheckUnlockConfig(var_25_0.unlock)

						if false then
							var_25_1 = false
						end
					else
						var_25_1 = true
					end

					return var_25_1
				end
			end
		end
	end)
end

function var_0_1.getForceEnterTalking(arg_26_0, arg_26_1)
	DORM_LOCK_GUIDE = var_1_10002

	if var_1_10002 then
		return {}
	end

	return arg_26_0:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[100] = true
		},
		roomId = arg_26_1
	})
end

var_0_1.ENTER_TALK_TYPE_DIC = {
	[101] = function(arg_27_0, arg_27_1)
		PlayerPrefs = var_1_10002

		local var_27_0 = var_1_10002.GetString("DORM3D_DAILY_ENTER", "")

		pg = var_3

		local var_27_1 = var_3.TimeMgr.GetInstance()

		return var_27_0 ~= var_3.CurrentSTimeDesc(var_27_1, "%Y/%m/%d")
	end,
	[102] = function(arg_28_0, arg_28_1)
		underscore = var_1_10002

		return var_1_10002.any(arg_28_0, function(arg_29_0)
			getProxy = var_2_10001
			ActivityProxy = var_2_10002

			local var_29_0 = var_2_10001(var_2_10002)

			return var_1.IsActivityNotEnd(var_29_0, arg_29_0)
		end)
	end,
	[103] = function(arg_30_0, arg_30_1)
		PlayerPrefs = var_1_10002

		return var_1_10002.GetInt("dorm3d_enter_count_" .. arg_30_1, 0) > arg_30_0[1]
	end,
	[104] = function(arg_31_0, arg_31_1)
		return true
	end
}

function var_0_1.getEnterTalking(arg_32_0, arg_32_1)
	local var_32_0

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_0:getTalkingList({
		unlock = true,
		typeDic = var_0_1.ENTER_TALK_TYPE_DIC,
		roomId = arg_32_1
	})) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.dorm3d_dialogue_group[iter_32_1]
		switch = var_1_10009

		if var_1_10009(var_1_10008.type, var_0_1.ENTER_TALK_TYPE_DIC, function(arg_33_0)
			return false
		end, var_1_10008.trigger_config, arg_32_0.configId) then
			if var_32_0 then
				var_1_10009 = var_1_10008.type
				pg = var_10

				if var_1_10009 < var_10.dorm3d_dialogue_group[var_32_0[1]].type then
					var_32_0 = {
						iter_32_1
					}
				else
					var_1_10009 = var_1_10008.type
					pg = var_10

					if var_1_10009 == var_10.dorm3d_dialogue_group[var_32_0[1]].type then
						table = var_1_10009

						var_1_10009.insert(var_32_0, iter_32_1)
					end
				end
			end
		end
	end

	return var_32_0 or {}
end

function var_0_1.getFurnitureTalking(arg_34_0, arg_34_1, arg_34_2)
	underscore = var_1_10003

	return var_1_10003.filter(arg_34_0:getTalkingList({
		unlock = true,
		typeDic = {
			[200] = true
		},
		roomId = arg_34_1
	}), function(arg_35_0)
		pg = var_2_10001

		return var_2_10001.dorm3d_dialogue_group[arg_35_0].trigger_config == "" or var_1.trigger_config == arg_34_2
	end)
end

function var_0_1.getZoneTalking(arg_36_0, arg_36_1, arg_36_2)
	underscore = var_1_10003

	return var_1_10003.filter(arg_36_0:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[300] = true
		},
		roomId = arg_36_1
	}), function(arg_37_0)
		pg = var_2_10001

		return var_2_10001.dorm3d_dialogue_group[arg_37_0].trigger_config == arg_36_2
	end)
end

function var_0_1.getDistanceTalking(arg_38_0, arg_38_1, arg_38_2)
	underscore = var_1_10003

	return var_1_10003.filter(arg_38_0:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[550] = true
		},
		roomId = arg_38_1
	}), function(arg_39_0)
		pg = var_2_10001

		return var_2_10001.dorm3d_dialogue_group[arg_39_0].trigger_config == arg_38_2
	end)
end

function var_0_1.getSpecialTalking(arg_40_0, arg_40_1)
	return arg_40_0:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[700] = true
		},
		roomId = arg_40_1
	})
end

function var_0_1.getGiftIds(arg_41_0)
	pg = var_1_10001

	local var_41_0 = var_1_10001.dorm3d_gift.get_id_list_by_ship_group_id

	table = var_1_10002

	local var_41_1 = var_1_10002.mergeArray
	local var_41_2 = var_41_0[0]
	local var_41_3

	if not var_41_0[arg_41_0.configId] then
		var_41_3 = {}
	end

	return var_41_1(var_41_2, var_41_3)
end

function var_0_1.needDownload(arg_42_0)
	ApartmentRoom = var_1_10001

	local var_42_0 = var_1_10001.New({
		id = arg_42_0:getConfig("bind_room")
	})

	return #var_1.getDownloadNameList(var_42_0) > 0
end

function var_0_1.filterUnlockTalkList(arg_43_0, arg_43_1)
	underscore = var_1_10002

	return var_1_10002.filter(arg_43_1, function(arg_44_0)
		ApartmentProxy = var_2_10001

		local var_44_0 = var_2_10001.CheckUnlockConfig

		pg = var_2_10002

		return var_44_0(var_2_10002.dorm3d_dialogue_group[arg_44_0].unlock)
	end)
end

function var_0_1.getIconTip(arg_45_0, arg_45_1)
	local var_45_0 = #arg_45_0:getForceEnterTalking(arg_45_1)

	if 0 < var_45_0 then
		return "main"
	else
		getProxy = var_45_0
		ApartmentProxy = var_3

		local var_45_1 = var_45_0(var_3)

		if var_2.getApartmentGiftCount(var_45_1, arg_45_0.configId) then
			return "gift"
		else
			Dorm3dFurniture = var_2

			if var_2.IsTimelimitShopTip(arg_45_1) then
				return "furniture"
			elseif false then
				return "talk"
			else
				return nil
			end
		end
	end

	return
end

function var_0_1.getGroupConfig(arg_46_0, arg_46_1)
	if not arg_46_1 or arg_46_1 == "" then
		return nil
	end

	ipairs = var_1_10002

	for iter_46_0, iter_46_1 in var_1_10002(arg_46_1) do
		if iter_46_1[1] == arg_46_0 then
			return iter_46_1[2]
		end
	end

	return nil
end

function var_0_1.GetAllModelIds(arg_47_0)
	pg = var_1_10001

	local var_47_0

	if not var_1_10001.dorm3d_resource.get_id_list_by_ship_group[arg_47_0.configId] then
		var_47_0 = {}
	end

	return var_47_0
end

function var_0_1.CheckAllCollectionTrack()
	getProxy = var_1_10000
	ApartmentProxy = var_1_10001

	local var_48_0 = var_1_10000(var_1_10001)

	if not var_0.CheckAllRoomInviteAll(var_48_0) then
		return
	end

	local var_48_1 = 0
	local var_48_2 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_48_0, iter_48_1 in var_1_10002(var_1_10003.dorm3d_recall.all) do
		pg = var_1_10007
		var_1_10008 = var_1_10007.dorm3d_recall[iter_48_1].story_id
		pg = var_1_10009

		if var_48_2[var_1_10009.dorm3d_dialogue_group[var_1_10008].char_id] == nil then
			getProxy = var_10
			ApartmentProxy = var_1_10011
			var_1_10011 = var_10(var_1_10011)

			local var_48_3

			if not var_10.getApartment(var_1_10011, var_1_10009) then
				var_48_3 = false
			end

			var_48_2[var_1_10009] = var_48_3
		end

		if not var_48_2[var_1_10009] or not var_48_2[var_1_10009].talkDic[var_1_10008] then
			var_48_1 = -1

			break
		else
			var_48_1 = var_48_1 + 1
		end
	end

	if var_48_1 < 0 then
		return
	end

	getProxy = var_2
	ApartmentProxy = var_3

	local var_48_4 = var_2(var_3).shopCount

	ipairs = var_3
	pg = var_4

	for iter_48_2, iter_48_3 in var_3(var_4.dorm3d_shop_template.all) do
		pg = var_1_10008

		if var_1_10008.dorm3d_shop_template[iter_48_3].room_id ~= 0 then
			if var_1_10008.type == 2 then
				defaultValue = var_9

				if var_9(var_48_4.permanentGift[var_1_10008.item_id], 0) > 0 then
					var_48_1 = var_48_1 + 1
				else
					var_48_1 = -1

					break
				end
			elseif var_1_10008.type == 1 then
				defaultValue = var_9

				if var_9(var_48_4.permanentFurniture[var_1_10008.item_id], 0) > 0 then
					var_48_1 = var_48_1 + 1
				else
					var_48_1 = -1

					break
				end
			end
		end
	end

	getProxy = var_3
	PlayerProxy = var_4

	local var_48_5 = var_3(var_4)
	local var_48_6 = var_3.getRawData(var_48_5).id

	PlayerPrefs = var_48_5

	if var_48_5.GetInt("APARTMENT_ALL_COLLECTION:" .. var_48_6, 0) < var_48_1 then
		PlayerPrefs = var_4

		var_4.SetInt("APARTMENT_ALL_COLLECTION:" .. var_48_6, var_48_1)

		pg = var_4

		local var_48_7 = var_4.GameTrackerMgr.GetInstance()
		local var_48_8 = var_4.Record

		GameTrackerBuilder = var_6

		var_48_8(var_48_7, var_6.BuildAllCollection(20002, var_48_1))
	end

	return
end

return var_0_1
