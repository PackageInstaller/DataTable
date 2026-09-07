local IslandAchievementGroup = class("IslandAchievementGroup")

function IslandAchievementGroup:Ctor(arg_1_1, arg_1_2)
	self.groupId = arg_1_1
	self.achvDic = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		self.achvDic[iter_1_1] = IslandAchievement.New(iter_1_1)
	end

	return
end

function IslandAchievementGroup:GetSortAchvList()
	local var_2_0 = underscore.values(self.achvDic)

	table.sort(var_2_0, CompareFuncs({
		function(arg_3_0)
			return arg_3_0:GetStage()
		end
	}))

	return var_2_0
end

function IslandAchievementGroup:GetAchvById(arg_4_1)
	return self.achvDic[arg_4_1]
end

function IslandAchievementGroup:SetGotTagById(arg_5_1)
	self.achvDic[arg_5_1]:SetStatus(IslandAchievement.STATUS.GOT)

	return
end

return IslandAchievementGroup
