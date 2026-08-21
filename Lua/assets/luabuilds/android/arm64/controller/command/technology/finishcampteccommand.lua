local var_0_0 = class("FinishCampTecCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.levelID

	pg.ConnectionMgr.GetInstance():Send(3, {
		tech_group_id = var_1_0.tecID
	}, 4, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(TechnologyNationProxy)

			var_2_0:updateTecItem(var_0, var_1_1, 0, 0)
			var_2_0:setTimer()
			var_2_0:calculateTecBuff()
			arg_1_0:sendNotification(TechnologyConst.FINISH_TEC_SUCCESS, var_0)
			var_2_0:refreshRedPoint()
			arg_1_0:sendNotification(TechnologyConst.UPDATE_REDPOINT_ON_TOP)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("coloring_cell", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
