local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveGuildBossTemplate", var_0_0)

function var_0_1.SetOwnerID(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:GetContDataTemplateById():GetSingleTeamData():GetHeroList()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if arg_1_1[iter_1_0] then
			iter_1_1:SetOwnerID(arg_1_1[iter_1_0])
		end
	end
end

function var_0_1.FormatHeroList(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = GuildData:GetAssistantBriefList()
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_3) do
		if iter_2_1:GetHeroType() == 3 then
			local var_2_2 = false
			local var_2_3

			for iter_2_2, iter_2_3 in ipairs(var_2_0) do
				if iter_2_3.member_id == iter_2_1:GetOwnerID() then
					var_2_3 = iter_2_3

					if iter_2_3.assist_hero_id == iter_2_1:GetHeroID() then
						var_2_2 = true

						break
					end
				end
			end

			if var_2_2 and var_2_3 ~= nil then
				table.insert(var_2_1, {
					type = 2,
					info = var_2_3
				})
			end
		elseif iter_2_1:GetHeroType() == 1 then
			table.insert(var_2_1, {
				type = 1,
				heroId = iter_2_1:GetHeroID()
			})
		else
			error("不支持试用角色")
		end
	end

	arg_2_0.heroInfoList_ = var_2_1

	for iter_2_4 = 1, 3 do
		if arg_2_0.heroInfoList_[iter_2_4] ~= nil then
			if arg_2_0.heroInfoList_[iter_2_4].type == 1 then
				arg_2_2.resultHeroList[iter_2_4] = arg_2_0.heroInfoList_[iter_2_4].heroId
			else
				arg_2_2.resultHeroList[iter_2_4] = arg_2_0.heroInfoList_[iter_2_4].info.assist_hero_id
			end
		else
			arg_2_2.resultHeroList[iter_2_4] = 0
		end
	end
end

function var_0_1.GetCurHeroInfoList(arg_3_0)
	return arg_3_0.heroInfoList_ or {}
end

return var_0_1
