local CompensateProxy = class("CompensateProxy", import(".NetProxy"))

CompensateProxy.Compensate_Remove = "CompensateProxy Compensate_Remove"
CompensateProxy.All_Compensate_Remove = "CompensateProxy All_Compensate_Remove"
CompensateProxy.UPDATE_ATTACHMENT_COUNT = "CompensateProxy UPDATE_ATTACHMENT_COUNT"

function CompensateProxy:register()
	self.data = {}

	self:on(30101, function(arg_2_0)
		self:unpdateLatestTime(arg_2_0.max_timestamp)
		self:unpdateUnreadCount(arg_2_0.number)
		self:SetDirty(true)

		return
	end)

	return
end

function CompensateProxy:RefreshRewardList(arg_3_1)
	self.data = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self.data[iter_3_1.id] = iter_3_1
	end

	return
end

function CompensateProxy:GetAllRewardList()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self.data) do
		if iter_4_1.timestamp - pg.TimeMgr.GetInstance():GetServerTime() > 0 then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function CompensateProxy:GetCompensateAttachments(arg_5_1)
	local var_5_0 = {}

	if not self.data[arg_5_1].attachFlag then
		for iter_5_0, iter_5_1 in ipairs(self.data[arg_5_1].attachments) do
			table.insert(var_5_0, Clone(iter_5_1))
		end
	end

	return PlayerConst.MergeSameDrops(var_5_0)
end

function CompensateProxy:DealMailOperation(arg_6_1)
	if self.data[arg_6_1] then
		self.data[arg_6_1]:setAttachFlag(true)
	end

	return
end

function CompensateProxy:timeCall()
	return {
		[ProxyRegister.SecondCall] = function(arg_8_0)
			local var_8_0

			for iter_8_0, iter_8_1 in pairs(self.data) do
				if iter_8_1:isEnd() then
					if var_8_0 == nil then
						var_8_0 = {}
					end

					table.insert(var_8_0, iter_8_0)
				end
			end

			if var_8_0 ~= nil then
				for iter_8_2, iter_8_3 in ipairs(var_8_0) do
					self.data[iter_8_3] = nil
				end

				self:sendNotification(CompensateProxy.Compensate_Remove)
			end

			if self.max_timestamp ~= 0 then
				if self.max_timestamp - pg.TimeMgr.GetInstance():GetServerTime() < 0 then
					self.max_timestamp = 0

					self:sendNotification(CompensateProxy.All_Compensate_Remove)
				end
			end

			return
		end
	}
end

function CompensateProxy:unpdateLatestTime(arg_9_1)
	self.max_timestamp = arg_9_1

	return
end

function CompensateProxy:unpdateUnreadCount(arg_10_1)
	self._existUnreadCount = arg_10_1

	self:sendNotification(CompensateProxy.UPDATE_ATTACHMENT_COUNT)

	return
end

function CompensateProxy:IsDirty()
	return self.isDirty
end

function CompensateProxy:SetDirty(arg_12_1)
	self.isDirty = arg_12_1

	return
end

function CompensateProxy:hasRewardCount()
	return self._existUnreadCount > 0 and self.max_timestamp - pg.TimeMgr.GetInstance():GetServerTime() > 0
end

return CompensateProxy
