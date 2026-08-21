local var_0_0 = class("WorldBossSupportCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type

	assert(var_1_0)

	local var_1_1 = nowWorld().worldBossProxy
	local var_1_2 = nowWorld().worldBossProxy:GetSelfBoss()

	if not var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_not_found"))

		return
	end

	if var_1_2:isDeath() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_boss_is_death"))

		return
	end

	if var_1_0 == WorldBoss.SUPPORT_TYPE_GUILD then
		if not getProxy(GuildProxy):getRawData() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_whitout_guild"))

			return
		end
	elseif var_1_0 == WorldBoss.SUPPORT_TYPE_FRIEND then
		if table.getCount((getProxy(FriendProxy):getRawData())) <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_whitout_friend"))

			return
		end
	end

	pg.ConnectionMgr.GetInstance():Send(34509, {
		type = var_1_0
	}, 34510, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_0 == WorldBoss.SUPPORT_TYPE_FRIEND then
				var_1_1:UpdateFriendSupported()
			elseif var_1_0 == WorldBoss.SUPPORT_TYPE_GUILD then
				var_1_1:UpdateGuildSupported()
			elseif var_1_0 == WorldBoss.SUPPORT_TYPE_WORLD then
				var_1_1:UpdateWorldSupported()
			end

			var_1_1:UpdateSelfBoss(var_1_2)
			arg_1_0:sendNotification(GAME.WORLD_BOSS_SUPPORT_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_joint_call_support_failed") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
