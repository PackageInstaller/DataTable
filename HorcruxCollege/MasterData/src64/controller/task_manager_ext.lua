local var_0_0 = {}
local playermodel = require("model.playermodel")
local core_data = require("data.core_data")
local core_manager = require("controller.core_manager")
local time_check_manager = require("controller.time_check_manager")
local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local var_0_7 = {
	[E_PASS_TRIAL] = {},
	[E_JOIN_TRIAL] = {},
	[E_CLEAR_LEVEL] = {},
	[E_HORCRUX_LEVEL] = {},
	[E_COMPONENT_EFFECT] = {},
	[E_RD_COMPONENT] = {},
	[E_RD_WEAPON] = {},
	[E_RD_HORCRUX] = {},
	[E_TRAVEL] = {},
	[E_GET_POSTCARD] = {},
	[E_FUCK_SOUL] = {},
	[E_KILL_ENEMY] = {},
	[E_KILL_ENEMY_DAILY] = {},
	[E_E_HORCRUX_LV_NUM] = {},
	[E_SCOREARENA_LEVEL] = {},
	[E_LAB_RESEARCH_EITHER] = {},
	[E_TWIST_UNIQUE_POOL] = {},
	[E_HORCRUX_UPSTAR] = {},
	[E_INVITE_PLAYER_PAY_COSTNUM] = {},
	[E_WEAPON_STAR_NUM] = {}
}

local function var_0_8(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in arg_1_0:gmatch("([^_]+)=([^_]+)") do
		var_1_0[tonumber(iter_1_0)] = tonumber(iter_1_1)
	end

	return var_1_0
end

function var_0_0:generate_task_params(arg_2_1)
	self.taskparams = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		self.taskparams[iter_2_1.id] = var_0_7[iter_2_1.id] and type(var_0_7[iter_2_1.id]) == "table" and var_0_8(iter_2_1.param) or tonumber(iter_2_1.param)
	end
end

function var_0_0:update_task_params(arg_3_1)
	self.taskparams = self.taskparams or {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		self.taskparams[iter_3_1.id] = var_0_7[iter_3_1.id] and type(var_0_7[iter_3_1.id]) == "table" and var_0_8(iter_3_1.param) or tonumber(iter_3_1.param)
	end
end

local var_0_9 = {
	[E_PASS_LEVEL] = function(arg_4_0, arg_4_1)
		local var_4_0 = 0

		if playermodel.levelmode[arg_4_0] then
			var_4_0 = playermodel.levelmode[arg_4_0].status - 1
		end

		local var_4_1 = math.floor(var_4_0 / arg_4_1 * 100)

		var_4_1 = var_4_1 <= 100 and var_4_1 or 100

		return var_4_1, arg_4_1, var_4_0
	end,
	[E_PLAYER_GRADE] = function(arg_5_0, arg_5_1)
		local var_5_0 = playermodel.grade
		local var_5_1 = math.floor(playermodel.grade / arg_5_1 * 100)

		var_5_1 = var_5_1 < 100 and math.floor(var_5_0 % 100) or 100

		return var_5_1, arg_5_1, var_5_0
	end,
	[E_PLAYER_CLASS] = function(arg_6_0, arg_6_1)
		local var_6_0 = playermodel.class
		local var_6_1 = math.floor(playermodel.class / arg_6_1 * 100)

		var_6_1 = var_6_1 <= 100 and var_6_1 or 100

		return var_6_1, arg_6_1, var_6_0
	end,
	[E_HANGUP_TIME] = function(arg_7_0, arg_7_1)
		local var_7_0 = math.floor(((time_check_manager:getCurTime() or os.time()) - playermodel.create_time) / 3600)
		local var_7_1 = math.floor(var_7_0 / arg_7_1 * 100)

		var_7_1 = var_7_1 <= 100 and var_7_1 or 100

		return var_7_1, arg_7_1, var_7_0
	end,
	[E_SOUL_NUM] = function(arg_8_0, arg_8_1)
		local var_8_0 = 0

		for iter_8_0, iter_8_1 in pairs(playermodel.haveSuit) do
			if iter_8_1 and not major_factor_data[iter_8_0].linkage then
				var_8_0 = var_8_0 + 1
			end
		end

		local var_8_1 = math.floor(var_8_0 / arg_8_1 * 100)

		var_8_1 = var_8_1 <= 100 and var_8_1 or 100

		return var_8_1, arg_8_1, var_8_0
	end,
	[E_UNLOCK_SOUL] = function(arg_9_0, arg_9_1)
		local var_9_0 = 0

		if playermodel.soulContract[arg_9_0] and playermodel.soulContract[arg_9_0] > 0 then
			var_9_0 = playermodel.soulContract[arg_9_0]
		end

		local var_9_1 = math.floor(var_9_0 / arg_9_1 * 100)

		var_9_1 = var_9_1 <= 100 and var_9_1 or 100

		return var_9_1, arg_9_1, var_9_0
	end,
	[E_SOUL_FAVOR] = function(arg_12_0, arg_12_1)
		local var_12_0 = 0

		if playermodel.favor[arg_12_0] then
			var_12_0 = playermodel.favor[arg_12_0].favorlevel
		end

		local var_12_1 = math.floor(var_12_0 / arg_12_1 * 100)

		var_12_1 = var_12_1 <= 100 and var_12_1 or 100

		return var_12_1, arg_12_1, var_12_0
	end,
	[E_GET_SOUL] = function(arg_11_0, arg_11_1)
		local var_11_0 = 0

		if playermodel.haveSuit[arg_11_1] then
			var_11_0 = 1
		end

		return var_11_0 * 100, 1, var_11_0
	end,
	[E_RANK] = function(arg_16_0, arg_16_1, arg_16_2)
		return arg_16_2.taskparams[E_RANK] <= arg_16_1 and 100 or 0, arg_16_1, arg_16_2.taskparams[E_RANK]
	end,
	[E_SERVANT_SKILL] = function(arg_13_0, arg_13_1)
		local var_13_0 = playermodel.skill1Level[arg_13_0] or 0
		local var_13_1 = math.floor(var_13_0 / arg_13_1 * 100)

		var_13_1 = var_13_1 <= 100 and var_13_1 or 100

		return var_13_1, arg_13_1, var_13_0
	end,
	[E_SOUL_SAN] = function(arg_14_0, arg_14_1)
		local var_14_0 = 0

		if playermodel.fitness[arg_14_0] then
			var_14_0 = playermodel.fitness[arg_14_0].fitnesslevel
		end

		local var_14_1 = math.floor(var_14_0 / arg_14_1 * 100)

		var_14_1 = var_14_1 <= 100 and var_14_1 or 100

		return var_14_1, arg_14_1, var_14_0
	end,
	[E_SERVANT_STRENGTH] = function(arg_15_0, arg_15_1)
		local var_15_0 = 0

		if playermodel.cores[arg_15_0] then
			var_15_0 = core_manager:getCoreLv(arg_15_0)
		end

		local var_15_2 = math.floor(var_15_0 / arg_15_1 * 100)

		var_15_2 = var_15_2 <= 100 and var_15_2 or 100

		return var_15_2, arg_15_1, var_15_0
	end,
	[E_E_HORCRUX_LV_NUM] = function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_18_2.taskparams[E_E_HORCRUX_LV_NUM][arg_18_0]
		local var_18_1 = math.floor(arg_18_2.taskparams[E_E_HORCRUX_LV_NUM][arg_18_0] / arg_18_1 * 100)

		var_18_1 = var_18_1 <= 100 and var_18_1 or 100

		return var_18_1, arg_18_1, var_18_0
	end,
	[E_SCOREARENA_LEVEL] = function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = arg_19_2.taskparams[E_SCOREARENA_LEVEL][arg_19_0]
		local var_19_1 = math.floor(arg_19_2.taskparams[E_SCOREARENA_LEVEL][arg_19_0] / arg_19_1 * 100)

		var_19_1 = var_19_1 <= 100 and var_19_1 or 100

		return var_19_1, arg_19_1, var_19_0
	end,
	[E_LAB_RESEARCH_EITHER] = function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_20_2.taskparams[E_LAB_RESEARCH_EITHER][arg_20_0]
		local var_20_1 = math.floor(arg_20_2.taskparams[E_LAB_RESEARCH_EITHER][arg_20_0] / arg_20_1 * 100)

		var_20_1 = var_20_1 <= 100 and var_20_1 or 100

		return var_20_1, arg_20_1, var_20_0
	end,
	[E_HAVE_SERVANT_LEVEL] = function(arg_10_0, arg_10_1)
		local var_10_0 = 0

		for iter_10_0, iter_10_1 in pairs(playermodel.haveServant) do
			if iter_10_1 and not servant_data[iter_10_0].linkage and arg_10_0 <= core_manager:getCoreLv(iter_10_0) then
				var_10_0 = var_10_0 + 1
			end
		end

		local var_10_2 = math.floor(var_10_0 / arg_10_1 * 100)

		var_10_2 = var_10_2 <= 100 and var_10_2 or 100

		return var_10_2, arg_10_1, var_10_0
	end,
	[E_SUBSTITUTE_RANK] = function(arg_17_0, arg_17_1, arg_17_2)
		return arg_17_1 <= arg_17_2.taskparams[E_SUBSTITUTE_RANK] and 100 or 0, arg_17_1, arg_17_2.taskparams[E_SUBSTITUTE_RANK]
	end,
	[E_CONTRACT_SERVANT_NUM] = function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = 0

		for iter_21_0, iter_21_1 in pairs(playermodel.soulContract) do
			if arg_21_0 <= iter_21_1 then
				var_21_0 = var_21_0 + 1
			end
		end

		local var_21_1 = math.floor(var_21_0 / arg_21_1 * 100)

		var_21_1 = var_21_1 <= 100 and var_21_1 or 100

		return var_21_1, arg_21_1, var_21_0
	end,
	[E_FAVOR_SOUL_NUM] = function(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = 0

		for iter_22_0, iter_22_1 in pairs(playermodel.favor) do
			if arg_22_0 <= iter_22_1.favorlevel then
				var_22_0 = var_22_0 + 1
			end
		end

		local var_22_1 = math.floor(var_22_0 / arg_22_1 * 100)

		var_22_1 = var_22_1 <= 100 and var_22_1 or 100

		return var_22_1, arg_22_1, var_22_0
	end,
	[E_SERVANT_LEVEL_NUM] = function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = 0

		for iter_23_0, iter_23_1 in pairs(playermodel.cores) do
			if arg_23_0 <= core_manager:getCoreLv(iter_23_0) then
				var_23_0 = var_23_0 + 1
			end
		end

		local var_23_2 = math.floor(var_23_0 / arg_23_1 * 100)

		var_23_2 = var_23_2 <= 100 and var_23_2 or 100

		return var_23_2, arg_23_1, var_23_0
	end,
	[E_SERVANT_OVERCLOCK] = function(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0 = playermodel.soulOverClock[arg_25_0] or 0
		local var_25_1 = math.floor(var_25_0 / arg_25_1 * 100)

		var_25_1 = var_25_1 <= 100 and var_25_1 or 100

		return var_25_1, arg_25_1, var_25_0
	end,
	[E_HORCRUX_UPSTAR] = function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_24_2.taskparams[E_HORCRUX_UPSTAR][arg_24_0] or 0
		local var_24_1 = math.floor(var_24_0 / arg_24_1 * 100)

		var_24_1 = var_24_1 <= 100 and var_24_1 or 100

		return var_24_1, arg_24_1, var_24_0
	end,
	[E_INVITE_PLAYER_PAY_COSTNUM] = function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_26_2.taskparams[E_INVITE_PLAYER_PAY_COSTNUM][arg_26_0] or 0
		local var_26_1 = math.floor(var_26_0 / arg_26_1 * 100)

		var_26_1 = var_26_1 <= 100 and var_26_1 or 100

		return var_26_1, arg_26_1, var_26_0
	end,
	[E_INVITE_PLAYER_COUNT_OPENSCHOOL] = function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = arg_27_2.taskparams[E_INVITE_PLAYER_COUNT_OPENSCHOOL] or 0
		local var_27_1 = math.floor(var_27_0 / arg_27_1 * 100)

		var_27_1 = var_27_1 <= 100 and var_27_1 or 100

		return var_27_1, arg_27_1, var_27_0
	end,
	[E_ACTIVITY_OPENBAG] = function(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = arg_28_2.taskparams[E_ACTIVITY_OPENBAG] or 0
		local var_28_1 = math.floor(var_28_0 / arg_28_1 * 100)

		var_28_1 = var_28_1 <= 100 and var_28_1 or 100

		return var_28_1, arg_28_1, var_28_0
	end
}

function var_0_0:check_common_taskcondition(arg_29_1, arg_29_2, arg_29_3)
	if not self.taskparams[arg_29_1] then
		return 0, arg_29_3, 0
	end

	if type(self.taskparams[arg_29_1]) == "table" then
		if not arg_29_2 then
			return 0, arg_29_3, 0
		end

		local var_29_0 = self.taskparams[arg_29_1][arg_29_2] or 0
		local var_29_1 = math.floor(var_29_0 / arg_29_3 * 100)

		var_29_1 = var_29_1 <= 100 and var_29_1 or 100

		return var_29_1, arg_29_3, var_29_0
	else
		local var_29_2 = self.taskparams[arg_29_1] or 0
		local var_29_3 = math.floor(var_29_2 / arg_29_3 * 100)

		var_29_3 = var_29_3 <= 100 and var_29_3 or 100

		return var_29_3, arg_29_3, var_29_2
	end
end

function var_0_0:check_condition(arg_30_1, arg_30_2, arg_30_3)
	if var_0_9[arg_30_1] then
		return var_0_9[arg_30_1](arg_30_2, arg_30_3, self)
	else
		return self:check_common_taskcondition(arg_30_1, arg_30_2, arg_30_3)
	end
end

return var_0_0
