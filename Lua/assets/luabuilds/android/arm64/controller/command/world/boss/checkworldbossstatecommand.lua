local var_0_0 = class("CheckWorldBossStateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.bossId
	local var_1_2 = var_1_0.callback
	local var_1_3 = var_1_0.time or 0
	local var_1_4 = tonumber(var_1_3)
	local var_1_5 = var_1_0.failedCallback

	local function var_1_6()
		local var_2_0 = getProxy(ChatProxy)

		for iter_2_0, iter_2_1 in ipairs((var_2_0:GetMessagesByUniqueId(var_1_1 .. "_" .. var_1_4))) do
			iter_2_1.args.isDeath = true

			var_2_0:UpdateMsg(iter_2_1)
		end

		local var_2_1 = getProxy(GuildProxy)

		for iter_2_2, iter_2_3 in ipairs((var_2_1:GetMessagesByUniqueId(var_1_1 .. "_" .. var_1_4))) do
			iter_2_3.args.isDeath = true

			var_2_1:UpdateMsg(iter_2_3)
		end

		if var_1_5 then
			var_1_5()
		end

		return
	end

	print("boss id", var_1_0.bossId, " time:", var_1_4)
	pg.ConnectionMgr.GetInstance():Send(34515, {
		boss_id = var_1_0.bossId,
		last_time = var_1_4
	}, 34516, function(arg_3_0)
		if arg_3_0.result == 0 then
			if var_1_2 then
				var_1_2()
			end
		elseif arg_3_0.result == 1 then
			var_1_6()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
		elseif arg_3_0.result == 3 then
			var_1_6()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
		elseif arg_3_0.result == 6 then
			var_1_6()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_max_challenge_cnt"))
		elseif arg_3_0.result == 20 then
			var_1_6()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_none"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_0
