local var_0_0 = class("WorldBossBattleQuitCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	if not var_1_0 then
		return
	end

	local var_1_1 = nowWorld():GetBossProxy()
	local var_1_2 = var_1_1:GetBossById(var_1_0)

	if var_1_2 and not var_1_1:IsSelfBoss(var_1_2) then
		var_1_1:RemoveCacheBoss(var_1_0)

		local var_1_3 = getProxy(ChatProxy)

		for iter_1_0, iter_1_1 in ipairs((var_1_3:GetMessagesByUniqueId(var_1_0 .. "_" .. var_1_2.lastTime))) do
			iter_1_1.args.isDeath = true

			var_1_3:UpdateMsg(iter_1_1)
		end

		local var_1_4 = getProxy(GuildProxy)

		for iter_1_2, iter_1_3 in ipairs((var_1_4:GetMessagesByUniqueId(var_1_0 .. "_" .. var_1_2.lastTime))) do
			iter_1_3.args.isDeath = true

			var_1_4:UpdateMsg(iter_1_3)
		end
	end

	return
end

return var_0_0
