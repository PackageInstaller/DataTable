class = var_0_10000

local var_0_0 = "CompensateProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.Compensate_Remove = "CompensateProxy Compensate_Remove"
var_0_1.All_Compensate_Remove = "CompensateProxy All_Compensate_Remove"
var_0_1.UPDATE_ATTACHMENT_COUNT = "CompensateProxy UPDATE_ATTACHMENT_COUNT"

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}

	arg_1_0:on(30101, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.unpdateLatestTime(var_2_0, arg_2_0.max_timestamp)

		local var_2_1 = arg_1_0

		var_1.unpdateUnreadCount(var_2_1, arg_2_0.number)

		local var_2_2 = arg_1_0

		var_1.SetDirty(var_2_2, true)

		return
	end)

	return
end

function var_0_1.RefreshRewardList(arg_3_0, arg_3_1)
	arg_3_0.data = {}
	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_1) do
		arg_3_0.data[iter_3_1.id] = iter_3_1
	end

	return
end

function var_0_1.GetAllRewardList(arg_4_0)
	local var_4_0 = {}

	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.data) do
		local var_4_1 = iter_4_1.timestamp

		pg = var_1_10008

		local var_4_2 = var_1_10008.TimeMgr.GetInstance()
		local var_4_3 = var_4_1 - var_1_10008.GetServerTime(var_4_2)

		if 0 < var_4_3 then
			table = var_1_10008

			var_1_10008.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function var_0_1.GetCompensateAttachments(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if not arg_5_0.data[arg_5_1].attachFlag then
		ipairs = var_4

		for iter_5_0, iter_5_1 in var_4(var_3.attachments) do
			table = var_1_10009
			var_1_10009 = var_1_10009.insert

			local var_5_1 = var_5_0

			Clone = var_1_10012

			var_1_10009(var_5_1, var_1_10012(iter_5_1))
		end
	end

	PlayerConst = var_4

	return var_4.MergeSameDrops(var_5_0)
end

function var_0_1.DealMailOperation(arg_6_0, arg_6_1)
	if arg_6_0.data[arg_6_1] then
		local var_6_0 = arg_6_0.data[arg_6_1]

		var_2.setAttachFlag(var_6_0, true)
	end

	return
end

function var_0_1.timeCall(arg_7_0)
	local var_7_0 = {}

	ProxyRegister = var_1_10002
	var_7_0[var_1_10002.SecondCall] = function(arg_8_0)
		local var_8_0

		pairs = var_2_10002

		for iter_8_0, iter_8_1 in var_2_10002(arg_7_0.data) do
			if iter_8_1:isEnd() then
				if var_8_0 == nil then
					var_8_0 = {}
				end

				table = var_7

				var_7.insert(var_8_0, iter_8_0)
			end
		end

		if var_8_0 ~= nil then
			ipairs = var_2

			for iter_8_2, iter_8_3 in var_2(var_8_0) do
				arg_7_0.data[iter_8_3] = nil
			end

			local var_8_1 = arg_7_0

			var_2.sendNotification(var_8_1, var_0_1.Compensate_Remove)
		end

		if arg_7_0.max_timestamp ~= 0 then
			local var_8_2 = arg_7_0.max_timestamp

			pg = var_3

			local var_8_3 = var_3.TimeMgr.GetInstance()

			if var_8_2 - var_3.GetServerTime(var_8_3) < 0 then
				arg_7_0.max_timestamp = 0

				local var_8_4 = arg_7_0

				var_3.sendNotification(var_8_4, var_0_1.All_Compensate_Remove)
			end
		end

		return
	end

	return var_7_0
end

function var_0_1.unpdateLatestTime(arg_9_0, arg_9_1)
	arg_9_0.max_timestamp = arg_9_1

	return
end

function var_0_1.unpdateUnreadCount(arg_10_0, arg_10_1)
	arg_10_0._existUnreadCount = arg_10_1

	arg_10_0:sendNotification(var_0_1.UPDATE_ATTACHMENT_COUNT)

	return
end

function var_0_1.IsDirty(arg_11_0)
	return arg_11_0.isDirty
end

function var_0_1.SetDirty(arg_12_0, arg_12_1)
	arg_12_0.isDirty = arg_12_1

	return
end

function var_0_1.hasRewardCount(arg_13_0)
	local var_13_0 = arg_13_0.max_timestamp

	pg = var_1_10002

	local var_13_1 = var_1_10002.TimeMgr.GetInstance()
	local var_13_2 = var_13_0 - var_2.GetServerTime(var_13_1)

	return arg_13_0._existUnreadCount > 0 and var_13_2 > 0
end

return var_0_1
