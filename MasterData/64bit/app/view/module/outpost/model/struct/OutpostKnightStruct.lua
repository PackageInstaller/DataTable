local OutpostEquip = require("app.view.module.outpost.model.struct.OutpostEquip")
local var_0_1 = g.core.config.outpost_parameter_info
local var_0_2 = table.insert
local var_0_3 = g.core.const.ConstMgr.outpostConst
local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local var_0_5 = g.core.config.outpost_knight_info
local var_0_6 = g.core.config.outpost_attribute_info
local var_0_7 = g.core.config.outpost_talent_skill_info
local var_0_8 = g.core.config.outpost_limit_knight_info
local OutpostKnightStruct = class("OutpostKnightStruct")

function OutpostKnightStruct:ctor(arg_1_1)
	self._advanceId = arg_1_1
	self._cfg = var_0_5.get(arg_1_1)
	self._cfgStarMap = {}
	self._serverData = nil
	self._coin = 0
	self._star = 0
	self._level = self._cfg.base_level
	self._exp = 0
	self._lineUp = false
	self._secondSubFatigue = 1 / var_0_1.get(var_0_3.WorldParam.TickSubFatigue).parameter
	self._knightInArena = 0
	self._bagGridMaxNum = 9999
	self._bagItem = {}
	self._bagIdMap = {}
	self._equipPos = {}
	self._equipList = {}
	self._stateMap = {}
	self._isOwn = nil
end

function OutpostKnightStruct:setStarCfg(arg_2_1)
	self._cfgStarMap[arg_2_1.star] = arg_2_1
end

function OutpostKnightStruct:setServerData(arg_3_1, arg_3_2, arg_3_3)
	self._level = arg_3_1.level or self._level
	self._exp = arg_3_1.exp
	self._star = arg_3_1.star
	self._knightInArena = arg_3_1.map_type

	if arg_3_2 ~= nil then
		self._lineUp = arg_3_2
	end

	if arg_3_3 then
		self:updateKnightState(arg_3_1.states or {})
	end

	self:updateKnightEquip(arg_3_1.equips or {})
	self:updateBagData(arg_3_1.bags)

	self._serverData = arg_3_1
end

function OutpostKnightStruct:setKnightArea(arg_4_1)
	self._knightInArena = arg_4_1

	if self._serverData then
		self._serverData.map_type = arg_4_1
	end
end

function OutpostKnightStruct:setIsLineUp(arg_5_1)
	self._lineUp = arg_5_1
end

function OutpostKnightStruct:updateKnightState(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1 or {}) do
		self._stateMap[iter_6_1.tp] = iter_6_1
	end
end

function OutpostKnightStruct:getKnightStateValue(arg_7_1)
	return self._stateMap[arg_7_1].value
end

function OutpostKnightStruct:setKnightStateValue(arg_8_1, arg_8_2)
	self._stateMap[arg_8_1].value = arg_8_2

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_STATUS_CHANGE)
end

function OutpostKnightStruct:updateKnightEquip(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1 or {}) do
		local var_9_0 = self._equipPos[iter_9_1.pos]

		if not self._equipPos[iter_9_1.pos] then
			var_9_0 = OutpostEquip.new()

			var_9_0:setOwner(self)

			self._equipPos[iter_9_1.pos] = var_9_0

			local var_9_1

			for iter_9_2, iter_9_3 in ipairs(self._equipList) do
				if iter_9_3:getEquipType() < iter_9_1.pos then
					var_9_1 = iter_9_2

					break
				end
			end

			if var_9_1 then
				table.insert(self._equipList, var_9_1, var_9_0)
			else
				self._equipList[#self._equipList + 1] = var_9_0
			end
		end

		var_9_0:updateEquipBySvrInfo(iter_9_1)
	end
end

function OutpostKnightStruct:isShowInBag(arg_10_1)
	if arg_10_1 == var_0_3.KNIGHT_COIN_ID then
		return false
	end

	return true
end

function OutpostKnightStruct:getOwnCoinNum()
	return (self._bagIdMap[var_0_3.KNIGHT_COIN_ID] or nil) and (self._bagIdMap[var_0_3.KNIGHT_COIN_ID].item_num or 0)
end

function OutpostKnightStruct:getOwnNumByItemId(arg_12_1)
	return (self._bagIdMap[arg_12_1] or nil) and self._bagIdMap[arg_12_1].item_num
end

function OutpostKnightStruct:getOwnItemByItemId(arg_13_1)
	return self._bagIdMap[arg_13_1]
end

function OutpostKnightStruct:updateBagData(arg_14_1)
	self._bagItem = {}
	self._bagIdMap = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1 or {}) do
		if self:isShowInBag(iter_14_1.item_id) and iter_14_1.item_num ~= 0 then
			table.insert(self._bagItem, iter_14_1)
		end

		self._bagIdMap[iter_14_1.item_id] = iter_14_1
	end

	table.sort(self._bagItem, function(arg_15_0, arg_15_1)
		if arg_15_0.item_id ~= arg_15_1.item_id then
			return arg_15_0.item_id < arg_15_1.item_id
		end

		if arg_15_0.item_num ~= arg_15_1.item_num then
			return arg_15_0.item_num > arg_15_1.item_num
		end

		return false
	end)
end

function OutpostKnightStruct:onItemChange(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if self._bagIdMap[iter_16_1.item_id] then
			self._bagIdMap[iter_16_1.item_id].item_num = self._bagIdMap[iter_16_1.item_id].item_num + iter_16_1.item_num
		else
			local var_16_0 = {
				item_id = iter_16_1.item_id,
				item_num = iter_16_1.item_num
			}

			self._bagIdMap[var_16_0.item_id] = var_16_0

			table.insert(self._bagItem, var_16_0)
		end

		if self._bagIdMap[iter_16_1.item_id].item_num == 0 then
			for iter_16_2, iter_16_3 in ipairs(self._bagItem) do
				if iter_16_3.item_id == iter_16_1.item_id then
					table.remove(self._bagItem, iter_16_2)

					break
				end
			end
		end
	end

	table.sort(self._bagItem, function(arg_17_0, arg_17_1)
		if arg_17_0.item_id ~= arg_17_1.item_id then
			return arg_17_0.item_id < arg_17_1.item_id
		end

		if arg_17_0.item_num ~= arg_17_1.item_num then
			return arg_17_0.item_num > arg_17_1.item_num
		end

		return false
	end)
end

function OutpostKnightStruct:getOwnBagData()
	return self._bagItem
end

function OutpostKnightStruct:getCurBaseAttr(arg_19_1)
	arg_19_1 = arg_19_1 or {}

	local var_19_0 = self._cfgStarMap[self._star]
	local var_19_1 = {
		299,
		599,
		1000
	}

	local function var_19_2(arg_20_0, arg_20_1)
		local var_20_0 = 0

		for iter_20_0, iter_20_1 in ipairs(var_19_1) do
			local var_20_1 = iter_20_0 - 1 <= 0 and 0 or var_19_1[iter_20_0 - 1]

			if iter_20_1 < arg_20_1 - 1 then
				var_20_0 = var_20_0 + (iter_20_1 - var_20_1) * var_19_0[arg_20_0 .. "_" .. iter_20_0] * 0.001
			else
				var_20_0 = var_20_0 + (arg_20_1 - 1 - var_20_1) * var_19_0[arg_20_0 .. "_" .. iter_20_0] * 0.001

				break
			end
		end

		return math.floor(var_20_0)
	end

	arg_19_1[1] = (arg_19_1[1] or 0) + (var_19_0.base_hp + var_19_2("develop_hp", self._level))
	arg_19_1[2] = (arg_19_1[2] or 0) + (var_19_0.base_attack + var_19_2("develop_attack", self._level))
	arg_19_1[3] = (arg_19_1[3] or 0) + (var_19_0.base_physical_defence + var_19_2("develop_physical_defence", self._level))
	arg_19_1[4] = (arg_19_1[4] or 0) + var_19_0.atk_speed
	arg_19_1[101] = (arg_19_1[101] or 0) + var_19_0.accuracy_rate
	arg_19_1[102] = (arg_19_1[102] or 0) + var_19_0.dodge_rate
	arg_19_1[103] = (arg_19_1[103] or 0) + var_19_0.crit_rate
	arg_19_1[104] = (arg_19_1[104] or 0) + var_19_0.harden_rate

	return arg_19_1
end

function OutpostKnightStruct:getSuitAttr(arg_21_1)
	arg_21_1 = arg_21_1 or {}

	local var_21_0 = self:getEquips()

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		local var_21_1 = iter_21_1:getTalentCfg()

		while var_0_7.hasKey(table.concat({
			"affect_type_",
			1
		})) do
			arg_21_1[var_21_1["affect_type_" .. 1]] = (arg_21_1[var_21_1["affect_type_" .. 1]] or 0) + var_21_1["affect_value_" .. 1]
		end
	end

	for iter_21_2, iter_21_3 in pairs({
		[12] = 2,
		[14] = 4,
		[13] = 3,
		[11] = 1
	}) do
		if arg_21_1[iter_21_2] and arg_21_1[iter_21_2] > 0 then
			arg_21_1[iter_21_3] = math.floor(arg_21_1[iter_21_3] * (1000 + arg_21_1[iter_21_2]) * 0.001)
		end
	end

	for iter_21_4, iter_21_5 in pairs(var_21_0) do
		local var_21_4 = iter_21_5:getCfg()

		arg_21_1[var_21_4.attribute_type] = (arg_21_1[var_21_4.attribute_type] or 0) + var_21_4.attribute_value
	end

	return arg_21_1
end

function OutpostKnightStruct:getBaseShowAttr()
	local var_22_0 = self:getFinalAtkAttrs()
	local var_22_1 = {}

	for iter_22_0 = 1, 4 do
		local var_22_2 = var_0_6.get(iter_22_0)
		local var_22_3 = var_22_0[iter_22_0]
		local var_22_4, var_22_5

		if not var_22_0[iter_22_0] then
			var_22_3 = 0
			var_22_4 = var_22_1
			var_22_5 = {
				type = iter_22_0,
				name = var_22_2.name
			}
		end

		var_22_5.value = var_22_2.value_format == 1 and var_22_3 or var_22_3 / 100 .. "%"
		var_22_5.icon = var_22_2.icon

		table.insert(var_22_1, var_22_5)
	end

	return var_22_1
end

function OutpostKnightStruct:getFinalAtkAttrs()
	local var_23_0 = {}

	self:getCurBaseAttr(var_23_0)
	self:getSuitAttr(var_23_0)

	return var_23_0
end

function OutpostKnightStruct:getSelfFightValue()
	return OutpostCommon.calcKnightFightValue({
		self
	})
end

function OutpostKnightStruct:getStateMaps()
	return self._stateMap
end

function OutpostKnightStruct:getLevel()
	return self._level
end

function OutpostKnightStruct:getExp()
	return self._exp
end

function OutpostKnightStruct:isLineUp()
	return self._lineUp
end

function OutpostKnightStruct:getServerId()
	if self._serverData then
		return self._serverData.knight_id
	end
end

function OutpostKnightStruct:getMapType()
	if self._serverData then
		return self._serverData.map_type == 0 and 1 or self._serverData.map_type
	else
		return 1
	end
end

function OutpostKnightStruct:getAllLvSkills(arg_31_1)
	local var_31_0 = {}
	local var_31_1 = {}

	for iter_31_0 = 0, 7 do
		local var_31_2 = self._cfgStarMap[iter_31_0]

		if self._cfgStarMap[iter_31_0] and var_31_2[arg_31_1] ~= 0 and not var_31_1[var_31_2[arg_31_1]] then
			var_31_1[var_31_2[arg_31_1]] = true

			table.insert(var_31_0, {
				star = iter_31_0,
				skillId = var_31_2[arg_31_1],
				isUnlock = iter_31_0 <= self._star
			})
		end
	end

	return var_31_0
end

function OutpostKnightStruct:getCfg(arg_32_1)
	return self._cfgStarMap[arg_32_1 or self._star]
end

function OutpostKnightStruct:getAdvId()
	return self._advanceId
end

function OutpostKnightStruct:isClassical(arg_34_1)
	if arg_34_1 == -1 then
		return true
	end

	return self._cfg.classical == arg_34_1
end

function OutpostKnightStruct:getOwnTargetArena()
	return self._knightInArena == 0 and 1 or self._knightInArena
end

function OutpostKnightStruct:getEquips()
	return self._equipPos
end

function OutpostKnightStruct:getEquipList()
	return self._equipList
end

function OutpostKnightStruct:getStar()
	return self._star
end

function OutpostKnightStruct:setClickChangeEquip(arg_39_1)
	self._isChangeEquip = arg_39_1
end

function OutpostKnightStruct:isInChangeEquip()
	return self._isChangeEquip
end

function OutpostKnightStruct:toProtoOutpostKnight()
	local var_41_0 = {}

	var_0_2(var_41_0, {
		tp = var_0_3.STATE_ENUM.KNIGHT_HP,
		value = self:getKnightStateValue(var_0_3.STATE_ENUM.KNIGHT_HP)
	})
	var_0_2(var_41_0, {
		tp = var_0_3.STATE_ENUM.KNIGHT_MOOD,
		value = self:getKnightStateValue(var_0_3.STATE_ENUM.KNIGHT_MOOD)
	})
	var_0_2(var_41_0, {
		tp = var_0_3.STATE_ENUM.KNIGHT_HUNGER,
		value = self:getKnightStateValue(var_0_3.STATE_ENUM.KNIGHT_HUNGER)
	})
	var_0_2(var_41_0, {
		tp = var_0_3.STATE_ENUM.KNIGHT_FATIGUE,
		value = self:getKnightStateValue(var_0_3.STATE_ENUM.KNIGHT_FATIGUE)
	})

	return {
		knight_id = self:getServerId(),
		advance_id = self:getAdvId(),
		map_type = self:getMapType(),
		states = var_41_0
	}
end

function OutpostKnightStruct:isOwn()
	return g.core.model.User.knightsData:getKnightByAdvanceId(self._advanceId):isOwn() or not not var_0_8.fetch(self._advanceId)
end

return OutpostKnightStruct
