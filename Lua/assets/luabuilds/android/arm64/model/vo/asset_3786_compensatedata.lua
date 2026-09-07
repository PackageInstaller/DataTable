local CompensateData = class("CompensateData", import(".BaseVO"))

function CompensateData:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.date = arg_1_1.send_time
	self.timestamp = arg_1_1.timestamp
	self.title, self.sender = unpack(string.split(HXSet.hxLan(arg_1_1.title), "||"))
	self.sender = self.sender or i18n("mail_sender_default")
	self.text = string.gsub(HXSet.hxLan(arg_1_1.text), "\\n", "\n")
	self.attachments = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.attachment_list) do
		table.insert(self.attachments, Drop.New({
			type = iter_1_1.type,
			id = iter_1_1.id,
			count = iter_1_1.number
		}))
	end

	self.attachFlag = arg_1_1.attach_flag ~= 0

	return
end

function CompensateData:setAttachFlag(arg_2_1)
	self.attachFlag = arg_2_1

	return
end

function CompensateData:isEnd()
	local var_3_0

	if self.timestamp > 0 then
		if pg.TimeMgr.GetInstance():GetServerTime() < self.timestamp then
			var_3_0 = false

			goto label_3_0
		end
	end

	::label_3_0::

	return true
end

return CompensateData
