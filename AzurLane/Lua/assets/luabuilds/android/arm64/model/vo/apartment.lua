local var_0_0 = class("Apartment", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.ship_group
	arg_1_0.level = arg_1_1.favor_lv
	arg_1_0.favor = arg_1_1.favor_exp
	arg_1_0.daily = arg_1_1.daily_favor
	arg_1_0.skinId = arg_1_1.cur_skin
	arg_1_0.callName = arg_1_1.name
	arg_1_0.setCallCd = arg_1_1.name_cd
	arg_1_0.setCallTimeStamp = pg.TimeMgr.GetInstance():GetServerTime()
	arg_1_0.visitTime = arg_1_1.visit_time
	arg_1_0.skinList = {}
	arg_1_0.hiddenInfo = {}

	table.insert(arg_1_0.skinList, arg_1_0:getConfig("skin_model"))

	local var_1_0 = arg_1_1.skins or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.skinList, iter_1_1)
	end

	local var_1_1 = arg_1_1.hidden_parts or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		table.insert(arg_1_0.hiddenInfo, {
			skin_id = iter_1_3.id,
			hidden_parts = {}
		})

		local var_1_2 = iter_1_3.hidden_parts or {}

		for iter_1_4, iter_1_5 in ipairs(var_1_2) do
			table.insert(arg_1_0.hiddenInfo[#arg_1_0.hiddenInfo].hidden_parts, iter_1_5)
		end
	end

	table.sort(arg_1_0.skinList)

	arg_1_0.triggerCountDic = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			return 0
		end
	})

	local var_1_3 = arg_1_1.regular_trigger or {}

	for iter_1_6, iter_1_7 in ipairs(var_1_3) do
		arg_1_0.triggerCountDic[iter_1_7] = arg_1_0.triggerCountDic[iter_1_7] + 1
	end

	arg_1_0.talkDic = {}

	local var_1_4 = arg_1_1.dialogues or {}

	for iter_1_8, iter_1_9 in ipairs(var_1_4) do
		arg_1_0.talkDic[iter_1_9] = true
	end

	return
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.dorm3d_dorm_template
end

function var_0_0.getFavorConfig(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or arg_4_0.level

	return pg.dorm3d_favor[pg.dorm3d_favor.get_id_list_by_char_id[arg_4_0.configId][arg_4_2]][arg_4_1]
end

function var_0_0.getFavor(arg_5_0)
	local var_5_1 = arg_5_0:getNextFavor()
end

function var_0_0.getNextFavor(arg_6_0)
	if arg_6_0.level < getDorm3dGameset("favor_level")[1] then
		return arg_6_0:getFavorConfig("favor_exp", arg_6_0.level + 1)
	else
		return 2147483647
	end

	return
end

function var_0_0.getMaxFavor(arg_7_0)
	local var_7_0 = 0

	for iter_7_0 = arg_7_0.level + 1, getDorm3dGameset("favor_level")[1] do
		var_7_0 = var_7_0 + arg_7_0:getFavorConfig("favor_exp", iter_7_0)
	end

	return var_7_0
end

function var_0_0.isMaxFavor(arg_8_0)
	return arg_8_0.level >= getDorm3dGameset("favor_level")[1] or arg_8_0.favor >= arg_8_0:getMaxFavor()
end

function var_0_0.getLevel(arg_9_0)
	return arg_9_0.level, getDorm3dGameset("favor_level")[1]
end

function var_0_0.canLevelUp(arg_10_0)
	return arg_10_0.level < getDorm3dGameset("favor_level")[1] and arg_10_0.favor >= arg_10_0:getNextFavor()
end

function var_0_0.addLevel(arg_11_0)
	assert(arg_11_0:canLevelUp())

	arg_11_0.favor = arg_11_0.favor - arg_11_0:getNextFavor()
	arg_11_0.level = arg_11_0.level + 1

	return
end

function var_0_0.addSkin(arg_12_0, arg_12_1)
	table.insert(arg_12_0.skinList, arg_12_1)
	table.sort(arg_12_0.skinList)

	return
end

function var_0_0.GetCurSkinId(arg_13_0)
	if arg_13_0.skinId == 0 then
		return arg_13_0:getConfig("skin_model")
	else
		return arg_13_0.skinId
	end

	return
end

function var_0_0.GetSkinModelID(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getConfig("skin_model")

	if arg_14_1 and arg_14_1 ~= "" then
		local var_14_1 = pg.dorm3d_resource.get_id_list_by_ship_group[arg_14_0.configId] or {}

		var_14_0 = underscore.detect(var_14_1, function(arg_15_0)
			return table.contains(pg.dorm3d_resource[arg_15_0].tags, arg_14_1)
		end)
	end

	return var_14_0
end

function var_0_0.GetCallName(arg_16_0)
	if arg_16_0.callName and #arg_16_0.callName > 0 then
		return arg_16_0.callName or pg.dorm3d_dorm_template[arg_16_0.configId].default_appellation
	end
end

function var_0_0.GetSetCallCd(arg_17_0)
	if arg_17_0.setCallCd then
		if pg.TimeMgr.GetInstance():GetServerTime() >= arg_17_0.setCallCd then
			return 0
		end

		return arg_17_0.setCallCd - pg.TimeMgr.GetInstance():GetServerTime()
	end
end

function var_0_0.GetHiddenParts(arg_18_0, arg_18_1)
	local var_18_0 = underscore.detect(arg_18_0.hiddenInfo, function(arg_19_0)
		return arg_19_0.skin_id == arg_18_1
	end)

	if not var_18_0 then
		if PlayerPrefs.GetInt(var_0_0.GetSetSkinKey(arg_18_1), 0) == 0 then
			return arg_18_0:GetDefaultHiddenParts(arg_18_1)
		end

		return {}
	end

	return var_18_0.hidden_parts or {}
end

function var_0_0.GetSetSkinKey(arg_20_0)
	return "dorm3d_apartment_set_skin_" .. arg_20_0 .. "_" .. getProxy(PlayerProxy):getRawData().id
end

function var_0_0.GetDefaultHiddenParts(arg_21_0, arg_21_1)
	return pg.dorm3d_default_hidden_part.get_id_list_by_skin_id[arg_21_1] or {}
end

function var_0_0.SetHiddenParts(arg_22_0, arg_22_1, arg_22_2)
	PlayerPrefs.SetInt(var_0_0.GetSetSkinKey(arg_22_1), 1)

	local var_22_0 = underscore.detect(arg_22_0.hiddenInfo, function(arg_23_0)
		return arg_23_0.skin_id == arg_22_1
	end)

	if not var_22_0 then
		table.insert(arg_22_0.hiddenInfo, {
			skin_id = arg_22_1,
			hidden_parts = arg_22_2
		})
	else
		var_22_0.hidden_parts = arg_22_2
	end

	return
end

function var_0_0.getTalkingList(arg_24_0, arg_24_1)
	local var_24_0 = pg.dorm3d_dialogue_group.get_id_list_by_char_id[arg_24_0.configId] or {}

	return underscore.filter(var_24_0, function(arg_25_0)
		return (not arg_24_1.typeDic or tobool(arg_24_1.typeDic[pg.dorm3d_dialogue_group[arg_25_0].type])) and (not arg_24_1.roomId or pg.dorm3d_dialogue_group[arg_25_0].room_id == 0 or arg_24_1.roomId == pg.dorm3d_dialogue_group[arg_25_0].room_id) and (not arg_24_1.unplay or not arg_24_0.talkDic[arg_25_0]) and (not arg_24_1.unlock or ApartmentProxy.CheckUnlockConfig(pg.dorm3d_dialogue_group[arg_25_0].unlock))
	end)
end

function var_0_0.getForceEnterTalking(arg_26_0, arg_26_1)
	if DORM_LOCK_GUIDE then
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

var_0_0.ENTER_TALK_TYPE_DIC = {
	[101] = function(arg_27_0, arg_27_1)
		local var_27_0 = pg.TimeMgr.GetInstance()

		return PlayerPrefs.GetString("DORM3D_DAILY_ENTER", "") ~= var_27_0:CurrentSTimeDesc("%Y/%m/%d")
	end,
	[102] = function(arg_28_0, arg_28_1)
		return underscore.any(arg_28_0, function(arg_29_0)
			return getProxy(ActivityProxy):IsActivityNotEnd(arg_29_0)
		end)
	end,
	[103] = function(arg_30_0, arg_30_1)
		return PlayerPrefs.GetInt("dorm3d_enter_count_" .. arg_30_1, 0) > arg_30_0[1]
	end,
	[104] = function(arg_31_0, arg_31_1)
		return true
	end
}

function var_0_0.getEnterTalking(arg_32_0, arg_32_1)
	local var_32_0

	for iter_32_0, iter_32_1 in ipairs(arg_32_0:getTalkingList({
		unlock = true,
		typeDic = var_0_0.ENTER_TALK_TYPE_DIC,
		roomId = arg_32_1
	})) do
		if switch(pg.dorm3d_dialogue_group[iter_32_1].type, var_0_0.ENTER_TALK_TYPE_DIC, function(arg_33_0)
			return false
		end, pg.dorm3d_dialogue_group[iter_32_1].trigger_config, arg_32_0.configId) then
			if not var_32_0 or pg.dorm3d_dialogue_group[iter_32_1].type < pg.dorm3d_dialogue_group[var_32_0[1]].type then
				var_32_0 = {
					iter_32_1
				}
			elseif pg.dorm3d_dialogue_group[iter_32_1].type == pg.dorm3d_dialogue_group[var_32_0[1]].type then
				table.insert(var_32_0, iter_32_1)
			end
		end
	end

	return var_32_0 or {}
end

function var_0_0.getFurnitureTalking(arg_34_0, arg_34_1, arg_34_2)
	return underscore.filter(arg_34_0:getTalkingList({
		unlock = true,
		typeDic = {
			[200] = true
		},
		roomId = arg_34_1
	}), function(arg_35_0)
		local var_35_0 = pg.dorm3d_dialogue_group[arg_35_0]

		return pg.dorm3d_dialogue_group[arg_35_0].trigger_config == "" or var_35_0.trigger_config == arg_34_2
	end)
end

function var_0_0.getZoneTalking(arg_36_0, arg_36_1, arg_36_2)
	return underscore.filter(arg_36_0:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[300] = true
		},
		roomId = arg_36_1
	}), function(arg_37_0)
		return pg.dorm3d_dialogue_group[arg_37_0].trigger_config == arg_36_2
	end)
end

function var_0_0.getDistanceTalking(arg_38_0, arg_38_1, arg_38_2)
	return underscore.filter(arg_38_0:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[550] = true
		},
		roomId = arg_38_1
	}), function(arg_39_0)
		return pg.dorm3d_dialogue_group[arg_39_0].trigger_config == arg_38_2
	end)
end

function var_0_0.getSpecialTalking(arg_40_0, arg_40_1)
	return arg_40_0:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[700] = true
		},
		roomId = arg_40_1
	})
end

function var_0_0.getGiftIds(arg_41_0)
	local var_41_0 = pg.dorm3d_gift.get_id_list_by_ship_group_id[arg_41_0.configId] or {}

	return table.mergeArray(pg.dorm3d_gift.get_id_list_by_ship_group_id[0], var_41_0)
end

function var_0_0.needDownload(arg_42_0)
	local var_42_0 = ApartmentRoom.New({
		id = arg_42_0:getConfig("bind_room")
	})

	return #var_42_0:getDownloadNameList() > 0
end

function var_0_0.filterUnlockTalkList(arg_43_0, arg_43_1)
	return underscore.filter(arg_43_1, function(arg_44_0)
		return ApartmentProxy.CheckUnlockConfig(pg.dorm3d_dialogue_group[arg_44_0].unlock)
	end)
end

function var_0_0.getIconTip(arg_45_0, arg_45_1)
	if #arg_45_0:getForceEnterTalking(arg_45_1) > 0 then
		return "main"
	else
		local var_45_0 = getProxy(ApartmentProxy)

		if var_45_0:getApartmentGiftCount(arg_45_0.configId) then
			return "gift"
		elseif Dorm3dFurniture.IsTimelimitShopTip(arg_45_1) then
			return "furniture"
		elseif false then
			return "talk"
		else
			return nil
		end
	end

	return
end

function var_0_0.getGroupConfig(arg_46_0, arg_46_1)
	if not arg_46_1 or arg_46_1 == "" then
		return nil
	end

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		if iter_46_1[1] == arg_46_0 then
			return iter_46_1[2]
		end
	end

	return nil
end

function var_0_0.GetAllModelIds(arg_47_0)
	return pg.dorm3d_resource.get_id_list_by_ship_group[arg_47_0.configId] or {}
end

function var_0_0.CheckAllCollectionTrack()
	if not getProxy(ApartmentProxy):CheckAllRoomInviteAll() then
		return
	end

	local var_48_0 = 0

	for iter_48_0, iter_48_1 in ipairs(pg.dorm3d_recall.all) do
		if ({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id] == nil then
			local var_48_1 = getProxy(ApartmentProxy):getApartment(pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id)

			var_48_1 = var_48_1 or false
			;({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id] = var_48_1
		end

		if not ({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id] or not ({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id].talkDic[pg.dorm3d_recall[iter_48_1].story_id] then
			var_48_0 = -1

			break
		else
			var_48_0 = var_48_0 + 1
		end
	end

	if var_48_0 < 0 then
		return
	end

	local var_48_2 = getProxy(ApartmentProxy).shopCount

	for iter_48_2, iter_48_3 in ipairs(pg.dorm3d_shop_template.all) do
		if pg.dorm3d_shop_template[iter_48_3].room_id ~= 0 then
			if pg.dorm3d_shop_template[iter_48_3].type == 2 then
				if defaultValue(var_48_2.permanentGift[pg.dorm3d_shop_template[iter_48_3].item_id], 0) > 0 then
					var_48_0 = var_48_0 + 1
				else
					var_48_0 = -1

					break
				end
			elseif pg.dorm3d_shop_template[iter_48_3].type == 1 then
				if defaultValue(var_48_2.permanentFurniture[pg.dorm3d_shop_template[iter_48_3].item_id], 0) > 0 then
					var_48_0 = var_48_0 + 1
				else
					var_48_0 = -1

					break
				end
			end
		end
	end

	local var_48_3 = getProxy(PlayerProxy)
	local var_48_4 = var_48_3:getRawData().id

	if var_48_0 > PlayerPrefs.GetInt("APARTMENT_ALL_COLLECTION:" .. var_48_4, 0) then
		PlayerPrefs.SetInt("APARTMENT_ALL_COLLECTION:" .. var_48_4, var_48_0)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAllCollection(20002, var_48_0))
	end

	return
end

return var_0_0
