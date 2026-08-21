local var_0_0 = class("CompensateProxy", import(".NetProxy"))

var_0_0.Compensate_Remove = "CompensateProxy Compensate_Remove"
var_0_0.All_Compensate_Remove = "CompensateProxy All_Compensate_Remove"
var_0_0.UPDATE_ATTACHMENT_COUNT = "CompensateProxy UPDATE_ATTACHMENT_COUNT"

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}

	arg_1_0:on(30101, function(arg_2_0)
		arg_1_0:unpdateLatestTime(arg_2_0.max_timestamp)
		arg_1_0:unpdateUnreadCount(arg_2_0.number)
		arg_1_0:SetDirty(true)

		return
	end)

	return
end

function var_0_0.RefreshRewardList(arg_3_0, arg_3_1)
	arg_3_0.data = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.data[iter_3_1.id] = iter_3_1
	end

	return
end

function var_0_0.GetAllRewardList(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.data) do
		local var_4_0 = pg.TimeMgr.GetInstance()
		local var_4_1 = iter_4_1.timestamp - var_4_0:GetServerTime()

		if var_4_1 > 0 then
			table.insert({}, iter_4_1)
		end
	end

	return {}
end

function var_0_0.GetCompensateAttachments(arg_5_0, arg_5_1)
	if not arg_5_0.data[arg_5_1].attachFlag then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.data[arg_5_1].attachments) do
			table.insert({}, Clone(iter_5_1))
		end
	end

	return PlayerConst.MergeSameDrops({})
end

function var_0_0.DealMailOperation(arg_6_0, arg_6_1)
	if arg_6_0.data[arg_6_1] then
		arg_6_0.data[arg_6_1]:setAttachFlag(true)
	end

	return
end

function var_0_0.timeCall(arg_7_0)
	return {
		[ProxyRegister.SecondCall] = function(arg_8_0)
			local var_8_0

			for iter_8_0, iter_8_1 in pairs(arg_7_0.data) do
				if iter_8_1:isEnd() then
					if var_8_0 == nil then
						var_8_0 = {}
					end

					table.insert(var_8_0, iter_8_0)
				end
			end

			if var_8_0 ~= nil then
				for iter_8_2, iter_8_3 in ipairs(var_8_0) do
					arg_7_0.data[iter_8_3] = nil
				end

				arg_7_0:sendNotification(var_0_0.Compensate_Remove)
			end

			if arg_7_0.max_timestamp ~= 0 then
				if arg_7_0.max_timestamp - pg.TimeMgr.GetInstance():GetServerTime() < 0 then
					arg_7_0.max_timestamp = 0

					arg_7_0:sendNotification(var_0_0.All_Compensate_Remove)
				end
			end

			return
		end
	}
end

function var_0_0.unpdateLatestTime(arg_9_0, arg_9_1)
	arg_9_0.max_timestamp = arg_9_1

	return
end

function var_0_0.unpdateUnreadCount(arg_10_0, arg_10_1)
	arg_10_0._existUnreadCount = arg_10_1

	arg_10_0:sendNotification(var_0_0.UPDATE_ATTACHMENT_COUNT)

	return
end

function var_0_0.IsDirty(arg_11_0)
	return arg_11_0.isDirty
end

function var_0_0.SetDirty(arg_12_0, arg_12_1)
	arg_12_0.isDirty = arg_12_1

	return
end

function var_0_0.hasRewardCount(arg_13_0)
	local var_13_0 = arg_13_0.max_timestamp - pg.TimeMgr.GetInstance():GetServerTime()

	return arg_13_0._existUnreadCount > 0 and var_13_0 > 0
end

return var_0_0
