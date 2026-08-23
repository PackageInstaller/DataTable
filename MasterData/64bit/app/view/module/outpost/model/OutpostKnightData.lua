local var_0_0 = g.core.config.outpost_knight_info
local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local OutpostKnightStruct = require("app.view.module.outpost.model.struct.OutpostKnightStruct")
local OutpostKnightData = class("OutpostKnightData")

function OutpostKnightData:ctor()
	self._knightLingUpData = {}
	self._knightAdvIdStructsMap = {}
	self._knightSidIdStructsMap = {}
	self._knightPosList = {}

	self:initAllKnight()
end

function OutpostKnightData:initAllKnight()
	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		if iter_2_1.is_show == 1 then
			if not self._knightAdvIdStructsMap[iter_2_1.advance_id] then
				local var_2_0 = OutpostKnightStruct.new(iter_2_1.advance_id)

				var_2_0:setStarCfg(iter_2_1)

				self._knightAdvIdStructsMap[iter_2_1.advance_id] = var_2_0
			else
				self._knightAdvIdStructsMap[iter_2_1.advance_id]:setStarCfg(iter_2_1)
			end
		end
	end
end

function OutpostKnightData:updateOwnKnightSvrAll(arg_3_1, arg_3_2)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if iter_3_1.knight_id ~= 0 then
			var_3_0[iter_3_1.knight_id] = true
			self._knightPosList[iter_3_1.pos] = iter_3_1.knight_id
		end
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1 or {}) do
		self._knightSidIdStructsMap[iter_3_3.knight_id] = self._knightAdvIdStructsMap[iter_3_3.advance_id]

		self._knightAdvIdStructsMap[iter_3_3.advance_id]:setServerData(iter_3_3, var_3_0[iter_3_3.knight_id], true)
	end
end

function OutpostKnightData:updateKnightSvr(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1 or {}) do
		if self._knightSidIdStructsMap[iter_4_1.knight_id] then
			self._knightSidIdStructsMap[iter_4_1.knight_id]:setServerData(iter_4_1, nil, arg_4_2)
		else
			local var_4_0 = OutpostKnightStruct.new(iter_4_1.advance_id)

			self._knightAdvIdStructsMap[iter_4_1.advance_id] = var_4_0
			self._knightSidIdStructsMap[iter_4_1.knight_id] = var_4_0

			var_4_0:setServerData(iter_4_1, nil, true)
		end
	end
end

function OutpostKnightData:getAllLineUpKnights()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self._knightAdvIdStructsMap) do
		if iter_5_1:isLineUp() then
			table.insert(var_5_0, iter_5_1)
		end
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:getSelfFightValue()
		local var_6_1 = arg_6_1:getSelfFightValue()

		if var_6_0 ~= var_6_1 then
			return var_6_1 < var_6_0
		end

		return arg_6_0:getCfg().advance_id < arg_6_1:getCfg().advance_id
	end)

	return var_5_0
end

function OutpostKnightData:getAllKnights(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self._knightAdvIdStructsMap) do
		if iter_7_1:isClassical(arg_7_1) then
			if config.START_NEW_GUIDE then
				if iter_7_1:isOwn() then
					table.insert(var_7_0, iter_7_1)
				end
			else
				table.insert(var_7_0, iter_7_1)
			end
		end
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0:isOwn()

		if var_8_0 ~= arg_8_1:isOwn() then
			return var_8_0
		end

		local var_8_1 = arg_8_0:getSelfFightValue()
		local var_8_2 = arg_8_1:getSelfFightValue()
		local var_8_3

		if var_8_1 ~= var_8_2 then
			do return var_8_2 < var_8_1 end

			var_8_3 = arg_8_1:isLineUp()
		end

		if arg_8_0:isLineUp() ~= var_8_3 then
			return var_8_3
		end

		return arg_8_0:getCfg().advance_id < arg_8_1:getCfg().advance_id
	end)

	return var_7_0
end

function OutpostKnightData:updateKnightEntrance(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_1.knights) do
		local var_9_0 = self:getKnightByAdvId(iter_9_1.advance_id)

		self._knightSidIdStructsMap[iter_9_1.knight_id] = var_9_0

		var_9_0:setServerData(iter_9_1, true, true)
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_1.slots or {}) do
		if iter_9_3.knight_id ~= 0 then
			self._knightPosList[iter_9_3.pos] = iter_9_3.knight_id
		end
	end
end

function OutpostKnightData:updateKnightExit(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1.knights) do
		self:getKnightBySid(iter_10_1.knight_id):setIsLineUp(false)

		for iter_10_2, iter_10_3 in pairs(self._knightPosList) do
			if iter_10_3 == iter_10_1.knight_id then
				self._knightPosList[iter_10_2] = nil

				break
			end
		end
	end
end

function OutpostKnightData:onS2COutPostKnightChangeMap(arg_11_1)
	if arg_11_1.slots then
		for iter_11_0, iter_11_1 in pairs(arg_11_1.slots) do
			self:getKnightBySid(iter_11_1.knight_id):setKnightArea(iter_11_1.map_type)
		end
	end
end

function OutpostKnightData:getKnightAllArena()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs((self:getAllLineUpKnights())) do
		local var_12_1 = iter_12_1:getOwnTargetArena()

		var_12_0[var_12_1] = var_12_0[var_12_1] or {}

		table.insert(var_12_0[var_12_1], iter_12_1)
	end

	return var_12_0
end

function OutpostKnightData:getKnightIdByPos(arg_13_1)
	return self._knightPosList[arg_13_1]
end

function OutpostKnightData:getKnightBySid(arg_14_1)
	return self._knightSidIdStructsMap[arg_14_1]
end

function OutpostKnightData:getKnightByAdvId(arg_15_1)
	return self._knightAdvIdStructsMap[arg_15_1]
end

function OutpostKnightData:isCanLineUp()
	local var_16_0 = g.core.model.User.outpostData:getBuildData():getBuild({
		type = g.core.const.ConstMgr.outpostConst.BuildType.Main
	})

	if var_16_0 then
		local var_16_1 = var_16_0:getMaxRoleNum()
		local var_16_2 = table.nums(self._knightPosList)

		return var_16_2 < var_16_1, var_16_1 - var_16_2
	end
end

function OutpostKnightData:getAllLineUpFightValueKnights()
	local var_17_0 = g.core.model.User.outpostData:getBuildData():getBuild({
		type = g.core.const.ConstMgr.outpostConst.BuildType.Main
	})
	local var_17_1 = {}
	local var_17_2 = {}
	local var_17_3 = {
		up = {},
		down = {}
	}

	if var_17_0 then
		local var_17_4 = var_17_0:getMaxRoleNum()
		local var_17_5 = self:getAllOwnKnight()

		for iter_17_0 = 1, var_17_4 do
			if var_17_5[iter_17_0] then
				table.insert(var_17_1, var_17_5[iter_17_0])

				var_17_2[var_17_5[iter_17_0]:getAdvId()] = true
			else
				break
			end
		end

		for iter_17_1, iter_17_2 in ipairs((self:getAllLineUpKnights())) do
			if not var_17_2[iter_17_2:getAdvId()] then
				table.insert(var_17_1, iter_17_2)
			end
		end

		table.sort(var_17_1, function(arg_18_0, arg_18_1)
			local var_18_0 = arg_18_0:getSelfFightValue()
			local var_18_1 = arg_18_1:getSelfFightValue()

			if var_18_0 ~= var_18_1 then
				return var_18_1 < var_18_0
			end

			local var_18_2 = arg_18_0:isLineUp()

			if var_18_2 ~= arg_18_1:isLineUp() then
				return var_18_2
			end

			return arg_18_0:getAdvId() > arg_18_1:getAdvId()
		end)

		for iter_17_3, iter_17_4 in ipairs(var_17_1) do
			if iter_17_3 <= var_17_4 then
				if not iter_17_4:isLineUp() then
					table.insert(var_17_3.up, iter_17_4)
				end
			elseif iter_17_4:isLineUp() then
				table.insert(var_17_3.down, iter_17_4)
			end
		end
	end

	return var_17_3
end

function OutpostKnightData:getAllCanUpKnights()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(self._knightAdvIdStructsMap) do
		if iter_19_1:isOwn() and not iter_19_1:isLineUp() then
			table.insert(var_19_0, iter_19_1)
		end
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:getSelfFightValue()
		local var_20_1 = arg_20_1:getSelfFightValue()

		if var_20_0 ~= var_20_1 then
			return var_20_1 < var_20_0
		end

		return arg_20_0:getAdvId() < arg_20_1:getAdvId()
	end)

	return var_19_0
end

function OutpostKnightData:getAllOwnKnight()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self._knightAdvIdStructsMap) do
		if iter_21_1:isOwn() then
			table.insert(var_21_0, iter_21_1)
		end
	end

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:getSelfFightValue()
		local var_22_1 = arg_22_1:getSelfFightValue()

		if var_22_0 ~= var_22_1 then
			return var_22_1 < var_22_0
		end

		return arg_22_0:getAdvId() < arg_22_1:getAdvId()
	end)

	return var_21_0
end

function OutpostKnightData:onS2COutpostDonateKnight(arg_23_1)
	self:getKnightBySid(arg_23_1.knight.knight_id):setServerData(arg_23_1.knight)
end

function OutpostKnightData:getFightValue()
	return OutpostCommon.calcKnightFightValue((self:getAllLineUpKnights()))
end

return OutpostKnightData
