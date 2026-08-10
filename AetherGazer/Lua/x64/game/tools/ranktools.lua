return {
	GetRankHeroList = function(arg_1_0, arg_1_1)
		local var_1_0 = {}
		local var_1_1 = {}
		local var_1_2

		if arg_1_1 then
			var_1_2 = ActivityCfg[arg_1_1].activity_template
		end

		if var_1_2 == ActivityTemplateConst.DESTROY_BOX_GAME_RANK then
			local var_1_3 = ActivityCfg.get_id_list_by_sub_activity_list[arg_1_1][1]
			local var_1_4 = DestroyBoxGameCfg.get_id_list_by_activity_id[var_1_3][1]
			local var_1_5 = clone(DestroyBoxGameCfg[var_1_4].trial_hero)

			table.sort(var_1_5, function(arg_2_0, arg_2_1)
				local var_2_0 = RankData:GetActivityRank(arg_1_1, arg_2_0)
				local var_2_1 = var_2_0 and var_2_0.curRank
				local var_2_2 = var_2_1 and var_2_1.score or 0
				local var_2_3 = RankData:GetActivityRank(arg_1_1, arg_2_1)
				local var_2_4 = var_2_3 and var_2_3.curRank
				local var_2_5 = var_2_4 and var_2_4.score or 0

				if var_2_2 ~= var_2_5 then
					print("xxxxxx", arg_2_0, arg_2_1)

					return var_2_5 < var_2_2
				else
					return arg_2_0 < arg_2_1
				end
			end)

			for iter_1_0, iter_1_1 in ipairs(var_1_5) do
				table.insert(var_1_0, HeroStandardSystemCfg[iter_1_1].hero_id)
				table.insert(var_1_1, iter_1_1)
			end
		end

		return var_1_0, var_1_1
	end
}
