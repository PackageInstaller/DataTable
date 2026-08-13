class = var_0_10000

local var_0_0 = "PublicGuild"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseGuild"))

pg = var_0_10001

local var_0_2 = var_0_10001.guild_technology_template

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.technologyGroups = {}
	arg_1_0.technologys = {}
	pairs = var_2

	for iter_1_0, iter_1_1 in var_2(var_0_2.get_id_list_by_group) do
		GuildTechnologyGroup = var_1_10007
		var_1_10007 = var_1_10007.New({
			id = iter_1_0
		})

		local var_1_0 = arg_1_0.technologyGroups

		var_1_0[iter_1_0] = var_1_10007
		PublicGuildTechnology = var_1_0

		local var_1_1 = var_1_0.New(var_1_10007)

		arg_1_0.technologys[iter_1_0] = var_1_1
	end

	ipairs = var_2

	local var_1_2

	if not arg_1_1.technologys then
		var_1_2 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_2) do
		local var_1_3 = var_0_2[iter_1_3.id]
		local var_1_4 = arg_1_0.technologyGroups[var_1_3.group]

		var_8.update(var_1_4, iter_1_3)
	end

	pg = var_2
	arg_1_0.maxDonateCntPreDay = var_2.guildset.contribution_task_num.key_value

	return
end

function var_0_1.InitUser(arg_2_0, arg_2_1)
	arg_2_0.donateCount = arg_2_1.donate_count
	arg_2_0.donateTasks = {}
	ipairs = var_2

	local var_2_0

	if not arg_2_1.donate_tasks then
		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		GuildDonateTask = var_1_10007
		var_1_10007 = var_1_10007.New({
			id = iter_2_1
		})
		table = var_1_10008

		var_1_10008.insert(arg_2_0.donateTasks, var_1_10007)
	end

	ipairs = var_2

	local var_2_1

	if not arg_2_1.tech_id then
		var_2_1 = {}
	end

	for iter_2_2, iter_2_3 in var_2(var_2_1) do
		local var_2_2 = var_0_2[iter_2_3].group
		local var_2_3 = arg_2_0.technologys[var_2_2]
		local var_2_4 = arg_2_0.technologyGroups[var_2_2]

		var_2_3:Update(iter_2_3, var_2_4)
	end

	return
end

function var_0_1.GetTechnologyGroups(arg_3_0)
	return arg_3_0.technologyGroups
end

function var_0_1.GetDonateTasks(arg_4_0)
	return arg_4_0.donateTasks
end

function var_0_1.GetTechnologys(arg_5_0)
	return arg_5_0.technologys
end

function var_0_1.GetTechnologyById(arg_6_0, arg_6_1)
	return arg_6_0.technologys[arg_6_1]
end

function var_0_1.GetDonateCount(arg_7_0)
	return arg_7_0.donateCount
end

function var_0_1.GetDonateTaskById(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.donateTasks) do
		if iter_8_1.id == arg_8_1 then
			return iter_8_1
		end
	end

	return
end

function var_0_1.HasDonateCnt(arg_9_0)
	return arg_9_0:GetRemainDonateCnt() > 0
end

function var_0_1.UpdateDonateTasks(arg_10_0, arg_10_1)
	arg_10_0.donateTasks = arg_10_1

	return
end

function var_0_1.IncDonateCount(arg_11_0)
	arg_11_0.donateCount = arg_11_0.donateCount + 1

	return
end

function var_0_1.GetRemainDonateCnt(arg_12_0)
	return arg_12_0.maxDonateCntPreDay - arg_12_0.donateCount
end

function var_0_1.ResetDonateCnt(arg_13_0)
	arg_13_0.donateCount = 0

	return
end

return var_0_1
