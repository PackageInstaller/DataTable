class = var_0_10000

local var_0_0 = "MailProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.MAIL_TOTAL = "mail total"
var_0_1.MAIL_OPENNED = "mail openned"
var_0_1.MAIL_ATTACHMENT_TAKEN = "mail attachment taken"
var_0_1.UPDATE_ATTACHMENT_COUNT = "UPDATE_ATTACHMENT_COUNT"
var_0_1.DEAL_CMD_LIST = {
	"read",
	"important",
	"unimportant",
	"delete",
	"attachment",
	"overflow",
	"move"
}
var_0_1.MailMessageBoxType = {
	OverflowConfirm = 3,
	ReDropConfirm = 5,
	ShowTips = 2,
	ReceiveAward = 1,
	RewardStoreroom = 4
}

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.total = 0
	arg_1_0.totalExist = 0
	arg_1_0.totalExistMailId = nil
	arg_1_0.ids = {}
	arg_1_0.importantIds = nil
	arg_1_0.rareIds = nil
	arg_1_0.collectionData = {}
	arg_1_0.collectionIds = nil

	arg_1_0:on(30001, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.unpdateUnreadCount(var_2_0, arg_2_0.unread_number)

		local var_2_1 = arg_1_0

		var_1.updateTotal(var_2_1, arg_2_0.total_number)

		return
	end)

	return
end

function var_0_1.getMail(arg_3_0, arg_3_1)
	if arg_3_0.data[arg_3_1] ~= nil then
		local var_3_0 = arg_3_0.data[arg_3_1]

		return var_2.clone(var_3_0)
	end

	return
end

function var_0_1.updateMail(arg_4_0, arg_4_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_4_0 = arg_4_1

	Mail = var_1_10005

	var_1_10002(var_1_10003(var_4_0, var_1_10005), "should be an instance of Mail")

	arg_4_0.data[arg_4_1.id] = arg_4_1:clone()

	return
end

function var_0_1.removeMail(arg_5_0, arg_5_1)
	arg_5_0.total = arg_5_0.total - 1

	if arg_5_0.totalExist > 0 and arg_5_1 <= arg_5_0.totalExistMailId then
		arg_5_0.totalExist = arg_5_0.totalExist - 1
		table = var_2

		var_2.removebyvalue(arg_5_0.ids, arg_5_1)
	end

	if arg_5_0.data[arg_5_1] then
		if arg_5_0.importantIds and arg_5_0.data[arg_5_1].importantFlag then
			table = var_2

			var_2.removebyvalue(arg_5_0.importantIds, arg_5_1)
		end

		if arg_5_0.rareIds then
			local var_5_0 = arg_5_0.data[arg_5_1]

			if var_2.IsRare(var_5_0) then
				table = var_2

				var_2.removebyvalue(arg_5_0.rareIds, arg_5_1)
			end
		end
	end

	arg_5_0.data[arg_5_1] = nil

	return
end

function var_0_1.getCollecitonMail(arg_6_0, arg_6_1)
	if arg_6_0.collectionData[arg_6_1] then
		local var_6_0 = arg_6_0.collectionData[arg_6_1]

		return var_2.clone(var_6_0)
	end

	return
end

function var_0_1.updateCollectionMail(arg_7_0, arg_7_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_7_0 = arg_7_1

	BaseMail = var_1_10005

	var_1_10002(var_1_10003(var_7_0, var_1_10005), "should be an instance of BaseMail")

	arg_7_0.collectionData[arg_7_1.id] = arg_7_1:clone()

	return
end

function var_0_1.removeCollectionMail(arg_8_0, arg_8_1)
	assert = var_1_10002

	var_1_10002(arg_8_0.collectionData[arg_8_1] ~= nil, "mail should exist")

	local var_8_0 = arg_8_0.collectionData

	var_8_0[arg_8_1] = nil
	table = var_8_0

	var_8_0.removebyvalue(arg_8_0.collectionIds, arg_8_1)

	return
end

function var_0_1.DealMailOperation(arg_9_0, arg_9_1, arg_9_2)
	switch = var_1_10003

	var_1_10003(arg_9_2, {
		read = function()
			arg_9_0._existUnreadCount = arg_9_0._existUnreadCount - 1

			if arg_9_0.data[arg_9_1] then
				local var_10_0 = arg_9_0.data[arg_9_1]

				var_0.setReadFlag(var_10_0, true)
			end

			return
		end,
		important = function()
			if arg_9_0.data[arg_9_1] then
				local var_11_0 = arg_9_0.data[arg_9_1]

				var_0.setImportantFlag(var_11_0, true)

				if arg_9_0.importantIds then
					table = var_0

					var_0.dichotomyInsert(arg_9_0.importantIds, arg_9_1)
				end
			end

			return
		end,
		unimportant = function()
			if arg_9_0.data[arg_9_1] then
				local var_12_0 = arg_9_0.data[arg_9_1]

				var_0.setImportantFlag(var_12_0, false)

				if arg_9_0.importantIds then
					table = var_0

					var_0.removebyvalue(arg_9_0.importantIds, arg_9_1)
				end
			end

			return
		end,
		delete = function()
			local var_13_0 = arg_9_0

			var_0.removeMail(var_13_0, arg_9_1)

			return
		end,
		attachment = function()
			if arg_9_0.data[arg_9_1] then
				local var_14_0 = arg_9_0.data[arg_9_1]

				var_0.setAttachFlag(var_14_0, true)

				local var_14_1 = arg_9_0.data[arg_9_1]

				var_0.setReadFlag(var_14_1, true)
			end

			return
		end,
		overflow = function()
			return
		end,
		move = function()
			if arg_9_0.data[arg_9_1] then
				local var_16_0 = arg_9_0.data[arg_9_1]
				local var_16_1 = arg_9_0

				var_1.removeMail(var_16_1, arg_9_1)

				local var_16_2 = arg_9_0

				var_1.updateCollectionMail(var_16_2, var_16_0)

				if arg_9_0.collectionIds then
					table = var_1

					var_1.dichotomyInsert(arg_9_0.collectionIds, arg_9_1)
				end
			end

			return
		end
	})

	return
end

function var_0_1.IsDirty(arg_17_0)
	return arg_17_0.totalExist < arg_17_0.total
end

function var_0_1.GetNewIndex(arg_18_0)
	math = var_1_10001

	local var_18_0 = var_1_10001.min
	local var_18_1 = arg_18_0.total - arg_18_0.totalExist

	SINGLE_MAIL_REQUIRE_SIZE = var_3

	local var_18_2 = var_18_0(var_18_1, var_3)

	return arg_18_0.total - var_18_2 + 1, arg_18_0.total
end

function var_0_1.GetNextIndex(arg_19_0)
	math = var_1_10001

	local var_19_0 = var_1_10001.min
	local var_19_1 = arg_19_0.totalExist - #arg_19_0.ids

	SINGLE_MAIL_REQUIRE_SIZE = var_3

	local var_19_2 = var_19_0(var_19_1, var_3)

	return arg_19_0.totalExist - #arg_19_0.ids - var_19_2 + 1, var_2
end

function var_0_1.AddNewMails(arg_20_0, arg_20_1)
	local var_20_0 = {}
	local var_20_1 = {}

	ipairs = var_1_10004

	for iter_20_0, iter_20_1 in var_1_10004(arg_20_1) do
		arg_20_0:updateMail(iter_20_1)

		if iter_20_1.importantFlag then
			table = var_9

			var_9.insert(var_20_0, iter_20_1.id)
		end

		if iter_20_1:IsRare() then
			table = var_9

			var_9.insert(var_20_1, iter_20_1.id)
		end
	end

	table = var_4

	local var_20_2 = var_4.mergeArray
	local var_20_3 = arg_20_0.ids

	underscore = var_6
	arg_20_0.ids = var_20_2(var_20_3, var_6.map(arg_20_1, function(arg_21_0)
		return arg_21_0.id
	end))

	if #var_20_0 > 0 and arg_20_0.importantIds then
		table = var_4
		arg_20_0.importantIds = var_4.mergeArray(arg_20_0.importantIds, var_20_0)
	end

	if #var_20_1 > 0 and arg_20_0.rareIds then
		table = var_4
		arg_20_0.rareIds = var_4.mergeArray(arg_20_0.rareIds, var_20_1)
	end

	arg_20_0.totalExist = arg_20_0.total

	if arg_20_0.totalExist > 0 then
		arg_20_0.totalExistMailId = arg_20_0.ids[#arg_20_0.ids]
	end

	return
end

function var_0_1.AddNextMails(arg_22_0, arg_22_1)
	ipairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_1) do
		arg_22_0:updateMail(iter_22_1)
	end

	table = var_2

	local var_22_0 = var_2.mergeArray

	underscore = var_3
	arg_22_0.ids = var_22_0(var_3.map(arg_22_1, function(arg_23_0)
		return arg_23_0.id
	end), arg_22_0.ids)

	return
end

function var_0_1.SetImportantMails(arg_24_0, arg_24_1)
	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_1) do
		arg_24_0:updateMail(iter_24_1)
	end

	underscore = var_2
	arg_24_0.importantIds = var_2.map(arg_24_1, function(arg_25_0)
		return arg_25_0.id
	end)

	return
end

function var_0_1.SetRareMails(arg_26_0, arg_26_1)
	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_1) do
		arg_26_0:updateMail(iter_26_1)
	end

	underscore = var_2
	arg_26_0.rareIds = var_2.map(arg_26_1, function(arg_27_0)
		return arg_27_0.id
	end)

	return
end

function var_0_1.AddCollectionMails(arg_28_0, arg_28_1)
	ipairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_1) do
		arg_28_0:updateCollectionMail(iter_28_1)
	end

	table = var_2

	local var_28_0 = var_2.mergeArray
	local var_28_1 = arg_28_0.collectionIds

	underscore = var_4
	arg_28_0.collectionIds = var_28_0(var_28_1, var_4.map(arg_28_1, function(arg_29_0)
		return arg_29_0.id
	end))

	return
end

function var_0_1.GetMails(arg_30_0, arg_30_1)
	underscore = var_1_10002

	return var_1_10002.map(arg_30_1, function(arg_31_0)
		return arg_30_0.data[arg_31_0]
	end)
end

function var_0_1.GetCollectionMails(arg_32_0, arg_32_1)
	underscore = var_1_10002

	return var_1_10002.map(arg_32_1, function(arg_33_0)
		return arg_32_0.collectionData[arg_33_0]
	end)
end

function var_0_1.GetMailsAttachments(arg_34_0, arg_34_1)
	local var_34_0 = {}

	ipairs = var_1_10003

	for iter_34_0, iter_34_1 in var_1_10003(arg_34_1) do
		if not arg_34_0.data[iter_34_1].attachFlag then
			ipairs = var_9

			for iter_34_2, iter_34_3 in var_9(var_8.attachments) do
				table = var_1_10014
				var_1_10014 = var_1_10014.insert

				local var_34_1 = var_34_0

				Clone = var_1_10016

				var_1_10014(var_34_1, var_1_10016(iter_34_3))
			end
		end
	end

	PlayerConst = var_3

	return var_3.MergeSameDrops(var_34_0)
end

function var_0_1.GetUnreadCount(arg_35_0)
	return arg_35_0._existUnreadCount
end

function var_0_1.unpdateUnreadCount(arg_36_0, arg_36_1)
	arg_36_0._existUnreadCount = arg_36_1

	arg_36_0:sendNotification(var_0_1.UPDATE_ATTACHMENT_COUNT)

	return
end

function var_0_1.updateTotal(arg_37_0, arg_37_1)
	arg_37_0.total = arg_37_1

	arg_37_0:sendNotification(var_0_1.MAIL_TOTAL, arg_37_0.total)

	return
end

return var_0_1
