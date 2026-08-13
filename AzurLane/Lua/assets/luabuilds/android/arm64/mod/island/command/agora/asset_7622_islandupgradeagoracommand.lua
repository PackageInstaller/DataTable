class = var_0_10000

local var_0_0 = "IslandUpgradeAgoraCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.GetIsland(var_1_1)
	local var_1_3 = var_3.GetAgoraAgency(var_1_2)

	if not var_4.CanUpgrade(var_1_3) then
		pg = var_5

		local var_1_4 = var_5.TipsMgr.GetInstance()
		local var_1_5 = var_5.ShowTips

		i18n = var_1_10008

		var_1_5(var_1_4, var_1_10008("island_agora_max_level"))

		return
	end

	local var_1_6 = var_4:GetUpgradeConsume()
	local var_1_7 = var_3
	local var_1_8 = var_3.GetInventoryAgency(var_1_7)
	local var_1_9 = var_6.GetOwnCount(var_1_8, var_1_6.id)

	if var_1_6 and var_1_9 < var_1_6.count then
		pg = var_1_7

		local var_1_10 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10011

		var_1_7(var_1_10, var_1_10011("common_no_resource"))

		return
	end

	pg = var_1_7

	local var_1_11 = var_1_7.ConnectionMgr.GetInstance()

	var_8.Send(var_1_11, 21305, {
		type = 0
	}, 21306, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.Upgrade(var_2_0)

			pg = var_2_2

			local var_2_1 = var_2_2.GameTrackerMgr.GetInstance()

			var_2_2 = var_2_2.Record
			GameTrackerBuilder = var_2_10004
			var_2_10004 = var_2_10004.BuildIslandAgoraUpgrade

			local var_2_3 = var_0

			var_2_2(var_2_1, var_2_10004(var_6.GetLevel(var_2_3)))

			if var_1_6 then
				local var_2_4 = arg_1_0

				var_2_2 = var_2_2.sendNotification
				GAME = var_2_10004

				var_2_2(var_2_4, var_2_10004.CONSUME_ITEM, var_1_6)
			end
		else
			pg = var_2_2

			local var_2_5 = var_2_2.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_6(var_2_5, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
