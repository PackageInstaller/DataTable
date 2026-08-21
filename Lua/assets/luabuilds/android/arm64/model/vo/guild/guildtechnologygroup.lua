local var_0_0 = class("GuildTechnologyGroup", import("..BaseVO"))

var_0_0.STATE_STOP = 0
var_0_0.STATE_START = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
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

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.pid = arg_2_1.id
	arg_2_0.configId = arg_2_0.pid
	arg_2_0.state = arg_2_1.state or 0
	arg_2_0.progress = arg_2_1.progress or 0
	arg_2_0.fakeId = arg_2_1.fake_id or arg_2_0.fakeId or arg_2_1.id

	return
end

function var_0_0.AddProgress(arg_3_0, arg_3_1)
	arg_3_0.progress = arg_3_0.progress + arg_3_1

	if arg_3_0:GetTargetProgress() <= arg_3_0.progress then
		arg_3_0:LevelUp()
	end

	return
end

function var_0_0.LevelUp(arg_4_0)
	arg_4_0:update({
		progress = 0,
		id = arg_4_0:GetNextId(),
		state = arg_4_0.state,
		fake_id = arg_4_0.fakeId
	})

	return
end

function var_0_0.GetNextId(arg_5_0)
	local var_5_0 = arg_5_0:getConfig("next_tech")

	if var_5_0 == 0 then
		return arg_5_0.pid
	else
		return var_5_0
	end

	return
end

function var_0_0.GetState(arg_6_0)
	return arg_6_0.state
end

function var_0_0.GetTargetProgress(arg_7_0)
	return arg_7_0:getConfig("exp")
end

function var_0_0.GetProgress(arg_8_0)
	return arg_8_0.progress
end

function var_0_0.GetFakeLevel(arg_9_0)
	return arg_9_0:bindConfigTable()[arg_9_0.fakeId].level
end

function var_0_0.GetLevel(arg_10_0)
	return arg_10_0:getConfig("level")
end

function var_0_0.GetMaxLevel(arg_11_0)
	return arg_11_0:getConfig("level_max")
end

function var_0_0.isMaxLevel(arg_12_0)
	return arg_12_0:GetLevel() >= arg_12_0:GetMaxLevel()
end

function var_0_0.bindConfigTable(arg_13_0)
	return pg.guild_technology_template
end

function var_0_0.GuildMemberCntType(arg_14_0)
	return arg_14_0:getConfig("effect_args")[1] == GuildConst.TYPE_GUILD_MEMBER_CNT
end

function var_0_0.isStarting(arg_15_0)
	return arg_15_0.state == var_0_0.STATE_START
end

function var_0_0.GetDesc(arg_16_0)
	local var_16_0 = arg_16_0:bindConfigTable()

	assert(var_16_0[arg_16_0.pid].next_tech, arg_16_0.pid)

	if var_16_0[arg_16_0.pid].next_tech == 0 then
		return GuildConst.GET_TECHNOLOGY_GROUP_DESC(var_16_0[arg_16_0.pid].effect_args, var_16_0[arg_16_0.pid].num, var_16_0[arg_16_0.pid].num)
	else
		return GuildConst.GET_TECHNOLOGY_GROUP_DESC(var_16_0[arg_16_0.pid].effect_args, var_16_0[arg_16_0.pid].num, var_16_0[var_16_0[arg_16_0.pid].next_tech].num)
	end

	return
end

function var_0_0.Stop(arg_17_0)
	arg_17_0.state = var_0_0.STATE_STOP

	return
end

function var_0_0.Start(arg_18_0)
	arg_18_0.state = var_0_0.STATE_START

	return
end

return var_0_0
