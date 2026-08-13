class = var_0_10000

local var_0_0 = "GuildTechnologyGroup"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

var_0_1.STATE_STOP = 0
var_0_1.STATE_START = 1

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id

	local var_1_0 = arg_1_0:bindConfigTable().get_id_list_by_group[arg_1_0.id][1]

	arg_1_0:update({
		progress = 0,
		state = 0,
		id = var_1_0,
		fake_id = var_1_0
	})

	return
end

function var_0_1.update(arg_2_0, arg_2_1)
	arg_2_0.pid = arg_2_1.id
	arg_2_0.configId = arg_2_0.pid

	local var_2_0

	if not arg_2_1.state then
		var_2_0 = 0
	end

	arg_2_0.state = var_2_0

	local var_2_1

	if not arg_2_1.progress then
		var_2_1 = 0
	end

	arg_2_0.progress = var_2_1

	local var_2_2

	if not arg_2_1.fake_id and not arg_2_0.fakeId then
		var_2_2 = arg_2_1.id
	end

	arg_2_0.fakeId = var_2_2

	return
end

function var_0_1.AddProgress(arg_3_0, arg_3_1)
	arg_3_0.progress = arg_3_0.progress + arg_3_1

	if arg_3_0:GetTargetProgress() <= arg_3_0.progress then
		arg_3_0:LevelUp()
	end

	return
end

function var_0_1.LevelUp(arg_4_0)
	local var_4_0 = arg_4_0:GetNextId()

	arg_4_0:update({
		progress = 0,
		id = var_4_0,
		state = arg_4_0.state,
		fake_id = arg_4_0.fakeId
	})

	return
end

function var_0_1.GetNextId(arg_5_0)
	if arg_5_0:getConfig("next_tech") == 0 then
		return arg_5_0.pid
	else
		return var_1
	end

	return
end

function var_0_1.GetState(arg_6_0)
	return arg_6_0.state
end

function var_0_1.GetTargetProgress(arg_7_0)
	return arg_7_0:getConfig("exp")
end

function var_0_1.GetProgress(arg_8_0)
	return arg_8_0.progress
end

function var_0_1.GetFakeLevel(arg_9_0)
	return arg_9_0:bindConfigTable()[arg_9_0.fakeId].level
end

function var_0_1.GetLevel(arg_10_0)
	return arg_10_0:getConfig("level")
end

function var_0_1.GetMaxLevel(arg_11_0)
	return arg_11_0:getConfig("level_max")
end

function var_0_1.isMaxLevel(arg_12_0)
	return arg_12_0:GetLevel() >= arg_12_0:GetMaxLevel()
end

function var_0_1.bindConfigTable(arg_13_0)
	pg = var_1_10001

	return var_1_10001.guild_technology_template
end

function var_0_1.GuildMemberCntType(arg_14_0)
	local var_14_0 = arg_14_0:getConfig("effect_args")[1]

	GuildConst = var_1_10002

	return var_14_0 == var_1_10002.TYPE_GUILD_MEMBER_CNT
end

function var_0_1.isStarting(arg_15_0)
	return arg_15_0.state == var_0_1.STATE_START
end

function var_0_1.GetDesc(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.bindConfigTable(var_16_0)[arg_16_0.pid].next_tech

	assert = var_16_0

	var_16_0(var_16_1, arg_16_0.pid)

	local var_16_2 = var_1[arg_16_0.pid].effect_args

	if var_16_1 == 0 then
		local var_16_3 = var_1[arg_16_0.pid].num
		local var_16_4 = var_1[arg_16_0.pid].num

		GuildConst = var_6

		return var_6.GET_TECHNOLOGY_GROUP_DESC(var_16_2, var_16_3, var_16_4)
	else
		local var_16_5 = var_1[arg_16_0.pid].num
		local var_16_6 = var_1[var_16_1].num

		GuildConst = var_6

		return var_6.GET_TECHNOLOGY_GROUP_DESC(var_16_2, var_16_5, var_16_6)
	end

	return
end

function var_0_1.Stop(arg_17_0)
	arg_17_0.state = var_0_1.STATE_STOP

	return
end

function var_0_1.Start(arg_18_0)
	arg_18_0.state = var_0_1.STATE_START

	return
end

return var_0_1
