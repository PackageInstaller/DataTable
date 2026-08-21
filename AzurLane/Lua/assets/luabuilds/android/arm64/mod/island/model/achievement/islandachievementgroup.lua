local var_0_0 = class("IslandAchievementGroup")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.groupId = arg_1_1
	arg_1_0.achvDic = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		arg_1_0.achvDic[iter_1_1] = IslandAchievement.New(iter_1_1)
	end

	return
end

function var_0_0.GetSortAchvList(arg_2_0)
	local var_2_0 = underscore.values(arg_2_0.achvDic)

	table.sort(var_2_0, CompareFuncs({
		function(arg_3_0)
			return arg_3_0:GetStage()
		end
	}))

	return var_2_0
end

function var_0_0.GetAchvById(arg_4_0, arg_4_1)
	return arg_4_0.achvDic[arg_4_1]
end

function var_0_0.SetGotTagById(arg_5_0, arg_5_1)
	arg_5_0.achvDic[arg_5_1]:SetStatus(IslandAchievement.STATUS.GOT)

	return
end

return var_0_0
