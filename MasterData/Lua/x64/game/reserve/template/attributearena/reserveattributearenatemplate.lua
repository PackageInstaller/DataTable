local ReserveAbyssTemplate = class("ReserveAbyssTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveAbyssTemplate:GetLockHero(arg_1_1, arg_1_2)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs((ActivityAttributeArenaData:GetArenaList(arg_1_1.customData.activityID))) do
		if iter_1_1.score > 0 then
			for iter_1_2, iter_1_3 in ipairs((self:GetContDataTemplateById(iter_1_1.id):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX))) do
				if iter_1_3:GetHeroID() ~= 0 then
					var_1_0[#var_1_0 + 1] = iter_1_3:GetHeroID()
				end
			end
		end
	end

	arg_1_2.lockHeroList = var_1_0
end

function ReserveAbyssTemplate:GetTrialHeroList(arg_2_1)
	return AttributeArenaTools.GetTrialHeroList(arg_2_1.customData.attribute_arena_id)
end

function ReserveAbyssTemplate:GetArenaHeroList(arg_3_1)
	local var_3_0 = {
		0,
		0,
		0
	}
	local var_3_1 = {
		0,
		0,
		0
	}

	for iter_3_0, iter_3_1 in ipairs((self:GetContDataTemplateById(arg_3_1):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX))) do
		var_3_0[iter_3_0] = iter_3_1:GetHeroID()
		var_3_1[iter_3_0] = iter_3_1:GetTrialID()
	end

	return var_3_0, var_3_1
end

return ReserveAbyssTemplate
