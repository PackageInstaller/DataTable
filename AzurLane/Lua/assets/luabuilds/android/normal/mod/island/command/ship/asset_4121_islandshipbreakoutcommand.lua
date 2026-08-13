class = var_0_10000

local var_0_0 = "IslandShipBreakOutCommand"

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

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 21601, {
		ship_id = var_1_0
	}, 21602, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			IslandProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)
			local var_2_1 = var_2_2.GetIsland(var_2_0)

			var_2_2 = var_2_2.GetInventoryAgency(var_2_1)
			var_2_10003 = var_0

			local var_2_3 = var_2.GetBreakoutMatrials(var_2_10003)

			ipairs = var_2_10003

			for iter_2_0, iter_2_1 in var_2_10003(var_2_3) do
				var_2_10009 = var_2_2

				var_2_2.RemoveItem(var_2_10009, iter_2_1.id, iter_2_1.count)
			end

			Clone = var_2_10003

			local var_2_4 = var_2_10003(var_0)
			local var_2_5 = var_2_10003.GetSkill(var_2_4)
			local var_2_6 = var_4.IsUnlock(var_2_5)
			local var_2_7 = var_0

			var_5.UpgradeBreakOut(var_2_7)

			local var_2_8 = var_0
			local var_2_9 = var_5.GetSkill(var_2_8)
			local var_2_10 = var_5.IsUnlock(var_2_9)

			if not var_2_6 and var_2_10 then
				local var_2_11 = var_0
				local var_2_12 = var_7.GetGlobalBuffAgency(var_2_11)

				var_7.OnShipSkillUnlock(var_2_12, var_1_0)

				getProxy = var_7
				IslandProxy = var_2_12

				local var_2_13 = var_7(var_2_12)
				local var_2_14 = var_7.GetIsland(var_2_13)

				var_2_10009 = var_7.GetCharacterAgency(var_2_14)

				local var_2_15 = var_7.DispatchEvent

				IslandCharacterAgency = var_2_10010

				var_2_15(var_2_10009, var_2_10010.SHIP_SKILL_STATE_CHANGE, var_0.id, true)
			end

			local var_2_16 = arg_1_0
			local var_2_17 = var_7.sendNotification

			GAME = var_2_10009

			var_2_17(var_2_16, var_2_10009.ISLAND_SHIP_BREAKOUT_DONE, {
				newShip = var_0,
				oldShip = var_2_10003,
				isUnlockSkill = var_6
			})

			IslandBookHelper = var_2_17

			var_2_17.OnShipUpgradeOrBreakOut(var_1_0)

			pg = var_7

			local var_2_18 = var_7.GameTrackerMgr.GetInstance()
			local var_2_19 = var_7.Record

			GameTrackerBuilder = var_9

			local var_2_20 = var_9.BuildIslandShipBreakout
			local var_2_21 = var_1_0
			local var_2_22 = var_0

			var_2_19(var_2_18, var_2_20(var_2_21, var_11.GetBreakLevel(var_2_22)))
		else
			pg = var_2_2

			local var_2_23 = var_2_2.TipsMgr.GetInstance()
			local var_2_24 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_24(var_2_23, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
