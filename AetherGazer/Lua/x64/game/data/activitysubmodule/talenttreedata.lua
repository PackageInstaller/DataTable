local var_0_0 = singletonClass("TalentTreeData")

talentList_ = {}

function var_0_0.InitData(arg_1_0)
	talentList_ = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		talentList_[iter_2_1.id] = iter_2_1.level
	end
end

function var_0_0.UpTalent(arg_3_0, arg_3_1)
	talentList_[arg_3_1] = (talentList_[arg_3_1] or 0) + 1
end

function var_0_0.GetTalentList(arg_4_0)
	return talentList_
end

function var_0_0.GetTalentLevel(arg_5_0, arg_5_1)
	return talentList_[arg_5_1] or 0
end

function var_0_0.GetTalentListByTheme(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(talentList_) do
		local var_6_1 = TalentTreeCfg[iter_6_0]

		if ActivityTools.GetActivityTheme(var_6_1.activity_id) == arg_6_1 then
			table.insert(var_6_0, {
				var_6_1.affix_id,
				iter_6_1,
				var_6_1.affix_user
			})
		end
	end

	return var_6_0
end

return var_0_0
