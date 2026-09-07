local MailProxy = class("MailProxy", import(".NetProxy"))

MailProxy.MAIL_TOTAL = "mail total"
MailProxy.MAIL_OPENNED = "mail openned"
MailProxy.MAIL_ATTACHMENT_TAKEN = "mail attachment taken"
MailProxy.UPDATE_ATTACHMENT_COUNT = "UPDATE_ATTACHMENT_COUNT"
MailProxy.DEAL_CMD_LIST = {
	"read",
	"important",
	"unimportant",
	"delete",
	"attachment",
	"overflow",
	"move"
}
MailProxy.MailMessageBoxType = {
	OverflowConfirm = 3,
	ReDropConfirm = 5,
	ShowTips = 2,
	ReceiveAward = 1,
	RewardStoreroom = 4
}

function MailProxy:register()
	self.data = {}
	self.total = 0
	self.totalExist = 0
	self.totalExistMailId = nil
	self.ids = {}
	self.importantIds = nil
	self.rareIds = nil
	self.collectionData = {}
	self.collectionIds = nil

	self:on(30001, function(arg_2_0)
		self:unpdateUnreadCount(arg_2_0.unread_number)
		self:updateTotal(arg_2_0.total_number)

		return
	end)

	return
end

function MailProxy:getMail(arg_3_1)
	if self.data[arg_3_1] ~= nil then
		return self.data[arg_3_1]:clone()
	end

	return
end

function MailProxy:updateMail(arg_4_1)
	assert(isa(arg_4_1, Mail), "should be an instance of Mail")

	self.data[arg_4_1.id] = arg_4_1:clone()

	return
end

function MailProxy:removeMail(arg_5_1)
	self.total = self.total - 1

	if self.totalExist > 0 and arg_5_1 <= self.totalExistMailId then
		self.totalExist = self.totalExist - 1

		table.removebyvalue(self.ids, arg_5_1)
	end

	if self.data[arg_5_1] then
		if self.importantIds and self.data[arg_5_1].importantFlag then
			table.removebyvalue(self.importantIds, arg_5_1)
		end

		if self.rareIds and self.data[arg_5_1]:IsRare() then
			table.removebyvalue(self.rareIds, arg_5_1)
		end
	end

	self.data[arg_5_1] = nil

	return
end

function MailProxy:getCollecitonMail(arg_6_1)
	if self.collectionData[arg_6_1] then
		return self.collectionData[arg_6_1]:clone()
	end

	return
end

function MailProxy:updateCollectionMail(arg_7_1)
	assert(isa(arg_7_1, BaseMail), "should be an instance of BaseMail")

	self.collectionData[arg_7_1.id] = arg_7_1:clone()

	return
end

function MailProxy:removeCollectionMail(arg_8_1)
	assert(self.collectionData[arg_8_1] ~= nil, "mail should exist")

	self.collectionData[arg_8_1] = nil

	table.removebyvalue(self.collectionIds, arg_8_1)

	return
end

function MailProxy:DealMailOperation(arg_9_1, arg_9_2)
	switch(arg_9_2, {
		read = function()
			self._existUnreadCount = self._existUnreadCount - 1

			if self.data[arg_9_1] then
				self.data[arg_9_1]:setReadFlag(true)
			end

			return
		end,
		important = function()
			if self.data[arg_9_1] then
				self.data[arg_9_1]:setImportantFlag(true)

				if self.importantIds then
					table.dichotomyInsert(self.importantIds, arg_9_1)
				end
			end

			return
		end,
		unimportant = function()
			if self.data[arg_9_1] then
				self.data[arg_9_1]:setImportantFlag(false)

				if self.importantIds then
					table.removebyvalue(self.importantIds, arg_9_1)
				end
			end

			return
		end,
		delete = function()
			self:removeMail(arg_9_1)

			return
		end,
		attachment = function()
			if self.data[arg_9_1] then
				self.data[arg_9_1]:setAttachFlag(true)
				self.data[arg_9_1]:setReadFlag(true)
			end

			return
		end,
		overflow = function()
			return
		end,
		move = function()
			if self.data[arg_9_1] then
				self:removeMail(arg_9_1)
				self:updateCollectionMail(self.data[arg_9_1])

				if self.collectionIds then
					table.dichotomyInsert(self.collectionIds, arg_9_1)
				end
			end

			return
		end
	})

	return
end

function MailProxy:IsDirty()
	return self.totalExist < self.total
end

function MailProxy:GetNewIndex()
	return self.total - math.min(self.total - self.totalExist, SINGLE_MAIL_REQUIRE_SIZE) + 1, self.total
end

function MailProxy:GetNextIndex()
	return self.totalExist - #self.ids - math.min(self.totalExist - #self.ids, SINGLE_MAIL_REQUIRE_SIZE) + 1, self.totalExist - #self.ids
end

function MailProxy:AddNewMails(arg_20_1)
	local var_20_0 = {}
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		self:updateMail(iter_20_1)

		if iter_20_1.importantFlag then
			table.insert(var_20_0, iter_20_1.id)
		end

		if iter_20_1:IsRare() then
			table.insert(var_20_1, iter_20_1.id)
		end
	end

	self.ids = table.mergeArray(self.ids, underscore.map(arg_20_1, function(arg_21_0)
		return arg_21_0.id
	end))

	if #var_20_0 > 0 and self.importantIds then
		self.importantIds = table.mergeArray(self.importantIds, var_20_0)
	end

	if #var_20_1 > 0 and self.rareIds then
		self.rareIds = table.mergeArray(self.rareIds, var_20_1)
	end

	self.totalExist = self.total

	if self.totalExist > 0 then
		self.totalExistMailId = self.ids[#self.ids]
	end

	return
end

function MailProxy:AddNextMails(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		self:updateMail(iter_22_1)
	end

	self.ids = table.mergeArray(underscore.map(arg_22_1, function(arg_23_0)
		return arg_23_0.id
	end), self.ids)

	return
end

function MailProxy:SetImportantMails(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		self:updateMail(iter_24_1)
	end

	self.importantIds = underscore.map(arg_24_1, function(arg_25_0)
		return arg_25_0.id
	end)

	return
end

function MailProxy:SetRareMails(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		self:updateMail(iter_26_1)
	end

	self.rareIds = underscore.map(arg_26_1, function(arg_27_0)
		return arg_27_0.id
	end)

	return
end

function MailProxy:AddCollectionMails(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		self:updateCollectionMail(iter_28_1)
	end

	self.collectionIds = table.mergeArray(self.collectionIds, underscore.map(arg_28_1, function(arg_29_0)
		return arg_29_0.id
	end))

	return
end

function MailProxy:GetMails(arg_30_1)
	return underscore.map(arg_30_1, function(arg_31_0)
		return self.data[arg_31_0]
	end)
end

function MailProxy:GetCollectionMails(arg_32_1)
	return underscore.map(arg_32_1, function(arg_33_0)
		return self.collectionData[arg_33_0]
	end)
end

function MailProxy:GetMailsAttachments(arg_34_1)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		if not self.data[iter_34_1].attachFlag then
			for iter_34_2, iter_34_3 in ipairs(self.data[iter_34_1].attachments) do
				table.insert(var_34_0, Clone(iter_34_3))
			end
		end
	end

	return PlayerConst.MergeSameDrops(var_34_0)
end

function MailProxy:GetUnreadCount()
	return self._existUnreadCount
end

function MailProxy:unpdateUnreadCount(arg_36_1)
	self._existUnreadCount = arg_36_1

	self:sendNotification(MailProxy.UPDATE_ATTACHMENT_COUNT)

	return
end

function MailProxy:updateTotal(arg_37_1)
	self.total = arg_37_1

	self:sendNotification(MailProxy.MAIL_TOTAL, self.total)

	return
end

return MailProxy
