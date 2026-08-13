class = var_0_10000

local var_0_0 = "WorldBossSupportCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type

	assert = var_1_10004

	var_1_10004(var_1_0)

	nowWorld = var_1_10004

	local var_1_1 = var_1_10004().worldBossProxy

	if not var_5.GetSelfBoss(var_1_1) then
		pg = var_1_1

		local var_1_2 = var_1_1.TipsMgr.GetInstance()
		local var_1_3 = var_7.ShowTips

		i18n = var_1_10009

		var_1_3(var_1_2, var_1_10009("world_joint_boss_not_found"))

		return
	end

	local var_1_4 = var_6
	local var_1_5

	if var_6.isDeath(var_1_4) then
		pg = var_1_5
		var_1_4 = var_1_5.TipsMgr.GetInstance()
		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10009

		var_1_5(var_1_4, var_1_10009("world_joint_boss_is_death"))

		return
	end

	WorldBoss = var_1_5

	if var_1_0 == var_1_5.SUPPORT_TYPE_GUILD then
		getProxy = var_7
		GuildProxy = var_1_4

		local var_1_6 = var_7(var_1_4)

		if not var_7.getRawData(var_1_6) then
			pg = var_1_6

			local var_1_7 = var_1_6.TipsMgr.GetInstance()
			local var_1_8 = var_9.ShowTips

			i18n = var_1_10011

			var_1_8(var_1_7, var_1_10011("world_joint_whitout_guild"))

			return
		end
	else
		WorldBoss = var_7

		if var_1_0 == var_7.SUPPORT_TYPE_FRIEND then
			getProxy = var_7
			FriendProxy = var_1_4

			local var_1_9 = var_7(var_1_4)

			var_1_4 = var_7.getRawData(var_1_9)
			table = var_1_9

			if var_1_9.getCount(var_1_4) <= 0 then
				pg = var_9

				local var_1_10 = var_9.TipsMgr.GetInstance()
				local var_1_11 = var_9.ShowTips

				i18n = var_1_10011

				var_1_11(var_1_10, var_1_10011("world_joint_whitout_friend"))

				return
			end
		end
	end

	local function var_1_12(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_0
			WorldBoss = var_2_10002

			local var_2_1

			if var_2_0 == var_2_10002.SUPPORT_TYPE_FRIEND then
				var_2_1 = var_0

				var_2_0.UpdateFriendSupported(var_2_1)
			else
				var_2_0 = var_1_0
				WorldBoss = var_2_1

				local var_2_2

				if var_2_0 == var_2_1.SUPPORT_TYPE_GUILD then
					var_2_2 = var_0

					var_2_0.UpdateGuildSupported(var_2_2)
				else
					var_2_0 = var_1_0
					WorldBoss = var_2_2

					if var_2_0 == var_2_2.SUPPORT_TYPE_WORLD then
						local var_2_3 = var_0

						var_2_0.UpdateWorldSupported(var_2_3)
					end
				end
			end

			local var_2_4 = var_0

			var_2_0.UpdateSelfBoss(var_2_4, var_0)

			local var_2_5 = arg_1_0

			var_2_0 = var_2_0.sendNotification
			GAME = var_2_10003

			var_2_0(var_2_5, var_2_10003.WORLD_BOSS_SUPPORT_DONE)
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			i18n = var_2_10003

			var_2_7(var_2_6, var_2_10003("world_joint_call_support_failed") .. arg_2_0.result)
		end

		return
	end

	pg = var_1_4

	local var_1_13 = var_1_4.ConnectionMgr.GetInstance()

	var_8.Send(var_1_13, 34509, {
		type = var_1_0
	}, 34510, var_1_12)

	return
end

return var_0_1
