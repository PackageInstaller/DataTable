local var_0_0 = class("EducateAddExtraAttrCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(27039, {
		attr_id = var_1_0.id
	}, 27040, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(EducateProxy):AddExtraAttr(var_1_0.id)
			arg_1_0:sendNotification(GAME.EDUCATE_ADD_EXTRA_ATTR_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate add extra attr error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
