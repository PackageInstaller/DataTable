class = var_0_10000

local var_0_0 = "HandleGuildAndPublicGuildTechCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.GetPublicGuild(var_1_0)

	assert = var_1_10004

	var_1_10004(var_1_1)

	if not var_2:getData() then
		return
	end

	local var_1_2 = false
	local var_1_3 = var_1_1:GetTechnologyGroups()

	pairs = var_1_10007

	for iter_1_0, iter_1_1 in var_1_10007(var_1_3) do
		local var_1_4 = var_4:getTechnologyGroupById(iter_1_1.id)

		var_12.update(var_1_4, {
			id = var_12.pid,
			state = var_12.state,
			progress = var_12.progress,
			fake_id = iter_1_1.pid
		})

		var_1_2 = true
	end

	if var_1_2 then
		var_2:updateGuild(var_4)
	end

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.sendNotification

	GAME = iter_1_0

	var_1_6(var_1_5, iter_1_0.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH_DONE)

	return
end

return var_0_1
