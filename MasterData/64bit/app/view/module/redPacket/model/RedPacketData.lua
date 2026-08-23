local var_0_0 = g.core.config.redpacket_info
local RedPacketData = class("RedPacketData")

function RedPacketData:ctor()
	self:initData()
end

function RedPacketData:initData()
	self._playerList = {}
	self._systemList = {}
	self._pickTime = {}
	self._systemPosition = {}
	self._detailList = {}
	self._awards = {}
	self._useTime = 0
	self._useList = {}
	self._wealth = 0
	self._lucky = 0
	self._allList = {}
	self._ownList = {}
	self._playerDetails = {}
	self._playerPos = nil
	self._isResponse = false
	self._canRec = false
end

function RedPacketData:resetPlayerListOrder()
	self._playerPos = nil
end

function RedPacketData:updateInfo(arg_4_1)
	self._isResponse = true
	self._useTime = arg_4_1.use_time
	self._wealth = arg_4_1.point
	self._lucky = arg_4_1.luck
	self._systemPosition = arg_4_1.guild_pick_time or {}
	self._pickTime = arg_4_1.pick_time

	if arg_4_1.rp then
		self._allList = arg_4_1.rp
	end

	self:_initList()
end

function RedPacketData:updatePacketDetail(arg_5_1)
	self._detailList = {}
	self._detailList.id = arg_5_1.id

	if arg_5_1.rp then
		for iter_5_0, iter_5_1 in pairs(self._allList) do
			if iter_5_1.id == arg_5_1.rp.id then
				self._allList[iter_5_0] = arg_5_1.rp
			end
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_1.pick or {}) do
		table.insert(self._detailList, {
			pick = iter_5_3,
			distribute = arg_5_1.distribute[iter_5_2],
			lucky = arg_5_1.lucky[iter_5_2]
		})
	end
end

function RedPacketData:onPickSuc(arg_6_1)
	self._lucky = arg_6_1.luck
	self._systemPosition = arg_6_1.guild_pick_time or {}
	self._pickTime = arg_6_1.pick_time

	if arg_6_1.awards then
		self._awards = arg_6_1.awards
	end

	for iter_6_0, iter_6_1 in pairs(self._allList) do
		if iter_6_1.id == arg_6_1.id then
			self._allList[iter_6_0].picked = true
		end
	end

	self:_initList()
end

function RedPacketData:onUseRedPacket(arg_7_1)
	self._wealth = arg_7_1.point
	self._useTime = arg_7_1.use_time
end

function RedPacketData:updatePickTimes(arg_8_1)
	self._pickTime[1] = arg_8_1 or 0
end

function RedPacketData:onS2CFlushRedPoint(arg_9_1)
	if not arg_9_1.guild_hint then
		return
	end

	self._canRec = checkbool(arg_9_1.guild_hint.has_red_packet)

	self:updatePickTimes(arg_9_1.guild_hint.gold_redpacket_left_time)
end

function RedPacketData:onFlushRedPacket(arg_10_1)
	if arg_10_1.rp then
		table.insert(self._playerList, arg_10_1.rp)
		table.insert(self._allList, arg_10_1.rp)
		self:_sortList(self._allList)

		if self._playerPos == nil then
			self:_sortList(self._playerList)
		else
			local var_10_0 = {}
			local var_10_1 = {}

			for iter_10_0, iter_10_1 in ipairs(self._playerList) do
				if self._playerPos[iter_10_1.id] then
					var_10_0[self._playerPos[iter_10_1.id]] = iter_10_1
				else
					var_10_1[#var_10_1 + 1] = iter_10_1
				end
			end

			for iter_10_2, iter_10_3 in ipairs(var_10_1) do
				var_10_0[#var_10_0 + 1] = iter_10_3
			end

			self._playerList = var_10_0
		end

		self._playerPos = {}

		for iter_10_4, iter_10_5 in ipairs(self._playerList) do
			self._playerPos[iter_10_5.id] = iter_10_4
		end

		self:_freshDetailList()
	end
end

function RedPacketData:initUseList(arg_11_1)
	self._useList = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		if g.core.config.redpacket_info.get(iter_11_1.id).target == 1 then
			table.insert(self._useList, {
				num = iter_11_1.num,
				base_id = iter_11_1.id
			})
		end
	end

	self._ownList = self:_splitUseList(self._useList)
end

function RedPacketData:insertUseList(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		if g.core.config.redpacket_info.get(iter_12_1.id).target == 1 then
			table.insert(self._useList, {
				num = iter_12_1.num,
				base_id = iter_12_1.id
			})
		end
	end

	self._ownList = self:_splitUseList(self._useList)
end

function RedPacketData:delUseList(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self._useList) do
		if iter_13_1.base_id == arg_13_1[1] then
			table.remove(self._useList, iter_13_0)
		end
	end

	self._ownList = self:_splitUseList(self._useList)
end

function RedPacketData:updateUseList(arg_14_1)
	for iter_14_0, iter_14_1 in pairs(self._useList) do
		for iter_14_2, iter_14_3 in pairs(arg_14_1) do
			if iter_14_1.base_id == iter_14_3.id then
				iter_14_1.num = iter_14_3.num
				self._useList[iter_14_0] = iter_14_1
			end
		end
	end

	self._ownList = self:_splitUseList(self._useList)
end

function RedPacketData:getRedPacketInfo(arg_15_1)
	local var_15_0 = {}

	for iter_15_0 = 1, g.core.config.redpacket_info.getLength() do
		local var_15_1 = g.core.config.redpacket_info.indexOf(iter_15_0)

		if var_15_1.target == arg_15_1 then
			table.insert(var_15_0, var_15_1)
		end
	end

	return var_15_0
end

function RedPacketData:_initSystemList()
	local var_16_0 = g.core.config.redpacket_gm_info.getLength()
	local var_16_1 = g.core.model.User.guildData:getGuildLevel()
	local var_16_2 = {}

	for iter_16_0 = 1, var_16_0 do
		local var_16_3 = g.core.config.redpacket_gm_info.indexOf(iter_16_0)

		if not var_16_2[var_16_3.position] then
			var_16_2[var_16_3.position] = {}

			table.insert(var_16_2[var_16_3.position], var_16_3)
		else
			table.insert(var_16_2[var_16_3.position], var_16_3)
		end
	end

	local var_16_4 = g.core.config.redpacket_info.getLength()

	for iter_16_1, iter_16_2 in pairs(self._systemList) do
		for iter_16_3 = 1, var_16_0 do
			local var_16_5 = g.core.config.redpacket_gm_info.indexOf(iter_16_3)

			if var_16_5.red_id == iter_16_2.base_id then
				iter_16_2.position = var_16_5.position
				var_16_2[iter_16_2.position] = {}

				break
			end
		end
	end

	local var_16_6 = {}

	for iter_16_4, iter_16_5 in pairs(var_16_2) do
		if next(iter_16_5) then
			table.insert(var_16_6, iter_16_5)
		end
	end

	local function var_16_7(arg_17_0, arg_17_1)
		return arg_17_0.open_type_value < arg_17_1.open_type_value
	end

	for iter_16_6, iter_16_7 in pairs(var_16_6) do
		table.sort(iter_16_7, var_16_7)

		local var_16_8

		if iter_16_7[1] then
			var_16_8 = {
				base_id = iter_16_7[1].red_id,
				id = iter_16_7[1].position,
				lockLv = iter_16_7[1].open_type_value,
				position = iter_16_7[1].position
			}

			for iter_16_8, iter_16_9 in pairs(iter_16_7) do
				if var_16_1 >= iter_16_9.open_type_value and var_16_8.lockLv < iter_16_9.open_type_value then
					var_16_8.base_id = iter_16_9.red_id
					var_16_8.id = iter_16_9.position
					var_16_8.lockLv = iter_16_9.open_type_value
					var_16_8.position = iter_16_9.position
				end
			end
		end

		if var_16_8 then
			table.insert(self._systemList, var_16_8)
		end
	end

	table.sort(self._systemList, function(arg_18_0, arg_18_1)
		if arg_18_0.position and arg_18_1.position then
			return arg_18_0.position < arg_18_1.position
		end
	end)
end

function RedPacketData:_splitUseList(arg_19_1)
	self._ownList = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_1) do
		for iter_19_2 = 1, iter_19_1.num do
			table.insert(self._ownList, {
				base_id = iter_19_1.base_id
			})
		end
	end

	return self._ownList
end

function RedPacketData:_initList()
	self._playerList = {}
	self._systemList = {}

	self:_sortList(self._allList)

	for iter_20_0, iter_20_1 in pairs(self._allList) do
		local var_20_0 = g.core.config.redpacket_info.get(iter_20_1.base_id)

		if var_20_0.target == 1 then
			table.insert(self._playerList, iter_20_1)
		elseif var_20_0.target == 2 then
			table.insert(self._systemList, iter_20_1)
		end
	end

	if self._playerPos == nil then
		self:_sortList(self._playerList)
	else
		local var_20_1 = {}
		local var_20_2 = {}

		for iter_20_2, iter_20_3 in ipairs(self._playerList) do
			if self._playerPos[iter_20_3.id] then
				var_20_1[self._playerPos[iter_20_3.id]] = iter_20_3
			else
				var_20_2[#var_20_2 + 1] = iter_20_3
			end
		end

		for iter_20_4, iter_20_5 in ipairs(var_20_2) do
			var_20_1[#var_20_1 + 1] = iter_20_5
		end

		self._playerList = var_20_1
	end

	self._playerPos = {}

	for iter_20_6, iter_20_7 in ipairs(self._playerList) do
		self._playerPos[iter_20_7.id] = iter_20_6
	end

	self:_initSystemList()
	self:_freshDetailList()
end

function RedPacketData:_sortList(arg_21_1)
	local var_21_0 = g.core.config.redpacket_info

	table.sort(arg_21_1 or {}, function(arg_22_0, arg_22_1)
		if arg_22_0.picked ~= arg_22_1.picked then
			return arg_22_1.picked
		end

		if not arg_22_0.picked then
			local var_22_0 = arg_22_0.pick_size < var_21_0.get(arg_22_0.base_id).limit_people

			if var_22_0 ~= (arg_22_1.pick_size < var_21_0.get(arg_22_1.base_id).limit_people) then
				return var_22_0
			end
		end

		if arg_22_0.due_time ~= arg_22_1.due_time then
			return arg_22_0.due_time < arg_22_1.due_time
		end

		return false
	end)

	return arg_21_1
end

function RedPacketData:removeRedPacket(arg_23_1)
	for iter_23_0, iter_23_1 in pairs(self._allList) do
		if iter_23_1.id == arg_23_1 then
			table.remove(self._allList, iter_23_0)

			break
		end
	end

	self:_initList()
end

function RedPacketData:getCurList(arg_24_1)
	if arg_24_1 == 1 then
		return self._systemList
	elseif arg_24_1 == 2 then
		table.sort(self._playerList, function(arg_25_0, arg_25_1)
			if not arg_25_0 or not arg_25_1 then
				return false
			end

			local var_25_0 = arg_25_0.pick_size or 0
			local var_25_1 = arg_25_1.pick_size or 0

			if arg_25_0.picked or arg_25_1.picked then
				if arg_25_0.picked and arg_25_1.picked then
					return arg_25_0.due_time > arg_25_1.due_time
				end

				if arg_25_0.picked then
					if var_25_1 < var_0_0.get(arg_25_1.base_id).limit_people then
						return false
					else
						return true
					end
				elseif var_25_0 < var_0_0.get(arg_25_0.base_id).limit_people then
					return true
				else
					return false
				end
			else
				local var_25_2 = false
				local var_25_3 = false

				if var_25_0 >= var_0_0.get(arg_25_0.base_id).limit_people then
					var_25_2 = true
				end

				if var_25_1 >= var_0_0.get(arg_25_1.base_id).limit_people then
					var_25_3 = true
				end

				if var_25_2 and var_25_3 or not var_25_2 and not var_25_3 then
					return arg_25_0.due_time < arg_25_1.due_time
				end

				return var_25_3
			end
		end)

		return self._playerList
	else
		return self._ownList
	end
end

function RedPacketData:getPacketInfoById(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self._allList) do
		if arg_26_1 == iter_26_1.id then
			return iter_26_1
		end
	end

	return {}
end

function RedPacketData:_freshDetailList()
	self._playerDetails = {}

	for iter_27_0, iter_27_1 in pairs(self._playerList) do
		local var_27_0 = g.core.config.redpacket_info.get(iter_27_1.base_id)

		table.insert(self._playerDetails, {
			id = iter_27_1.id,
			baseId = iter_27_1.base_id,
			picked = iter_27_1.picked,
			fromName = iter_27_1.from_name,
			userQuality = g.core.config.knight_info.get(iter_27_1.from_base_id).quality,
			size = var_27_0.size,
			limit = var_27_0.limit_people,
			pickNum = iter_27_1.pick_size
		})
	end
end

function RedPacketData:getPlayerDetailInfo()
	return self._playerDetails
end

function RedPacketData:canRecPlayerRedPacket()
	for iter_29_0, iter_29_1 in ipairs(self._playerList) do
		local var_29_0 = not iter_29_1.picked
		local var_29_1 = g.core.config.redpacket_info.get(iter_29_1.base_id)
		local var_29_2 = 1

		if var_29_1.get_limit == g.core.const.ConstMgr.PARAMETER_CONST.INGOTS_RED_PACKET_LIMIT then
			var_29_2 = 1
		elseif var_29_1.get_limit == g.core.const.ConstMgr.PARAMETER_CONST.GOLD_RED_PACKET_LIMIT then
			var_29_2 = 2
		elseif var_29_1.get_limit == g.core.const.ConstMgr.PARAMETER_CONST.DEVOTE_RED_PACKET_LIMIT then
			var_29_2 = 3
		end

		if self._pickTime[var_29_2] and self._pickTime[var_29_2] > 0 and var_29_0 and iter_29_1.pick_size < var_29_1.limit_people then
			return true
		end
	end

	return false
end

function RedPacketData:canRecSystemRedPacket()
	for iter_30_0 = 1, #self._systemList do
		local var_30_0 = self._systemList[iter_30_0]
		local var_30_1 = not self._systemList[iter_30_0].picked and var_30_0.due_time
		local var_30_2 = self._systemList[iter_30_0].lockLv or 1

		if var_30_1 and var_30_2 <= g.core.model.User.guildData:getGuildLevel() and g.core.common.ServerTime:getOpenLeftTime(12, 0, 0) <= 0 and var_30_0.pick_size < g.core.config.redpacket_info.get(var_30_0.base_id).limit_people then
			return true
		end
	end

	return false
end

function RedPacketData:getServerLimitId(arg_31_1)
	local var_31_0 = 0

	if arg_31_1 == g.core.const.ConstMgr.PARAMETER_CONST.INGOTS_RED_PACKET_LIMIT then
		var_31_0 = 1
	elseif arg_31_1 == g.core.const.ConstMgr.PARAMETER_CONST.GOLD_RED_PACKET_LIMIT then
		var_31_0 = 2
	elseif arg_31_1 == g.core.const.ConstMgr.PARAMETER_CONST.DEVOTE_RED_PACKET_LIMIT then
		var_31_0 = 3
	end

	return var_31_0
end

function RedPacketData:isLastGuildReceive(arg_32_1)
	local var_32_0 = 0

	if arg_32_1.luck and arg_32_1.point then
		return false
	end

	for iter_32_0, iter_32_1 in g.core.config.redpacket_gm_info.ipairs() do
		if iter_32_1.red_id == arg_32_1.base_id then
			var_32_0 = iter_32_1.position

			break
		end
	end

	if var_32_0 == 0 then
		return false
	end

	for iter_32_2 = 1, #self._systemPosition do
		if var_32_0 == self._systemPosition[iter_32_2] then
			return true
		end
	end

	return false
end

function RedPacketData:getPlayerList()
	return self._playerList
end

function RedPacketData:getSystemList()
	return self._systemList
end

function RedPacketData:getPickTime()
	return self._pickTime
end

function RedPacketData:getSyetemPosition()
	return self._systemPosition
end

function RedPacketData:getDetailList()
	return self._detailList
end

function RedPacketData:getAwards()
	return self._awards
end

function RedPacketData:getUseTime()
	return self._useTime
end

function RedPacketData:getUseList()
	return self._useList
end

function RedPacketData:getWealthPoint()
	return self._wealth
end

function RedPacketData:getLuckyPoint()
	return self._lucky
end

function RedPacketData:getSplitUseList()
	return self._ownList
end

function RedPacketData:isResponse()
	return self._isResponse
end

function RedPacketData:canReceive()
	return self._canRec
end

function RedPacketData:isHasRedPacketCanSend()
	if self:getUseTime() <= 0 then
		return false
	end

	self._curList = self:getCurList(3)

	return #self._curList > 0
end

function RedPacketData:isHasGuildRedPacket()
	return self:canRecSystemRedPacket() or self:canRecPlayerRedPacket()
end

function RedPacketData:canGetRedPackage(arg_48_1)
	if arg_48_1 and arg_48_1.type then
		if arg_48_1.type == 1 then
			return self:canRecSystemRedPacket()
		else
			return self:canRecPlayerRedPacket()
		end
	else
		return self:isHasGuildRedPacket()
	end
end

return RedPacketData
