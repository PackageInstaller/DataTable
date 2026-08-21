local var_0_0 = class("IslandGetNpcActionAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21702, {
		npc_id = var_1_0.npcId,
		ship_id = var_1_0.shipId,
		action_feedback_id = var_1_0.actionId
	}, 21703, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland()

			if var_0 ~= 0 then
				var_2_0:GetNpcFeedbackAgency():AddNpc(var_0)
			end

			local var_2_1 = var_2_0:GetCharacterAgency()
			local var_2_2 = var_2_1:GetShipById(var_0)

			if var_2_2 and var_2_2:HasGreetingSkill() then
				local var_2_3 = var_2_2:GetSkill()

				if var_2_3:CanUse4Ship(var_2_2, {
					IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING
				}) then
					var_2_2:ApplySkill(IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING)
					var_2_0:DispatchEvent(IslandProxy.LINK_CORE, ISLAND_EVT.PLAY_EFFECT, var_0, {
						value = var_2_2:GetCurrentEnergy() - var_2_2:GetCurrentEnergy()
					}, IslandRecEnergyEffect.TYPE)
					var_2_1:DispatchEvent(IslandCharacterAgency.SHIP_SKILL_STATE_CHANGE, var_0, false)
				end

				if var_2_3:CanUse4Ship(var_2_2, {
					IslandBuffType.SHIP_AWARD_BY_GREETING
				}) then
					var_2_2:ApplySkill(IslandBuffType.SHIP_AWARD_BY_GREETING)
					var_2_1:DispatchEvent(IslandCharacterAgency.SHIP_SKILL_STATE_CHANGE, var_0, false)
				end
			end

			;({}).dropData = IslandDropHelper.AddItems(arg_2_0)

			arg_1_0:sendNotification(GAME.ISLAND_GET_NPC_ACTION_AWARD_DONE, {})
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.ACTION_HELLO_DAILY)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
