local var_0_0 = import("game.views.newHero.NewHeroListFilterView")
local var_0_1 = class("NewGuildBossAssistHeroFilterView", var_0_0)

function var_0_1.SetHeroIdList(arg_1_0, arg_1_1)
	arg_1_0.heroDataList_ = arg_1_1
	arg_1_0.displayHeroDataList_ = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		if not HeroTools.NeedToHideHero(iter_1_1.assist_hero_id, HeroConst.HERO_DATA_TYPE.FOREIGN) then
			table.insert(arg_1_0.displayHeroDataList_, iter_1_1)
		end
	end

	arg_1_0:RefreshSort()
end

function var_0_1.UpdateList(arg_2_0)
	local var_2_0 = GameSetting.unlock_hero_need.value

	table.sort(arg_2_0.displayHeroDataList_, function(arg_3_0, arg_3_1)
		local var_3_0 = false
		local var_3_1 = false

		if arg_2_0.extraSorter_ ~= nil then
			local var_3_2, var_3_3 = arg_2_0.extraSorter_(arg_3_0, arg_3_1)
			local var_3_4 = var_3_3

			if var_3_2 then
				return var_3_4
			end
		end

		local var_3_5 = arg_3_0
		local var_3_6 = arg_3_1

		if arg_2_0.curSortType_ == 0 then
			local var_3_7, var_3_8 = arg_2_0:FightPowerSorter(var_3_5, var_3_6)
			local var_3_9 = var_3_8

			if var_3_7 then
				return var_3_9
			end

			local var_3_10, var_3_11 = arg_2_0:RareSorter(var_3_5, var_3_6)
			local var_3_12 = var_3_11

			if var_3_10 then
				return var_3_12
			end

			local var_3_13, var_3_14 = arg_2_0:LevelSorter(var_3_5, var_3_6)
			local var_3_15 = var_3_14

			if var_3_13 then
				return var_3_15
			end
		else
			local var_3_16, var_3_17 = arg_2_0:RareSorter(var_3_5, var_3_6)
			local var_3_18 = var_3_17

			if var_3_16 then
				return var_3_18
			end

			local var_3_19, var_3_20 = arg_2_0:FightPowerSorter(var_3_5, var_3_6)
			local var_3_21 = var_3_20

			if var_3_19 then
				return var_3_21
			end

			local var_3_22, var_3_23 = arg_2_0:LevelSorter(var_3_5, var_3_6)
			local var_3_24 = var_3_23

			if var_3_22 then
				return var_3_24
			end
		end

		if arg_3_0.assist_hero_id ~= arg_3_1.assist_hero_id then
			return arg_3_0.assist_hero_id > arg_3_1.assist_hero_id
		end

		return tonumber(arg_3_0.member_id) > tonumber(arg_3_1.member_id)
	end)

	if arg_2_0.callback_ ~= nil then
		arg_2_0.callback_(arg_2_0.displayHeroDataList_)
	end
end

function var_0_1.FightPowerSorter(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.fight_capacity
	local var_4_1 = arg_4_2.fight_capacity

	if var_4_0 ~= var_4_1 then
		if arg_4_0.curOrder_ == "desc" then
			return true, var_4_1 < var_4_0
		else
			return true, var_4_0 < var_4_1
		end
	end

	return false, false
end

function var_0_1.RareSorter(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = HeroCfg[arg_5_1.assist_hero_id]
	local var_5_1 = HeroCfg[arg_5_2.assist_hero_id]

	if var_5_0.rare ~= var_5_1.rare then
		if arg_5_0.curOrder_ == "desc" then
			return true, var_5_0.rare > var_5_1.rare
		else
			return true, var_5_0.rare < var_5_1.rare
		end
	end

	return false, false
end

function var_0_1.RefreshSort(arg_6_0, arg_6_1)
	if not arg_6_0.available_ then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.heroDataList_) do
		iter_6_1.id = iter_6_1.assist_hero_id
		iter_6_1.type = HeroConst.HERO_DATA_TYPE.FOREIGN
	end

	arg_6_0:UpdateList()
	arg_6_0:RenderFilterBtn()
end

return var_0_1
