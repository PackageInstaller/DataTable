class = var_0_10000

local var_0_0 = "IslandGetNpcActionAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().npcId
	local var_1_1 = var_2.actionId
	local var_1_2 = var_2.shipId

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 21702, {
		npc_id = var_1_0,
		ship_id = var_1_2,
		action_feedback_id = var_1_1
	}, 21703, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			IslandProxy = var_2_10002

			local var_2_0 = var_2_1(var_2_10002)

			var_2_1 = var_2_1.GetIsland(var_2_0)

			if var_1_0 ~= 0 then
				var_2_10003 = var_2_1

				local var_2_2 = var_2_1.GetNpcFeedbackAgency(var_2_10003)

				var_2.AddNpc(var_2_2, var_1_0)
			end

			var_2_10003 = var_2_1

			local var_2_3 = var_2_1.GetCharacterAgency(var_2_10003)

			if var_2.GetShipById(var_2_3, var_1_2) and var_2_10003:HasGreetingSkill() then
				local var_2_4 = var_2_10003:GetSkill()
				local var_2_5 = var_2_3.CanUse4Ship

				var_2_10007 = var_2_10003

				local var_2_6 = {}

				IslandBuffType = var_2_10009
				var_2_6[1] = var_2_10009.SHIP_POWER_RECOVER_BY_GREETING

				local var_2_11

				if var_2_5(var_2_4, var_2_10007, var_2_6) then
					local var_2_7 = var_2_10003:GetCurrentEnergy()

					var_2_10007 = var_2_10003

					local var_2_8 = var_2_10003.ApplySkill

					IslandBuffType = var_2_6

					var_2_8(var_2_10007, var_2_6.SHIP_POWER_RECOVER_BY_GREETING)

					var_2_10007 = var_2_10003

					local var_2_9 = var_2_10003.GetCurrentEnergy(var_2_10007)
					local var_2_10 = var_2_1

					var_2_10007 = var_2_1.DispatchEvent
					IslandProxy = var_2_11
					var_2_11 = var_2_11.LINK_CORE
					ISLAND_EVT = var_2_10010

					local var_2_12 = var_2_10010.PLAY_EFFECT
					local var_2_13 = var_1_2
					local var_2_14 = {
						value = var_2_9 - var_2_7
					}

					IslandRecEnergyEffect = var_13

					var_2_10007(var_2_10, var_2_11, var_2_12, var_2_13, var_2_14, var_13.TYPE)

					local var_2_15 = var_2

					var_2_10007 = var_2.DispatchEvent
					IslandCharacterAgency = var_2_11

					var_2_10007(var_2_15, var_2_11.SHIP_SKILL_STATE_CHANGE, var_1_2, false)
				end

				local var_2_16 = var_2_3
				local var_2_17 = var_2_3.CanUse4Ship

				var_2_10007 = var_2_10003

				local var_2_18 = {}

				IslandBuffType = var_2_11
				var_2_18[1] = var_2_11.SHIP_AWARD_BY_GREETING

				if var_2_17(var_2_16, var_2_10007, var_2_18) then
					local var_2_19 = var_2_10003
					local var_2_20 = var_2_10003.ApplySkill

					IslandBuffType = var_2_10007

					var_2_20(var_2_19, var_2_10007.SHIP_AWARD_BY_GREETING)

					local var_2_21 = var_2
					local var_2_22 = var_2.DispatchEvent

					IslandCharacterAgency = var_2_10007

					var_2_22(var_2_21, var_2_10007.SHIP_SKILL_STATE_CHANGE, var_1_2, false)
				end
			end

			IslandDropHelper = var_2_3

			local var_2_23 = var_2_3.AddItems(arg_2_0)
			local var_2_24 = arg_1_0
			local var_2_25 = var_5.sendNotification

			GAME = var_2_10007

			var_2_25(var_2_24, var_2_10007.ISLAND_GET_NPC_ACTION_AWARD_DONE, {
				dropData = var_2_23
			})

			IslandTaskHelper = var_2_25

			local var_2_26 = var_2_25.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_2_24

			var_2_26(var_2_24.ACTION_HELLO_DAILY)
		else
			pg = var_2_1

			local var_2_27 = var_2_1.TipsMgr.GetInstance()
			local var_2_28 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_28(var_2_27, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
