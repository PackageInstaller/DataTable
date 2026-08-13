class = var_0_10000

local var_0_0 = "ApartmentSkinPartHiddenCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.skinId
	local var_1_2 = var_2.partList

	getProxy = var_1_10006
	ApartmentProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 28038, {
		ship_group = var_1_0,
		skin_id = var_1_1,
		hidden_parts = var_1_2
	}, 28039, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3

			var_1.ModifyApartment(var_2_0, var_1_0, function(arg_3_0)
				arg_3_0:SetHiddenParts(var_1_1, var_1_2)

				return
			end)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_2(var_2_1, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
