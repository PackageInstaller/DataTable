local NewGuildBossAssistHeroFilterView = class("NewGuildBossAssistHeroFilterView", (import("game.views.newHero.NewHeroListFilterView")))

function NewGuildBossAssistHeroFilterView:SetHeroIdList(arg_1_1)
	self.heroDataList_ = arg_1_1
	self.displayHeroDataList_ = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		if not HeroTools.NeedToHideHero(iter_1_1.assist_hero_id, HeroConst.HERO_DATA_TYPE.FOREIGN) then
			table.insert(self.displayHeroDataList_, iter_1_1)
		end
	end

	self:RefreshSort()
end

function NewGuildBossAssistHeroFilterView:UpdateList()
	table.sort(self.displayHeroDataList_, function(arg_3_0, arg_3_1)
		if self.extraSorter_ ~= nil then
			local var_3_2, var_3_3 = self.extraSorter_(arg_3_0, arg_3_1)

			if var_3_2 then
				return var_3_3
			end
		end

		local var_3_4 = arg_3_0

		if self.curSortType_ == 0 then
			local var_3_5, var_3_6 = self:FightPowerSorter(var_3_4, arg_3_1)

			if var_3_5 then
				return var_3_6
			end

			local var_3_7, var_3_8 = self:RareSorter(var_3_4, arg_3_1)

			if var_3_7 then
				return var_3_8
			end

			local var_3_9, var_3_10 = self:LevelSorter(var_3_4, arg_3_1)

			if var_3_9 then
				return var_3_10
			end
		else
			local var_3_11, var_3_12 = self:RareSorter(var_3_4, arg_3_1)

			if var_3_11 then
				return var_3_12
			end

			local var_3_13, var_3_14 = self:FightPowerSorter(var_3_4, arg_3_1)

			if var_3_13 then
				return var_3_14
			end

			local var_3_15, var_3_16 = self:LevelSorter(var_3_4, arg_3_1)

			if var_3_15 then
				return var_3_16
			end
		end

		if arg_3_0.assist_hero_id ~= arg_3_1.assist_hero_id then
			return arg_3_0.assist_hero_id > arg_3_1.assist_hero_id
		end

		return tonumber(arg_3_0.member_id) > tonumber(arg_3_1.member_id)
	end)

	if self.callback_ ~= nil then
		self.callback_(self.displayHeroDataList_)
	end
end

function NewGuildBossAssistHeroFilterView:FightPowerSorter(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2.fight_capacity

	if arg_4_1.fight_capacity ~= arg_4_2.fight_capacity then
		if self.curOrder_ == "desc" then
			return true, var_4_0 < arg_4_1.fight_capacity
		else
			return true, arg_4_1.fight_capacity < var_4_0
		end
	end

	return false, false
end

function NewGuildBossAssistHeroFilterView:RareSorter(arg_5_1, arg_5_2)
	local var_5_0 = HeroCfg[arg_5_1.assist_hero_id]
	local var_5_1 = HeroCfg[arg_5_2.assist_hero_id]

	if HeroCfg[arg_5_1.assist_hero_id].rare ~= HeroCfg[arg_5_2.assist_hero_id].rare then
		if self.curOrder_ == "desc" then
			return true, var_5_0.rare > var_5_1.rare
		else
			return true, var_5_0.rare < var_5_1.rare
		end
	end

	return false, false
end

function NewGuildBossAssistHeroFilterView:RefreshSort(arg_6_1)
	if not self.available_ then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(self.heroDataList_) do
		iter_6_1.id = iter_6_1.assist_hero_id
		iter_6_1.type = HeroConst.HERO_DATA_TYPE.FOREIGN
	end

	self:UpdateList()
	self:RenderFilterBtn()
end

return NewGuildBossAssistHeroFilterView
