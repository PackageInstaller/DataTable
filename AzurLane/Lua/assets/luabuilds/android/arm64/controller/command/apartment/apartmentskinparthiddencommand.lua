local var_0_0 = class("ApartmentSkinPartHiddenCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ApartmentProxy)

	pg.ConnectionMgr.GetInstance():Send(28038, {
		ship_group = var_1_0.groupId,
		skin_id = var_1_0.skinId,
		hidden_parts = var_1_0.partList
	}, 28039, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:ModifyApartment(var_0, function(arg_3_0)
				arg_3_0:SetHiddenParts(var_0, var_0)

				return
			end)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
