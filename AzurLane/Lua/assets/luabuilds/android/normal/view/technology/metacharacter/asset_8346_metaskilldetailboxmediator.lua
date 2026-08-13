class = var_0_10000

local var_0_0 = "MetaSkillDetailBoxMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.TACTICS_META_UNLOCK_SKILL_DONE
	GAME = var_2
	var_2_0[2] = var_2.TACTICS_META_SWITCH_SKILL_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	GAME = var_3_1

	if var_3_0 ~= var_3_1.TACTICS_META_UNLOCK_SKILL_DONE then
		GAME = var_4

		if var_3_0 == var_4.TACTICS_META_SWITCH_SKILL_DONE then
			GAME = var_4

			if var_3_0 == var_4.TACTICS_META_SWITCH_SKILL_DONE and arg_3_0.contextData.expInfoList and #var_4 > 0 then
				local var_3_3 = arg_3_0.contextData.metaShipID
				local var_3_4

				ipairs = var_1_10007

				for iter_3_0, iter_3_1 in var_1_10007(var_4) do
					if iter_3_1.shipID == var_3_3 and iter_3_1.isUpLevel and iter_3_1.isMaxLevel then
						var_3_4 = iter_3_0
					end
				end

				if var_3_4 then
					var_4[var_3_4].isUpLevel = false
					var_4[var_3_4].isMaxLevel = false
				end
			end

			local var_3_5 = arg_3_0.viewComponent

			var_4.updateSkillList(var_3_5)
		end

		return
	end
end

return var_0_1
