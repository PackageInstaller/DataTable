return {
	CheckRelationUpgradeCondition = function(arg_1_0, arg_1_1)
		if not HeroRelationUpgradeConditionCfg[arg_1_0] then
			return false
		end

		if HeroRelationUpgradeConditionCfg[arg_1_0].type == 1 then
			for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
				local var_1_0 = HeroData:GetHeroData(iter_1_1)

				if var_1_0.level >= HeroRelationUpgradeConditionCfg[arg_1_0].arg[1] and var_1_0.unlock == 1 then
					return true
				end
			end

			return false
		elseif HeroRelationUpgradeConditionCfg[arg_1_0].type == 2 then
			for iter_1_2, iter_1_3 in ipairs(arg_1_1) do
				local var_1_1 = HeroData:GetHeroData(iter_1_3)
				local var_1_2 = 0

				if var_1_1.unlock == 1 then
					for iter_1_4, iter_1_5 in ipairs(var_1_1.skill) do
						var_1_2 = SkillTools.GetIsDodgeSkill(iter_1_5.skill_id) and var_1_2 + 1 or var_1_2 + HeroTools.GetTotalSkillLv(iter_1_3, iter_1_5.skill_id)
					end

					if var_1_2 >= HeroRelationUpgradeConditionCfg[arg_1_0].arg[1] then
						return true
					end
				end
			end

			return false
		elseif HeroRelationUpgradeConditionCfg[arg_1_0].type == 3 then
			for iter_1_6, iter_1_7 in ipairs(arg_1_1) do
				local var_1_3 = HeroData:GetHeroData(iter_1_7)

				if var_1_3.weapon_info.level >= HeroRelationUpgradeConditionCfg[arg_1_0].arg[1] and var_1_3.unlock == 1 then
					return true
				end
			end

			return false
		elseif HeroRelationUpgradeConditionCfg[arg_1_0].type == 4 then
			for iter_1_8, iter_1_9 in ipairs(arg_1_1) do
				local var_1_4 = HeroData:GetHeroData(iter_1_9)

				if var_1_4.star >= HeroRelationUpgradeConditionCfg[arg_1_0].arg[1] and var_1_4.unlock == 1 then
					return true
				end
			end

			return false
		elseif HeroRelationUpgradeConditionCfg[arg_1_0].type == 5 then
			for iter_1_10, iter_1_11 in ipairs(arg_1_1) do
				if HeroTools.GetHeroProficiency(iter_1_11) >= HeroRelationUpgradeConditionCfg[arg_1_0].arg[1] then
					return true
				end
			end

			return false
		elseif HeroRelationUpgradeConditionCfg[arg_1_0].type == 6 then
			for iter_1_12, iter_1_13 in ipairs(arg_1_1) do
				local var_1_5 = HeroData:GetHeroData(iter_1_13)

				if var_1_5 and var_1_5.unlock == 1 then
					local var_1_6 = 0

					for iter_1_14, iter_1_15 in ipairs(var_1_5.transition) do
						var_1_6 = var_1_6 + iter_1_15.talent_points
					end

					if var_1_6 >= HeroRelationUpgradeConditionCfg[arg_1_0].arg[1] then
						return true
					end
				end
			end
		else
			return false
		end
	end,
	GetRelationUpgradeConditionDes = function(arg_2_0)
		if not HeroRelationUpgradeConditionCfg[arg_2_0] then
			return ""
		end

		if HeroRelationUpgradeConditionCfg[arg_2_0].type == 1 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_1", HeroRelationUpgradeConditionCfg[arg_2_0].arg[1])
		elseif HeroRelationUpgradeConditionCfg[arg_2_0].type == 2 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_2", HeroRelationUpgradeConditionCfg[arg_2_0].arg[1])
		elseif HeroRelationUpgradeConditionCfg[arg_2_0].type == 3 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_3", HeroRelationUpgradeConditionCfg[arg_2_0].arg[1])
		elseif HeroRelationUpgradeConditionCfg[arg_2_0].type == 4 then
			local var_2_0 = HeroRelationUpgradeConditionCfg[arg_2_0].arg[1]

			if HeroRelationUpgradeConditionCfg[arg_2_0].arg[1] == 100 then
				var_2_0 = "B"
			elseif HeroRelationUpgradeConditionCfg[arg_2_0].arg[1] == 200 then
				var_2_0 = "A"
			elseif HeroRelationUpgradeConditionCfg[arg_2_0].arg[1] == 300 then
				var_2_0 = "S"
			elseif HeroRelationUpgradeConditionCfg[arg_2_0].arg[1] == 400 then
				var_2_0 = "SS"
			elseif HeroRelationUpgradeConditionCfg[arg_2_0].arg[1] == 500 then
				var_2_0 = "SSS"
			elseif HeroRelationUpgradeConditionCfg[arg_2_0].arg[1] == 600 then
				var_2_0 = "Ω"
			end

			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_4", var_2_0)
		elseif HeroRelationUpgradeConditionCfg[arg_2_0].type == 5 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_5", HeroRelationUpgradeConditionCfg[arg_2_0].arg[1])
		elseif HeroRelationUpgradeConditionCfg[arg_2_0].type == 6 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_6", HeroRelationUpgradeConditionCfg[arg_2_0].arg[1])
		else
			return ""
		end
	end,
	GetTrustLvDes = function(arg_3_0)
		return GetTips("HERO_TRUST_LEVEL_DES_" .. arg_3_0)
	end,
	GetLikeLvDes = function(arg_4_0)
		return GetTips("HERO_LIKE_LEVEL_DES_" .. arg_4_0)
	end,
	GetRelationConfig = function(arg_5_0, arg_5_1)
		for iter_5_0, iter_5_1 in ipairs(HeroRelationCfg.get_id_list_by_main_hero_id[arg_5_0]) do
			if arg_5_1 == HeroRelationCfg[iter_5_1].relate_hero_id then
				return HeroRelationCfg[iter_5_1]
			end
		end

		return nil
	end,
	CheckWallPaperIsUnlock = function(self)
		if self.type == 1 then
			return HeroData:GetHeroData(self.id).unlock == 1
		elseif self.type == 2 then
			return HeroTools.GetHasOwnedSkin(self.id)
		elseif self.type == 3 then
			return IllustratedData:GetIllustrationInfo()[self.id] ~= nil
		end
	end,
	NeedShowArchivePop = function()
		if manager.time:IsToday(getData("archivePop", "cache") or 0) then
			return false, 0, 0
		end

		local var_7_0 = HeroData:GetHeroList()

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if #HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[iter_7_1.id][1]].super_plot_id > 0 then
				local var_7_3 = ArchiveData:GetHasViewedSuperHeartList(HeroRecordCfg.get_id_list_by_hero_id[iter_7_1.id][1])
				local var_7_4, var_7_5, var_7_6 = IsConditionAchieved(GameSetting.hero_super_plot_unlock_condition.value[2], {
					heroId = iter_7_1.id
				})

				if var_7_4 and #var_7_3 < 2 and not getData("archivePop", "popInfo" .. HeroRecordCfg.get_id_list_by_hero_id[iter_7_1.id][1] .. 2) then
					return true, iter_7_1.id, 2
				end
			end
		end

		for iter_7_2, iter_7_3 in pairs(var_7_0) do
			if #HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[iter_7_3.id][1]].plot_id > 0 then
				local var_7_7 = ArchiveData:GetHasViewedHeartList(HeroRecordCfg.get_id_list_by_hero_id[iter_7_3.id][1])
				local var_7_8 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[iter_7_3.id][1]).lv

				if var_7_8 == 5 and #var_7_7 < var_7_8 - 1 and not getData("archivePop", "popInfo" .. HeroRecordCfg.get_id_list_by_hero_id[iter_7_3.id][1] .. 1) then
					return true, iter_7_3.id, 1
				end
			end
		end

		return false, 0, 0
	end
}
