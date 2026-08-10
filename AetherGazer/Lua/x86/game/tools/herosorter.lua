local var_0_0 = class("HeroSorter")
local var_0_1 = {}
local var_0_2 = false

function var_0_0.Reset(arg_1_0)
	var_0_2 = false
	var_0_1 = {}
end

function var_0_0.SetUnlockFirst(arg_2_0, arg_2_1)
	var_0_2 = arg_2_1

	return var_0_0
end

function var_0_0.SortWithId(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(var_3_0, iter_3_1)
	end

	table.sort(var_3_0, handler(arg_3_0, arg_3_0.SortRule))
	arg_3_0:Reset()

	return var_3_0
end

function var_0_0.SortRule(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = HeroData:GetHeroList()[arg_4_1]
	local var_4_1 = HeroData:GetHeroList()[arg_4_2]

	if var_0_2 then
		local var_4_2 = var_4_0.unlock == 1 and 1 or 0
		local var_4_3 = var_4_1.unlock == 1 and 1 or 0

		if var_4_2 ~= var_4_3 then
			return var_4_3 < var_4_2
		end
	end

	local var_4_4 = HeroCfg[arg_4_1]
	local var_4_5 = HeroCfg[arg_4_2]
	local var_4_6 = arg_4_0:GetSortWeight(var_4_0)
	local var_4_7 = arg_4_0:GetSortWeight(var_4_1)
	local var_4_8 = arg_4_0:GetHeroPower(var_4_0)
	local var_4_9 = arg_4_0:GetHeroPower(var_4_1)

	if var_4_6 ~= var_4_7 then
		return var_4_7 < var_4_6
	elseif var_4_8 ~= var_4_9 then
		return var_4_9 < var_4_8
	elseif var_4_4.rare ~= var_4_5.rare then
		return var_4_4.rare > var_4_5.rare
	else
		return arg_4_2 < arg_4_1
	end
end

function var_0_0.GetHeroPower(arg_5_0, arg_5_1, arg_5_2)
	if var_0_1[arg_5_1.id] then
		return var_0_1[arg_5_1.id]
	end

	local var_5_0

	if arg_5_2 then
		var_5_0 = arg_5_2(arg_5_1.id)
	else
		var_5_0 = getBattlePower(arg_5_1)
	end

	var_0_1[arg_5_1.id] = var_5_0

	return var_5_0
end

function var_0_0.GetSortWeight(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = HeroCfg[arg_6_1.id]

	if arg_6_1.hero_unlock == 1 or arg_6_1.unlock == 1 then
		var_6_0 = var_6_0 + 100
	end

	if (arg_6_1.hero_unlock == 0 or arg_6_1.unlock == 0) and arg_6_1.piece and arg_6_1.piece >= GameSetting.unlock_hero_need.value[var_6_1.rare] then
		var_6_0 = var_6_0 + 10
	end

	return var_6_0
end

return var_0_0
