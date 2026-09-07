local ChapterCell = class("ChapterCell", import(".LevelCellData"))

function ChapterCell:Ctor(arg_1_1)
	self.walkable = true
	self.forbiddenDirections = ChapterConst.ForbiddenNone
	self.row = arg_1_1.pos.row
	self.column = arg_1_1.pos.column
	self.attachment = arg_1_1.item_type
	self.attachmentId = arg_1_1.item_id
	self.flag = arg_1_1.item_flag
	self.data = arg_1_1.item_data
	self.trait = ChapterConst.TraitNone
	self.item = nil
	self.itemOffset = nil
	self.flagList = {}

	if arg_1_1.flag_list then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.flag_list) do
			table.insert(self.flagList, iter_1_1)
		end
	end

	return
end

function ChapterCell:updateFlagList(arg_2_1)
	self.flagList = self.flagList or {}

	table.clear(self.flagList)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.flag_list) do
		table.insert(self.flagList, iter_2_1)
	end

	return
end

function ChapterCell:GetFlagList()
	return self.flagList
end

function ChapterCell:GetWeatherFlagList()
	local var_4_0 = underscore.filter(self:GetFlagList(), function(arg_5_0)
		return tobool(pg.weather_data_template[arg_5_0])
	end)

	if not self:IsVisible() then
		table.insert(var_4_0, ChapterConst.FlagWeatherFogVisible)
	end

	return var_4_0
end

function ChapterCell:checkHadFlag(arg_6_1)
	return table.contains(self.flagList, arg_6_1)
end

function ChapterCell:Line2Name(arg_7_1)
	return "chapter_cell_" .. self .. "_" .. arg_7_1
end

function ChapterCell:Line2QuadName(arg_8_1)
	return "chapter_cell_quad_" .. self .. "_" .. arg_8_1
end

function ChapterCell:Line2MarkName(arg_9_1, arg_9_2)
	return "chapter_cell_mark_" .. self .. "_" .. arg_9_1 .. "#" .. arg_9_2
end

function ChapterCell:MinMaxLine2QuadName(arg_10_1, arg_10_2, arg_10_3)
	return "chapter_cell_quad_" .. self .. "_" .. arg_10_1 .. "_" .. arg_10_2 .. "_" .. arg_10_3
end

function ChapterCell:Line2RivalName(arg_11_1, arg_11_2)
	return "rival_" .. arg_11_1 .. "_" .. arg_11_2
end

function ChapterCell:LineAround(arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0 = -arg_12_2, arg_12_2 do
		for iter_12_1 = -arg_12_2, arg_12_2 do
			if arg_12_2 >= math.abs(iter_12_0) + math.abs(iter_12_1) then
				table.insert(var_12_0, {
					row = self + iter_12_0,
					column = arg_12_1 + iter_12_1
				})
			end
		end
	end

	return var_12_0
end

function ChapterCell:SetWalkable(arg_13_1)
	self.walkable = tobool(arg_13_1)

	if type(arg_13_1) == "boolean" then
		if arg_13_1 then
			self.forbiddenDirections = ChapterConst.ForbiddenNone or ChapterConst.ForbiddenAll
		end
	elseif type(arg_13_1) == "number" then
		self.forbiddenDirections = bit.band(arg_13_1, ChapterConst.ForbiddenAll)
	end

	return
end

function ChapterCell:IsWalkable()
	return self.walkable
end

function ChapterCell:InitVisible()
	self.visible = {}

	return
end

function ChapterCell:UpdateVisible(arg_16_1, arg_16_2)
	assert(self.visible and not arg_16_2 == table.contains(self.visible, arg_16_1))

	if arg_16_2 then
		table.insert(self.visible, arg_16_1)
	else
		table.removebyvalue(self.visible, arg_16_1)
	end

	return
end

function ChapterCell:IsVisible()
	if self.visible then
		return #self.visible > 0
	else
		return true
	end

	return
end

return ChapterCell
