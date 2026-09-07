local GetWBOtherBossCommand = class("GetWBOtherBossCommand", pm.SimpleCommand)

function GetWBOtherBossCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = {}

	if var_1_0 == WorldBoss.OTHER_BOSS_TYPE_FRIEND then
		for iter_1_0, iter_1_1 in pairs((getProxy(FriendProxy):getRawData())) do
			table.insert(var_1_1, iter_1_1.id)
		end
	elseif var_1_0 == WorldBoss.OTHER_BOSS_TYPE_GUILD then
		for iter_1_2, iter_1_3 in pairs(getProxy(GuildProxy):getRawData().member) do
			table.insert(var_1_1, iter_1_3.id)
		end
	end

	if #var_1_1 == 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(33503, {
		user_id_list = var_1_1
	}, 33504, function(arg_2_0)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.boss_list) do
			local var_2_1 = WorldBoss.New()

			var_2_1:Setup(iter_2_1)
			table.insert(var_2_0, var_2_1)
		end

		nowWorld():GetBossProxy():UpdateOtheroBosses(var_2_0)
		self:sendNotification(GAME.WORLD_BOSS_GET_OTHER_BOSS_DONE)

		return
	end)

	return
end

return GetWBOtherBossCommand
