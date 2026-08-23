local PreciousSuitStruct = require("app.view.module.precious.model.PreciousSuitStruct")
local FriendData = class("FriendData")
local FriendStructData = import(".FriendStructData")
local var_0_3 = g.core.config.knight_association_info
local var_0_4 = g.core.config.pet_equipment_info

function FriendData:ctor()
	self:initData()
end

function FriendData:initData()
	self._sendCache = {}
	self._giftCache = {}
	self._friendList = {}
	self._blackList = {}
	self._requestList = {}
	self._addFriendList = {}
	self._giftList = {}
	self._recommendList = {}
	self._playerInfo = {}
	self._giftNum = 0
	self._friendMap = {}
	self._awards = {}
	self._receivedNum = 0
	self._requestNum = 0
	self._giftedNum = 0
	self._assData = {}
	self._applyCondList = {}
	self._localServerId = nil
	self._friendRoomConnectTime = 0
	self._friendSearchConnectTime = 0
	self._friendListConnectTime = 0
	self._friendRequestListConnectTime = 0
	self._friendRecommendConnectTime = 0
end

function FriendData:GetFriendAssctTotalCount()
	local var_3_0 = 0

	for iter_3_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX do
		var_3_0 = var_3_0 + self:GetActiveAssCountByKnightPos(iter_3_0)
	end

	return var_3_0
end

function FriendData:CheckKnightActive(arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		return true
	end

	if not self._growInfo.knights then
		return false
	end

	local var_4_0 = false

	for iter_4_0 = 1, 6 do
		if self._playerInfo.knights[iter_4_0] and self._playerInfo.knights[iter_4_0].base_id > 0 then
			local var_4_1 = g.core.config.knight_info.get(self._playerInfo.knights[iter_4_0].base_id)

			if var_4_1.quality >= 7 and tostring(var_4_1.advance_id) ~= "200000" and tostring(var_4_1.advance_id) ~= "210000" then
				var_4_0 = true
			end
		end
	end

	for iter_4_1, iter_4_2 in ipairs(self._growInfo.knights) do
		if iter_4_1 > g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_PARTNER_MAX and not var_4_0 then
			return false
		end

		if self._growInfo.knights[iter_4_1].base_id > 0 and arg_4_1 == g.core.config.knight_info.get(iter_4_2.base_id).advance_id then
			return true
		end
	end

	return false
end

function FriendData:CheckEquipActive(arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		return true
	end

	if arg_5_2 == 0 then
		return false
	end

	if not self._playerInfo.equipments then
		return false
	end

	for iter_5_0 = 1, 4 do
		if self._playerInfo.equipments[arg_5_2 * 4 + iter_5_0 - 4] and arg_5_1 == self._playerInfo.equipments[arg_5_2 * 4 + iter_5_0 - 4].base_id then
			return true
		end
	end

	return false
end

function FriendData:CheckTreasureActive(arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		return true
	end

	if arg_6_2 == 0 then
		return false
	end

	if not self._playerInfo.treasures then
		return false
	end

	for iter_6_0 = 1, 2 do
		local var_6_0 = g.core.config.treasure_info.get(self._playerInfo.treasures[arg_6_2 * 2 + iter_6_0 - 2].base_id)

		if var_6_0 and arg_6_1 == var_6_0.advance_id then
			return true
		end
	end

	return false
end

function FriendData:isAssctActive(arg_7_1, arg_7_2)
	if arg_7_1 <= 0 then
		return false
	end

	local var_7_0 = var_0_3.get(arg_7_1)
	local var_7_1 = false

	for iter_7_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.ASS_COND_MAX do
		if var_7_0.type == g.core.const.ConstMgr.KNIGHT_CONST.ASS_TYPE.KNIGHT then
			var_7_1 = self:CheckKnightActive(var_7_0["value_" .. iter_7_0], arg_7_2)
		elseif var_7_0.type == g.core.const.ConstMgr.KNIGHT_CONST.ASS_TYPE.EQUIP then
			var_7_1 = self:CheckEquipActive(var_7_0["value_" .. iter_7_0], arg_7_2)
		elseif var_7_0.type == g.core.const.ConstMgr.KNIGHT_CONST.ASS_TYPE.TREATURE then
			var_7_1 = self:CheckTreasureActive(var_7_0["value_" .. iter_7_0], arg_7_2)
		end

		if not var_7_1 then
			return false
		end
	end

	return var_7_1
end

function FriendData:GetLineUpKnight()
	local var_8_0 = {}

	for iter_8_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX do
		if self._playerInfo.knights[iter_8_0] and self._playerInfo.knights[iter_8_0].base_id > 0 then
			table.insert(var_8_0, self._playerInfo.knights[iter_8_0].base_id)
		else
			table.insert(var_8_0, 0)
		end
	end

	return var_8_0
end

function FriendData:GetBackupFormation()
	local var_9_0 = {}

	for iter_9_0 = 22, g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_BACKUP_MAX do
		if self._growInfo.knights[iter_9_0] and self._growInfo.knights[iter_9_0].base_id > 0 then
			table.insert(var_9_0, {
				pos = iter_9_0,
				base_id = self._growInfo.knights[iter_9_0].base_id,
				level = self._growInfo.knights[iter_9_0].level
			})
		else
			table.insert(var_9_0, {
				level = 0,
				base_id = 0,
				pos = iter_9_0
			})
		end
	end

	return var_9_0
end

function FriendData:GetPartnerFormation()
	local var_10_0 = {}

	for iter_10_0 = 7, g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_PARTNER_MAX do
		if self._growInfo.knights[iter_10_0] and self._growInfo.knights[iter_10_0].base_id > 0 then
			table.insert(var_10_0, {
				pos = iter_10_0,
				base_id = self._growInfo.knights[iter_10_0].base_id
			})
		else
			table.insert(var_10_0, {
				base_id = 0,
				pos = iter_10_0
			})
		end
	end

	return var_10_0
end

function FriendData:GetActiveAssCountByKnightPos(arg_11_1)
	local var_11_0 = 0

	if self._playerInfo.knights[arg_11_1] and self._playerInfo.knights[arg_11_1].base_id > 0 then
		local var_11_1 = g.core.config.knight_info.get(self._playerInfo.knights[arg_11_1].base_id)

		for iter_11_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.ASSCT_MAX do
			if var_11_1["association_" .. iter_11_0] > 0 and self:isAssctActive(var_11_1["association_" .. iter_11_0], arg_11_1) then
				self._assData[var_11_1.id] = var_11_1["association_" .. iter_11_0]
				var_11_0 = var_11_0 + 1
			end
		end
	end

	return var_11_0
end

function FriendData:updateFriendsList(arg_12_1, arg_12_2)
	if arg_12_1 == 1 then
		if arg_12_2.friend then
			self._friendList = {}
			self._giftList = {}

			for iter_12_0, iter_12_1 in pairs(arg_12_2.friend) do
				local var_12_0 = FriendStructData.new(iter_12_1.user.id)

				for iter_12_2, iter_12_3 in pairs(self._friendMap) do
					if iter_12_2 == iter_12_1.user.id then
						var_12_0:setGiftState(iter_12_3.send_gift)
						var_12_0:setReceiveState(iter_12_3.receive_gift)

						break
					end
				end

				var_12_0:setGiftValue(iter_12_1.gift_id)
				var_12_0:setBasicInfo(iter_12_1.user)
				var_12_0:setCharmValue(iter_12_1.charm)
				var_12_0:setCharmSvrRank(iter_12_1.charm_rank)

				if iter_12_1.task_id then
					local var_12_1 = {}

					for iter_12_4, iter_12_5 in pairs(iter_12_1.task_id) do
						var_12_1[iter_12_5] = iter_12_1.task_count[iter_12_4]
					end

					var_12_0:setCompletedTaskList(var_12_1)
				end

				if iter_12_1.gift_id > 0 then
					self._giftList[#self._giftList + 1] = var_12_0
				end

				self._friendList[#self._friendList + 1] = var_12_0
			end
		end
	elseif arg_12_1 == 2 then
		self._blackList = {}

		if arg_12_2.user then
			for iter_12_6, iter_12_7 in pairs(arg_12_2.user) do
				local var_12_2 = FriendStructData.new(iter_12_7.id)

				var_12_2:setBasicInfo(iter_12_7)

				self._blackList[#self._blackList + 1] = var_12_2
			end
		end
	elseif arg_12_1 == 3 then
		self._requestList = {}

		if arg_12_2.user then
			for iter_12_8, iter_12_9 in pairs(arg_12_2.user) do
				local var_12_3 = FriendStructData.new(iter_12_9.id)

				var_12_3:setBasicInfo(iter_12_9)

				self._requestList[#self._requestList + 1] = var_12_3
			end
		end
	elseif arg_12_1 == 5 then
		self._recommendList = {}

		if arg_12_2.user then
			for iter_12_10, iter_12_11 in pairs(arg_12_2.user) do
				local var_12_4 = FriendStructData.new(iter_12_11.id)

				var_12_4:setBasicInfo(iter_12_11)

				if self:canAddToRequestList(var_12_4) then
					self._recommendList[#self._recommendList + 1] = var_12_4
				end
			end
		end

		table.sort(self._recommendList, function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_0:getOfflineTime()
			local var_13_1 = arg_13_1:getOfflineTime()

			if var_13_0 ~= var_13_1 then
				if var_13_0 * var_13_1 == 0 then
					return var_13_0 == 0
				else
					return var_13_1 < var_13_0
				end
			end

			local var_13_2 = arg_13_0:getBasicInfo().level
			local var_13_3 = arg_13_1:getBasicInfo().level

			if var_13_2 ~= var_13_3 then
				return var_13_3 < var_13_2
			end

			local var_13_4 = g.core.platform.ServerListProxy:getSelectedServer()
			local var_13_5 = arg_13_0:getBasicInfo().sid ~= var_13_4.id

			if var_13_5 ~= (arg_13_1:getBasicInfo().sid ~= var_13_4.id) then
				return var_13_5
			end

			return arg_13_0:getFriendId() < arg_13_1:getFriendId()
		end)
	end
end

function FriendData:processingDatasToStructs(arg_14_1)
	local var_14_0 = {}

	if arg_14_1 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			local var_14_1 = FriendStructData.new(iter_14_1.id)

			var_14_1:setBasicInfo(iter_14_1)

			if self:canAddToRequestList(var_14_1) then
				var_14_0[#var_14_0 + 1] = var_14_1
			end
		end
	end

	return var_14_0
end

function FriendData:_updateFriendState(arg_15_1)
	self._friendList = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		local var_15_0 = false

		for iter_15_2, iter_15_3 in pairs(self._friendMap) do
			if iter_15_2 == iter_15_1:getFriendId() then
				iter_15_1:setGiftState(iter_15_3.send_gift)
				iter_15_1:setReceiveState(iter_15_3.receive_gift)

				var_15_0 = true

				break
			end
		end

		if not var_15_0 then
			iter_15_1:setGiftState(false)
			iter_15_1:setReceiveState(false)
		end

		self._friendList[#self._friendList + 1] = iter_15_1
	end
end

function FriendData:updateConfirmList(arg_16_1)
	local var_16_0 = self:getFriendNumMax()

	if arg_16_1.id == 0 then
		for iter_16_0 = table.nums(self._requestList), 1, -1 do
			if arg_16_1.accept then
				local var_16_1 = false

				for iter_16_1, iter_16_2 in ipairs(self._friendList) do
					if iter_16_2:getFriendId() == self._requestList[iter_16_0]:getFriendId() then
						var_16_1 = true

						break
					end
				end

				if not var_16_1 and var_16_0 > #self._friendList and arg_16_1.ret == g.core.network.proto.RET_OK then
					self._friendList[#self._friendList + 1] = self._requestList[iter_16_0]
				end

				for iter_16_3, iter_16_4 in ipairs(arg_16_1.ids or {}) do
					if iter_16_4 == self._requestList[iter_16_0]:getFriendId() then
						table.remove(self._requestList, iter_16_0)

						break
					end
				end
			else
				table.remove(self._requestList, iter_16_0)
			end
		end
	else
		for iter_16_5, iter_16_6 in pairs(self._requestList) do
			if iter_16_6:getFriendId() == arg_16_1.id then
				if arg_16_1.accept then
					local var_16_2 = false

					for iter_16_7, iter_16_8 in ipairs(self._friendList) do
						if iter_16_8:getFriendId() == iter_16_6:getFriendId() then
							var_16_2 = true

							break
						end
					end

					if not var_16_2 and var_16_0 > #self._friendList and arg_16_1.ret == g.core.network.proto.RET_OK then
						self._friendList[#self._friendList + 1] = iter_16_6
					end
				end

				table.remove(self._requestList, iter_16_5)

				break
			end
		end
	end

	self:_updateFriendState(self._friendList)
end

function FriendData:onNotifyAddFriend(arg_17_1)
	for iter_17_0, iter_17_1 in pairs(self._addFriendList) do
		if iter_17_1:getFriendId() == arg_17_1.id then
			local var_17_0 = false

			for iter_17_2, iter_17_3 in ipairs(self._friendList) do
				if iter_17_3:getFriendId() == iter_17_1:getFriendId() then
					var_17_0 = true

					break
				end
			end

			if not var_17_0 then
				self._friendList[#self._friendList + 1] = iter_17_1
			end

			table.remove(self._addFriendList, iter_17_0)

			break
		end
	end

	for iter_17_4, iter_17_5 in pairs(self._requestList) do
		if iter_17_5:getFriendId() == arg_17_1.id then
			table.remove(self._requestList, iter_17_4)

			break
		end
	end

	for iter_17_6, iter_17_7 in ipairs(self._blackList) do
		if iter_17_7:getFriendId() == arg_17_1.id then
			table.remove(self._blackList, iter_17_6)

			break
		end
	end
end

function FriendData:onNotifyTask(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self._friendList) do
		if iter_18_1:getFriendId() == arg_18_1.id or iter_18_1:getFriendId() == arg_18_1.friend_id then
			local var_18_0 = iter_18_1:getCompletedTasks()

			var_18_0[arg_18_1.task_id] = var_18_0[arg_18_1.task_id] and var_18_0[arg_18_1.task_id] + 1 or 1

			iter_18_1:setCompletedTaskList(var_18_0)

			break
		end
	end
end

function FriendData:onNotifyTaskAll(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		self:onNotifyTask(iter_19_1)
	end
end

function FriendData:onNotifyGift(arg_20_1)
	for iter_20_0, iter_20_1 in pairs(self._friendList) do
		if iter_20_1:getFriendId() == arg_20_1.id then
			local var_20_0 = false

			for iter_20_2, iter_20_3 in ipairs(self._giftList) do
				if iter_20_3:getFriendId() == arg_20_1.id then
					var_20_0 = true

					break
				end
			end

			if not var_20_0 then
				iter_20_1:setGiftValue(arg_20_1.gift_id)

				self._giftList[#self._giftList + 1] = iter_20_1
			end

			break
		end
	end
end

function FriendData:onNotifyAddFriendRequest(arg_21_1)
	local var_21_0 = false

	for iter_21_0, iter_21_1 in pairs(self._requestList) do
		if iter_21_1:getFriendId() == arg_21_1.id then
			var_21_0 = true

			break
		end
	end

	if not var_21_0 then
		local var_21_1 = FriendStructData.new(arg_21_1.id)

		var_21_1:setBasicInfo(arg_21_1.user)

		self._requestList[#self._requestList + 1] = var_21_1
	end
end

function FriendData:onNotifyDelFriend(arg_22_1)
	for iter_22_0, iter_22_1 in pairs(self._friendList) do
		if iter_22_1:getFriendId() == arg_22_1.id then
			table.remove(self._friendList, iter_22_0)

			break
		end
	end

	for iter_22_2, iter_22_3 in pairs(self._giftList) do
		if iter_22_3:getFriendId() == arg_22_1.id then
			table.remove(self._giftList, iter_22_2)

			break
		end
	end
end

function FriendData:onSendGiftSuc(arg_23_1)
	if arg_23_1.id == 0 then
		for iter_23_0, iter_23_1 in pairs(self._friendList) do
			iter_23_1:setGiftState(true)

			local var_23_0 = iter_23_1:getFriendId()
			local var_23_1 = self._friendMap[var_23_0]

			if not self._friendMap[var_23_0] then
				var_23_1 = {
					receive_gift = iter_23_1:isReceived()
				}

				if var_23_1.receive_gift then
					self._receivedNum = self._receivedNum + 1
				end

				self._friendMap[var_23_0] = var_23_1
			end

			var_23_1.send_gift = true
		end
	else
		for iter_23_2, iter_23_3 in pairs(self._friendList) do
			if iter_23_3:getFriendId() == arg_23_1.id then
				iter_23_3:setGiftState(true)

				local var_23_2 = iter_23_3:getFriendId()
				local var_23_3 = self._friendMap[var_23_2]

				if not self._friendMap[var_23_2] then
					var_23_3 = {
						receive_gift = iter_23_3:isReceived()
					}

					if var_23_3.receive_gift then
						self._receivedNum = self._receivedNum + 1
					end

					self._friendMap[var_23_2] = var_23_3
				end

				var_23_3.send_gift = true

				break
			end
		end
	end
end

function FriendData:onReceiveGiftSuc(arg_24_1)
	if arg_24_1.id then
		for iter_24_0, iter_24_1 in pairs(self._friendList) do
			for iter_24_2, iter_24_3 in pairs(arg_24_1.id) do
				if iter_24_1:getFriendId() == iter_24_3 then
					iter_24_1:setGiftValue(0)
					iter_24_1:setReceiveState(true)

					self._giftedNum = self._giftedNum + 1
					self._receivedNum = self._receivedNum + 1

					break
				end
			end
		end

		for iter_24_4 = table.nums(self._giftList), 1, -1 do
			for iter_24_5, iter_24_6 in pairs(arg_24_1.id) do
				if self._giftList[iter_24_4]:getFriendId() == iter_24_6 then
					table.remove(self._giftList, iter_24_4)

					break
				end
			end
		end
	end
end

function FriendData:GetGrowthInfo()
	return self._growInfo or {}
end

function FriendData:GetStrengthScore(arg_26_1, arg_26_2)
	local var_26_0 = g.core.config.unite_token_info.get(arg_26_1)
	local var_26_1 = 0
	local var_26_2 = g.core.config.unite_token_upgrade_info.get(var_26_0.upgrade_code, arg_26_2)

	for iter_26_0 = 1, 4 do
		if var_26_2["upgrade_type_" .. iter_26_0] > 0 then
			var_26_1 = var_26_1 + var_26_2["upgrade_value_" .. iter_26_0] * g.core.common.Attribute:getFightValueWeight(var_26_2["upgrade_type_" .. iter_26_0]) / 1000
		end
	end

	for iter_26_1 = 1, arg_26_2 do
		local var_26_3 = g.core.config.unite_token_upgrade_info.get(var_26_0.upgrade_code, iter_26_1)

		if var_26_3.talent > 0 then
			local var_26_4 = g.core.config.talent_skill_info.get(var_26_3.talent)

			for iter_26_2 = 1, 3 do
				if var_26_4["affect_type_" .. iter_26_2] > 0 then
					var_26_1 = var_26_1 + var_26_4["affect_value_" .. iter_26_2] * g.core.common.Attribute:getFightValueWeight(var_26_4["affect_type_" .. iter_26_2]) / 1000
				end
			end
		end
	end

	return math.floor(var_26_1 + 0.5)
end

function FriendData:GetUniteInfo(arg_27_1)
	if not arg_27_1 then
		return 0, 0, 0
	end

	if not next(arg_27_1) then
		return 0, 0, 0
	end

	return 0, 0, 0
end

function FriendData:GetGroup()
	local var_28_0 = {}

	for iter_28_0 = 1, 4 do
		local var_28_1 = 0

		for iter_28_1, iter_28_2 in ipairs(self._playerInfo.knights) do
			local var_28_2 = g.core.config.knight_info.get(iter_28_2.base_id)

			if var_28_2.quality >= 6 and var_28_2.advance_id ~= 200000 and var_28_2.advance_id ~= 210000 and iter_28_0 == var_28_2.group then
				var_28_1 = var_28_1 + 1
			end
		end

		var_28_0[iter_28_0] = var_28_1
	end

	return var_28_0
end

function FriendData:GetHookCountAndNum(arg_29_1)
	if next(arg_29_1) == nil then
		return 0, 0
	end

	local var_29_0 = 0
	local var_29_1 = 0

	for iter_29_0, iter_29_1 in pairs(arg_29_1) do
		for iter_29_2 = 1, g.core.config.knight_book_info.getLength() do
			local var_29_2 = g.core.config.knight_book_info.indexOf(iter_29_2)

			if tostring(var_29_2.level) == tostring(iter_29_1.level) and tostring(var_29_2.advance_id) == tostring(iter_29_1.id) then
				var_29_1 = var_29_1 + var_29_2.score
			end
		end

		var_29_0 = var_29_0 + 1
	end

	return var_29_0, var_29_1
end

function FriendData:GetBioChapterId(arg_30_1)
	if arg_30_1 <= 0 then
		return 0
	end

	local var_30_0 = g.core.config.scroll_main_growth_info.get(arg_30_1)

	if var_30_0 == nil or var_30_0.tab_type == 1 then
		return 0
	end

	return var_30_0.chapter_id
end

function FriendData:GetMainChapterId(arg_31_1)
	if arg_31_1 <= 0 then
		return 0
	end

	local var_31_0 = g.core.config.scroll_main_growth_info.get(arg_31_1)

	if var_31_0 == nil or var_31_0.tab_type == 2 then
		return 0
	end

	return var_31_0.chapter_id
end

function FriendData:onUserDetailInfoBack(arg_32_1)
	if arg_32_1.grow then
		self._growInfo = arg_32_1.grow

		if arg_32_1.grow.unite_tokens then
			self._growInfo.unite_num, self._growInfo.unite_awaken_num, self._growInfo.unite_score = self:GetUniteInfo(arg_32_1.grow.unite_tokens)
		else
			self._growInfo.unite_num = 0
			self._growInfo.unite_awaken_num = 0
			self._growInfo.unite_score = 0
		end

		if arg_32_1.grow.knight_handbook then
			self._growInfo.knight_handbook_num, self._growInfo.knight_handbook_value = self:GetHookCountAndNum(arg_32_1.grow.knight_handbook)
		else
			self._growInfo.knight_handbook_num = 0
			self._growInfo.knight_handbook_value = 0
		end

		self._growInfo.scroll_bio_max = arg_32_1.grow.scroll_bio_max and self:GetBioChapterId(arg_32_1.grow.scroll_bio_max) or 0
		self._growInfo.scroll_dungeon_max = arg_32_1.grow.scroll_dungeon_max and self:GetMainChapterId(arg_32_1.grow.scroll_dungeon_max) or 0
		self._growInfo.scroll_nightmare_num = self._growInfo.scroll_nightmare_num or 0
		self._growInfo.title_num = arg_32_1.grow.title_num or 0
		self._growInfo.dress_num = arg_32_1.grow.dress_num or 0
		self._growInfo.skin_num = arg_32_1.grow.skin_num or 0
		self._growInfo.dress_handbook_num = arg_32_1.grow.dress_handbook_num or 0
		self._growInfo.skin_handbook_num = arg_32_1.grow.skin_handbook_num or 0
		self._growInfo.card_num = arg_32_1.grow.card_num or 0
		self._growInfo.knights = arg_32_1.grow.knights or {}
	end

	if arg_32_1.player then
		self._playerInfo = clone(arg_32_1.player)

		for iter_32_0, iter_32_1 in pairs(self._friendList) do
			if iter_32_1:getFriendId() == arg_32_1.player.user.id then
				iter_32_1:setBasicInfo(arg_32_1.player.user)

				self._playerInfo.isFriend = true
			end
		end

		for iter_32_2, iter_32_3 in pairs(self._blackList) do
			if iter_32_3:getFriendId() == arg_32_1.player.user.id then
				iter_32_3:setBasicInfo(arg_32_1.player.user)

				self._playerInfo.isBlack = true
			end
		end

		self._playerInfo.formationData = {}
		self._playerInfo.formationData.knights = self._playerInfo.user.knights

		local var_32_0 = {}
		local var_32_1 = {}

		for iter_32_4, iter_32_5 in pairs(self._playerInfo.formation.position) do
			local var_32_2 = self._playerInfo.formation.knight_id[iter_32_5] or 0

			if var_32_2 > 0 then
				for iter_32_6, iter_32_7 in pairs(self._playerInfo.knights) do
					if iter_32_7.id == var_32_2 then
						local var_32_3 = g.core.config.knight_info.get(iter_32_7.base_id)
						local var_32_4 = require("app.view.module.knight.model.KnightStruct").new(var_32_3.advance_id)

						var_32_4:addCfgInfo(var_32_3)
						var_32_4:setInfo(iter_32_7)
						var_32_4:setIsOtherUser(true, self._playerInfo.user.name)

						var_32_0[iter_32_4] = var_32_4
						var_32_1[iter_32_7.id] = var_32_4

						break
					end
				end
			end
		end

		self._playerInfo.formationData.knightStructArr = var_32_0
		self._playerInfo.knightIdDict = var_32_1

		local var_32_5 = {}

		if self._playerInfo.equipments then
			local var_32_6 = {}

			for iter_32_8, iter_32_9 in pairs(self._playerInfo.equipments) do
				var_32_6[iter_32_9.position] = iter_32_9

				local var_32_7 = math.ceil(iter_32_9.position / 4)

				var_32_5[var_32_7] = var_32_5[var_32_7] or {}
				var_32_5[var_32_7][g.core.common.Goods.TYPE_EQUIP] = var_32_5[var_32_7][g.core.common.Goods.TYPE_EQUIP] or {}
				var_32_5[var_32_7][g.core.common.Goods.TYPE_EQUIP][iter_32_9.base_id] = iter_32_9
			end

			self._playerInfo.formationData.equipments = var_32_6
		end

		if self._playerInfo.treasures then
			local var_32_8 = {}

			for iter_32_10, iter_32_11 in pairs(self._playerInfo.treasures) do
				var_32_8[iter_32_11.position] = iter_32_11

				local var_32_9 = math.ceil(iter_32_11.position / 2)

				var_32_5[var_32_9] = var_32_5[var_32_9] or {}
				var_32_5[var_32_9][g.core.common.Goods.TYPE_TREASURE] = var_32_5[var_32_9][g.core.common.Goods.TYPE_TREASURE] or {}
				var_32_5[var_32_9][g.core.common.Goods.TYPE_TREASURE][iter_32_11.base_id] = iter_32_11
			end

			self._playerInfo.formationData.treasures = var_32_8
		end

		local var_32_10 = {}

		if self._playerInfo.unite_tokens then
			for iter_32_12, iter_32_13 in pairs(self._playerInfo.unite_tokens) do
				local var_32_11 = require("app.view.module.uniteToken.model.UniteTokenStructData").new(iter_32_13.base_id)

				var_32_11:updateByNetData(iter_32_13)

				var_32_10[iter_32_12] = var_32_11
			end
		end

		self._playerInfo.formationData.unitTokenData = var_32_10

		if self._playerInfo.artifacts then
			local var_32_12 = {}

			for iter_32_14, iter_32_15 in pairs(self._playerInfo.artifacts) do
				local var_32_13 = require("app.view.module.artifact.model.ArtifactStruct").new(iter_32_15.base_id)

				var_32_13:setServerData(iter_32_15)

				var_32_12[iter_32_15.pos] = var_32_13
				var_32_5[iter_32_15.pos] = var_32_5[iter_32_15.pos] or {}
				var_32_5[iter_32_15.pos][g.core.common.Goods.TYPE_ARTIFACT] = var_32_5[iter_32_15.pos][g.core.common.Goods.TYPE_ARTIFACT] or {}
				var_32_5[iter_32_15.pos][g.core.common.Goods.TYPE_ARTIFACT][iter_32_15.base_id] = iter_32_15
			end

			self._playerInfo.formationData.artifacts = var_32_12
		end

		local var_32_14 = {}
		local var_32_15 = {}

		for iter_32_16, iter_32_17 in ipairs(self._playerInfo.formationData.knights) do
			if iter_32_17 > 0 then
				local var_32_16 = g.core.config.knight_info.get(iter_32_17)
				local var_32_17 = require("app.view.module.knight.model.KnightStruct").new(var_32_16.advance_id)

				var_32_17:addCfgInfo(var_32_16)

				if iter_32_16 > 6 then
					var_32_15[iter_32_16] = var_32_17
				end

				var_32_14[var_32_16.advance_id] = true
			end
		end

		self._playerInfo.formationData.otherKnightStructTab = var_32_15

		for iter_32_18, iter_32_19 in pairs(self._playerInfo.formationData.knightStructArr) do
			var_32_5[iter_32_18] = var_32_5[iter_32_18] or {}
			var_32_5[iter_32_18][g.core.common.Goods.TYPE_KNIGHT] = clone(var_32_14)
		end

		local var_32_18 = {}

		for iter_32_20, iter_32_21 in ipairs(self._playerInfo.pets or {}) do
			local var_32_19 = require("app.view.module.pet.model.PetStruct").new(g.core.config.pet_info.get(iter_32_21.base_id).advance_id)

			var_32_19:setServerData(iter_32_21)
			table.insert(var_32_18, var_32_19)
		end

		self._playerInfo.formationData.pets = var_32_18

		local var_32_20 = {}

		for iter_32_22, iter_32_23 in ipairs(self._playerInfo.precious_suits or {}) do
			local var_32_21 = PreciousSuitStruct.new()

			var_32_21:setServerData(iter_32_23)

			var_32_20[var_32_21:getSuitGroup()] = var_32_21
		end

		local var_32_22 = {}

		for iter_32_24, iter_32_25 in ipairs(self._playerInfo.formation.precious_suits or {}) do
			var_32_22[iter_32_24] = var_32_20[iter_32_25]
		end

		self._playerInfo.formationData.preciousSuit = var_32_22

		local var_32_23 = {}

		for iter_32_26, iter_32_27 in ipairs(self._playerInfo.succubas or {}) do
			local var_32_24 = require("app.view.module.succuba.model.SuccubaStruct").new({
				id = iter_32_27.base_id
			})

			var_32_24:updateSvrInfo(iter_32_27)

			var_32_23[var_32_24:getPosition()] = var_32_24
		end

		self._playerInfo.formationData.succubaList = var_32_23
		self._playerInfo.formationData.matchInfos = var_32_5
		self._playerInfo.formationData.totalAssct = g.core.model.User.formationData:getTotalAssCount(self._playerInfo.formationData.knightStructArr, var_32_5)
		self._playerInfo.formationData.groupInfo = g.core.model.User.formationData:getGroupInfo(self._playerInfo.formationData.knightStructArr)
	end
end

function FriendData:GetGoldLineUpKnight()
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(self._playerInfo.knights) do
		local var_33_1 = g.core.config.knight_info.get(iter_33_1.base_id)

		if var_33_1.quality >= 7 and tostring(var_33_1.advance_id) ~= "200000" and tostring(var_33_1.advance_id) ~= "210000" then
			var_33_0 = var_33_0 + 1
		end
	end

	return var_33_0
end

function FriendData:GetUser()
	if self._playerInfo.user then
		return self._playerInfo.user
	end

	return {}
end

function FriendData:updateFriendsInfo(arg_35_1)
	if arg_35_1 then
		self._giftedNum = arg_35_1.receive_gift_count
		self._friendMap = {}
		self._receivedNum = 0

		if arg_35_1.friend_id then
			for iter_35_0, iter_35_1 in pairs(arg_35_1.friend_id) do
				local var_35_0 = {
					send_gift = arg_35_1.send_gift[iter_35_0],
					receive_gift = arg_35_1.receive_gift[iter_35_0]
				}

				if var_35_0.receive_gift then
					self._receivedNum = self._receivedNum + 1
				end

				self._friendMap[iter_35_1] = var_35_0
			end
		end

		self:_updateFriendState(self._friendList)
	end
end

function FriendData:onDelFriendSuc(arg_36_1)
	for iter_36_0, iter_36_1 in pairs(self._friendList) do
		if iter_36_1:getFriendId() == arg_36_1.id then
			table.remove(self._friendList, iter_36_0)

			break
		end
	end

	for iter_36_2, iter_36_3 in pairs(self._giftList) do
		if iter_36_3:getFriendId() == arg_36_1.id then
			table.remove(self._giftList, iter_36_2)

			break
		end
	end
end

function FriendData:onAddBlackSuc(arg_37_1)
	for iter_37_0, iter_37_1 in pairs(self._friendList) do
		if iter_37_1:getFriendId() == arg_37_1.id then
			self._blackList[#self._blackList + 1] = iter_37_1

			table.remove(self._friendList, iter_37_0)

			break
		end
	end

	for iter_37_2, iter_37_3 in pairs(self._requestList) do
		if iter_37_3:getFriendId() == arg_37_1.id then
			self._blackList[#self._blackList + 1] = iter_37_3

			table.remove(self._requestList, iter_37_2)

			break
		end
	end

	for iter_37_4, iter_37_5 in pairs(self._giftList) do
		if iter_37_5:getFriendId() == arg_37_1.id then
			self._blackList[#self._blackList + 1] = iter_37_5

			table.remove(self._giftList, iter_37_4)

			break
		end
	end

	g.core.network.GameNetProxy:send_C2S_Friend_BlackList({})
end

function FriendData:onDelBlackSuc(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(self._blackList) do
		if iter_38_1:getFriendId() == arg_38_1.id then
			table.remove(self._blackList, iter_38_0)

			break
		end
	end
end

function FriendData:notifyAddFriendBySelf(arg_39_1)
	local var_39_0 = false

	for iter_39_0, iter_39_1 in pairs(self._addFriendList) do
		if iter_39_1:getFriendId() == arg_39_1.id then
			var_39_0 = true
		end
	end

	if not var_39_0 then
		local var_39_1 = FriendStructData.new(arg_39_1.id)

		var_39_1:setBasicInfo(arg_39_1)

		self._addFriendList[#self._addFriendList + 1] = var_39_1
	end
end

function FriendData:getFriendIntimate(arg_40_1)
	return nil, nil
end

function FriendData:getCurTabList(arg_41_1)
	return arg_41_1 == 0 and self._friendList or arg_41_1 == 1 and self._blackList or arg_41_1 == 2 and self._requestList or self._giftList
end

function FriendData:getFriendInfoById(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(self._friendList) do
		if iter_42_1:getFriendId() == arg_42_1 then
			return iter_42_1
		end
	end
end

function FriendData:getFriendInfoByName(arg_43_1)
	for iter_43_0, iter_43_1 in pairs(self._friendList) do
		if iter_43_1:getFriendName() == arg_43_1 then
			return iter_43_1
		end
	end
end

function FriendData:_checkCurTimeInRange(arg_44_1, arg_44_2)
	local var_44_0 = g.core.common.ServerTime:secondsFromToday() / 3600

	return arg_44_1 <= var_44_0 and var_44_0 <= arg_44_2
end

function FriendData:getLeftGiftNum()
	local var_45_0 = 0

	if (self:getGiftedNum() or 0) >= g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_GIFT_LIMIT).parameter then
		return var_45_0
	end

	for iter_45_0, iter_45_1 in ipairs(self._friendList) do
		if iter_45_1:isCanReceived() then
			var_45_0 = var_45_0 + 1
		end
	end

	return var_45_0
end

function FriendData:getFriendRedpoint()
	return self:isHasRequestNum() or self:isCanRecvGiftOrGiven()
end

function FriendData:isHasRequestNum()
	return self:getRequestNum() > 0
end

function FriendData:isCanRecvGiftOrGiven()
	local var_48_0 = 0
	local var_48_1 = (self:getGiftedNum() or 0) < g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_GIFT_LIMIT).parameter
	local var_48_2 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_STAMINA) == 1000

	for iter_48_0, iter_48_1 in ipairs(self._friendList) do
		if iter_48_1:isCanReceived() and var_48_1 and not var_48_2 or not iter_48_1:isGifted() then
			var_48_0 = var_48_0 + 1
		end
	end

	return 1 <= var_48_0
end

function FriendData:getRequestNum()
	self._requestNum = 0

	for iter_49_0, iter_49_1 in pairs(self._requestList) do
		self._requestNum = self._requestNum + 1
	end

	return self._requestNum
end

function FriendData:getGiftNum()
	self._giftNum = 0

	if g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_GIFT_LIMIT).parameter - self:getGiftedNum() > 0 then
		for iter_50_0, iter_50_1 in pairs(self._giftList) do
			self._giftNum = self._giftNum + 1
		end
	end

	return self._giftNum
end

function FriendData:getFriendNumMax()
	return g.core.config.role_info.get((g.core.model.User:getLevel())).friend_limit
end

function FriendData:getPetEquipsByPetIndex(arg_52_1)
	local var_52_0 = {}

	if self._playerInfo then
		for iter_52_0 = 1, 3 do
			table.insert(var_52_0, self._playerInfo.formation.pet_equipment_id[(arg_52_1 - 1) * 3 + iter_52_0])
		end
	end

	return var_52_0
end

function FriendData:getPetEquipByID(arg_53_1)
	for iter_53_0, iter_53_1 in ipairs(self._playerInfo.petEquipments or {}) do
		if arg_53_1 == iter_53_1.id then
			return {
				cfgInfo = var_0_4.get(iter_53_1.base_id),
				serverData = iter_53_1
			}
		end
	end
end

function FriendData:updateApplyCondList(arg_54_1)
	self._applyCondList = {}

	table.insert(self._applyCondList, {
		condType = arg_54_1.cond_type,
		value = arg_54_1.value
	})
end

function FriendData:getApplyCondList()
	return self._applyCondList
end

function FriendData:isInFriendList(arg_56_1)
	for iter_56_0, iter_56_1 in ipairs(self._friendList) do
		if iter_56_1:getFriendId() == arg_56_1 then
			return true
		end
	end

	return false
end

function FriendData:isInAddFriendList(arg_57_1)
	local var_57_0 = false

	for iter_57_0, iter_57_1 in pairs(self._addFriendList) do
		if iter_57_1:getFriendId() == arg_57_1 then
			var_57_0 = true
		end
	end

	return var_57_0
end

function FriendData:isCrossServerFriend(arg_58_1)
	if self._localServerId == nil then
		self._localServerId = g.core.platform.ServerListProxy:getSelectedServer().id
	end

	return arg_58_1 ~= self._localServerId
end

function FriendData:canAddToRequestList(arg_59_1)
	local var_59_0 = arg_59_1:getBasicInfo()

	return (var_59_0.sid ~= g.core.platform.ServerListProxy:getSelectedServer().id or nil) and g.core.common.ModuleUnlock:isFunctionUnlockByUserInfo(var_59_0, g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND)
end

function FriendData:setFriendRoomConnectTime(arg_60_1)
	self._friendRoomConnectTime = arg_60_1
end

function FriendData:getFriendRoomConnectTime()
	return self._friendRoomConnectTime
end

function FriendData:setFriendSearchConnectTime(arg_62_1)
	self._friendSearchConnectTime = arg_62_1
end

function FriendData:getFriendSearchConnectTime()
	return self._friendSearchConnectTime
end

function FriendData:setFriendRequestListConnectTime(arg_64_1)
	self._friendRequestListConnectTime = arg_64_1
end

function FriendData:getFriendRequestListConnectTime()
	return self._friendRequestListConnectTime
end

function FriendData:setFriendListConnectTime(arg_66_1)
	self._friendListConnectTime = arg_66_1
end

function FriendData:getFriendListConnectTime()
	return self._friendListConnectTime
end

function FriendData:setFriendRecommendConnectTime(arg_68_1)
	self._friendRecommendConnectTime = arg_68_1
end

function FriendData:getFriendRecommendConnectTime()
	return self._friendRecommendConnectTime
end

function FriendData:getRecommendList()
	return self._recommendList
end

function FriendData:getFriendList()
	return self._friendList
end

function FriendData:getRequestList()
	return self._requestList
end

function FriendData:getPlayerInfo()
	return self._playerInfo
end

function FriendData:getGiftList()
	return self._giftList
end

function FriendData:getBlackList()
	return self._blackList
end

function FriendData:getGiftedNum()
	return self._giftedNum
end

function FriendData:getReceivedReward()
	return self._awards
end

function FriendData:getReceivedNum()
	return self._receivedNum
end

return FriendData
