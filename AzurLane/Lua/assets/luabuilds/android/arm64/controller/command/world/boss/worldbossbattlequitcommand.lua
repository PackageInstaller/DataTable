class = var_0_10000

local var_0_0 = "WorldBossBattleQuitCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1

	if not arg_1_1.getBody(var_1_0).id then
		return
	end

	nowWorld = var_1_0

	local var_1_1 = var_1_0()
	local var_1_2 = var_4.GetBossProxy(var_1_1)

	if var_5.GetBossById(var_1_2, var_3) and not var_5:IsSelfBoss(var_6) then
		local var_1_3 = var_5

		var_5.RemoveCacheBoss(var_1_3, var_3)

		getProxy = var_7
		ChatProxy = var_1_3

		local var_1_4 = var_7(var_1_3)
		local var_1_5 = var_7.GetMessagesByUniqueId(var_1_4, var_3 .. "_" .. var_6.lastTime)

		ipairs = var_1_3

		for iter_1_0, iter_1_1 in var_1_3(var_1_5) do
			iter_1_1.args.isDeath = true

			var_7:UpdateMsg(iter_1_1)
		end

		getProxy = var_9
		GuildProxy = var_11

		local var_1_6 = var_9(var_11)
		local var_1_7 = var_9.GetMessagesByUniqueId(var_1_6, var_3 .. "_" .. var_6.lastTime)

		ipairs = var_11

		for iter_1_2, iter_1_3 in var_11(var_1_7) do
			iter_1_3.args.isDeath = true

			var_9:UpdateMsg(iter_1_3)
		end
	end

	return
end

return var_0_1
