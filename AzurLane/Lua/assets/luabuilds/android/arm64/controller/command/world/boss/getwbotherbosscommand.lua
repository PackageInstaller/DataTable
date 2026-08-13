class = var_0_10000

local var_0_0 = "GetWBOtherBossCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = {}

	WorldBoss = var_1_10005

	if var_1_0 == var_1_10005.OTHER_BOSS_TYPE_FRIEND then
		getProxy = var_5
		FriendProxy = var_1_10007

		local var_1_2 = var_5(var_1_10007)
		local var_1_3 = var_5.getRawData(var_1_2)

		pairs = var_1_10007

		for iter_1_0, iter_1_1 in var_1_10007(var_1_3) do
			table = var_1_10012

			var_1_10012.insert(var_1_1, iter_1_1.id)
		end
	else
		WorldBoss = var_5

		if var_1_0 == var_5.OTHER_BOSS_TYPE_GUILD then
			getProxy = var_5
			GuildProxy = var_1_10007

			local var_1_4 = var_5(var_1_10007)
			local var_1_5 = var_5.getRawData(var_1_4)

			pairs = var_1_10007

			for iter_1_2, iter_1_3 in var_1_10007(var_1_5.member) do
				table = var_1_10012

				var_1_10012.insert(var_1_1, iter_1_3.id)
			end
		end
	end

	if #var_1_1 == 0 then
		return
	end

	pg = var_5

	local var_1_6 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_6, 33503, {
		user_id_list = var_1_1
	}, 33504, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.boss_list) do
			WorldBoss = var_2_10007

			local var_2_1 = var_2_10007.New()

			var_2_10007.Setup(var_2_1, iter_2_1)

			table = var_8

			var_8.insert(var_2_0, var_2_10007)
		end

		nowWorld = var_2

		local var_2_2 = var_2()
		local var_2_3 = var_2.GetBossProxy(var_2_2)

		var_2.UpdateOtheroBosses(var_2_3, var_2_0)

		local var_2_4 = arg_1_0
		local var_2_5 = var_3.sendNotification

		GAME = var_6

		var_2_5(var_2_4, var_6.WORLD_BOSS_GET_OTHER_BOSS_DONE)

		return
	end)

	return
end

return var_0_1
