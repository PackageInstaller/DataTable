local var_0_0 = {}

function var_0_0.LevelToExp(arg_1_0, arg_1_1)
	if arg_1_1 == nil then
		return 0
	end

	if var_0_0.levelToExp == nil then
		var_0_0.levelToExp = {}
	end

	if var_0_0.levelToExp[arg_1_1] == nil then
		var_0_0.levelToExp[arg_1_1] = {}

		local var_1_0 = 0

		for iter_1_0, iter_1_1 in ipairs(GameLevelSetting) do
			var_0_0.levelToExp[arg_1_1][iter_1_0] = var_1_0
			var_1_0 = var_1_0 + iter_1_1[arg_1_1]
		end
	end

	return var_0_0.levelToExp[arg_1_1][arg_1_0]
end

function var_0_0.CheckExp(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == nil then
		return 1, 0, 0
	elseif arg_2_2 == "user_level_exp" then
		return var_0_0.CheckUserExp(arg_2_0, arg_2_1)
	end
end

function var_0_0.CheckHeroExp(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0
	local var_3_1 = arg_3_1
	local var_3_2 = 0
	local var_3_3 = arg_3_0
	local var_3_4 = 0

	for iter_3_0 = 1, math.min(GameLevelSetting[#GameLevelSetting.all].id, arg_3_2) do
		local var_3_5 = GameLevelSetting[iter_3_0].hero_level_exp1

		if iter_3_0 < arg_3_0 then
			var_3_0 = var_3_0 + var_3_5
			var_3_1 = var_3_1 - var_3_5
		elseif var_3_5 <= var_3_1 then
			var_3_1 = var_3_1 - var_3_5
			var_3_2 = var_3_5

			if var_3_3 < arg_3_2 then
				var_3_0 = var_3_0 + var_3_5
				var_3_3 = var_3_3 + 1
			else
				var_3_4 = var_3_1 + var_3_5
				var_3_2 = 0

				break
			end
		else
			if arg_3_2 <= var_3_3 then
				var_3_4 = var_3_1
				var_3_2 = 0

				break
			end

			var_3_0 = var_3_0 + var_3_1
			var_3_2 = var_3_1

			break
		end
	end

	return var_3_3, var_3_2, var_3_1, var_3_0, var_3_4
end

function var_0_0.CheckUserExp(arg_4_0, arg_4_1)
	local var_4_0 = "user_level_exp"
	local var_4_1 = GameLevelSetting[arg_4_0]
	local var_4_2 = GameLevelSetting[arg_4_0 + 1]

	if var_4_1 == nil or var_4_2 == nil or var_4_2[var_4_0] == 0 or var_0_0.GetIsCurrentMaxLv(arg_4_0, var_4_0) then
		return arg_4_0, arg_4_1, 0
	end

	local var_4_3 = var_4_1[var_4_0]

	if var_4_3 <= arg_4_1 then
		return var_0_0.CheckUserExp(arg_4_0 + 1, arg_4_1 - var_4_3)
	else
		return arg_4_0, arg_4_1, 0
	end
end

function var_0_0.GetIsCurrentMaxLv(arg_5_0, arg_5_1)
	if arg_5_1 == "hero_level_exp1" then
		return arg_5_0 >= PlayerData:GetPlayerInfo().userLevel
	end

	return GameLevelSetting[arg_5_0 + 1] == nil
end

function var_0_0.GetIsMaxLv(arg_6_0, arg_6_1)
	local var_6_0 = GameSetting[arg_6_1 .. "_level_max"]

	if not var_6_0 then
		print("GameSetting存在未知的记录:", arg_6_1 .. "_level_max")

		return true
	end

	return arg_6_0 >= var_6_0.value[1]
end

function var_0_0.GetMaxTotalExp(arg_7_0, arg_7_1)
	local var_7_0 = 1

	if arg_7_0 == "hero_level_exp1" then
		var_7_0 = GameSetting.hero_level_max.value[1]
	elseif arg_7_0 == "user_level_exp" then
		var_7_0 = GameSetting.user_level_max.value[1]
	end

	return var_0_0.LevelToExp(var_7_0, arg_7_0)
end

function var_0_0.LoveExpToLevel(arg_8_0)
	local var_8_0 = 0

	for iter_8_0 = 1, HeroConst.HERO_LOVE_LV_MAX + 1 do
		local var_8_1 = GameLevelSetting[iter_8_0].hero_love_exp

		var_8_0 = var_8_0 + var_8_1

		if var_8_1 == 0 then
			return iter_8_0, 0, var_8_0
		end

		if arg_8_0 > var_8_1 - 1 then
			arg_8_0 = arg_8_0 - var_8_1
		else
			return iter_8_0, arg_8_0, var_8_0
		end
	end
end

function var_0_0.checkLoveExp(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0 + arg_9_1
	local var_9_1, var_9_2 = var_0_0.LevelToExp(var_9_0)

	return var_9_1, var_9_2
end

return var_0_0
