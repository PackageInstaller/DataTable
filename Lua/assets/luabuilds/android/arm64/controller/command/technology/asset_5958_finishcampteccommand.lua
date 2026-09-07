local FinishCampTecCommand = class("FinishCampTecCommand", pm.SimpleCommand)

function FinishCampTecCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.tecID
	local var_1_2 = var_1_0.levelID

	pg.ConnectionMgr.GetInstance():Send(3, {
		tech_group_id = var_1_0.tecID
	}, 4, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(TechnologyNationProxy)

			var_2_0:updateTecItem(var_1_1, var_1_2, 0, 0)
			var_2_0:setTimer()
			var_2_0:calculateTecBuff()
			self:sendNotification(TechnologyConst.FINISH_TEC_SUCCESS, var_1_1)
			var_2_0:refreshRedPoint()
			self:sendNotification(TechnologyConst.UPDATE_REDPOINT_ON_TOP)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("coloring_cell", arg_2_0.result))
		end

		return
	end)

	return
end

return FinishCampTecCommand
