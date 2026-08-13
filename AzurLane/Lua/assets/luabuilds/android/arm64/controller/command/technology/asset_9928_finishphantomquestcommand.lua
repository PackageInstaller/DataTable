class = var_0_10000

local var_0_0 = "FinishPhantomQuestCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().bluePrintId
	local var_1_1 = var_2.questId

	getProxy = var_1_10005
	TechnologyProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.getBluePrintById(var_1_2, var_1_0)

	if var_5.getPhantomQuestInfo(var_1_3, var_1_1).unlocked or var_6.progress < var_6.config.target_num then
		return
	end

	pg = var_7

	local var_1_4 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 12210, {
		ship_id = var_5.shipId,
		skin_shadow_id = var_1_1
	}, 12211, function(arg_2_0)
		ShipBluePrint = var_2_10001

		if var_2_10001.getPhantomQuestCostDrop(var_0) then
			reducePlayerOwn = var_2_10002

			var_2_10002(var_1)
		end

		getProxy = var_2_10002
		BayProxy = var_2_10004

		local var_2_0 = var_2_10002(var_2_10004)

		var_2.updateShipSkin(var_2_0, var_0.shipId, var_1_1, 0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_2.sendNotification

		GAME = var_5

		var_2_2(var_2_1, var_5.FINISH_PHANTOM_QUEST_DONE)

		return
	end)

	return
end

return var_0_1
