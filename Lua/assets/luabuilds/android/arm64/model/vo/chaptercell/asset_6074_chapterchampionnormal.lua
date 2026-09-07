local ChapterChampionNormal = class("ChapterChampionNormal", import(".LevelCellData"))

function ChapterChampionNormal:Ctor(arg_1_1)
	self.row = arg_1_1.pos.row
	self.column = arg_1_1.pos.column
	self.id = arg_1_1.id
	self.configId = self.id
	self.attachmentId = self.id
	self.attachment = arg_1_1.attachment
	self.flag = arg_1_1.flag
	self.data = arg_1_1.data

	return
end

function ChapterChampionNormal:bindConfigTable()
	return pg.expedition_data_template
end

function ChapterChampionNormal:getPrefab()
	return self:getConfig("icon")
end

function ChapterChampionNormal:getFleetType()
	return FleetType.Normal
end

function ChapterChampionNormal:getPoolType()
	return (self:getConfig("icon_type") == 1 or nil) and (ChapterConst.TemplateEnemy or ChapterConst.TemplateChampion)
end

function ChapterChampionNormal:getScale()
	return self:getConfig("scale")
end

function ChapterChampionNormal:inAlertRange(arg_7_1, arg_7_2)
	return _.any(self:getConfig("alert_range"), function(arg_8_0)
		return arg_8_0[1] + self.row == arg_7_1 and arg_8_0[2] + self.column == arg_7_2
	end)
end

return ChapterChampionNormal
