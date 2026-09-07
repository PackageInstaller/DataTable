local IslandNodeMarkCommand = class("IslandNodeMarkCommand", pm.SimpleCommand)

function IslandNodeMarkCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 2,
		activity_id = var_1_0.act_id,
		arg1 = var_1_0.node_id
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(SixthAnniversaryIslandProxy):GetNode(var_1_0.node_id).isNew = false

			pg.m02:sendNotification(GAME.ISLAND_NODE_MARK_DONE, {
				node_id = var_1_0.node_id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("Trigger island event failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandNodeMarkCommand
