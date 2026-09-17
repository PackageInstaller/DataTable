local var_0_0 = {}
local var_0_1 = math.min
local var_0_2 = math.max
local buff_data = require("data.buff_data")
local FightMessage = require("fight.FightMessage")
local var_0_5 = _G.CalculateExtraDamage
local var_0_7 = _G.CalculateStrikeDodgeCriBlind

local function var_0_8(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_0 then
		return 0
	end

	if not arg_1_0._instance then
		return 0
	end

	return baseAttr[arg_1_1].proc1(arg_1_0, arg_1_2)
end

local function var_0_9(arg_2_0, arg_2_1)
	local var_2_0 = {
		0,
		0,
		1,
		0
	}

	if not arg_2_1 then
		return var_2_0
	end

	if not arg_2_1._instance then
		return var_2_0
	end

	if arg_2_0.param1 and (arg_2_0.param1 < 100 or arg_2_0.param1 > 200) and arg_2_0.target1 == 1 then
		var_2_0[1] = var_0_8(arg_2_1, arg_2_0.param1, arg_2_0.max1)
	end

	if arg_2_0.param2 and (arg_2_0.param2 < 100 or arg_2_0.param2 > 200) and arg_2_0.target2 == 1 then
		var_2_0[2] = var_0_8(arg_2_1, arg_2_0.param2, arg_2_0.max2)
	end

	if arg_2_0.param3 and (arg_2_0.param3 < 100 or arg_2_0.param3 > 200) and arg_2_0.target3 == 1 then
		var_2_0[3] = var_0_8(arg_2_1, arg_2_0.param3, arg_2_0.max3)
	end

	if arg_2_0.param4 and (arg_2_0.param4 < 100 or arg_2_0.param4 > 200) and arg_2_0.target4 == 1 then
		var_2_0[4] = var_0_8(arg_2_1, arg_2_0.param4, arg_2_0.max4)
	end

	if arg_2_0.param5 and (arg_2_0.param5 < 100 or arg_2_0.param5 > 200) and arg_2_0.target5 == 1 then
		var_2_0[5] = var_0_8(arg_2_1, arg_2_0.param5, arg_2_0.max5)
	end

	if arg_2_0.param6 and (arg_2_0.param6 < 100 or arg_2_0.param6 > 200) and arg_2_0.target6 == 1 then
		var_2_0[6] = var_0_8(arg_2_1, arg_2_0.param6, arg_2_0.max6)
	end

	return var_2_0
end

local function var_0_10(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0["value" .. arg_4_0] or arg_4_1

		if arg_3_0["param" .. arg_4_0] then
			if arg_3_0["target" .. arg_4_0] == 2 then
				var_4_0 = var_4_0 * var_0_8(arg_3_2, arg_3_0["param" .. arg_4_0], arg_3_0["max" .. arg_4_0])
			elseif arg_3_1[arg_4_0] then
				var_4_0 = var_4_0 * arg_3_1[arg_4_0]
			end
		end

		return var_4_0
	end

	local var_3_1 = (var_3_0(1, 0) + var_3_0(2, 0)) * (var_3_0(3, 1) + var_3_0(4, 0))

	if arg_3_0.value5 then
		var_3_1 = var_0_2(var_3_1, var_3_0(5))
	end

	if arg_3_0.value6 then
		var_3_1 = var_0_1(var_3_1, var_3_0(6))
	end

	return var_3_1
end

local function var_0_12(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0 then
		return 0
	end

	if not arg_7_0._instance then
		return 0
	end

	local var_7_0 = arg_7_0:getStatusRegisterValueAdd(arg_7_1)
	local var_7_1 = FightManager.getCharacter(arg_7_2)

	if var_7_1 then
		var_7_0 = var_7_0 + var_7_1:getStatusExertRegisterValueAdd(arg_7_1)
	end

	return var_7_0
end

local function var_0_13(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0 then
		return 0
	end

	if not arg_8_0._instance then
		return 0
	end

	return baseAttr[arg_8_1].proc1(arg_8_0, arg_8_2)
end

local function var_0_14(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0 then
		return 0
	end

	if not arg_9_0._instance then
		return 0
	end

	return baseAttr[arg_9_1].proc3(arg_9_0, arg_9_2)
end

local function var_0_15(arg_10_0, arg_10_1)
	local var_10_0 = {
		0,
		0,
		1,
		0
	}

	if not arg_10_1 then
		return var_10_0
	end

	if not arg_10_1._instance then
		return var_10_0
	end

	for iter_10_0 = 1, 6 do
		if arg_10_0["param" .. iter_10_0] and (arg_10_0["param" .. iter_10_0] < 100 or arg_10_0["param" .. iter_10_0] > 200) and arg_10_0["target" .. iter_10_0] == 1 then
			var_10_0[iter_10_0] = var_0_13(arg_10_1, arg_10_0["param" .. iter_10_0], arg_10_0["max" .. iter_10_0])
		end
	end

	var_10_0.sourceindex = arg_10_1.index

	return var_10_0
end

local function var_0_16(arg_11_0, arg_11_1)
	local var_11_0 = {
		0,
		0,
		1,
		0
	}

	if not arg_11_1 then
		return var_11_0
	end

	if not arg_11_1._instance then
		return var_11_0
	end

	for iter_11_0 = 1, 6 do
		if arg_11_0["param" .. iter_11_0] and (arg_11_0["param" .. iter_11_0] < 100 or arg_11_0["param" .. iter_11_0] > 200) and arg_11_0["target" .. iter_11_0] == 1 then
			var_11_0[iter_11_0] = var_0_14(arg_11_1, arg_11_0["param" .. iter_11_0], arg_11_0["max" .. iter_11_0])
		end
	end

	var_11_0.sourceindex = arg_11_1.index

	return var_11_0
end

local function var_0_17(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_1.sourceindex then
		return arg_12_1[arg_12_0]
	end

	local var_12_0 = FightManager.getCharacter(arg_12_1.sourceindex)

	if not var_12_0 then
		return arg_12_1[arg_12_0]
	end

	arg_12_1[arg_12_0] = var_0_13(var_12_0, arg_12_2, arg_12_3) or arg_12_4

	return arg_12_1[arg_12_0]
end

local function var_0_18(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if not arg_13_1.sourceindex then
		return arg_13_1[arg_13_0]
	end

	local var_13_0 = FightManager.getCharacter(arg_13_1.sourceindex)

	if not var_13_0 then
		return arg_13_1[arg_13_0]
	end

	arg_13_1[arg_13_0] = var_0_14(var_13_0, arg_13_2, arg_13_3) or arg_13_4

	return arg_13_1[arg_13_0]
end

local function var_0_19(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local function var_14_0()
		if not arg_14_4 then
			return 0
		end

		if not arg_14_4.damage then
			return 0
		end

		return arg_14_4.damage
	end

	local function var_14_1()
		if not arg_14_4 then
			return 0
		end

		if not arg_14_4.heal then
			return 0
		end

		return arg_14_4.heal
	end

	local function var_14_2(arg_17_0, arg_17_1)
		local var_17_0 = arg_14_0["value" .. arg_17_0] or arg_17_1

		if arg_14_0["param" .. arg_17_0] then
			if arg_14_0["param" .. arg_17_0] == 100 then
				var_17_0 = var_17_0 * var_14_0()
			elseif arg_14_0["param" .. arg_17_0] == 101 then
				var_17_0 = var_17_0 * var_14_1()
			elseif arg_14_0["target" .. arg_17_0] then
				if arg_14_0["target" .. arg_17_0] == 1 then
					var_17_0 = arg_14_0["sourcechange" .. arg_17_0] and var_17_0 * var_0_17(arg_17_0, arg_14_3, arg_14_0["param" .. arg_17_0], arg_14_0["max" .. arg_17_0], arg_17_1) or var_17_0 * arg_14_3[arg_17_0]
				elseif arg_14_0["target" .. arg_17_0] == 2 then
					var_17_0 = var_17_0 * var_0_13(arg_14_2, arg_14_0["param" .. arg_17_0], arg_14_0["max" .. arg_17_0])
				elseif arg_14_0["target" .. arg_17_0] == 3 then
					var_17_0 = var_17_0 * var_0_13(arg_14_1, arg_14_0["param" .. arg_17_0], arg_14_0["max" .. arg_17_0])
				end
			end
		end

		return var_17_0
	end

	local var_14_3 = (var_14_2(1, 0) + var_14_2(2, 0)) * (var_14_2(3, 1) + var_14_2(4, 0))

	if arg_14_0.value5 then
		var_14_3 = var_0_2(var_14_3, var_14_2(5))
	end

	if arg_14_0.value6 then
		var_14_3 = var_0_1(var_14_3, var_14_2(6))
	end

	return var_14_3
end

local function var_0_20(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local function var_18_0()
		if not arg_18_4 then
			return 0
		end

		if not arg_18_4.damage then
			return 0
		end

		return arg_18_4.damage
	end

	local function var_18_1()
		if not arg_18_4 then
			return 0
		end

		if not arg_18_4.heal then
			return 0
		end

		return arg_18_4.heal
	end

	local function var_18_2()
		if not arg_18_4 then
			return 0
		end

		if not arg_18_4.bufftime then
			return 0
		end

		return arg_18_4.bufftime
	end

	local function var_18_3(arg_22_0, arg_22_1)
		local var_22_0 = arg_18_0["value" .. arg_22_0] or arg_22_1

		if arg_18_0["param" .. arg_22_0] then
			if arg_18_0["param" .. arg_22_0] == 100 then
				var_22_0 = var_22_0 * var_18_0()
			elseif arg_18_0["param" .. arg_22_0] == 101 then
				var_22_0 = var_22_0 * var_18_1()
			elseif arg_18_0["param" .. arg_22_0] == 102 then
				var_22_0 = var_22_0 * var_18_2()
			elseif arg_18_0["target" .. arg_22_0] then
				if arg_18_0["target" .. arg_22_0] == 1 then
					var_22_0 = arg_18_0["sourcechange" .. arg_22_0] and var_22_0 * var_0_18(arg_22_0, arg_18_3, arg_18_0["param" .. arg_22_0], arg_18_0["max" .. arg_22_0], arg_22_1) or var_22_0 * arg_18_3[arg_22_0]
				elseif arg_18_0["target" .. arg_22_0] == 2 then
					var_22_0 = var_22_0 * var_0_14(arg_18_2, arg_18_0["param" .. arg_22_0], arg_18_0["max" .. arg_22_0])
				elseif arg_18_0["target" .. arg_22_0] == 3 then
					var_22_0 = var_22_0 * var_0_14(arg_18_1, arg_18_0["param" .. arg_22_0], arg_18_0["max" .. arg_22_0])
				end
			end
		end

		return var_22_0
	end

	local var_18_4 = (var_18_3(1, 0) + var_18_3(2, 0)) * (var_18_3(3, 1) + var_18_3(4, 0))

	if arg_18_0.value5 then
		var_18_4 = var_0_2(var_18_4, var_18_3(5))
	end

	if arg_18_0.value6 then
		var_18_4 = var_0_1(var_18_4, var_18_3(6))
	end

	return var_18_4
end

local function var_0_21(arg_23_0, arg_23_1, arg_23_2)
	local function var_23_0(arg_24_0, arg_24_1)
		local var_24_0 = arg_23_0["value" .. arg_24_0] or arg_24_1

		if arg_23_0["param" .. arg_24_0] then
			if arg_23_0["target" .. arg_24_0] == 2 then
				var_24_0 = var_24_0 * var_0_14(arg_23_2, arg_23_0["param" .. arg_24_0], arg_23_0["max" .. arg_24_0])
			elseif arg_23_1[arg_24_0] then
				var_24_0 = var_24_0 * arg_23_1[arg_24_0]
			end
		end

		return var_24_0
	end

	local var_23_1 = (var_23_0(1, 0) + var_23_0(2, 0)) * (var_23_0(3, 1) + var_23_0(4, 0))

	if arg_23_0.value5 then
		var_23_1 = var_0_2(var_23_1, var_23_0(5))
	end

	if arg_23_0.value6 then
		var_23_1 = var_0_1(var_23_1, var_23_0(6))
	end

	return var_23_1
end

local function var_0_22(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0 then
		return 0
	end

	if not arg_25_0._instance then
		return 0
	end

	local var_25_0 = arg_25_0:getStatusTriggerValueAdd(arg_25_1)
	local var_25_1 = FightManager.getCharacter(arg_25_2)

	if var_25_1 then
		var_25_0 = var_25_0 + var_25_1:getStatusExertTriggerValueAdd(arg_25_1)
	end

	return var_25_0
end

local function var_0_23(arg_26_0, arg_26_1)
	return function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
		local var_27_0 = FightManager.getCharacter(arg_27_1)
		local var_27_1 = var_0_10(arg_27_3, arg_27_4, var_27_0)
		local var_27_2 = var_27_1 + var_27_1 * var_0_12(var_27_0, arg_27_0, arg_27_2)

		if arg_26_0 == "curhp" or arg_26_0 == "hp" then
			var_27_2 = math.round(var_27_2)
		end

		return var_27_2, arg_26_0
	end
end

local function var_0_24(arg_28_0)
	return nil
end

local function var_0_25()
	return function(arg_34_0, arg_34_1)
		local var_34_0 = FightManager.getCharacter(arg_34_1)

		if not var_34_0 then
			return
		end

		var_34_0.statuspool:setStatus("vertigo", true)
		var_34_0.statuspool:addStatus("vertigo_count", 1)
		var_34_0:setVertigo()
	end
end

local function var_0_26()
	return function(arg_36_0, arg_36_1)
		local var_36_0 = FightManager.getCharacter(arg_36_1)

		if not var_36_0 then
			return
		end

		var_36_0.statuspool:addStatus("vertigo_count", -1)

		if var_36_0.statuspool:getStatus("vertigo_count") <= 0 then
			var_36_0.statuspool:setStatus("vertigo", false)
			var_36_0:removeVertigo()
		end
	end
end

local function var_0_27()
	return function(arg_42_0, arg_42_1)
		local var_42_0 = FightManager.getCharacter(arg_42_1)

		if not var_42_0 then
			return
		end

		var_42_0.statuspool:setStatus("stone", true)
		var_42_0.statuspool:addStatus("stone_count", 1)
		var_42_0:setStone()
	end
end

local function var_0_28()
	return function(arg_44_0, arg_44_1)
		local var_44_0 = FightManager.getCharacter(arg_44_1)

		if not var_44_0 then
			return
		end

		var_44_0.statuspool:addStatus("stone_count", -1)

		if var_44_0.statuspool:getStatus("stone_count") <= 0 then
			var_44_0.statuspool:setStatus("stone", false)
			var_44_0:removeStone()
		end
	end
end

local function var_0_29()
	return function(arg_46_0, arg_46_1)
		local var_46_0 = FightManager.getCharacter(arg_46_1)

		if not var_46_0 then
			return
		end

		var_46_0.statuspool:setStatus("confine", true)
		var_46_0.statuspool:addStatus("confine_count", 1)
		var_46_0:setConfine()
	end
end

local function var_0_30()
	return function(arg_48_0, arg_48_1)
		local var_48_0 = FightManager.getCharacter(arg_48_1)

		if not var_48_0 then
			return
		end

		var_48_0.statuspool:addStatus("confine_count", -1)

		if var_48_0.statuspool:getStatus("confine_count") <= 0 then
			var_48_0.statuspool:setStatus("confine", false)
			var_48_0:removeConfine()
		end
	end
end

local function var_0_31()
	return function(arg_50_0, arg_50_1)
		local var_50_0 = FightManager.getCharacter(arg_50_1)

		if not var_50_0 then
			return
		end

		var_50_0.statuspool:setStatus("silence", true)
		var_50_0.statuspool:addStatus("silence_count", 1)
		var_50_0:setSilence()
	end
end

local function var_0_32()
	return function(arg_52_0, arg_52_1)
		local var_52_0 = FightManager.getCharacter(arg_52_1)

		if not var_52_0 then
			return
		end

		var_52_0.statuspool:addStatus("silence_count", -1)

		if var_52_0.statuspool:getStatus("silence_count") <= 0 then
			var_52_0.statuspool:setStatus("silence", false)
			var_52_0:removeSilence()
		end
	end
end

local function var_0_33()
	return function(arg_54_0, arg_54_1)
		local var_54_0 = FightManager.getCharacter(arg_54_1)

		if not var_54_0 then
			return
		end

		var_54_0.statuspool:setStatus("addict", true)
		var_54_0.statuspool:addStatus("addict_count", 1)
		var_54_0:setAddict()
	end
end

local function var_0_34()
	return function(arg_56_0, arg_56_1)
		local var_56_0 = FightManager.getCharacter(arg_56_1)

		if not var_56_0 then
			return
		end

		var_56_0.statuspool:addStatus("addict_count", -1)

		if var_56_0.statuspool:getStatus("addict_count") <= 0 then
			var_56_0.statuspool:setStatus("addict", false)
			var_56_0:removeAddict()
		end
	end
end

local function var_0_35()
	return function(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4, arg_62_5)
		local var_62_0 = FightManager.getCharacter(arg_62_1)
		local var_62_1 = FightManager.getCharacter(arg_62_2)

		var_62_0:addShield(math.round((var_0_21(arg_62_3, arg_62_4, var_62_0))), arg_62_5)
	end
end

local function var_0_36()
	return function(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4, arg_64_5)
		local var_64_0 = FightManager.getCharacter(arg_64_1)

		if not var_64_0 then
			return
		end

		var_64_0:removeShield(arg_64_5)
	end
end

local function var_0_37()
	return function(arg_66_0, arg_66_1)
		local var_66_0 = FightManager.getCharacter(arg_66_1)

		var_66_0.statuspool:setStatus("immortal", true)
		var_66_0.statuspool:addStatus("immortal_count", 1)
		var_66_0:setImmortal()
	end
end

local function var_0_38()
	return function(arg_68_0, arg_68_1)
		local var_68_0 = FightManager.getCharacter(arg_68_1)

		var_68_0.statuspool:addStatus("immortal_count", -1)

		if var_68_0.statuspool:getStatus("immortal_count") <= 0 then
			var_68_0.statuspool:setStatus("immortal", false)
			var_68_0:removeImmortal()
		end
	end
end

local function var_0_39()
	return function(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
		local var_82_0 = FightManager.getCharacter(arg_82_1)

		for iter_82_0 in arg_82_3.value:gmatch("([^&]+)") do
			var_82_0.statuspool:registerStatus(tonumber(iter_82_0))
		end
	end
end

local function var_0_40()
	return function(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
		local var_84_0 = FightManager.getCharacter(arg_84_1)

		for iter_84_0 in arg_84_3.value:gmatch("([^&]+)") do
			var_84_0.statuspool:unregisterStatus(tonumber(iter_84_0))
		end
	end
end

local function var_0_41()
	return function(arg_86_0, arg_86_1)
		local var_86_0 = FightManager.getCharacter(arg_86_1)

		var_86_0.statuspool:setStatus("heallimit", true)
		var_86_0.statuspool:addStatus("heallimit_count", 1)
	end
end

local function var_0_42()
	return function(arg_88_0, arg_88_1)
		local var_88_0 = FightManager.getCharacter(arg_88_1)

		var_88_0.statuspool:addStatus("heallimit_count", -1)

		if var_88_0.statuspool:getStatus("heallimit_count") <= 0 then
			var_88_0.statuspool:setStatus("heallimit", false)
		end
	end
end

local function var_0_43()
	return function(arg_90_0, arg_90_1)
		local var_90_0 = FightManager.getCharacter(arg_90_1)

		var_90_0.statuspool:setStatus("bkb", true)
		var_90_0.statuspool:addStatus("bkb_count", 1)
		var_90_0.statuspool:cleanDebuff(1)
	end
end

local function var_0_44()
	return function(arg_92_0, arg_92_1)
		local var_92_0 = FightManager.getCharacter(arg_92_1)

		var_92_0.statuspool:addStatus("bkb_count", -1)

		if var_92_0.statuspool:getStatus("bkb_count") <= 0 then
			var_92_0.statuspool:setStatus("bkb", false)
		end
	end
end

local function var_0_47()
	return function(arg_98_0, arg_98_1)
		local var_98_0 = FightManager.getCharacter(arg_98_1)

		var_98_0.statuspool:setStatus("ignore_dodge", true)
		var_98_0.statuspool:addStatus("ignore_dodge_count", 1)
	end
end

local function var_0_48()
	return function(arg_100_0, arg_100_1)
		local var_100_0 = FightManager.getCharacter(arg_100_1)

		var_100_0.statuspool:addStatus("ignore_dodge_count", -1)

		if var_100_0.statuspool:getStatus("ignore_dodge_count") <= 0 then
			var_100_0.statuspool:setStatus("ignore_dodge", false)
		end
	end
end

local function var_0_49()
	return function(arg_102_0, arg_102_1, arg_102_2, arg_102_3)
		FightManager.getCharacter(arg_102_1).statuspool:registerStatusTriggerProbAdd(arg_102_3.value1, arg_102_3.value2)
	end
end

local function var_0_50()
	return function(arg_104_0, arg_104_1, arg_104_2, arg_104_3)
		FightManager.getCharacter(arg_104_1).statuspool:unregisterStatusTriggerProbAdd(arg_104_3.value1, arg_104_3.value2)
	end
end

local function var_0_51()
	return function(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
		local var_110_0 = tonumber(arg_110_3.value1)
		local var_110_1 = FightManager.getCharacter(arg_110_1)

		if arg_110_3.target1 == 2 then
			var_110_1.statuspool:registerStatusValueAdd(var_110_0, arg_110_3.value2)
		else
			var_110_1.statuspool:registerStatusExertValueAdd(var_110_0, arg_110_3.value2)
		end
	end
end

local function var_0_52()
	return function(arg_112_0, arg_112_1, arg_112_2, arg_112_3)
		local var_112_0 = tonumber(arg_112_3.value1)
		local var_112_1 = FightManager.getCharacter(arg_112_1)

		if arg_112_3.target1 == 2 then
			var_112_1.statuspool:unregisterStatusValueAdd(var_112_0, arg_112_3.value2)
		else
			var_112_1.statuspool:unregisterStatusExertValueAdd(var_112_0, arg_112_3.value2)
		end
	end
end

local function var_0_53()
	return function(arg_118_0, arg_118_1, arg_118_2, arg_118_3)
		local var_118_0 = tonumber(arg_118_3.value1)

		print("register buff time add: ", arg_118_1, arg_118_3.target1, var_118_0, arg_118_3.value2)

		local var_118_1 = FightManager.getCharacter(arg_118_1)

		if arg_118_3.target1 == 2 then
			var_118_1.statuspool:registerBuffTimeAdd(var_118_0, arg_118_3.value2)
		else
			var_118_1.statuspool:registerExertBuffTimeAdd(var_118_0, arg_118_3.value2)
		end
	end
end

local function var_0_54()
	return function(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
		local var_120_0 = tonumber(arg_120_3.value1)
		local var_120_1 = FightManager.getCharacter(arg_120_1)

		if arg_120_3.target1 == 2 then
			var_120_1.statuspool:unregisterBuffTimeAdd(var_120_0, arg_120_3.value2)
		else
			var_120_1.statuspool:unregisterExertBuffTimeAdd(var_120_0, arg_120_3.value2)
		end
	end
end

local function var_0_55()
	return function(arg_122_0, arg_122_1, arg_122_2, arg_122_3)
		local var_122_0 = tonumber(arg_122_3.value1)
		local var_122_1 = FightManager.getCharacter(arg_122_1)

		if arg_122_3.target1 == 1 then
			var_122_1.statuspool:registerExertBuffStackAdd(var_122_0, arg_122_3.value2)
		else
			var_122_1.statuspool:registerBuffStackAdd(var_122_0, arg_122_3.value2)
		end
	end
end

local function var_0_56()
	return function(arg_124_0, arg_124_1, arg_124_2, arg_124_3)
		local var_124_0 = tonumber(arg_124_3.value1)
		local var_124_1 = FightManager.getCharacter(arg_124_1)

		if arg_124_3.target1 == 1 then
			var_124_1.statuspool:unregisterExertBuffStackAdd(var_124_0, arg_124_3.value2)
		else
			var_124_1.statuspool:unregisterBuffStackAdd(var_124_0, arg_124_3.value2)
		end
	end
end

local function var_0_57()
	return function(arg_126_0, arg_126_1, arg_126_2, arg_126_3)
		local var_126_0 = tonumber(arg_126_3.value1)
		local var_126_1 = FightManager.getCharacter(arg_126_1)

		if arg_126_3.target1 == 2 then
			var_126_1.statuspool:registerStatusValueAddRandom(var_126_0, arg_126_3.value2, arg_126_3.value3)
		else
			var_126_1.statuspool:registerStatusValueExertAddRandom(var_126_0, arg_126_3.value2, arg_126_3.value3)
		end
	end
end

local function var_0_58()
	return function(arg_128_0, arg_128_1, arg_128_2, arg_128_3)
		local var_128_0 = tonumber(arg_128_3.value1)
		local var_128_1 = FightManager.getCharacter(arg_128_1)

		if arg_128_3.target1 == 2 then
			var_128_1.statuspool:unregisterStatusValueAddRandom(var_128_0, arg_128_3.value2, arg_128_3.value3)
		else
			var_128_1.statuspool:unregisterStatusValueExertAddRandom(var_128_0, arg_128_3.value2, arg_128_3.value3)
		end
	end
end

local function var_0_59()
	return function(arg_152_0, arg_152_1)
		local var_152_0 = FightManager.getCharacter(arg_152_1)

		var_152_0.statuspool:addStatus("ragefree_count", -1)

		if var_152_0.statuspool:getStatus("ragefree_count") <= 0 then
			var_152_0.statuspool:setStatus("ragefree", false)
		end
	end
end

local function var_0_60()
	return function(arg_170_0, arg_170_1, arg_170_2, arg_170_3, arg_170_4)
		FightManager.getCharacter(arg_170_1).statuspool:setStatus("addattrweak", arg_170_3.value1)
	end
end

local function var_0_61()
	return function(arg_172_0, arg_172_1)
		FightManager.getCharacter(arg_172_1).statuspool:setStatus("addattrweak", 0)
	end
end

local var_0_64 = {
	[OLDVERTIGO] = var_0_25,
	[OLDEXTRA_ATTACK] = {
		var_0_23,
		"extra_attack"
	},
	[OLDEXTRA_DEFENCE] = {
		var_0_23,
		"extra_defence"
	},
	[OLDHEMATOPHAGY] = {
		var_0_23,
		"hematophagy"
	},
	[OLDSTONE] = var_0_27,
	[OLDCONFINE] = var_0_29,
	[OLDSILENCE] = var_0_31,
	[OLDADDICT] = var_0_33,
	[OLDEXTRA_WEAK] = {
		var_0_23,
		"extra_weak"
	},
	[OLDEXTRA_HEAL] = {
		var_0_23,
		"extra_heal"
	},
	[OLDSHIELD] = var_0_35,
	[OLDIMMORTAL] = var_0_37,
	[OLDDEBUFF_IMMUNE] = var_0_43,
	[OLDADD_STATUS] = var_0_39,
	[OLDEXTRA_INJURE] = {
		var_0_23,
		"extra_injure"
	},
	[OLDHEAL_LIMIT] = var_0_41,
	[OLDATTACK_DEFENCE] = {
		var_0_23,
		"defence"
	},
	[OLDCRI_PROB_CHANGE] = {
		var_0_23,
		"exe_critical"
	},
	[OLDDODGE_PROB_CHANGE] = {
		var_0_23,
		"exe_dodge"
	},
	[OLDSTRIKE_PROB_CHANGE] = {
		var_0_23,
		"exe_strike"
	},
	[OLDCRI_DAMAGE_ADD] = {
		var_0_23,
		"cri_damage_add"
	},
	[OLDDODGE_DAMAGE_ADD] = {
		var_0_23,
		"dodge_damage_add"
	},
	[OLDSTRIKE_DAMAGE_ADD] = {
		var_0_23,
		"strike_damage_add"
	},
	[OLDBLIND_PROB_CHANGE] = {
		var_0_23,
		"blind"
	},
	[OLDDAMAGE_CHANGE] = {
		var_0_23,
		"damage"
	},
	[OLDHP_CHANGE] = {
		var_0_23,
		"hp"
	},
	[OLDDEFENCE_CHANGE] = {
		var_0_23,
		"defence"
	},
	[OLDCRI_CHANGE] = {
		var_0_23,
		"critical"
	},
	[OLDDODGE_CHANGE] = {
		var_0_23,
		"dodge"
	},
	[OLDSTRIKE_CHANGE] = {
		var_0_23,
		"strike"
	},
	[OLDXP_CHANGE] = {
		var_0_23,
		"spellpower"
	},
	[OLDATTACKSPEED_CHANGE] = {
		var_0_23,
		"attackspeed"
	},
	[OLDMOVINGSPEED_CHANGE] = {
		var_0_23,
		"movingspeed"
	},
	[OLDHEAL_RATE_CHANGE] = {
		var_0_23,
		"healrate"
	},
	[OLDCD_MINUS] = {
		var_0_23,
		"cd_minus"
	},
	[OLDEXTRA_ATTACK_CONST] = {
		var_0_23,
		"extra_attack_const"
	},
	[OLDEXTRA_DEFENCE_CONST] = {
		var_0_23,
		"extra_defence_const"
	},
	[OLDBKB] = var_0_43,
	[OLDFORCE_CHANGE] = {
		var_0_23,
		"force"
	},
	[OLDREFORCE_CHANGE] = {
		var_0_23,
		"reforce"
	},
	[OLDATTACKRANGE_CHANGE] = {
		var_0_23,
		"range"
	},
	[OLDIGNORE_DEFENCE] = {
		var_0_23,
		"defence_rate"
	},
	[OLDIGNORE_DODGE] = var_0_47,
	[OLDCD_MINUS_CONST] = {
		var_0_23,
		"cd_minus_const"
	},
	[OLDSTATUS_TRIGGER_PROB_ADD] = var_0_49,
	[OLDSTATUS_VALUE_ADD] = var_0_51,
	[OLDBUFF_TIME_ADD] = var_0_53,
	[OLDBUFF_STACK_ADD] = var_0_55,
	[OLDSTATUS_VALUE_ADD_RANDOM] = var_0_57,
	[OLDHEAL_CONST_CHANGE] = {
		var_0_23,
		"healconst"
	},
	[OLDEXTRA_HEAL_CONST_CHANGE] = {
		var_0_23,
		"extra_heal_const"
	},
	[VERTIGO] = var_0_25,
	[STONE] = var_0_27,
	[CONFINE] = var_0_29,
	[SILENCE] = var_0_31,
	[ADDICT] = var_0_33,
	[IMMORTAL] = var_0_37,
	[HEAL_LIMIT] = var_0_41,
	[SHIELD] = var_0_35,
	[HEMATOPHAGY] = {
		var_0_23,
		"hematophagy"
	},
	[DEBUFF_IMMUNE] = var_0_43,
	[ADD_STATUS] = var_0_39,
	[BKB] = var_0_43,
	[IGNORE_DEFENCE] = {
		var_0_23,
		"defence_rate"
	},
	[IGNORE_DODGE] = var_0_47,
	[CD_MINUS_CONST] = {
		var_0_23,
		"cd_minus_const"
	},
	[CD_MINUS] = {
		var_0_23,
		"cd_minus"
	},
	[STATUS_TRIGGER_PROB_ADD] = var_0_49,
	[STATUS_TRIGGER_CD_ADD] = function()
		return function(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
			FightManager.getCharacter(arg_106_1).statuspool:registerStatusTriggerCDAdd(arg_106_3.value1, arg_106_3.value2)
		end
	end,
	[STATUS_VALUE_ADD] = var_0_51,
	[STATUS_TYPE_VALUE_ADD] = function()
		return function(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
			local var_114_0 = tonumber(arg_114_3.value1)
			local var_114_1 = FightManager.getCharacter(arg_114_1)

			if arg_114_3.target1 == 2 then
				var_114_1.statuspool:registerStatusTypeValueAdd(var_114_0, arg_114_3.value2)
			else
				var_114_1.statuspool:registerStatusTypeExertValueAdd(var_114_0, arg_114_3.value2)
			end
		end
	end,
	[BUFF_TIME_ADD] = var_0_53,
	[BUFF_STACK_ADD] = var_0_55,
	[STATUS_VALUE_ADD_RANDOM] = var_0_57,
	[STATUS_TYPE_VALUE_ADD_RANDOM] = function()
		return function(arg_130_0, arg_130_1, arg_130_2, arg_130_3)
			local var_130_0 = tonumber(arg_130_3.value1)
			local var_130_1 = FightManager.getCharacter(arg_130_1)

			if arg_130_3.target1 == 2 then
				var_130_1.statuspool:registerStatusTypeValueAddRandom(var_130_0, arg_130_3.value2, arg_130_3.value3)
			else
				var_130_1.statuspool:registerStatusTypeExertValueAddRandom(var_130_0, arg_130_3.value2, arg_130_3.value3)
			end
		end
	end,
	[FEAR] = function()
		return function(arg_58_0, arg_58_1)
			local var_58_0 = FightManager.getCharacter(arg_58_1)

			if not var_58_0 then
				return
			end

			var_58_0.statuspool:setStatus("fear", true)
			var_58_0.statuspool:addStatus("fear_count", 1)
			var_58_0:setFear()
		end
	end,
	[DEFENCE_RATE_CHANGE] = {
		var_0_23,
		"defence_rate"
	},
	[STRIKE_RATE_CHANGE] = {
		var_0_23,
		"strike_rate"
	},
	[CRI_RATE_CHANGE] = {
		var_0_23,
		"cri_rate"
	},
	[ALL_BUFF_TIME_CHANGE] = function()
		return function(arg_134_0, arg_134_1, arg_134_2, arg_134_3)
			local var_134_0 = tonumber(arg_134_3.value1)
			local var_134_1 = FightManager.getCharacter(arg_134_1)

			if arg_134_3.target1 == 2 then
				var_134_1.statuspool:registerAllBuffTimeChange(var_134_0, arg_134_3.value2)
			else
				var_134_1.statuspool:registerAllExertBuffTimeChange(var_134_0, arg_134_3.value2)
			end
		end
	end,
	[SWITCH_FLY_UNIT] = function()
		return function(arg_138_0, arg_138_1)
			local var_138_0 = FightManager.getCharacter(arg_138_1)

			if not var_138_0 then
				return
			end

			var_138_0.statuspool:addStatus("fly_count", 1)
			var_138_0:setFlyUnit()
		end
	end,
	[CHUNGE_LIMIT] = function()
		return function(arg_78_0, arg_78_1)
			local var_78_0 = FightManager.getCharacter(arg_78_1)

			var_78_0.statuspool:setStatus("revivallimit", true)
			var_78_0.statuspool:addStatus("revivallimit_count", 1)
		end
	end,
	[FROZEN] = function()
		return function(arg_30_0, arg_30_1)
			local var_30_0 = FightManager.getCharacter(arg_30_1)

			if not var_30_0 then
				return
			end

			var_30_0.statuspool:setStatus("frozen", true)
			var_30_0.statuspool:addStatus("frozen_count", 1)
			var_30_0:setFrozen()
		end
	end,
	[SUPER_IMMORTAL] = function()
		return function(arg_70_0, arg_70_1)
			local var_70_0 = FightManager.getCharacter(arg_70_1)

			if var_70_0.statuspool:getStatus("invalidate_superimmortal") then
				var_70_0.statuspool:addStatus("superimmortal_count_temp", 1)
			else
				var_70_0.statuspool:setStatus("superimmortal", true)
				var_70_0.statuspool:addStatus("superimmortal_count", 1)
				var_70_0:setImmortal()
			end
		end
	end,
	[FORCE_IMMUNE] = function()
		return function(arg_154_0, arg_154_1)
			local var_154_0 = FightManager.getCharacter(arg_154_1)

			var_154_0.statuspool:setStatus("forceimmune", true)
			var_154_0.statuspool:addStatus("forceimmune_count", 1)
		end
	end,
	[GRAB] = function()
		return function(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
			local var_38_0 = FightManager.getCharacter(arg_38_1)

			if not var_38_0 then
				return
			end

			local var_38_1 = {
				bonename = arg_38_3.value1
			}

			var_38_1.finaloffset = cc.p(arg_38_3.value2 or 0, arg_38_3.value3 or 0)

			var_38_0:setGrabed(arg_38_2, var_38_1)
		end
	end,
	[TRANSFORM] = function()
		return function(arg_158_0, arg_158_1, arg_158_2, arg_158_3)
			FightManager.getCharacter(arg_158_1):startTransform(arg_158_3.value1, arg_158_3.value2)
		end
	end,
	[RAGE_LIMIT] = function()
		return function(arg_162_0, arg_162_1)
			local var_162_0 = FightManager.getCharacter(arg_162_1)

			var_162_0.statuspool:setStatus("ragelimit", true)
			var_162_0.statuspool:addStatus("ragelimit_count", 1)
		end
	end,
	[STEAL_ATTRIBUTE] = function()
		return function(arg_166_0, arg_166_1, arg_166_2, arg_166_3, arg_166_4)
			local var_166_0 = FightManager.getCharacter(arg_166_1)

			if not var_166_0 then
				return
			end

			local var_166_1 = FightManager.getCharacter(arg_166_2)

			if not var_166_1 then
				return
			end

			local var_166_2 = baseAttr[arg_166_3.param1].attr

			if not baseAttr[arg_166_3.param1].attr then
				return
			end

			local var_166_3 = var_0_10(arg_166_3, arg_166_4, var_166_0)
			local var_166_4 = var_166_3 + var_166_3 * var_0_12(var_166_0, arg_166_0, arg_166_2)

			if var_166_2 == "curhp" or var_166_2 == "hp" then
				var_166_4 = math.round(var_166_4)
			end

			var_166_1:addAttribute(var_166_2, -1 * var_166_4)

			return var_166_4, var_166_2
		end
	end,
	[EXTRA_ATTACK] = {
		var_0_23,
		"extra_attack"
	},
	[EXTRA_DEFENCE] = {
		var_0_23,
		"extra_defence"
	},
	[EXTRA_WEAK] = {
		var_0_23,
		"extra_weak"
	},
	[EXTRA_HEAL_ADD] = {
		var_0_23,
		"extra_heal"
	},
	[EXTRA_HEAL_MINUS] = {
		var_0_23,
		"extra_heal"
	},
	[EXTRA_INJURE] = {
		var_0_23,
		"extra_injure"
	},
	[EXTRA_ATTACK_CONST] = {
		var_0_23,
		"extra_attack_const"
	},
	[EXTRA_DEFENCE_CONST] = {
		var_0_23,
		"extra_defence_const"
	},
	[ATTACK_DEFENCE_ADD] = {
		var_0_23,
		"defence"
	},
	[ATTACK_DEFENCE_MINUS] = {
		var_0_23,
		"defence"
	},
	[CRI_PROB_ADD] = {
		var_0_23,
		"exe_critical"
	},
	[CRI_PROB_MINUS] = {
		var_0_23,
		"exe_critical"
	},
	[DODGE_PROB_ADD] = {
		var_0_23,
		"exe_dodge"
	},
	[DODGE_PROB_MINUS] = {
		var_0_23,
		"exe_dodge"
	},
	[STRIKE_PROB_ADD] = {
		var_0_23,
		"exe_strike"
	},
	[STRIKE_PROB_MINUS] = {
		var_0_23,
		"exe_strike"
	},
	[CRI_DAMAGE_ADD] = {
		var_0_23,
		"cri_damage_add"
	},
	[CRI_DAMAGE_MINUS] = {
		var_0_23,
		"cri_damage_add"
	},
	[DODGE_DAMAGE_ADD] = {
		var_0_23,
		"dodge_damage_add"
	},
	[DODGE_DAMAGE_MINUS] = {
		var_0_23,
		"dodge_damage_add"
	},
	[STRIKE_DAMAGE_ADD] = {
		var_0_23,
		"strike_damage_add"
	},
	[STRIKE_DAMAGE_MINUS] = {
		var_0_23,
		"strike_damage_add"
	},
	[BLIND_PROB_ADD] = {
		var_0_23,
		"blind"
	},
	[BLIND_PROB_MINUS] = {
		var_0_23,
		"blind"
	},
	[DAMAGE_ADD] = {
		var_0_23,
		"damage"
	},
	[DAMAGE_MINUS] = {
		var_0_23,
		"damage"
	},
	[HP_ADD] = {
		var_0_23,
		"hp"
	},
	[HP_MINUS] = {
		var_0_23,
		"hp"
	},
	[DEFENCE_ADD] = {
		var_0_23,
		"defence"
	},
	[DEFENCE_MINUS] = {
		var_0_23,
		"defence"
	},
	[CRI_ADD] = {
		var_0_23,
		"critical"
	},
	[CRI_MINUS] = {
		var_0_23,
		"critical"
	},
	[DODGE_ADD] = {
		var_0_23,
		"dodge"
	},
	[DODGE_MINUS] = {
		var_0_23,
		"dodge"
	},
	[STRIKE_ADD] = {
		var_0_23,
		"strike"
	},
	[STRIKE_MINUS] = {
		var_0_23,
		"strike"
	},
	[XP_ADD] = {
		var_0_23,
		"spellpower"
	},
	[XP_MINUS] = {
		var_0_23,
		"spellpower"
	},
	[ATTACKSPEED_ADD] = {
		var_0_23,
		"attackspeed"
	},
	[ATTACKSPEED_MINUS] = {
		var_0_23,
		"attackspeed"
	},
	[MOVINGSPEED_ADD] = {
		var_0_23,
		"movingspeed"
	},
	[MOVINGSPEED_MINUS] = {
		var_0_23,
		"movingspeed"
	},
	[HEAL_RATE_ADD] = {
		var_0_23,
		"healrate"
	},
	[HEAL_RATE_MINUS] = {
		var_0_23,
		"healrate"
	},
	[FORCE_ADD] = {
		var_0_23,
		"force"
	},
	[FORCE_MINUS] = {
		var_0_23,
		"force"
	},
	[REFORCE_ADD] = {
		var_0_23,
		"reforce"
	},
	[REFORCE_MINUS] = {
		var_0_23,
		"reforce"
	},
	[ATTACKRANGE_ADD] = {
		var_0_23,
		"range"
	},
	[ATTACKRANGE_MINUS] = {
		var_0_23,
		"range"
	},
	[HEAL_CONST_ADD] = {
		var_0_23,
		"healconst"
	},
	[HEAL_CONST_MINUS] = {
		var_0_23,
		"healconst"
	},
	[EXTRA_HEAL_CONST_ADD] = {
		var_0_23,
		"extra_heal_const"
	},
	[EXTRA_HEAL_CONST_MINUS] = {
		var_0_23,
		"extra_heal_const"
	},
	[EXTRA_MECHANICAL_ATTACK] = {
		var_0_23,
		"extra_mechanical_attack"
	},
	[EXTRA_MECHANICAL_DEFENCE] = {
		var_0_23,
		"extra_mechanical_defence"
	},
	[EXTRA_MECHANICAL_WEAK] = {
		var_0_23,
		"extra_mechanical_weak"
	},
	[EXTRA_MECHANICAL_INJURE] = {
		var_0_23,
		"extra_mechanical_injure"
	},
	[EXTRA_MECHANICAL_ATTACK_CONST] = {
		var_0_23,
		"extra_mechanical_attackconst"
	},
	[EXTRA_MECHANICAL_DEFENCE_CONST] = {
		var_0_23,
		"extra_mechanical_defenceconst"
	},
	[EXTRA_ENERGY_ATTACK] = {
		var_0_23,
		"extra_energy_attack"
	},
	[EXTRA_ENERGY_DEFENCE] = {
		var_0_23,
		"extra_energy_defence"
	},
	[EXTRA_ENERGY_WEAK] = {
		var_0_23,
		"extra_energy_weak"
	},
	[EXTRA_ENERGY_INJURE] = {
		var_0_23,
		"extra_energy_injure"
	},
	[EXTRA_ENERGY_ATTACK_CONST] = {
		var_0_23,
		"extra_energy_attackconst"
	},
	[EXTRA_ENERGY_DEFENCE_CONST] = {
		var_0_23,
		"extra_energy_defenceconst"
	},
	[ENERGYDEFENCE_ADD] = {
		var_0_23,
		"energydefence"
	},
	[ENERGYDEFENCE_MINUS] = {
		var_0_23,
		"energydefence"
	},
	[ENERGYDEFENCE_RATE_CHANGE] = {
		var_0_23,
		"energydefence_rate"
	},
	[EXTRA_ATTACK_RAGE_CHANGE] = {
		var_0_23,
		"extra_attack_rage"
	},
	[EXTRA_ATTACK_RAGE_CHANGE_CONST] = {
		var_0_23,
		"extra_attack_rage_const"
	},
	[DEBUFF_IMMUNE_2] = function()
		return function(arg_142_0, arg_142_1, arg_142_2, arg_142_3)
			local var_142_0 = FightManager.getCharacter(arg_142_1)
			local var_142_1 = {}

			for iter_142_0 in arg_142_3.value1:gmatch("(%d+)") do
				table.insert(var_142_1, tonumber(iter_142_0))
			end

			for iter_142_1, iter_142_2 in ipairs(var_142_1) do
				var_142_0.statuspool:addImmuneDebuff(iter_142_2)
			end
		end
	end,
	[DEBUFF_IMMUNE_3] = function()
		return function(arg_146_0, arg_146_1, arg_146_2, arg_146_3)
			local var_146_0 = FightManager.getCharacter(arg_146_1)
			local var_146_1 = {}

			for iter_146_0 in arg_146_3.value1:gmatch("(%d+)") do
				table.insert(var_146_1, tonumber(iter_146_0))
			end

			for iter_146_1, iter_146_2 in ipairs(var_146_1) do
				var_146_0.statuspool:addImmuneDebuffID(iter_146_2)
			end
		end
	end,
	[EXTRA_SKILL_RAGE_CHANGE] = {
		var_0_23,
		"extra_skill_rage"
	},
	[EXTRA_SKILL_RAGE_CHANGE_CONST] = {
		var_0_23,
		"extra_skill_rage_const"
	},
	[EXTRA_RECOVERY_RAGE_CHANGE] = {
		var_0_23,
		"extra_recovery_rage"
	},
	[EXTRA_RECOVERY_RAGE_CHANGE_CONST] = {
		var_0_23,
		"extra_recovery_rage_const"
	},
	[SKILL_CD_COUNT_CHANGE] = {
		var_0_23,
		"skill_cd_count_minus"
	},
	[EXTRA_HEAL_EXTERN_ADD] = {
		var_0_23,
		"extra_heal_extern"
	},
	[EXTRA_HEAL_EXTERN_MINUS] = {
		var_0_23,
		"extra_heal_extern"
	},
	[RAGE_FREE] = function()
		return function(arg_150_0, arg_150_1)
			local var_150_0 = FightManager.getCharacter(arg_150_1)

			var_150_0.statuspool:setStatus("ragefree", true)
			var_150_0.statuspool:addStatus("ragefree_count", 1)
		end
	end,
	[GET_RAGE] = {
		var_0_23,
		"rage"
	},
	[PIERCE_CHANGE] = {
		var_0_23,
		"pierce"
	},
	[PIERCE_PERCENT_CHANGE] = {
		var_0_23,
		"piercepercent"
	},
	[ENERGY_PIERCE_CHANGE] = {
		var_0_23,
		"energypierce"
	},
	[ENERGY_PIERCE_PERCENT_CHANGE] = {
		var_0_23,
		"energypiercepercent"
	},
	[ADD_ATTR_WEAK] = {
		var_0_60,
		"addattrweak"
	},
	[REDUCE_ATTR_WEAK] = {
		var_0_60,
		"reduceattrweak"
	},
	[TRANSFER_DAMAGE] = {
		function()
			return function(arg_174_0, arg_174_1, arg_174_2, arg_174_3, arg_174_4)
				local var_174_0 = FightManager.getCharacter(arg_174_2)
				local var_174_1 = FightManager.getCharacter(arg_174_1)

				if arg_174_2 and arg_174_2 ~= arg_174_1 and not var_174_1.statuspool:getStatus("transferdamage") then
					var_174_1:beBear(arg_174_2, arg_174_3.value1)
					var_174_1.statuspool:setStatus("transferdamage", true)
				end
			end
		end,
		"transferdamage"
	},
	[MAX_TAKEN_DAMAGE] = {
		var_0_23,
		"max_taken_damage"
	},
	[IGNORE_MAX_DAMAGE] = {
		function()
			return function(arg_178_0, arg_178_1, arg_178_2, arg_178_3, arg_178_4)
				local var_178_0 = FightManager.getCharacter(arg_178_2)

				FightManager.getCharacter(arg_178_1).statuspool:setStatus("ignoremaxdamage", true)
			end
		end,
		"ignoremaxdamage"
	},
	[MAX_CAUSE_DAMAGE] = {
		var_0_23,
		"max_cause_damage"
	},
	[IGNORE_MAX_CAUSE_DAMAGE] = {
		function()
			return function(arg_182_0, arg_182_1, arg_182_2, arg_182_3, arg_182_4)
				local var_182_0 = FightManager.getCharacter(arg_182_2)

				FightManager.getCharacter(arg_182_1).statuspool:setStatus("ignoremaxcausedamage", true)
			end
		end,
		"ignoremaxcausedamage"
	},
	[MAX_CAUSE_DAMAGE_HOLY] = {
		var_0_23,
		"max_cause_damage_holy"
	},
	[IGNORE_MAX_CAUSE_DAMAGE_HOLY] = {
		function()
			return function(arg_186_0, arg_186_1, arg_186_2, arg_186_3, arg_186_4)
				local var_186_0 = FightManager.getCharacter(arg_186_2)

				FightManager.getCharacter(arg_186_1).statuspool:setStatus("ignoremaxcausedamageholy", true)
			end
		end,
		"ignoremaxcausedamageholy"
	},
	[MAX_CAUSE_DAMAGE_MECHANICAL] = {
		var_0_23,
		"max_cause_damage_mechanical"
	},
	[IGNORE_MAX_CAUSE_DAMAGE_MECHANICAL] = {
		function()
			return function(arg_190_0, arg_190_1, arg_190_2, arg_190_3, arg_190_4)
				local var_190_0 = FightManager.getCharacter(arg_190_2)

				FightManager.getCharacter(arg_190_1).statuspool:setStatus("ignoremaxcausedamagemechanical", true)
			end
		end,
		"ignoremaxcausedamagemechanical"
	},
	[MAX_CAUSE_DAMAGE_ENERGY] = {
		var_0_23,
		"max_cause_damage_energy"
	},
	[IGNORE_MAX_CAUSE_DAMAGE_ENERGY] = {
		function()
			return function(arg_194_0, arg_194_1, arg_194_2, arg_194_3, arg_194_4)
				local var_194_0 = FightManager.getCharacter(arg_194_2)

				FightManager.getCharacter(arg_194_1).statuspool:setStatus("ignoremaxcausedamageenergy", true)
			end
		end,
		"ignoremaxcausedamageenergy"
	},
	[ATTACKSPEED_LOCKED] = {
		function()
			return function(arg_198_0, arg_198_1, arg_198_2)
				local var_198_0 = FightManager.getCharacter(arg_198_2)
				local var_198_1 = FightManager.getCharacter(arg_198_1)

				var_198_1:setAttribute("cur_locked_attackspeed", var_198_1:getAttribute("attackspeed"))
				var_198_1.statuspool:setStatus("attackspeedlocked", true)
			end
		end,
		"attackspeedlocked"
	},
	[ATTACKSPEED_LOCKED_LIMIT] = {
		function()
			return function(arg_202_0, arg_202_1, arg_202_2)
				local var_202_0 = FightManager.getCharacter(arg_202_2)

				FightManager.getCharacter(arg_202_1).statuspool:setStatus("attackspeedlockedlimit", true)
			end
		end,
		"attackspeedlockedlimit"
	},
	[MAX_ATTACKSPEED_LOCKED_LIMIT] = {
		var_0_23,
		"maxattackspeedlimit"
	},
	[MIN_ATTACKSPEED_LOCKED_LIMIT] = {
		var_0_23,
		"minattackspeedlimit"
	},
	[INVALIDATE_SUPER_IMMORTAL] = {
		function()
			return function(arg_74_0, arg_74_1)
				local var_74_0 = FightManager.getCharacter(arg_74_1)

				var_74_0.statuspool:setStatus("superimmortal_count_temp", (var_74_0.statuspool:getStatus("superimmortal_count")))
				var_74_0.statuspool:setStatus("superimmortal_count", 0)
				var_74_0.statuspool:setStatus("superimmortal", false)
				var_74_0:removeImmortal()
				var_74_0.statuspool:setStatus("invalidate_superimmortal", true)
				var_74_0.statuspool:addStatus("invalidate_superimmortal_count", 1)
			end
		end
	},
	[MOCK_STATUS] = {
		function()
			return function(arg_210_0, arg_210_1, arg_210_2)
				local var_210_0 = FightManager.getCharacter(arg_210_2)
				local var_210_1 = FightManager.getCharacter(arg_210_1)

				var_210_1.statuspool:setStatus("mock_status", true)
				var_210_1.statuspool:addStatus("mock_status_count", 1)
			end
		end
	},
	[SUFFER_DAMAGE_CHANGE_MECHANICAL] = {
		function()
			return function(arg_214_0, arg_214_1, arg_214_2)
				local var_214_0 = FightManager.getCharacter(arg_214_2)
				local var_214_1 = FightManager.getCharacter(arg_214_1)

				var_214_1.statuspool:setStatus("suffer_damage_change_mechanical", true)
				var_214_1.statuspool:addStatus("suffer_damage_change_mechanical_count", 1)
			end
		end
	},
	[DAMAGE_CHANGE_MECHANICAL] = {
		function()
			return function(arg_218_0, arg_218_1, arg_218_2)
				local var_218_0 = FightManager.getCharacter(arg_218_2)
				local var_218_1 = FightManager.getCharacter(arg_218_1)

				var_218_1.statuspool:setStatus("damage_change_mechanical", true)
				var_218_1.statuspool:addStatus("damage_change_mechanical_count", 1)
			end
		end
	}
}
local var_0_65 = {
	[OLDVERTIGO] = var_0_26,
	[OLDEXTRA_ATTACK] = {
		var_0_24,
		"extra_attack"
	},
	[OLDEXTRA_DEFENCE] = {
		var_0_24,
		"extra_defence"
	},
	[OLDHEMATOPHAGY] = {
		var_0_24,
		"hematophagy"
	},
	[OLDSTONE] = var_0_28,
	[OLDCONFINE] = var_0_30,
	[OLDSILENCE] = var_0_32,
	[OLDADDICT] = var_0_34,
	[OLDEXTRA_WEAK] = {
		var_0_24,
		"extra_weak"
	},
	[OLDEXTRA_HEAL] = {
		var_0_24,
		"extra_heal"
	},
	[OLDSHIELD] = var_0_36,
	[OLDIMMORTAL] = var_0_38,
	[OLDDEBUFF_IMMUNE] = var_0_44,
	[OLDADD_STATUS] = var_0_40,
	[OLDEXTRA_INJURE] = {
		var_0_24,
		"extra_injure"
	},
	[OLDHEAL_LIMIT] = var_0_42,
	[OLDATTACK_DEFENCE] = {
		var_0_24,
		"defence"
	},
	[OLDCRI_PROB_CHANGE] = {
		var_0_24,
		"exe_critical"
	},
	[OLDDODGE_PROB_CHANGE] = {
		var_0_24,
		"exe_dodge"
	},
	[OLDSTRIKE_PROB_CHANGE] = {
		var_0_24,
		"exe_strike"
	},
	[OLDCRI_DAMAGE_ADD] = {
		var_0_24,
		"cri_damage_add"
	},
	[OLDDODGE_DAMAGE_ADD] = {
		var_0_24,
		"dodge_damage_add"
	},
	[OLDSTRIKE_DAMAGE_ADD] = {
		var_0_24,
		"strike_damage_add"
	},
	[OLDBLIND_PROB_CHANGE] = {
		var_0_24,
		"blind"
	},
	[OLDDAMAGE_CHANGE] = {
		var_0_24,
		"damage"
	},
	[OLDHP_CHANGE] = {
		var_0_24,
		"hp"
	},
	[OLDDEFENCE_CHANGE] = {
		var_0_24,
		"defence"
	},
	[OLDCRI_CHANGE] = {
		var_0_24,
		"critical"
	},
	[OLDDODGE_CHANGE] = {
		var_0_24,
		"dodge"
	},
	[OLDSTRIKE_CHANGE] = {
		var_0_24,
		"strike"
	},
	[OLDXP_CHANGE] = {
		var_0_24,
		"spellpower"
	},
	[OLDATTACKSPEED_CHANGE] = {
		var_0_24,
		"attackspeed"
	},
	[OLDMOVINGSPEED_CHANGE] = {
		var_0_24,
		"movingspeed"
	},
	[OLDHEAL_RATE_CHANGE] = {
		var_0_24,
		"healrate"
	},
	[OLDCD_MINUS] = {
		var_0_24,
		"cd_minus"
	},
	[OLDEXTRA_ATTACK_CONST] = {
		var_0_24,
		"extra_attack_const"
	},
	[OLDEXTRA_DEFENCE_CONST] = {
		var_0_24,
		"extra_defence_const"
	},
	[OLDBKB] = var_0_44,
	[OLDFORCE_CHANGE] = {
		var_0_24,
		"force"
	},
	[OLDREFORCE_CHANGE] = {
		var_0_24,
		"reforce"
	},
	[OLDATTACKRANGE_CHANGE] = {
		var_0_24,
		"range"
	},
	[OLDIGNORE_DEFENCE] = {
		var_0_24,
		"defence_rate"
	},
	[OLDIGNORE_DODGE] = var_0_48,
	[OLDCD_MINUS_CONST] = {
		var_0_24,
		"cd_minus_const"
	},
	[OLDSTATUS_TRIGGER_PROB_ADD] = var_0_50,
	[OLDSTATUS_VALUE_ADD] = var_0_52,
	[OLDBUFF_TIME_ADD] = var_0_54,
	[OLDBUFF_STACK_ADD] = var_0_56,
	[OLDSTATUS_VALUE_ADD_RANDOM] = var_0_58,
	[OLDHEAL_CONST_CHANGE] = {
		var_0_24,
		"healconst"
	},
	[OLDEXTRA_HEAL_CONST_CHANGE] = {
		var_0_24,
		"extra_heal_const"
	},
	[VERTIGO] = var_0_26,
	[STONE] = var_0_28,
	[CONFINE] = var_0_30,
	[SILENCE] = var_0_32,
	[ADDICT] = var_0_34,
	[SHIELD] = var_0_36,
	[IMMORTAL] = var_0_38,
	[DEBUFF_IMMUNE] = var_0_44,
	[ADD_STATUS] = var_0_40,
	[HEMATOPHAGY] = {
		var_0_24,
		"hematophagy"
	},
	[HEAL_LIMIT] = var_0_42,
	[CD_MINUS] = {
		var_0_24,
		"cd_minus"
	},
	[CD_MINUS_CONST] = {
		var_0_24,
		"cd_minus_const"
	},
	[BKB] = var_0_44,
	[IGNORE_DEFENCE] = {
		var_0_24,
		"ignore_defence"
	},
	[IGNORE_DODGE] = var_0_48,
	[STATUS_TRIGGER_PROB_ADD] = var_0_50,
	[STATUS_TRIGGER_CD_ADD] = function()
		return function(arg_108_0, arg_108_1, arg_108_2, arg_108_3)
			FightManager.getCharacter(arg_108_1).statuspool:unregisterStatusTriggerCDAdd(arg_108_3.value1, arg_108_3.value2)
		end
	end,
	[STATUS_VALUE_ADD] = var_0_52,
	[STATUS_TYPE_VALUE_ADD] = function()
		return function(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
			local var_116_0 = tonumber(arg_116_3.value1)
			local var_116_1 = FightManager.getCharacter(arg_116_1)

			if arg_116_3.target1 == 2 then
				var_116_1.statuspool:unregisterStatusTypeValueAdd(var_116_0, arg_116_3.value2)
			else
				var_116_1.statuspool:unregisterStatusTypeExertValueAdd(var_116_0, arg_116_3.value2)
			end
		end
	end,
	[BUFF_TIME_ADD] = var_0_54,
	[BUFF_STACK_ADD] = var_0_56,
	[STATUS_VALUE_ADD_RANDOM] = var_0_58,
	[STATUS_TYPE_VALUE_ADD_RANDOM] = function()
		return function(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
			local var_132_0 = tonumber(arg_132_3.value1)
			local var_132_1 = FightManager.getCharacter(arg_132_1)

			if arg_132_3.target1 == 2 then
				var_132_1.statuspool:unregisterStatusTypeValueAddRandom(var_132_0, arg_132_3.value2, arg_132_3.value3)
			else
				var_132_1.statuspool:unregisterStatusTypeExertValueAddRandom(var_132_0, arg_132_3.value2, arg_132_3.value3)
			end
		end
	end,
	[FEAR] = function()
		return function(arg_60_0, arg_60_1)
			local var_60_0 = FightManager.getCharacter(arg_60_1)

			if not var_60_0 then
				return
			end

			var_60_0.statuspool:addStatus("fear_count", -1)

			if var_60_0.statuspool:getStatus("fear_count") <= 0 then
				var_60_0.statuspool:setStatus("fear", false)
				var_60_0:removeFear()
			end
		end
	end,
	[DEFENCE_RATE_CHANGE] = {
		var_0_24,
		"defence_rate"
	},
	[STRIKE_RATE_CHANGE] = {
		var_0_24,
		"strike_rate"
	},
	[CRI_RATE_CHANGE] = {
		var_0_24,
		"cri_rate"
	},
	[ALL_BUFF_TIME_CHANGE] = function()
		return function(arg_136_0, arg_136_1, arg_136_2, arg_136_3)
			local var_136_0 = tonumber(arg_136_3.value1)
			local var_136_1 = FightManager.getCharacter(arg_136_1)

			if arg_136_3.target1 == 2 then
				var_136_1.statuspool:unregisterAllBuffTimeChange(var_136_0, arg_136_3.value2)
			else
				var_136_1.statuspool:unregisterAllExertBuffTimeChange(var_136_0, arg_136_3.value2)
			end
		end
	end,
	[SWITCH_FLY_UNIT] = function()
		return function(arg_140_0, arg_140_1)
			local var_140_0 = FightManager.getCharacter(arg_140_1)

			if not var_140_0 then
				return
			end

			var_140_0.statuspool:addStatus("fly_count", -1)

			if var_140_0.statuspool:getStatus("fly_count") <= 0 then
				var_140_0:removeFlyUnit()
			end
		end
	end,
	[CHUNGE_LIMIT] = function()
		return function(arg_80_0, arg_80_1)
			local var_80_0 = FightManager.getCharacter(arg_80_1)

			var_80_0.statuspool:addStatus("revivallimit_count", -1)

			if var_80_0.statuspool:getStatus("revivallimit_count") <= 0 then
				var_80_0.statuspool:setStatus("revivallimit", false)
			end
		end
	end,
	[FROZEN] = function()
		return function(arg_32_0, arg_32_1)
			local var_32_0 = FightManager.getCharacter(arg_32_1)

			if not var_32_0 then
				return
			end

			var_32_0.statuspool:addStatus("frozen_count", -1)

			if var_32_0.statuspool:getStatus("frozen_count") <= 0 then
				var_32_0.statuspool:setStatus("frozen", false)
				var_32_0:removeFrozen()
			end
		end
	end,
	[SUPER_IMMORTAL] = function()
		return function(arg_72_0, arg_72_1)
			local var_72_0 = FightManager.getCharacter(arg_72_1)

			if var_72_0.statuspool:getStatus("invalidate_superimmortal") then
				var_72_0.statuspool:addStatus("superimmortal_count_temp", -1)
			else
				var_72_0.statuspool:addStatus("superimmortal_count", -1)

				if var_72_0.statuspool:getStatus("superimmortal_count") <= 0 then
					var_72_0.statuspool:setStatus("superimmortal", false)
					var_72_0:removeImmortal()
				end
			end
		end
	end,
	[FORCE_IMMUNE] = function()
		return function(arg_156_0, arg_156_1, arg_156_2, arg_156_3)
			local var_156_0 = FightManager.getCharacter(arg_156_1)

			if not var_156_0 then
				return
			end

			var_156_0.statuspool:addStatus("forceimmune_count", -1)

			if var_156_0.statuspool:getStatus("forceimmune_count") <= 0 then
				var_156_0.statuspool:setStatus("forceimmune", false)
			end
		end
	end,
	[GRAB] = function()
		return function(arg_40_0, arg_40_1, arg_40_2)
			local var_40_0 = FightManager.getCharacter(arg_40_1)

			if not var_40_0 then
				return
			end

			var_40_0:removeGrabed(arg_40_2)
		end
	end,
	[TRANSFORM] = function()
		return function(arg_160_0, arg_160_1)
			FightManager.getCharacter(arg_160_1):finishTransform()
		end
	end,
	[RAGE_LIMIT] = function()
		return function(arg_164_0, arg_164_1, arg_164_2, arg_164_3)
			local var_164_0 = FightManager.getCharacter(arg_164_1)

			if not var_164_0 then
				return
			end

			var_164_0.statuspool:addStatus("ragelimit_count", -1)

			if var_164_0.statuspool:getStatus("ragelimit_count") <= 0 then
				var_164_0.statuspool:setStatus("ragelimit", false)
			end
		end
	end,
	[STEAL_ATTRIBUTE] = function()
		return function(arg_168_0, arg_168_1, arg_168_2, arg_168_3, arg_168_4, arg_168_5, arg_168_6)
			local var_168_0 = arg_168_6 or 0
			local var_168_1 = baseAttr[arg_168_3.param1].attr

			if not baseAttr[arg_168_3.param1].attr then
				return
			end

			local var_168_2 = FightManager.getCharacter(arg_168_1)

			if var_168_2 then
				var_168_2:addAttribute(var_168_1, -1 * var_168_0)
			end

			local var_168_3 = FightManager.getCharacter(arg_168_2)

			if var_168_3 then
				var_168_3:addAttribute(var_168_1, var_168_0)
			end
		end
	end,
	[EXTRA_ATTACK] = {
		var_0_24,
		"extra_attack"
	},
	[EXTRA_DEFENCE] = {
		var_0_24,
		"extra_defence"
	},
	[EXTRA_WEAK] = {
		var_0_24,
		"extra_weak"
	},
	[EXTRA_HEAL_ADD] = {
		var_0_24,
		"extra_heal"
	},
	[EXTRA_HEAL_MINUS] = {
		var_0_24,
		"extra_heal"
	},
	[EXTRA_INJURE] = {
		var_0_24,
		"extra_injure"
	},
	[EXTRA_ATTACK_CONST] = {
		var_0_24,
		"extra_attack_const"
	},
	[EXTRA_DEFENCE_CONST] = {
		var_0_24,
		"extra_defence_const"
	},
	[ATTACK_DEFENCE_ADD] = {
		var_0_24,
		"defence"
	},
	[ATTACK_DEFENCE_MINUS] = {
		var_0_24,
		"defence"
	},
	[CRI_PROB_ADD] = {
		var_0_24,
		"exe_critical"
	},
	[CRI_PROB_MINUS] = {
		var_0_24,
		"exe_critical"
	},
	[DODGE_PROB_ADD] = {
		var_0_24,
		"exe_dodge"
	},
	[DODGE_PROB_MINUS] = {
		var_0_24,
		"exe_dodge"
	},
	[STRIKE_PROB_ADD] = {
		var_0_24,
		"exe_strike"
	},
	[STRIKE_PROB_MINUS] = {
		var_0_24,
		"exe_strike"
	},
	[CRI_DAMAGE_ADD] = {
		var_0_24,
		"cri_damage_add"
	},
	[CRI_DAMAGE_MINUS] = {
		var_0_24,
		"cri_damage_add"
	},
	[DODGE_DAMAGE_ADD] = {
		var_0_24,
		"dodge_damage_add"
	},
	[DODGE_DAMAGE_MINUS] = {
		var_0_24,
		"dodge_damage_add"
	},
	[STRIKE_DAMAGE_ADD] = {
		var_0_24,
		"strike_damage_add"
	},
	[STRIKE_DAMAGE_MINUS] = {
		var_0_24,
		"strike_damage_add"
	},
	[BLIND_PROB_ADD] = {
		var_0_24,
		"blind"
	},
	[BLIND_PROB_MINUS] = {
		var_0_24,
		"blind"
	},
	[DAMAGE_ADD] = {
		var_0_24,
		"damage"
	},
	[DAMAGE_MINUS] = {
		var_0_24,
		"damage"
	},
	[HP_ADD] = {
		var_0_24,
		"hp"
	},
	[HP_MINUS] = {
		var_0_24,
		"hp"
	},
	[DEFENCE_ADD] = {
		var_0_24,
		"defence"
	},
	[DEFENCE_MINUS] = {
		var_0_24,
		"defence"
	},
	[CRI_ADD] = {
		var_0_24,
		"critical"
	},
	[CRI_MINUS] = {
		var_0_24,
		"critical"
	},
	[DODGE_ADD] = {
		var_0_24,
		"dodge"
	},
	[DODGE_MINUS] = {
		var_0_24,
		"dodge"
	},
	[STRIKE_ADD] = {
		var_0_24,
		"strike"
	},
	[STRIKE_MINUS] = {
		var_0_24,
		"strike"
	},
	[XP_ADD] = {
		var_0_24,
		"spellpower"
	},
	[XP_MINUS] = {
		var_0_24,
		"spellpower"
	},
	[ATTACKSPEED_ADD] = {
		var_0_24,
		"attackspeed"
	},
	[ATTACKSPEED_MINUS] = {
		var_0_24,
		"attackspeed"
	},
	[MOVINGSPEED_ADD] = {
		var_0_24,
		"movingspeed"
	},
	[MOVINGSPEED_MINUS] = {
		var_0_24,
		"movingspeed"
	},
	[HEAL_RATE_ADD] = {
		var_0_24,
		"healrate"
	},
	[HEAL_RATE_MINUS] = {
		var_0_24,
		"healrate"
	},
	[FORCE_ADD] = {
		var_0_24,
		"force"
	},
	[FORCE_MINUS] = {
		var_0_24,
		"force"
	},
	[REFORCE_ADD] = {
		var_0_24,
		"reforce"
	},
	[REFORCE_MINUS] = {
		var_0_24,
		"reforce"
	},
	[ATTACKRANGE_ADD] = {
		var_0_24,
		"range"
	},
	[ATTACKRANGE_MINUS] = {
		var_0_24,
		"range"
	},
	[HEAL_CONST_ADD] = {
		var_0_24,
		"healconst"
	},
	[HEAL_CONST_MINUS] = {
		var_0_24,
		"healconst"
	},
	[EXTRA_HEAL_CONST_ADD] = {
		var_0_24,
		"extra_heal_const"
	},
	[EXTRA_HEAL_CONST_MINUS] = {
		var_0_24,
		"extra_heal_const"
	},
	[EXTRA_MECHANICAL_ATTACK] = {
		var_0_24,
		"extra_mechanical_attack"
	},
	[EXTRA_MECHANICAL_DEFENCE] = {
		var_0_24,
		"extra_mechanical_defence"
	},
	[EXTRA_MECHANICAL_WEAK] = {
		var_0_24,
		"extra_mechanical_weak"
	},
	[EXTRA_MECHANICAL_INJURE] = {
		var_0_24,
		"extra_mechanical_injure"
	},
	[EXTRA_MECHANICAL_ATTACK_CONST] = {
		var_0_24,
		"extra_mechanical_attackconst"
	},
	[EXTRA_MECHANICAL_DEFENCE_CONST] = {
		var_0_24,
		"extra_mechanical_defenceconst"
	},
	[EXTRA_ENERGY_ATTACK] = {
		var_0_24,
		"extra_energy_attack"
	},
	[EXTRA_ENERGY_DEFENCE] = {
		var_0_24,
		"extra_energy_defence"
	},
	[EXTRA_ENERGY_WEAK] = {
		var_0_24,
		"extra_energy_weak"
	},
	[EXTRA_ENERGY_INJURE] = {
		var_0_24,
		"extra_energy_injure"
	},
	[EXTRA_ENERGY_ATTACK_CONST] = {
		var_0_24,
		"extra_energy_attackconst"
	},
	[EXTRA_ENERGY_DEFENCE_CONST] = {
		var_0_24,
		"extra_energy_defenceconst"
	},
	[ENERGYDEFENCE_ADD] = {
		var_0_24,
		"energydefence"
	},
	[ENERGYDEFENCE_MINUS] = {
		var_0_24,
		"energydefence"
	},
	[ENERGYDEFENCE_RATE_CHANGE] = {
		var_0_24,
		"energydefence_rate"
	},
	[EXTRA_ATTACK_RAGE_CHANGE] = {
		var_0_24,
		"extra_attack_rage"
	},
	[EXTRA_ATTACK_RAGE_CHANGE_CONST] = {
		var_0_24,
		"extra_attack_rage_const"
	},
	[DEBUFF_IMMUNE_2] = function()
		return function(arg_144_0, arg_144_1, arg_144_2, arg_144_3)
			local var_144_0 = FightManager.getCharacter(arg_144_1)
			local var_144_1 = {}

			for iter_144_0 in arg_144_3.value1:gmatch("(%d+)") do
				table.insert(var_144_1, tonumber(iter_144_0))
			end

			for iter_144_1, iter_144_2 in ipairs(var_144_1) do
				var_144_0.statuspool:removeImmuneDebuff(iter_144_2)
			end
		end
	end,
	[DEBUFF_IMMUNE_3] = function()
		return function(arg_148_0, arg_148_1, arg_148_2, arg_148_3)
			local var_148_0 = FightManager.getCharacter(arg_148_1)
			local var_148_1 = {}

			for iter_148_0 in arg_148_3.value1:gmatch("(%d+)") do
				table.insert(var_148_1, tonumber(iter_148_0))
			end

			for iter_148_1, iter_148_2 in ipairs(var_148_1) do
				var_148_0.statuspool:removeImmuneDebuffID(iter_148_2)
			end
		end
	end,
	[EXTRA_SKILL_RAGE_CHANGE] = {
		var_0_24,
		"extra_skill_rage"
	},
	[EXTRA_SKILL_RAGE_CHANGE_CONST] = {
		var_0_24,
		"extra_skill_rage_const"
	},
	[EXTRA_RECOVERY_RAGE_CHANGE] = {
		var_0_24,
		"extra_recovery_rage"
	},
	[EXTRA_RECOVERY_RAGE_CHANGE_CONST] = {
		var_0_24,
		"extra_recovery_rage_const"
	},
	[SKILL_CD_COUNT_CHANGE] = {
		var_0_24,
		"skill_cd_count_minus"
	},
	[EXTRA_HEAL_EXTERN_ADD] = {
		var_0_24,
		"extra_heal_extern"
	},
	[EXTRA_HEAL_EXTERN_MINUS] = {
		var_0_24,
		"extra_heal_extern"
	},
	[RAGE_FREE] = var_0_59,
	[GET_RAGE] = {
		var_0_59,
		"rage"
	},
	[PIERCE_CHANGE] = {
		var_0_24,
		"pierce"
	},
	[PIERCE_PERCENT_CHANGE] = {
		var_0_24,
		"piercepercent"
	},
	[ENERGY_PIERCE_CHANGE] = {
		var_0_24,
		"energypierce"
	},
	[ENERGY_PIERCE_PERCENT_CHANGE] = {
		var_0_24,
		"energypiercepercent"
	},
	[ADD_ATTR_WEAK] = {
		var_0_61,
		"addattrweak"
	},
	[REDUCE_ATTR_WEAK] = {
		var_0_61,
		"reduceattrweak"
	},
	[TRANSFER_DAMAGE] = {
		function()
			return function(arg_176_0, arg_176_1, arg_176_2)
				local var_176_0 = FightManager.getCharacter(arg_176_2)
				local var_176_1 = FightManager.getCharacter(arg_176_1)

				if var_176_1.statuspool:getStatus("transferdamage") then
					var_176_1:removeBear()
					var_176_1.statuspool:setStatus("transferdamage", false)
				end
			end
		end,
		"transferdamage"
	},
	[MAX_TAKEN_DAMAGE] = {
		var_0_24,
		"max_taken_damage"
	},
	[IGNORE_MAX_DAMAGE] = {
		function()
			return function(arg_180_0, arg_180_1, arg_180_2)
				local var_180_0 = FightManager.getCharacter(arg_180_2)

				FightManager.getCharacter(arg_180_1).statuspool:setStatus("transferdamage", false)
			end
		end,
		"ignoremaxdamage"
	},
	[MAX_CAUSE_DAMAGE] = {
		var_0_24,
		"max_cause_damage"
	},
	[IGNORE_MAX_CAUSE_DAMAGE] = {
		function()
			return function(arg_184_0, arg_184_1, arg_184_2)
				local var_184_0 = FightManager.getCharacter(arg_184_2)

				FightManager.getCharacter(arg_184_1).statuspool:setStatus("ignoremaxcausedamage", false)
			end
		end,
		"ignoremaxcausedamage"
	},
	[MAX_CAUSE_DAMAGE_HOLY] = {
		var_0_24,
		"max_cause_damage_holy"
	},
	[IGNORE_MAX_CAUSE_DAMAGE_HOLY] = {
		function()
			return function(arg_188_0, arg_188_1, arg_188_2)
				local var_188_0 = FightManager.getCharacter(arg_188_2)

				FightManager.getCharacter(arg_188_1).statuspool:setStatus("ignoremaxcausedamageholy", false)
			end
		end,
		"ignoremaxcausedamageholy"
	},
	[MAX_CAUSE_DAMAGE_MECHANICAL] = {
		var_0_24,
		"max_cause_damage_mechanical"
	},
	[IGNORE_MAX_CAUSE_DAMAGE_MECHANICAL] = {
		function()
			return function(arg_192_0, arg_192_1, arg_192_2)
				local var_192_0 = FightManager.getCharacter(arg_192_2)

				FightManager.getCharacter(arg_192_1).statuspool:setStatus("ignoremaxcausedamagemechanical", false)
			end
		end,
		"ignoremaxcausedamagemechanical"
	},
	[MAX_CAUSE_DAMAGE_ENERGY] = {
		var_0_24,
		"max_cause_damage_energy"
	},
	[IGNORE_MAX_CAUSE_DAMAGE_ENERGY] = {
		function()
			return function(arg_196_0, arg_196_1, arg_196_2)
				local var_196_0 = FightManager.getCharacter(arg_196_2)

				FightManager.getCharacter(arg_196_1).statuspool:setStatus("ignoremaxcausedamageenergy", false)
			end
		end,
		"ignoremaxcausedamageenergy"
	},
	[ATTACKSPEED_LOCKED] = {
		function()
			return function(arg_200_0, arg_200_1, arg_200_2)
				local var_200_0 = FightManager.getCharacter(arg_200_2)

				FightManager.getCharacter(arg_200_1).statuspool:setStatus("attackspeedlocked", false)
			end
		end,
		"ignoreattackspeedlocked"
	},
	[ATTACKSPEED_LOCKED_LIMIT] = {
		function()
			return function(arg_204_0, arg_204_1, arg_204_2)
				local var_204_0 = FightManager.getCharacter(arg_204_2)

				FightManager.getCharacter(arg_204_1).statuspool:setStatus("attackspeedlockedlimit", false)
			end
		end,
		"attackspeedlockedlimit"
	},
	[MAX_ATTACKSPEED_LOCKED_LIMIT] = {
		var_0_24,
		"maxattackspeedlimit"
	},
	[MIN_ATTACKSPEED_LOCKED_LIMIT] = {
		var_0_24,
		"minattackspeedlimit"
	},
	[INVALIDATE_SUPER_IMMORTAL] = {
		function()
			return function(arg_76_0, arg_76_1)
				local var_76_0 = FightManager.getCharacter(arg_76_1)

				var_76_0.statuspool:addStatus("invalidate_superimmortal_count", -1)

				if var_76_0.statuspool:getStatus("invalidate_superimmortal_count") <= 0 then
					var_76_0.statuspool:setStatus("invalidate_superimmortal", false)

					local var_76_1 = var_76_0.statuspool:getStatus("superimmortal_count_temp")

					var_76_0.statuspool:setStatus("superimmortal_count", var_76_1)

					if var_76_1 > 0 then
						var_76_0.statuspool:setStatus("superimmortal", true)
						var_76_0:setImmortal()
					end
				end
			end
		end
	},
	[MOCK_STATUS] = {
		function()
			return function(arg_212_0, arg_212_1, arg_212_2)
				local var_212_0 = FightManager.getCharacter(arg_212_2)
				local var_212_1 = FightManager.getCharacter(arg_212_1)

				var_212_1.statuspool:addStatus("mock_status_count", -1)

				if var_212_1.statuspool:getStatus("mock_status_count") <= 0 then
					var_212_1.statuspool:setStatus("mock_status", false)
				end
			end
		end
	},
	[SUFFER_DAMAGE_CHANGE_MECHANICAL] = {
		function()
			return function(arg_216_0, arg_216_1, arg_216_2)
				local var_216_0 = FightManager.getCharacter(arg_216_2)
				local var_216_1 = FightManager.getCharacter(arg_216_1)

				var_216_1.statuspool:addStatus("suffer_damage_change_mechanical_count", -1)

				if var_216_1.statuspool:getStatus("suffer_damage_change_mechanical_count") <= 0 then
					var_216_1.statuspool:setStatus("suffer_damage_change_mechanical", false)
				end
			end
		end
	},
	[DAMAGE_CHANGE_MECHANICAL] = {
		function()
			return function(arg_220_0, arg_220_1, arg_220_2)
				local var_220_0 = FightManager.getCharacter(arg_220_2)
				local var_220_1 = FightManager.getCharacter(arg_220_1)

				var_220_1.statuspool:addStatus("damage_change_mechanical_count", -1)

				if var_220_1.statuspool:getStatus("damage_change_mechanical_count") <= 0 then
					var_220_1.statuspool:setStatus("damage_change_mechanical", false)
				end
			end
		end
	}
}

function var_0_0.getRegisterMethod(arg_221_0, arg_221_1, ...)
	if not var_0_64[arg_221_1] then
		return nil
	end

	return var_0_64[arg_221_1](...)
end

function var_0_0.getUnregisterMethod(arg_222_0, arg_222_1, ...)
	if not var_0_65[arg_222_1] then
		return nil
	end

	return var_0_65[arg_222_1](...)
end

function var_0_0.getRegisterAttribute(arg_223_0, arg_223_1)
	return (type(var_0_64[arg_223_1]) == "table" or nil) and (var_0_64[arg_223_1][2] or nil)
end

local function var_0_66(arg_224_0, arg_224_1, arg_224_2, arg_224_3, arg_224_4, arg_224_5)
	local var_224_0 = var_0_19(arg_224_4.paramtbl, arg_224_1, arg_224_2, arg_224_3, arg_224_5)

	return (var_224_0 + var_224_0 * var_0_22(arg_224_2, arg_224_0, arg_224_4.sourceindex)) * (arg_224_4.refrencecount or 1)
end

local function var_0_67(arg_225_0, arg_225_1, arg_225_2, arg_225_3, arg_225_4, arg_225_5)
	local var_225_0 = var_0_20(arg_225_4.paramtbl, arg_225_1, arg_225_2, arg_225_3, arg_225_5)

	return (var_225_0 + var_225_0 * var_0_22(arg_225_2, arg_225_0, arg_225_4.sourceindex)) * (arg_225_4.refrencecount or 1)
end

local function var_0_68(arg_226_0)
	return function(arg_227_0, arg_227_1, arg_227_2, arg_227_3, arg_227_4, arg_227_5)
		local var_227_0 = FightManager.getCharacter(arg_227_1)
		local var_227_1 = FightManager.getCharacter(arg_227_2)

		if not var_227_1 then
			return
		end

		local var_227_2 = var_0_66(arg_227_0, var_227_0, var_227_1, arg_227_3, arg_227_4, arg_227_5)

		if arg_227_4.statustarget == 3 then
			var_227_0:addExternAttribute(arg_226_0, var_227_2)
		else
			var_227_1:addExternAttribute(arg_226_0, var_227_2)
		end
	end
end

local function var_0_69(arg_228_0)
	return function(arg_229_0, arg_229_1, arg_229_2, arg_229_3, arg_229_4, arg_229_5)
		if arg_228_0 then
			local var_229_0 = var_0_67(arg_229_0, FightManager.getCharacter(arg_229_1), FightManager.getCharacter(arg_229_2), arg_229_3, arg_229_4, arg_229_5)

			if arg_229_4.exetarget == OWNERSELF then
				arg_229_5.heal = arg_229_5.heal + var_229_0
			elseif arg_229_4.exetarget == TARGET then
				arg_229_5.re_heal = arg_229_5.re_heal + var_229_0
			end
		else
			local var_229_1 = FightManager.getCharacter(arg_229_1)
			local var_229_2 = FightManager.getCharacter(arg_229_2)
			local var_229_3

			if not var_229_2 or not var_229_2._instance then
				do return end

				var_229_3 = {}
			end

			var_229_3.heal = math.round((var_0_67(arg_229_0, var_229_1, var_229_2, arg_229_3, arg_229_4, arg_229_5)))
			var_229_3.sourceindex = arg_229_4 and arg_229_4.sourceindex

			var_229_2:getRecovery(var_229_3, arg_229_5 and arg_229_5.triggeronheal)
		end
	end
end

local function var_0_70()
	return function(arg_231_0, arg_231_1, arg_231_2, arg_231_3, arg_231_4, arg_231_5)
		arg_231_5.effect.hematophagy = arg_231_5.effect.hematophagy + var_0_66(arg_231_0, FightManager.getCharacter(arg_231_1), FightManager.getCharacter(arg_231_2), arg_231_3, arg_231_4, arg_231_5)
	end
end

local function var_0_71()
	return function(arg_233_0, arg_233_1, arg_233_2, arg_233_3, arg_233_4, arg_233_5)
		local var_233_0 = FightManager.getCharacter(arg_233_1)

		if not var_233_0 or not var_233_0._instance then
			return
		end

		local var_233_1 = arg_233_4.statustarget == 1 and FightManager.getCharacter(arg_233_4.sourceindex) or arg_233_4.statustarget == 3 and var_233_0 or FightManager.getCharacter(arg_233_2)

		if not var_233_1 or not var_233_1._instance then
			return
		end

		local var_233_2 = arg_233_4.paramtbl.value2 or 1

		for iter_233_0 in arg_233_4.paramtbl.value1:gmatch("([^&]+)") do
			var_233_1:addBuff(tonumber(iter_233_0), arg_233_1, var_233_0:getExertBuffTimeAdd(tonumber(iter_233_0)), var_233_0:getExertBuffTimeFac(buff_data[tonumber(iter_233_0)].buff_or_debuff), var_233_0:getExertBuffStackAdd(tonumber(iter_233_0)), var_233_2)
		end
	end
end

local function var_0_72()
	return function(arg_237_0, arg_237_1, arg_237_2, arg_237_3, arg_237_4, arg_237_5)
		local var_237_1 = FightManager.getCharacter(arg_237_1)

		if not var_237_1 or not var_237_1._instance then
			return
		end

		local var_237_2 = arg_237_4.statustarget == 1 and FightManager.getCharacter(arg_237_4.sourceindex) or arg_237_4.statustarget == 3 and var_237_1 or FightManager.getCharacter(arg_237_2)

		if not var_237_2 or not var_237_2._instance then
			return
		end
	end
end

local function var_0_73()
	return function(arg_239_0, arg_239_1, arg_239_2, arg_239_3, arg_239_4, arg_239_5)
		local var_239_0 = FightManager.getCharacter(arg_239_2)

		if not var_239_0 or not var_239_0._instance then
			return
		end

		local var_239_1, var_239_2 = arg_239_4.paramtbl.value1:match("status=(.+)/buff=(.+)")

		for iter_239_0 in var_239_2:gmatch("([^&]+)") do
			var_239_0:addBuff(tonumber(iter_239_0), arg_239_4.sourceindex, var_239_0:getExertBuffTimeAdd(tonumber(iter_239_0)), var_239_0:getExertBuffTimeFac(buff_data[tonumber(iter_239_0)].buff_or_debuff), (var_239_0:getExertBuffStackAdd(tonumber(iter_239_0))))
		end
	end
end

local function var_0_74()
	return function(arg_241_0, arg_241_1, arg_241_2, arg_241_3, arg_241_4, arg_241_5)
		arg_241_5.doubleattack = true
	end
end

local function var_0_75(arg_242_0)
	return function(arg_243_0, arg_243_1, arg_243_2, arg_243_3, arg_243_4, arg_243_5)
		if arg_242_0 then
			arg_243_5.damage = arg_243_5.damage + var_0_67(arg_243_0, FightManager.getCharacter(arg_243_1), FightManager.getCharacter(arg_243_2), arg_243_3, arg_243_4, arg_243_5)
		else
			local var_243_0 = FightManager.getCharacter(arg_243_1)
			local var_243_1 = FightManager.getCharacter(arg_243_2)
			local var_243_2

			if not var_243_1 or not var_243_1._instance then
				do return end

				var_243_2 = {}
			end

			var_243_2.damage = math.round((var_0_5(MECHANICAL_DAMAGE, var_0_67(arg_243_0, var_243_0, var_243_1, arg_243_3, arg_243_4, arg_243_5), FightManager.getCharacter(arg_243_4.sourceindex), var_243_1)))
			var_243_2.damagetype = MECHANICAL_DAMAGE
			var_243_2.info = {}
			var_243_2.sourceindex = arg_243_4.sourceindex

			var_243_1:beHitted(var_243_2, arg_243_5 and arg_243_5.triggeronhurt)
		end
	end
end

local function var_0_76()
	return function(arg_251_0, arg_251_1, arg_251_2, arg_251_3, arg_251_4, arg_251_5)
		local var_251_0 = FightManager.getCharacter(arg_251_2)

		var_251_0:updateCD((var_0_66(arg_251_0, FightManager.getCharacter(arg_251_1), var_251_0, arg_251_3, arg_251_4, arg_251_5)))
	end
end

local function var_0_77()
	return function(arg_253_0, arg_253_1, arg_253_2, arg_253_3, arg_253_4, arg_253_5)
		local var_253_0 = FightManager.getCharacter(arg_253_1)

		FightManager.getCharacter(arg_253_2):cleanBuff(arg_253_4.paramtbl.value1, arg_253_4.paramtbl.value2)
	end
end

local function var_0_78()
	return function(arg_255_0, arg_255_1, arg_255_2, arg_255_3, arg_255_4, arg_255_5)
		local var_255_0 = FightManager.getCharacter(arg_255_1)

		FightManager.getCharacter(arg_255_2):cleanDebuff(arg_255_4.paramtbl.value1, arg_255_4.paramtbl.value2)
	end
end

local function var_0_79()
	return function(arg_257_0, arg_257_1, arg_257_2, arg_257_3, arg_257_4, arg_257_5)
		arg_257_5.effect.immortal_limit = true
	end
end

local function var_0_80()
	return function(arg_259_0, arg_259_1, arg_259_2, arg_259_3, arg_259_4, arg_259_5)
		local var_259_0 = FightManager.getCharacter(arg_259_1)

		var_259_0:believeChunge(math.round((var_0_66(arg_259_0, var_259_0, FightManager.getCharacter(arg_259_2), arg_259_3, arg_259_4, arg_259_5))))
	end
end

local function var_0_82()
	return function(arg_263_0, arg_263_1, arg_263_2, arg_263_3, arg_263_4, arg_263_5)
		arg_263_5.effect.ignore_dodge = true
	end
end

local function var_0_83()
	return function(arg_265_0, arg_265_1, arg_265_2, arg_265_3, arg_265_4, arg_265_5)
		local var_265_0 = FightManager.getCharacter(arg_265_2)

		var_265_0:minusAllCD((var_0_66(arg_265_0, FightManager.getCharacter(arg_265_1), var_265_0, arg_265_3, arg_265_4, arg_265_5)))
	end
end

local function var_0_84()
	return function(arg_267_0, arg_267_1, arg_267_2, arg_267_3, arg_267_4, arg_267_5)
		local var_267_0 = FightManager.getCharacter(arg_267_1)

		FightManager.getCharacter(arg_267_2):removeBuffByCount(arg_267_4.paramtbl.value1, arg_267_4.paramtbl.value2)
	end
end

local var_0_86 = {
	[OLDEXTRA_ATTACK] = {
		var_0_68,
		"extra_attack"
	},
	[OLDEXTRA_DEFENCE] = {
		var_0_68,
		"extra_defence"
	},
	[OLDRECOVERY] = var_0_69,
	[OLDHEMATOPHAGY] = var_0_70,
	[OLDADD_BUFF] = var_0_71,
	[OLDEXTRA_WEAK] = {
		var_0_68,
		"extra_weak"
	},
	[OLDEXTRA_HEAL] = {
		var_0_68,
		"extra_heal"
	},
	[OLDADD_STATUS] = var_0_72,
	[OLDADD_STATUS_BUFF] = var_0_73,
	[OLDEXTRA_INJURE] = {
		var_0_68,
		"extra_injure"
	},
	[OLDDOUBLE_ATTACK] = var_0_74,
	[OLDMAKE_ATTACK] = var_0_75,
	[OLDATTACK_DEFENCE] = {
		var_0_68,
		"defence"
	},
	[OLDCRI_PROB_CHANGE] = {
		var_0_68,
		"exe_critical"
	},
	[OLDDODGE_PROB_CHANGE] = {
		var_0_68,
		"exe_dodge"
	},
	[OLDSTRIKE_PROB_CHANGE] = {
		var_0_68,
		"exe_strike"
	},
	[OLDCRI_DAMAGE_ADD] = {
		var_0_68,
		"cri_damage_add"
	},
	[OLDDODGE_DAMAGE_ADD] = {
		var_0_68,
		"dodge_damage_add"
	},
	[OLDSTRIKE_DAMAGE_ADD] = {
		var_0_68,
		"strike_damage_add"
	},
	[OLDBLIND_PROB_CHANGE] = {
		var_0_68,
		"blind"
	},
	[OLDDAMAGE_CHANGE] = {
		var_0_68,
		"damage"
	},
	[OLDDEFENCE_CHANGE] = {
		var_0_68,
		"defence"
	},
	[OLDCRI_CHANGE] = {
		var_0_68,
		"critical"
	},
	[OLDDODGE_CHANGE] = {
		var_0_68,
		"dodge"
	},
	[OLDSTRIKE_CHANGE] = {
		var_0_68,
		"strike"
	},
	[OLDXP_CHANGE] = {
		var_0_68,
		"spellpower"
	},
	[OLDCD_MINUS] = var_0_76,
	[OLDEXTRA_ATTACK_CONST] = {
		var_0_68,
		"extra_attack_const"
	},
	[OLDEXTRA_DEFENCE_CONST] = {
		var_0_68,
		"extra_defence_const"
	},
	[OLDCLEAN_BUFF] = var_0_77,
	[OLDCLEAN_DEBUFF] = var_0_78,
	[OLDIMMORTAL_LIMIT] = var_0_79,
	[OLDCHUNGE] = var_0_80,
	[OLDFORCE_CHANGE] = {
		var_0_68,
		"force"
	},
	[OLDREFORCE_CHANGE] = {
		var_0_68,
		"reforce"
	},
	[OLDIGNORE_DEFENCE] = {
		var_0_68,
		"defence_rate"
	},
	[OLDIGNORE_DODGE] = var_0_82,
	[OLDCD_MINUS_CONST] = var_0_83,
	[OLDCLEAN_SPECIFIC_BUFF] = var_0_84,
	[OLDEXTRA_HEAL_CONST_CHANGE] = {
		var_0_68,
		"extra_heal_const"
	},
	[EXTRA_ATTACK] = {
		var_0_68,
		"extra_attack"
	},
	[EXTRA_DEFENCE] = {
		var_0_68,
		"extra_defence"
	},
	[RECOVERY] = var_0_69,
	[HEMATOPHAGY] = var_0_70,
	[ADD_BUFF] = var_0_71,
	[ADD_BUFF_RANDOM] = function()
		return function(arg_235_0, arg_235_1, arg_235_2, arg_235_3, arg_235_4, arg_235_5)
			local var_235_0 = FightManager.getCharacter(arg_235_1)

			if not var_235_0 or not var_235_0._instance then
				return
			end

			local var_235_1 = arg_235_4.statustarget == 1 and FightManager.getCharacter(arg_235_4.sourceindex) or arg_235_4.statustarget == 3 and var_235_0 or FightManager.getCharacter(arg_235_2)

			if not var_235_1 or not var_235_1._instance then
				return
			end

			local var_235_2 = arg_235_4.paramtbl.value2 or 1
			local var_235_3 = {}

			for iter_235_0 in arg_235_4.paramtbl.value1:gmatch("([^&]+)") do
				table.insert(var_235_3, tonumber(iter_235_0))
			end

			local var_235_4 = #var_235_3 == 1 and var_235_3[1] or var_235_3[math.random(1, #var_235_3)]

			var_235_1:addBuff(var_235_4, arg_235_1, var_235_0:getExertBuffTimeAdd(var_235_4), var_235_0:getExertBuffTimeFac(buff_data[var_235_4].buff_or_debuff), var_235_0:getExertBuffStackAdd(var_235_4), var_235_2)
		end
	end,
	[EXTRA_WEAK] = {
		var_0_68,
		"extra_weak"
	},
	[EXTRA_HEAL_ADD] = {
		var_0_68,
		"extra_heal"
	},
	[EXTRA_HEAL_MINUS] = {
		var_0_68,
		"extra_heal"
	},
	[ADD_STATUS] = var_0_72,
	[ADD_STATUS_BUFF] = var_0_73,
	[EXTRA_INJURE] = {
		var_0_68,
		"extra_injure"
	},
	[DOUBLE_ATTACK] = var_0_74,
	[MAKE_ATTACK] = var_0_75,
	[MAKE_ENERGY_ATTACK] = function(arg_246_0)
		return function(arg_247_0, arg_247_1, arg_247_2, arg_247_3, arg_247_4, arg_247_5)
			if arg_246_0 then
				arg_247_5.damage = arg_247_5.damage + var_0_67(arg_247_0, FightManager.getCharacter(arg_247_1), FightManager.getCharacter(arg_247_2), arg_247_3, arg_247_4, arg_247_5)
			else
				local var_247_0 = FightManager.getCharacter(arg_247_1)
				local var_247_1 = FightManager.getCharacter(arg_247_2)
				local var_247_2

				if not var_247_1 or not var_247_1._instance then
					do return end

					var_247_2 = {}
				end

				var_247_2.damage = math.round((var_0_5(ENERGY_DAMAGE, var_0_67(arg_247_0, var_247_0, var_247_1, arg_247_3, arg_247_4, arg_247_5), FightManager.getCharacter(arg_247_4.sourceindex), var_247_1)))
				var_247_2.damagetype = ENERGY_DAMAGE
				var_247_2.info = {}
				var_247_2.sourceindex = arg_247_4.sourceindex

				var_247_1:beHitted(var_247_2, arg_247_5 and arg_247_5.triggeronhurt)
			end
		end
	end,
	[MAKE_HOLY_ATTACK] = function(arg_248_0)
		return function(arg_249_0, arg_249_1, arg_249_2, arg_249_3, arg_249_4, arg_249_5)
			if arg_248_0 then
				arg_249_5.damage = arg_249_5.damage + var_0_67(arg_249_0, FightManager.getCharacter(arg_249_1), FightManager.getCharacter(arg_249_2), arg_249_3, arg_249_4, arg_249_5)
			else
				local var_249_0 = FightManager.getCharacter(arg_249_1)
				local var_249_1 = FightManager.getCharacter(arg_249_2)
				local var_249_2

				if not var_249_1 or not var_249_1._instance then
					do return end

					var_249_2 = {}
				end

				var_249_2.damage = math.round((var_0_5(HOLY_DAMAGE, var_0_67(arg_249_0, var_249_0, var_249_1, arg_249_3, arg_249_4, arg_249_5), FightManager.getCharacter(arg_249_4.sourceindex), var_249_1)))
				var_249_2.damagetype = HOLY_DAMAGE
				var_249_2.info = {}
				var_249_2.sourceindex = arg_249_4.sourceindex

				var_249_1:beHitted(var_249_2, arg_249_5 and arg_249_5.triggeronhurt)
			end
		end
	end,
	[ATTACK_DEFENCE_ADD] = {
		var_0_68,
		"defence"
	},
	[ATTACK_DEFENCE_MINUS] = {
		var_0_68,
		"defence"
	},
	[CRI_PROB_ADD] = {
		var_0_68,
		"exe_critical"
	},
	[CRI_PROB_MINUS] = {
		var_0_68,
		"exe_critical"
	},
	[DODGE_PROB_ADD] = {
		var_0_68,
		"exe_dodge"
	},
	[DODGE_PROB_MINUS] = {
		var_0_68,
		"exe_dodge"
	},
	[STRIKE_PROB_ADD] = {
		var_0_68,
		"exe_strike"
	},
	[STRIKE_PROB_MINUS] = {
		var_0_68,
		"exe_strike"
	},
	[CRI_DAMAGE_ADD] = {
		var_0_68,
		"cri_damage_add"
	},
	[CRI_DAMAGE_MINUS] = {
		var_0_68,
		"cri_damage_add"
	},
	[DODGE_DAMAGE_ADD] = {
		var_0_68,
		"dodge_damage_add"
	},
	[DODGE_DAMAGE_MINUS] = {
		var_0_68,
		"dodge_damage_add"
	},
	[STRIKE_DAMAGE_ADD] = {
		var_0_68,
		"strike_damage_add"
	},
	[STRIKE_DAMAGE_MINUS] = {
		var_0_68,
		"strike_damage_add"
	},
	[BLIND_PROB_ADD] = {
		var_0_68,
		"blind"
	},
	[BLIND_PROB_MINUS] = {
		var_0_68,
		"blind"
	},
	[DAMAGE_ADD] = {
		var_0_68,
		"damage"
	},
	[DAMAGE_MINUS] = {
		var_0_68,
		"damage"
	},
	[DEFENCE_ADD] = {
		var_0_68,
		"defence"
	},
	[DEFENCE_MINUS] = {
		var_0_68,
		"defence"
	},
	[CRI_ADD] = {
		var_0_68,
		"critical"
	},
	[CRI_MINUS] = {
		var_0_68,
		"critical"
	},
	[DODGE_ADD] = {
		var_0_68,
		"dodge"
	},
	[DODGE_MINUS] = {
		var_0_68,
		"dodge"
	},
	[STRIKE_ADD] = {
		var_0_68,
		"strike"
	},
	[STRIKE_MINUS] = {
		var_0_68,
		"strike"
	},
	[XP_ADD] = {
		var_0_68,
		"spellpower"
	},
	[XP_MINUS] = {
		var_0_68,
		"spellpower"
	},
	[CD_MINUS] = var_0_76,
	[EXTRA_ATTACK_CONST] = {
		var_0_68,
		"extra_attack_const"
	},
	[EXTRA_DEFENCE_CONST] = {
		var_0_68,
		"extra_defence_const"
	},
	[CLEAN_BUFF] = var_0_77,
	[CLEAN_DEBUFF] = var_0_78,
	[IMMORTAL_LIMIT] = var_0_79,
	[CHUNGE] = var_0_80,
	[FORCE_ADD] = {
		var_0_68,
		"force"
	},
	[FORCE_MINUS] = {
		var_0_68,
		"force"
	},
	[REFORCE_ADD] = {
		var_0_68,
		"reforce"
	},
	[REFORCE_MINUS] = {
		var_0_68,
		"reforce"
	},
	[IGNORE_DEFENCE] = {
		var_0_68,
		"defence_rate"
	},
	[IGNORE_DODGE] = var_0_82,
	[CD_MINUS_CONST] = var_0_83,
	[CLEAN_SPECIFIC_BUFF] = var_0_84,
	[DEFENCE_RATE_CHANGE] = {
		var_0_68,
		"defence_rate"
	},
	[STRIKE_RATE_CHANGE] = {
		var_0_68,
		"strike_rate"
	},
	[CRI_RATE_CHANGE] = {
		var_0_68,
		"cri_rate"
	},
	[EXTRA_HEAL_CONST_ADD] = {
		var_0_68,
		"extra_heal_const"
	},
	[EXTRA_HEAL_CONST_MINUS] = {
		var_0_68,
		"extra_heal_const"
	},
	[EXTRA_MECHANICAL_ATTACK] = {
		var_0_68,
		"extra_mechanical_attack"
	},
	[EXTRA_MECHANICAL_DEFENCE] = {
		var_0_68,
		"extra_mechanical_defence"
	},
	[EXTRA_MECHANICAL_WEAK] = {
		var_0_68,
		"extra_mechanical_weak"
	},
	[EXTRA_MECHANICAL_INJURE] = {
		var_0_68,
		"extra_mechanical_injure"
	},
	[EXTRA_MECHANICAL_ATTACK_CONST] = {
		var_0_68,
		"extra_mechanical_attackconst"
	},
	[EXTRA_MECHANICAL_DEFENCE_CONST] = {
		var_0_68,
		"extra_mechanical_defenceconst"
	},
	[EXTRA_ENERGY_ATTACK] = {
		var_0_68,
		"extra_energy_attack"
	},
	[EXTRA_ENERGY_DEFENCE] = {
		var_0_68,
		"extra_energy_defence"
	},
	[EXTRA_ENERGY_WEAK] = {
		var_0_68,
		"extra_energy_weak"
	},
	[EXTRA_ENERGY_INJURE] = {
		var_0_68,
		"extra_energy_injure"
	},
	[EXTRA_ENERGY_ATTACK_CONST] = {
		var_0_68,
		"extra_energy_attackconst"
	},
	[EXTRA_ENERGY_DEFENCE_CONST] = {
		var_0_68,
		"extra_energy_defenceconst"
	},
	[ENERGYDEFENCE_ADD] = {
		var_0_68,
		"energydefence"
	},
	[ENERGYDEFENCE_MINUS] = {
		var_0_68,
		"energydefence"
	},
	[ENERGYDEFENCE_RATE_CHANGE] = {
		var_0_68,
		"energydefence_rate"
	},
	[REAL_DAMAGE_CHANGE] = function()
		return function(arg_270_0, arg_270_1, arg_270_2, arg_270_3, arg_270_4, arg_270_5)
			if not arg_270_5 or not arg_270_5.damage then
				return
			end

			arg_270_5.damage = arg_270_5.damage + var_0_67(arg_270_0, FightManager.getCharacter(arg_270_1), FightManager.getCharacter(arg_270_2), arg_270_3, arg_270_4, arg_270_5)
		end
	end,
	[REAL_HEAL_CHANGE] = function()
		return function(arg_272_0, arg_272_1, arg_272_2, arg_272_3, arg_272_4, arg_272_5)
			if not arg_272_5 or not arg_272_5.heal then
				return
			end

			arg_272_5.heal = arg_272_5.heal + var_0_67(arg_272_0, FightManager.getCharacter(arg_272_1), FightManager.getCharacter(arg_272_2), arg_272_3, arg_272_4, arg_272_5)
		end
	end,
	[EXTRA_ATTACK_RAGE_CHANGE] = {
		var_0_68,
		"extra_attack_rage"
	},
	[EXTRA_ATTACK_RAGE_CHANGE_CONST] = {
		var_0_68,
		"extra_attack_rage_const"
	},
	[GET_RAGE] = function()
		return function(arg_274_0, arg_274_1, arg_274_2, arg_274_3, arg_274_4, arg_274_5)
			local var_274_0 = FightManager.getCharacter(arg_274_2)

			if not var_274_0 or not var_274_0._instance then
				return
			end

			var_274_0:addRageByValue((var_0_67(arg_274_0, FightManager.getCharacter(arg_274_1), var_274_0, arg_274_3, arg_274_4, arg_274_5)))
		end
	end,
	[EXTRA_SKILL_RAGE_CHANGE] = {
		var_0_68,
		"extra_skill_rage"
	},
	[EXTRA_SKILL_RAGE_CHANGE_CONST] = {
		var_0_68,
		"extra_skill_rage_const"
	},
	[EXTRA_RECOVERY_RAGE_CHANGE] = {
		var_0_68,
		"extra_recovery_rage"
	},
	[EXTRA_RECOVERY_RAGE_CHANGE_CONST] = {
		var_0_68,
		"extra_recovery_rage_const"
	},
	[RESET_SKILL_CD] = function()
		return function(arg_276_0, arg_276_1, arg_276_2, arg_276_3, arg_276_4, arg_276_5)
			(arg_276_4.statustarget == 1 and FightManager.getCharacter(arg_276_4.sourceindex) or arg_276_4.statustarget == 3 and FightManager.getCharacter(arg_276_1) or FightManager.getCharacter(arg_276_2)):resetSkillCD()
		end
	end,
	[SKILL_CD_COUNT_CHANGE] = function()
		return function(arg_280_0, arg_280_1, arg_280_2, arg_280_3, arg_280_4, arg_280_5)
			local var_280_0 = FightManager.getCharacter(arg_280_1)
			local var_280_1 = FightManager.getCharacter(arg_280_2)

			;(arg_280_4.statustarget == 1 and FightManager.getCharacter(arg_280_4.sourceindex) or arg_280_4.statustarget == 3 and var_280_0 or var_280_1):addAttackCDCount((var_0_67(arg_280_0, var_280_0, var_280_1, arg_280_3, arg_280_4, arg_280_5)))
		end
	end,
	[EXTRA_HEAL_EXTERN_ADD] = {
		var_0_68,
		"extra_heal_extern"
	},
	[EXTRA_HEAL_EXTERN_MINUS] = {
		var_0_68,
		"extra_heal_extern"
	},
	[MAKE_ATTACK_WITH_CRI] = function(arg_244_0)
		return function(arg_245_0, arg_245_1, arg_245_2, arg_245_3, arg_245_4, arg_245_5)
			if arg_244_0 then
				arg_245_5.damage = arg_245_5.damage + var_0_67(arg_245_0, FightManager.getCharacter(arg_245_1), FightManager.getCharacter(arg_245_2), arg_245_3, arg_245_4, arg_245_5)
			else
				local var_245_0 = FightManager.getCharacter(arg_245_1)
				local var_245_1 = FightManager.getCharacter(arg_245_2)

				if not var_245_1 or not var_245_1._instance then
					return
				end

				local var_245_2 = var_0_67(arg_245_0, var_245_0, var_245_1, arg_245_3, arg_245_4, arg_245_5)
				local var_245_3 = FightManager.getCharacter(arg_245_4.sourceindex)

				if not var_245_3 then
					return
				end

				local var_245_4 = FightMessage.new()

				var_245_4.damage = var_245_2

				local var_245_5, var_245_6, var_245_7, var_245_8 = var_0_7(var_245_4, MECHANICAL_DAMAGE, var_245_3, var_245_1, 0)
				local var_245_9 = 1 + var_245_3:getAttribute("cri_damage_add")
				local var_245_10 = 1 - var_245_1:getAttribute("dodge_damage_add")

				if var_245_10 < 0 then
					var_245_10 = 0
				end

				var_245_4.damage = var_245_4.damage * (var_245_8 and var_245_9 or 1) * (var_245_7 and var_245_10 or 1) * (var_245_6 and 1 + var_245_3:getAttribute("strike_damage_add") or 1)
				var_245_4.damage = var_0_5(MECHANICAL_DAMAGE, var_245_4.damage, var_245_3, var_245_1)
				var_245_4.damage = math.round(var_245_4.damage)
				var_245_4.info.isCri = var_245_8
				var_245_4.info.isMiss = isMiss
				var_245_4.info.isStrike = var_245_6

				var_245_1:beHitted({
					damage = var_245_4.damage,
					damagetype = MECHANICAL_DAMAGE,
					info = var_245_4.info,
					sourceindex = arg_245_4.sourceindex
				}, arg_245_5 and arg_245_5.triggeronhurt)
			end
		end
	end,
	[BLINK_BACK] = function()
		return function(arg_278_0, arg_278_1, arg_278_2, arg_278_3, arg_278_4, arg_278_5)
			(arg_278_4.statustarget == 1 and FightManager.getCharacter(arg_278_4.sourceindex) or arg_278_4.statustarget == 2 and FightManager.getCharacter(arg_278_2) or FightManager.getCharacter(arg_278_1)):skill_blink_back()
		end
	end,
	[PIERCE_CHANGE] = {
		var_0_68,
		"pierce"
	},
	[PIERCE_PERCENT_CHANGE] = {
		var_0_68,
		"piercepercent"
	},
	[ENERGY_PIERCE_CHANGE] = {
		var_0_68,
		"energypierce"
	},
	[ENERGY_PIERCE_PERCENT_CHANGE] = {
		var_0_68,
		"energypiercepercent"
	},
	[CONTRACT] = function()
		return function(arg_282_0, arg_282_1, arg_282_2, arg_282_3, arg_282_4, arg_282_5)
			local var_282_0 = FightManager.getCharacter(arg_282_1)

			FightManager.getCharacter(arg_282_2):beContracted(arg_282_4.sourceindex, arg_282_4.paramtbl.value1, arg_282_4.paramtbl.value2)
		end
	end,
	[FORCED_DISPLACEMENT] = function()
		return function(arg_284_0, arg_284_1, arg_284_2, arg_284_3, arg_284_4, arg_284_5)
			local var_284_0 = FightManager.getCharacter(arg_284_2)
			local var_284_1 = FightManager.getCharacter(arg_284_1):getPositionX()
			local var_284_2 = var_284_0:getPositionX()

			if var_284_1 < var_284_2 then
				var_284_0:move(var_284_1 + arg_284_4.paramtbl.value1 - var_284_2, 0)
			elseif var_284_2 < var_284_1 then
				var_284_0:move(var_284_1 - arg_284_4.paramtbl.value1 - var_284_2, 0)
			end
		end
	end
}

function var_0_0.getTriggerMethod(arg_285_0, arg_285_1, arg_285_2)
	return var_0_86[arg_285_1](arg_285_2)
end

function var_0_0.getSourceParam(arg_286_0, arg_286_1, arg_286_2)
	return var_0_9(arg_286_1, arg_286_2)
end

function var_0_0.getTriggerSourceParam(arg_287_0, arg_287_1, arg_287_2)
	return var_0_15(arg_287_1, arg_287_2)
end

function var_0_0.getRealSourceParam(arg_288_0, arg_288_1, arg_288_2)
	return var_0_16(arg_288_1, arg_288_2)
end

function var_0_0.init(arg_289_0)
	for iter_289_0, iter_289_1 in pairs(var_0_64) do
		if type(iter_289_1) == "table" then
			setmetatable(iter_289_1, {
				__call = function(self, ...)
					return self[1](self[2], ...)
				end
			})
		end
	end

	for iter_289_2, iter_289_3 in pairs(var_0_65) do
		if type(iter_289_3) == "table" then
			setmetatable(iter_289_3, {
				__call = function(self, ...)
					return self[1](self[2], ...)
				end
			})
		end
	end

	for iter_289_4, iter_289_5 in pairs(var_0_86) do
		if type(iter_289_5) == "table" then
			setmetatable(iter_289_5, {
				__call = function(self, ...)
					return self[1](self[2], ...)
				end
			})
		end
	end
end

var_0_0:init()

return var_0_0
