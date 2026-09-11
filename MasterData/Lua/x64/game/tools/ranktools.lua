return {
	GetRankHeroList = function(arg_1_0, arg_1_1)
		local var_1_0 = {}
		local var_1_1 = {}

		if ((arg_1_1 or nil) and ActivityCfg[arg_1_1].activity_template) == ActivityTemplateConst.DESTROY_BOX_GAME_RANK then
			local var_1_3 = clone(DestroyBoxGameCfg[DestroyBoxGameCfg.get_id_list_by_activity_id[ActivityCfg.get_id_list_by_sub_activity_list[arg_1_1][1]][1]].trial_hero)

			table.sort(var_1_3, function(arg_2_0, arg_2_1)
				local var_2_0 = RankData:GetActivityRank(arg_1_1, arg_2_0)
				local var_2_1

				if var_2_0 and var_2_0.curRank then
					var_2_1 = (var_2_0 and var_2_0.curRank).score or 0
				end

				local var_2_2 = RankData:GetActivityRank(arg_1_1, arg_2_1)

				if var_2_2 and var_2_2.curRank then
					local var_2_3 = (var_2_2 and var_2_2.curRank).score or 0

					if var_2_1 ~= var_2_3 then
						print("xxxxxx", arg_2_0, arg_2_1)

						do return var_2_3 < var_2_1 end

						goto label_2_0
					end
				end

				do return arg_2_0 < arg_2_1 end

				::label_2_0::
			end)

			for iter_1_0, iter_1_1 in ipairs(var_1_3) do
				table.insert(var_1_0, HeroStandardSystemCfg[iter_1_1].hero_id)
				table.insert(var_1_1, iter_1_1)
			end
		end

		return var_1_0, var_1_1
	end
}
