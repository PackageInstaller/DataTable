local ChapterChampionSubmarine = class("ChapterChampionSubmarine", import(".ChapterChampionNormal"))

function ChapterChampionSubmarine:Ctor(arg_1_1)
	ChapterChampionSubmarine.super.Ctor(arg_1_1)

	return
end

function ChapterChampionSubmarine:bindConfigTable()
	return pg.expedition_data_template
end

function ChapterChampionSubmarine:getPrefab()
	return self:getConfig("icon")
end

function ChapterChampionSubmarine:getFleetType()
	return FleetType.Submarine
end

function ChapterChampionSubmarine:getPoolType()
	return "tpl_enemy"
end

function ChapterChampionSubmarine:getScale()
	return self:getConfig("scale")
end

function ChapterChampionSubmarine:inAlertRange(arg_7_1, arg_7_2)
	return _.any(self:getConfig("alert_range"), function(arg_8_0)
		return arg_8_0[1] + self.row == arg_7_1 and arg_8_0[2] + self.column == arg_7_2
	end)
end

return ChapterChampionSubmarine
