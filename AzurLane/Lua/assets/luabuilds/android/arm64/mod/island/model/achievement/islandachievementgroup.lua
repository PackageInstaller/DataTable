class = var_0_10000

local var_0_0 = var_0_10000("IslandAchievementGroup")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.groupId = arg_1_1
	arg_1_0.achvDic = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_2) do
		local var_1_0 = arg_1_0.achvDic

		IslandAchievement = var_1_10009
		var_1_0[iter_1_1] = var_1_10009.New(iter_1_1)
	end

	return
end

function var_0_0.GetSortAchvList(arg_2_0)
	underscore = var_1_10001

	local var_2_0 = var_1_10001.values(arg_2_0.achvDic)

	table = var_1_10002

	local var_2_1 = var_1_10002.sort
	local var_2_2 = var_2_0

	CompareFuncs = var_1_10005

	var_2_1(var_2_2, var_1_10005({
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
	local var_5_0 = arg_5_0.achvDic[arg_5_1]
	local var_5_1 = var_2.SetStatus

	IslandAchievement = var_1_10005

	var_5_1(var_5_0, var_1_10005.STATUS.GOT)

	return
end

return var_0_0
