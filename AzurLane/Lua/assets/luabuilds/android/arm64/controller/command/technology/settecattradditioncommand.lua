class = var_0_10000

local var_0_0 = "SetTecAttrAdditionCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().sendList
	local var_1_1 = var_2.onSuccess
	local var_1_2 = {
		techset_list = var_1_0
	}

	print = var_1_10006

	var_1_10006("64009 Set Attr Addition")

	Application = var_1_10006

	if var_1_10006.isEditor then
		print_r = var_6

		var_6(var_1_0)
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 9, var_1_2, 10, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			TechnologyNationProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)

			var_2_2.initSetableAttrAddition(var_2_0, var_1_0)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			TechnologyConst = var_4

			var_2_2(var_2_1, var_4.SET_TEC_ATTR_ADDITION_FINISH, {
				onSuccess = var_1_1
			})

			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()

			var_2_2 = var_2_2.ShowTips
			i18n = var_4

			var_2_2(var_2_3, var_4("attrset_save_success"))
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_4, "64009 Error Code:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
