local var_0_0 = class("BaseMail", import(".BaseVO"))

var_0_0.ATTACHMENT_UNTAKEN = 1
var_0_0.ATTACHMENT_TAKEN = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.date = arg_1_1.date
	arg_1_0.title, arg_1_0.sender = unpack(string.split(HXSet.hxLan(arg_1_1.title), "||"))

	if arg_1_0.sender then
		local var_1_0 = arg_1_0.sender or ""

		arg_1_0.sender = string.gsub(var_1_0, "{ship_statistics:(%d+).-}", function(arg_2_0)
			return pg.ship_data_statistics[tonumber(arg_2_0)].name
		end) or i18n("mail_sender_default")
		arg_1_0.content = string.gsub(HXSet.hxLan(arg_1_1.content), "\\n", "\n")
		arg_1_0.attachments = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.attachment_list) do
			table.insert(arg_1_0.attachments, Drop.New({
				type = iter_1_1.type,
				id = iter_1_1.id,
				count = iter_1_1.number
			}))
		end

		return
	end
end

local var_0_1

function var_0_0.IsRare(arg_3_0)
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

	return #arg_3_0.attachments > 0 and underscore.any(arg_3_0.attachments, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(var_0_1) do
			if arg_4_0.type == iter_4_1.type and arg_4_0.id == iter_4_1.id then
				return false
			end
		end

		return true
	end)
end

function var_0_0.IsMatchKey(arg_5_0, arg_5_1)
	if not arg_5_1 or arg_5_1 == "" then
		return true
	end

	arg_5_1 = string.lower(string.gsub(arg_5_1, "%.", "%%."))
	arg_5_1 = string.lower(string.gsub(arg_5_1, "%-", "%%-"))

	return underscore.any({
		arg_5_0.title,
		arg_5_0.sender,
		arg_5_0.content
	}, function(arg_6_0)
		return string.find(string.lower(arg_6_0), arg_5_1)
	end)
end

return var_0_0
