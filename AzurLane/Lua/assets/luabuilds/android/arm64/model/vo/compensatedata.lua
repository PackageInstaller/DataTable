class = var_0_10000

local var_0_0 = "CompensateData"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.date = arg_1_1.send_time
	arg_1_0.timestamp = arg_1_1.timestamp
	unpack = var_2
	string = var_1_10004

	local var_1_0 = var_1_10004.split

	HXSet = var_1_10006
	arg_1_0.title, arg_1_0.sender = var_2(var_1_0(var_1_10006.hxLan(arg_1_1.title), "||"))

	local var_1_1

	if not arg_1_0.sender then
		i18n = var_1_1
		var_1_1 = var_1_1("mail_sender_default")
	end

	arg_1_0.sender = var_1_1
	string = var_1_1

	local var_1_2 = var_1_1.gsub

	HXSet = var_4
	arg_1_0.text = var_1_2(var_4.hxLan(arg_1_1.text), "\\n", "\n")
	arg_1_0.attachments = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.attachment_list) do
		table = var_1_3

		local var_1_3 = var_1_3.insert
		local var_1_4 = arg_1_0.attachments

		Drop = var_1_10010

		var_1_3(var_1_4, var_1_10010.New({
			type = iter_1_1.type,
			id = iter_1_1.id,
			count = iter_1_1.number
		}))
	end

	arg_1_0.attachFlag = arg_1_1.attach_flag ~= 0

	return
end

function var_0_1.setAttachFlag(arg_2_0, arg_2_1)
	arg_2_0.attachFlag = arg_2_1

	return
end

function var_0_1.isEnd(arg_3_0)
	if arg_3_0.timestamp > 0 then
		pg = var_1

		local var_3_0 = var_1.TimeMgr.GetInstance()
		local var_3_1

		if not (var_1.GetServerTime(var_3_0) >= arg_3_0.timestamp) then
			var_3_1 = false
		else
			var_3_1 = true
		end

		return var_3_1
	end
end

return var_0_1
