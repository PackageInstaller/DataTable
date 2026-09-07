local SetTecAttrAdditionCommand = class("SetTecAttrAdditionCommand", pm.SimpleCommand)

function SetTecAttrAdditionCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.sendList
	local var_1_2 = var_1_0.onSuccess

	print("64009 Set Attr Addition")

	if Application.isEditor then
		print_r(var_1_0.sendList)
	end

	pg.ConnectionMgr.GetInstance():Send(9, {
		techset_list = var_1_0.sendList
	}, 10, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(TechnologyNationProxy):initSetableAttrAddition(var_1_1)
			self:sendNotification(TechnologyConst.SET_TEC_ATTR_ADDITION_FINISH, {
				onSuccess = var_1_2
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("attrset_save_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips("64009 Error Code:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return SetTecAttrAdditionCommand
