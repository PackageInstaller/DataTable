class = var_0_10000

local var_0_0 = "TechnologyCatchup"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.STATE_UNSELECT = 1
var_0_1.STATE_CATCHUPING = 2
var_0_1.STATE_FINISHED_ALL = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.version
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.number then
		var_1_0 = 0
	end

	arg_1_0.ssrNum = var_1_0

	local var_1_1

	if not arg_1_1.dr_numbers then
		var_1_1 = {}
	end

	arg_1_0.urNums = var_1_1

	arg_1_0:bulidTargetNums()

	arg_1_0.state = var_0_1.STATE_UNSELECT

	arg_1_0:updateState()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.technology_catchup_template
end

function var_0_1.isUr(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0:getConfig("ur_char")) do
		if arg_3_1 == iter_3_1 then
			return true
		end
	end

	return false
end

function var_0_1.bulidTargetNums(arg_4_0)
	arg_4_0.targetNums = {}
	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0:getConfig("char_choice")) do
		if arg_4_0:isUr(iter_4_1) then
			pairs = var_6

			for iter_4_2, iter_4_3 in var_6(arg_4_0.urNums) do
				if iter_4_3.id == iter_4_1 then
					local var_4_0 = arg_4_0.targetNums
					local var_4_1

					if not iter_4_3.number then
						var_4_1 = 0
					end

					var_4_0[iter_4_1] = var_4_1
				end
			end
		else
			arg_4_0.targetNums[iter_4_1] = arg_4_0.ssrNum
		end

		if not arg_4_0.targetNums[iter_4_1] then
			arg_4_0.targetNums[iter_4_1] = 0
		end
	end

	return
end

function var_0_1.getTargetNum(arg_5_0, arg_5_1)
	return arg_5_0.targetNums[arg_5_1]
end

function var_0_1.addTargetNum(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_0:isUr(arg_6_1) then
		var_6_0 = arg_6_0.targetNums
		var_6_0[arg_6_1] = arg_6_0.targetNums[arg_6_1] + arg_6_2
	else
		ipairs = var_6_0

		for iter_6_0, iter_6_1 in var_6_0(arg_6_0:getConfig("char_choice")) do
			if not arg_6_0:isUr(iter_6_1) then
				arg_6_0.targetNums[iter_6_1] = arg_6_0.targetNums[iter_6_1] + arg_6_2
			end
		end
	end

	arg_6_0:updateState()

	return
end

function var_0_1.isFinish(arg_7_0, arg_7_1)
	if arg_7_0:isUr(arg_7_1) then
		return arg_7_0.targetNums[arg_7_1] >= arg_7_0:getConfig("obtain_max_per_ur")
	else
		return arg_7_0.targetNums[arg_7_1] >= arg_7_0:getConfig("obtain_max")
	end

	return
end

function var_0_1.isFinishSSR(arg_8_0)
	local var_8_0 = true

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0:getConfig("char_choice")) do
		if not arg_8_0:isUr(iter_8_1) and not arg_8_0:isFinish(iter_8_1) then
			var_8_0 = false
		end
	end

	return var_8_0
end

function var_0_1.isFinishAll(arg_9_0)
	local var_9_0 = true

	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0:getConfig("char_choice")) do
		if not arg_9_0:isFinish(iter_9_1) then
			var_9_0 = false
		end
	end

	return var_9_0
end

function var_0_1.updateState(arg_10_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003).curCatchupGroupID

	if arg_10_0:isFinishAll() then
		arg_10_0.state = var_0_1.STATE_FINISHED_ALL
	elseif arg_10_0.targetNums[var_10_0] then
		arg_10_0.state = var_0_1.STATE_CATCHUPING
	else
		arg_10_0.state = var_0_1.STATE_UNSELECT
	end

	return
end

function var_0_1.getState(arg_11_0)
	return arg_11_0.state
end

return var_0_1
