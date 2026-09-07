local IslandAchievement = class("IslandAchievement", import("model.vo.BaseVO"))

IslandAchievement.STATUS = {
	GET = "get",
	NORMAL = "noraml",
	GOT = "got"
}

function IslandAchievement:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id

	return
end

function IslandAchievement:bindConfigTable()
	return pg.island_achievement
end

function IslandAchievement:SetStatus(arg_3_1)
	self.status = arg_3_1

	return
end

function IslandAchievement:GetStatus()
	return self.status
end

function IslandAchievement:GetStage()
	return self:getConfig("stage")
end

function IslandAchievement:IsHideType()
	return self:getConfig("show_type") == 2
end

function IslandAchievement:GetType()
	return self:getConfig("target_type")
end

function IslandAchievement:GetParam()
	return self:getConfig("target_value1")
end

function IslandAchievement:GetNum()
	return self:getConfig("target_num")
end

function IslandAchievement:GetAwards()
	local var_10_0 = self:getConfig("award_display")

	if var_10_0 == "" then
		return {}
	end

	return underscore.map(var_10_0, function(arg_11_0)
		return Drop.Create(arg_11_0)
	end)
end

function IslandAchievement:GetIcon()
	local var_12_0 = pg.island_achievement[self].group
	local var_12_1 = pg.island_achievement_group

	return pg.island_achievement_group[underscore.detect(pg.island_achievement_group.all, function(arg_13_0)
		return table.contains(var_12_1[arg_13_0].achievement_list, var_12_0)
	end)].icon
end

return IslandAchievement
