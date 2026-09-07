local QuickExchangeBlueprintCommand = class("QuickExchangeBlueprintCommand", pm.SimpleCommand)

function QuickExchangeBlueprintCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(BagProxy)
	local var_1_2 = {}

	pg.ConnectionMgr.GetInstance():Send(15012, {
		use_list = var_1_0
	}, 15013, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.ret_list) do
			if iter_2_1.result == 0 then
				var_1_1:removeItemById(var_1_0[iter_2_0].id, var_1_0[iter_2_0].count)

				var_1_2 = table.mergeArray(var_1_2, PlayerConst.addTranDrop(iter_2_1.drop_list))
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
			end
		end

		self:sendNotification(GAME.QUICK_EXCHANGE_BLUEPRINT_DONE, var_1_2)

		return
	end)

	return
end

return QuickExchangeBlueprintCommand
