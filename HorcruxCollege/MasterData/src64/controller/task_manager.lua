E_PASS_LEVEL = 1
E_PASS_TRIAL = 2
E_SET_SIGNMEMT = 3
E_SET_NAME = 4
E_SET_PHONE = 5
E_SET_MEDAL = 6
E_TWIST_NORMAL = 7
E_JOIN_TRIAL = 8
E_UPGRADE_WEAPON = 9
E_OPEN_RESTAURANT = 10
E_SET_DORM = 11
E_SHARE_GAME = 12
E_ARENA_DAILY = 101
E_TWIST_FREE_DAILY = 102
E_SIGH_DAILY = 103
E_MIDAS_DAILY = 104
E_QUICKFIGHT_DAILY = 105
E_HARVEST_ENERGY_DAILY = 106
E_VERIFY_ADVENTURE_DAILY = 107
E_SERVANT_DAILY = 108
E_KILL_ENEMY_DAILY = 109
E_MONTHLY_TWIST_COUNT_ACTIVITY = 800
E_PLAYER_GRADE = 1000
E_PLAYER_CLASS = 1001
E_QUICKFIGHT = 1002
E_HANGUP_TIME = 1003
E_FIGHT_FAIL = 1004
E_GAIN_SP = 1005
E_COST_SP = 1006
E_GAIN_DIAMOND = 1007
E_COST_DIAMOND = 1008
E_GAIN_GOLD = 1009
E_COST_GOLD = 1010
E_GAIN_HORNOR = 1011
E_COST_HORNOR = 1012
E_TWIST = 1013
E_MIDAS = 1014
E_SIGN = 1015
E_UNLOCK_MEDAL = 1016
E_UNLOCK_HEAD = 1017
E_CLEAR_LEVEL = 1018
E_SOUL_NUM = 1019
E_UNLOCK_SOUL = 1020
E_HORCRUX_TYPE_NUM = 1021
E_HORCRUX_NUM = 1022
E_HORCRUX_LEVEL = 1023
E_HORCRUX_COMPOUND = 1024
E_HORCRUX_RARITY = 1023
E_WEAPON_NUM = 1025
E_WEAPON_STAR = 1026
E_WEAPON_MAJOR = 1026
E_COMPONENT_EFFECT = 1027
E_COMPONENT_NUM = 1028
E_COMPONENT_SMELT = 1029
E_COMPONENT_STRENGTH = 1030
E_VERIFY_ADVENTURE = 1031
E_REJECT_ADVENTURE = 1032
E_COMPLETE_ADVENTURE = 1033
E_RD_COMPONENT = 1034
E_RD_WEAPON = 1035
E_RD_HORCRUX = 1036
E_LAB_LEVEL = 1037
E_ARENA = 1038
E_ARENA_SUCC = 1039
E_ARENA_FAIL = 1040
E_RANK = 1041
E_UNLOCK_DORM = 1042
E_SERVANT = 1043
E_TRAVEL = 1044
E_GET_POSTCARD = 1045
E_SOUL_FAVOR = 1046
E_FUCK_SOUL = 1047
E_GET_SOUL = 1048
E_KILL_ENEMY = 1049
E_GET_ITEM = 1050
E_SERVANT_SKILL = 1051
E_SOUL_SAN = 1052
E_SERVANT_STRENGTH = 1053
E_EXPLORE_TIME = 1054
E_PASS_EXPLORE = 1055
E_RD_MAJOR_WEAPON = 1056
E_E_HORCRUX_LV_NUM = 1070
E_SCOREARENA_LEVEL = 1082
E_LAB_RESEARCH_EITHER = 1084
E_HAVE_SERVANT_LEVEL = 1085
E_SUBSTITUTE_RANK = 1086
E_NINIFA_COMPOUND = 1088
E_CLEAN_DAILY_TASK = 1089
E_TWIST_UNIQUE_POOL = 1090
E_BUY_GIFTCARD = 1101
E_CONTRACT_SERVANT_NUM = 1102
E_FAVOR_SOUL_NUM = 1103
E_SERVANT_LEVEL_NUM = 1104
E_RECHARGE = 1118
E_SERVANT_OVERCLOCK = 1119
E_TWIST_COUNT_ACTIVITY = 1120
E_HORCRUX_UPSTAR = 1108
E_SERVANT_OVERCLOCK = 1119
E_INVITE_PLAYER_PAY_COSTNUM = 3100
E_INVITE_PLAYER_COUNT_OPENSCHOOL = 3101
E_ACTIVITY_OPENBAG = 3036
E_WEAPON_STAR_NUM = 2033
E_SUBSCRIPTION_PRIVILEGE = 2085

local var_0_0 = {}

setmetatable(var_0_0, {
	__index = require("controller.task_manager_ext")
})

local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local time_check_manager = require("controller.time_check_manager")
local level_manager = require("controller.level_manager")
local network = require("network.network")
local bit = require("bit")
local task_data = require("data.task_data")
local var_0_8 = {
	[TASK_TYPE_NORMAL] = require("data.normal_task_index_data"),
	[TASK_TYPE_DAILY] = require("data.daily_task_index_data"),
	[TASK_TYPE_ACHIEVE] = require("data.achieve_task_index_data"),
	[TASK_TYPE_CAREER] = require("data.career_task_index_data"),
	[TASK_TYPE_BATTLEPASS] = require("data.battle_pass_task_index_data"),
	[TASK_TYPE_FAMILY_DAILY] = require("data.task_index_dailyfamily_data"),
	[TASK_TYPE_WEEKLY] = require("data.weekly_task_index_data")
}
local var_0_9 = {
	[TASK_TYPE_NORMAL] = true,
	[TASK_TYPE_DAILY] = true,
	[TASK_TYPE_ACHIEVE] = true,
	[TASK_TYPE_CAREER] = true,
	[TASK_TYPE_BATTLEPASS] = true,
	[TASK_TYPE_WEEKLY] = true
}

var_0_0.taskinfo = {}
var_0_0.tasks = {
	[TASK_TYPE_NORMAL] = {},
	[TASK_TYPE_DAILY] = {},
	[TASK_TYPE_ACHIEVE] = {},
	[TASK_TYPE_CAREER] = {},
	[TASK_TYPE_BATTLEPASS] = {},
	[TASK_TYPE_FAMILY_DAILY] = {},
	[TASK_TYPE_WEEKLY] = {}
}
var_0_0.taskfinised = {
	[TASK_TYPE_NORMAL] = {},
	[TASK_TYPE_DAILY] = {},
	[TASK_TYPE_ACHIEVE] = {},
	[TASK_TYPE_CAREER] = {},
	[TASK_TYPE_BATTLEPASS] = {},
	[TASK_TYPE_FAMILY_DAILY] = {},
	[TASK_TYPE_WEEKLY] = {}
}

function var_0_0.get_player_tasks(arg_1_0, arg_1_1)
	arg_1_0.taskinfo = {}

	network:rpc("get_player_task", {}, function(arg_2_0)
		arg_1_0.taskinfo[TASK_TYPE_NORMAL] = arg_2_0.normal
		arg_1_0.taskinfo[TASK_TYPE_DAILY] = arg_2_0.daily
		arg_1_0.taskinfo[TASK_TYPE_ACHIEVE] = arg_2_0.achieve
		arg_1_0.taskinfo[TASK_TYPE_CAREER] = arg_2_0.career
		arg_1_0.taskinfo[TASK_TYPE_BATTLEPASS] = arg_2_0.battlepass
		arg_1_0.taskinfo[TASK_TYPE_FAMILY_DAILY] = arg_2_0.family_daily
		arg_1_0.taskinfo[TASK_TYPE_WEEKLY] = arg_2_0.weekly

		if arg_1_1 then
			arg_1_1()
		end
	end)
end

function var_0_0:get_player_tasks_by_type(arg_3_1, arg_3_2)
	self.taskinfo = self.taskinfo or {}

	local var_3_0 = {
		[TASK_TYPE_NORMAL] = "normal",
		[TASK_TYPE_DAILY] = "daily",
		[TASK_TYPE_ACHIEVE] = "achieve",
		[TASK_TYPE_CAREER] = "career",
		[TASK_TYPE_BATTLEPASS] = "battlepass",
		[TASK_TYPE_FAMILY_DAILY] = "family_daily",
		[TASK_TYPE_WEEKLY] = "weekly"
	}

	network:rpc("get_player_task", {
		task_type = arg_3_1
	}, function(arg_4_0)
		self.taskinfo[arg_3_1] = arg_4_0[var_3_0[arg_3_1]]

		if arg_3_2 then
			arg_3_2()
		end
	end)
end

function var_0_0.reset(arg_5_0)
	arg_5_0.taskinfo = {}
	arg_5_0.tasks = {
		[TASK_TYPE_NORMAL] = {},
		[TASK_TYPE_DAILY] = {},
		[TASK_TYPE_ACHIEVE] = {},
		[TASK_TYPE_CAREER] = {},
		[TASK_TYPE_BATTLEPASS] = {},
		[TASK_TYPE_FAMILY_DAILY] = {},
		[TASK_TYPE_WEEKLY] = {}
	}
	arg_5_0.taskfinised = {
		[TASK_TYPE_NORMAL] = {},
		[TASK_TYPE_DAILY] = {},
		[TASK_TYPE_ACHIEVE] = {},
		[TASK_TYPE_CAREER] = {},
		[TASK_TYPE_BATTLEPASS] = {},
		[TASK_TYPE_FAMILY_DAILY] = {},
		[TASK_TYPE_WEEKLY] = {}
	}
end

function var_0_0.get_task_info(arg_6_0, arg_6_1)
	network:rpc("get_task_info", nil, function(arg_7_0)
		arg_6_0:generate_task_params(arg_7_0.taskinfo)
		arg_6_0:generate_task_info()
		require("controller.achieve_manager"):generate_task_info()

		if arg_6_1 then
			arg_6_1()
		end
	end)
end

function var_0_0:generate_task_info()
	self.tasks = {
		[TASK_TYPE_NORMAL] = {},
		[TASK_TYPE_DAILY] = {},
		[TASK_TYPE_ACHIEVE] = {},
		[TASK_TYPE_CAREER] = {},
		[TASK_TYPE_BATTLEPASS] = {},
		[TASK_TYPE_FAMILY_DAILY] = {},
		[TASK_TYPE_WEEKLY] = {}
	}
	self.taskfinised = {
		[TASK_TYPE_NORMAL] = {},
		[TASK_TYPE_DAILY] = {},
		[TASK_TYPE_ACHIEVE] = {},
		[TASK_TYPE_CAREER] = {},
		[TASK_TYPE_BATTLEPASS] = {},
		[TASK_TYPE_FAMILY_DAILY] = {},
		[TASK_TYPE_WEEKLY] = {}
	}
	self.task_type_len = {
		[TASK_TYPE_NORMAL] = 0,
		[TASK_TYPE_DAILY] = 0,
		[TASK_TYPE_ACHIEVE] = 0,
		[TASK_TYPE_CAREER] = 0,
		[TASK_TYPE_BATTLEPASS] = {},
		[TASK_TYPE_FAMILY_DAILY] = {},
		[TASK_TYPE_WEEKLY] = 0
	}

	for iter_8_0, iter_8_1 in pairs(var_0_9) do
		if iter_8_0 == TASK_TYPE_BATTLEPASS then
			self:generate_battle_pass_task_info()
		else
			for iter_8_2, iter_8_3 in pairs(var_0_8[iter_8_0]) do
				if iter_8_3.valid and (iter_8_0 == TASK_TYPE_CAREER and iter_8_3.class == playermodel.class or iter_8_0 ~= TASK_TYPE_CAREER) then
					if self:is_task_finished(self.taskinfo[iter_8_0], iter_8_3.id) then
						table.insert(self.taskfinised[iter_8_0], iter_8_3.taskid)
					elseif self:can_task_triggered(iter_8_3.taskid) then
						table.insert(self.tasks[iter_8_0], self:cal_task_stat(iter_8_3.taskid))
					end

					if not task_data[iter_8_3.taskid].classtype or task_data[iter_8_3.taskid].classtype == playermodel.class then
						self.task_type_len[iter_8_0] = self.task_type_len[iter_8_0] + 1
					end
				end
			end

			table.sort(self.tasks[iter_8_0], function(arg_9_0, arg_9_1)
				if arg_9_0.percent >= 100 and arg_9_1.percent >= 100 or arg_9_0.percent < 100 and arg_9_1.percent < 100 then
					return arg_9_0.order < arg_9_1.order
				else
					return arg_9_0.percent >= 100 and arg_9_1.percent < 100
				end
			end)
		end
	end
end

function var_0_0:generate_battle_pass_task_info()
	self.taskfinised[TASK_TYPE_BATTLEPASS] = {}
	self.tasks[TASK_TYPE_BATTLEPASS] = {}

	for iter_10_0, iter_10_1 in pairs(var_0_8[TASK_TYPE_BATTLEPASS]) do
		if iter_10_1.valid then
			iter_10_1.display_type = task_data[iter_10_1.taskid].display_type

			if self:is_task_finished(self.taskinfo[TASK_TYPE_BATTLEPASS], iter_10_1.id) then
				self.taskfinised[TASK_TYPE_BATTLEPASS][iter_10_1.display_type] = self.taskfinised[TASK_TYPE_BATTLEPASS][iter_10_1.display_type] or {}

				table.insert(self.taskfinised[TASK_TYPE_BATTLEPASS][iter_10_1.display_type], iter_10_1.taskid)
			elseif self:can_task_triggered(iter_10_1.taskid) then
				self.tasks[TASK_TYPE_BATTLEPASS][iter_10_1.display_type] = self.tasks[TASK_TYPE_BATTLEPASS][iter_10_1.display_type] or {}

				table.insert(self.tasks[TASK_TYPE_BATTLEPASS][iter_10_1.display_type], self:cal_task_stat(iter_10_1.taskid))
			end

			if not task_data[iter_10_1.taskid].classtype or task_data[iter_10_1.taskid].classtype == playermodel.class then
				self.task_type_len[TASK_TYPE_BATTLEPASS][iter_10_1.display_type] = self.task_type_len[TASK_TYPE_BATTLEPASS][iter_10_1.display_type] or 0
				self.task_type_len[TASK_TYPE_BATTLEPASS][iter_10_1.display_type] = self.task_type_len[TASK_TYPE_BATTLEPASS][iter_10_1.display_type] + 1
			end
		end
	end

	for iter_10_2, iter_10_3 in pairs(self.tasks[TASK_TYPE_BATTLEPASS]) do
		if iter_10_3 and next(iter_10_3) then
			table.sort(iter_10_3, function(arg_11_0, arg_11_1)
				if arg_11_0.percent == arg_11_1.percent then
					return arg_11_0.order < arg_11_1.order
				else
					return arg_11_0.percent > arg_11_1.percent
				end
			end)
		end
	end
end

function var_0_0.reset_on_daily_update(arg_12_0, arg_12_1)
	network:rpc("reset_daily_task", nil, function(arg_13_0)
		arg_12_0.taskinfo[TASK_TYPE_DAILY] = arg_13_0.tasks

		arg_12_0:update_task_params(arg_13_0.taskinfo)

		arg_12_0.tasks[TASK_TYPE_DAILY] = {}
		arg_12_0.taskfinised[TASK_TYPE_DAILY] = {}
		arg_12_0.task_type_len = arg_12_0.task_type_len or {
			[TASK_TYPE_NORMAL] = 0,
			[TASK_TYPE_DAILY] = 0,
			[TASK_TYPE_ACHIEVE] = 0,
			[TASK_TYPE_CAREER] = 0,
			[TASK_TYPE_BATTLEPASS] = 0,
			[TASK_TYPE_FAMILY_DAILY] = 0
		}
		arg_12_0.task_type_len[TASK_TYPE_DAILY] = 0

		for iter_13_0, iter_13_1 in pairs(var_0_8[TASK_TYPE_DAILY]) do
			if iter_13_1.valid then
				if arg_12_0:is_task_finished(arg_12_0.taskinfo[TASK_TYPE_DAILY], iter_13_1.id) then
					table.insert(arg_12_0.taskfinised[TASK_TYPE_DAILY], iter_13_1.taskid)
				elseif arg_12_0:can_task_triggered(iter_13_1.taskid) then
					table.insert(arg_12_0.tasks[TASK_TYPE_DAILY], arg_12_0:cal_task_stat(iter_13_1.taskid))
				end

				if not task_data[iter_13_1.taskid].classtype or task_data[iter_13_1.taskid].classtype == playermodel.class then
					arg_12_0.task_type_len[TASK_TYPE_DAILY] = arg_12_0.task_type_len[TASK_TYPE_DAILY] + 1
				end
			end
		end

		table.sort(arg_12_0.tasks[TASK_TYPE_DAILY], function(arg_14_0, arg_14_1)
			if arg_14_0.percent == arg_14_1.percent then
				return arg_14_0.order < arg_14_1.order
			else
				return arg_14_0.percent > arg_14_1.percent
			end
		end)

		if arg_12_1 then
			arg_12_1()
		end
	end)
end

function var_0_0.reset_on_weekly_update(arg_15_0, arg_15_1)
	network:rpc("reset_weekly_task", nil, function(arg_16_0)
		arg_15_0.taskinfo[TASK_TYPE_WEEKLY] = arg_16_0.tasks

		arg_15_0:update_task_params(arg_16_0.taskinfo)

		arg_15_0.tasks[TASK_TYPE_WEEKLY] = {}
		arg_15_0.taskfinised[TASK_TYPE_WEEKLY] = {}
		arg_15_0.task_type_len = arg_15_0.task_type_len or {
			[TASK_TYPE_NORMAL] = 0,
			[TASK_TYPE_WEEKLY] = 0,
			[TASK_TYPE_ACHIEVE] = 0,
			[TASK_TYPE_CAREER] = 0,
			[TASK_TYPE_BATTLEPASS] = 0,
			[TASK_TYPE_FAMILY_DAILY] = 0
		}
		arg_15_0.task_type_len[TASK_TYPE_WEEKLY] = 0

		for iter_16_0, iter_16_1 in pairs(var_0_8[TASK_TYPE_WEEKLY]) do
			if iter_16_1.valid then
				if arg_15_0:is_task_finished(arg_15_0.taskinfo[TASK_TYPE_WEEKLY], iter_16_1.id) then
					table.insert(arg_15_0.taskfinised[TASK_TYPE_WEEKLY], iter_16_1.taskid)
				elseif arg_15_0:can_task_triggered(iter_16_1.taskid) then
					table.insert(arg_15_0.tasks[TASK_TYPE_WEEKLY], arg_15_0:cal_task_stat(iter_16_1.taskid))
				end

				if not task_data[iter_16_1.taskid].classtype or task_data[iter_16_1.taskid].classtype == playermodel.class then
					arg_15_0.task_type_len[TASK_TYPE_WEEKLY] = arg_15_0.task_type_len[TASK_TYPE_WEEKLY] + 1
				end
			end
		end

		table.sort(arg_15_0.tasks[TASK_TYPE_WEEKLY], function(arg_17_0, arg_17_1)
			if arg_17_0.percent == arg_17_1.percent then
				return arg_17_0.order < arg_17_1.order
			else
				return arg_17_0.percent > arg_17_1.percent
			end
		end)

		if arg_15_1 then
			arg_15_1()
		end
	end)
end

function var_0_0:updateOnFinishTask(arg_18_1)
	local var_18_0 = task_data[arg_18_1]

	for iter_18_0, iter_18_1 in ipairs(self.tasks[task_data[arg_18_1].task_type]) do
		if iter_18_1.taskid == arg_18_1 then
			table.remove(self.tasks[task_data[arg_18_1].task_type], iter_18_0)

			break
		end
	end

	table.insert(self.taskfinised[task_data[arg_18_1].task_type], arg_18_1)

	local var_18_1, var_18_2 = self:trigger_continue_task(task_data[arg_18_1].continue_task)

	for iter_18_2, iter_18_3 in pairs(self.taskfinised[task_data[arg_18_1].task_type]) do
		if var_18_2 and var_18_2[1] and iter_18_3 == var_18_2[1].taskid then
			var_18_1 = false

			break
		end
	end

	if var_18_1 then
		local function var_18_3(arg_19_0)
			local var_19_0 = self.tasks[var_18_0.task_type]
			local var_19_1 = 1
			local var_19_2 = arg_19_0.order
			local var_19_3 = arg_19_0.percent

			while var_19_1 <= #self.tasks[var_18_0.task_type] do
				local var_19_4 = math.floor(var_19_1 + (#self.tasks[var_18_0.task_type] - var_19_1) / 2)

				if var_19_0[var_19_4 - 1] then
					local var_19_5 = var_19_0[var_19_4 - 1].percent or var_19_0[1].percent

					if var_19_0[var_19_4] then
						local var_19_6 = var_19_0[var_19_4].percent or var_19_0[#var_19_0].percent

						if var_19_3 == var_19_5 and var_19_3 == var_19_6 then
							var_19_5 = var_19_0[var_19_4 - 1] and var_19_0[var_19_4 - 1].order or var_19_0[1].order
							var_19_6 = var_19_0[var_19_4] and var_19_0[var_19_4].order or var_19_0[#var_19_0].order

							local var_19_7

							if var_19_5 <= var_19_2 and var_19_2 <= var_19_6 then
								return var_19_4
							elseif var_19_2 < var_19_5 then
								var_19_7 = var_19_4 - 1
							else
								var_19_1 = var_19_4 + 1
							end
						elseif var_19_3 <= var_19_5 and var_19_6 <= var_19_3 then
							return var_19_4
						elseif var_19_5 < var_19_3 then
							var_19_7 = var_19_4 - 1
						end
					end
				end

				var_19_1 = var_19_4 + 1
			end

			if var_19_1 <= 1 then
				return 1
			end

			return #var_19_0 + 1
		end

		for iter_18_4, iter_18_5 in ipairs(var_18_2) do
			table.insert(self.tasks[task_data[arg_18_1].task_type], var_18_3(iter_18_5), iter_18_5)
		end
	end
end

function var_0_0:can_task_triggered(arg_20_1)
	local var_20_0 = task_data[arg_20_1]

	if not self:check_pre_task(task_data[arg_20_1].pre) then
		return false
	end

	if var_20_0.trigger_type == 0 then
		return true
	elseif var_20_0.trigger_type == 1 then
		if var_20_0.classtype then
			return playermodel.level > var_20_0.trigger_condition and var_20_0.classtype == playermodel.class
		else
			return playermodel.level > var_20_0.trigger_condition
		end
	elseif var_20_0.trigger_type == 7 then
		return level_manager:isPlayerPassLevel(var_20_0.trigger_condition % 100 .. "-" .. var_20_0.trigger_condition - var_20_0.trigger_condition % 100 * 100)
	end

	return false
end

function var_0_0:check_pre_task(arg_21_1)
	if not arg_21_1 then
		return true
	end

	for iter_21_0, iter_21_1 in pairs((string.split(arg_21_1, ","))) do
		local var_21_0 = task_data[tonumber(iter_21_1)]

		if not self:is_task_finished(self.taskinfo[var_21_0.task_type], var_21_0.index) then
			return false
		end
	end

	return true
end

function var_0_0:trigger_continue_task(arg_22_1)
	local var_22_0

	if not arg_22_1 then
		do return false end

		var_22_0 = {}
	end

	for iter_22_0, iter_22_1 in pairs((string.split(arg_22_1, ","))) do
		local var_22_1 = tonumber(iter_22_1)

		if self:can_task_triggered(var_22_1) then
			table.insert(var_22_0, self:cal_task_stat(var_22_1))
		end
	end

	return #var_22_0 > 0, var_22_0
end

function var_0_0:cal_task_stat(arg_23_1)
	local var_23_1, var_23_2, var_23_3 = self:check_condition(task_data[arg_23_1].needs_type, task_data[arg_23_1].needs_target or task_data[arg_23_1].need_target_string, task_data[arg_23_1].needs_num)

	return {
		taskid = arg_23_1,
		percent = var_23_1,
		finished = var_23_3,
		need = var_23_2,
		order = task_data[arg_23_1].order
	}
end

local var_0_10 = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384,
	32768,
	65536,
	131072,
	262144,
	524288,
	1048576,
	2097152,
	4194304,
	8388608,
	16777216,
	33554432,
	67108864,
	134217728,
	268435456,
	536870912,
	1073741824,
	2147483648
}

function var_0_0.is_task_finished(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_1 then
		return false
	end

	local var_24_0 = math.ceil(arg_24_2 / 16)
	local var_24_1

	if not arg_24_1[var_24_0] then
		do return false end

		var_24_1 = arg_24_1[var_24_0]
	end

	return bit.band(var_24_1, var_0_10[((arg_24_2 - 1) % 16 + 1) * 2]) ~= 0
end

function var_0_0:switch_to_finished(arg_25_1)
	if not task_data[arg_25_1] then
		return
	end

	local var_25_0 = task_data[arg_25_1].task_type
	local var_25_1 = math.ceil(task_data[arg_25_1].index / 16)

	if not self.taskinfo[task_data[arg_25_1].task_type][var_25_1] then
		self.taskinfo[var_25_0][var_25_1] = 0
	end

	self.taskinfo[var_25_0][var_25_1] = bit.bor(self.taskinfo[var_25_0][var_25_1], var_0_10[((task_data[arg_25_1].index - 1) % 16 + 1) * 2 - 1])
	self.taskinfo[var_25_0][var_25_1] = bit.bor(self.taskinfo[var_25_0][var_25_1], var_0_10[((task_data[arg_25_1].index - 1) % 16 + 1) * 2])
end

function var_0_0.getTaskReward(arg_26_0, arg_26_1, arg_26_2)
	network:rpc("get_task_reward", {
		taskid = arg_26_1
	}, function(arg_27_0)
		if arg_27_0.result == 1 then
			arg_26_0:switch_to_finished(arg_26_1)
			arg_26_0:updateOnFinishTask(arg_26_1)
			AnalyticManager.taskSuccess(arg_27_0.gold, arg_27_0.diamond)

			if task_data[arg_26_1].task_type == 2 then
				AnalyticManager.gain_daily_task_reward({
					taskid = arg_26_1,
					class = playermodel.class,
					level = playermodel.grade,
					role_num = playermodel:getHavedServantNum()
				})
			end

			AnalyticManager.completeTask({
				tasktype = task_data[arg_26_1].task_type,
				taskid = arg_26_1
			})

			if arg_26_2 then
				arg_26_2(1, arg_27_0)
			end
		elseif arg_26_2 then
			arg_26_2(0)
		end
	end)
end

function var_0_0.getDailyTaskActiveNum(arg_28_0, arg_28_1, arg_28_2)
	network:rpc("get_daily_task_active_num", {
		taskid = arg_28_1
	}, function(arg_29_0)
		if arg_29_0.result == 1 then
			for iter_29_0, iter_29_1 in ipairs(arg_29_0.finishIds) do
				arg_28_0:switch_to_finished(iter_29_1)
				arg_28_0:updateOnFinishTask(iter_29_1)
				AnalyticManager.taskSuccess(arg_29_0.gold, arg_29_0.diamond)

				if task_data[iter_29_1].task_type == 2 then
					AnalyticManager.gain_daily_task_reward({
						taskid = iter_29_1,
						class = playermodel.class,
						level = playermodel.grade,
						role_num = playermodel:getHavedServantNum()
					})
				end

				AnalyticManager.completeTask({
					tasktype = task_data[iter_29_1].task_type,
					taskid = iter_29_1
				})
			end

			if arg_28_2 then
				arg_28_2(1, arg_29_0)
			end
		elseif arg_28_2 then
			arg_28_2(0)
		end
	end)
end

function var_0_0.getTaskRewardOneKey(arg_30_0, arg_30_1, arg_30_2)
	network:rpc("get_task_reward_onekey", {
		tasktype = arg_30_1
	}, function(arg_31_0)
		if arg_31_0.result == 1 then
			for iter_31_0, iter_31_1 in pairs(arg_31_0.finish_ids) do
				arg_30_0:switch_to_finished(iter_31_1)
				arg_30_0:updateOnFinishTask(iter_31_1)
				AnalyticManager.taskSuccess(arg_31_0.gold, arg_31_0.diamond)

				if task_data[iter_31_1].task_type == 2 then
					AnalyticManager.gain_daily_task_reward({
						taskid = iter_31_1,
						class = playermodel.class,
						level = playermodel.grade,
						role_num = playermodel:getHavedServantNum()
					})
				end

				AnalyticManager.completeTask({
					tasktype = task_data[iter_31_1].task_type,
					taskid = iter_31_1
				})
			end

			if arg_30_2 then
				arg_30_2(1, arg_31_0)
			end
		elseif arg_31_0.result == 1 then
			global_ShowBlockWords(TASK_REWARD_ONEKEY_WARN)

			if arg_30_2 then
				arg_30_2(2)
			end
		elseif arg_30_2 then
			arg_30_2(0)
		end
	end)
end

function var_0_0:getTaskListLen(arg_32_1)
	local var_32_0 = #self.tasks[arg_32_1]

	if arg_32_1 == TASK_TYPE_ACHIEVE or arg_32_1 == TASK_TYPE_CAREER or arg_32_1 == TASK_TYPE_DAILY then
		var_32_0 = var_32_0 + #self.taskfinised[arg_32_1]
	end

	return var_32_0
end

function var_0_0:getBattlePassListLen(arg_33_1)
	self.tasks[TASK_TYPE_BATTLEPASS] = self.tasks[TASK_TYPE_BATTLEPASS] or {}
	self.tasks[TASK_TYPE_BATTLEPASS][arg_33_1] = self.tasks[TASK_TYPE_BATTLEPASS][arg_33_1] or {}
	self.taskfinised[TASK_TYPE_BATTLEPASS] = self.taskfinised[TASK_TYPE_BATTLEPASS] or {}
	self.taskfinised[TASK_TYPE_BATTLEPASS][arg_33_1] = self.taskfinised[TASK_TYPE_BATTLEPASS][arg_33_1] or {}

	return #self.tasks[TASK_TYPE_BATTLEPASS][arg_33_1] + #self.taskfinised[TASK_TYPE_BATTLEPASS][arg_33_1]
end

function var_0_0:getTaskListMaxLen(arg_34_1)
	return self.task_type_len[arg_34_1]
end

function var_0_0:getBattlePassTaskListMaxLen(arg_35_1)
	return self.task_type_len[TASK_TYPE_BATTLEPASS][arg_35_1]
end

function var_0_0:getTaskFinishLen(arg_36_1)
	return #self.taskfinised[arg_36_1]
end

function var_0_0:getbattlePassFinishLen(arg_37_1)
	self.taskfinised[TASK_TYPE_BATTLEPASS] = self.taskfinised[TASK_TYPE_BATTLEPASS] or {}
	self.taskfinised[TASK_TYPE_BATTLEPASS][arg_37_1] = self.taskfinised[TASK_TYPE_BATTLEPASS][arg_37_1] or {}

	return #self.taskfinised[TASK_TYPE_BATTLEPASS][arg_37_1]
end

function var_0_0:dequeueTaskInfo(arg_38_1, arg_38_2)
	if arg_38_2 <= #self.tasks[arg_38_1] then
		return self.tasks[arg_38_1][arg_38_2]
	else
		return self.taskfinised[arg_38_1][arg_38_2 - #self.tasks[arg_38_1]]
	end
end

function var_0_0:dequeueBattlePassTaskInfo(arg_39_1, arg_39_2)
	self.taskfinised[TASK_TYPE_BATTLEPASS] = self.taskfinised[TASK_TYPE_BATTLEPASS] or {}
	self.taskfinised[TASK_TYPE_BATTLEPASS][arg_39_1] = self.taskfinised[TASK_TYPE_BATTLEPASS][arg_39_1] or {}
	self.tasks[TASK_TYPE_BATTLEPASS] = self.tasks[TASK_TYPE_BATTLEPASS] or {}
	self.tasks[TASK_TYPE_BATTLEPASS][arg_39_1] = self.tasks[TASK_TYPE_BATTLEPASS][arg_39_1] or {}

	if arg_39_2 <= #self.tasks[TASK_TYPE_BATTLEPASS][arg_39_1] then
		return self.tasks[TASK_TYPE_BATTLEPASS][arg_39_1][arg_39_2]
	else
		return self.taskfinised[TASK_TYPE_BATTLEPASS][arg_39_1][arg_39_2 - #self.tasks[TASK_TYPE_BATTLEPASS][arg_39_1]]
	end
end

function var_0_0.queryTaskData(arg_40_0, arg_40_1)
	return task_data[taskId]
end

function var_0_0:isHaveReward(arg_41_1)
	if not self.tasks then
		return false
	end

	if next(self.tasks) == nil or self.tasks[arg_41_1] == nil then
		return false
	end

	for iter_41_0, iter_41_1 in pairs(self.tasks[arg_41_1]) do
		if iter_41_1.percent >= 100 then
			return true
		end
	end

	return false
end

function var_0_0.getBattlePassRewardOneKey(arg_42_0, arg_42_1, arg_42_2)
	network:rpc("get_battlepass_task_reward_onekey", {
		tasktype = TASK_TYPE_BATTLEPASS,
		showtype = arg_42_1
	}, function(arg_43_0)
		if arg_43_0.result == 1 then
			for iter_43_0, iter_43_1 in pairs(arg_43_0.finish_ids) do
				arg_42_0:switch_to_finished(iter_43_1)
				arg_42_0:updateOnBattlePassFinishTask(iter_43_1, arg_42_1)
			end
		end

		if arg_42_2 then
			arg_42_2(arg_43_0.result, arg_43_0)
		end
	end)
end

function var_0_0:updateOnBattlePassFinishTask(arg_44_1, arg_44_2)
	for iter_44_0, iter_44_1 in ipairs(self.tasks[TASK_TYPE_BATTLEPASS][arg_44_2]) do
		if iter_44_1.taskid == arg_44_1 then
			table.remove(self.tasks[TASK_TYPE_BATTLEPASS][arg_44_2], iter_44_0)

			break
		end
	end

	table.insert(self.taskfinised[TASK_TYPE_BATTLEPASS][arg_44_2], arg_44_1)
end

function var_0_0.check_task_time(arg_45_0, arg_45_1)
	if not arg_45_1 then
		return
	end

	local var_45_0 = time_check_manager:getCurTime()

	if arg_45_1.starttime and var_45_0 < os.time(parse_time(arg_45_1.starttime)) then
		return false
	end

	if arg_45_1.finishtime and var_45_0 > os.time(parse_time(arg_45_1.finishtime)) then
		return false
	end

	return true
end

function var_0_0:generate_commity_task_info()
	self.taskfinised[TASK_TYPE_FAMILY_DAILY] = {}
	self.tasks[TASK_TYPE_FAMILY_DAILY] = {}

	for iter_46_0, iter_46_1 in pairs(var_0_8[TASK_TYPE_FAMILY_DAILY]) do
		if iter_46_1.valid then
			iter_46_1.display_type = task_data[iter_46_1.taskid].display_type

			if self:is_task_finished(self.taskinfo[TASK_TYPE_FAMILY_DAILY], iter_46_1.id) then
				self.taskfinised[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type] = self.taskfinised[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type] or {}

				table.insert(self.taskfinised[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type], iter_46_1.taskid)
			elseif self:can_task_triggered(iter_46_1.taskid) then
				self.tasks[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type] = self.tasks[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type] or {}

				table.insert(self.tasks[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type], self:cal_task_stat(iter_46_1.taskid))
			end

			if not task_data[iter_46_1.taskid].classtype or task_data[iter_46_1.taskid].classtype == playermodel.class then
				self.task_type_len[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type] = self.task_type_len[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type] or 0
				self.task_type_len[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type] = self.task_type_len[TASK_TYPE_FAMILY_DAILY][iter_46_1.display_type] + 1
			end
		end
	end

	for iter_46_2, iter_46_3 in pairs(self.tasks[TASK_TYPE_FAMILY_DAILY]) do
		if iter_46_3 and next(iter_46_3) then
			table.sort(iter_46_3, function(arg_47_0, arg_47_1)
				if arg_47_0.percent == arg_47_1.percent then
					return arg_47_0.order < arg_47_1.order
				else
					return arg_47_0.percent > arg_47_1.percent
				end
			end)
		end
	end
end

function var_0_0:dequeueCommityTaskInfo(arg_48_1, arg_48_2)
	self.taskfinised[TASK_TYPE_FAMILY_DAILY] = self.taskfinised[TASK_TYPE_FAMILY_DAILY] or {}
	self.taskfinised[TASK_TYPE_FAMILY_DAILY][arg_48_1] = self.taskfinised[TASK_TYPE_FAMILY_DAILY][arg_48_1] or {}
	self.tasks[TASK_TYPE_FAMILY_DAILY] = self.tasks[TASK_TYPE_FAMILY_DAILY] or {}
	self.tasks[TASK_TYPE_FAMILY_DAILY][arg_48_1] = self.tasks[TASK_TYPE_FAMILY_DAILY][arg_48_1] or {}

	local var_48_0
	local var_48_1

	for iter_48_0, iter_48_1 in pairs(self.tasks[TASK_TYPE_FAMILY_DAILY][arg_48_1]) do
		if iter_48_1.taskid == arg_48_2 then
			var_48_1 = iter_48_0
			var_48_0 = true

			break
		end
	end

	if var_48_0 then
		return self.tasks[TASK_TYPE_FAMILY_DAILY][arg_48_1][var_48_1]
	else
		return arg_48_2
	end
end

function var_0_0:getCommityTaskFishedInfo(arg_49_1)
	if not arg_49_1 then
		return
	end

	return self.taskfinised[TASK_TYPE_FAMILY_DAILY][arg_49_1]
end

function var_0_0:getCommityTaskInfo(arg_50_1)
	if not arg_50_1 then
		return
	end

	return self.tasks[TASK_TYPE_FAMILY_DAILY][arg_50_1]
end

return var_0_0
