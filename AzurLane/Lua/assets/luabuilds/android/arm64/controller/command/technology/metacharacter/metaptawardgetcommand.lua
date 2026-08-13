class = var_0_10000

local var_0_0 = "MetaPTAwardGetCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	MetaCharacterProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = arg_1_1:getBody()
	local var_1_2 = {
		group_id = var_1_1.groupID,
		target_pt = var_1_1.targetCount
	}

	print = var_5

	var_5("34003 meta pt award send:", var_1_1.groupID, var_1_1.targetCount)

	pg = var_5

	local var_1_3 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 34003, var_1_2, 34004, function(arg_2_0)
		print = var_2_10001

		var_2_10001("34004 meta pt award done:", arg_2_0.result)

		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.drop_list)

			local var_2_1 = var_1_0
			local var_2_2 = var_2.getMetaProgressVOByID(var_2_1, var_1_1.groupID).metaPtData.targets

			table = var_2_1

			local var_2_3 = var_2_1.indexof(var_2_2, var_1_1.targetCount)

			var_2:updatePTLevel(var_2_3)

			local var_2_4 = arg_1_0
			local var_2_5 = var_5.sendNotification

			GAME = var_8

			var_2_5(var_2_4, var_8.GET_META_PT_AWARD_DONE, {
				awards = var_2_0
			})
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_6, 34004 + " : " + arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
