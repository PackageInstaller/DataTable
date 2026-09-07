local IslandRequestCommand = class("IslandRequestCommand", pm.SimpleCommand)

function IslandRequestCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = pg.TimeMgr.GetInstance():GetServerTime()

	pg.ConnectionMgr.GetInstance():Send(26108, {
		act_id = var_1_0.act_id
	}, 26109, function(arg_2_0)
		if arg_2_0.ret == 0 then
			local var_2_0 = getProxy(SixthAnniversaryIslandProxy)

			var_2_0.timeStamp = var_1_1
			var_2_0.nodeDic = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.node_list) do
				var_2_0.nodeDic[iter_2_1.id] = IslandNode.New(iter_2_1)
			end

			existCall(var_1_0.callback)
			pg.m02:sendNotification(GAME.REQUEST_NODE_LIST_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips("Request island data failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandRequestCommand
