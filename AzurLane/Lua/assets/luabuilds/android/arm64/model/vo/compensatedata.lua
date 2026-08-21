local var_0_0 = class("CompensateData", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.date = arg_1_1.send_time
	arg_1_0.timestamp = arg_1_1.timestamp
	arg_1_0.title, arg_1_0.sender = unpack(string.split(HXSet.hxLan(arg_1_1.title), "||"))
	arg_1_0.sender = arg_1_0.sender or i18n("mail_sender_default")
	arg_1_0.text = string.gsub(HXSet.hxLan(arg_1_1.text), "\\n", "\n")
	arg_1_0.attachments = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.attachment_list) do
		table.insert(arg_1_0.attachments, Drop.New({
			type = iter_1_1.type,
			id = iter_1_1.id,
			count = iter_1_1.number
		}))
	end

	arg_1_0.attachFlag = arg_1_1.attach_flag ~= 0

	return
end

function var_0_0.setAttachFlag(arg_2_0, arg_2_1)
	arg_2_0.attachFlag = arg_2_1

	return
end

function var_0_0.isEnd(arg_3_0)
	if arg_3_0.timestamp > 0 then
		local var_3_0 = pg.TimeMgr.GetInstance():GetServerTime() >= arg_3_0.timestamp

		return var_3_0
	end
end

return var_0_0
