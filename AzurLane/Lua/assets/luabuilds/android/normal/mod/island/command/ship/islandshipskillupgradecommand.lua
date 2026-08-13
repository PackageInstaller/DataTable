class = var_0_10000

local var_0_0 = "IslandShipSkillUpgradeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetCharacterAgency(var_1_2)

	if not var_5.GetShipById(var_1_3, var_1_0) then
		return
	end

	if not var_6:CanUpgradeSkill() then
		return
	end

	pg = var_7

	local var_1_4 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 21611, {
		ship_id = var_1_0
	}, 21612, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_10003 = var_1.GetSkill(var_2_0)

			local var_2_1 = var_1.GetUpgradeMaterial(var_2_10003)
			local var_2_2 = var_1

			var_1.Upgrade(var_2_2)

			getProxy = var_2_10003
			IslandProxy = var_2_2

			local var_2_3 = var_2_10003(var_2_2)
			local var_2_4 = var_2_10003.GetIsland(var_2_3)

			var_2_10003 = var_2_10003.GetInventoryAgency(var_2_4)
			ipairs = var_2_4

			for iter_2_0, iter_2_1 in var_2_4(var_2_1) do
				var_2_10003:RemoveItem(iter_2_1.id, iter_2_1.count)
			end

			IslandAchievementHelper = var_4

			var_4.OnShipSkillUpgrade(var_1:GetLevel())

			local var_2_5 = var_0
			local var_2_6 = var_4.GetGlobalBuffAgency(var_2_5)

			var_4.OnShipSkillUpgrade(var_2_6, var_1_0)

			local var_2_7 = arg_1_0
			local var_2_8 = var_4.sendNotification

			GAME = var_6

			var_2_8(var_2_7, var_6.ISLAND_SHIP_SKILL_UPGRADE_DONE)

			pg = var_2_8

			local var_2_9 = var_2_8.GameTrackerMgr.GetInstance()
			local var_2_10 = var_4.Record

			GameTrackerBuilder = var_6

			var_2_10(var_2_9, var_6.BuildIslandShipSkillUpgrade(var_0.id, var_1.id, var_1:GetLevel()))
		else
			pg = var_1

			local var_2_11 = var_1.TipsMgr.GetInstance()
			local var_2_12 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_12(var_2_11, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
