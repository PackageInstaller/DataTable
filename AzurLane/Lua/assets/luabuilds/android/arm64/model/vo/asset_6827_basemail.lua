class = var_0_10000

local var_0_0 = "BaseMail"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.ATTACHMENT_UNTAKEN = 1
var_0_1.ATTACHMENT_TAKEN = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.date = arg_1_1.date
	unpack = var_2
	string = var_1_10004

	local var_1_0 = var_1_10004.split

	HXSet = var_1_10006
	arg_1_0.title, arg_1_0.sender = var_2(var_1_0(var_1_10006.hxLan(arg_1_1.title), "||"))

	if arg_1_0.sender then
		string = var_1_1

		local var_1_1 = var_1_1.gsub
		local var_1_2

		if not arg_1_0.sender then
			var_1_2 = ""
		end

		if not var_1_1(var_1_2, "{ship_statistics:(%d+).-}", function(arg_2_0)
			pg = var_2_10001

			local var_2_0 = var_2_10001.ship_data_statistics

			tonumber = var_2_10002

			return var_2_0[var_2_10002(arg_2_0)].name
		end) then
			i18n = var_1_1
			var_1_1 = var_1_1("mail_sender_default")
		end

		arg_1_0.sender = var_1_1
		string = var_1_1

		local var_1_3 = var_1_1.gsub

		HXSet = var_1_2
		arg_1_0.content = var_1_3(var_1_2.hxLan(arg_1_1.content), "\\n", "\n")
		arg_1_0.attachments = {}
		ipairs = var_2

		for iter_1_0, iter_1_1 in var_2(arg_1_1.attachment_list) do
			table = var_1_4

			local var_1_4 = var_1_4.insert
			local var_1_5 = arg_1_0.attachments

			Drop = var_1_10010

			var_1_4(var_1_5, var_1_10010.New({
				type = iter_1_1.type,
				id = iter_1_1.id,
				count = iter_1_1.number
			}))
		end

		return
	end
end

local var_0_2

function var_0_1.IsRare(arg_3_0)
	if not var_0_2 then
		var_0_2 = {}
		ipairs = var_1

		local var_3_0 = {}

		PlayerConst = var_1_10004
		var_3_0[1] = var_1_10004.ResGold
		PlayerConst = var_4
		var_3_0[2] = var_4.ResOil
		PlayerConst = var_4
		var_3_0[3] = var_4.ResExploit

		for iter_3_0, iter_3_1 in var_1(var_3_0) do
			table = var_1_10006
			var_1_10006 = var_1_10006.insert

			local var_3_1 = var_0_2

			Drop = var_1_10009
			var_1_10009 = var_1_10009.New

			local var_3_2 = {}

			DROP_TYPE_RESOURCE = var_1_10012
			var_3_2.type = var_1_10012
			var_3_2.id = iter_3_1

			var_1_10006(var_3_1, var_1_10009(var_3_2))
		end

		table = var_1

		local var_3_3 = var_1.insert
		local var_3_4 = var_0_2

		Drop = iter_3_0

		local var_3_5 = iter_3_0.New
		local var_3_6 = {}

		DROP_TYPE_ITEM = var_1_10007
		var_3_6.type = var_1_10007
		ITEM_ID_CUBE = var_1_10007
		var_3_6.id = var_1_10007

		var_3_3(var_3_4, var_3_5(var_3_6))
	end

	local var_3_7

	if #arg_3_0.attachments > 0 then
		underscore = var_1
		var_3_7 = var_1.any(arg_3_0.attachments, function(arg_4_0)
			ipairs = var_2_10001

			for iter_4_0, iter_4_1 in var_2_10001(var_0_2) do
				if arg_4_0.type == iter_4_1.type and arg_4_0.id == iter_4_1.id then
					return false
				end
			end

			return true
		end)
	else
		var_3_7 = false
	end

	if false then
		var_3_7 = true
	end

	return var_3_7
end

function var_0_1.IsMatchKey(arg_5_0, arg_5_1)
	if not arg_5_1 or arg_5_1 == "" then
		return true
	end

	string = var_1_10002

	local var_5_0 = var_1_10002.lower

	string = var_1_10004
	arg_5_1 = var_5_0(var_1_10004.gsub(arg_5_1, "%.", "%%."))
	string = var_2

	local var_5_1 = var_2.lower

	string = var_4
	arg_5_1 = var_5_1(var_4.gsub(arg_5_1, "%-", "%%-"))
	underscore = var_2

	return var_2.any({
		arg_5_0.title,
		arg_5_0.sender,
		arg_5_0.content
	}, function(arg_6_0)
		string = var_2_10001

		local var_6_0 = var_2_10001.find

		string = var_2_10003

		return var_6_0(var_2_10003.lower(arg_6_0), arg_5_1)
	end)
end

return var_0_1
