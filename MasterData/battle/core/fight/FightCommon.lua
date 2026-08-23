local var_0_0 = math
local var_0_1 = math.min
local var_0_2 = math.max
local var_0_3 = table
local var_0_4 = table.sort
local var_0_5 = table.insert
local var_0_6 = table.remove
local var_0_7 = {
	range = function(arg_1_0, arg_1_1, arg_1_2)
		if arg_1_0 then
			arg_1_2 = var_0_2(arg_1_0, arg_1_2)
		end

		if arg_1_1 then
			arg_1_2 = var_0_1(arg_1_1, arg_1_2)
		end

		return arg_1_2
	end,
	random = function(arg_2_0, arg_2_1, arg_2_2)
		return arg_2_2:boundedRandom(arg_2_0, arg_2_1)
	end,
	createVictimTarget = function(arg_3_0, arg_3_1)
		if not arg_3_0 then
			return nil
		end

		return {
			inherit = false,
			miss = false,
			block = false,
			crit = false,
			victim = arg_3_0,
			isIncludeAll = arg_3_1 == true
		}
	end
}

function var_0_7:copyTarget()
	if self then
		local var_4_0 = var_0_7.createVictimTarget(self.victim)

		var_4_0.miss = self.miss
		var_4_0.crit = self.crit
		var_4_0.block = self.block
		var_4_0.inherit = true

		return var_4_0
	end

	return nil
end

function var_0_7:getRandomNTargets(arg_5_1, arg_5_2)
	local var_5_0 = self.battleData:getKnightList(arg_5_1, nil, self.attacker)
	local var_5_1 = {}

	for iter_5_0 = 1, #var_5_0 do
		var_0_5(var_5_1, var_0_7.createVictimTarget(var_5_0[iter_5_0]))
	end

	while arg_5_2 < #var_5_1 do
		var_0_6(var_5_1, (var_0_7.random(1, #var_5_1, self.battleField)))
	end

	return var_5_1
end

function var_0_7:getRandomMaxTargets(arg_6_1, arg_6_2, arg_6_3)
	return var_0_7.getRandomMaxTargetsGroup(self.battleData:getKnightList(arg_6_1, nil, self.attacker), arg_6_2, arg_6_3, self.battleField)
end

function var_0_7:getRandomMaxTargets2(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0
	local var_7_1
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_4 = {}
	local var_7_5 = self.battleData:getKnightList(arg_7_1, nil, self.attacker)

	for iter_7_0 = 1, #var_7_5 do
		if not var_7_0 then
			var_7_0 = var_7_5[iter_7_0].advanceInfo[arg_7_2]
			var_7_2 = {}
			var_7_2[#var_7_2 + 1] = var_7_5[iter_7_0]
		elseif arg_7_3 then
			if var_7_0 < var_7_5[iter_7_0].advanceInfo[arg_7_2] then
				var_7_1 = var_7_0
				var_7_3 = var_7_2
				var_7_0 = var_7_5[iter_7_0].advanceInfo[arg_7_2]
				var_7_2 = {}
				var_7_2[#var_7_2 + 1] = var_7_5[iter_7_0]
			elseif var_7_5[iter_7_0].advanceInfo[arg_7_2] == var_7_0 then
				var_7_2[#var_7_2 + 1] = var_7_5[iter_7_0]
			elseif not var_7_1 then
				var_7_1 = var_7_5[iter_7_0].advanceInfo[arg_7_2]
				var_7_3 = {}
				var_7_3[#var_7_3 + 1] = var_7_5[iter_7_0]
			elseif var_7_1 < var_7_5[iter_7_0].advanceInfo[arg_7_2] then
				var_7_1 = var_7_5[iter_7_0].advanceInfo[arg_7_2]
				var_7_3 = {}
				var_7_3[#var_7_3 + 1] = var_7_5[iter_7_0]
			elseif var_7_5[iter_7_0].advanceInfo[arg_7_2] == var_7_1 then
				var_7_3[#var_7_3 + 1] = var_7_5[iter_7_0]
			end
		elseif var_7_5[iter_7_0].advanceInfo[arg_7_2] < var_7_0 then
			var_7_1 = var_7_0
			var_7_3 = var_7_2
			var_7_0 = var_7_5[iter_7_0].advanceInfo[arg_7_2]
			var_7_2 = {}
			var_7_2[#var_7_2 + 1] = var_7_5[iter_7_0]
		elseif var_7_5[iter_7_0].advanceInfo[arg_7_2] == var_7_0 then
			var_7_2[#var_7_2 + 1] = var_7_5[iter_7_0]
		elseif not var_7_1 then
			var_7_1 = var_7_5[iter_7_0].advanceInfo[arg_7_2]
			var_7_3 = {}
			var_7_3[#var_7_3 + 1] = var_7_5[iter_7_0]
		elseif var_7_5[iter_7_0].advanceInfo[arg_7_2] < var_7_1 then
			var_7_1 = var_7_5[iter_7_0].advanceInfo[arg_7_2]
			var_7_3 = {}
			var_7_3[#var_7_3 + 1] = var_7_5[iter_7_0]
		elseif var_7_5[iter_7_0].advanceInfo[arg_7_2] == var_7_1 then
			var_7_3[#var_7_3 + 1] = var_7_5[iter_7_0]
		end
	end

	for iter_7_1 = 1, #var_7_2 do
		var_0_5(var_7_4, var_7_2[iter_7_1])
	end

	if #var_7_4 >= 2 then
		while #var_7_4 > 2 do
			var_0_6(var_7_4, (var_0_7.random(1, #var_7_4, self.battleField)))
		end
	else
		var_0_5(var_7_4, var_7_3[var_0_7.random(1, #var_7_3, self.battleField)])
	end

	return var_7_4
end

function var_0_7:getMaxTargetsN(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = self.battleData:getKnightList(arg_8_1, nil, self.attacker)

	if #var_8_0 == 0 then
		return {}
	end

	if #var_8_0 < arg_8_4 then
		return var_8_0
	end

	local var_8_1 = {}

	for iter_8_0 = 1, #var_8_0 do
		var_8_1[iter_8_0] = iter_8_0
	end

	var_0_4(var_8_1, function(arg_9_0, arg_9_1)
		local var_9_0 = var_8_0[arg_9_0].advanceInfo[arg_8_2]
		local var_9_1 = var_8_0[arg_9_1].advanceInfo[arg_8_2]

		if var_8_0[arg_9_0].advanceInfo[arg_8_2] ~= var_8_0[arg_9_1].advanceInfo[arg_8_2] then
			if arg_8_3 then
				return var_9_1 < var_9_0
			else
				return var_9_0 < var_9_1
			end
		end

		return arg_9_0 < arg_9_1
	end)

	local var_8_2 = {}

	for iter_8_1 = 1, arg_8_4 do
		local var_8_3 = 1

		for iter_8_2 = 2, #var_8_1 do
			if var_8_0[var_8_1[iter_8_2]].advanceInfo[arg_8_2] ~= var_8_0[var_8_1[1]].advanceInfo[arg_8_2] then
				break
			end

			var_8_3 = iter_8_2
		end

		local var_8_4 = var_0_7.random(1, var_8_3, self.battleField)

		var_0_5(var_8_2, var_8_0[var_8_1[var_8_4]])
		var_0_6(var_8_1, var_8_4)
	end

	return var_8_2
end

function var_0_7:getRateTargetsN(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = self.battleData:getKnightList(arg_10_1, nil, self.attacker)
	local var_10_1 = {}

	if arg_10_3 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			if arg_10_4 < iter_10_1.advanceInfo[arg_10_2] then
				var_0_5(var_10_1, iter_10_1)
			end
		end
	else
		for iter_10_2, iter_10_3 in ipairs(var_10_0) do
			if arg_10_4 > iter_10_3.advanceInfo[arg_10_2] then
				var_0_5(var_10_1, iter_10_3)
			end
		end
	end

	return var_10_1
end

function var_0_7.getRandomN(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		var_0_5(var_11_0, iter_11_1)
	end

	for iter_11_2 = #var_11_0, var_0_2(#var_11_0 - arg_11_1 + 1, 1), -1 do
		local var_11_2 = var_0_7.random(1, iter_11_2, arg_11_2)

		var_0_5(var_11_1, var_11_0[var_11_2])

		var_11_0[iter_11_2], var_11_0[var_11_2] = var_11_0[var_11_2], var_11_0[iter_11_2]
	end

	return var_11_1
end

function var_0_7:getRandomMaxTargetsGroup(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = -1
	local var_12_1 = {}

	for iter_12_0 = 1, #self do
		if var_12_0 < 0 or arg_12_2 and var_12_0 < self[iter_12_0].advanceInfo[arg_12_1] or not arg_12_2 and self[iter_12_0].advanceInfo[arg_12_1] < var_12_0 then
			var_12_0 = self[iter_12_0].advanceInfo[arg_12_1]
			var_12_1 = {}
			var_12_1[#var_12_1 + 1] = self[iter_12_0]
		elseif self[iter_12_0].advanceInfo[arg_12_1] == var_12_0 then
			var_12_1[#var_12_1 + 1] = self[iter_12_0]
		end
	end

	return var_12_1[var_0_7.random(1, #var_12_1, arg_12_3)]
end

function var_0_7:getRandomMaxTargetsGroupN(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = {}

	for iter_13_0 = 1, #self do
		var_0_5(var_13_0, iter_13_0)
	end

	var_0_4(var_13_0, function(arg_14_0, arg_14_1)
		local var_14_0 = self[arg_14_0].advanceInfo[arg_13_1]
		local var_14_1 = self[arg_14_1].advanceInfo[arg_13_1]

		if self[arg_14_0].advanceInfo[arg_13_1] ~= self[arg_14_1].advanceInfo[arg_13_1] then
			if arg_13_2 then
				return var_14_1 < var_14_0
			else
				return var_14_0 < var_14_1
			end
		end

		return arg_14_0 < arg_14_1
	end)

	local var_13_1 = {}

	if arg_13_4 > #var_13_0 then
		for iter_13_1, iter_13_2 in ipairs(var_13_0) do
			var_0_5(var_13_1, self[iter_13_2])
		end
	else
		for iter_13_3 = 1, arg_13_4 do
			var_0_5(var_13_1, self[var_13_0[iter_13_3]])
		end
	end

	return var_13_1
end

function var_0_7:getRandomMaxTargets2Group(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0
	local var_15_1
	local var_15_2 = {}
	local var_15_3 = {}
	local var_15_4 = {}

	for iter_15_0 = 1, #self do
		if not var_15_0 then
			var_15_0 = self[iter_15_0].advanceInfo[arg_15_1]
			var_15_2 = {}
			var_15_2[#var_15_2 + 1] = self[iter_15_0]
		elseif arg_15_2 then
			if var_15_0 < self[iter_15_0].advanceInfo[arg_15_1] then
				var_15_1 = var_15_0
				var_15_3 = var_15_2
				var_15_0 = self[iter_15_0].advanceInfo[arg_15_1]
				var_15_2 = {}
				var_15_2[#var_15_2 + 1] = self[iter_15_0]
			elseif self[iter_15_0].advanceInfo[arg_15_1] == var_15_0 then
				var_15_2[#var_15_2 + 1] = self[iter_15_0]
			elseif not var_15_1 then
				var_15_1 = self[iter_15_0].advanceInfo[arg_15_1]
				var_15_3 = {}
				var_15_3[#var_15_3 + 1] = self[iter_15_0]
			elseif var_15_1 < self[iter_15_0].advanceInfo[arg_15_1] then
				var_15_1 = self[iter_15_0].advanceInfo[arg_15_1]
				var_15_3 = {}
				var_15_3[#var_15_3 + 1] = self[iter_15_0]
			elseif self[iter_15_0].advanceInfo[arg_15_1] == var_15_1 then
				var_15_3[#var_15_3 + 1] = self[iter_15_0]
			end
		elseif self[iter_15_0].advanceInfo[arg_15_1] < var_15_0 then
			var_15_1 = var_15_0
			var_15_3 = var_15_2
			var_15_0 = self[iter_15_0].advanceInfo[arg_15_1]
			var_15_2 = {}
			var_15_2[#var_15_2 + 1] = self[iter_15_0]
		elseif self[iter_15_0].advanceInfo[arg_15_1] == var_15_0 then
			var_15_2[#var_15_2 + 1] = self[iter_15_0]
		elseif not var_15_1 then
			var_15_1 = self[iter_15_0].advanceInfo[arg_15_1]
			var_15_3 = {}
			var_15_3[#var_15_3 + 1] = self[iter_15_0]
		elseif self[iter_15_0].advanceInfo[arg_15_1] < var_15_1 then
			var_15_1 = self[iter_15_0].advanceInfo[arg_15_1]
			var_15_3 = {}
			var_15_3[#var_15_3 + 1] = self[iter_15_0]
		elseif self[iter_15_0].advanceInfo[arg_15_1] == var_15_1 then
			var_15_3[#var_15_3 + 1] = self[iter_15_0]
		end
	end

	for iter_15_1 = 1, #var_15_2 do
		var_0_5(var_15_4, var_15_2[iter_15_1])
	end

	if #var_15_4 >= 2 then
		while #var_15_4 > 2 do
			var_0_6(var_15_4, (var_0_7.random(1, #var_15_4, arg_15_3)))
		end
	else
		var_0_5(var_15_4, var_15_3[var_0_7.random(1, #var_15_3, arg_15_3)])
	end

	return var_15_4
end

function var_0_7:getSpKnights(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	return var_0_7.getSpKnightsGroup(self.battleData:getKnightList(arg_16_1, nil, self.attacker), arg_16_2, arg_16_3, arg_16_4)
end

function var_0_7:getRandomKnight(arg_17_1)
	local var_17_0 = self.battleData:getKnightList(arg_17_1, nil, self.attacker)

	return var_17_0[var_0_7.random(1, #var_17_0, self.battleField)]
end

function var_0_7:getGroup(arg_18_1, arg_18_2)
	return var_0_7.getSpGroup(self.battleData:getKnightList(arg_18_1, nil, self.attacker), arg_18_2)
end

function var_0_7:getRandomNTargetsWithoutSelf(arg_19_1, arg_19_2)
	local var_19_0 = self.battleData:getKnightList(arg_19_1, nil, self.attacker)
	local var_19_1 = {}

	for iter_19_0 = 1, #var_19_0 do
		if var_19_0[iter_19_0].serialId ~= self.attacker.serialId then
			var_0_5(var_19_1, var_0_7.createVictimTarget(var_19_0[iter_19_0]))
		end
	end

	while arg_19_2 < #var_19_1 do
		var_0_6(var_19_1, (var_0_7.random(1, #var_19_1, self.battleField)))
	end

	return var_19_1
end

function var_0_7:getRangeKnights()
	local var_20_0 = {}
	local var_20_1 = {}

	if self then
		for iter_20_0 = 1, #self do
			var_20_0[iter_20_0] = self[iter_20_0].victim
			var_20_1[var_20_0[iter_20_0]] = self[iter_20_0]
		end
	end

	return var_20_0, var_20_1
end

function var_0_7:getSpKnightsGroup(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = {}

	for iter_21_0 = 1, #self do
		if arg_21_3 and arg_21_2 <= self[iter_21_0].advanceInfo[arg_21_1] or not arg_21_3 and self[iter_21_0].advanceInfo[arg_21_1] <= arg_21_2 then
			var_21_0[#var_21_0 + 1] = self[iter_21_0]
		end
	end

	return var_21_0
end

function var_0_7:getSpGroup(arg_22_1)
	local var_22_0 = {}

	for iter_22_0 = 1, #self do
		if self[iter_22_0].knightCfg.group == arg_22_1 then
			var_22_0[#var_22_0 + 1] = self[iter_22_0]
		end
	end

	return var_22_0
end

function var_0_7:getSpBuffKnights(arg_23_1)
	local var_23_0 = {}

	for iter_23_0 = 1, #self do
		if self[iter_23_0]:hasBuffByEffectType(arg_23_1) then
			var_0_5(var_23_0, self[iter_23_0])
		end
	end

	return var_23_0
end

function var_0_7:getMaxTargetsNGroup(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if #self == 0 then
		return {}
	end

	if #self < arg_24_3 then
		return self
	end

	local var_24_0 = {}

	for iter_24_0 = 1, #self do
		var_24_0[iter_24_0] = iter_24_0
	end

	var_0_4(var_24_0, function(arg_25_0, arg_25_1)
		local var_25_0 = self[arg_25_0].advanceInfo[arg_24_1]
		local var_25_1 = self[arg_25_1].advanceInfo[arg_24_1]

		if self[arg_25_0].advanceInfo[arg_24_1] ~= self[arg_25_1].advanceInfo[arg_24_1] then
			if arg_24_2 then
				return var_25_1 < var_25_0
			else
				return var_25_0 < var_25_1
			end
		end

		return arg_25_0 < arg_25_1
	end)

	local var_24_1 = {}

	for iter_24_1 = 1, arg_24_3 do
		local var_24_2 = 1

		for iter_24_2 = 2, #var_24_0 do
			if self[var_24_0[iter_24_2]].advanceInfo[arg_24_1] ~= self[var_24_0[1]].advanceInfo[arg_24_1] then
				break
			end

			var_24_2 = iter_24_2
		end

		local var_24_3 = var_0_7.random(1, var_24_2, arg_24_4)

		var_0_5(var_24_1, self[var_24_0[var_24_3]])
		var_0_6(var_24_0, var_24_3)
	end

	return var_24_1
end

function var_0_7:getRandomNTargetsWithoutList(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = self.battleData:getKnightList(arg_26_1, nil, self.attacker)
	local var_26_1 = {}

	for iter_26_0 = 1, #var_26_0 do
		local var_26_2 = false

		for iter_26_1 = 1, #arg_26_3 do
			if var_26_0[iter_26_0].serialId == arg_26_3[iter_26_1].victim.serialId then
				var_26_2 = true

				break
			end
		end

		if not var_26_2 then
			var_0_5(var_26_1, var_0_7.createVictimTarget(var_26_0[iter_26_0]))
		end
	end

	while arg_26_2 < #var_26_1 do
		var_0_6(var_26_1, (var_0_7.random(1, #var_26_1, self.battleField)))
	end

	return var_26_1
end

function var_0_7:getRandomNTargetsWithoutListAll(arg_27_1, arg_27_2)
	local var_27_0 = self.battleData:getAllKnightListTarget()
	local var_27_1 = {}

	for iter_27_0 = 1, #var_27_0 do
		local var_27_2 = false

		for iter_27_1 = 1, #arg_27_2 do
			if var_27_0[iter_27_0].serialId == arg_27_2[iter_27_1].victim.serialId then
				var_27_2 = true

				break
			end
		end

		if not var_27_2 then
			var_0_5(var_27_1, var_0_7.createVictimTarget(var_27_0[iter_27_0]))
		end
	end

	while arg_27_1 < #var_27_1 do
		var_0_6(var_27_1, (var_0_7.random(1, #var_27_1, self.battleField)))
	end

	return var_27_1
end

function var_0_7:getAttackDis(arg_28_1)
	local var_28_0 = 0

	if self.serialId % 10 < 4 and arg_28_1.serialId % 10 < 4 then
		var_28_0 = var_28_0 + 1
		var_28_0 = var_28_0 + var_0_0.abs(self.serialId % 10 - arg_28_1.serialId % 10)
	elseif self.serialId % 10 > 3 and arg_28_1.serialId % 10 > 3 then
		var_28_0 = var_28_0 + 3
		var_28_0 = var_28_0 + var_0_0.abs(self.serialId % 10 - arg_28_1.serialId % 10)
	elseif self.serialId % 10 < 4 and arg_28_1.serialId % 10 > 3 then
		var_28_0 = var_28_0 + 2 + var_0_0.abs(self.serialId % 10 - (arg_28_1.serialId % 10 - 3))
	elseif self.serialId % 10 > 3 and arg_28_1.serialId % 10 < 4 then
		var_28_0 = var_28_0 + 2 + var_0_0.abs(self.serialId % 10 - 3 - arg_28_1.serialId % 10)
	end

	return var_28_0
end

function var_0_7:getSortBuffList0(arg_29_1, arg_29_2)
	if #self <= arg_29_1 then
		return self
	else
		local var_29_0 = var_0_7.random(1, #self, arg_29_2)
		local var_29_1 = {}

		for iter_29_0 = 1, #self do
			var_0_5(var_29_1, self[var_29_0])

			var_29_0 = var_29_0 + 1

			if #self < var_29_0 then
				var_29_0 = 1
			end
		end

		return var_29_1
	end
end

function var_0_7:getSortBuffList1(arg_30_1)
	if arg_30_1 >= #self then
		return self
	end

	local var_30_0 = {}

	var_0_3.sort(self, function(arg_31_0, arg_31_1)
		return arg_31_0.buffTime < arg_31_1.buffTime
	end)

	for iter_30_0 = 1, arg_30_1 do
		var_0_3.insert(var_30_0, self[iter_30_0])
	end

	return var_30_0
end

function var_0_7:getSortBuffList2(arg_32_1, arg_32_2)
	if #self <= arg_32_1 then
		return self
	end

	local var_32_0 = var_0_7.random(1, #self, arg_32_2)
	local var_32_1 = {}

	for iter_32_0 = 1, #self do
		if self[var_32_0].buffCfg.not_clear == 0 then
			var_0_5(var_32_1, self[var_32_0])
		end

		if arg_32_1 <= #var_32_1 then
			return var_32_1
		end

		var_32_0 = var_32_0 + 1

		if #self < var_32_0 then
			var_32_0 = 1
		end
	end

	for iter_32_1 = 1, #self do
		if self[var_32_0].buffCfg.not_clear ~= 0 then
			var_0_5(var_32_1, self[var_32_0])
		end

		if arg_32_1 <= #var_32_1 then
			return var_32_1
		end

		var_32_0 = var_32_0 + 1

		if #self < var_32_0 then
			var_32_0 = 1
		end
	end

	return var_32_1
end

function var_0_7:getSortBuffList3(arg_33_1, arg_33_2)
	if #self <= arg_33_1 then
		return self
	end

	local var_33_0 = var_0_7.random(1, #self, arg_33_2)
	local var_33_1 = {}

	for iter_33_0 = 1, #self do
		if self[var_33_0].buffCfg.buff_type ~= 1 then
			var_0_5(var_33_1, self[var_33_0])
		end

		if arg_33_1 <= #var_33_1 then
			return var_33_1
		end

		var_33_0 = var_33_0 + 1

		if #self < var_33_0 then
			var_33_0 = 1
		end
	end

	for iter_33_1 = 1, #self do
		if self[var_33_0].buffCfg.buff_type == 1 then
			var_0_5(var_33_1, self[var_33_0])
		end

		if arg_33_1 <= #var_33_1 then
			return var_33_1
		end

		var_33_0 = var_33_0 + 1

		if #self < var_33_0 then
			var_33_0 = 1
		end
	end

	return var_33_1
end

function var_0_7.getSortBuffList4(arg_34_0, arg_34_1, arg_34_2)
	return var_0_7._getSortBuffListBuffType(arg_34_0, arg_34_1, arg_34_2, 3)
end

function var_0_7.getSortBuffList5(arg_35_0, arg_35_1, arg_35_2)
	return var_0_7._getSortBuffListBuffType(arg_35_0, arg_35_1, arg_35_2, 1)
end

function var_0_7:_getSortBuffListBuffType(arg_36_1, arg_36_2, arg_36_3)
	if #self <= arg_36_1 then
		return self
	end

	local var_36_0 = var_0_7.random(1, #self, arg_36_2)
	local var_36_1 = {}

	for iter_36_0 = 1, #self do
		if self[var_36_0].buffCfg.buff_type == arg_36_3 then
			var_0_5(var_36_1, self[var_36_0])
		end

		if arg_36_1 <= #var_36_1 then
			return var_36_1
		end

		var_36_0 = var_36_0 + 1

		if #self < var_36_0 then
			var_36_0 = 1
		end
	end

	for iter_36_1 = 1, #self do
		if self[var_36_0].buffCfg.buff_type ~= arg_36_3 then
			var_0_5(var_36_1, self[var_36_0])
		end

		if arg_36_1 <= #var_36_1 then
			return var_36_1
		end

		var_36_0 = var_36_0 + 1

		if #self < var_36_0 then
			var_36_0 = 1
		end
	end

	return var_36_1
end

function var_0_7:getFrontRow(arg_37_1, arg_37_2)
	local var_37_0 = {}
	local var_37_1 = self:getKnights()
	local var_37_2 = false

	for iter_37_0 = 1, 3 do
		local var_37_3 = var_37_1:getKnightByIdAndPos(arg_37_1, iter_37_0)

		if var_37_3 and var_37_3:isValid(arg_37_2) then
			var_37_2 = true

			var_0_3.insert(var_37_0, var_37_3)
		end
	end

	if not var_37_2 then
		for iter_37_1 = 4, 6 do
			local var_37_4 = var_37_1:getKnightByIdAndPos(arg_37_1, iter_37_1)

			if var_37_4 and var_37_4:isValid(arg_37_2) then
				var_0_3.insert(var_37_0, var_37_4)
			end
		end
	end

	return var_37_0
end

function var_0_7:getBackRow(arg_38_1, arg_38_2)
	local var_38_0 = {}
	local var_38_1 = self:getKnights()
	local var_38_2 = false

	for iter_38_0 = 4, 6 do
		local var_38_3 = var_38_1:getKnightByIdAndPos(arg_38_1, iter_38_0)

		if var_38_3 and var_38_3:isValid(arg_38_2) then
			var_38_2 = true

			var_0_3.insert(var_38_0, var_38_3)
		end
	end

	if not var_38_2 then
		for iter_38_1 = 1, 3 do
			local var_38_4 = var_38_1:getKnightByIdAndPos(arg_38_1, iter_38_1)

			if var_38_4 and var_38_4:isValid(arg_38_2) then
				var_0_3.insert(var_38_0, var_38_4)
			end
		end
	end

	return var_38_0
end

return var_0_7
