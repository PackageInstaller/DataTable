class = var_0_10000

local var_0_0 = "IslandRequestCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_10003

	local var_1_2 = var_1_10003.TimeMgr.GetInstance()
	local var_1_3 = var_3.GetServerTime(var_1_2)

	pg = var_1_0

	local var_1_4 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_4, 26108, {
		act_id = var_1_1.act_id
	}, 26109, function(arg_2_0)
		local var_2_0

		if arg_2_0.ret == 0 then
			getProxy = var_2_0
			SixthAnniversaryIslandProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)
			var_2_0.timeStamp = var_1_3
			var_2_0.nodeDic = {}
			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(arg_2_0.node_list) do
				local var_2_1 = var_2_0.nodeDic
				local var_2_2 = iter_2_1.id

				IslandNode = var_2_10009
				var_2_1[var_2_2] = var_2_10009.New(iter_2_1)
			end

			existCall = var_2

			var_2(var_1_1.callback)

			pg = var_2

			local var_2_3 = var_2.m02
			local var_2_4 = var_2.sendNotification

			GAME = iter_2_0

			var_2_4(var_2_3, iter_2_0.REQUEST_NODE_LIST_DONE)
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "Request island data failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
