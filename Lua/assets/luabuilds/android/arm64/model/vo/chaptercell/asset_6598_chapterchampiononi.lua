local ChapterChampionOni = class("ChapterChampionOni", import(".LevelCellData"))

function ChapterChampionOni:Ctor(arg_1_1)
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

function ChapterChampionOni:bindConfigTable()
	return pg.specialunit_template
end

function ChapterChampionOni:getPrefab()
	return self:getConfig("prefab")
end

function ChapterChampionOni:getFleetType()
	return FleetType.Normal
end

function ChapterChampionOni:getPoolType()
	return ChapterConst.TemplateOni
end

function ChapterChampionOni:getScale()
	return 200
end

function ChapterChampionOni:inAlertRange(arg_7_1, arg_7_2)
	return _.any(self:getConfig("alert_range"), function(arg_8_0)
		return arg_8_0[1] + self.row == arg_7_1 and arg_8_0[2] + self.column == arg_7_2
	end)
end

return ChapterChampionOni
