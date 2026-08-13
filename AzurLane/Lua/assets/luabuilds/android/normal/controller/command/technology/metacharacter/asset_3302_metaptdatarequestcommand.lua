class = var_0_10000

local var_0_0 = "MetaPTDataRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	MetaCharacterProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)
	local var_1_1 = arg_1_1:getBody()
	local var_1_2 = {}

	if var_1_1.isAll then
		local var_1_3 = var_1_0

		var_1_10006 = var_1_0.getMetaProgressVOList(var_1_3)
		ipairs = var_1_3

		for iter_1_0, iter_1_1 in var_1_3(var_1_10006) do
			if iter_1_1:isPtType() and (iter_1_1:isInAct() or iter_1_1:isInArchive()) then
				table = var_12

				var_12.insert(var_1_2, iter_1_1.id)
			end
		end
	end

	print = var_1_10006

	local var_1_4 = "34001 meta pt request:"

	table = var_1_10008

	var_1_10006(var_1_4, var_1_10008.concat(var_1_2, ","))

	pg = var_1_10006

	local var_1_5 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 34001, {
		group_id = var_1_2
	}, 34002, function(arg_2_0)
		print = var_2_10001

		var_2_10001("34002 meta pt request done:", #var_1_2)

		local var_2_0 = var_1_0

		var_1.setAllProgressPTData(var_2_0, arg_2_0.meta_ship_list)

		return
	end)

	return
end

return var_0_1
