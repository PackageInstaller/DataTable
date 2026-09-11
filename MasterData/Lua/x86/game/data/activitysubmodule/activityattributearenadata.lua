local var_0_0 = singletonClass("ActivityAttributeArenaData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_3 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.arena_list) do
		local var_2_1 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.team_list) do
			table.insert(var_2_1, {
				hero_id = iter_2_3.hero_id,
				hero_type = iter_2_3.hero_type
			})
		end

		table.insert(var_2_0, {
			index = iter_2_1.index,
			id = iter_2_1.id,
			score = iter_2_1.score,
			team_list = var_2_1
		})
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0.index < arg_3_1.index
	end)

	var_0_1[arg_2_1.activity_id] = var_2_0
	var_0_2[arg_2_1.activity_id] = arg_2_1.rounds
end

function var_0_0.ResetData(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(var_0_1[arg_4_1] or {}) do
		if arg_4_2 == iter_4_1.id then
			iter_4_1.score = 0
			iter_4_1.team_list = {}

			break
		end
	end
end

function var_0_0.GetArenaList(arg_5_0, arg_5_1)
	return var_0_1[arg_5_1] or {}
end

function var_0_0.GetArenaScore(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(var_0_1[arg_6_1] or {}) do
		if arg_6_2 == iter_6_1.id then
			return iter_6_1.score
		end
	end

	return 0
end

function var_0_0.GetLockHero(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(var_0_1[arg_7_1] or {}) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1.team_list) do
			if iter_7_3.hero_type == 2 then
				table.insert(var_7_0, HeroStandardSystemCfg[iter_7_3.hero_id].hero_id)
			else
				table.insert(var_7_0, iter_7_3.hero_id)
			end
		end
	end

	return var_7_0
end

function var_0_0.GetRound(arg_8_0, arg_8_1)
	return var_0_2[arg_8_1] or 0
end

function var_0_0.SetRead(arg_9_0, arg_9_1)
	local var_9_0 = var_0_2[arg_9_1] or 0

	var_0_3[arg_9_1] = var_9_0

	saveData("ActivityAttributeArena", tostring(arg_9_1), var_9_0)
end

function var_0_0.GetRead(arg_10_0, arg_10_1)
	if not var_0_3[arg_10_1] then
		local var_10_0 = getData("ActivityAttributeArena", tostring(arg_10_1))

		var_0_3[arg_10_1] = type(var_10_0) ~= "number" and 0 or var_10_0
	end

	if (var_0_2[arg_10_1] or 0) == var_0_3[arg_10_1] then
		return true
	else
		return false
	end
end

return var_0_0
