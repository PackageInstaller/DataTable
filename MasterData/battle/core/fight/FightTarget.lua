local var_0_0 = math
local var_0_1 = math.floor
local var_0_2 = math.min
local var_0_3 = math.max
local var_0_4 = table
local var_0_5 = table.insert
local var_0_6 = table.remove
local var_0_7 = load("core.fight.FightCommon")
local var_0_8 = load("core.rule.BuffRule")
local var_0_9 = loadCfg("core.config.cfg.battle_extra_value_info")
local var_0_10 = {}

function var_0_10:getVictimTargets()
	local var_1_0 = {}
	local var_1_1 = self.attacker
	local var_1_2 = self.attacker.opIdentity
	local var_1_3 = self.attacker.identity
	local var_1_4 = self.battleData:getKnights()
	local var_1_5 = self.battleField
	local var_1_6 = (self.attacker.originInfo.pos - 1) % 3 + 1
	local var_1_7 = (self.attacker.originInfo.pos - 1) % 3 + 1 + 3

	local function var_1_8()
		local var_2_0 = {
			var_1_6,
			var_1_6 - 1,
			var_0_2(var_1_6 + 1, 3),
			var_1_6 - 2,
			var_0_2(var_1_6 + 2, 3),
			var_1_7,
			var_1_7 - 1,
			var_1_7 + 1,
			var_1_7 - 2,
			var_1_7 + 2
		}
		local var_2_1 = 1
		local var_2_2

		repeat
			var_2_2 = var_1_4:getKnightByIdAndPos(var_1_2, var_2_0[var_2_1])
			var_2_1 = var_2_1 + 1
		until var_2_2 and var_2_2:isValid(var_1_1) or var_2_1 > #var_2_0

		return var_2_2
	end

	if not self.attacker.isPlayer and self.affectType == 1 then
		local var_1_10 = var_1_1:doBuff(var_0_8.TYPE.BUFF_TAUNT, {})
		local var_1_11 = var_1_1:doBuff(var_0_8.TYPE.TAUNT)

		if var_1_11 then
			local var_1_12 = true

			for iter_1_0, iter_1_1 in ipairs(var_1_10) do
				if iter_1_1.serialId == var_1_11.serialId then
					var_1_12 = false
				end
			end

			if var_1_12 then
				var_0_5(var_1_10, var_1_11)
			end
		end

		if next(var_1_10) then
			for iter_1_2, iter_1_3 in ipairs(var_1_10) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_3))
			end

			return var_1_0
		end
	end

	local var_1_13 = self.range
	local var_1_14 = self.range_value or 1

	self.range_value = var_1_14

	if var_1_13 == 1 then
		local var_1_15 = var_1_8()

		if var_1_15 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_15))
		end
	elseif var_1_13 == 2 then
		local var_1_16 = {
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3,
			var_0_3((self.attacker.originInfo.pos - 1) % 3 + 1 + 3 - 1, 4),
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3 + 1,
			var_0_3((self.attacker.originInfo.pos - 1) % 3 + 1 + 3 - 2, 4),
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3 + 2,
			(self.attacker.originInfo.pos - 1) % 3 + 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 - 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 - 2,
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 2
		}
		local var_1_17 = 1
		local var_1_18

		repeat
			var_1_18 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_16[var_1_17])
			var_1_17 = var_1_17 + 1
		until var_1_18 and var_1_18:isValid(var_1_1) or var_1_17 > #var_1_16

		if var_1_18 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_18))
		end
	elseif var_1_13 == 3 then
		var_1_0 = var_0_7.getRandomNTargets(self, var_1_2, 1)
	elseif var_1_13 == 4 then
		local var_1_19 = var_1_8()

		if var_1_19 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_19))

			if var_1_19.originInfo.pos <= 3 then
				local var_1_20 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_19.originInfo.pos + 3)

				if var_1_20 and var_1_20:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_20))
				end
			end
		end
	elseif var_1_13 == 5 then
		var_1_0 = var_0_7.getRandomNTargets(self, var_1_2, 2)
	elseif var_1_13 == 6 then
		local var_1_21 = {}

		for iter_1_4 = 1, 3 do
			local var_1_22 = 0

			for iter_1_5 = 1, 2 do
				local var_1_23 = var_1_4:getKnightByIdAndPos(var_1_2, (iter_1_5 - 1) * 3 + iter_1_4)

				if var_1_23 and var_1_23:isValid(var_1_1) then
					var_1_22 = var_1_22 + 1
				end
			end

			if var_1_22 == 2 then
				var_1_21[#var_1_21 + 1] = iter_1_4
			end
		end

		if #var_1_21 > 0 then
			local var_1_24 = var_0_7.random(1, #var_1_21, var_1_5)

			var_0_5(var_1_0, var_0_7.createVictimTarget((var_1_4:getKnightByIdAndPos(var_1_2, var_1_21[var_1_24]))))
			var_0_5(var_1_0, var_0_7.createVictimTarget((var_1_4:getKnightByIdAndPos(var_1_2, var_1_21[var_1_24] + 3))))
		else
			local var_1_25 = {}

			for iter_1_6 = 1, 3 do
				local var_1_26 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_6)

				if var_1_26 and var_1_26:isValid(var_1_1) then
					var_0_5(var_1_25, var_1_26)
				end
			end

			if #var_1_25 == 0 then
				for iter_1_7 = 4, 6 do
					local var_1_27 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_7)

					if var_1_27 and var_1_27:isValid(var_1_1) then
						var_0_5(var_1_25, var_1_27)
					end
				end
			end

			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_25[var_0_7.random(1, #var_1_25, var_1_5)]))
		end
	elseif var_1_13 == 7 then
		for iter_1_8 = 1, 3 do
			local var_1_28 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_8)

			if var_1_28 and var_1_28:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_28))
			end
		end

		if #var_1_0 == 0 then
			for iter_1_9 = 4, 6 do
				local var_1_29 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_9)

				if var_1_29 and var_1_29:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_29))
				end
			end
		end
	elseif var_1_13 == 8 then
		for iter_1_10 = 4, 6 do
			local var_1_30 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_10)

			if var_1_30 and var_1_30:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_30))
			end
		end

		if #var_1_0 == 0 then
			for iter_1_11 = 1, 3 do
				local var_1_31 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_11)

				if var_1_31 and var_1_31:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_31))
				end
			end
		end
	elseif var_1_13 == 9 then
		var_1_0 = var_0_7.getRandomNTargets(self, var_1_2, 3)
	elseif var_1_13 == 10 then
		local var_1_32 = var_1_8()

		if var_1_32 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_32))

			local var_1_33 = {
				var_1_32.originInfo.pos - 3,
				var_1_32.originInfo.pos + 3
			}

			if var_1_32.originInfo.pos ~= 4 then
				var_1_33[#var_1_33 + 1] = var_1_32.originInfo.pos - 1
			end

			if var_1_32.originInfo.pos ~= 3 then
				var_1_33[#var_1_33 + 1] = var_1_32.originInfo.pos + 1
			end

			for iter_1_12 = 1, #var_1_33 do
				local var_1_34 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_33[iter_1_12])

				if var_1_34 and var_1_34:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_34))
				end
			end
		end
	elseif var_1_13 == 11 then
		var_1_0 = var_0_7.getRandomNTargets(self, var_1_2, 4)
	elseif var_1_13 == 12 then
		local var_1_35 = {}

		for iter_1_13 = 1, 3 do
			local var_1_36 = 0

			for iter_1_14 = 1, 2 do
				local var_1_37 = var_1_4:getKnightByIdAndPos(var_1_2, (iter_1_14 - 1) * 3 + iter_1_13)

				if var_1_37 and var_1_37:isValid(var_1_1) then
					var_1_36 = var_1_36 + 1
				end
			end

			if var_1_36 == 0 then
				var_1_35[#var_1_35 + 1] = iter_1_13
			end
		end

		if #var_1_35 == 0 then
			for iter_1_15 = 1, 3 do
				local var_1_38 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_15)

				if not var_1_38 or not var_1_38:isValid(var_1_1) then
					var_1_35[#var_1_35 + 1] = iter_1_15
				end
			end

			if #var_1_35 == 0 then
				for iter_1_16 = 4, 6 do
					local var_1_39 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_16)

					if not var_1_39 or not var_1_39:isValid() then
						var_1_35[#var_1_35 + 1] = iter_1_16 - 3
					end
				end
			end

			if #var_1_35 == 0 then
				var_1_35 = {
					1,
					2,
					3
				}
			end
		end

		local var_1_40 = var_0_7.random(1, #var_1_35, var_1_5)

		for iter_1_17 = 1, 3 do
			if iter_1_17 ~= var_1_35[var_1_40] then
				local var_1_41 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_17)

				if var_1_41 and var_1_41:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_41))
				end

				local var_1_42 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_17 + 3)

				if var_1_42 and var_1_42:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_42))
				end
			end
		end
	elseif var_1_13 == 13 then
		local var_1_43 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

		for iter_1_18 = 1, #var_1_43 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_43[iter_1_18]))
		end
	elseif var_1_13 == 14 then
		var_0_5(var_1_0, var_0_7.createVictimTarget((var_0_7.getRandomMaxTargets(self, var_1_2, "hpRate", false))))
	elseif var_1_13 == 15 then
		local var_1_44 = var_0_7.getRandomMaxTargets2(self, var_1_2, "hpRate", false)

		for iter_1_19 = 1, #var_1_44 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_44[iter_1_19]))
		end
	elseif var_1_13 == 16 then
		local var_1_45 = var_0_7.getRandomMaxTargets(self, var_1_2, "hpRate", true)

		if var_1_45 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_45))
		end
	elseif var_1_13 == 17 then
		local var_1_46 = var_0_7.getRandomMaxTargets(self, var_1_2, "hpRate", true)

		if var_1_46 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_46))

			local var_1_47 = var_1_4:getKnightByIdAndPos(var_1_2, (var_1_46.originInfo.pos < 4 or nil) and (var_1_46.originInfo.pos + 3 or var_1_46.originInfo.pos - 3))

			if var_1_47 and var_1_47:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_47))
			end
		end
	elseif var_1_13 == 18 then
		local var_1_48 = var_0_7.getRandomMaxTargets(self, var_1_2, "hpRate", true)

		if var_1_48 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_48))

			local var_1_49 = {}

			if var_1_48.originInfo.pos ~= 4 then
				var_1_49[#var_1_49 + 1] = var_1_48.originInfo.pos - 1
			end

			var_1_49[#var_1_49 + 1] = var_1_48.originInfo.pos + 3

			if var_1_48.originInfo.pos ~= 3 then
				var_1_49[#var_1_49 + 1] = var_1_48.originInfo.pos + 1
			end

			var_1_49[#var_1_49 + 1] = var_1_48.originInfo.pos - 3

			for iter_1_20 = 1, #var_1_49 do
				local var_1_50 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_49[iter_1_20])

				if var_1_50 and var_1_50:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_50))
				end
			end
		end
	elseif var_1_13 == 19 then
		local var_1_51 = var_0_7.getRandomMaxTargets(self, var_1_2, "INITIAL_ANGER", true)

		if var_1_51 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_51))
		end
	elseif var_1_13 == 20 then
		local var_1_52 = var_0_7.getRandomMaxTargets(self, var_1_2, "INITIAL_ANGER", true)

		if var_1_52 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_52))

			local var_1_53 = var_1_4:getKnightByIdAndPos(var_1_2, (var_1_52.originInfo.pos < 4 or nil) and (var_1_52.originInfo.pos + 3 or var_1_52.originInfo.pos - 3))

			if var_1_53 and var_1_53:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_53))
			end
		end
	elseif var_1_13 == 21 then
		local var_1_54 = var_0_7.getRandomMaxTargets(self, var_1_2, "INITIAL_ANGER", true)

		if var_1_54 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_54))

			local var_1_55 = {}

			if var_1_54.originInfo.pos ~= 4 then
				var_1_55[#var_1_55 + 1] = var_1_54.originInfo.pos - 1
			end

			var_1_55[#var_1_55 + 1] = var_1_54.originInfo.pos + 3

			if var_1_54.originInfo.pos ~= 3 then
				var_1_55[#var_1_55 + 1] = var_1_54.originInfo.pos + 1
			end

			var_1_55[#var_1_55 + 1] = var_1_54.originInfo.pos - 3

			for iter_1_21 = 1, #var_1_55 do
				local var_1_56 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_55[iter_1_21])

				if var_1_56 and var_1_56:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_56))
				end
			end
		end
	elseif var_1_13 == 22 then
		local var_1_57 = #self.battleData:getKnightList(var_1_2, nil, var_1_1)

		if var_1_57 == 6 then
			local var_1_58 = var_0_7.getRandomMaxTargets2(self, var_1_2, "INITIAL_ANGER", false)

			for iter_1_22 = 1, 6 do
				if iter_1_22 ~= var_1_58[1].originInfo.pos and iter_1_22 ~= var_1_58[2].originInfo.pos then
					local var_1_59 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_22)

					if var_1_59 and var_1_59:isValid(var_1_1) then
						var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_59))
					end
				end
			end
		elseif var_1_57 == 5 then
			local var_1_60 = var_0_7.getRandomMaxTargets(self, var_1_2, "INITIAL_ANGER", false)

			for iter_1_23 = 1, 6 do
				if iter_1_23 ~= var_1_60.originInfo.pos then
					local var_1_61 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_23)

					if var_1_61 and var_1_61:isValid(var_1_1) then
						var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_61))
					end
				end
			end
		else
			for iter_1_24 = 1, 6 do
				local var_1_62 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_24)

				if var_1_62 and var_1_62:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_62))
				end
			end
		end
	elseif var_1_13 == 23 then
		local var_1_63 = var_0_7.getRandomMaxTargets(self, var_1_2, "totalDef", true)

		if var_1_63 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_63))
		end
	elseif var_1_13 == 24 then
		local var_1_64 = var_0_7.getRandomMaxTargets(self, var_1_2, "totalDef", true)

		if var_1_64 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_64))

			local var_1_65 = var_1_4:getKnightByIdAndPos(var_1_2, (var_1_64.originInfo.pos < 4 or nil) and (var_1_64.originInfo.pos + 3 or var_1_64.originInfo.pos - 3))

			if var_1_65 and var_1_65:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_65))
			end
		end
	elseif var_1_13 == 25 then
		local var_1_66 = var_0_7.getRandomMaxTargets(self, var_1_2, "totalDef", true)

		if var_1_66 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_66))

			local var_1_67 = {}

			if var_1_66.originInfo.pos ~= 4 then
				var_1_67[#var_1_67 + 1] = var_1_66.originInfo.pos - 1
			end

			var_1_67[#var_1_67 + 1] = var_1_66.originInfo.pos + 3

			if var_1_66.originInfo.pos ~= 3 then
				var_1_67[#var_1_67 + 1] = var_1_66.originInfo.pos + 1
			end

			var_1_67[#var_1_67 + 1] = var_1_66.originInfo.pos - 3

			for iter_1_25 = 1, #var_1_67 do
				local var_1_68 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_67[iter_1_25])

				if var_1_68 and var_1_68:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_68))
				end
			end
		end
	elseif var_1_13 == 26 then
		var_0_5(var_1_0, var_0_7.createVictimTarget((var_0_7.getRandomMaxTargets(self, var_1_2, "totalAtk", true))))
	elseif var_1_13 == 27 then
		local var_1_69 = var_0_7.getRandomMaxTargets(self, var_1_2, "totalAtk", true)

		if var_1_69 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_69))

			local var_1_70 = var_1_4:getKnightByIdAndPos(var_1_2, (var_1_69.originInfo.pos < 4 or nil) and (var_1_69.originInfo.pos + 3 or var_1_69.originInfo.pos - 3))

			if var_1_70 and var_1_70:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_70))
			end
		end
	elseif var_1_13 == 28 then
		local var_1_71 = var_0_7.getRandomMaxTargets(self, var_1_2, "totalAtk", true)

		if var_1_71 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_71))

			local var_1_72 = {}

			if var_1_71.originInfo.pos ~= 4 then
				var_1_72[#var_1_72 + 1] = var_1_71.originInfo.pos - 1
			end

			var_1_72[#var_1_72 + 1] = var_1_71.originInfo.pos + 3

			if var_1_71.originInfo.pos ~= 3 then
				var_1_72[#var_1_72 + 1] = var_1_71.originInfo.pos + 1
			end

			var_1_72[#var_1_72 + 1] = var_1_71.originInfo.pos - 3

			for iter_1_26 = 1, #var_1_72 do
				local var_1_73 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_72[iter_1_26])

				if var_1_73 and var_1_73:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_73))
				end
			end
		end
	elseif var_1_13 == 29 then
		local var_1_74 = var_0_7.getMaxTargetsN(self, var_1_2, "hpRate", true, 3)

		for iter_1_27 = 1, #var_1_74 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_74[iter_1_27]))
		end
	elseif var_1_13 == 30 then
		local var_1_75 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

		for iter_1_28 = 1, #var_1_75 do
			if var_1_75[iter_1_28]:hasBuffByEffectType(var_0_8.EFFECT_TYPE.BURNING) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_75[iter_1_28]))
			end
		end
	elseif var_1_13 == 31 then
		local var_1_76 = self.battleData:getKnightList(var_1_2, nil, var_1_1)[1]

		if var_1_76 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_76))
		end
	elseif var_1_13 == 32 then
		local var_1_77 = self.battleData:getKnightList(var_1_2, nil, var_1_1)
		local var_1_78 = -1
		local var_1_79 = {}

		for iter_1_29 = 1, #var_1_77 do
			local var_1_80 = var_1_77[iter_1_29]:getMarkLevel(1)

			if var_1_78 < var_1_80 then
				var_1_78 = var_1_80
				var_1_79 = {
					iter_1_29
				}
			elseif var_1_80 == var_1_78 then
				var_0_5(var_1_79, iter_1_29)
			end
		end

		if next(var_1_79) then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_77[var_1_79[var_0_7.random(1, #var_1_79, var_1_5)]]))
		end
	elseif var_1_13 == 33 then
		local var_1_81 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

		if #var_1_81 <= 2 then
			for iter_1_30 = 1, #var_1_81 do
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_81[iter_1_30]))
			end
		else
			local var_1_82 = {}

			for iter_1_31 = 1, #var_1_81 do
				var_1_82[iter_1_31] = iter_1_31
			end

			local var_1_83 = var_0_7.getRandomN(var_1_82, #var_1_82, var_1_5)

			for iter_1_32 = 1, 2 do
				for iter_1_33 = #var_1_81 - 1, iter_1_32, -1 do
					if var_1_81[var_1_83[iter_1_33 + 1]]:getMarkLevel(1) > var_1_81[var_1_83[iter_1_33]]:getMarkLevel(1) then
						var_1_83[iter_1_33 + 1] = var_1_83[iter_1_33]
						var_1_83[iter_1_33] = var_1_83[iter_1_33 + 1]
					end
				end
			end

			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_81[var_1_83[1]]))
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_81[var_1_83[2]]))
		end
	elseif var_1_13 == 34 then
		local var_1_84 = var_0_7.getMaxTargetsN(self, var_1_2, "INITIAL_HP", true, 2)

		for iter_1_34 = 1, #var_1_84 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_84[iter_1_34]))
		end
	elseif var_1_13 == 35 then
		local var_1_85 = self.battleData:getKnightList(var_1_2, nil, var_1_1)
		local var_1_86 = -1
		local var_1_87 = {}

		for iter_1_35 = 1, #var_1_85 do
			local var_1_88 = var_1_85[iter_1_35]:getMarkLevel(7)

			if var_1_86 < var_1_88 then
				var_1_86 = var_1_88
				var_1_87 = {
					iter_1_35
				}
			elseif var_1_88 == var_1_86 then
				var_0_5(var_1_87, iter_1_35)
			end
		end

		if next(var_1_87) then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_85[var_1_87[var_0_7.random(1, #var_1_87, var_1_5)]]))
		end
	elseif var_1_13 == 36 then
		for iter_1_36, iter_1_37 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			for iter_1_38, iter_1_39 in ipairs((iter_1_37:getBuffs())) do
				if iter_1_39.buffCfg.buff_control_type == 1 then
					var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_37))

					break
				end
			end
		end
	elseif var_1_13 == 37 then
		local var_1_89 = var_0_7.getMaxTargetsN(self, var_1_2, "hpRate", false, 3)

		for iter_1_40 = 1, #var_1_89 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_89[iter_1_40]))
		end
	elseif var_1_13 == 38 then
		local var_1_90 = var_0_7.getMaxTargetsN(self, var_1_2, "hpRate", false, 4)

		for iter_1_41 = 1, #var_1_90 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_90[iter_1_41]))
		end
	elseif var_1_13 == 39 then
		local var_1_91 = {}

		for iter_1_42 = 1, 3 do
			local var_1_92 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_42)

			if var_1_92 and var_1_92:isValid(var_1_1) then
				var_0_5(var_1_91, var_1_92)
			end
		end

		if #var_1_91 == 0 then
			for iter_1_43 = 4, 6 do
				local var_1_93 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_43)

				if var_1_93 and var_1_93:isValid(var_1_1) then
					var_0_5(var_1_91, var_1_93)
				end
			end
		end

		local var_1_94 = var_0_7.getRandomMaxTargetsGroup(var_1_91, "ATTACK", true, var_1_5)

		if var_1_94 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_94))
		end
	elseif var_1_13 == 40 then
		local var_1_95 = {}

		for iter_1_44 = 1, 3 do
			local var_1_96 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_44)

			if var_1_96 and var_1_96:isValid(var_1_1) then
				var_0_5(var_1_95, var_1_96)
			end
		end

		if #var_1_95 == 0 then
			for iter_1_45 = 4, 6 do
				local var_1_97 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_45)

				if var_1_97 and var_1_97:isValid(var_1_1) then
					var_0_5(var_1_95, var_1_97)
				end
			end
		end

		local var_1_98 = var_0_7.getRandomMaxTargets2Group(var_1_95, "ATTACK", true, var_1_5)

		for iter_1_46 = 1, #var_1_98 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_98[iter_1_46]))
		end
	elseif var_1_13 == 41 then
		for iter_1_47, iter_1_48 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_48.baseInfo.SHIELD > 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_48))
			end
		end
	elseif var_1_13 == 42 then
		var_1_0 = var_0_7.getRandomNTargets(self, var_1_2, 2)
	elseif var_1_13 == 43 then
		local var_1_99 = var_0_7.getRandomMaxTargets(self, var_1_2, "totalAtk", true)

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_99))

		local var_1_100 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

		if #var_1_100 > 1 then
			local var_1_101 = var_0_7.random(1, #var_1_100 - 1, self.battleField)

			for iter_1_49, iter_1_50 in ipairs(var_1_100) do
				if iter_1_50.serialId ~= var_1_99.serialId then
					var_1_101 = var_1_101 - 1

					if var_1_101 == 0 then
						var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_50))

						break
					end
				end
			end
		end
	elseif var_1_13 == 44 then
		for iter_1_51, iter_1_52 in ipairs((self.battleData:getNearKnightList((var_0_7.getRandomMaxTargets(self, var_1_2, "totalAtk", true))))) do
			var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_52))
		end
	elseif var_1_13 == 45 then
		local var_1_102 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

		for iter_1_53 = 1, #var_1_102 do
			if var_1_102[iter_1_53]:hasBuffByEffectType(var_0_8.EFFECT_TYPE.TREE_BIND) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_102[iter_1_53]))
			end
		end
	elseif var_1_13 == 46 then
		local var_1_103 = var_0_7.getSpKnights(self, var_1_2, "hpRate", 999, false)

		for iter_1_54 = 1, #var_1_103 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_103[iter_1_54]))
		end
	elseif var_1_13 == 47 then
		local var_1_104 = {}

		for iter_1_55, iter_1_56 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			local var_1_105 = false

			for iter_1_57, iter_1_58 in ipairs((iter_1_56:getBuffs())) do
				if iter_1_58.buffCfg.buff_control_type == 1 then
					var_1_105 = true

					break
				end
			end

			if not var_1_105 then
				var_0_5(var_1_104, iter_1_56)
			end
		end

		if next(var_1_104) then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_104[var_0_7.random(1, #var_1_104, var_1_5)]))
		end
	elseif var_1_13 == 48 then
		local var_1_106 = var_0_7.getRandomMaxTargets(self, var_1_2, "totalAtk", true)

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_106))

		if var_1_106 then
			local var_1_107 = {}

			for iter_1_59, iter_1_60 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
				if iter_1_60.serialId ~= var_1_106.serialId then
					var_0_5(var_1_107, iter_1_60)
				end
			end

			for iter_1_61, iter_1_62 in ipairs((var_0_7.getRandomN(var_1_107, 2, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_62))
			end
		end
	elseif var_1_13 == 49 then
		local var_1_108 = var_0_7.getRandomMaxTargets2(self, var_1_2, "ATTACK", true)

		for iter_1_63 = 1, #var_1_108 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_108[iter_1_63]))
		end
	elseif var_1_13 == 50 then
		local var_1_109 = {}
		local var_1_110 = {}

		for iter_1_64, iter_1_65 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_65:getBuffCount(1001) == 0 then
				var_0_5(var_1_109, iter_1_65)
			else
				var_0_5(var_1_110, iter_1_65)
			end
		end

		while var_1_14 < #var_1_109 do
			var_0_6(var_1_109, (var_0_7.random(1, #var_1_109, var_1_5)))
		end

		while var_1_14 > #var_1_109 and #var_1_110 > 0 do
			local var_1_111 = var_0_7.random(1, #var_1_110, var_1_5)

			var_0_5(var_1_109, var_1_110[var_1_111])
			var_0_6(var_1_110, var_1_111)
		end

		for iter_1_66 = 1, #var_1_109 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_109[iter_1_66]))
		end
	elseif var_1_13 == 51 then
		local var_1_112 = {}
		local var_1_113 = {}

		for iter_1_67, iter_1_68 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_68.baseInfo.INITIAL_ANGER >= 4 then
				var_0_4.insert(var_1_112, iter_1_68)
			else
				var_0_4.insert(var_1_113, iter_1_68)
			end
		end

		if var_1_14 <= #var_1_112 then
			for iter_1_69, iter_1_70 in ipairs((var_0_7.getRandomN(var_1_112, var_1_14, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_70))
			end
		else
			for iter_1_71, iter_1_72 in ipairs(var_1_112) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_72))
			end

			for iter_1_73, iter_1_74 in ipairs((var_0_7.getRandomN(var_1_113, var_1_14 - #var_1_0, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_74))
			end
		end
	elseif var_1_13 == 52 then
		for iter_1_75, iter_1_76 in ipairs({
			1,
			2,
			3,
			5
		}) do
			local var_1_114 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_76)

			if var_1_114 and var_1_114:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_114))
			end
		end
	elseif var_1_13 == 53 then
		local var_1_115 = {
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3,
			var_0_3((self.attacker.originInfo.pos - 1) % 3 + 1 + 3 - 1, 4),
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3 + 1,
			var_0_3((self.attacker.originInfo.pos - 1) % 3 + 1 + 3 - 2, 4),
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3 + 2,
			(self.attacker.originInfo.pos - 1) % 3 + 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 - 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 - 2,
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 2
		}
		local var_1_116 = 1
		local var_1_117

		repeat
			var_1_117 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_115[var_1_116])
			var_1_116 = var_1_116 + 1
		until var_1_117 and var_1_117:isValid(var_1_1) or var_1_116 > #var_1_115

		if var_1_117 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_117))

			local var_1_118 = var_1_117.originInfo.pos
			local var_1_119 = var_1_117.originInfo.pos > 3 and 3 or 0

			for iter_1_77 = 1, 3 do
				local var_1_120 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_77 + var_1_119)

				if var_1_120 and var_1_120:isValid(var_1_1) and iter_1_77 + var_1_119 ~= var_1_118 then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_120))
				end
			end

			local var_1_121 = var_1_4:getKnightByIdAndPos(var_1_2, (var_1_118 < 4 or nil) and (var_1_118 + 3 or var_1_118 - 3))

			if var_1_121 and var_1_121:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_121))
			end
		end
	elseif var_1_13 == 54 then
		local var_1_122 = {
			(self.attacker.originInfo.pos - 1) % 3 + 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 - 1,
			var_0_2((self.attacker.originInfo.pos - 1) % 3 + 1 + 1, 3),
			(self.attacker.originInfo.pos - 1) % 3 + 1 - 2,
			var_0_2((self.attacker.originInfo.pos - 1) % 3 + 1 + 2, 3),
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3,
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3 - 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3 + 1,
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3 - 2,
			(self.attacker.originInfo.pos - 1) % 3 + 1 + 3 + 2
		}
		local var_1_123 = 1
		local var_1_124

		repeat
			var_1_124 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_122[var_1_123])
			var_1_123 = var_1_123 + 1
		until var_1_124 and var_1_124:isValid(var_1_1) or var_1_123 > #var_1_122

		if var_1_124 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_124))

			local var_1_125 = var_1_124.originInfo.pos
			local var_1_126 = var_1_124.originInfo.pos > 3 and 3 or 0

			for iter_1_78 = 1, 3 do
				local var_1_127 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_78 + var_1_126)

				if var_1_127 and var_1_127:isValid(var_1_1) and iter_1_78 + var_1_126 ~= var_1_125 then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_127))
				end
			end

			local var_1_128 = var_1_4:getKnightByIdAndPos(var_1_2, (var_1_125 < 4 or nil) and (var_1_125 + 3 or var_1_125 - 3))

			if var_1_128 and var_1_128:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_128))
			end
		end
	elseif var_1_13 == 55 then
		local var_1_129 = 0
		local var_1_130 = {}

		for iter_1_79, iter_1_80 in ipairs((var_1_5:getBattleData():getKnightList(var_1_2, nil, var_1_1))) do
			local var_1_131 = var_0_7.getAttackDis(var_1_1, iter_1_80)

			if var_1_129 <= var_1_131 and iter_1_80:getBuffCount(var_0_8.TYPE.HIDE, true) <= 0 then
				var_1_129 = var_1_131
				var_1_130 = {}

				var_0_5(var_1_130, iter_1_80)
			elseif var_1_131 == var_1_129 and iter_1_80:getBuffCount(var_0_8.TYPE.HIDE, true) <= 0 then
				var_0_5(var_1_130, iter_1_80)
			end
		end

		if #var_1_130 > 1 then
			if var_1_130[1].serialId > var_1_130[2].serialId then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_130[1]))
			else
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_130[2]))
			end
		elseif #var_1_130 == 1 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_130[1]))
		else
			var_1_0 = var_0_7.getRandomNTargets(self, var_1_2, 1)
		end
	elseif var_1_13 == 56 then
		local var_1_132 = var_1_5:getBattleData():getRandomTargetData(var_1_13, var_1_3, 1)

		if next(var_1_132) then
			local var_1_133, var_1_134 = var_0_7.getRangeKnights(var_1_132)

			for iter_1_81 = 1, #var_1_133 do
				if var_1_133[iter_1_81]:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_133[iter_1_81]))
				end
			end
		else
			var_1_0 = var_0_7.getRandomNTargets(self, var_1_2, var_1_14)

			var_1_5:getBattleData():setRandomTargetData(var_1_13, var_1_3, var_1_0, 1)
		end
	elseif var_1_13 == 57 then
		var_0_5(var_1_0, var_0_7.createVictimTarget((var_0_7.getRandomMaxTargets(self, var_1_2, "totalAtk", false))))
	elseif var_1_13 == 58 then
		for iter_1_82, iter_1_83 in ipairs((var_1_5:getBattleData():getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_83.knightCfg.attack_type == var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_83))
			end
		end
	elseif var_1_13 == 59 then
		local var_1_135 = {}
		local var_1_136 = {}

		for iter_1_84, iter_1_85 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_85:getBuffCount(1164) <= 0 then
				var_0_5(var_1_135, iter_1_85)
			else
				var_0_5(var_1_136, iter_1_85)
			end
		end

		while var_1_14 < #var_1_135 do
			var_0_6(var_1_135, (var_0_7.random(1, #var_1_135, var_1_5)))
		end

		while var_1_14 > #var_1_135 and #var_1_136 > 0 do
			local var_1_137 = var_0_7.random(1, #var_1_136, var_1_5)

			var_0_5(var_1_135, var_1_136[var_1_137])
			var_0_6(var_1_136, var_1_137)
		end

		for iter_1_86 = 1, #var_1_135 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_135[iter_1_86]))
		end
	elseif var_1_13 == 60 then
		local var_1_138 = var_0_7.getRandomKnight(self, var_1_2)

		if var_1_138 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_138))

			local var_1_139 = {}

			if var_1_138.originInfo.pos ~= 4 then
				var_1_139[#var_1_139 + 1] = var_1_138.originInfo.pos - 1
			end

			var_1_139[#var_1_139 + 1] = var_1_138.originInfo.pos + 3

			if var_1_138.originInfo.pos ~= 3 then
				var_1_139[#var_1_139 + 1] = var_1_138.originInfo.pos + 1
			end

			var_1_139[#var_1_139 + 1] = var_1_138.originInfo.pos - 3

			for iter_1_87 = 1, #var_1_139 do
				local var_1_140 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_139[iter_1_87])

				if var_1_140 and var_1_140:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_140))
				end
			end
		end
	elseif var_1_13 == 61 then
		local var_1_141 = var_1_5:getBattleData():getRandomTargetData(var_1_13, var_1_3, var_1_14)

		if next(var_1_141) then
			local var_1_142, var_1_143 = var_0_7.getRangeKnights(var_1_141)

			for iter_1_88 = 1, #var_1_142 do
				if var_1_142[iter_1_88]:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_142[iter_1_88]))
				end
			end
		else
			local var_1_144 = var_0_7.getRandomKnight(self, var_1_2)

			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_144))

			local var_1_145 = {}

			if var_1_144.originInfo.pos ~= 4 then
				var_1_145[#var_1_145 + 1] = var_1_144.originInfo.pos - 1
			end

			var_1_145[#var_1_145 + 1] = var_1_144.originInfo.pos + 3

			if var_1_144.originInfo.pos ~= 3 then
				var_1_145[#var_1_145 + 1] = var_1_144.originInfo.pos + 1
			end

			var_1_145[#var_1_145 + 1] = var_1_144.originInfo.pos - 3

			for iter_1_89 = 1, #var_1_145 do
				local var_1_146 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_145[iter_1_89])

				if var_1_146 and var_1_146:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_146))
				end
			end

			var_1_5:getBattleData():setRandomTargetData(var_1_13, var_1_3, var_1_0, var_1_14)
		end
	elseif var_1_13 == 62 then
		local var_1_147 = var_1_5:getBattleData():getKnightList(var_1_2, nil, var_1_1)

		for iter_1_90 = 1, #var_1_147 do
			if var_1_147[iter_1_90]:getBuffCount(var_1_14) > 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_147[iter_1_90]))
			end
		end
	elseif var_1_13 == 63 then
		local var_1_148 = var_1_5:getBattleData():getKnightList(var_1_2, nil, var_1_1)

		for iter_1_91 = 1, #var_1_148 do
			if var_1_148[iter_1_91].knightCfg.profession == var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_148[iter_1_91]))
			end
		end
	elseif var_1_13 == 64 then
		local var_1_149 = var_1_5:getBattleData():getKnightList(var_1_2, nil, var_1_1)

		for iter_1_92 = 1, #var_1_149 do
			if var_1_149[iter_1_92].knightCfg.profession ~= var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_149[iter_1_92]))
			end
		end
	elseif var_1_13 == 65 then
		local var_1_150 = var_1_5:getBattleData():getKnightList(var_1_2, nil, var_1_1)

		for iter_1_93 = 1, #var_1_150 do
			if var_1_150[iter_1_93].knightCfg.group == var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_150[iter_1_93]))
			end
		end
	elseif var_1_13 == 66 then
		local var_1_151 = var_1_5:getBattleData():getKnightList(var_1_2, nil, var_1_1)

		for iter_1_94 = 1, #var_1_151 do
			if var_1_151[iter_1_94].knightCfg.group ~= var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_151[iter_1_94]))
			end
		end
	elseif var_1_13 == 67 then
		local var_1_152 = var_1_5:getBattleData():getKnightList(var_1_2, nil, var_1_1)

		for iter_1_95 = 1, #var_1_152 do
			if var_1_152[iter_1_95]:getBuffCount(var_0_8.COUNT_TYPE.ATTR_NEGATIVE) > 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_152[iter_1_95]))
			end
		end
	elseif var_1_13 == 68 then
		local var_1_153 = var_0_7.getMaxTargetsNGroup(self.battleData:getKnightList(var_1_2, nil, var_1_1), "INITIAL_HP", true, var_1_14, var_1_5)

		for iter_1_96 = 1, #var_1_153 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_153[iter_1_96]))
		end
	elseif var_1_13 == 69 then
		local var_1_154 = {}
		local var_1_155 = self.skillCfg or {}

		for iter_1_97, iter_1_98 in ipairs(self.battleData:getKnightList(var_1_2, nil, var_1_1)) do
			if not iter_1_98:doBuff(var_0_8.TYPE.HIDE, false, {
				attacker = var_1_1,
				victim = iter_1_98,
				skillType = var_1_155.skill_type
			}) then
				var_0_4.insert(var_1_154, iter_1_98)
			end
		end

		local var_1_156 = var_0_7.getMaxTargetsNGroup(var_1_154, "INITIAL_HP", false, var_1_14, var_1_5)

		for iter_1_99 = 1, #var_1_156 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_156[iter_1_99]))
		end
	elseif var_1_13 == 70 then
		for iter_1_100, iter_1_101 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if var_1_14 > iter_1_101:getHpRate() then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_101))
			end
		end
	elseif var_1_13 == 71 then
		local var_1_157 = var_0_7.getMaxTargetsNGroup(self.battleData:getKnightList(var_1_2, nil, var_1_1), "INITIAL_HP", false, 1, var_1_5)

		if #var_1_157 > 0 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_157[1]))

			local var_1_158 = var_1_4:getKnightByIdAndPos(var_1_2, (var_1_157[1].originInfo.pos < 4 or nil) and (var_1_157[1].originInfo.pos + 3 or var_1_157[1].originInfo.pos - 3))

			if var_1_158 and var_1_158:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_158))
			end
		end
	elseif var_1_13 == 72 then
		local var_1_159 = {}

		for iter_1_102, iter_1_103 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_103:getBuffCount(1243) > 0 then
				var_0_5(var_1_159, iter_1_103)
			end
		end

		if var_1_14 >= #var_1_159 then
			for iter_1_104, iter_1_105 in ipairs(var_1_159) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_105))
			end
		else
			for iter_1_106, iter_1_107 in ipairs((var_0_7.getRandomN(var_1_159, var_1_14, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_107))
			end
		end
	elseif var_1_13 == 73 then
		if ((var_1_1.isPlayer or nil) and var_0_7.getRandomKnight(self, var_1_3)).originInfo.pos < 4 then
			local var_1_161 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

			for iter_1_108 = 1, #var_1_161 do
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_161[iter_1_108]))
			end
		else
			for iter_1_109 = 1, 3 do
				local var_1_162 = var_1_4:getKnightByIdAndPos(var_1_2, iter_1_109)

				if var_1_162 and var_1_162:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_162))
				end
			end
		end
	elseif var_1_13 == 74 then
		for iter_1_110, iter_1_111 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_111.knightCfg.advance_id == var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_111))
			end
		end
	elseif var_1_13 == 75 then
		local var_1_163 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

		for iter_1_112 = 1, #var_1_163 do
			if var_1_163[iter_1_112].baseInfo.SHIELD == 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_163[iter_1_112]))
			end
		end
	elseif var_1_13 == 76 then
		local var_1_164 = 3
		local var_1_165 = self.battleData:getKnightList(var_1_2, nil, var_1_1)
		local var_1_166 = {}

		for iter_1_113 = 1, #var_1_165 do
			if var_1_165[iter_1_113]:getBuffCount(var_1_14, false, true) > 0 and var_1_164 > 0 then
				var_1_164 = var_1_164 - 1
				var_1_166[iter_1_113] = true

				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_165[iter_1_113]))
			end
		end

		if var_1_164 > 0 then
			for iter_1_114 = 1, #var_1_165 do
				if var_1_164 > 0 and not var_1_166[iter_1_114] then
					var_1_164 = var_1_164 - 1
					var_1_166[iter_1_114] = true

					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_165[iter_1_114]))
				end
			end
		end
	elseif var_1_13 == 77 then
		local var_1_167 = 0
		local var_1_168
		local var_1_169 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

		for iter_1_115 = 1, #var_1_169 do
			local var_1_170 = var_1_169[iter_1_115]:getBuffRecord(var_1_14) or 0

			if not var_1_168 or var_1_167 < var_1_170 then
				var_1_168 = var_1_169[iter_1_115]
				var_1_167 = var_1_170
			end
		end

		if var_1_168 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_168))
		end
	elseif var_1_13 == 78 then
		local var_1_171 = var_0_7.getRandomMaxTargets(self, var_1_2, "hpRate", false)

		if var_1_171 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_171))

			local var_1_172 = {}

			if var_1_171.originInfo.pos ~= 4 then
				var_1_172[#var_1_172 + 1] = var_1_171.originInfo.pos - 1
			end

			var_1_172[#var_1_172 + 1] = var_1_171.originInfo.pos + 3

			if var_1_171.originInfo.pos ~= 3 then
				var_1_172[#var_1_172 + 1] = var_1_171.originInfo.pos + 1
			end

			var_1_172[#var_1_172 + 1] = var_1_171.originInfo.pos - 3

			for iter_1_116 = 1, #var_1_172 do
				local var_1_173 = var_1_4:getKnightByIdAndPos(var_1_2, var_1_172[iter_1_116])

				if var_1_173 and var_1_173:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_173))
				end
			end
		end
	elseif var_1_13 == 79 then
		local var_1_174 = var_0_7.getMaxTargetsN(self, var_1_2, "ATTACK", true, var_1_14)

		for iter_1_117 = 1, #var_1_174 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_174[iter_1_117]))
		end
	elseif var_1_13 == 80 then
		local var_1_175 = var_0_7.getMaxTargetsN(self, var_1_2, "INITIAL_ANGER", true, var_1_14)

		for iter_1_118 = 1, #var_1_175 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_175[iter_1_118]))
		end
	elseif var_1_13 == 81 then
		local var_1_176 = self.battleData:getKnightList(var_1_2, nil, var_1_1)

		for iter_1_119 = 1, #var_1_176 do
			if var_1_176[iter_1_119]:getBuffCount(230, true) > 0 or var_1_176[iter_1_119]:getBuffCount(231, true) > 0 or var_1_176[iter_1_119]:getBuffCount(232, true) > 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_176[iter_1_119]))
			end
		end
	elseif var_1_13 == 82 then
		local var_1_177 = self.battleData:getKnightList(var_1_2, nil, var_1_1)
		local var_1_178 = {}

		for iter_1_120, iter_1_121 in ipairs(var_1_5:getRecord()[var_1_2]) do
			var_1_178[iter_1_121.id] = iter_1_121
		end

		var_0_4.sort(var_1_177, function(arg_3_0, arg_3_1)
			if var_1_178[arg_3_0.knightCfg.id].dam ~= var_1_178[arg_3_1.knightCfg.id].dam then
				return var_1_178[arg_3_1.knightCfg.id].dam < var_1_178[arg_3_0.knightCfg.id].dam
			end

			return false
		end)

		for iter_1_122 = 1, var_1_14 < #var_1_177 and var_1_14 or #var_1_177 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_177[iter_1_122]))
		end
	elseif var_1_13 == 83 then
		local var_1_179 = {}

		for iter_1_123, iter_1_124 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_124.baseInfo.SHIELD > 0 then
				var_0_4.insert(var_1_179, iter_1_124)
			end
		end

		if var_1_14 >= #var_1_179 then
			for iter_1_125, iter_1_126 in ipairs(var_1_179) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_126))
			end
		else
			for iter_1_127, iter_1_128 in ipairs((var_0_7.getRandomN(var_1_179, var_1_14, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_128))
			end
		end
	elseif var_1_13 == 84 then
		local var_1_180 = var_0_7.getMaxTargetsN(self, var_1_2, "hpRate", true, var_1_14)

		for iter_1_129 = 1, #var_1_180 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_180[iter_1_129]))
		end
	elseif var_1_13 == 85 then
		local var_1_181 = {}
		local var_1_182 = {}

		for iter_1_130, iter_1_131 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_131:getBuffCount(251, true) == 0 then
				var_0_5(var_1_181, iter_1_131)
			else
				var_0_5(var_1_182, iter_1_131)
			end
		end

		while var_1_14 < #var_1_181 do
			var_0_6(var_1_181, (var_0_7.random(1, #var_1_181, var_1_5)))
		end

		while var_1_14 > #var_1_181 and #var_1_182 > 0 do
			local var_1_183 = var_0_7.random(1, #var_1_182, var_1_5)

			var_0_5(var_1_181, var_1_182[var_1_183])
			var_0_6(var_1_182, var_1_183)
		end

		for iter_1_132 = 1, #var_1_181 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_181[iter_1_132]))
		end
	elseif var_1_13 == 86 then
		local var_1_184 = var_0_7.getRateTargetsN(self, var_1_2, "hpRate", false, var_1_14)

		for iter_1_133 = 1, #var_1_184 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_184[iter_1_133]))
		end
	elseif var_1_13 == 87 then
		local var_1_185 = var_0_7.getRateTargetsN(self, var_1_2, "hpRate", true, var_1_14)

		for iter_1_134 = 1, #var_1_185 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_185[iter_1_134]))
		end
	elseif var_1_13 == 88 then
		local var_1_186 = 10000
		local var_1_187

		for iter_1_135, iter_1_136 in ipairs((self.battleData:getKnightList(var_1_2, nil, var_1_1))) do
			if iter_1_136.advanceInfo.hpRate < var_1_186 then
				var_1_186 = iter_1_136.advanceInfo.hpRate
				var_1_187 = iter_1_136
			end
		end

		if var_1_187 and var_1_186 <= var_1_14 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_187))
		end
	elseif var_1_13 == 101 then
		var_0_5(var_1_0, var_0_7.createVictimTarget((var_1_1.isPlayer or nil) and var_0_7.getRandomKnight(self, var_1_3)))
	elseif var_1_13 == 102 then
		local var_1_189 = var_1_1

		if var_1_1.isPlayer then
			var_1_189 = var_0_7.getRandomKnight(self, var_1_3)
		end

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_189))

		local var_1_190 = var_1_4:getKnightByIdAndPos(var_1_3, (var_1_189.originInfo.pos < 4 or nil) and (var_1_189.originInfo.pos + 3 or var_1_189.originInfo.pos - 3))

		if var_1_190 and var_1_190:isValid(var_1_1) then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_190))
		end
	elseif var_1_13 == 103 then
		local var_1_192 = ((var_1_1.isPlayer or nil) and var_0_7.getRandomKnight(self, var_1_3)).originInfo.pos > 3 and 3 or 0

		for iter_1_137 = 1, 3 do
			local var_1_193 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_137 + var_1_192)

			if var_1_193 and var_1_193:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_193))
			end
		end
	elseif var_1_13 == 104 then
		local var_1_194 = var_1_1

		if var_1_1.isPlayer then
			var_1_194 = var_0_7.getRandomKnight(self, var_1_3)
		end

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_194))

		local var_1_195 = {}

		if var_1_194.originInfo.pos ~= 4 then
			var_1_195[#var_1_195 + 1] = var_1_194.originInfo.pos - 1
		end

		var_1_195[#var_1_195 + 1] = var_1_194.originInfo.pos + 3

		if var_1_194.originInfo.pos ~= 3 then
			var_1_195[#var_1_195 + 1] = var_1_194.originInfo.pos + 1
		end

		var_1_195[#var_1_195 + 1] = var_1_194.originInfo.pos - 3

		for iter_1_138 = 1, #var_1_195 do
			local var_1_196 = var_1_4:getKnightByIdAndPos(var_1_3, var_1_195[iter_1_138])

			if var_1_196 and var_1_196:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_196))
			end
		end
	elseif var_1_13 == 105 then
		var_1_0 = var_0_7.getRandomNTargets(self, var_1_3, 1)
	elseif var_1_13 == 106 then
		var_1_0 = var_0_7.getRandomNTargets(self, var_1_3, 2)
	elseif var_1_13 == 107 then
		for iter_1_139 = 1, 3 do
			local var_1_197 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_139)

			if var_1_197 and var_1_197:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_197))
			end
		end

		if #var_1_0 == 0 then
			for iter_1_140 = 4, 6 do
				local var_1_198 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_140)

				if var_1_198 and var_1_198:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_198))
				end
			end
		end
	elseif var_1_13 == 108 then
		for iter_1_141 = 4, 6 do
			local var_1_199 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_141)

			if var_1_199 and var_1_199:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_199))
			end
		end

		if #var_1_0 == 0 then
			for iter_1_142 = 1, 3 do
				local var_1_200 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_142)

				if var_1_200 and var_1_200:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_200))
				end
			end
		end
	elseif var_1_13 == 109 then
		local var_1_201 = self.battleData:getKnightList(var_1_3, nil, var_1_1)

		for iter_1_143 = 1, #var_1_201 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_201[iter_1_143]))
		end
	elseif var_1_13 == 110 then
		var_0_5(var_1_0, var_0_7.createVictimTarget((var_0_7.getRandomMaxTargets(self, var_1_3, "hpRate", false))))
	elseif var_1_13 == 111 then
		local var_1_202 = var_0_7.getRandomMaxTargets2(self, var_1_3, "hpRate", false)

		for iter_1_144 = 1, #var_1_202 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_202[iter_1_144]))
		end
	elseif var_1_13 == 112 then
		local var_1_203 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 400, false)

		for iter_1_145 = 1, #var_1_203 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_203[iter_1_145]))
		end
	elseif var_1_13 == 113 then
		local var_1_204 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 500, false)

		for iter_1_146 = 1, #var_1_204 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_204[iter_1_146]))
		end
	elseif var_1_13 == 114 then
		local var_1_205 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 600, false)

		for iter_1_147 = 1, #var_1_205 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_205[iter_1_147]))
		end
	elseif var_1_13 == 115 then
		local var_1_206 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 800, false)

		for iter_1_148 = 1, #var_1_206 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_206[iter_1_148]))
		end
	elseif var_1_13 == 116 then
		local var_1_207 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 300, true)

		for iter_1_149 = 1, #var_1_207 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_207[iter_1_149]))
		end
	elseif var_1_13 == 117 then
		local var_1_208 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 500, true)

		for iter_1_150 = 1, #var_1_208 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_208[iter_1_150]))
		end
	elseif var_1_13 == 118 then
		local var_1_209 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 700, true)

		for iter_1_151 = 1, #var_1_209 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_209[iter_1_151]))
		end
	elseif var_1_13 == 119 then
		local var_1_210 = var_0_7.getGroup(self, var_1_3, 1)

		for iter_1_152 = 1, #var_1_210 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_210[iter_1_152]))
		end
	elseif var_1_13 == 120 then
		local var_1_211 = var_0_7.getGroup(self, var_1_3, 2)

		for iter_1_153 = 1, #var_1_211 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_211[iter_1_153]))
		end
	elseif var_1_13 == 121 then
		local var_1_212 = var_0_7.getGroup(self, var_1_3, 3)

		for iter_1_154 = 1, #var_1_212 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_212[iter_1_154]))
		end
	elseif var_1_13 == 122 then
		local var_1_213 = var_0_7.getGroup(self, var_1_3, 4)

		for iter_1_155 = 1, #var_1_213 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_213[iter_1_155]))
		end
	elseif var_1_13 == 123 then
		local var_1_214 = var_0_7.getMaxTargetsN(self, var_1_3, "hpRate", false, 3)

		for iter_1_156 = 1, #var_1_214 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_214[iter_1_156]))
		end
	elseif var_1_13 == 124 then
		local var_1_215 = self.battleData:getKnightList(var_1_3, nil, var_1_1)

		for iter_1_157 = 1, #var_1_215 do
			if var_1_215[iter_1_157]:getMarkLevel(2) >= 5 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_215[iter_1_157]))
			end
		end
	elseif var_1_13 == 125 then
		var_1_0 = var_0_7.getRandomNTargetsWithoutSelf(self, var_1_3, 1)

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_1))
	elseif var_1_13 == 126 then
		var_1_0 = var_0_7.getRandomNTargetsWithoutSelf(self, var_1_3, 2)

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_1))
	elseif var_1_13 == 127 then
		var_1_0 = var_0_7.getRandomNTargetsWithoutSelf(self, var_1_3, 3)

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_1))
	elseif var_1_13 == 128 then
		local var_1_216 = self.battleData:getKnightList(var_1_3, true, var_1_1)

		for iter_1_158 = 1, #var_1_216 do
			if var_1_216[iter_1_158].isDead then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_216[iter_1_158]))
			end
		end
	elseif var_1_13 == 129 then
		local var_1_217 = self.battleData:getKnightList(var_1_3, true, var_1_1)
		local var_1_218 = {}

		for iter_1_159 = 1, #var_1_217 do
			if var_1_217[iter_1_159].isDead then
				var_0_5(var_1_218, var_1_217[iter_1_159])
			end
		end

		if #var_1_218 > 0 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_218[var_0_7.random(1, #var_1_218, var_1_5)]))
		end
	elseif var_1_13 == 130 then
		local var_1_219 = self.battleData:getKnightList(var_1_3, true, var_1_1)
		local var_1_220 = {}

		for iter_1_160 = 1, #var_1_219 do
			if var_1_219[iter_1_160].isDead then
				var_0_5(var_1_220, var_1_219[iter_1_160])
			end
		end

		while #var_1_220 > 2 do
			var_0_6(var_1_220, (var_0_7.random(1, #var_1_220, var_1_5)))
		end

		for iter_1_161 = 1, #var_1_220 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_220[iter_1_161]))
		end
	elseif var_1_13 == 131 then
		local var_1_221 = self.battleData:getRebornKnights()

		for iter_1_162 = 1, #var_1_221 do
			if not var_1_221[iter_1_162].isDead and var_1_221[iter_1_162].identity == var_1_3 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_221[iter_1_162]))

				break
			end
		end
	elseif var_1_13 == 132 then
		local var_1_222 = 2
		local var_1_223 = self.battleData:getRebornKnights()

		for iter_1_163 = 1, #var_1_223 do
			if not var_1_223[iter_1_163].isDead and var_1_223[iter_1_163].identity == var_1_3 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_223[iter_1_163]))

				var_1_222 = var_1_222 - 1

				if var_1_222 == 0 then
					break
				end
			end
		end
	elseif var_1_13 == 133 then
		var_0_5(var_1_0, var_0_7.createVictimTarget((var_0_7.getRandomMaxTargets(self, var_1_3, "ATTACK", true))))
	elseif var_1_13 == 134 then
		local var_1_224 = load("core.ControlBuffWeight")
		local var_1_225 = 0
		local var_1_228 = {}

		for iter_1_164, iter_1_165 in ipairs((self.battleData:getKnightList(var_1_3))) do
			for iter_1_166, iter_1_167 in ipairs((iter_1_165:getBuffs())) do
				if iter_1_167.buffCfg.buff_control_type == 1 then
					var_1_225 = var_1_225 + var_1_224.getWeight(iter_1_167.buffCfg)

					var_0_5(var_1_228, {
						min = var_1_225,
						max = var_1_225,
						knight = iter_1_165
					})
				end
			end
		end

		local var_1_229 = var_1_5:boundedRandom(1, var_1_225)

		for iter_1_168, iter_1_169 in ipairs(var_1_228) do
			if var_1_229 > iter_1_169.min and var_1_229 <= iter_1_169.max then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_169.knight))

				break
			end
		end
	elseif var_1_13 == 135 then
		local var_1_230

		for iter_1_170, iter_1_171 in ipairs((self.battleData:getKnightList(var_1_3))) do
			if iter_1_171.serialId ~= var_1_1.serialId then
				var_1_230 = var_1_230 or iter_1_171

				if iter_1_171.advanceInfo.hpRate < var_1_230.advanceInfo.hpRate then
					var_1_230 = iter_1_171
				end
			end
		end

		if var_1_230 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_230))
		end
	elseif var_1_13 == 136 then
		var_1_0 = var_0_7.getRandomNTargets(self, var_1_3, 3)
	elseif var_1_13 == 137 then
		local var_1_231 = var_0_7.getRandomMaxTargets2(self, var_1_3, "ATTACK", true)

		for iter_1_172 = 1, #var_1_231 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_231[iter_1_172]))
		end
	elseif var_1_13 == 138 then
		local var_1_232 = var_1_4:getKnightByIdAndPos(var_1_3, (var_1_1.originInfo.pos < 4 or nil) and (var_1_1.originInfo.pos + 3 or var_1_1.originInfo.pos - 3))

		if var_1_232 and var_1_232:isValid(var_1_1) then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_232))
		end
	elseif var_1_13 == 139 then
		local var_1_233 = {}

		for iter_1_173 = 1, 3 do
			local var_1_234 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_173)

			if var_1_234 and var_1_234:isValid(var_1_1) then
				var_0_5(var_1_233, var_1_234)
			end
		end

		if #var_1_233 == 0 then
			for iter_1_174 = 4, 6 do
				local var_1_235 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_174)

				if var_1_235 and var_1_235:isValid(var_1_1) then
					var_0_5(var_1_233, var_1_235)
				end
			end
		end

		local var_1_236 = var_0_7.getRandomMaxTargetsGroup(var_1_233, "ATTACK", true, var_1_5)

		if var_1_236 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_236))
		end
	elseif var_1_13 == 140 then
		local var_1_237 = {}

		for iter_1_175 = 1, 3 do
			local var_1_238 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_175)

			if var_1_238 and var_1_238:isValid(var_1_1) then
				var_0_5(var_1_237, var_1_238)
			end
		end

		if #var_1_237 == 0 then
			for iter_1_176 = 4, 6 do
				local var_1_239 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_176)

				if var_1_239 and var_1_239:isValid(var_1_1) then
					var_0_5(var_1_237, var_1_239)
				end
			end
		end

		local var_1_240 = var_0_7.getRandomMaxTargets2Group(var_1_237, "ATTACK", true, var_1_5)

		for iter_1_177 = 1, #var_1_240 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_240[iter_1_177]))
		end
	elseif var_1_13 == 141 then
		local var_1_241 = false

		for iter_1_178 = 1, 3 do
			local var_1_242 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_178)

			if var_1_242 and var_1_242:isValid(var_1_1) then
				var_1_241 = true

				if var_1_1.serialId ~= var_1_242.serialId then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_242))
				end
			end
		end

		if not var_1_241 then
			for iter_1_179 = 4, 6 do
				local var_1_243 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_179)

				if var_1_243 and var_1_243:isValid(var_1_1) and var_1_1.serialId ~= var_1_243.serialId then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_243))
				end
			end
		end
	elseif var_1_13 == 142 then
		local var_1_244 = false

		for iter_1_180 = 4, 6 do
			local var_1_245 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_180)

			if var_1_245 and var_1_245:isValid(var_1_1) then
				var_1_244 = true

				if var_1_1.serialId ~= var_1_245.serialId then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_245))
				end
			end
		end

		if not var_1_244 then
			for iter_1_181 = 1, 3 do
				local var_1_246 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_181)

				if var_1_246 and var_1_246:isValid(var_1_1) and var_1_1.serialId ~= var_1_246.serialId then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_246))
				end
			end
		end
	elseif var_1_13 == 143 then
		local var_1_247 = self.battleData:getKnightList(var_1_3, nil, var_1_1)

		for iter_1_182, iter_1_183 in ipairs(var_1_247) do
			if iter_1_183.serialId == var_1_1.serialId then
				var_0_4.remove(var_1_247, iter_1_182)

				break
			end
		end

		local var_1_248 = var_0_7.getRandomMaxTargets2Group(var_1_247, "INITIAL_HP", true, var_1_5)

		for iter_1_184 = 1, #var_1_248 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_248[iter_1_184]))
		end
	elseif var_1_13 == 145 then
		for iter_1_185, iter_1_186 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_186:doBuff(var_0_8.TYPE.YANG) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_186))
			end
		end
	elseif var_1_13 == 146 then
		for iter_1_187, iter_1_188 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_188:doBuff(var_0_8.TYPE.YIN) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_188))
			end
		end
	elseif var_1_13 == 147 then
		for iter_1_189, iter_1_190 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			for iter_1_191, iter_1_192 in ipairs((iter_1_190:getBuffs())) do
				if iter_1_192.buffCfg.buff_type == var_0_8.TYPE.YIN or iter_1_192.buffCfg.buff_type == var_0_8.TYPE.YANG then
					var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_190))

					break
				end
			end
		end
	elseif var_1_13 == 148 then
		local var_1_249
		local var_1_250 = 0

		for iter_1_193, iter_1_194 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_194.serialId ~= var_1_1.serialId and var_1_250 < iter_1_194.advanceInfo.totalAtk then
				var_1_250 = iter_1_194.advanceInfo.totalAtk
				var_1_249 = iter_1_194
			end
		end

		if var_1_249 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_249))
		end
	elseif var_1_13 == 149 then
		local var_1_251 = self.battleData:getKnightList(var_1_3, nil, var_1_1)

		for iter_1_195, iter_1_196 in ipairs(var_1_251) do
			if iter_1_196.serialId == var_1_1.serialId then
				var_0_4.remove(var_1_251, iter_1_195)

				break
			end
		end

		local var_1_252 = var_0_7.getRandomMaxTargets2Group(var_1_251, "INITIAL_ANGER", false, var_1_5)

		for iter_1_197 = 1, #var_1_252 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_252[iter_1_197]))
		end
	elseif var_1_13 == 150 then
		for iter_1_198, iter_1_199 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_199.serialId ~= var_1_1.serialId then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_199))
			end
		end
	elseif var_1_13 == 151 then
		local var_1_253 = {}

		for iter_1_200, iter_1_201 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_201.serialId ~= var_1_1.serialId then
				var_0_4.insert(var_1_253, iter_1_201)
			end
		end

		local var_1_254 = var_0_7.getRandomMaxTargetsGroup(var_1_253, "INITIAL_ANGER", false, var_1_5)

		if var_1_254 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_254))
		end
	elseif var_1_13 == 152 then
		local var_1_255 = var_0_7.getRandomMaxTargets2(self, var_1_3, "INITIAL_ANGER", false)

		for iter_1_202 = 1, #var_1_255 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_255[iter_1_202]))
		end
	elseif var_1_13 == 153 then
		local var_1_256 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 300, false)

		for iter_1_203 = 1, #var_1_256 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_256[iter_1_203]))
		end
	elseif var_1_13 == 154 then
		local var_1_257 = {}

		for iter_1_204, iter_1_205 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			for iter_1_206, iter_1_207 in ipairs((iter_1_205:getBuffs())) do
				if iter_1_207.buffCfg.buff_control_type == 1 then
					var_0_5(var_1_257, iter_1_205)

					break
				end
			end
		end

		if not var_1_1.isPlayer and #var_1_257 > 1 then
			for iter_1_208, iter_1_209 in ipairs(var_1_257) do
				if iter_1_209.serialId == var_1_1.serialId then
					var_0_6(var_1_257, iter_1_208)

					break
				end
			end
		end

		if next(var_1_257) then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_257[var_0_7.random(1, #var_1_257, var_1_5)]))
		end
	elseif var_1_13 == 155 then
		local var_1_258 = var_0_7.getRandomMaxTargets(self, var_1_3, "totalAtk", true)

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_258))

		if var_1_258 then
			local var_1_259 = {}

			for iter_1_210, iter_1_211 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
				if iter_1_211.serialId ~= var_1_258.serialId then
					var_0_5(var_1_259, iter_1_211)
				end
			end

			for iter_1_212, iter_1_213 in ipairs((var_0_7.getRandomMaxTargets2Group(var_1_259, "ATTACK", true, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_213))
			end
		end
	elseif var_1_13 == 156 then
		local var_1_260 = var_1_1

		if var_1_1.isPlayer then
			var_1_260 = var_0_7.getRandomKnight(self, var_1_3)
		end

		local var_1_261 = var_1_260.originInfo.pos > 3 and 0 or 3
		local var_1_262 = false

		for iter_1_214 = 1, 3 do
			local var_1_263 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_214 + var_1_261)

			if var_1_263 and var_1_263:isValid(var_1_1) then
				var_1_262 = true

				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_263))
			end
		end

		if not var_1_262 then
			local var_1_264 = var_1_260.originInfo.pos > 3 and 3 or 0

			for iter_1_215 = 1, 3 do
				local var_1_265 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_215 + var_1_264)

				if var_1_265 and var_1_265:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_265))
				end
			end
		end
	elseif var_1_13 == 157 then
		local var_1_267 = var_1_1

		if var_1_1.isPlayer then
			var_1_267 = var_0_7.getRandomKnight(self, var_1_3)
		end

		local var_1_268 = false
		local var_1_269 = var_1_267.originInfo.pos > 3 and 0 or 3

		for iter_1_216 = 1, 3 do
			local var_1_270 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_216 + var_1_269)

			if var_1_270 and var_1_270:isValid(var_1_1) then
				var_1_268 = true

				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_270))
			end
		end

		if not var_1_268 then
			local var_1_271 = var_1_267.originInfo.pos > 3 and 3 or 0

			for iter_1_217 = 1, 3 do
				local var_1_272 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_217 + var_1_271)

				if var_1_272 and var_1_272:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_272))
				end
			end
		else
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_1))
		end
	elseif var_1_13 == 158 then
		local var_1_274 = var_0_7.getSpKnights(self, var_1_3, "hpRate", 500, false)

		if #var_1_274 > 0 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_274[1]))
		end
	elseif var_1_13 == 159 then
		local var_1_275 = {}
		local var_1_276 = {}

		for iter_1_218, iter_1_219 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_219:getBuffCount(98, true) <= 0 then
				var_0_4.insert(var_1_275, iter_1_219)
			else
				var_0_4.insert(var_1_276, iter_1_219)
			end
		end

		if var_1_14 <= #var_1_275 then
			for iter_1_220, iter_1_221 in ipairs((var_0_7.getRandomN(var_1_275, var_1_14, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_221))
			end
		else
			for iter_1_222, iter_1_223 in ipairs(var_1_275) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_223))
			end

			for iter_1_224, iter_1_225 in ipairs((var_0_7.getRandomN(var_1_276, var_1_14 - #var_1_0, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_225))
			end
		end
	elseif var_1_13 == 160 then
		local var_1_277 = {}
		local var_1_278 = {}

		for iter_1_226, iter_1_227 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_227:getBuffCount(98, true) <= 0 then
				var_0_4.insert(var_1_277, iter_1_227)
			else
				var_0_4.insert(var_1_278, iter_1_227)
			end
		end

		if var_1_14 <= #var_1_277 then
			for iter_1_228, iter_1_229 in ipairs((var_0_7.getRandomMaxTargets2Group(var_1_277, "ATTACK", true, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_229))
			end
		else
			for iter_1_230, iter_1_231 in ipairs(var_1_277) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_231))
			end

			if var_1_14 - #var_1_0 == 2 then
				for iter_1_232, iter_1_233 in ipairs((var_0_7.getRandomMaxTargets2Group(var_1_278, "ATTACK", true, var_1_5))) do
					var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_233))
				end
			else
				var_0_5(var_1_0, var_0_7.createVictimTarget((var_0_7.getRandomMaxTargetsGroup(var_1_278, "ATTACK", true, var_1_5))))
			end
		end
	elseif var_1_13 == 161 then
		local var_1_279 = var_1_1.originInfo.pos
		local var_1_280 = var_1_1.originInfo.pos > 3 and 3 or 0

		for iter_1_234 = 1, 3 do
			local var_1_281 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_234 + var_1_280)

			if var_1_281 and var_1_281:isValid(var_1_1) and iter_1_234 + var_1_280 ~= var_1_279 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_281))
			end
		end
	elseif var_1_13 == 162 then
		for iter_1_235, iter_1_236 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_236.knightCfg.advance_id == var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_236))
			end
		end
	elseif var_1_13 == 163 then
		local var_1_282 = var_1_5:getBattleData():getFirstDeadKnight(var_1_3)

		if var_1_282 ~= 0 then
			local var_1_283 = self.battleData:getKnightData(var_1_282)

			if var_1_283 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_283))
			end
		end
	elseif var_1_13 == 164 then
		local var_1_284 = var_1_1.originInfo.pos
		local var_1_285 = var_1_1.originInfo.pos > 3 and 3 or 0
		local var_1_286 = {}

		for iter_1_237 = 1, 3 do
			local var_1_287 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_237 + var_1_285)

			if var_1_287 and var_1_287:isValid(var_1_1) and iter_1_237 + var_1_285 ~= var_1_284 then
				var_0_5(var_1_286, var_1_287)
			end
		end

		if next(var_1_286) then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_286[var_0_7.random(1, #var_1_286, var_1_5)]))
		end
	elseif var_1_13 == 165 then
		var_0_5(var_1_0, var_0_7.createVictimTarget((var_0_7.getRandomMaxTargets(self, var_1_3, "totalDef", false))))
	elseif var_1_13 == 166 then
		local var_1_288 = {}
		local var_1_289 = {}
		local var_1_290 = var_0_1(var_1_5:getCurAttackIndex() / 2)

		for iter_1_238, iter_1_239 in ipairs((self.battleData:getKnightList(var_1_3, nil, var_1_1))) do
			if iter_1_239:getBuffCount(var_0_8.COUNT_TYPE.CONTROL) > 0 and var_1_290 < iter_1_239.originInfo.pos then
				var_0_4.insert(var_1_288, iter_1_239)
			else
				var_0_4.insert(var_1_289, iter_1_239)
			end
		end

		if var_1_14 <= #var_1_288 then
			for iter_1_240, iter_1_241 in ipairs((var_0_7.getRandomN(var_1_288, var_1_14, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_241))
			end
		else
			for iter_1_242, iter_1_243 in ipairs(var_1_288) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_243))
			end

			for iter_1_244, iter_1_245 in ipairs((var_0_7.getRandomN(var_1_289, var_1_14 - #var_1_0, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_245))
			end
		end
	elseif var_1_13 == 167 then
		local var_1_291 = var_1_5:getBattleData():getKnightList(var_1_3, nil, var_1_1)

		for iter_1_246 = 1, #var_1_291 do
			if var_1_291[iter_1_246].knightCfg.profession == var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_291[iter_1_246]))
			end
		end
	elseif var_1_13 == 168 then
		local var_1_292 = var_1_5:getBattleData():getKnightList(var_1_3, nil, var_1_1)

		for iter_1_247 = 1, #var_1_292 do
			if var_1_292[iter_1_247].knightCfg.profession ~= var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_292[iter_1_247]))
			end
		end
	elseif var_1_13 == 169 then
		local var_1_293 = var_1_5:getBattleData():getKnightList(var_1_3, nil, var_1_1)

		for iter_1_248 = 1, #var_1_293 do
			if var_1_293[iter_1_248].knightCfg.group == var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_293[iter_1_248]))
			end
		end
	elseif var_1_13 == 170 then
		local var_1_294 = var_1_5:getBattleData():getKnightList(var_1_3, nil, var_1_1)

		for iter_1_249 = 1, #var_1_294 do
			if var_1_294[iter_1_249].knightCfg.group ~= var_1_14 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_294[iter_1_249]))
			end
		end
	elseif var_1_13 == 171 then
		local var_1_295 = var_1_1

		if var_1_1.isPlayer then
			var_1_295 = var_0_7.getRandomKnight(self, var_1_3)
		end

		var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_295))

		if var_1_1.baseInfo.SHIELD > 0 then
			local var_1_296 = {}

			if var_1_295.originInfo.pos ~= 4 then
				var_1_296[#var_1_296 + 1] = var_1_295.originInfo.pos - 1
			end

			var_1_296[#var_1_296 + 1] = var_1_295.originInfo.pos + 3

			if var_1_295.originInfo.pos ~= 3 then
				var_1_296[#var_1_296 + 1] = var_1_295.originInfo.pos + 1
			end

			var_1_296[#var_1_296 + 1] = var_1_295.originInfo.pos - 3

			for iter_1_250 = 1, #var_1_296 do
				local var_1_297 = var_1_4:getKnightByIdAndPos(var_1_3, var_1_296[iter_1_250])

				if var_1_297 and var_1_297:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_297))
				end
			end
		end
	elseif var_1_13 == 172 then
		local var_1_298 = var_1_1.originInfo.pos > 3 and 3 or 0

		for iter_1_251 = 1, 3 do
			local var_1_299 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_251 + var_1_298)

			if var_1_299 and var_1_299:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_299))
			end
		end
	elseif var_1_13 == 173 then
		local var_1_300 = var_1_4:getKnightByIdAndPos(var_1_3, (var_1_1.originInfo.pos < 4 or nil) and (var_1_1.originInfo.pos + 3 or var_1_1.originInfo.pos - 3))

		if var_1_300 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_300))
		end
	elseif var_1_13 == 174 then
		local var_1_301 = {}

		for iter_1_252 = 1, 3 do
			local var_1_302 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_252)

			if var_1_302 and var_1_302:isValid(var_1_1) then
				var_0_5(var_1_301, var_1_302)
			end
		end

		if #var_1_301 == 0 then
			for iter_1_253 = 4, 6 do
				local var_1_303 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_253)

				if var_1_303 and var_1_303:isValid(var_1_1) then
					var_0_5(var_1_301, var_1_303)
				end
			end
		end

		local var_1_304 = var_0_7.getMaxTargetsNGroup(var_1_301, "INITIAL_HP", true, 1, var_1_5)

		if #var_1_304 > 0 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_304[1]))
		end
	elseif var_1_13 == 175 then
		local var_1_305 = {}

		for iter_1_254 = 4, 6 do
			local var_1_306 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_254)

			if var_1_306 and var_1_306:isValid(var_1_1) then
				var_0_5(var_1_305, var_1_306)
			end
		end

		if #var_1_305 == 0 then
			for iter_1_255 = 1, 3 do
				local var_1_307 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_255)

				if var_1_307 and var_1_307:isValid(var_1_1) then
					var_0_5(var_1_305, var_1_307)
				end
			end
		end

		local var_1_308 = var_0_7.getMaxTargetsNGroup(var_1_305, "ATTACK", true, 1, var_1_5)

		if #var_1_308 > 0 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_308[1]))
		end
	elseif var_1_13 == 176 then
		for iter_1_256 = 1, 6 do
			local var_1_309 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_256)

			if var_1_309 and var_1_309:isReal(var_1_1) and not var_1_309.exile and var_1_309:getBuffCount(var_1_14) > 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_309))
			end
		end
	elseif var_1_13 == 177 then
		local var_1_310 = var_1_1.originInfo.pos
		local var_1_311 = var_1_1.originInfo.pos < 4 and var_1_310 + 3 or var_1_310 - 3

		local function var_1_312(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = arg_4_0

			if arg_4_0 > 3 then
				var_4_0 = 3
				var_4_1 = var_4_1 - 3
			end

			local var_4_2 = {}

			for iter_4_0 = 1, 2 do
				if var_4_1 - iter_4_0 > 0 and var_4_1 - iter_4_0 < 4 then
					var_0_4.insert(var_4_2, var_4_1 - iter_4_0 + var_4_0)
				end

				if var_4_1 + iter_4_0 > 0 and var_4_1 + iter_4_0 < 4 then
					var_0_4.insert(var_4_2, var_4_1 + iter_4_0 + var_4_0)
				end
			end

			return var_4_2
		end

		local var_1_313 = var_1_4:getKnightByIdAndPos(var_1_3, var_1_311)

		if var_1_313 and var_1_313:isValid(var_1_1) and var_1_313:getBuffCount(27, true) <= 0 then
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_313))
		else
			for iter_1_257, iter_1_258 in ipairs((var_1_312(var_1_311))) do
				local var_1_314 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_258)

				if var_1_314 and var_1_314:isValid(var_1_1) and var_1_314:getBuffCount(27, true) <= 0 then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_314))

					break
				end
			end

			if not next(var_1_0) then
				for iter_1_259, iter_1_260 in ipairs((var_1_312(var_1_310))) do
					local var_1_315 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_260)

					if var_1_315 and var_1_315:isValid(var_1_1) and var_1_315:getBuffCount(27, true) <= 0 then
						var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_315))

						break
					end
				end
			end
		end
	elseif var_1_13 == 178 then
		local var_1_316 = var_1_1

		if var_1_1.isPlayer then
			var_1_316 = var_0_7.getRandomKnight(self, var_1_3)
		end

		local var_1_317 = var_1_316.originInfo.pos > 3 and 0 or 3
		local var_1_318 = false

		for iter_1_261 = 1, 3 do
			local var_1_319 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_261 + var_1_317)

			if var_1_319 and var_1_319:isValid(var_1_1) then
				var_1_318 = true

				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_319))
			end
		end

		if not var_1_318 then
			local var_1_320 = var_1_316.originInfo.pos > 3 and 3 or 0

			for iter_1_262 = 1, 3 do
				local var_1_321 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_262 + var_1_320)

				if var_1_321 and var_1_321:isValid(var_1_1) and var_1_316.originInfo.pos ~= iter_1_262 + var_1_320 then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_321))
				end
			end
		end
	elseif var_1_13 == 179 then
		local var_1_323 = {}
		local var_1_324 = self.battleData:getKnightList(var_1_3, true)

		for iter_1_263 = 1, #var_1_324 do
			if var_1_324[iter_1_263].isDead and var_1_324[iter_1_263].isCanSelect then
				var_0_5(var_1_323, var_1_324[iter_1_263])
			end
		end

		if #var_1_323 > 0 then
			for iter_1_264, iter_1_265 in ipairs((var_0_7.getRandomN(var_1_323, 1, var_1_5))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_265))
			end
		else
			local var_1_325 = var_0_7.getMaxTargetsN(self, var_1_3, "hpRate", false, 1)

			for iter_1_266 = 1, #var_1_325 do
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_325[iter_1_266]))
			end
		end
	elseif var_1_13 == 180 then
		local var_1_326 = var_1_1

		if var_1_1.isPlayer then
			var_1_326 = var_0_7.getRandomKnight(self, var_1_3)
		end

		local var_1_327 = var_1_326.originInfo.pos
		local var_1_328 = {}

		if var_1_326.originInfo.pos ~= 4 then
			var_1_328[#var_1_328 + 1] = var_1_327 - 1
		end

		var_1_328[#var_1_328 + 1] = var_1_327 + 3

		if var_1_327 ~= 3 then
			var_1_328[#var_1_328 + 1] = var_1_327 + 1
		end

		var_1_328[#var_1_328 + 1] = var_1_327 - 3

		for iter_1_267 = 1, #var_1_328 do
			local var_1_329 = var_1_4:getKnightByIdAndPos(var_1_3, var_1_328[iter_1_267])

			if var_1_329 and var_1_329:isValid(var_1_1) then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_329))
			end
		end
	elseif var_1_13 == 181 then
		local var_1_330 = self.battleData:getKnightList(var_1_3, true)

		for iter_1_268 = 1, #var_1_330 do
			if var_1_330[iter_1_268].baseInfo.SHIELD > 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_330[iter_1_268]))
			end
		end
	elseif var_1_13 == 182 then
		if ((var_1_1.isPlayer or nil) and var_0_7.getRandomKnight(self, var_1_3)).originInfo.pos >= 4 then
			local var_1_332 = self.battleData:getKnightList(var_1_3, nil, var_1_1)

			for iter_1_269 = 1, #var_1_332 do
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_332[iter_1_269]))
			end
		else
			for iter_1_270 = 1, 3 do
				local var_1_333 = var_1_4:getKnightByIdAndPos(var_1_3, iter_1_270)

				if var_1_333 and var_1_333:isValid(var_1_1) then
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_333))
				end
			end
		end
	elseif var_1_13 == 183 then
		local var_1_334 = self.battleData:getKnightList(var_1_3, nil, var_1_1)

		for iter_1_271, iter_1_272 in ipairs(var_1_334) do
			if iter_1_272.serialId == var_1_1.serialId then
				var_0_4.remove(var_1_334, iter_1_271)

				break
			end
		end

		for iter_1_273 = 1, #var_1_334 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_334[iter_1_273]))
		end
	elseif var_1_13 == 184 then
		local var_1_335 = self.battleData:getKnightList(var_1_3, nil, var_1_1)

		for iter_1_274 = 1, #var_1_335 do
			if var_1_335[iter_1_274]:getBuffCount(var_1_14, false, true) > 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_335[iter_1_274]))
			end
		end
	elseif var_1_13 == 185 then
		local var_1_336 = var_0_7.getMaxTargetsN(self, var_1_3, "hpRate", false, var_1_14)

		for iter_1_275 = 1, #var_1_336 do
			var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_336[iter_1_275]))
		end
	elseif var_1_13 == 201 then
		if self.targets[1] then
			for iter_1_276, iter_1_277 in ipairs(self.targets[1]) do
				var_0_5(var_1_0, var_0_7.copyTarget(iter_1_277))
			end
		end
	elseif var_1_13 == 202 then
		if self.targets[2] then
			for iter_1_278, iter_1_279 in ipairs(self.targets[2]) do
				var_0_5(var_1_0, var_0_7.copyTarget(iter_1_279))
			end
		end
	elseif var_1_13 == 203 then
		if self.targets[#self.targets] then
			for iter_1_280, iter_1_281 in ipairs(self.targets[#self.targets]) do
				var_0_5(var_1_0, var_0_7.copyTarget(iter_1_281))
			end
		end
	elseif var_1_13 == 204 then
		local var_1_337, var_1_338 = var_0_7.getRangeKnights(self.targets[1])

		var_0_5(var_1_0, var_0_7.copyTarget(var_1_338[var_0_7.getRandomMaxTargetsGroup(var_1_337, "hpRate", false, var_1_5)]))
	elseif var_1_13 == 205 then
		local var_1_339, var_1_340 = var_0_7.getRangeKnights(self.targets[1])

		var_0_5(var_1_0, var_0_7.copyTarget(var_1_340[var_0_7.getRandomMaxTargetsGroup(var_1_339, "hpRate", true, var_1_5)]))
	elseif var_1_13 == 206 then
		local var_1_341, var_1_342 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_343 = var_0_7.getSpKnightsGroup(var_1_341, "hpRate", 300, false)

		for iter_1_282 = 1, #var_1_343 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_342[var_1_343[iter_1_282]]))
		end
	elseif var_1_13 == 207 then
		local var_1_344, var_1_345 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_346 = var_0_7.getSpKnightsGroup(var_1_344, "hpRate", 400, false)

		for iter_1_283 = 1, #var_1_346 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_345[var_1_346[iter_1_283]]))
		end
	elseif var_1_13 == 208 then
		local var_1_347, var_1_348 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_349 = var_0_7.getSpKnightsGroup(var_1_347, "hpRate", 500, false)

		for iter_1_284 = 1, #var_1_349 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_348[var_1_349[iter_1_284]]))
		end
	elseif var_1_13 == 209 then
		local var_1_350, var_1_351 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_352 = var_0_7.getSpKnightsGroup(var_1_350, "hpRate", 600, false)

		for iter_1_285 = 1, #var_1_352 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_351[var_1_352[iter_1_285]]))
		end
	elseif var_1_13 == 210 then
		local var_1_353, var_1_354 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_355 = var_0_7.getSpKnightsGroup(var_1_353, "hpRate", 800, false)

		for iter_1_286 = 1, #var_1_355 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_354[var_1_355[iter_1_286]]))
		end
	elseif var_1_13 == 211 then
		local var_1_356, var_1_357 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_358 = var_0_7.getSpKnightsGroup(var_1_356, "hpRate", 300, true)

		for iter_1_287 = 1, #var_1_358 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_357[var_1_358[iter_1_287]]))
		end
	elseif var_1_13 == 212 then
		local var_1_359, var_1_360 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_361 = var_0_7.getSpKnightsGroup(var_1_359, "hpRate", 500, true)

		for iter_1_288 = 1, #var_1_361 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_360[var_1_361[iter_1_288]]))
		end
	elseif var_1_13 == 213 then
		local var_1_362, var_1_363 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_364 = var_0_7.getSpKnightsGroup(var_1_362, "hpRate", 700, true)

		for iter_1_289 = 1, #var_1_364 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_363[var_1_364[iter_1_289]]))
		end
	elseif var_1_13 == 214 then
		local var_1_365, var_1_366 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_367 = var_0_7.getSpKnightsGroup(var_1_365, "INITIAL_ANGER", 3, true)

		for iter_1_290 = 1, #var_1_367 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_366[var_1_367[iter_1_290]]))
		end
	elseif var_1_13 == 215 then
		local var_1_368, var_1_369 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_370 = var_0_7.getSpGroup(var_1_368, 1)

		for iter_1_291 = 1, #var_1_370 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_369[var_1_370[iter_1_291]]))
		end
	elseif var_1_13 == 216 then
		local var_1_371, var_1_372 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_373 = var_0_7.getSpGroup(var_1_371, 2)

		for iter_1_292 = 1, #var_1_373 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_372[var_1_373[iter_1_292]]))
		end
	elseif var_1_13 == 217 then
		local var_1_374, var_1_375 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_376 = var_0_7.getSpGroup(var_1_374, 3)

		for iter_1_293 = 1, #var_1_376 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_375[var_1_376[iter_1_293]]))
		end
	elseif var_1_13 == 218 then
		local var_1_377, var_1_378 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_379 = var_0_7.getSpGroup(var_1_377, 4)

		for iter_1_294 = 1, #var_1_379 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_378[var_1_379[iter_1_294]]))
		end
	elseif var_1_13 == 219 then
		local var_1_380, var_1_381 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_382 = var_0_7.getSpKnightsGroup(var_1_380, "INITIAL_ANGER", 3, false)

		for iter_1_295 = 1, #var_1_382 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_381[var_1_382[iter_1_295]]))
		end
	elseif var_1_13 == 220 then
		local var_1_383, var_1_384 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_385 = var_0_7.getSpKnightsGroup(var_1_383, "INITIAL_ANGER", 4, true)

		for iter_1_296 = 1, #var_1_385 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_384[var_1_385[iter_1_296]]))
		end
	elseif var_1_13 == 221 then
		local var_1_386, var_1_387 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_388 = var_0_7.getSpKnightsGroup(var_1_386, "ATTACK", var_1_1.advanceInfo.ATTACK, true)

		for iter_1_297 = 1, #var_1_388 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_387[var_1_388[iter_1_297]]))
		end
	elseif var_1_13 == 222 then
		local var_1_389, var_1_390 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_391 = var_0_7.getSpKnightsGroup(var_1_389, "ATTACK", var_1_1.advanceInfo.ATTACK - 1, false)

		for iter_1_298 = 1, #var_1_391 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_390[var_1_391[iter_1_298]]))
		end
	elseif var_1_13 == 223 then
		local var_1_392, var_1_393 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_394 = var_0_7.getSpBuffKnights(var_1_392, var_0_8.EFFECT_TYPE.BURNING)

		for iter_1_299 = 1, #var_1_394 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_393[var_1_394[iter_1_299]]))
		end
	elseif var_1_13 == 224 then
		local var_1_395, var_1_396 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_300 = 1, #var_1_395 do
			if var_1_395[iter_1_300]:getMarkLevel(1) > 0 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_396[var_1_395[iter_1_300]]))
			end
		end
	elseif var_1_13 == 225 then
		local var_1_397, var_1_398 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_399 = {}

		for iter_1_301 = 1, #var_1_397 do
			for iter_1_302 = 1, #var_1_397[iter_1_301].buffs do
				if var_1_397[iter_1_301].buffs[iter_1_302].buffCfg.buff_increase_type == 2 then
					var_0_5(var_1_399, var_1_397[iter_1_301])

					break
				end
			end
		end

		for iter_1_303 = 1, #var_1_399 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_398[var_1_399[iter_1_303]]))
		end
	elseif var_1_13 == 226 then
		local var_1_400, var_1_401 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_402 = var_0_7.getSpKnightsGroup(var_1_400, "hpRate", var_1_1.baseInfo.hpRate + 1, true)

		for iter_1_304 = 1, #var_1_402 do
			if var_1_402[iter_1_304].identity == var_1_2 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_401[var_1_402[iter_1_304]]))
			end
		end
	elseif var_1_13 == 227 then
		local var_1_403, var_1_404 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_405 = var_0_7.getSpKnightsGroup(var_1_403, "hpRate", var_1_1.baseInfo.hpRate - 1, false)

		for iter_1_305 = 1, #var_1_405 do
			if var_1_405[iter_1_305].identity == var_1_2 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_404[var_1_405[iter_1_305]]))
			end
		end
	elseif var_1_13 == 228 then
		local var_1_406, var_1_407 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_408 = var_0_7.getSpKnightsGroup(var_1_406, "hpRate", var_1_1.baseInfo.hpRate + 1, true)

		for iter_1_306 = 1, #var_1_408 do
			if var_1_408[iter_1_306].identity == var_1_3 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_407[var_1_408[iter_1_306]]))
			end
		end
	elseif var_1_13 == 229 then
		local var_1_409, var_1_410 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_411 = var_0_7.getSpKnightsGroup(var_1_409, "hpRate", var_1_1.baseInfo.hpRate - 1, false)

		for iter_1_307 = 1, #var_1_411 do
			if var_1_411[iter_1_307].identity == var_1_3 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_410[var_1_411[iter_1_307]]))
			end
		end
	elseif var_1_13 == 230 then
		local var_1_412, var_1_413 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_308 = 1, #var_1_412 do
			if var_1_412[iter_1_308]:hasBuffByEffectType(var_0_8.EFFECT_TYPE.BLAST_BURNING) then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_413[var_1_412[iter_1_308]]))
			end
		end
	elseif var_1_13 == 231 then
		if self.targets[#self.targets] then
			local var_1_414, var_1_415 = var_0_7.getRangeKnights(self.targets[#self.targets])
			local var_1_416 = {}

			for iter_1_309 = 1, #var_1_414 do
				for iter_1_310 = 1, #var_1_414[iter_1_309].buffs do
					if var_1_414[iter_1_309].buffs[iter_1_310].buffCfg.buff_increase_type == 1 then
						var_0_5(var_1_416, var_1_414[iter_1_309])

						break
					end
				end
			end

			for iter_1_311 = 1, #var_1_416 do
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_415[var_1_416[iter_1_311]]))
			end
		end
	elseif var_1_13 == 232 then
		local var_1_417, var_1_418 = var_0_7.getRangeKnights(self.targets[1])

		if #var_1_417 < 3 then
			for iter_1_312 = 1, #var_1_417 do
				if var_1_417[iter_1_312].identity == var_1_2 then
					var_0_5(var_1_0, var_0_7.copyTarget(var_1_418[var_1_417[iter_1_312]]))
				end
			end
		end
	elseif var_1_13 == 233 then
		local var_1_419, var_1_420 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_313, iter_1_314 in ipairs(var_1_419) do
			if iter_1_314.originInfo.pos >= 4 and iter_1_314.originInfo.pos <= 6 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_420[iter_1_314]))
			end
		end

		if #var_1_0 == 0 and self.targets[1] then
			for iter_1_315, iter_1_316 in ipairs(self.targets[1]) do
				var_0_5(var_1_0, var_0_7.copyTarget(iter_1_316))
			end
		end
	elseif var_1_13 == 234 then
		local var_1_421, var_1_422 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_423 = var_1_5:getActionKnights()

		for iter_1_317, iter_1_318 in ipairs(var_1_421) do
			local var_1_424 = false

			for iter_1_319, iter_1_320 in ipairs(var_1_423) do
				if iter_1_318.serialId == iter_1_320 then
					var_1_424 = true

					break
				end
			end

			if not var_1_424 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_422[iter_1_318]))
			end
		end
	elseif var_1_13 == 235 then
		if self.targets[1] and #self.targets[1] == 1 then
			for iter_1_321, iter_1_322 in ipairs((var_1_5:getBattleData():getNearKnightList(self.targets[1][1].victim))) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_322))
			end
		end
	elseif var_1_13 == 236 then
		local var_1_425, var_1_426 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_323 = 1, #var_1_425 do
			if var_1_425[iter_1_323]:hasBuffByEffectType(var_0_8.EFFECT_TYPE.ARMOR_BROKEN) then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_426[var_1_425[iter_1_323]]))
			end
		end
	elseif var_1_13 == 237 then
		local var_1_427, var_1_428 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_429 = var_0_7.getRandomMaxTargetsGroup(var_1_427, "ATTACK", true, var_1_5)

		if var_1_429 then
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_428[var_1_429]))
		end
	elseif var_1_13 == 238 then
		local var_1_430, var_1_431 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_324 = 1, #var_1_430 do
			if var_1_430[iter_1_324]:hasBuffByEffectType(var_0_8.EFFECT_TYPE.SILENCE) then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_431[var_1_430[iter_1_324]]))
			end
		end
	elseif var_1_13 == 239 then
		local var_1_432, var_1_433 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_434 = var_0_7.getRandomMaxTargets2Group(var_1_432, "hpRate", true, var_1_5)

		if #var_1_434 > 0 then
			for iter_1_325 = 1, #var_1_434 do
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_433[var_1_434[iter_1_325]]))
			end
		end
	elseif var_1_13 == 240 then
		local var_1_435, var_1_436 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_326 = 1, #var_1_435 do
			if not var_1_435[iter_1_326]:hasBuffByEffectType(var_0_8.EFFECT_TYPE.FROZEN) then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_436[var_1_435[iter_1_326]]))
			end
		end
	elseif var_1_13 == 241 then
		local var_1_437, var_1_438 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_327 = 1, #var_1_437 do
			if var_1_437[iter_1_327].baseInfo.SHIELD > 0 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_438[var_1_437[iter_1_327]]))
			end
		end
	elseif var_1_13 == 242 then
		local var_1_439, var_1_440 = var_0_7.getRangeKnights(self.targets[1])

		if #var_1_439 > 0 then
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_440[var_1_439[var_0_7.random(1, #var_1_439, var_1_5)]]))
		end
	elseif var_1_13 == 243 then
		local var_1_441, var_1_442 = var_0_7.getRangeKnights(self.targets[1])
		local var_1_443 = var_0_7.getSpKnightsGroup(var_1_441, "hpRate", 200, false)

		for iter_1_328 = 1, #var_1_443 do
			var_0_5(var_1_0, var_0_7.copyTarget(var_1_442[var_1_443[iter_1_328]]))
		end
	elseif var_1_13 == 244 then
		local var_1_444, var_1_445 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_329, iter_1_330 in ipairs(var_1_444) do
			if iter_1_330.baseInfo.INITIAL_ANGER >= 4 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_445[iter_1_330]))
			end
		end
	elseif var_1_13 == 245 then
		local var_1_446, var_1_447 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_331, iter_1_332 in ipairs(var_1_446) do
			if iter_1_332.advanceInfo.PHY_DEFENCE < iter_1_332.originInfo.PHY_DEFENCE or iter_1_332.advanceInfo.PHY_DEFENCE_PCT < iter_1_332.originInfo.PHY_DEFENCE_PCT or iter_1_332.advanceInfo.MAG_DEFENCE < iter_1_332.originInfo.MAG_DEFENCE or iter_1_332.advanceInfo.MAG_DEFENCE_PCT < iter_1_332.originInfo.MAG_DEFENCE_PCT or iter_1_332.advanceInfo.DEFENCE < iter_1_332.originInfo.DEFENCE or iter_1_332.advanceInfo.DEFENCE_PCT < iter_1_332.originInfo.DEFENCE_PCT or iter_1_332:getBuffCount(var_0_8.COUNT_TYPE.DEFENCE_ATTR) > 0 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_447[iter_1_332]))
			end
		end
	elseif var_1_13 == 246 then
		local var_1_448, var_1_449 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_333, iter_1_334 in ipairs(var_1_448) do
			if iter_1_334.knightCfg.attack_type == var_1_14 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_449[iter_1_334]))
			end
		end
	elseif var_1_13 == 247 then
		local var_1_450, var_1_451 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_335 = 1, #var_1_450 do
			if var_1_450[iter_1_335]:getBuffCount(1001) <= 0 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_451[var_1_450[iter_1_335]]))
			end
		end
	elseif var_1_13 == 248 then
		local var_1_452, var_1_453 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_336 = 1, #var_1_452 do
			if var_1_452[iter_1_336].knightCfg.profession == var_1_14 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_453[var_1_452[iter_1_336]]))
			end
		end
	elseif var_1_13 == 249 then
		local var_1_454, var_1_455 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_337 = 1, #var_1_454 do
			if var_1_454[iter_1_337].knightCfg.profession ~= var_1_14 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_455[var_1_454[iter_1_337]]))
			end
		end
	elseif var_1_13 == 250 then
		local var_1_456, var_1_457 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_338 = 1, #var_1_456 do
			if var_1_456[iter_1_338].knightCfg.group == var_1_14 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_457[var_1_456[iter_1_338]]))
			end
		end
	elseif var_1_13 == 251 then
		local var_1_458, var_1_459 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_339 = 1, #var_1_458 do
			if var_1_458[iter_1_339].knightCfg.group ~= var_1_14 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_459[var_1_458[iter_1_339]]))
			end
		end
	elseif var_1_13 == 252 then
		local var_1_460, var_1_461 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_340 = 1, #var_1_460 do
			if var_1_460[iter_1_340]:getBuffCount(var_1_14) > 0 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_461[var_1_460[iter_1_340]]))
			end
		end
	elseif var_1_13 == 253 then
		local var_1_462, var_1_463 = var_0_7.getRangeKnights(self.targets[1])

		if var_1_14 >= #var_1_462 then
			for iter_1_341 = 1, #var_1_462 do
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_463[var_1_462[iter_1_341]]))
			end
		else
			local var_1_464 = var_0_7.getRandomN(var_1_462, var_1_14, var_1_5)

			for iter_1_342 = 1, #var_1_464 do
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_463[var_1_464[iter_1_342]]))
			end
		end
	elseif var_1_13 == 254 then
		local var_1_465, var_1_466 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_343 = 1, #var_1_465 do
			if var_1_465[iter_1_343]:getBuffCount(23440, false, true) == var_1_14 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_466[var_1_465[iter_1_343]]))
			end
		end
	elseif var_1_13 == 255 then
		local var_1_467, var_1_468 = var_0_7.getRangeKnights(self.targets[1])

		if var_1_14 >= #var_1_467 then
			for iter_1_344 = 1, #var_1_467 do
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_468[var_1_467[iter_1_344]]))
			end
		else
			for iter_1_345, iter_1_346 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_1_467, "hpRate", false, var_1_5, var_1_14))) do
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_468[iter_1_346]))
			end
		end
	elseif var_1_13 == 256 then
		local var_1_469, var_1_470 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_347 = 1, #var_1_469 do
			if var_1_469[iter_1_347].identity == var_1_1.identity then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_470[var_1_469[iter_1_347]]))
			end
		end
	elseif var_1_13 == 257 then
		local var_1_471, var_1_472 = var_0_7.getRangeKnights(self.targets[1])

		for iter_1_348 = 1, #var_1_471 do
			if var_1_471[iter_1_348].identity == var_1_2 then
				var_0_5(var_1_0, var_0_7.copyTarget(var_1_472[var_1_471[iter_1_348]]))
			end
		end
	elseif var_1_13 == 301 then
		-- block empty
	elseif var_1_13 == 302 then
		local var_1_473 = {}
		local var_1_474 = {}

		if not var_1_1.isPlayer then
			for iter_1_349, iter_1_350 in ipairs((var_1_1:getBuffs())) do
				if iter_1_350.buffCfg.buff_effect_type == var_0_8.EFFECT_TYPE.STUN and iter_1_350.attacker:isValid() and not var_1_474[iter_1_350.attacker] then
					var_0_4.insert(var_1_473, iter_1_350.attacker)

					var_1_474[iter_1_350.attacker] = true
				end
			end

			if #var_1_473 > 0 then
				for iter_1_351 = 1, #var_1_473 do
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_473[iter_1_351]))
				end
			end
		end
	elseif var_1_13 == 303 then
		local var_1_475 = {}
		local var_1_476 = {}

		if not var_1_1.isPlayer then
			for iter_1_352, iter_1_353 in ipairs((var_1_1:getBuffs())) do
				if iter_1_353.buffCfg.buff_effect_type == var_0_8.EFFECT_TYPE.BURNING and iter_1_353.attacker:isValid(var_1_1) and not var_1_476[iter_1_353.attacker] then
					var_0_4.insert(var_1_475, iter_1_353.attacker)

					var_1_476[iter_1_353.attacker] = true
				end
			end

			if #var_1_475 > 0 then
				for iter_1_354 = 1, #var_1_475 do
					var_0_5(var_1_0, var_0_7.createVictimTarget(var_1_475[iter_1_354]))
				end
			end
		end
	elseif var_1_13 == 500 then
		local var_1_477 = var_0_7.getRandomN(self.battleData:getAllKnightListTarget(nil, var_1_1), var_1_14, var_1_5)

		if var_1_14 >= #var_1_477 then
			for iter_1_355, iter_1_356 in ipairs(var_1_477) do
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_356))
			end
		else
			local var_1_478 = {}
			local var_1_479 = {}

			for iter_1_357, iter_1_358 in ipairs(var_1_477) do
				if iter_1_358:getBuffCount(1272) <= 0 then
					var_0_4.insert(var_1_478, iter_1_358)
				else
					var_0_4.insert(var_1_479, iter_1_358)
				end
			end

			if var_1_14 >= #var_1_478 then
				for iter_1_359, iter_1_360 in ipairs(var_1_478) do
					var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_360))
				end
			else
				for iter_1_361, iter_1_362 in ipairs((var_0_7.getRandomN(var_1_478, var_1_14, var_1_5))) do
					var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_362))
				end
			end

			if var_1_14 > #var_1_0 and var_1_14 <= #var_1_477 then
				for iter_1_363, iter_1_364 in ipairs((var_0_7.getRandomN(var_1_479, var_1_14 - #var_1_0, var_1_5))) do
					var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_364))
				end
			end
		end
	elseif var_1_13 == 501 then
		for iter_1_365, iter_1_366 in ipairs((self.battleData:getAllKnightListTarget(nil, var_1_1))) do
			if iter_1_366:getBuffCount(var_1_14) > 0 then
				var_0_5(var_1_0, var_0_7.createVictimTarget(iter_1_366))
			end
		end
	elseif var_0_10["_getVictimTarget" .. var_1_13] then
		var_0_10["_getVictimTarget" .. var_1_13](var_1_0, self, self.targets)
	elseif config and config.DEBUG_VERSION then
		assert(false, string.format("没找到范围 %s 的函数", var_1_13))
	end

	return var_1_0
end

function var_0_10._getVictimTarget0(arg_5_0, arg_5_1)
	return
end

function var_0_10._getVictimTarget89(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.battleData:getKnightList(arg_6_1.attacker.opIdentity, nil, arg_6_1.attacker)

	for iter_6_0 = 1, #var_6_0 do
		if var_6_0[iter_6_0]:getMarkLevel(91) > 0 then
			var_0_5(arg_6_0, var_0_7.createVictimTarget(var_6_0[iter_6_0]))
		end
	end
end

function var_0_10._getVictimTarget90(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.battleData:getKnightList(arg_7_1.attacker.opIdentity, nil, arg_7_1.attacker)

	for iter_7_0 = 1, #var_7_0 do
		if var_7_0[iter_7_0]:getBuffCount(1311) > 0 then
			var_0_5(arg_7_0, var_0_7.createVictimTarget(var_7_0[iter_7_0]))
		end
	end
end

function var_0_10._getVictimTarget91(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.battleData:getKnightList(arg_8_1.attacker.opIdentity, nil, arg_8_1.attacker)

	for iter_8_0 = 1, #var_8_0 do
		if var_8_0[iter_8_0]:getBuffCount(1324) > 0 then
			var_0_5(arg_8_0, var_0_7.createVictimTarget(var_8_0[iter_8_0]))
		end
	end
end

function var_0_10._getVictimTarget92(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.battleData:getKnightList(arg_9_1.attacker.opIdentity, nil, arg_9_1.attacker)
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0 = 1, #var_9_0 do
		if var_9_0[iter_9_0]:getBuffCount(1340, false, false) > 0 then
			var_9_1[#var_9_1 + 1] = var_9_0[iter_9_0]
		else
			var_9_2[#var_9_2 + 1] = var_9_0[iter_9_0]
		end
	end

	if arg_9_1.range_value <= #var_9_2 then
		for iter_9_1, iter_9_2 in ipairs((var_0_7.getRandomN(var_9_2, arg_9_1.range_value, arg_9_1.battleField))) do
			var_0_5(arg_9_0, var_0_7.createVictimTarget(iter_9_2))
		end
	else
		for iter_9_3, iter_9_4 in ipairs(var_9_2) do
			var_0_5(arg_9_0, var_0_7.createVictimTarget(iter_9_4))
		end

		for iter_9_5, iter_9_6 in ipairs((var_0_7.getRandomN(var_9_1, arg_9_1.range_value - #var_9_2, arg_9_1.battleField))) do
			var_0_5(arg_9_0, var_0_7.createVictimTarget(iter_9_6))
		end
	end
end

function var_0_10._getVictimTarget93(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.battleData:getKnightList(arg_10_1.attacker.opIdentity, nil, arg_10_1.attacker)

	for iter_10_0 = 1, #var_10_0 do
		if arg_10_1.range_value >= var_10_0[iter_10_0].knightCfg.quality then
			var_0_5(arg_10_0, var_0_7.createVictimTarget(var_10_0[iter_10_0]))
		end
	end
end

function var_0_10._getVictimTarget94(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.battleField:getBattleData()
	local var_11_1 = arg_11_1.battleData:getKnightList(arg_11_1.attacker.opIdentity, nil, arg_11_1.attacker)
	local var_11_2 = 0
	local var_11_3 = {}

	for iter_11_0 = 1, #var_11_1 do
		local var_11_4 = var_11_0:getNearKnightList(var_11_1[iter_11_0])

		if var_11_2 < #var_11_4 then
			var_11_2 = #var_11_4
		end

		var_11_3[#var_11_4] = var_11_3[#var_11_4] or {}

		var_0_5(var_11_3[#var_11_4], {
			knight = var_11_1[iter_11_0],
			nearList = var_11_4
		})
	end

	if var_11_3[var_11_2] then
		local var_11_5 = var_0_7.random(1, #var_11_3[var_11_2], arg_11_1.battleField)

		var_0_5(arg_11_0, var_0_7.createVictimTarget(var_11_3[var_11_2][var_11_5].knight))

		for iter_11_1, iter_11_2 in ipairs(var_11_3[var_11_2][var_11_5].nearList) do
			var_0_5(arg_11_0, var_0_7.createVictimTarget(iter_11_2))
		end
	end
end

function var_0_10._getVictimTarget95(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.battleData:getKnights()

	for iter_12_0 = 1, 3 do
		local var_12_1 = var_12_0:getKnightByIdAndPos(arg_12_1.attacker.opIdentity, iter_12_0)

		if var_12_1 and var_12_1:isValid(arg_12_1.attacker) then
			var_0_5(arg_12_0, var_0_7.createVictimTarget(var_12_1))
		end
	end

	if #arg_12_0 == 0 then
		for iter_12_1 = 4, 6 do
			local var_12_2 = var_12_0:getKnightByIdAndPos(arg_12_1.attacker.opIdentity, iter_12_1)

			if var_12_2 and var_12_2:isValid(arg_12_1.attacker) then
				var_0_5(arg_12_0, var_0_7.createVictimTarget(var_12_2))
			end
		end
	else
		for iter_12_2, iter_12_3 in ipairs(arg_12_0) do
			if iter_12_3.victim:getBuffCount(1001) > 0 or iter_12_3.victim:getBuffCount(1356) > 0 then
				local var_12_3 = var_12_0:getKnightByIdAndPos(arg_12_1.attacker.opIdentity, iter_12_3.victim.originInfo.pos + 3)

				if var_12_3 and var_12_3:isValid(arg_12_1.attacker) then
					var_0_5(arg_12_0, var_0_7.createVictimTarget(var_12_3))
				end
			end
		end
	end
end

function var_0_10._getVictimTarget96(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.battleData:getKnightByIdAndPos(arg_13_1.attacker.opIdentity, arg_13_1.attacker.originInfo.pos)

	if not var_13_0 or not var_13_0:isValid(arg_13_1.attacker) then
		var_13_0 = arg_13_1.battleData:getNearKnight(arg_13_1.attacker.opIdentity, arg_13_1.attacker.originInfo.pos, arg_13_1.attacker)
	end

	var_0_5(arg_13_0, var_0_7.createVictimTarget(var_13_0))
end

function var_0_10._getVictimTarget97(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs((arg_14_1.battleData:getKnightList(arg_14_1.attacker.opIdentity, nil, arg_14_1.attacker))) do
		if iter_14_1.knightCfg.quality >= 4 then
			var_0_4.insert(var_14_0, iter_14_1)
		else
			var_0_4.insert(var_14_1, iter_14_1)
		end
	end

	if #var_14_0 < arg_14_1.range_value then
		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			var_0_5(arg_14_0, var_0_7.createVictimTarget(iter_14_3))
		end

		for iter_14_4, iter_14_5 in ipairs((var_0_7.getRandomN(var_14_1, arg_14_1.range_value - #var_14_0, arg_14_1.battleField))) do
			var_0_5(arg_14_0, var_0_7.createVictimTarget(iter_14_5))
		end
	else
		for iter_14_6, iter_14_7 in ipairs(#var_14_0 == arg_14_1.range_value and var_14_0 or var_0_7.getRandomN(var_14_0, arg_14_1.range_value, arg_14_1.battleField)) do
			var_0_5(arg_14_0, var_0_7.createVictimTarget(iter_14_7))
		end
	end
end

function var_0_10._getVictimTarget98(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.battleData:getKnightList(arg_15_1.attacker.opIdentity, nil, arg_15_1.attacker)

	for iter_15_0 = 1, #var_15_0 do
		if var_15_0[iter_15_0]:getMarkLevel(125) > 0 then
			var_0_5(arg_15_0, var_0_7.createVictimTarget(var_15_0[iter_15_0]))
		end
	end
end

function var_0_10._getVictimTarget99(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.battleData:getKnightList(arg_16_1.attacker.opIdentity, nil, arg_16_1.attacker)
	local var_16_1 = {}
	local var_16_2 = {}

	for iter_16_0 = 1, #var_16_0 do
		if var_16_0[iter_16_0]:getBuffCount(1386, false, false) > 0 then
			var_16_1[#var_16_1 + 1] = var_16_0[iter_16_0]
		else
			var_16_2[#var_16_2 + 1] = var_16_0[iter_16_0]
		end
	end

	if arg_16_1.range_value <= #var_16_2 then
		for iter_16_1, iter_16_2 in ipairs((var_0_7.getRandomN(var_16_2, arg_16_1.range_value, arg_16_1.battleField))) do
			var_0_5(arg_16_0, var_0_7.createVictimTarget(iter_16_2))
		end
	else
		for iter_16_3, iter_16_4 in ipairs(var_16_2) do
			var_0_5(arg_16_0, var_0_7.createVictimTarget(iter_16_4))
		end

		for iter_16_5, iter_16_6 in ipairs((var_0_7.getRandomN(var_16_1, arg_16_1.range_value - #var_16_2, arg_16_1.battleField))) do
			var_0_5(arg_16_0, var_0_7.createVictimTarget(iter_16_6))
		end
	end
end

function var_0_10._getVictimTarget186(arg_17_0, arg_17_1)
	local var_17_0 = var_0_7.getSpKnights(arg_17_1, arg_17_1.attacker.identity, "hpRate", arg_17_1.range_value, false)

	for iter_17_0 = 1, #var_17_0 do
		var_0_5(arg_17_0, var_0_7.createVictimTarget(var_17_0[iter_17_0]))
	end
end

function var_0_10._getVictimTarget187(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.battleData:getKnightList(arg_18_1.attacker.identity, nil, arg_18_1.attacker)
	local var_18_1 = {}

	for iter_18_0 = 1, #var_18_0 do
		if var_18_0[iter_18_0]:getBuffCount(1326, false, false) < 1 then
			var_18_1[#var_18_1 + 1] = var_18_0[iter_18_0]
		end
	end

	for iter_18_1, iter_18_2 in ipairs((var_0_7.getRandomN(var_18_1, arg_18_1.range_value, arg_18_1.battleField))) do
		var_0_5(arg_18_0, var_0_7.createVictimTarget(iter_18_2))
	end
end

function var_0_10._getVictimTarget188(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.battleData:getKnightList(arg_19_1.attacker.identity, nil, arg_19_1.attacker)
	local var_19_1 = {}
	local var_19_2 = {}

	for iter_19_0 = 1, #var_19_0 do
		if var_19_0[iter_19_0]:getBuffCount(1341, false, false) > 0 then
			var_19_1[#var_19_1 + 1] = var_19_0[iter_19_0]
		else
			var_19_2[#var_19_2 + 1] = var_19_0[iter_19_0]
		end
	end

	if arg_19_1.range_value <= #var_19_2 then
		for iter_19_1, iter_19_2 in ipairs((var_0_7.getRandomN(var_19_2, arg_19_1.range_value, arg_19_1.battleField))) do
			var_0_5(arg_19_0, var_0_7.createVictimTarget(iter_19_2))
		end
	else
		for iter_19_3, iter_19_4 in ipairs(var_19_2) do
			var_0_5(arg_19_0, var_0_7.createVictimTarget(iter_19_4))
		end

		for iter_19_5, iter_19_6 in ipairs((var_0_7.getRandomN(var_19_1, arg_19_1.range_value - #var_19_2, arg_19_1.battleField))) do
			var_0_5(arg_19_0, var_0_7.createVictimTarget(iter_19_6))
		end
	end
end

function var_0_10._getVictimTarget189(arg_20_0, arg_20_1)
	local var_20_1 = arg_20_1.battleData:getKnightList(arg_20_1.attacker.opIdentity, nil, arg_20_1.attacker)
	local var_20_2 = {}
	local var_20_3 = {}

	for iter_20_0 = 1, #var_20_1 do
		if var_20_1[iter_20_0]:getBuffCount(1175, false, false) > 0 then
			var_20_2[#var_20_2 + 1] = var_20_1[iter_20_0]
		else
			var_20_3[#var_20_3 + 1] = var_20_1[iter_20_0]
		end
	end

	if arg_20_1.range_value <= #var_20_3 then
		for iter_20_1, iter_20_2 in ipairs((var_0_7.getRandomN(var_20_3, arg_20_1.range_value, arg_20_1.battleField))) do
			var_0_5(arg_20_0, var_0_7.createVictimTarget(iter_20_2))
		end
	else
		for iter_20_3, iter_20_4 in ipairs(var_20_3) do
			var_0_5(arg_20_0, var_0_7.createVictimTarget(iter_20_4))
		end

		for iter_20_5, iter_20_6 in ipairs((var_0_7.getRandomN(var_20_2, arg_20_1.range_value - #var_20_3, arg_20_1.battleField))) do
			var_0_5(arg_20_0, var_0_7.createVictimTarget(iter_20_6))
		end
	end
end

function var_0_10._getVictimTarget190(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1.battleData:getKnightList(arg_21_1.attacker.identity, nil, arg_21_1.attacker)

	for iter_21_0 = 1, #var_21_0 do
		if var_21_0[iter_21_0]:getMarkLevel(100770) >= arg_21_1.range_value then
			var_0_5(arg_21_0, var_0_7.createVictimTarget(var_21_0[iter_21_0]))
		end
	end
end

function var_0_10._getVictimTarget191(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = var_0_7.getRandomMaxTargetsGroupN(arg_22_1.battleData:getKnightList(arg_22_1.attacker.identity, nil, arg_22_1.attacker), "ATTACK", true, arg_22_1.battleField, arg_22_1.range_value)

	for iter_22_0 = 1, #var_22_0 do
		var_0_5(arg_22_0, var_0_7.createVictimTarget(var_22_0[iter_22_0]))
	end
end

function var_0_10._getVictimTarget192(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1.battleData:getKnightList(arg_23_1.attacker.identity, nil, arg_23_1.attacker)
	local var_23_1 = var_0_7.getRandomMaxTargetsGroupN(var_23_0, "ATTACK", true, arg_23_1.battleField, #var_23_0)

	if #var_23_1 > 0 then
		var_0_5(arg_23_0, var_0_7.createVictimTarget(var_0_4.remove(var_23_1, 1)))
		var_0_5(arg_23_0, var_0_7.createVictimTarget(var_0_7.getRandomN(var_23_1, 1, arg_23_1.battleField)[1]))
	end
end

function var_0_10._getVictimTarget193(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.battleData:getKnightList(arg_24_1.attacker.identity, nil, arg_24_1.attacker)
	local var_24_1 = {}

	for iter_24_0 = 1, #var_24_0 do
		if var_24_0[iter_24_0]:getBuffCount(1394, false, false) < 1 then
			var_24_1[#var_24_1 + 1] = var_24_0[iter_24_0]
		end
	end

	for iter_24_1, iter_24_2 in ipairs((var_0_7.getRandomN(var_24_1, arg_24_1.range_value, arg_24_1.battleField))) do
		var_0_5(arg_24_0, var_0_7.createVictimTarget(iter_24_2))
	end
end

function var_0_10._getVictimTarget194(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.battleData:getKnightList(arg_25_1.attacker.identity, nil, arg_25_1.attacker)
	local var_25_1 = {}

	for iter_25_0 = 1, #var_25_0 do
		if var_25_0[iter_25_0]:getMarkLevel(132) > 0 then
			var_25_1[#var_25_1 + 1] = var_25_0[iter_25_0]
		end
	end

	for iter_25_1, iter_25_2 in ipairs((var_0_7.getRandomN(var_25_1, arg_25_1.range_value, arg_25_1.battleField))) do
		var_0_5(arg_25_0, var_0_7.createVictimTarget(iter_25_2))
	end
end

function var_0_10._getVictimTarget195(arg_26_0, arg_26_1)
	local var_26_1 = arg_26_1.battleData:getKnightList(arg_26_1.attacker.identity, nil, arg_26_1.attacker)

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		if iter_26_1.serialId == arg_26_1.attacker.serialId then
			var_0_4.remove(var_26_1, iter_26_0)

			break
		end
	end

	if arg_26_1.range_value <= #var_26_1 then
		for iter_26_2, iter_26_3 in ipairs((var_0_7.getRandomN(var_26_1, arg_26_1.range_value, arg_26_1.battleField))) do
			var_0_5(arg_26_0, var_0_7.createVictimTarget(iter_26_3))
		end
	else
		for iter_26_4, iter_26_5 in ipairs(var_26_1) do
			var_0_5(arg_26_0, var_0_7.createVictimTarget(iter_26_5))
		end
	end
end

function var_0_10._getVictimTarget196(arg_27_0, arg_27_1)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1.battleData:getKnightList(arg_27_1.attacker.identity, nil, arg_27_1.attacker)) do
		if iter_27_1:getBuffCount(26489, nil, true) > 0 then
			var_0_4.insert(var_27_0, iter_27_1)
		end
	end

	if arg_27_1.range_value <= #var_27_0 then
		for iter_27_2, iter_27_3 in ipairs((var_0_7.getRandomN(var_27_0, arg_27_1.range_value, arg_27_1.battleField))) do
			var_0_5(arg_27_0, var_0_7.createVictimTarget(iter_27_3))
		end
	else
		for iter_27_4, iter_27_5 in ipairs(var_27_0) do
			var_0_5(arg_27_0, var_0_7.createVictimTarget(iter_27_5))
		end
	end
end

function var_0_10._getVictimTarget197(arg_28_0, arg_28_1)
	local var_28_0 = var_0_7.getRandomMaxTargetsGroupN(arg_28_1.battleData:getKnightList(arg_28_1.attacker.identity, nil, arg_28_1.attacker), "totalDef", true, arg_28_1.battleField, arg_28_1.range_value)

	for iter_28_0 = 1, #var_28_0 do
		var_0_5(arg_28_0, var_0_7.createVictimTarget(var_28_0[iter_28_0]))
	end
end

function var_0_10._getVictimTarget198(arg_29_0, arg_29_1)
	local var_29_0 = var_0_7.getRandomMaxTargetsGroupN(arg_29_1.battleData:getKnightList(arg_29_1.attacker.identity, nil, arg_29_1.attacker), "INITIAL_THRESH", true, arg_29_1.battleField, arg_29_1.range_value)

	for iter_29_0 = 1, #var_29_0 do
		var_0_5(arg_29_0, var_0_7.createVictimTarget(var_29_0[iter_29_0]))
	end
end

function var_0_10._getVictimTarget258(arg_30_0, arg_30_1, arg_30_2)
	local var_30_1 = arg_30_1.range_value

	for iter_30_0, iter_30_1 in ipairs(arg_30_2[#arg_30_2] or {}) do
		if var_30_1 >= iter_30_1.victim.baseInfo.hpRate then
			var_0_5(arg_30_0, var_0_7.copyTarget(iter_30_1))
		end
	end
end

function var_0_10._getVictimTarget259(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_2[#arg_31_2] or {}
	local var_31_1 = arg_31_1.range_value

	if arg_31_1.range_value >= #var_31_0 then
		for iter_31_0, iter_31_1 in ipairs(var_31_0) do
			var_0_5(arg_31_0, var_0_7.copyTarget(iter_31_1))
		end
	else
		for iter_31_2, iter_31_3 in ipairs((var_0_7.getRandomN(var_31_0, var_31_1, arg_31_1.battleField))) do
			var_0_5(arg_31_0, var_0_7.copyTarget(iter_31_3))
		end
	end
end

function var_0_10._getVictimTarget260(arg_32_0, arg_32_1, arg_32_2)
	for iter_32_0, iter_32_1 in ipairs(arg_32_2[1] or {}) do
		for iter_32_2, iter_32_3 in ipairs(iter_32_1.victim:getBuffs()) do
			if iter_32_3.buffCfg.buff_type == 2 and iter_32_3.buffCfg.buff_increase_type == 2 then
				var_0_5(arg_32_0, var_0_7.copyTarget(iter_32_1))

				break
			end
		end
	end
end

function var_0_10._getVictimTarget261(arg_33_0, arg_33_1, arg_33_2)
	for iter_33_0, iter_33_1 in ipairs(arg_33_2[1] or {}) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1.victim:getBuffs()) do
			if iter_33_3.buffCfg.buff_control_type == 1 then
				var_0_5(arg_33_0, var_0_7.copyTarget(iter_33_1))

				break
			end
		end
	end
end

function var_0_10._getVictimTarget262(arg_34_0, arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in ipairs(arg_34_2[arg_34_1.range_value] or {}) do
		var_0_5(arg_34_0, var_0_7.copyTarget(iter_34_1))
	end
end

function var_0_10._getVictimTarget263(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1.battleData:getKnightList(arg_35_1.attacker.opIdentity, true, arg_35_1.attacker)
	local var_35_1 = {}
	local var_35_2 = {}

	for iter_35_0 = 1, #var_35_0 do
		if var_35_0[iter_35_0]:getBuffCount(1035, false, false) > 0 then
			var_35_1[#var_35_1 + 1] = var_35_0[iter_35_0]
		else
			var_35_2[#var_35_2 + 1] = var_35_0[iter_35_0]
		end
	end

	if arg_35_1.range_value <= #var_35_1 then
		for iter_35_1, iter_35_2 in ipairs((var_0_7.getRandomN(var_35_1, arg_35_1.range_value, arg_35_1.battleField))) do
			var_0_5(arg_35_0, var_0_7.createVictimTarget(iter_35_2, true))
		end
	else
		for iter_35_3, iter_35_4 in ipairs(var_35_1) do
			var_0_5(arg_35_0, var_0_7.createVictimTarget(iter_35_4, true))
		end

		for iter_35_5, iter_35_6 in ipairs((var_0_7.getRandomN(var_35_2, arg_35_1.range_value - #var_35_1, arg_35_1.battleField))) do
			var_0_5(arg_35_0, var_0_7.createVictimTarget(iter_35_6, true))
		end
	end
end

function var_0_10._getVictimTarget264(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1.battleData:getKnightList(arg_36_1.attacker.opIdentity, nil, arg_36_1.attacker)

	for iter_36_0 = 1, #var_36_0 do
		if arg_36_1.range_value <= var_36_0[iter_36_0]:getBuffCount(1391, false, false) then
			var_0_5(arg_36_0, var_0_7.createVictimTarget(var_36_0[iter_36_0]))
		end
	end
end

function var_0_10._getVictimTarget265(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = var_0_7.getMaxTargetsN(arg_37_1, arg_37_1.attacker.opIdentity, "ATTACK", true, 6)

	for iter_37_0 = 1, #var_37_0 do
		local var_37_1

		if var_37_0[iter_37_0]:getBuffCount(1324, false) <= 0 then
			if 0 < arg_37_1.range_value then
				var_0_5(arg_37_0, var_0_7.createVictimTarget(var_37_0[iter_37_0]))

				var_37_1 = 0 + 1
			else
				break
			end
		end
	end
end

function var_0_10._getVictimTarget266(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = var_0_7.getMaxTargetsN(arg_38_1, arg_38_1.attacker.opIdentity, "hpRate", true, 6)

	for iter_38_0 = #var_38_0, 1, -1 do
		local var_38_1

		if var_38_0[iter_38_0]:getBuffCount(1324, false) <= 0 then
			if 0 < arg_38_1.range_value then
				var_0_5(arg_38_0, var_0_7.createVictimTarget(var_38_0[iter_38_0]))

				var_38_1 = 0 + 1
			else
				break
			end
		end
	end
end

function var_0_10._getVictimTarget267(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_1.battleData:getKnightList(arg_39_1.attacker.opIdentity, nil, arg_39_1.attacker)
	local var_39_1 = {}

	for iter_39_0 = 1, #var_39_0 do
		if var_39_0[iter_39_0]:getBuffCount(1324) > 0 then
			var_39_1[#var_39_1 + 1] = var_39_0[iter_39_0]
		end
	end

	if arg_39_1.range_value <= #var_39_1 then
		for iter_39_1, iter_39_2 in ipairs((var_0_7.getRandomN(var_39_1, arg_39_1.range_value, arg_39_1.battleField))) do
			var_0_5(arg_39_0, var_0_7.createVictimTarget(iter_39_2))
		end
	end
end

function var_0_10._getVictimTarget268(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1.battleData:getKnights()
	local var_40_1 = {}

	for iter_40_0 = 4, 6 do
		local var_40_3 = var_40_0:getKnightByIdAndPos(arg_40_1.attacker.identity, iter_40_0)

		if var_40_3 and var_40_3:isValid(arg_40_1.attacker) then
			if arg_40_1.attacker.serialId ~= var_40_3.serialId then
				var_0_5(var_40_1, var_40_3)
			end
		end
	end

	if #var_40_1 <= 0 then
		for iter_40_1 = 1, 3 do
			local var_40_5 = var_40_0:getKnightByIdAndPos(arg_40_1.attacker.identity, iter_40_1)

			if var_40_5 and var_40_5:isValid(arg_40_1.attacker) and arg_40_1.attacker.serialId ~= var_40_5.serialId then
				var_0_5(var_40_1, var_40_5)
			end
		end
	end

	if arg_40_1.range_value <= #var_40_1 then
		for iter_40_2, iter_40_3 in ipairs((var_0_7.getRandomN(var_40_1, arg_40_1.range_value, arg_40_1.battleField))) do
			var_0_5(arg_40_0, var_0_7.createVictimTarget(iter_40_3, true))
		end
	else
		for iter_40_4, iter_40_5 in ipairs(var_40_1) do
			var_0_5(arg_40_0, var_0_7.createVictimTarget(iter_40_5, true))
		end
	end
end

function var_0_10._getVictimTarget269(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_1.battleData:getKnightList(arg_41_1.attacker.opIdentity, nil, arg_41_1.attacker)) do
		if iter_41_1:getBuffCount(2016, false, false) > 0 then
			var_0_5(var_41_0, iter_41_1)
		end
	end

	for iter_41_2, iter_41_3 in ipairs(var_0_7.getRandomN(var_41_0, arg_41_1.range_value, arg_41_1.battleField)) do
		var_0_5(arg_41_0, var_0_7.createVictimTarget(iter_41_3))
	end
end

function var_0_10._getVictimTarget270(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_1.battleData:getKnights()
	local var_42_1 = {}

	for iter_42_0 = 1, 3 do
		local var_42_3 = var_42_0:getKnightByIdAndPos(arg_42_1.attacker.opIdentity, iter_42_0)

		if var_42_3 and var_42_3:isValid(arg_42_1.attacker) then
			if arg_42_1.attacker.serialId ~= var_42_3.serialId then
				var_0_5(var_42_1, var_42_3)
			end
		end
	end

	if #var_42_1 <= 0 then
		for iter_42_1 = 4, 6 do
			local var_42_5 = var_42_0:getKnightByIdAndPos(arg_42_1.attacker.opIdentity, iter_42_1)

			if var_42_5 and var_42_5:isValid(arg_42_1.attacker) and arg_42_1.attacker.serialId ~= var_42_5.serialId then
				var_0_5(var_42_1, var_42_5)
			end
		end
	end

	if arg_42_1.range_value <= #var_42_1 then
		for iter_42_2, iter_42_3 in ipairs((var_0_7.getRandomN(var_42_1, arg_42_1.range_value, arg_42_1.battleField))) do
			var_0_5(arg_42_0, var_0_7.createVictimTarget(iter_42_3, true))
		end
	else
		for iter_42_4, iter_42_5 in ipairs(var_42_1) do
			var_0_5(arg_42_0, var_0_7.createVictimTarget(iter_42_5, true))
		end
	end
end

function var_0_10._getVictimTarget271(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_1.battleData:getKnightList(arg_43_1.attacker.identity, nil, arg_43_1.attacker)

	var_0_4.sort(var_43_0, function(arg_44_0, arg_44_1)
		return arg_44_0.knightCfg.quality > arg_44_1.knightCfg.quality
	end)

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if arg_43_1.range_value < iter_43_0 then
			break
		end

		var_0_5(arg_43_0, var_0_7.createVictimTarget(iter_43_1))
	end
end

function var_0_10._getVictimTarget272(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_1.battleData:getKnightList(arg_45_1.attacker.identity, nil, arg_45_1.attacker)
	local var_45_1 = {}

	for iter_45_0 = 1, #var_45_0 do
		if var_45_0[iter_45_0]:getBuffCount(2023, false, false) > 0 or var_45_0[iter_45_0]:getBuffCount(2024, false, false) > 0 then
			var_45_1[#var_45_1 + 1] = var_45_0[iter_45_0]
		end
	end

	for iter_45_1, iter_45_2 in ipairs(var_0_7.getRandomN(var_45_1, arg_45_1.range_value, arg_45_1.battleField)) do
		var_0_5(arg_45_0, var_0_7.createVictimTarget(iter_45_2))
	end
end

function var_0_10._getVictimTarget273(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_1.battleData:getKnightList(arg_46_1.attacker.identity, nil, arg_46_1.attacker)
	local var_46_1 = {}

	for iter_46_0 = 1, #var_46_0 do
		if var_46_0[iter_46_0]:getBuffCount(2023, false, false) > 0 then
			var_46_1[#var_46_1 + 1] = var_46_0[iter_46_0]
		end
	end

	for iter_46_1, iter_46_2 in ipairs(var_0_7.getRandomN(var_46_1, arg_46_1.range_value, arg_46_1.battleField)) do
		var_0_5(arg_46_0, var_0_7.createVictimTarget(iter_46_2))
	end
end

function var_0_10._getVictimTarget274(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_1.battleData:getKnightList(arg_47_1.attacker.identity, nil, arg_47_1.attacker)
	local var_47_1 = {}

	for iter_47_0 = 1, #var_47_0 do
		if var_47_0[iter_47_0]:getBuffCount(2024, false, false) > 0 then
			var_47_1[#var_47_1 + 1] = var_47_0[iter_47_0]
		end
	end

	for iter_47_1, iter_47_2 in ipairs(var_0_7.getRandomN(var_47_1, arg_47_1.range_value, arg_47_1.battleField)) do
		var_0_5(arg_47_0, var_0_7.createVictimTarget(iter_47_2))
	end
end

function var_0_10._getVictimTarget275(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = {}
	local var_48_1 = arg_48_1.battleData:getKnights()

	for iter_48_0 = 1, 3 do
		local var_48_2 = var_48_1:getKnightByIdAndPos(arg_48_1.attacker.identity, iter_48_0)

		if var_48_2 and var_48_2:isValid(arg_48_1.attacker) then
			var_48_0[#var_48_0 + 1] = var_48_2
		end
	end

	if #arg_48_0 == 0 then
		for iter_48_1 = 4, 6 do
			local var_48_3 = var_48_1:getKnightByIdAndPos(arg_48_1.attacker.identity, iter_48_1)

			if var_48_3 and var_48_3:isValid(arg_48_1.attacker) then
				var_48_0[#var_48_0 + 1] = var_48_3
			end
		end
	end

	for iter_48_2, iter_48_3 in ipairs(var_0_7.getRandomN(var_48_0, 1, arg_48_1.battleField)) do
		var_0_5(arg_48_0, var_0_7.createVictimTarget(iter_48_3))
	end
end

function var_0_10._getVictimTarget276(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = {}
	local var_49_1 = arg_49_1.battleData:getKnights()

	for iter_49_0 = 1, 3 do
		local var_49_2 = var_49_1:getKnightByIdAndPos(arg_49_1.attacker.identity, iter_49_0)

		if var_49_2 and var_49_2:isValid(arg_49_1.attacker) then
			var_49_0[#var_49_0 + 1] = var_49_2
		end
	end

	if #arg_49_0 == 0 then
		for iter_49_1 = 4, 6 do
			local var_49_3 = var_49_1:getKnightByIdAndPos(arg_49_1.attacker.identity, iter_49_1)

			if var_49_3 and var_49_3:isValid(arg_49_1.attacker) then
				var_49_0[#var_49_0 + 1] = var_49_3
			end
		end
	end

	for iter_49_2, iter_49_3 in ipairs(var_0_7.getRandomN(var_49_0, 2, arg_49_1.battleField)) do
		var_0_5(arg_49_0, var_0_7.createVictimTarget(iter_49_3))
	end
end

function var_0_10._getVictimTarget277(arg_50_0, arg_50_1)
	local var_50_0 = {}

	for iter_50_0, iter_50_1 in ipairs(arg_50_1.battleData:getKnightList(arg_50_1.attacker.opIdentity, nil, arg_50_1.attacker)) do
		if iter_50_1:getBuffCount(2028, false, false) > 0 then
			var_0_5(var_50_0, iter_50_1)
		end
	end

	for iter_50_2, iter_50_3 in ipairs((var_0_7.getRandomN(var_50_0, arg_50_1.range_value, arg_50_1.battleField))) do
		var_0_5(arg_50_0, var_0_7.createVictimTarget(iter_50_3))
	end
end

function var_0_10._getVictimTarget278(arg_51_0, arg_51_1)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in ipairs(arg_51_1.battleData:getKnightList(arg_51_1.attacker.identity, nil, arg_51_1.attacker)) do
		if iter_51_1.serialId ~= arg_51_1.attacker.serialId then
			var_0_4.insert(var_51_0, iter_51_1)
		end
	end

	for iter_51_2, iter_51_3 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_51_0, "hpRate", false, arg_51_1.battleField, arg_51_1.range_value))) do
		var_0_5(arg_51_0, var_0_7.createVictimTarget(iter_51_3))
	end
end

function var_0_10._getVictimTarget279(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_1.battleData:getKnights()
	local var_52_1 = {}

	for iter_52_0 = 1, 3 do
		local var_52_2 = var_52_0:getKnightByIdAndPos(arg_52_1.attacker.identity, iter_52_0)

		if var_52_2 and var_52_2:isValid(arg_52_1.attacker) then
			var_0_5(var_52_1, var_52_2)
		end
	end

	if #var_52_1 == 0 then
		for iter_52_1 = 4, 6 do
			local var_52_3 = var_52_0:getKnightByIdAndPos(arg_52_1.attacker.identity, iter_52_1)

			if var_52_3 and var_52_3:isValid(arg_52_1.attacker) then
				var_0_5(var_52_1, var_52_3)
			end
		end
	end

	for iter_52_2, iter_52_3 in ipairs(var_52_1) do
		if arg_52_1.range_value == 0 or iter_52_3.classical == arg_52_1.range_value then
			var_0_5(arg_52_0, var_0_7.createVictimTarget(iter_52_3))
		end
	end
end

function var_0_10._getVictimTarget280(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1.attacker

	if arg_53_1.attacker.isPlayer then
		var_53_0 = var_0_7.getRandomKnight(arg_53_1, arg_53_1.attacker.identity)
	end

	if arg_53_1.range_value == 0 or var_53_0.classical == arg_53_1.range_value then
		var_0_5(arg_53_0, var_0_7.createVictimTarget(var_53_0))
	end
end

function var_0_10._getVictimTarget281(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_1.battleData:getKnights()
	local var_54_1

	for iter_54_0 = 1, 3 do
		local var_54_2 = var_54_0:getKnightByIdAndPos(arg_54_1.attacker.opIdentity, iter_54_0)

		if var_54_2 and var_54_2:isValid(arg_54_1.attacker) and (not var_54_1 or var_54_1.advanceInfo.INITIAL_HP > var_54_2.advanceInfo.INITIAL_HP) then
			var_54_1 = var_54_2
		end
	end

	if not var_54_1 then
		for iter_54_1 = 4, 6 do
			local var_54_3 = var_54_0:getKnightByIdAndPos(arg_54_1.attacker.opIdentity, iter_54_1)

			if var_54_3 and var_54_3:isValid(arg_54_1.attacker) and (not var_54_1 or var_54_1.advanceInfo.INITIAL_HP > var_54_3.advanceInfo.INITIAL_HP) then
				var_54_1 = var_54_3
			end
		end
	end

	if var_54_1 then
		var_0_5(arg_54_0, var_0_7.createVictimTarget(var_54_1))
	end
end

function var_0_10._getVictimTarget282(arg_55_0, arg_55_1)
	for iter_55_0, iter_55_1 in arg_55_1.battleData:getKnights():ipairs(arg_55_1.attacker.opIdentity) do
		if iter_55_1:isValid() then
			var_0_5(arg_55_0, var_0_7.createVictimTarget(iter_55_1))

			return
		end
	end
end

function var_0_10._getVictimTarget283(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_1.battleData:getKnights()

	for iter_56_0 = 1, 3 do
		local var_56_1 = var_56_0:getKnightByIdAndPos(arg_56_1.attacker.opIdentity, iter_56_0)
		local var_56_2 = var_56_0:getKnightByIdAndPos(arg_56_1.attacker.opIdentity, iter_56_0 + 3)

		if var_56_1 or var_56_2 then
			var_0_5(arg_56_0, var_0_7.createVictimTarget(var_56_1))
			var_0_5(arg_56_0, var_0_7.createVictimTarget(var_56_2))

			return
		end
	end
end

function var_0_10._getVictimTarget284(arg_57_0, arg_57_1)
	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(arg_57_1.battleData:getKnightList(arg_57_1.attacker.identity, nil, arg_57_1.attacker)) do
		if iter_57_1:getBuffCount(2051, false, false) > 0 then
			var_0_5(var_57_0, iter_57_1)
		end
	end

	for iter_57_2, iter_57_3 in ipairs((var_0_7.getRandomN(var_57_0, arg_57_1.range_value, arg_57_1.battleField))) do
		var_0_5(arg_57_0, var_0_7.createVictimTarget(iter_57_3))
	end
end

function var_0_10._getVictimTarget285(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1.battleData:getKnights()
	local var_58_1 = false

	for iter_58_0 = 1, 3 do
		local var_58_2 = var_58_0:getKnightByIdAndPos(arg_58_1.attacker.opIdentity, iter_58_0)

		if var_58_2 and var_58_2:isValid(arg_58_1.attacker) then
			var_58_1 = true

			if arg_58_1.range_value == 0 then
				var_0_5(arg_58_0, var_0_7.createVictimTarget(var_58_2))
			elseif arg_58_1.range_value == var_58_2.classical then
				var_0_5(arg_58_0, var_0_7.createVictimTarget(var_58_2))
			end
		end
	end

	if not var_58_1 then
		for iter_58_1 = 4, 6 do
			local var_58_3 = var_58_0:getKnightByIdAndPos(arg_58_1.attacker.opIdentity, iter_58_1)

			if var_58_3 and var_58_3:isValid(arg_58_1.attacker) then
				if arg_58_1.range_value == 0 then
					var_0_5(arg_58_0, var_0_7.createVictimTarget(var_58_3))
				elseif arg_58_1.range_value == var_58_3.classical then
					var_0_5(arg_58_0, var_0_7.createVictimTarget(var_58_3))
				end
			end
		end
	end
end

function var_0_10._getVictimTarget286(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_1.battleData:getKnights()
	local var_59_1 = false

	for iter_59_0 = 1, 3 do
		local var_59_2 = var_59_0:getKnightByIdAndPos(arg_59_1.attacker.opIdentity, iter_59_0)

		if var_59_2 and var_59_2:isValid(arg_59_1.attacker) then
			var_59_1 = true

			if arg_59_1.range_value <= var_59_2.advanceInfo.hpRate then
				var_0_5(arg_59_0, var_0_7.createVictimTarget(var_59_2))
			end
		end
	end

	if not var_59_1 then
		for iter_59_1 = 4, 6 do
			local var_59_3 = var_59_0:getKnightByIdAndPos(arg_59_1.attacker.opIdentity, iter_59_1)

			if var_59_3 and var_59_3:isValid(arg_59_1.attacker) and arg_59_1.range_value <= var_59_3.advanceInfo.hpRate then
				var_0_5(arg_59_0, var_0_7.createVictimTarget(var_59_3))
			end
		end
	end
end

function var_0_10._getVictimTarget287(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_1.battleData:getKnights()
	local var_60_1 = false

	for iter_60_0 = 1, 3 do
		local var_60_2 = var_60_0:getKnightByIdAndPos(arg_60_1.attacker.opIdentity, iter_60_0)

		if var_60_2 and var_60_2:isValid(arg_60_1.attacker) then
			var_60_1 = true

			if var_60_2.advanceInfo.SHIELD > 0 then
				var_0_5(arg_60_0, var_0_7.createVictimTarget(var_60_2))
			end
		end
	end

	if not var_60_1 then
		for iter_60_1 = 4, 6 do
			local var_60_3 = var_60_0:getKnightByIdAndPos(arg_60_1.attacker.opIdentity, iter_60_1)

			if var_60_3 and var_60_3:isValid(arg_60_1.attacker) and var_60_3.advanceInfo.SHIELD > 0 then
				var_0_5(arg_60_0, var_0_7.createVictimTarget(var_60_3))
			end
		end
	end
end

function var_0_10._getVictimTarget290(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_1.battleData:getKnights()
	local var_61_1 = false

	for iter_61_0 = 4, 6 do
		local var_61_2 = var_61_0:getKnightByIdAndPos(arg_61_1.attacker.identity, iter_61_0)

		if var_61_2 and var_61_2:isValid(arg_61_1.attacker) then
			var_61_1 = true

			if arg_61_1.range_value == 0 then
				var_0_5(arg_61_0, var_0_7.createVictimTarget(var_61_2))
			elseif arg_61_1.range_value == var_61_2.classical then
				var_0_5(arg_61_0, var_0_7.createVictimTarget(var_61_2))
			end
		end
	end

	if not var_61_1 then
		for iter_61_1 = 1, 3 do
			local var_61_3 = var_61_0:getKnightByIdAndPos(arg_61_1.attacker.identity, iter_61_1)

			if var_61_3 and var_61_3:isValid(arg_61_1.attacker) then
				if arg_61_1.range_value == 0 then
					var_0_5(arg_61_0, var_0_7.createVictimTarget(var_61_3))
				elseif arg_61_1.range_value == var_61_3.classical then
					var_0_5(arg_61_0, var_0_7.createVictimTarget(var_61_3))
				end
			end
		end
	end
end

function var_0_10._getVictimTarget291(arg_62_0, arg_62_1)
	for iter_62_0, iter_62_1 in ipairs((arg_62_1.battleData:getKnightList(arg_62_1.attacker.identity, nil, arg_62_1.attacker))) do
		if arg_62_1.range_value == iter_62_1.classical then
			var_0_5(arg_62_0, var_0_7.createVictimTarget(iter_62_1))
		end
	end
end

function var_0_10._getVictimTarget292(arg_63_0, arg_63_1)
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in ipairs((arg_63_1.battleData:getKnightList(arg_63_1.attacker.identity, nil, arg_63_1.attacker))) do
		if iter_63_1.knightCfg.quality == 4 then
			local var_63_2 = {
				knight = iter_63_1
			}

			var_63_2.value = iter_63_1.advanceInfo.INITIAL_ENERGY or 0

			var_0_5(var_63_0, var_63_2)
		elseif iter_63_1.knightCfg.quality == 5 then
			local var_63_4 = {
				knight = iter_63_1
			}

			var_63_4.value = iter_63_1.advanceInfo.INITIAL_THRESH or 0

			var_0_5(var_63_0, var_63_4)
		end
	end

	var_0_4.sort(var_63_0, function(arg_64_0, arg_64_1)
		return arg_64_0.value < arg_64_1.value
	end)

	for iter_63_2 = 1, var_0_0.min(arg_63_1.range_value, #var_63_0) do
		var_0_5(arg_63_0, var_0_7.createVictimTarget(var_63_0[iter_63_2].knight))
	end
end

function var_0_10._getVictimTarget300(arg_65_0, arg_65_1)
	for iter_65_0, iter_65_1 in ipairs((arg_65_1.battleData:getKnightList(arg_65_1.attacker.opIdentity, nil, arg_65_1.attacker))) do
		if arg_65_1.range_value == iter_65_1.classical then
			var_0_5(arg_65_0, var_0_7.createVictimTarget(iter_65_1))
		end
	end
end

function var_0_10._getVictimTarget304(arg_66_0, arg_66_1)
	local var_66_0 = -1
	local var_66_1 = {}

	for iter_66_0, iter_66_1 in ipairs((arg_66_1.battleData:getKnightList(arg_66_1.attacker.opIdentity, nil, arg_66_1.attacker))) do
		local var_66_2 = iter_66_1:getBuffCount(arg_66_1.range_value, false, false)

		if var_66_0 < var_66_2 then
			var_66_0 = var_66_2
			var_66_1 = {
				iter_66_1
			}
		elseif var_66_0 == var_66_2 then
			var_0_5(var_66_1, iter_66_1)
		end
	end

	if #var_66_1 == 1 then
		var_0_5(arg_66_0, var_0_7.createVictimTarget(var_66_1[1]))
	else
		for iter_66_2, iter_66_3 in ipairs((var_0_7.getRandomN(var_66_1, 1, arg_66_1.battleField))) do
			var_0_5(arg_66_0, var_0_7.createVictimTarget(iter_66_3))
		end
	end
end

function var_0_10._getVictimTarget305(arg_67_0, arg_67_1)
	local var_67_0, var_67_1 = var_0_7.getRangeKnights(arg_67_1.targets[#arg_67_1.targets])
	local var_67_2 = var_0_7.getRandomMaxTargetsGroupN(var_67_0, "ATTACK", true, arg_67_1.battleField, arg_67_1.range_value)

	for iter_67_0 = 1, #var_67_2 do
		var_0_5(arg_67_0, var_0_7.createVictimTarget(var_67_2[iter_67_0]))
	end
end

function var_0_10._getVictimTarget306(arg_68_0, arg_68_1)
	for iter_68_0, iter_68_1 in ipairs((arg_68_1.battleData:getFirstDeadKnightOrder(arg_68_1.attacker.identity))) do
		local var_68_0 = arg_68_1.battleData:getKnightData(iter_68_1)

		if var_68_0 and var_68_0.isDead then
			var_0_5(arg_68_0, var_0_7.createVictimTarget(var_68_0))

			break
		end
	end
end

function var_0_10._getVictimTarget307(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_1.battleData:getKnightList(arg_69_1.attacker.identity, nil, arg_69_1.attacker)
	local var_69_1 = {}

	for iter_69_0 = 1, #var_69_0 do
		if var_69_0[iter_69_0]:getBuffCount(2280, false, false) < 1 then
			var_69_1[#var_69_1 + 1] = var_69_0[iter_69_0]
		end
	end

	for iter_69_1, iter_69_2 in ipairs((var_0_7.getRandomN(var_69_1, arg_69_1.range_value, arg_69_1.battleField))) do
		var_0_5(arg_69_0, var_0_7.createVictimTarget(iter_69_2))
	end
end

function var_0_10._getVictimTarget308(arg_70_0, arg_70_1)
	if not arg_70_1.attacker.isPlayer and arg_70_1.attacker:getHpRate() >= arg_70_1.range_value then
		var_0_5(arg_70_0, var_0_7.createVictimTarget(arg_70_1.attacker))
	end
end

function var_0_10._getVictimTarget309(arg_71_0, arg_71_1)
	if not arg_71_1.attacker.isPlayer and arg_71_1.attacker:getHpRate() < arg_71_1.range_value then
		var_0_5(arg_71_0, var_0_7.createVictimTarget(arg_71_1.attacker))
	end
end

function var_0_10._getVictimTarget310(arg_72_0, arg_72_1)
	local var_72_0 = 99999
	local var_72_1 = {}

	for iter_72_0, iter_72_1 in ipairs((arg_72_1.battleData:getKnightList(arg_72_1.attacker.opIdentity, nil, arg_72_1.attacker))) do
		local var_72_2 = iter_72_1:getBuffCount(arg_72_1.range_value, false, false)

		if var_72_2 < var_72_0 then
			var_72_0 = var_72_2
			var_72_1 = {
				iter_72_1
			}
		elseif var_72_0 == var_72_2 then
			var_0_5(var_72_1, iter_72_1)
		end
	end

	if #var_72_1 == 1 then
		var_0_5(arg_72_0, var_0_7.createVictimTarget(var_72_1[1]))
	else
		for iter_72_2, iter_72_3 in ipairs((var_0_7.getRandomN(var_72_1, 1, arg_72_1.battleField))) do
			var_0_5(arg_72_0, var_0_7.createVictimTarget(iter_72_3))
		end
	end
end

function var_0_10._getVictimTarget311(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_1.battleData:getKnights()

	for iter_73_0 = 1, 6 do
		local var_73_1 = var_73_0:getKnightByIdAndPos(arg_73_1.attacker.identity, iter_73_0)

		if var_73_1 and var_73_1:isReal(arg_73_1.attacker) and not var_73_1.exile and var_73_1:getBuffCount(arg_73_1.range_value) <= 0 then
			var_0_5(arg_73_0, var_0_7.createVictimTarget(var_73_1))
		end
	end
end

function var_0_10._getVictimTarget312(arg_74_0, arg_74_1)
	local var_74_1 = {}
	local var_74_2, var_74_3 = var_0_7.getRangeKnights(arg_74_1.targets[#arg_74_1.targets])

	for iter_74_0, iter_74_1 in ipairs(var_74_2) do
		if iter_74_1.classical == arg_74_1.range_value then
			var_0_5(var_74_1, iter_74_1)
		end
	end

	if #var_74_1 == 0 then
		var_74_1 = var_74_2
	end

	for iter_74_2, iter_74_3 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_74_1, "ATTACK", true, arg_74_1.battleField, 1))) do
		var_0_5(arg_74_0, var_0_7.createVictimTarget(iter_74_3))
	end
end

function var_0_10._getVictimTarget313(arg_75_0, arg_75_1)
	local var_75_0, var_75_1 = var_0_7.getRangeKnights(arg_75_1.targets[#arg_75_1.targets])
	local var_75_2 = var_0_7.getRandomN(var_75_0, arg_75_1.range_value, arg_75_1.battleField)

	for iter_75_0 = 1, #var_75_2 do
		var_0_5(arg_75_0, var_0_7.createVictimTarget(var_75_2[iter_75_0]))
	end
end

function var_0_10._getVictimTarget314(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_1.battleData:getKnights()

	for iter_76_0 = 1, 6 do
		local var_76_1 = var_76_0:getKnightByIdAndPos(3 - arg_76_1.attacker.identity, iter_76_0)

		if var_76_1 and var_76_1:isReal(arg_76_1.attacker) and not var_76_1.exile and var_76_1:getBuffCount(arg_76_1.range_value) <= 0 then
			var_0_5(arg_76_0, var_0_7.createVictimTarget(var_76_1))
		end
	end
end

function var_0_10._getVictimTarget315(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_1.battleData:getKnightList(arg_77_1.attacker.opIdentity, nil, arg_77_1.attacker)

	var_0_4.sort(var_77_0, function(arg_78_0, arg_78_1)
		return arg_78_0:getBuffCount(10001, false, false) > arg_78_1:getBuffCount(10001, false, false)
	end)

	for iter_77_0 = 1, var_0_0.min(arg_77_1.range_value, #var_77_0) do
		var_0_5(arg_77_0, var_0_7.createVictimTarget(var_77_0[iter_77_0]))
	end
end

function var_0_10._getVictimTarget316(arg_79_0, arg_79_1)
	for iter_79_0, iter_79_1 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_0_7.getRangeKnights(arg_79_1.targets[#arg_79_1.targets]), "INITIAL_HP", true, arg_79_1.battleField, arg_79_1.range_value))) do
		var_0_5(arg_79_0, var_0_7.createVictimTarget(iter_79_1))
	end
end

function var_0_10._getVictimTarget317(arg_80_0, arg_80_1)
	local var_80_0 = {}

	for iter_80_0, iter_80_1 in ipairs((var_0_7.getRangeKnights(arg_80_1.targets[#arg_80_1.targets]))) do
		if iter_80_1 ~= arg_80_1.attacker then
			var_0_5(var_80_0, iter_80_1)
		end
	end

	local var_80_1 = {}

	for iter_80_2, iter_80_3 in ipairs(var_80_0) do
		if iter_80_3.classical == arg_80_1.range_value then
			var_0_5(var_80_1, iter_80_3)
		end
	end

	if #var_80_1 > 0 then
		for iter_80_4, iter_80_5 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_80_1, "ATTACK", true, arg_80_1.battleField, 1))) do
			var_0_5(arg_80_0, var_0_7.createVictimTarget(iter_80_5))
		end

		return
	end

	if #var_80_0 > 0 then
		for iter_80_6, iter_80_7 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_80_0, "ATTACK", true, arg_80_1.battleField, 1))) do
			var_0_5(arg_80_0, var_0_7.createVictimTarget(iter_80_7))
		end

		return
	end

	var_0_5(arg_80_0, var_0_7.createVictimTarget(arg_80_1.attacker))
end

function var_0_10._getVictimTarget502(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_1.battleData:getKnightList(arg_81_1.attacker.opIdentity, nil, arg_81_1.attacker)
	local var_81_1
	local var_81_2 = var_0_7.random(1, #var_81_0, arg_81_1.battleField)

	for iter_81_0 = 1, #var_81_0 do
		if var_81_0[var_81_2].knightCfg.advance_id ~= arg_81_1.attacker.knightCfg.advance_id and var_81_0[var_81_2]:getBuffCount(var_0_8.TYPE.TRANSFORM, true) <= 0 then
			var_81_1 = var_81_0[var_81_2]

			break
		end

		var_81_2 = var_81_2 + 1

		if #var_81_0 < var_81_2 then
			var_81_2 = 1
		end
	end

	if var_81_1 then
		var_0_5(arg_81_0, var_0_7.createVictimTarget(var_81_1))
	end
end

function var_0_10._getVictimTarget503(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_1.battleData:getKnightList(arg_82_1.attacker.opIdentity, nil, arg_82_1.attacker)

	for iter_82_0 = 1, #var_82_0 do
		if var_82_0[iter_82_0]:getMarkLevel(130) > 0 then
			var_0_5(arg_82_0, var_0_7.createVictimTarget(var_82_0[iter_82_0]))
		end
	end
end

function var_0_10._getVictimTarget504(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_1.battleData:getKnightList(arg_83_1.attacker.opIdentity, nil, arg_83_1.attacker)

	for iter_83_0 = 1, #var_83_0 do
		if var_83_0[iter_83_0]:getBuffCount(arg_83_1.range_value) > 0 then
			var_0_5(arg_83_0, var_0_7.createVictimTarget(var_83_0[iter_83_0]))
		end
	end
end

function var_0_10._getVictimTarget505(arg_84_0, arg_84_1)
	local var_84_0 = {}

	for iter_84_0, iter_84_1 in ipairs((arg_84_1.battleData:getKnightList(arg_84_1.attacker.opIdentity, nil, arg_84_1.attacker))) do
		if iter_84_1:getBuffCount(1415) <= 0 then
			var_0_5(var_84_0, iter_84_1)
		end
	end

	if arg_84_1.range_value >= #var_84_0 then
		for iter_84_2, iter_84_3 in ipairs(var_84_0) do
			var_0_5(arg_84_0, var_0_7.createVictimTarget(iter_84_3))
		end
	else
		for iter_84_4, iter_84_5 in ipairs((var_0_7.getRandomN(var_84_0, arg_84_1.range_value, arg_84_1.battleField))) do
			var_0_5(arg_84_0, var_0_7.createVictimTarget(iter_84_5))
		end
	end
end

function var_0_10._getVictimTarget506(arg_85_0, arg_85_1)
	for iter_85_0, iter_85_1 in ipairs(arg_85_1.battleData:getKnightList(arg_85_1.attacker.opIdentity, nil, arg_85_1.attacker)) do
		if iter_85_1:getBuffCount(26381, false, true) > 0 then
			var_0_5(arg_85_0, var_0_7.createVictimTarget(iter_85_1))
		end
	end
end

function var_0_10._getVictimTarget507(arg_86_0, arg_86_1)
	local var_86_0 = {}

	for iter_86_0, iter_86_1 in ipairs(arg_86_1.battleData:getKnightList(arg_86_1.attacker.opIdentity, nil, arg_86_1.attacker)) do
		if iter_86_1:getBuffCount(26381, false, true) > 0 then
			var_0_5(var_86_0, iter_86_1)
		end
	end

	for iter_86_2, iter_86_3 in ipairs((var_0_7.getRandomN(var_86_0, arg_86_1.range_value, arg_86_1.battleField))) do
		var_0_5(arg_86_0, var_0_7.createVictimTarget(iter_86_3))
	end
end

function var_0_10._getVictimTarget508(arg_87_0, arg_87_1)
	local var_87_0 = {}

	for iter_87_0, iter_87_1 in ipairs(arg_87_1.battleData:getKnightList(arg_87_1.attacker.opIdentity, nil, arg_87_1.attacker)) do
		if iter_87_1:getBuffCount(26381, false, true) > 0 then
			var_0_5(var_87_0, iter_87_1)
		end
	end

	for iter_87_2, iter_87_3 in ipairs((var_0_7.getRandomN(var_87_0, 1, arg_87_1.battleField))) do
		var_0_5(arg_87_0, var_0_7.createVictimTarget(iter_87_3))
	end
end

function var_0_10._getVictimTarget509(arg_88_0, arg_88_1)
	local var_88_0 = {}

	for iter_88_0, iter_88_1 in ipairs(arg_88_1.battleData:getKnightList(arg_88_1.attacker.opIdentity, nil, arg_88_1.attacker)) do
		if iter_88_1:getBuffCount(26381, false, true) > 0 then
			var_0_5(var_88_0, iter_88_1)
		end
	end

	for iter_88_2, iter_88_3 in ipairs((var_0_7.getRandomN(var_88_0, 2, arg_88_1.battleField))) do
		var_0_5(arg_88_0, var_0_7.createVictimTarget(iter_88_3))
	end
end

function var_0_10._getVictimTarget510(arg_89_0, arg_89_1)
	local var_89_0 = {}

	for iter_89_0, iter_89_1 in ipairs(arg_89_1.battleData:getKnightList(arg_89_1.attacker.opIdentity, nil, arg_89_1.attacker)) do
		if iter_89_1:getBuffCount(26381, false, true) > 0 then
			var_0_5(var_89_0, iter_89_1)
		end
	end

	for iter_89_2, iter_89_3 in ipairs((var_0_7.getRandomN(var_89_0, 3, arg_89_1.battleField))) do
		var_0_5(arg_89_0, var_0_7.createVictimTarget(iter_89_3))
	end
end

function var_0_10._getVictimTarget511(arg_90_0, arg_90_1)
	local var_90_0 = {}

	for iter_90_0, iter_90_1 in ipairs(arg_90_1.battleData:getKnightList(arg_90_1.attacker.opIdentity, nil, arg_90_1.attacker)) do
		if iter_90_1:getBuffCount(366, true) > 0 then
			var_0_5(var_90_0, iter_90_1)
		end
	end

	for iter_90_2, iter_90_3 in ipairs((var_0_7.getRandomN(var_90_0, arg_90_1.range_value, arg_90_1.battleField))) do
		var_0_5(arg_90_0, var_0_7.createVictimTarget(iter_90_3))
	end
end

function var_0_10._getVictimTarget512(arg_91_0, arg_91_1)
	local var_91_0 = {}

	for iter_91_0, iter_91_1 in ipairs(arg_91_1.battleData:getKnightList(arg_91_1.attacker.opIdentity, nil, arg_91_1.attacker)) do
		if iter_91_1:getBuffCount(1462, false, false) > 0 then
			var_0_5(var_91_0, iter_91_1)
		end
	end

	for iter_91_2, iter_91_3 in ipairs((var_0_7.getRandomN(var_91_0, arg_91_1.range_value, arg_91_1.battleField))) do
		var_0_5(arg_91_0, var_0_7.createVictimTarget(iter_91_3))
	end
end

function var_0_10._getVictimTarget513(arg_92_0, arg_92_1)
	local var_92_0 = {}
	local var_92_1 = {}

	for iter_92_0, iter_92_1 in ipairs(arg_92_1.battleData:getKnightList(arg_92_1.attacker.identity, nil, arg_92_1.attacker)) do
		if iter_92_1:getBuffCount(1466, false, false) > 0 then
			var_0_5(var_92_0, iter_92_1)
		else
			var_0_4.insert(var_92_1, iter_92_1)
		end
	end

	if arg_92_1.range_value <= #var_92_0 then
		for iter_92_2, iter_92_3 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_92_0, "hpRate", false, arg_92_1.battleField, arg_92_1.range_value))) do
			var_0_5(arg_92_0, var_0_7.createVictimTarget(iter_92_3))
		end
	else
		for iter_92_4, iter_92_5 in ipairs(var_92_0) do
			var_0_5(arg_92_0, var_0_7.createVictimTarget(iter_92_5))
		end

		for iter_92_6, iter_92_7 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_92_1, "hpRate", false, arg_92_1.battleField, arg_92_1.range_value - #var_92_0))) do
			var_0_5(arg_92_0, var_0_7.createVictimTarget(iter_92_7))
		end
	end
end

function var_0_10._getVictimTarget514(arg_93_0, arg_93_1)
	local var_93_0 = {}
	local var_93_1 = {}

	for iter_93_0, iter_93_1 in ipairs(arg_93_1.battleData:getKnightList(arg_93_1.attacker.identity, nil, arg_93_1.attacker)) do
		if iter_93_1:getBuffCount(1466, false, false) > 0 then
			var_0_5(var_93_0, iter_93_1)
		else
			var_0_4.insert(var_93_1, iter_93_1)
		end
	end

	if arg_93_1.range_value <= #var_93_1 then
		for iter_93_2, iter_93_3 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_93_1, "hpRate", true, arg_93_1.battleField, arg_93_1.range_value))) do
			var_0_5(arg_93_0, var_0_7.createVictimTarget(iter_93_3))
		end
	else
		for iter_93_4, iter_93_5 in ipairs(var_93_1) do
			var_0_5(arg_93_0, var_0_7.createVictimTarget(iter_93_5))
		end

		for iter_93_6, iter_93_7 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_93_0, "hpRate", true, arg_93_1.battleField, arg_93_1.range_value - #var_93_0))) do
			var_0_5(arg_93_0, var_0_7.createVictimTarget(iter_93_7))
		end
	end
end

function var_0_10._getVictimTarget515(arg_94_0, arg_94_1)
	local var_94_0 = {}
	local var_94_1 = {}

	for iter_94_0, iter_94_1 in ipairs(arg_94_1.battleData:getKnightList(arg_94_1.attacker.identity, nil, arg_94_1.attacker)) do
		if iter_94_1:getBuffCount(1479, false, false) > 0 then
			var_0_5(var_94_0, iter_94_1)
		else
			var_0_4.insert(var_94_1, iter_94_1)
		end
	end

	if arg_94_1.range_value <= #var_94_1 then
		for iter_94_2, iter_94_3 in ipairs((var_0_7.getRandomN(var_94_1, arg_94_1.range_value, arg_94_1.battleField))) do
			var_0_5(arg_94_0, var_0_7.createVictimTarget(iter_94_3))
		end
	else
		for iter_94_4, iter_94_5 in ipairs(var_94_1) do
			var_0_5(arg_94_0, var_0_7.createVictimTarget(iter_94_5))
		end

		for iter_94_6, iter_94_7 in ipairs((var_0_7.getRandomN(var_94_0, arg_94_1.range_value, arg_94_1.battleField))) do
			var_0_5(arg_94_0, var_0_7.createVictimTarget(iter_94_7))
		end
	end
end

function var_0_10._getVictimTarget516(arg_95_0, arg_95_1)
	local var_95_0 = {}

	for iter_95_0, iter_95_1 in ipairs(arg_95_1.battleData:getKnightList(arg_95_1.attacker.opIdentity, nil, arg_95_1.attacker)) do
		if iter_95_1:getBuffCount(1505, false, false) > 0 then
			var_0_5(var_95_0, iter_95_1)
		end
	end

	for iter_95_2, iter_95_3 in ipairs(var_0_7.getRandomN(var_95_0, arg_95_1.range_value, arg_95_1.battleField)) do
		var_0_5(arg_95_0, var_0_7.createVictimTarget(iter_95_3))
	end
end

function var_0_10._getVictimTarget517(arg_96_0, arg_96_1)
	local var_96_0 = {}

	for iter_96_0, iter_96_1 in ipairs(arg_96_1.battleData:getKnightList(arg_96_1.attacker.opIdentity, nil, arg_96_1.attacker)) do
		if iter_96_1:getBuffCount(1522, false, false) > 0 then
			var_0_5(var_96_0, iter_96_1)
		end
	end

	for iter_96_2, iter_96_3 in ipairs(var_0_7.getRandomN(var_96_0, arg_96_1.range_value, arg_96_1.battleField)) do
		var_0_5(arg_96_0, var_0_7.createVictimTarget(iter_96_3))
	end
end

function var_0_10._getVictimTarget518(arg_97_0, arg_97_1)
	local var_97_0 = arg_97_1.battleData:getKnightList(arg_97_1.attacker.identity, nil, arg_97_1.attacker)

	for iter_97_0 = 1, #var_97_0 do
		if var_97_0[iter_97_0]:getMarkLevel(arg_97_1.range_value) > 0 then
			var_0_5(arg_97_0, var_0_7.createVictimTarget(var_97_0[iter_97_0]))
		end
	end
end

function var_0_10._getVictimTarget519(arg_98_0, arg_98_1)
	local var_98_0 = arg_98_1.battleData:getKnightList(arg_98_1.attacker.opIdentity, nil, arg_98_1.attacker)

	for iter_98_0 = 1, #var_98_0 do
		if var_98_0[iter_98_0]:getMarkLevel(arg_98_1.range_value) > 0 then
			var_0_5(arg_98_0, var_0_7.createVictimTarget(var_98_0[iter_98_0]))
		end
	end
end

function var_0_10._getVictimTarget520(arg_99_0, arg_99_1)
	local var_99_0 = 0

	var_99_0 = arg_99_1.attacker.knightCfg.attack_type == 1 and arg_99_1.attacker.advanceInfo.PHY_DEFENCE or arg_99_1.attacker.advanceInfo.MAG_DEFENCE

	local var_99_2 = arg_99_1.battleData:getKnightList(arg_99_1.attacker.opIdentity, nil, arg_99_1.attacker)

	for iter_99_0 = 1, #var_99_2 do
		local var_99_3 = var_99_2[iter_99_0]

		if 0 <= (var_99_2[iter_99_0].knightCfg.attack_type == 1 and var_99_3.advanceInfo.PHY_DEFENCE or var_99_3.advanceInfo.MAG_DEFENCE) then
			var_0_5(arg_99_0, var_0_7.createVictimTarget(var_99_3))
		end
	end
end

function var_0_10._getVictimTarget521(arg_100_0, arg_100_1)
	local var_100_0 = {}
	local var_100_1 = {}

	for iter_100_0, iter_100_1 in ipairs(arg_100_1.battleData:getKnightList(arg_100_1.attacker.opIdentity, nil, arg_100_1.attacker)) do
		if iter_100_1:getBuffCount(6000, false, false) > 0 then
			var_0_5(var_100_0, iter_100_1)
		else
			var_0_4.insert(var_100_1, iter_100_1)
		end
	end

	if arg_100_1.range_value <= #var_100_0 then
		for iter_100_2, iter_100_3 in ipairs((var_0_7.getRandomN(var_100_0, arg_100_1.range_value, arg_100_1.battleField))) do
			var_0_5(arg_100_0, var_0_7.createVictimTarget(iter_100_3))
		end
	else
		for iter_100_4, iter_100_5 in ipairs(var_100_0) do
			var_0_5(arg_100_0, var_0_7.createVictimTarget(iter_100_5))
		end

		for iter_100_6, iter_100_7 in ipairs((var_0_7.getRandomN(var_100_1, arg_100_1.range_value - #var_100_0, arg_100_1.battleField))) do
			var_0_5(arg_100_0, var_0_7.createVictimTarget(iter_100_7))
		end
	end
end

function var_0_10._getVictimTarget522(arg_101_0, arg_101_1)
	local var_101_0 = {}
	local var_101_1 = {}

	for iter_101_0, iter_101_1 in ipairs(arg_101_1.battleData:getKnightList(arg_101_1.attacker.opIdentity, nil, arg_101_1.attacker)) do
		if iter_101_1:getBuffCount(1058, false, false) > 0 then
			var_0_5(var_101_0, iter_101_1)
		else
			var_0_4.insert(var_101_1, iter_101_1)
		end
	end

	if arg_101_1.range_value <= #var_101_0 then
		for iter_101_2, iter_101_3 in ipairs((var_0_7.getRandomN(var_101_0, arg_101_1.range_value, arg_101_1.battleField))) do
			var_0_5(arg_101_0, var_0_7.createVictimTarget(iter_101_3))
		end
	else
		for iter_101_4, iter_101_5 in ipairs(var_101_0) do
			var_0_5(arg_101_0, var_0_7.createVictimTarget(iter_101_5))
		end

		for iter_101_6, iter_101_7 in ipairs((var_0_7.getRandomN(var_101_1, arg_101_1.range_value - #var_101_0, arg_101_1.battleField))) do
			var_0_5(arg_101_0, var_0_7.createVictimTarget(iter_101_7))
		end
	end
end

function var_0_10._getVictimTarget523(arg_102_0, arg_102_1)
	local var_102_0 = {}
	local var_102_1 = {}

	for iter_102_0, iter_102_1 in ipairs(arg_102_1.battleData:getKnightList(arg_102_1.attacker.opIdentity, nil, arg_102_1.attacker)) do
		if iter_102_1:getBuffCount(2220, false, false) > 0 then
			var_0_5(var_102_0, iter_102_1)
		else
			var_0_4.insert(var_102_1, iter_102_1)
		end
	end

	if arg_102_1.range_value <= #var_102_1 then
		for iter_102_2, iter_102_3 in ipairs((var_0_7.getRandomN(var_102_1, arg_102_1.range_value, arg_102_1.battleField))) do
			var_0_5(arg_102_0, var_0_7.createVictimTarget(iter_102_3))
		end
	else
		for iter_102_4, iter_102_5 in ipairs(var_102_1) do
			var_0_5(arg_102_0, var_0_7.createVictimTarget(iter_102_5))
		end

		for iter_102_6, iter_102_7 in ipairs((var_0_7.getRandomN(var_102_0, arg_102_1.range_value - #var_102_1, arg_102_1.battleField))) do
			var_0_5(arg_102_0, var_0_7.createVictimTarget(iter_102_7))
		end
	end
end

function var_0_10._getVictimTarget524(arg_103_0, arg_103_1)
	local var_103_0 = arg_103_1.battleData:getKnights()
	local var_103_1 = {}
	local var_103_2 = {}
	local var_103_3 = {}

	for iter_103_0 = 4, 6 do
		local var_103_4 = var_103_0:getKnightByIdAndPos(arg_103_1.attacker.opIdentity, iter_103_0)

		if var_103_4 and var_103_4:isValid(arg_103_1.attacker) then
			var_0_5(var_103_3, var_103_4)
		end
	end

	for iter_103_1, iter_103_2 in ipairs(var_103_3) do
		if iter_103_2:getBuffCount(2220, false, false) > 0 then
			var_0_5(var_103_1, iter_103_2)
		else
			var_0_4.insert(var_103_2, iter_103_2)
		end
	end

	if arg_103_1.range_value <= #var_103_2 then
		for iter_103_3, iter_103_4 in ipairs((var_0_7.getRandomN(var_103_2, arg_103_1.range_value, arg_103_1.battleField))) do
			var_0_5(arg_103_0, var_0_7.createVictimTarget(iter_103_4))
		end
	else
		for iter_103_5, iter_103_6 in ipairs(var_103_2) do
			var_0_5(arg_103_0, var_0_7.createVictimTarget(iter_103_6))
		end

		for iter_103_7, iter_103_8 in ipairs((var_0_7.getRandomN(var_103_1, arg_103_1.range_value - #var_103_2, arg_103_1.battleField))) do
			var_0_5(arg_103_0, var_0_7.createVictimTarget(iter_103_8))
		end
	end
end

function var_0_10._getVictimTarget525(arg_104_0, arg_104_1)
	local var_104_0 = arg_104_1.battleData:getKnights()
	local var_104_1 = {}

	for iter_104_0 = 4, 6 do
		local var_104_2 = var_104_0:getKnightByIdAndPos(arg_104_1.attacker.opIdentity, iter_104_0)

		if var_104_2 and var_104_2:isValid(arg_104_1.attacker) then
			var_0_5(var_104_1, var_104_2)
		end
	end

	if arg_104_1.range_value <= #var_104_1 then
		for iter_104_1, iter_104_2 in ipairs((var_0_7.getRandomN(var_104_1, arg_104_1.range_value, arg_104_1.battleField))) do
			var_0_5(arg_104_0, var_0_7.createVictimTarget(iter_104_2, true))
		end
	else
		for iter_104_3, iter_104_4 in ipairs(var_104_1) do
			var_0_5(arg_104_0, var_0_7.createVictimTarget(iter_104_4, true))
		end
	end
end

function var_0_10._getVictimTarget526(arg_105_0, arg_105_1, arg_105_2)
	if not arg_105_2[#arg_105_2] then
		return
	end

	for iter_105_0, iter_105_1 in ipairs(arg_105_2[#arg_105_2]) do
		if iter_105_1.victim.classical == arg_105_1.range_value then
			var_0_5(arg_105_0, var_0_7.copyTarget(iter_105_1))
		end
	end
end

function var_0_10._getVictimTarget527(arg_106_0, arg_106_1)
	local var_106_0 = {}

	for iter_106_0, iter_106_1 in ipairs(arg_106_1.battleData:getKnightList(arg_106_1.attacker.identity, nil, arg_106_1.attacker)) do
		if iter_106_1.classical == 3 then
			var_0_5(var_106_0, iter_106_1)
		end
	end

	for iter_106_2, iter_106_3 in ipairs(var_0_7.getRandomN(var_106_0, arg_106_1.range_value, arg_106_1.battleField)) do
		var_0_5(arg_106_0, var_0_7.createVictimTarget(iter_106_3))
	end
end

function var_0_10._getVictimTarget528(arg_107_0, arg_107_1)
	local var_107_0 = {}

	for iter_107_0, iter_107_1 in ipairs(arg_107_1.battleData:getKnightList(arg_107_1.attacker.identity, nil, arg_107_1.attacker)) do
		if iter_107_1.classical == 2 then
			var_0_5(var_107_0, iter_107_1)
		end
	end

	for iter_107_2, iter_107_3 in ipairs((var_0_7.getRandomMaxTargetsGroupN(var_107_0, "INITIAL_HP", true, arg_107_1.battleField, arg_107_1.range_value))) do
		var_0_5(arg_107_0, var_0_7.createVictimTarget(iter_107_3))
	end
end

function var_0_10._getVictimTarget529(arg_108_0, arg_108_1)
	local var_108_0 = {}

	for iter_108_0, iter_108_1 in ipairs(arg_108_1.battleData:getKnightList(arg_108_1.attacker.opIdentity, nil, arg_108_1.attacker)) do
		if iter_108_1.hasBuffByElementalType(arg_108_1.range_value) then
			var_0_5(var_108_0, iter_108_1)
		end
	end

	for iter_108_2, iter_108_3 in ipairs(var_108_0) do
		var_0_5(arg_108_0, var_0_7.createVictimTarget(iter_108_3))
	end
end

function var_0_10._getVictimTarget530(arg_109_0, arg_109_1)
	local var_109_0 = {}

	for iter_109_0, iter_109_1 in ipairs(arg_109_1.battleData:getKnightList(arg_109_1.attacker.opIdentity, nil, arg_109_1.attacker)) do
		if iter_109_1:getBuffCount(10001, false, false) > 0 then
			var_0_5(var_109_0, iter_109_1)
		end
	end

	for iter_109_2, iter_109_3 in ipairs(var_0_7.getRandomN(var_109_0, arg_109_1.range_value, arg_109_1.battleField)) do
		var_0_5(arg_109_0, var_0_7.createVictimTarget(iter_109_3))
	end
end

function var_0_10._getVictimTarget531(arg_110_0, arg_110_1)
	local var_110_0 = {}
	local var_110_1 = {}

	for iter_110_0, iter_110_1 in ipairs((var_0_7.getBackRow(arg_110_1.battleData, arg_110_1.attacker.opIdentity, arg_110_1.attacker))) do
		if iter_110_1:getBuffCount(2317, false, false) > 0 then
			var_0_5(var_110_1, iter_110_1)
		else
			var_0_5(var_110_0, iter_110_1)
		end
	end

	if arg_110_1.range_value <= #var_110_0 then
		for iter_110_2, iter_110_3 in ipairs((var_0_7.getRandomN(var_110_0, arg_110_1.range_value, arg_110_1.battleField))) do
			var_0_5(arg_110_0, var_0_7.createVictimTarget(iter_110_3))
		end
	else
		for iter_110_4, iter_110_5 in ipairs(var_110_0) do
			var_0_5(arg_110_0, var_0_7.createVictimTarget(iter_110_5))
		end

		for iter_110_6, iter_110_7 in ipairs((var_0_7.getRandomN(var_110_1, arg_110_1.range_value - #var_110_0, arg_110_1.battleField))) do
			var_0_5(arg_110_0, var_0_7.createVictimTarget(iter_110_7))
		end
	end
end

function var_0_10._getVictimTarget532(arg_111_0, arg_111_1)
	local var_111_0 = {}
	local var_111_1 = {}

	for iter_111_0, iter_111_1 in ipairs((arg_111_1.battleData:getKnightList(arg_111_1.attacker.opIdentity, nil, arg_111_1.attacker))) do
		if iter_111_1:getBuffCount(2317, false, false) > 0 then
			var_0_5(var_111_1, iter_111_1)
		else
			var_0_5(var_111_0, iter_111_1)
		end
	end

	if arg_111_1.range_value <= #var_111_0 then
		for iter_111_2, iter_111_3 in ipairs((var_0_7.getRandomN(var_111_0, arg_111_1.range_value, arg_111_1.battleField))) do
			var_0_5(arg_111_0, var_0_7.createVictimTarget(iter_111_3))
		end
	else
		for iter_111_4, iter_111_5 in ipairs(var_111_0) do
			var_0_5(arg_111_0, var_0_7.createVictimTarget(iter_111_5))
		end

		for iter_111_6, iter_111_7 in ipairs((var_0_7.getRandomN(var_111_1, arg_111_1.range_value - #var_111_0, arg_111_1.battleField))) do
			var_0_5(arg_111_0, var_0_7.createVictimTarget(iter_111_7))
		end
	end
end

function var_0_10._getVictimTarget533(arg_112_0, arg_112_1)
	for iter_112_0, iter_112_1 in ipairs((arg_112_1.battleData:getKnightList(arg_112_1.attacker.identity, nil, arg_112_1.attacker))) do
		if iter_112_1 ~= arg_112_1.attacker and arg_112_1.range_value == iter_112_1.classical then
			var_0_5(arg_112_0, var_0_7.createVictimTarget(iter_112_1))
		end
	end
end

function var_0_10._getVictimTarget534(arg_113_0, arg_113_1)
	for iter_113_0, iter_113_1 in ipairs((arg_113_1.battleData:getKnightList(arg_113_1.attacker.identity, nil, arg_113_1.attacker))) do
		if arg_113_1.range_value == iter_113_1.classical then
			var_0_5(arg_113_0, var_0_7.createVictimTarget(iter_113_1))
		end
	end
end

function var_0_10._getVictimTarget535(arg_114_0, arg_114_1)
	local var_114_0 = {}

	for iter_114_0, iter_114_1 in ipairs((arg_114_1.battleData:getKnightList(arg_114_1.attacker.opIdentity, nil, arg_114_1.attacker))) do
		for iter_114_2, iter_114_3 in ipairs((iter_114_1:getBuffs())) do
			if iter_114_3.buffCfg.buff_type == 2 and iter_114_3.buffCfg.buff_elemental_type == 2 then
				var_0_5(var_114_0, iter_114_1)

				break
			end
		end
	end

	for iter_114_4, iter_114_5 in ipairs((var_0_7.getRandomN(var_114_0, arg_114_1.range_value, arg_114_1.battleField))) do
		var_0_5(arg_114_0, var_0_7.createVictimTarget(iter_114_5))
	end
end

function var_0_10._getVictimTarget536(arg_115_0, arg_115_1)
	for iter_115_0, iter_115_1 in ipairs((arg_115_1.battleData:getKnightList(arg_115_1.attacker.identity, true, arg_115_1.attacker))) do
		if not iter_115_1.isDead then
			var_0_5(arg_115_0, var_0_7.createVictimTarget(iter_115_1))
		end
	end
end

function var_0_10._getVictimTarget537(arg_116_0, arg_116_1)
	if arg_116_1.attacker:getBuffCount(2550) > 0 then
		var_0_5(arg_116_0, var_0_7.createVictimTarget(arg_116_1.attacker))
	end
end

function var_0_10._getVictimTarget538(arg_117_0, arg_117_1)
	local var_117_0 = var_0_9.get(arg_117_1.range_value, 6)
	local var_117_1 = var_117_0.value_3
	local var_117_2 = arg_117_1.battleData:getKnightList(arg_117_1.attacker.opIdentity, nil, arg_117_1.attacker)

	if arg_117_1.attacker:getBuffCount(var_117_0.value_2) > 0 then
		local var_117_3 = {}
		local var_117_4 = {}

		for iter_117_0, iter_117_1 in ipairs(var_117_2) do
			if var_117_0.value_4 > iter_117_1:getBuffCount(var_117_0.value_3, true) then
				var_0_5(var_117_3, iter_117_1)

				var_117_4[iter_117_1] = true
			end
		end

		var_0_4.sort(var_117_3, function(arg_118_0, arg_118_1)
			return arg_118_0:getBuffCount(var_117_1, true) > arg_118_1:getBuffCount(var_117_1, true)
		end)

		local var_117_5 = var_0_2(var_117_0.value_1, #var_117_3)

		for iter_117_2 = 1, var_117_5 do
			var_0_5(arg_117_0, var_0_7.createVictimTarget(var_117_3[iter_117_2]))
		end

		if var_117_5 < var_117_0.value_1 then
			local var_117_6 = {}

			for iter_117_3, iter_117_4 in ipairs(var_117_2) do
				if not var_117_4[iter_117_4] then
					var_0_5(var_117_6, iter_117_4)
				end
			end

			for iter_117_5, iter_117_6 in ipairs((var_0_7.getRandomN(var_117_6, var_117_0.value_1 - var_117_5, arg_117_1.battleField))) do
				var_0_5(arg_117_0, var_0_7.createVictimTarget(iter_117_6))
			end
		end
	else
		for iter_117_7, iter_117_8 in ipairs((var_0_7.getRandomN(var_117_2, var_117_0.value_1, arg_117_1.battleField))) do
			var_0_5(arg_117_0, var_0_7.createVictimTarget(iter_117_8))
		end
	end
end

function var_0_10._getVictimTarget539(arg_119_0, arg_119_1)
	local var_119_0 = var_0_9.get(arg_119_1.range_value, 6)
	local var_119_1 = var_0_7.getRangeKnights(arg_119_1.targets[#arg_119_1.targets])

	for iter_119_0 = 1, #var_119_1 do
		local var_119_2 = var_119_1[iter_119_0]:getBuffs()

		for iter_119_1 = 1, #var_119_2 do
			if var_119_2[iter_119_1].buffCfg.buff_effect_type == var_119_0.value_1 and var_119_0.value_2 <= var_119_2[iter_119_1].numberOfLayers then
				var_0_5(arg_119_0, var_0_7.createVictimTarget(var_119_1[iter_119_0]))

				break
			end
		end
	end
end

function var_0_10._getVictimTarget540(arg_120_0, arg_120_1)
	local var_120_0 = var_0_9.get(arg_120_1.range_value, 6)
	local var_120_1 = var_0_7.getRangeKnights(arg_120_1.targets[#arg_120_1.targets])

	for iter_120_0 = 1, #var_120_1 do
		if var_120_0.value_2 <= var_120_1[iter_120_0]:getBuffCount(var_120_0.value_1) then
			var_0_5(arg_120_0, var_0_7.createVictimTarget(var_120_1[iter_120_0]))
		end
	end
end

function var_0_10._getVictimTarget1001(arg_121_0, arg_121_1)
	local var_121_0 = {}

	for iter_121_0, iter_121_1 in ipairs(arg_121_1.battleData:getKnightList(arg_121_1.attacker.opIdentity, nil, arg_121_1.attacker)) do
		if iter_121_1.hasBuffByElementalType(arg_121_1.range_value) then
			var_0_5(var_121_0, iter_121_1)
		end
	end

	for iter_121_2, iter_121_3 in ipairs(var_121_0) do
		var_0_5(arg_121_0, var_0_7.createVictimTarget(iter_121_3))
	end
end

return var_0_10
