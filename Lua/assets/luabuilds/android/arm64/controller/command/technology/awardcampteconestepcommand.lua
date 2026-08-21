local var_0_0 = class("AwardCampTecCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	({}).type = 1

	print("64007 Get TecCamp Award OneStep", 1)
	pg.ConnectionMgr.GetInstance():Send(7, {}, 8, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(TechnologyNationProxy)

			var_2_0:updateTecItemAwardOneStep()
			arg_1_0:sendNotification(TechnologyConst.GOT_TEC_CAMP_AWARD_ONESTEP, {
				awardList = PlayerConst.addTranDrop(arg_2_0.rewards)
			})
			var_2_0:refreshRedPoint()
			arg_1_0:sendNotification(TechnologyConst.UPDATE_REDPOINT_ON_TOP)
		else
			pg.TipsMgr.GetInstance():ShowTips("64007 Error Code:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
