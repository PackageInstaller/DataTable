local var_0_0 = class("MetaPTAwardGetCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(MetaCharacterProxy)
	local var_1_1 = arg_1_1:getBody()

	print("34003 meta pt award send:", var_1_1.groupID, var_1_1.targetCount)
	pg.ConnectionMgr.GetInstance():Send(34003, {
		group_id = var_1_1.groupID,
		target_pt = var_1_1.targetCount
	}, 34004, function(arg_2_0)
		print("34004 meta pt award done:", arg_2_0.result)

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_0:getMetaProgressVOByID(var_1_1.groupID)

			var_2_0:updatePTLevel((table.indexof(var_2_0.metaPtData.targets, var_1_1.targetCount)))
			arg_1_0:sendNotification(GAME.GET_META_PT_AWARD_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.drop_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(34004 + " : " + arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
