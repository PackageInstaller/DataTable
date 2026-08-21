local var_0_0 = class("IslandSettingFlagCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(IslandProxy):GetIsland():GetSettingsAgency()
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1:getBody().flags) do
		if var_1_0:GetFlagByType(iter_1_1.type) ~= iter_1_1.flag then
			table.insert({}, iter_1_1)
		end
	end

	if #{} == 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21332, {
		flag_list = {}
	}, 21333, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_0:SetFlags(var_1_1)
			arg_1_0:sendNotification(GAME.ISLAND_SETTING_FLAG_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
