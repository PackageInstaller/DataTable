local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveAbyssTemplate", var_0_0)

function var_0_1.GetLockHero(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.customData.activityID
	local var_1_1 = {}
	local var_1_2 = ActivityAttributeArenaData:GetArenaList(var_1_0)

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		if iter_1_1.score > 0 then
			local var_1_3 = arg_1_0:GetContDataTemplateById(iter_1_1.id):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX)

			for iter_1_2, iter_1_3 in ipairs(var_1_3) do
				if iter_1_3:GetHeroID() ~= 0 then
					var_1_1[#var_1_1 + 1] = iter_1_3:GetHeroID()
				end
			end
		end
	end

	arg_1_2.lockHeroList = var_1_1
end

function var_0_1.GetTrialHeroList(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.customData.attribute_arena_id

	return AttributeArenaTools.GetTrialHeroList(var_2_0)
end

function var_0_1.GetArenaHeroList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:GetContDataTemplateById(arg_3_1):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX)
	local var_3_1 = {
		0,
		0,
		0
	}
	local var_3_2 = {
		0,
		0,
		0
	}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		var_3_1[iter_3_0] = iter_3_1:GetHeroID()
		var_3_2[iter_3_0] = iter_3_1:GetTrialID()
	end

	return var_3_1, var_3_2
end

return var_0_1
