local Apartment = class("Apartment", import(".BaseVO"))

function Apartment:Ctor(arg_1_1)
	self.configId = arg_1_1.ship_group
	self.level = arg_1_1.favor_lv
	self.favor = arg_1_1.favor_exp
	self.daily = arg_1_1.daily_favor
	self.skinId = arg_1_1.cur_skin
	self.callName = arg_1_1.name
	self.setCallCd = arg_1_1.name_cd
	self.setCallTimeStamp = pg.TimeMgr.GetInstance():GetServerTime()
	self.visitTime = arg_1_1.visit_time
	self.skinList = {}
	self.hiddenInfo = {}

	table.insert(self.skinList, self:getConfig("skin_model"))

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.skins or {}) do
		table.insert(self.skinList, iter_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.hidden_parts or {}) do
		table.insert(self.hiddenInfo, {
			skin_id = iter_1_3.id,
			hidden_parts = {}
		})

		for iter_1_4, iter_1_5 in ipairs(iter_1_3.hidden_parts or {}) do
			table.insert(self.hiddenInfo[#self.hiddenInfo].hidden_parts, iter_1_5)
		end
	end

	table.sort(self.skinList)

	self.triggerCountDic = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			return 0
		end
	})

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.regular_trigger or {}) do
		self.triggerCountDic[iter_1_7] = self.triggerCountDic[iter_1_7] + 1
	end

	self.talkDic = {}

	for iter_1_8, iter_1_9 in ipairs(arg_1_1.dialogues or {}) do
		self.talkDic[iter_1_9] = true
	end

	return
end

function Apartment:bindConfigTable()
	return pg.dorm3d_dorm_template
end

function Apartment:getFavorConfig(arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or self.level

	return pg.dorm3d_favor[pg.dorm3d_favor.get_id_list_by_char_id[self.configId][arg_4_2]][arg_4_1]
end

function Apartment:getFavor()
	local var_5_1 = self:getNextFavor()
end

function Apartment:getNextFavor()
	if self.level < getDorm3dGameset("favor_level")[1] then
		return self:getFavorConfig("favor_exp", self.level + 1)
	else
		return 2147483647
	end

	return
end

function Apartment:getMaxFavor()
	local var_7_0 = 0

	for iter_7_0 = self.level + 1, getDorm3dGameset("favor_level")[1] do
		var_7_0 = var_7_0 + self:getFavorConfig("favor_exp", iter_7_0)
	end

	return var_7_0
end

function Apartment:isMaxFavor()
	return self.level >= getDorm3dGameset("favor_level")[1] or self.favor >= self:getMaxFavor()
end

function Apartment:getLevel()
	return self.level, getDorm3dGameset("favor_level")[1]
end

function Apartment:canLevelUp()
	return self.level < getDorm3dGameset("favor_level")[1] and self.favor >= self:getNextFavor()
end

function Apartment:addLevel()
	assert(self:canLevelUp())

	self.favor = self.favor - self:getNextFavor()
	self.level = self.level + 1

	return
end

function Apartment:addSkin(arg_12_1)
	table.insert(self.skinList, arg_12_1)
	table.sort(self.skinList)

	return
end

function Apartment:GetCurSkinId()
	if self.skinId == 0 then
		return self:getConfig("skin_model")
	else
		return self.skinId
	end

	return
end

function Apartment:GetSkinModelID(arg_14_1)
	local var_14_0 = self:getConfig("skin_model")

	return (arg_14_1 and arg_14_1 ~= "" or nil) and underscore.detect(pg.dorm3d_resource.get_id_list_by_ship_group[self.configId] or {}, function(arg_15_0)
		return table.contains(pg.dorm3d_resource[arg_15_0].tags, arg_14_1)
	end)
end

function Apartment:GetCallName()
	return (self.callName and #self.callName > 0 or nil) and (self.callName or pg.dorm3d_dorm_template[self.configId].default_appellation)
end

function Apartment:GetSetCallCd()
	if self.setCallCd then
		if pg.TimeMgr.GetInstance():GetServerTime() >= self.setCallCd then
			return 0
		end
	end

	return self.setCallCd - pg.TimeMgr.GetInstance():GetServerTime()
end

function Apartment:GetHiddenParts(arg_18_1)
	local var_18_0 = underscore.detect(self.hiddenInfo, function(arg_19_0)
		return arg_19_0.skin_id == arg_18_1
	end)

	if not var_18_0 then
		if PlayerPrefs.GetInt(Apartment.GetSetSkinKey(arg_18_1), 0) == 0 then
			return self:GetDefaultHiddenParts(arg_18_1)
		end

		return {}
	end

	return var_18_0.hidden_parts or {}
end

function Apartment:GetSetSkinKey()
	return "dorm3d_apartment_set_skin_" .. self .. "_" .. getProxy(PlayerProxy):getRawData().id
end

function Apartment:GetDefaultHiddenParts(arg_21_1)
	return pg.dorm3d_default_hidden_part.get_id_list_by_skin_id[arg_21_1] or {}
end

function Apartment:SetHiddenParts(arg_22_1, arg_22_2)
	PlayerPrefs.SetInt(Apartment.GetSetSkinKey(arg_22_1), 1)

	local var_22_0 = underscore.detect(self.hiddenInfo, function(arg_23_0)
		return arg_23_0.skin_id == arg_22_1
	end)

	if not var_22_0 then
		table.insert(self.hiddenInfo, {
			skin_id = arg_22_1,
			hidden_parts = arg_22_2
		})
	else
		var_22_0.hidden_parts = arg_22_2
	end

	return
end

function Apartment:getTalkingList(arg_24_1)
	return underscore.filter(pg.dorm3d_dialogue_group.get_id_list_by_char_id[self.configId] or {}, function(arg_25_0)
		return (not arg_24_1.typeDic or tobool(arg_24_1.typeDic[pg.dorm3d_dialogue_group[arg_25_0].type])) and (not arg_24_1.roomId or pg.dorm3d_dialogue_group[arg_25_0].room_id == 0 or arg_24_1.roomId == pg.dorm3d_dialogue_group[arg_25_0].room_id) and (not arg_24_1.unplay or not self.talkDic[arg_25_0]) and (not arg_24_1.unlock or ApartmentProxy.CheckUnlockConfig(pg.dorm3d_dialogue_group[arg_25_0].unlock))
	end)
end

function Apartment:getForceEnterTalking(arg_26_1)
	if DORM_LOCK_GUIDE then
		return {}
	end

	return self:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[100] = true
		},
		roomId = arg_26_1
	})
end

Apartment.ENTER_TALK_TYPE_DIC = {
	[101] = function(arg_27_0, arg_27_1)
		return PlayerPrefs.GetString("DORM3D_DAILY_ENTER", "") ~= pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d")
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

function Apartment:getEnterTalking(arg_32_1)
	local var_32_0

	for iter_32_0, iter_32_1 in ipairs(self:getTalkingList({
		unlock = true,
		typeDic = Apartment.ENTER_TALK_TYPE_DIC,
		roomId = arg_32_1
	})) do
		if switch(pg.dorm3d_dialogue_group[iter_32_1].type, Apartment.ENTER_TALK_TYPE_DIC, function(arg_33_0)
			return false
		end, pg.dorm3d_dialogue_group[iter_32_1].trigger_config, self.configId) then
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

function Apartment:getFurnitureTalking(arg_34_1, arg_34_2)
	return underscore.filter(self:getTalkingList({
		unlock = true,
		typeDic = {
			[200] = true
		},
		roomId = arg_34_1
	}), function(arg_35_0)
		return pg.dorm3d_dialogue_group[arg_35_0].trigger_config == "" or pg.dorm3d_dialogue_group[arg_35_0].trigger_config == arg_34_2
	end)
end

function Apartment:getZoneTalking(arg_36_1, arg_36_2)
	return underscore.filter(self:getTalkingList({
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

function Apartment:getDistanceTalking(arg_38_1, arg_38_2)
	return underscore.filter(self:getTalkingList({
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

function Apartment:getSpecialTalking(arg_40_1)
	return self:getTalkingList({
		unplay = true,
		unlock = true,
		typeDic = {
			[700] = true
		},
		roomId = arg_40_1
	})
end

function Apartment:getGiftIds()
	return table.mergeArray(pg.dorm3d_gift.get_id_list_by_ship_group_id[0], pg.dorm3d_gift.get_id_list_by_ship_group_id[self.configId] or {})
end

function Apartment:needDownload()
	return #ApartmentRoom.New({
		id = self:getConfig("bind_room")
	}):getDownloadNameList() > 0
end

function Apartment:filterUnlockTalkList(arg_43_1)
	return underscore.filter(arg_43_1, function(arg_44_0)
		return ApartmentProxy.CheckUnlockConfig(pg.dorm3d_dialogue_group[arg_44_0].unlock)
	end)
end

function Apartment:getIconTip(arg_45_1)
	if #self:getForceEnterTalking(arg_45_1) > 0 then
		return "main"
	elseif getProxy(ApartmentProxy):getApartmentGiftCount(self.configId) then
		return "gift"
	elseif Dorm3dFurniture.IsTimelimitShopTip(arg_45_1) then
		return "furniture"
	elseif false then
		return "talk"
	else
		return nil
	end

	return
end

function Apartment:getGroupConfig(arg_46_1)
	if not arg_46_1 or arg_46_1 == "" then
		return nil
	end

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		if iter_46_1[1] == self then
			return iter_46_1[2]
		end
	end

	return nil
end

function Apartment:GetAllModelIds()
	return pg.dorm3d_resource.get_id_list_by_ship_group[self.configId] or {}
end

function Apartment.CheckAllCollectionTrack()
	if not getProxy(ApartmentProxy):CheckAllRoomInviteAll() then
		return
	end

	local var_48_0 = 0
	local var_48_1 = {}

	for iter_48_0, iter_48_1 in ipairs(pg.dorm3d_recall.all) do
		if var_48_1[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id] == nil then
			local var_48_2 = getProxy(ApartmentProxy):getApartment(pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id)

			var_48_2 = var_48_2 or false
			var_48_1[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id] = var_48_2
		end

		if not var_48_1[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id] or not var_48_1[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_48_1].story_id].char_id].talkDic[pg.dorm3d_recall[iter_48_1].story_id] then
			var_48_0 = -1

			break
		else
			var_48_0 = var_48_0 + 1
		end
	end

	if var_48_0 < 0 then
		return
	end

	local var_48_3 = getProxy(ApartmentProxy).shopCount

	for iter_48_2, iter_48_3 in ipairs(pg.dorm3d_shop_template.all) do
		if pg.dorm3d_shop_template[iter_48_3].room_id ~= 0 then
			if pg.dorm3d_shop_template[iter_48_3].type == 2 then
				if defaultValue(var_48_3.permanentGift[pg.dorm3d_shop_template[iter_48_3].item_id], 0) > 0 then
					var_48_0 = var_48_0 + 1
				else
					var_48_0 = -1

					break
				end
			elseif pg.dorm3d_shop_template[iter_48_3].type == 1 then
				if defaultValue(var_48_3.permanentFurniture[pg.dorm3d_shop_template[iter_48_3].item_id], 0) > 0 then
					var_48_0 = var_48_0 + 1
				else
					var_48_0 = -1

					break
				end
			end
		end
	end

	local var_48_4 = getProxy(PlayerProxy):getRawData().id

	if var_48_0 > PlayerPrefs.GetInt("APARTMENT_ALL_COLLECTION:" .. var_48_4, 0) then
		PlayerPrefs.SetInt("APARTMENT_ALL_COLLECTION:" .. var_48_4, var_48_0)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAllCollection(20002, var_48_0))
	end

	return
end

return Apartment
