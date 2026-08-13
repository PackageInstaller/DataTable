class = var_0_10000

local var_0_0 = "WorldBossBattleQuitCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	if not arg_1_1:getBody().id then
		return
	end

	nowWorld = var_1_10004

	local var_1_0 = var_1_10004()
	local var_1_1 = var_4.GetBossProxy(var_1_0)

	if var_5.GetBossById(var_1_1, var_3) and not var_5:IsSelfBoss(var_6) then
		local var_1_2 = var_5

		var_5.RemoveCacheBoss(var_1_2, var_3)

		getProxy = var_7
		ChatProxy = var_1_2

		local var_1_3 = var_7(var_1_2)
		local var_1_4 = var_7.GetMessagesByUniqueId(var_1_3, var_3 .. "_" .. var_6.lastTime)

		ipairs = var_1_3

		for iter_1_0, iter_1_1 in var_1_3(var_1_4) do
			iter_1_1.args.isDeath = true

			var_7:UpdateMsg(iter_1_1)
		end

		getProxy = var_9
		GuildProxy = var_10

		local var_1_5 = var_9(var_10)
		local var_1_6 = var_9.GetMessagesByUniqueId(var_1_5, var_3 .. "_" .. var_6.lastTime)

		ipairs = var_1_5

		for iter_1_2, iter_1_3 in var_1_5(var_1_6) do
			iter_1_3.args.isDeath = true

			var_9:UpdateMsg(iter_1_3)
		end
	end

	return
end

return var_0_1
