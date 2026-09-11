local HeroSorter = class("HeroSorter")
local var_0_1 = {}
local var_0_2 = false

function HeroSorter:Reset()
	var_0_2 = false
	var_0_1 = {}
end

function HeroSorter:SetUnlockFirst(arg_2_1)
	var_0_2 = arg_2_1

	return HeroSorter
end

function HeroSorter:SortWithId(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(var_3_0, iter_3_1)
	end

	table.sort(var_3_0, handler(self, self.SortRule))
	self:Reset()

	return var_3_0
end

function HeroSorter:SortRule(arg_4_1, arg_4_2)
	local var_4_0 = HeroData:GetHeroList()[arg_4_1]
	local var_4_1 = HeroData:GetHeroList()[arg_4_2]

	if var_0_2 then
		if (var_4_0.unlock == 1 and 1 or 0) ~= (var_4_1.unlock == 1 and 1 or 0) then
			return (var_4_1.unlock == 1 and 1 or 0) < (var_4_0.unlock == 1 and 1 or 0)
		end
	end

	local var_4_3 = HeroCfg[arg_4_1]
	local var_4_4 = HeroCfg[arg_4_2]
	local var_4_5 = self:GetSortWeight(var_4_0)
	local var_4_6 = self:GetSortWeight(var_4_1)
	local var_4_7 = self:GetHeroPower(var_4_0)
	local var_4_8 = self:GetHeroPower(var_4_1)

	if var_4_5 ~= var_4_6 then
		return var_4_6 < var_4_5
	elseif var_4_7 ~= var_4_8 then
		return var_4_8 < var_4_7
	elseif var_4_3.rare ~= var_4_4.rare then
		return var_4_3.rare > var_4_4.rare
	else
		return arg_4_2 < arg_4_1
	end
end

function HeroSorter:GetHeroPower(arg_5_1, arg_5_2)
	if var_0_1[arg_5_1.id] then
		return var_0_1[arg_5_1.id]
	end

	local var_5_0 = arg_5_2 and arg_5_2(arg_5_1.id) or getBattlePower(arg_5_1)

	var_0_1[arg_5_1.id] = var_5_0

	return var_5_0
end

function HeroSorter:GetSortWeight(arg_6_1)
	local var_6_0 = 0

	if arg_6_1.hero_unlock == 1 or arg_6_1.unlock == 1 then
		var_6_0 = var_6_0 + 100
	end

	if (arg_6_1.hero_unlock == 0 or arg_6_1.unlock == 0) and arg_6_1.piece and arg_6_1.piece >= GameSetting.unlock_hero_need.value[HeroCfg[arg_6_1.id].rare] then
		var_6_0 = var_6_0 + 10
	end

	return var_6_0
end

return HeroSorter
