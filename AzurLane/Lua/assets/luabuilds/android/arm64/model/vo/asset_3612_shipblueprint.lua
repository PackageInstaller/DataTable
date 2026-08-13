class = var_0_10000

local var_0_0 = "ShipBluePrint"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.STATE_LOCK = 1
var_0_1.STATE_DEV = 2
var_0_1.STATE_DEV_FINISHED = 3
var_0_1.STATE_UNLOCK = 4
var_0_1.TASK_STATE_LOCK = 1
var_0_1.TASK_STATE_OPENING = 2
var_0_1.TASK_STATE_WAIT = 3
var_0_1.TASK_STATE_START = 4
var_0_1.TASK_STATE_ACHIEVED = 5
var_0_1.TASK_STATE_FINISHED = 6
var_0_1.TASK_STATE_PAUSE = 7
var_0_1.STRENGTHEN_TYPE_ATTR = "attr"
var_0_1.STRENGTHEN_TYPE_DIALOGUE = "dialog"
var_0_1.STRENGTHEN_TYPE_SKILL = "skill"
var_0_1.STRENGTHEN_TYPE_CHANGE_SKILL = "change_skill"
var_0_1.STRENGTHEN_TYPE_BASE_LIST = "base"
var_0_1.STRENGTHEN_TYPE_SKIN = "skin"
var_0_1.STRENGTHEN_TYPE_BREAKOUT = "breakout"
var_0_1.STRENGTHEN_TYPE_PRLOAD_COUNT = "preload"
var_0_1.STRENGTHEN_TYPE_EQUIPMENTPROFICIENCY = "equipmentproficiency"
pg = var_1

local var_0_2 = var_1.ship_data_blueprint

pg = var_0_0

local var_0_3 = var_0_0.ship_strengthen_blueprint
local var_0_4 = false

function var_0_1.print(...)
	if var_0_4 then
		print = var_0

		var_0(...)
	end

	return
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.configId = arg_2_1.id
	arg_2_0.id = arg_2_0.configId
	arg_2_0.state = var_0_1.STATE_LOCK
	arg_2_0.startTime = 0
	arg_2_0.shipId = 0
	arg_2_0.duration = 0
	arg_2_0.level = 0
	arg_2_0.fateLevel = -1
	arg_2_0.exp = 0
	arg_2_0.strengthenConfig = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0:getConfig("strengthen_effect")) do
		Clone = var_7

		if var_7(var_0_3[iter_2_1]).special == 1 then
			arg_2_0:warpspecialEffect(var_7)
		end

		arg_2_0.strengthenConfig[iter_2_0] = var_7
	end

	arg_2_0.fateStrengthenConfig = {}
	ipairs = var_2

	for iter_2_2, iter_2_3 in var_2(arg_2_0:getConfig("fate_strengthen")) do
		Clone = var_7

		if var_7(var_0_3[iter_2_3]).special == 1 then
			arg_2_0:warpspecialEffect(var_7)
		end

		arg_2_0.fateStrengthenConfig[iter_2_2] = var_7
	end

	return
end

function var_0_1.warpspecialEffect(arg_3_0, arg_3_1)
	local var_3_0 = {}

	string = var_1_10003

	local var_3_1 = var_1_10003.split(arg_3_1.effect_desc, "|")
	local var_3_2 = 0

	type = var_5

	if var_5(arg_3_1.effect_attr) == "table" then
		ipairs = var_5

		for iter_3_0, iter_3_1 in var_5(arg_3_1.effect_attr) do
			var_3_2 = var_3_2 + 1
			table = var_1_10010
			var_1_10010 = var_1_10010.insert

			local var_3_3 = var_3_0
			local var_3_4 = {
				var_0_1.STRENGTHEN_TYPE_ATTR,
				iter_3_1
			}
			local var_3_5

			if not var_3_1[var_3_2] then
				var_3_5 = ""
			end

			var_3_4[3] = var_3_5

			var_1_10010(var_3_3, var_3_4)
		end

		arg_3_1.effect_attr = nil
	end

	local var_3_6

	if arg_3_1.effect_breakout ~= 0 then
		var_3_2 = var_3_2 + 1
		table = var_3_6
		var_3_6 = var_3_6.insert

		local var_3_7 = var_3_0
		local var_3_8 = {
			var_0_1.STRENGTHEN_TYPE_BREAKOUT,
			arg_3_1.effect_breakout
		}
		local var_3_9

		if not var_3_1[var_3_2] then
			var_3_9 = ""
		end

		var_3_8[3] = var_3_9

		var_3_6(var_3_7, var_3_8)

		arg_3_1.effect_breakout = nil
	end

	type = var_3_6

	local var_3_10

	if var_3_6(arg_3_1.effect_skill) == "table" then
		var_3_2 = var_3_2 + 1
		table = var_3_10
		var_3_10 = var_3_10.insert

		local var_3_11 = var_3_0
		local var_3_12 = {
			var_0_1.STRENGTHEN_TYPE_SKILL,
			arg_3_1.effect_skill
		}
		local var_3_13

		if not var_3_1[var_3_2] then
			var_3_13 = ""
		end

		var_3_12[3] = var_3_13

		var_3_10(var_3_11, var_3_12)

		arg_3_1.effect_skill = nil
	end

	type = var_3_10

	local var_3_14

	if var_3_10(arg_3_1.change_skill) == "table" then
		var_3_2 = var_3_2 + 1
		table = var_3_14
		var_3_14 = var_3_14.insert

		local var_3_15 = var_3_0
		local var_3_16 = {
			var_0_1.STRENGTHEN_TYPE_CHANGE_SKILL,
			arg_3_1.change_skill
		}
		local var_3_17

		if not var_3_1[var_3_2] then
			var_3_17 = ""
		end

		var_3_16[3] = var_3_17

		var_3_14(var_3_15, var_3_16)

		arg_3_1.change_skill = nil
	end

	type = var_3_14

	local var_3_18

	if var_3_14(arg_3_1.effect_base) == "table" then
		var_3_2 = var_3_2 + 1
		table = var_3_18
		var_3_18 = var_3_18.insert

		local var_3_19 = var_3_0
		local var_3_20 = {
			var_0_1.STRENGTHEN_TYPE_BASE_LIST,
			arg_3_1.effect_base
		}
		local var_3_21

		if not var_3_1[var_3_2] then
			var_3_21 = ""
		end

		var_3_20[3] = var_3_21

		var_3_18(var_3_19, var_3_20)

		arg_3_1.effect_base = nil
	end

	type = var_3_18

	local var_3_22

	if var_3_18(arg_3_1.effect_preload) == "table" then
		var_3_2 = var_3_2 + 1
		table = var_3_22
		var_3_22 = var_3_22.insert

		local var_3_23 = var_3_0
		local var_3_24 = {
			var_0_1.STRENGTHEN_TYPE_PRLOAD_COUNT,
			arg_3_1.effect_preload
		}
		local var_3_25

		if not var_3_1[var_3_2] then
			var_3_25 = ""
		end

		var_3_24[3] = var_3_25

		var_3_22(var_3_23, var_3_24)

		arg_3_1.effect_preload = nil
	end

	type = var_3_22

	if var_3_22(arg_3_1.effect_dialog) == "table" then
		var_3_2 = var_3_2 + 1
		table = var_5

		local var_3_26 = var_5.insert
		local var_3_27 = var_3_0
		local var_3_28 = {
			var_0_1.STRENGTHEN_TYPE_DIALOGUE,
			arg_3_1.effect_dialog
		}
		local var_3_29

		if not var_3_1[var_3_2] then
			var_3_29 = ""
		end

		var_3_28[3] = var_3_29

		var_3_26(var_3_27, var_3_28)

		arg_3_1.effect_dialog = nil
	end

	local var_3_30

	if arg_3_1.effect_skin ~= 0 then
		var_3_2 = var_3_2 + 1
		table = var_3_30
		var_3_30 = var_3_30.insert

		local var_3_31 = var_3_0
		local var_3_32 = {
			var_0_1.STRENGTHEN_TYPE_SKIN,
			arg_3_1.effect_skin
		}
		local var_3_33

		if not var_3_1[var_3_2] then
			var_3_33 = ""
		end

		var_3_32[3] = var_3_33

		var_3_30(var_3_31, var_3_32)

		arg_3_1.effect_skin = nil
	end

	type = var_3_30

	if var_3_30(arg_3_1.effect_equipment_proficiency) == "table" then
		local var_3_34 = var_3_2 + 1

		table = var_5

		local var_3_35 = var_5.insert
		local var_3_36 = var_3_0
		local var_3_37 = {
			var_0_1.STRENGTHEN_TYPE_EQUIPMENTPROFICIENCY,
			arg_3_1.effect_equipment_proficiency
		}
		local var_3_38

		if not var_3_1[var_3_34] then
			var_3_38 = ""
		end

		var_3_37[3] = var_3_38

		var_3_35(var_3_36, var_3_37)
	end

	arg_3_1.special_effect = var_3_0

	return
end

function var_0_1.updateInfo(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_1.start_time then
		var_4_0 = 0
	end

	arg_4_0.startTime = var_4_0

	local var_4_1

	if not arg_4_1.ship_id then
		var_4_1 = 0
	end

	arg_4_0.shipId = var_4_1

	if arg_4_1.blue_print_level then
		math = var_2

		local var_4_2

		if not var_2.min(arg_4_1.blue_print_level, arg_4_0:getMaxLevel()) then
			var_4_2 = 0
		end

		arg_4_0.level = var_4_2

		local var_4_3

		if arg_4_0.level ~= arg_4_0:getMaxLevel() or not (arg_4_1.blue_print_level - arg_4_0:getMaxLevel()) then
			var_4_3 = -1
		end

		arg_4_0.fateLevel = var_4_3

		local var_4_4

		if not arg_4_1.exp then
			var_4_4 = 0
		end

		arg_4_0.exp = var_4_4

		local var_4_5

		if not arg_4_1.start_duration then
			var_4_5 = 0
		end

		arg_4_0.duration = var_4_5

		arg_4_0:updateState()

		return
	end
end

function var_0_1.updateStartUpTime(arg_5_0, arg_5_1)
	arg_5_0.duration = arg_5_1

	return
end

function var_0_1.updateState(arg_6_0)
	if arg_6_0:isFetched() then
		arg_6_0.state = var_0_1.STATE_UNLOCK
	elseif arg_6_0.startTime == 0 then
		arg_6_0.state = var_0_1.STATE_LOCK
	elseif arg_6_0:isFinishedAllTasks() then
		arg_6_0.state = var_0_1.STATE_DEV_FINISHED
	else
		arg_6_0.state = var_0_1.STATE_DEV
	end

	return
end

function var_0_1.addExp(arg_7_0, arg_7_1)
	assert = var_1_10002

	var_1_10002(arg_7_1, "exp can not be nil")

	arg_7_0.exp = arg_7_0.exp + arg_7_1

	if arg_7_0:getMaxLevel() > arg_7_0.level then
		while arg_7_0:canLevelUp() do
			local var_7_0 = arg_7_0:getNextLevelExp()

			arg_7_0.exp = arg_7_0.exp - var_7_0
			math = var_4
			arg_7_0.level = var_4.min(arg_7_0.level + 1, var_2)
		end

		if arg_7_0.level == var_2 then
			arg_7_0.fateLevel = 0
		end
	end

	if arg_7_0:canFateSimulation() then
		local var_7_1 = arg_7_0:getMaxFateLevel()

		while arg_7_0:canFateLevelUp() do
			local var_7_2 = arg_7_0:getNextFateLevelExp()

			arg_7_0.exp = arg_7_0.exp - var_7_2
			math = var_4
			arg_7_0.fateLevel = var_4.min(arg_7_0.fateLevel + 1, var_7_1)
		end
	end

	return
end

function var_0_1.getNextLevelExp(arg_8_0)
	if arg_8_0.level == arg_8_0:getMaxLevel() then
		return -1
	else
		local var_8_0 = arg_8_0.level + 1

		return arg_8_0.strengthenConfig[var_8_0].need_exp
	end

	return
end

function var_0_1.getNextFateLevelExp(arg_9_0)
	if arg_9_0.fateLevel == arg_9_0:getMaxFateLevel() then
		return -1
	else
		local var_9_0 = arg_9_0.fateLevel + 1

		return arg_9_0.fateStrengthenConfig[var_9_0].need_exp
	end

	return
end

function var_0_1.canLevelUp(arg_10_0)
	if arg_10_0.level == arg_10_0:getMaxLevel() then
		return false
	end

	if arg_10_0:getNextLevelExp() <= arg_10_0.exp then
		return true
	end

	return false
end

function var_0_1.canFateSimulation(arg_11_0)
	return #arg_11_0.fateStrengthenConfig > 0 and arg_11_0.fateLevel >= 0
end

function var_0_1.canFateLevelUp(arg_12_0)
	if arg_12_0.fateLevel == arg_12_0:getMaxFateLevel() then
		return false
	end

	if arg_12_0:getNextFateLevelExp() <= arg_12_0.exp then
		return true
	end

	return false
end

function var_0_1.getMaxLevel(arg_13_0)
	return arg_13_0.strengthenConfig[#arg_13_0.strengthenConfig].lv
end

function var_0_1.getMaxFateLevel(arg_14_0)
	return arg_14_0.fateStrengthenConfig[#arg_14_0.fateStrengthenConfig].lv - 30
end

function var_0_1.isMaxLevel(arg_15_0)
	return arg_15_0.level == arg_15_0:getMaxLevel()
end

function var_0_1.isMaxFateLevel(arg_16_0)
	return arg_16_0.fateLevel == arg_16_0:getMaxFateLevel()
end

function var_0_1.isMaxIntensifyLevel(arg_17_0)
	if #arg_17_0:getConfig("fate_strengthen") > 0 then
		return arg_17_0:isMaxFateLevel()
	else
		return arg_17_0:isMaxLevel()
	end

	return
end

function var_0_1.getBluePrintAddition(arg_18_0, arg_18_1)
	table = var_1_10002

	local var_18_0 = var_1_10002.indexof

	ShipModAttr = var_1_10004

	local var_18_1 = var_18_0(var_1_10004.BLUEPRINT_ATTRS, arg_18_1)

	if arg_18_0:getConfig("attr_exp")[var_18_1] then
		local var_18_2 = 0

		for iter_18_0 = 1, arg_18_0.level do
			var_18_2 = var_18_2 + arg_18_0.strengthenConfig[iter_18_0].effect[var_18_1]
		end

		local var_18_3 = 0

		if not arg_18_0:isMaxLevel() then
			local var_18_4 = arg_18_0:getNextLevelExp()

			var_18_3 = arg_18_0.exp / var_18_4 * arg_18_0.strengthenConfig[arg_18_0.level + 1].effect[var_18_1]
		end

		local var_18_5 = (var_18_2 + var_18_3) / var_3
		local var_18_6 = (var_18_2 + var_18_3) % var_3

		return var_18_5, var_18_6
	else
		return 0, 0
	end

	return
end

function var_0_1.getShipVO(arg_19_0)
	Ship = var_1_10001

	local var_19_0 = var_1_10001.New
	local var_19_1 = {}

	tonumber = var_1_10004
	var_19_1.configId = var_1_10004(arg_19_0.id .. "1")

	return var_19_0(var_19_1)
end

function var_0_1.isFetched(arg_20_0)
	return arg_20_0.shipId ~= 0
end

function var_0_1.getState(arg_21_0)
	return arg_21_0.state
end

function var_0_1.start(arg_22_0, arg_22_1)
	arg_22_0.state = var_0_1.STATE_DEV
	arg_22_0.startTime = arg_22_1
	arg_22_0.duration = 0

	return
end

function var_0_1.reset(arg_23_0)
	arg_23_0.state = var_0_1.STATE_LOCK
	arg_23_0.startTime = 0

	return
end

function var_0_1.isLock(arg_24_0)
	return arg_24_0.state == var_0_1.STATE_LOCK
end

function var_0_1.isDeving(arg_25_0)
	return arg_25_0.state == var_0_1.STATE_DEV
end

function var_0_1.isFinished(arg_26_0)
	return arg_26_0.state == var_0_1.STATE_DEV_FINISHED
end

function var_0_1.finish(arg_27_0)
	arg_27_0.state = var_0_1.STATE_DEV_FINISHED

	return
end

function var_0_1.unlock(arg_28_0, arg_28_1)
	arg_28_0.shipId = arg_28_1
	arg_28_0.state = var_0_1.STATE_UNLOCK
	arg_28_0.duration = 0

	return
end

function var_0_1.isUnlock(arg_29_0)
	return arg_29_0.state == var_0_1.STATE_UNLOCK
end

function var_0_1.getItemId(arg_30_0)
	return arg_30_0:getConfig("strengthen_item")
end

function var_0_1.bindConfigTable(arg_31_0)
	pg = var_1_10001

	return var_1_10001.ship_data_blueprint
end

function var_0_1.getTaskIds(arg_32_0)
	_ = var_1_10001

	return var_1_10001.map(arg_32_0:getConfig("unlock_task"), function(arg_33_0)
		return arg_33_0[1]
	end)
end

function var_0_1.getTaskOpenTimeStamp(arg_34_0, arg_34_1)
	table = var_1_10002

	local var_34_0 = var_1_10002.indexof(arg_34_0:getTaskIds(), arg_34_1)

	return arg_34_0:getConfig("unlock_task")[var_34_0][2] + arg_34_0.startTime + 1
end

function var_0_1.isFinishedAllTasks(arg_35_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_35_0 = var_1_10001(var_1_10003)

	_ = var_1_10002

	return var_1_10002.all(arg_35_0:getTaskIds(), function(arg_36_0)
		local var_36_0 = arg_35_0

		return var_1.getTaskStateById(var_36_0, arg_36_0) == var_0_1.TASK_STATE_FINISHED
	end)
end

function var_0_1.getTaskStateById(arg_37_0, arg_37_1)
	if arg_37_0:isLock() then
		local var_37_0 = arg_37_0.duration

		if 0 < var_37_0 then
			return var_0_1.TASK_STATE_PAUSE
		else
			return var_0_1.TASK_STATE_LOCK
		end
	else
		local var_37_1 = arg_37_0
		local var_37_2 = arg_37_0.getTaskOpenTimeStamp(var_37_1, arg_37_1)

		pg = var_1_10003

		local var_37_3 = var_1_10003.TimeMgr.GetInstance()

		if var_37_2 > var_3.GetServerTime(var_37_3) then
			return var_0_1.TASK_STATE_WAIT
		else
			getProxy = var_37_1
			TaskProxy = var_1_10006

			local var_37_4 = var_37_1(var_1_10006)

			if var_4.getTaskVO(var_37_4, arg_37_1) and var_5:isReceive() then
				return var_0_1.TASK_STATE_FINISHED
			elseif var_5 and var_5:isFinish() then
				return var_0_1.TASK_STATE_ACHIEVED
			elseif var_5 then
				return var_0_1.TASK_STATE_START
			else
				return var_0_1.TASK_STATE_OPENING
			end
		end
	end

	return
end

function var_0_1.getExpRetio(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getConfig("attr_exp")

	assert = var_1_10003

	var_1_10003(arg_38_1 > 0 and arg_38_1 <= #var_38_0, "invalid index" .. arg_38_1)

	return var_38_0[arg_38_1]
end

function var_0_1.specialStrengthens(arg_39_0)
	local var_39_0 = {}

	noEmptyStr = var_1_10002

	if var_1_10002(arg_39_0:getConfig("normal_display")) then
		table = var_1_10003

		var_1_10003.insert(var_39_0, {
			level = 0,
			des = {},
			extraDes = var_2
		})
	end

	ipairs = var_1_10003

	for iter_39_0, iter_39_1 in var_1_10003(arg_39_0.strengthenConfig) do
		if iter_39_1.special == 1 then
			table = var_8

			var_8.insert(var_39_0, {
				des = iter_39_1.special_effect,
				extraDes = iter_39_1.extra_desc,
				level = iter_39_1.lv
			})
		end
	end

	return var_39_0
end

function var_0_1.getSpecials(arg_40_0)
	return arg_40_0.strengthenConfig[arg_40_0.level].special_effect
end

function var_0_1.getTopLimitAttrValue(arg_41_0, arg_41_1)
	if arg_41_0.level == 0 then
		return 0
	else
		local var_41_0 = arg_41_0.strengthenConfig[arg_41_0.level].effect[arg_41_1]

		assert = var_1_10004

		var_1_10004(var_2[arg_41_1], "strengthen config effect" .. arg_41_1)

		local var_41_1 = arg_41_0:getConfig("attr_exp")[arg_41_1]

		math = var_1_10005

		return var_1_10005.floor(var_41_0 / var_41_1)
	end

	return
end

function var_0_1.getItemExp(arg_42_0)
	local var_42_0 = arg_42_0:getConfig("strengthen_item")

	Item = var_1_10002

	return var_1_10002.getConfigData(var_42_0).usage_arg[1]
end

function var_0_1.getShipProperties(arg_43_0, arg_43_1, arg_43_2)
	assert = var_1_10003

	var_1_10003(arg_43_1, "shipVO can not be nil" .. arg_43_0.shipId)

	local var_43_0 = arg_43_1
	local var_43_1 = arg_43_1.getBaseProperties(var_43_0)

	defaultValue = var_1_10004
	arg_43_2 = var_1_10004(arg_43_2, true)

	local var_43_2 = arg_43_0:getTotalAdditions()

	pairs = var_43_0

	for iter_43_0, iter_43_1 in var_43_0(var_43_1) do
		local var_43_3 = var_43_1[iter_43_0]

		if not var_43_2[iter_43_0] then
			var_1_10011 = 0
		end

		var_43_1[iter_43_0] = var_43_3 + var_1_10011
	end

	if arg_43_1:getIntimacyLevel() > 0 and arg_43_2 then
		pg = var_5

		local var_43_4 = var_5.intimacy_template[arg_43_1:getIntimacyLevel()].attr_bonus * 0.0001

		pairs = var_6

		for iter_43_2, iter_43_3 in var_6(var_43_1) do
			AttributeType = var_1_10011

			if iter_43_2 ~= var_1_10011.Durability then
				AttributeType = var_1_10011

				if iter_43_2 ~= var_1_10011.Cannon then
					AttributeType = var_1_10011

					if iter_43_2 ~= var_1_10011.Torpedo then
						AttributeType = var_1_10011

						if iter_43_2 ~= var_1_10011.AntiAircraft then
							AttributeType = var_1_10011

							if iter_43_2 ~= var_1_10011.Air then
								AttributeType = var_1_10011

								if iter_43_2 ~= var_1_10011.Reload then
									AttributeType = var_1_10011

									if iter_43_2 ~= var_1_10011.Hit then
										AttributeType = var_1_10011

										if iter_43_2 ~= var_1_10011.AntiSub then
											AttributeType = var_1_10011

											if iter_43_2 == var_1_10011.Dodge then
												var_43_1[iter_43_2] = var_43_1[iter_43_2] * (var_43_4 + 1)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return var_43_1
end

function var_0_1.getTotalAdditions(arg_44_0)
	local var_44_0 = {}
	local var_44_1 = arg_44_0:attrSpecialAddition()

	ipairs = var_1_10003
	Ship = var_1_10005

	for iter_44_0, iter_44_1 in var_1_10003(var_1_10005.PROPERTIES) do
		local var_44_2, var_44_3 = arg_44_0:getBluePrintAddition(iter_44_1)
		local var_44_4

		if not var_44_1[iter_44_1] then
			var_44_4 = 0
		end

		var_44_0[iter_44_1] = var_44_2 + var_44_4
	end

	return var_44_0
end

function var_0_1.attrSpecialAddition(arg_45_0)
	local var_45_0 = {}

	for iter_45_0 = 1, arg_45_0.level do
		if arg_45_0.strengthenConfig[iter_45_0].special == 1 then
			type = var_7

			if var_7(var_6.special_effect) == "table" then
				ipairs = var_7

				for iter_45_1, iter_45_2 in var_7(var_6.special_effect) do
					if iter_45_2[1] == var_0_1.STRENGTHEN_TYPE_ATTR then
						local var_45_1 = iter_45_2[2][1]
						local var_45_2

						if not var_45_0[var_12[1]] then
							var_45_2 = 0
						end

						var_45_0[var_45_1] = var_45_2 + var_12[2]
					end
				end
			end
		end
	end

	for iter_45_3 = 1, arg_45_0.fateLevel do
		if arg_45_0.fateStrengthenConfig[iter_45_3].special == 1 then
			type = var_7

			if var_7(var_6.special_effect) == "table" then
				ipairs = var_7

				for iter_45_4, iter_45_5 in var_7(var_6.special_effect) do
					if iter_45_5[1] == var_0_1.STRENGTHEN_TYPE_ATTR then
						local var_45_3 = iter_45_5[2][1]
						local var_45_4

						if not var_45_0[var_12[1]] then
							var_45_4 = 0
						end

						var_45_0[var_45_3] = var_45_4 + var_12[2]
					end
				end
			end
		end
	end

	return var_45_0
end

function var_0_1.getUseageMaxItem(arg_46_0)
	local var_46_0 = 0

	for iter_46_0 = arg_46_0.level + 1, arg_46_0:getMaxLevel() do
		assert = var_1_10006

		var_1_10006(arg_46_0.strengthenConfig[iter_46_0], "strengthen config >> " .. iter_46_0)

		var_46_0 = var_46_0 + arg_46_0.strengthenConfig[iter_46_0].need_exp
	end

	math = var_2

	local var_46_1 = var_2.max

	math = var_4

	return var_46_1(var_4.ceil((var_46_0 - arg_46_0.exp) / arg_46_0:getItemExp()), 0)
end

function var_0_1.getFateUseageMaxItem(arg_47_0)
	local var_47_0 = 0

	for iter_47_0 = arg_47_0.fateLevel + 1, arg_47_0:getMaxFateLevel() do
		assert = var_1_10006

		var_1_10006(arg_47_0.fateStrengthenConfig[iter_47_0], "strengthen config >> " .. iter_47_0)

		var_47_0 = var_47_0 + arg_47_0.fateStrengthenConfig[iter_47_0].need_exp
	end

	math = var_2

	local var_47_1 = var_2.max

	math = var_4

	return var_47_1(var_4.ceil((var_47_0 - arg_47_0.exp) / arg_47_0:getItemExp()), 0)
end

function var_0_1.getOpenTaskList(arg_48_0)
	return arg_48_0:getConfig("unlock_task_open_condition")
end

function var_0_1.getStrengthenConfig(arg_49_0, arg_49_1)
	return arg_49_0.strengthenConfig[arg_49_1]
end

function var_0_1.getFateStrengthenConfig(arg_50_0, arg_50_1)
	return arg_50_0.fateStrengthenConfig[arg_50_1]
end

function var_0_1.getUnlockVoices(arg_51_0)
	local var_51_0 = {}

	for iter_51_0 = 1, arg_51_0.level do
		local var_51_1 = arg_51_0

		if arg_51_0.getStrengthenConfig(var_51_1, iter_51_0).special == 1 then
			local var_51_2 = var_6.special_effect

			type = var_51_1

			if var_51_1(var_51_2) == "table" then
				ipairs = var_8

				for iter_51_1, iter_51_2 in var_8(var_51_2) do
					if iter_51_2[1] == var_0_1.STRENGTHEN_TYPE_DIALOGUE then
						ipairs = var_13

						for iter_51_3, iter_51_4 in var_13(iter_51_2[2]) do
							table = var_1_10018

							var_1_10018.insert(var_51_0, iter_51_4)
						end
					end
				end
			end
		end
	end

	return var_51_0
end

function var_0_1.getUnlockLevel(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:getMaxLevel()

	for iter_52_0 = 1, var_52_0 do
		local var_52_1 = arg_52_0
		local var_52_2 = arg_52_0.getStrengthenConfig(var_52_1, iter_52_0).special_effect

		type = var_52_1

		if var_52_1(var_52_2) == "table" then
			ipairs = var_9

			for iter_52_1, iter_52_2 in var_9(var_52_2) do
				if iter_52_2[1] == var_0_1.STRENGTHEN_TYPE_DIALOGUE then
					ipairs = var_14

					for iter_52_3, iter_52_4 in var_14(iter_52_2[2]) do
						if arg_52_1 == iter_52_4 then
							return iter_52_0
						end
					end
				end
			end
		end
	end

	return 0
end

function var_0_1.getBaseList(arg_53_0, arg_53_1)
	assert = var_1_10002

	var_1_10002(arg_53_1, "shipVO can not be nil" .. arg_53_0.shipId)

	for iter_53_0 = arg_53_0.level, 1, -1 do
		local var_53_0 = arg_53_0

		if arg_53_0.getStrengthenConfig(var_53_0, iter_53_0).special == 1 then
			local var_53_1 = var_6.special_effect

			ipairs = var_53_0

			for iter_53_1, iter_53_2 in var_53_0(var_53_1) do
				if iter_53_2[1] == var_0_1.STRENGTHEN_TYPE_BASE_LIST then
					return iter_53_2[2]
				end
			end
		end
	end

	return arg_53_1:getConfig("base_list")
end

function var_0_1.getPreLoadCount(arg_54_0, arg_54_1)
	assert = var_1_10002

	var_1_10002(arg_54_1, "shipVO can not be nil" .. arg_54_0.shipId)

	for iter_54_0 = arg_54_0.level, 1, -1 do
		local var_54_0 = arg_54_0

		if arg_54_0.getStrengthenConfig(var_54_0, iter_54_0).special == 1 then
			local var_54_1 = var_6.special_effect

			ipairs = var_54_0

			for iter_54_1, iter_54_2 in var_54_0(var_54_1) do
				if iter_54_2[1] == var_0_1.STRENGTHEN_TYPE_PRLOAD_COUNT then
					return iter_54_2[2]
				end
			end
		end
	end

	return arg_54_1:getConfig("preload_count")
end

function var_0_1.getEquipProficiencyList(arg_55_0, arg_55_1)
	assert = var_1_10002

	var_1_10002(arg_55_1, "shipVO can not be nil" .. arg_55_0.shipId)

	local var_55_0 = {}

	for iter_55_0 = 1, arg_55_0.level do
		local var_55_1 = arg_55_0

		if arg_55_0.getStrengthenConfig(var_55_1, iter_55_0).special == 1 then
			local var_55_2 = var_7.special_effect

			ipairs = var_55_1

			for iter_55_1, iter_55_2 in var_55_1(var_55_2) do
				if iter_55_2[1] == var_0_1.STRENGTHEN_TYPE_EQUIPMENTPROFICIENCY then
					local var_55_3 = iter_55_2[2][1]
					local var_55_4 = iter_55_2[2][2]
					local var_55_5

					if not var_55_0[var_55_3] then
						var_55_5 = 0
					end

					var_55_0[var_55_3] = var_55_5 + var_55_4
				end
			end
		end
	end

	Clone = var_3

	local var_55_6 = var_3(arg_55_1:getConfig("equipment_proficiency"))

	pairs = var_4

	for iter_55_3, iter_55_4 in var_4(var_55_0) do
		var_55_6[iter_55_3] = var_55_6[iter_55_3] + iter_55_4
	end

	return var_55_6
end

function var_0_1.isFinishPrevTask(arg_56_0)
	local var_56_0 = true
	local var_56_1 = true

	ipairs = var_1_10003

	for iter_56_0, iter_56_1 in var_1_10003(arg_56_0:getOpenTaskList()) do
		getProxy = var_1_10008
		TaskProxy = var_1_10010
		var_1_10010 = var_1_10008(var_1_10010)

		if not var_1_10008.getTaskVO(var_1_10010, iter_56_1) or not var_1_10008:isFinish() then
			return false, false
		else
			var_56_1 = (var_1_10008:isReceive() or false) and var_56_1
		end
	end

	return var_56_0, var_56_1
end

function var_0_1.isShipModMaxLevel(arg_57_0, arg_57_1)
	assert = var_1_10002

	var_1_10002(arg_57_1, "shipVO can not be nil" .. arg_57_0.shipId)

	local var_57_0 = arg_57_0
	local var_57_1 = arg_57_0.getStrengthenConfig

	math = var_5

	local var_57_2 = var_57_1(var_57_0, var_5.min(arg_57_0.level + 1, arg_57_0:getMaxLevel()))

	if not arg_57_0:isMaxLevel() and arg_57_1.level < var_57_2.need_lv then
		return true, var_57_2.need_lv
	else
		return false
	end

	return
end

function var_0_1.isShipModMaxFateLevel(arg_58_0, arg_58_1)
	assert = var_1_10002

	var_1_10002(arg_58_1, "shipVO can not be nil" .. arg_58_0.shipId)

	local var_58_0 = arg_58_0
	local var_58_1 = arg_58_0.getFateStrengthenConfig

	math = var_5

	local var_58_2 = var_58_1(var_58_0, var_5.min(arg_58_0.fateLevel + 1, arg_58_0:getMaxFateLevel()))

	if not arg_58_0:isMaxFateLevel() and arg_58_1.level < var_58_2.need_lv then
		return true, var_58_2.need_lv
	else
		return false
	end

	return
end

function var_0_1.isShipModMaxIntensifyLevel(arg_59_0, arg_59_1)
	if arg_59_0:canFateSimulation() then
		return arg_59_0:isShipModMaxFateLevel(arg_59_1)
	else
		return arg_59_0:isShipModMaxLevel(arg_59_1)
	end

	return
end

function var_0_1.getChangeSkillList(arg_60_0)
	return arg_60_0:getConfig("change_skill")
end

function var_0_1.isRarityUR(arg_61_0)
	local var_61_0 = arg_61_0:getShipVO()
	local var_61_1 = var_1.getRarity(var_61_0)

	ShipRarity = var_1_10002

	return var_61_1 >= var_1_10002.SSR
end

function var_0_1.getFateMaxLeftOver(arg_62_0)
	if arg_62_0:isRarityUR() then
		pg = var_62_0

		local var_62_0

		if not var_62_0.gameset.fate_sim_ur.key_value then
			pg = var_62_0
			var_62_0 = var_62_0.gameset.fate_sim_ssr.key_value
		end

		return var_62_0 - arg_62_0:getFateUseNum() < 0 and var_62_0 or var_2
	end
end

function var_0_1.getFateUseNum(arg_63_0)
	local var_63_0 = 0

	if arg_63_0:isMaxLevel() then
		local var_63_1 = 0

		ipairs = var_1_10003

		for iter_63_0, iter_63_1 in var_1_10003(arg_63_0.fateStrengthenConfig) do
			if iter_63_1.lv <= 30 + arg_63_0.fateLevel then
				var_63_1 = var_63_1 + iter_63_1.need_exp
			end
		end

		local var_63_2 = var_63_1 + arg_63_0.exp
		local var_63_3 = arg_63_0:getItemExp()

		math = var_4
		var_63_0 = var_4.floor(var_63_2 / var_63_3)
	end

	return var_63_0
end

function var_0_1.isPursuing(arg_64_0)
	return arg_64_0:getConfig("is_pursuing") == 1
end

function var_0_1.getPursuingPrice(arg_65_0, arg_65_1)
	arg_65_1 = arg_65_1 or 100

	return arg_65_0:getConfig("price") * arg_65_1 / 100
end

function var_0_1.getUnlockItem(arg_66_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003

	local var_66_0 = var_1_10001(var_1_10003)

	ipairs = var_1_10002

	for iter_66_0, iter_66_1 in var_1_10002(arg_66_0:getConfig("gain_item_id")) do
		if var_66_0:getItemCountById(iter_66_1) > 0 then
			return iter_66_1
		end
	end

	return
end

function var_0_1.isPursuingCostTip(arg_67_0)
	if arg_67_0:isPursuing() and arg_67_0:isUnlock() then
		if not arg_67_0:isMaxIntensifyLevel() then
			local var_67_0 = arg_67_0
			local var_67_1 = arg_67_0.isShipModMaxIntensifyLevel

			getProxy = var_1_10004
			BayProxy = var_1_10006

			local var_67_2 = var_1_10004(var_1_10006)

			if not var_67_1(var_67_0, var_4.getShipById(var_67_2, arg_67_0.shipId)) then
				getProxy = var_67_1
				TechnologyProxy = var_67_0

				local var_67_3 = var_67_1(var_67_0)

				if var_67_1.calcPursuingCost(var_67_3, arg_67_0, 1) ~= 0 then
					var_67_1 = false
				else
					var_67_1 = true
				end

				return var_67_1
			end
		end
	end
end

function var_0_1.setPhantomQuestProgress(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0

	if not arg_68_0.phantomQuestProgress then
		var_68_0 = {}
	end

	arg_68_0.phantomQuestProgress = var_68_0
	arg_68_0.phantomQuestProgress[arg_68_1] = arg_68_2

	return
end

function var_0_1.getPhantomQuestCostDrop(arg_69_0)
	if arg_69_0.config.type == 5 then
		Drop = var_1

		local var_69_0 = var_1.New
		local var_69_1 = {}

		DROP_TYPE_RESOURCE = var_1_10004
		var_69_1.type = var_1_10004
		PlayerConst = var_1_10004
		var_69_1.id = var_1_10004.ResDiamond
		var_69_1.count = arg_69_0.config.target_num

		return var_69_0(var_69_1)
	else
		return nil
	end

	return
end

function var_0_1.getPhantomQuestProgress(arg_70_0, arg_70_1)
	assert = var_1_10002

	var_1_10002(arg_70_0.shipId)

	switch = var_1_10002

	return var_1_10002(arg_70_1, {
		function()
			getProxy = var_2_10000
			BayProxy = var_2_10002

			local var_71_0 = var_2_10000(var_2_10002)

			return var_0.getShipById(var_71_0, arg_70_0.shipId).level
		end,
		function()
			local var_72_0 = arg_70_0.level
			local var_72_1 = arg_70_0.level
			local var_72_2 = arg_70_0

			return var_72_0 + (var_72_1 < var_2.getMaxLevel(var_72_2) and 0 or arg_70_0.fateLevel)
		end,
		function()
			local var_73_0

			if not arg_70_0.phantomQuestProgress[3] then
				var_73_0 = 0
			end

			return var_73_0
		end,
		function()
			getProxy = var_2_10000
			BayProxy = var_2_10002

			local var_74_0 = var_2_10000(var_2_10002)

			return var_0.getShipById(var_74_0, arg_70_0.shipId).propose and 1 or 0
		end,
		function()
			Drop = var_2_10000

			local var_75_0 = var_2_10000.New
			local var_75_1 = {}

			DROP_TYPE_RESOURCE = var_2_10003
			var_75_1.type = var_2_10003
			PlayerConst = var_2_10003
			var_75_1.id = var_2_10003.ResDiamond

			local var_75_2 = var_75_0(var_75_1)

			return var_0.getOwnedCount(var_75_2)
		end
	})
end

function var_0_1.getPhantomQuestInfo(arg_76_0, arg_76_1)
	pg = var_1_10002

	local var_76_0 = var_1_10002.technology_shadow_unlock[arg_76_1]
	local var_76_1 = {
		config = var_76_0
	}
	local var_76_2 = arg_76_0

	var_76_1.progress = arg_76_0.getPhantomQuestProgress(var_76_2, var_76_0.type)
	tobool = var_4
	getProxy = var_76_2
	BayProxy = var_1_10008

	local var_76_3 = var_76_2(var_1_10008)

	var_76_1.unlocked = var_4(var_6.getShipById(var_76_3, arg_76_0.shipId).phantomDic[arg_76_1])

	return var_76_1
end

function var_0_1.getAllPhantomQuestInfo(arg_77_0)
	underscore = var_1_10001

	local var_77_0 = var_1_10001.map

	pg = var_1_10003

	return var_77_0(var_1_10003.technology_shadow_unlock.all, function(arg_78_0)
		local var_78_0 = arg_77_0

		return var_1.getPhantomQuestInfo(var_78_0, arg_78_0)
	end)
end

function var_0_1.isUnlockShipPhantom(arg_79_0)
	getGameset = var_1_10001

	local var_79_0 = var_1_10001("technology_shadow_unlock_lv")[1]
	local var_79_1 = arg_79_0
	local var_79_3

	if arg_79_0.isFetched(var_79_1) then
		getProxy = var_79_3
		BayProxy = var_79_1

		local var_79_2 = var_79_3(var_79_1)

		var_79_3 = var_79_0 <= var_79_3.getShipById(var_79_2, arg_79_0.shipId).level
	end

	return var_79_3
end

function var_0_1.IsFate(arg_80_0)
	return #arg_80_0:getConfig("fate_strengthen") > 0
end

return var_0_1
