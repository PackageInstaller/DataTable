local WorldEntrance = class("WorldEntrance", import("...BaseEntity"))

WorldEntrance.Fields = {
	config = "table",
	marks = "table",
	transportDic = "table",
	world = "table",
	id = "number",
	becomeSairen = "boolean",
	active = "boolean"
}
WorldEntrance.Listeners = {}
WorldEntrance.EventUpdateMapIndex = "WorldEntrance.EventUpdateMapIndex"
WorldEntrance.EventUpdateDisplayMarks = "WorldEntrance.EventUpdateDisplayMarks"

function WorldEntrance:DebugPrint()
	return string.format("入口 [id: %s] [原始地图: %s] [所属区域: %s] [所属海域: %s]", self.id, self:GetBaseMapId(), self.config.regions, self.config.world)
end

function WorldEntrance:Setup(arg_2_1, arg_2_2)
	self.id = arg_2_1

	assert(pg.world_chapter_colormask[arg_2_1], "world_chapter_colormask.csv without this id:" .. self.id)

	self.config = pg.world_chapter_colormask[arg_2_1]
	self.transportDic = {}

	for iter_2_0, iter_2_1 in ipairs(self.config.map_transfer) do
		self.transportDic[iter_2_1] = true
	end

	self.marks = {
		task_main = 0,
		task_following_main = 0,
		task_following_boss = 0,
		task_following = 0,
		task_collecktion = 0,
		task = 0,
		treasure = 0,
		sairen = 0,
		treasure_sairen = 0,
		step = 0
	}

	return
end

function WorldEntrance:IsOpen()
	return self:GetBaseMap():IsMapOpen()
end

function WorldEntrance:GetBaseMapId()
	return self.config.chapter
end

function WorldEntrance:GetBaseMap()
	return nowWorld():GetMap(self:GetBaseMapId())
end

function WorldEntrance:GetColormaskUniqueID()
	return self.config.color_id
end

function WorldEntrance:GetAreaId()
	return self.config.regions
end

function WorldEntrance:IsPressing()
	return self:GetBaseMap().isPressing
end

function WorldEntrance:HasPort(arg_9_1)
	local var_9_0 = self:GetPortId()
	local var_9_1

	if var_9_0 > 0 then
		if arg_9_1 then
			if pg.world_port_data[var_9_0].port_camp ~= nowWorld():GetRealm() then
				var_9_1 = false

				goto label_9_0
			end
		end
	end

	::label_9_0::

	return true
end

function WorldEntrance:GetPortId()
	return self.config.port_map_icon
end

function WorldEntrance:UpdateActive(arg_11_1)
	if self.active ~= arg_11_1 then
		self.active = arg_11_1

		if arg_11_1 then
			nowWorld():GetAtlas():SetActiveEntrance(self)
		end
	end

	return
end

function WorldEntrance:UpdateDisplayMarks(arg_12_1, arg_12_2)
	self.marks[arg_12_1] = self.marks[arg_12_1] + (arg_12_2 and 1 or -1)

	if self.marks[arg_12_1] == 0 and arg_12_2 or self.marks[arg_12_1] == 1 and not arg_12_2 then
		self:DispatchEvent(WorldEntrance.EventUpdateDisplayMarks, arg_12_1, self.marks[arg_12_1] > 0)
	end

	return
end

function WorldEntrance:GetDisplayMarks()
	return self.marks
end

function WorldEntrance:GetSairenMapId()
	return self.config.sairen_chapter[1]
end

function WorldEntrance:UpdateSairenMark(arg_15_1)
	if tobool(self.becomeSairen) ~= tobool(arg_15_1) then
		self.becomeSairen = arg_15_1
	end

	return
end

function WorldEntrance:GetAchievementAwards()
	return _.map(self.config.target_drop_show, function(arg_17_0)
		return {
			star = arg_17_0[1],
			drop = {
				type = arg_17_0[2][1],
				id = arg_17_0[2][2],
				count = arg_17_0[2][3]
			}
		}
	end)
end

return WorldEntrance
