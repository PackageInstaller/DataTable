local var_0_0 = class("HandleGuildAndPublicGuildTechCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(GuildProxy)
	local var_1_1 = var_1_0:GetPublicGuild()

	assert(var_1_1)

	local var_1_2 = var_1_0:getData()

	if not var_1_2 then
		return
	end

	local var_1_3 = false

	for iter_1_0, iter_1_1 in pairs((var_1_1:GetTechnologyGroups())) do
		local var_1_4 = var_1_2:getTechnologyGroupById(iter_1_1.id)

		var_1_4:update({
			id = var_1_4.pid,
			state = var_1_4.state,
			progress = var_1_4.progress,
			fake_id = iter_1_1.pid
		})

		var_1_3 = true
	end

	if var_1_3 then
		var_1_0:updateGuild(var_1_2)
	end

	arg_1_0:sendNotification(GAME.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH_DONE)

	return
end

return var_0_0
