class = var_0_10000

local var_0_0 = "WorldBossSupportCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).type

	assert = var_1_0

	var_1_0(var_1_1)

	nowWorld = var_1_0

	local var_1_2 = var_1_0().worldBossProxy

	if not var_5.GetSelfBoss(var_1_2) then
		pg = var_1_10007

		local var_1_3 = var_1_10007.TipsMgr.GetInstance()
		local var_1_4 = var_7.ShowTips

		i18n = var_1_10010

		var_1_4(var_1_3, var_1_10010("world_joint_boss_not_found"))

		return
	end

	local var_1_5 = var_6
	local var_1_6

	if var_6.isDeath(var_1_5) then
		pg = var_1_6
		var_1_5 = var_1_6.TipsMgr.GetInstance()
		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10010

		var_1_6(var_1_5, var_1_10010("world_joint_boss_is_death"))

		return
	end

	WorldBoss = var_1_6

	if var_1_1 == var_1_6.SUPPORT_TYPE_GUILD then
		getProxy = var_7
		GuildProxy = var_1_5

		local var_1_7 = var_7(var_1_5)

		if not var_7.getRawData(var_1_7) then
			pg = var_1_5

			local var_1_8 = var_1_5.TipsMgr.GetInstance()

			var_1_5 = var_1_5.ShowTips
			i18n = var_1_10012

			var_1_5(var_1_8, var_1_10012("world_joint_whitout_guild"))

			return
		end
	else
		WorldBoss = var_7

		if var_1_1 == var_7.SUPPORT_TYPE_FRIEND then
			getProxy = var_7
			FriendProxy = var_1_5

			local var_1_9 = var_7(var_1_5)

			var_1_2 = var_7.getRawData(var_1_9)
			table = var_1_5

			if var_1_5.getCount(var_1_2) <= 0 then
				pg = var_9

				local var_1_10 = var_9.TipsMgr.GetInstance()
				local var_1_11 = var_9.ShowTips

				i18n = var_1_10012

				var_1_11(var_1_10, var_1_10012("world_joint_whitout_friend"))

				return
			end
		end
	end

	local function var_1_12(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_1
			WorldBoss = var_2_10002

			if var_2_0 == var_2_10002.SUPPORT_TYPE_FRIEND then
				local var_2_1 = var_0

				var_2_0.UpdateFriendSupported(var_2_1)
			else
				var_2_0 = var_1_1
				WorldBoss = var_2

				if var_2_0 == var_2.SUPPORT_TYPE_GUILD then
					local var_2_2 = var_0

					var_2_0.UpdateGuildSupported(var_2_2)
				else
					var_2_0 = var_1_1
					WorldBoss = var_2

					if var_2_0 == var_2.SUPPORT_TYPE_WORLD then
						local var_2_3 = var_0

						var_2_0.UpdateWorldSupported(var_2_3)
					end
				end
			end

			local var_2_4 = var_0

			var_2_0.UpdateSelfBoss(var_2_4, var_0)

			local var_2_5 = arg_1_0

			var_2_0 = var_2_0.sendNotification
			GAME = var_2_10004

			var_2_0(var_2_5, var_2_10004.WORLD_BOSS_SUPPORT_DONE)
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			i18n = var_2_10004

			var_2_7(var_2_6, var_2_10004("world_joint_call_support_failed") .. arg_2_0.result)
		end

		return
	end

	pg = var_1_2

	local var_1_13 = var_1_2.ConnectionMgr.GetInstance()

	var_8.Send(var_1_13, 34509, {
		type = var_1_1
	}, 34510, var_1_12)

	return
end

return var_0_1
