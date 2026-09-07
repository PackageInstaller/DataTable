local IslandSetOrderTendencyCommand = class("IslandSetOrderTendencyCommand", pm.SimpleCommand)

function IslandSetOrderTendencyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().value
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	if var_1_1:GetTendency() == var_1_0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21410, {
		type = var_1_0
	}, 21411, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:SetTendency(var_1_0)
			self:sendNotification(GAME.ISLAND_SET_ORDER_TENDENCY_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSetOrderTendencyCommand
