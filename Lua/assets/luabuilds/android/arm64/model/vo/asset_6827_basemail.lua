local BaseMail = class("BaseMail", import(".BaseVO"))

BaseMail.ATTACHMENT_UNTAKEN = 1
BaseMail.ATTACHMENT_TAKEN = 2

function BaseMail:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.date = arg_1_1.date
	self.title, self.sender = unpack(string.split(HXSet.hxLan(arg_1_1.title), "||"))

	if self.sender then
		self.sender = string.gsub(self.sender or "", "{ship_statistics:(%d+).-}", function(arg_2_0)
			return pg.ship_data_statistics[tonumber(arg_2_0)].name
		end) or i18n("mail_sender_default")
	end

	self.content = string.gsub(HXSet.hxLan(arg_1_1.content), "\\n", "\n")
	self.attachments = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.attachment_list) do
		table.insert(self.attachments, Drop.New({
			type = iter_1_1.type,
			id = iter_1_1.id,
			count = iter_1_1.number
		}))
	end

	return
end

local var_0_1

function BaseMail:IsRare()
	if not var_0_1 then
		var_0_1 = {}

		for iter_3_0, iter_3_1 in ipairs({
			PlayerConst.ResGold,
			PlayerConst.ResOil,
			PlayerConst.ResExploit
		}) do
			table.insert(var_0_1, Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = iter_3_1
			}))
		end

		table.insert(var_0_1, Drop.New({
			type = DROP_TYPE_ITEM,
			id = ITEM_ID_CUBE
		}))
	end

	return #self.attachments > 0 and underscore.any(self.attachments, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(var_0_1) do
			if arg_4_0.type == iter_4_1.type and arg_4_0.id == iter_4_1.id then
				return false
			end
		end

		return true
	end)
end

function BaseMail:IsMatchKey(arg_5_1)
	if not arg_5_1 or arg_5_1 == "" then
		return true
	end

	arg_5_1 = string.lower(string.gsub(arg_5_1, "%.", "%%."))
	arg_5_1 = string.lower(string.gsub(arg_5_1, "%-", "%%-"))

	return underscore.any({
		self.title,
		self.sender,
		self.content
	}, function(arg_6_0)
		return string.find(string.lower(arg_6_0), arg_5_1)
	end)
end

return BaseMail
