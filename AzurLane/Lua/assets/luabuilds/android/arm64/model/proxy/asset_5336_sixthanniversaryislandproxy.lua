class = var_0_10000

local var_0_0 = "SixthAnniversaryIslandProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.nodeDic = nil
	arg_1_0.timeStamp = 0

	return
end

function var_0_1.CheckValid(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.TimeMgr.GetInstance()
	local var_2_1

	if arg_2_0.nodeDic then
		var_2_1 = var_2_0:IsSameDay(arg_2_0.timeStamp, var_2_0:GetServerTime())
	end

	return var_2_1
end

function var_0_1.GetNodeDic(arg_3_0)
	if arg_3_0:CheckValid() then
		return arg_3_0.nodeDic
	else
		return {}
	end

	return
end

function var_0_1.CheckAndRequest(arg_4_0, arg_4_1)
	local var_4_0 = {}

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_4_1 = var_1_10003(var_1_10005)
	local var_4_2 = var_3.getActivityByType

	ActivityConst = var_1_10006

	if var_4_2(var_4_1, var_1_10006.ACTIVITY_TYPE_ISLAND) and not var_3:isEnd() and not arg_4_0:CheckValid() then
		table = var_1_10004

		var_1_10004.insert(var_4_0, function(arg_5_0)
			local var_5_0 = arg_4_0
			local var_5_1 = var_1.sendNotification

			GAME = var_2_10004

			var_5_1(var_5_0, var_2_10004.REQUEST_NODE_LIST, {
				act_id = var_0.id,
				callback = arg_5_0
			})

			return
		end)
	end

	seriesAsync = var_1_10004

	var_1_10004(var_4_0, arg_4_1)

	return
end

function var_0_1.GetNode(arg_6_0, arg_6_1)
	return arg_6_0.nodeDic[arg_6_1]
end

function var_0_1.GetNodeIds(arg_7_0)
	underscore = var_1_10001

	local var_7_0 = var_1_10001.keys(arg_7_0.nodeDic)

	table = var_1_10002

	var_1_10002.sort(var_7_0)

	return var_7_0
end

return var_0_1
