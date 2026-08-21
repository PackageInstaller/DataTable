local var_0_0 = class("AwardCampTecCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	print("64005 Get TecCamp Award", var_1_0.groupID, var_1_0.tecID)
	pg.ConnectionMgr.GetInstance():Send(5, {
		group_id = var_1_0.groupID,
		tech_id = var_1_0.tecID
	}, 6, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(TechnologyNationProxy)

			var_2_0:updateTecItemAward(var_0, var_0)
			arg_1_0:sendNotification(TechnologyConst.GOT_TEC_CAMP_AWARD, {
				awardList = PlayerConst.addTranDrop(arg_2_0.rewards),
				groupID = var_0,
				tecID = var_0
			})
			var_2_0:refreshRedPoint()
			arg_1_0:sendNotification(TechnologyConst.UPDATE_REDPOINT_ON_TOP)
		else
			pg.TipsMgr.GetInstance():ShowTips("64005 Error Code:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
