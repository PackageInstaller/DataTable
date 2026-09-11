return {
	GetMainUIName = function(arg_1_0)
		if ActivityTools.GetActivityTheme(arg_1_0) == ActivityConst.THEME.HELLA then
			return "UI/VersionUI/HellaUI/HellaTalentUI"
		else
			return "UI/VersionUI/HellaUI/HellaTalentUI"
		end
	end,
	IsCanUp = function(arg_2_0)
		local var_2_0 = TalentTreeCfg[arg_2_0]
		local var_2_1 = TalentTreeData:GetTalentLevel(arg_2_0)

		if var_2_1 < TalentTreeCfg[arg_2_0].max_level then
			return ItemTools.getItemNum(var_2_0.cost[var_2_1 + 1][1]) >= var_2_0.cost[var_2_1 + 1][2]
		end

		return false
	end,
	GetActivityIdByTheme = function(arg_3_0)
		for iter_3_0, iter_3_1 in pairs((ActivityData:GetAllActivityData())) do
			if arg_3_0 == ActivityTools.GetActivityTheme(iter_3_0) and ActivityTemplateConst.TALENT_TREE == ActivityTools.GetActivityType(iter_3_0) then
				return iter_3_0
			end
		end
	end
}
