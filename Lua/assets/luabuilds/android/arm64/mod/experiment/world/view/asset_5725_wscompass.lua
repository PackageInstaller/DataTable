local WSCompass = class("WSCompass", import("...BaseEntity"))

WSCompass.Fields = {
	map = "table",
	scaleRate = "table",
	ROTATIONOFFSET = "number",
	cells = "table",
	anchor = "userdata",
	diameter = "number",
	gid = "number",
	border = "userdata",
	prevFleetPos = "table",
	marks = "table",
	tf = "userdata",
	pool = "table",
	rangeTF = "userdata",
	entrance = "table",
	fov = "number",
	normal = "number"
}
WSCompass.Listeners = {
	onAdd = "OnAdd",
	onUpdateAttachment = "OnUpdateAttachment",
	onRemove = "OnRemove"
}

function WSCompass:GetCompassTpl()
	if self == WorldMapAttachment.CompassTypeBattle then
		return "compassBat_tpl"
	elseif self == WorldMapAttachment.CompassTypeExploration then
		return "compassExp_tpl"
	elseif self == WorldMapAttachment.CompassTypeTask then
		return "compassTask_tpl"
	elseif self == WorldMapAttachment.CompassTypeBoss then
		return "compassBoss_tpl"
	elseif self == WorldMapAttachment.CompassTypeGuidePost then
		return "compassGuidepost_tpl"
	elseif self == WorldMapAttachment.CompassTypeTaskTrack then
		return "compassTask_tpl"
	elseif self == WorldMapAttachment.CompassTypePort then
		return "compassPort_tpl"
	elseif self == WorldMapAttachment.CompassTypeSalvage then
		return "compassSalvage_tpl"
	elseif self == WorldMapAttachment.CompassTypeFile then
		return "compassFile_tpl"
	end

	return
end

function WSCompass:Setup(arg_2_1)
	self.ROTATIONOFFSET = 45
	self.rangeTF = self.tf:Find("range")
	self.anchor = self.rangeTF:Find("anchor")
	self.border = self.rangeTF:Find("mask/border")
	self.fov = WorldConst.GetFOVRadius() * 2
	self.diameter = self.fov * 2
	self.normal = self.rangeTF.sizeDelta.x / self.diameter
	self.marks = {}
	self.prevFleetPos = nil

	if arg_2_1 then
		self.scaleRate = Vector3.one or Vector3.New(0.7, 0.7, 1)
	end

	return
end

function WSCompass:Update(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2:GetFleet()
	local var_3_1, var_3_2 = arg_3_2:GetMapSize()
	local var_3_3 = Vector2(var_3_1 - 1, var_3_2 - 1)

	if self.entrance ~= arg_3_1 or self.map ~= arg_3_2 or self.gid ~= arg_3_2.gid then
		self.entrance = arg_3_1
		self.map = arg_3_2
		self.gid = arg_3_2.gid

		self:InitCells(var_3_3)
	end

	self:UpdateMarks(var_3_3, var_3_0.row, var_3_0.column)
	self:UpdateBorder(var_3_3, var_3_0.row, var_3_0.column)
	self:UpdateFleetPos(var_3_0, var_3_0.row, var_3_0.column)

	return
end

function WSCompass:UpdateByViewer(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0, var_4_1 = arg_4_1:GetMapSize()
	local var_4_2 = Vector2(var_4_0 - 1, var_4_1 - 1)

	self:ClearMarks()
	self:UpdateMarks(var_4_2, arg_4_2, arg_4_3)
	self:UpdateBorder(var_4_2, arg_4_2, arg_4_3)
	self:UpdateFleetPos(arg_4_1:GetFleet(), arg_4_2, arg_4_3)

	return
end

function WSCompass:InitCells(arg_5_1)
	self:RemoveCellsListener()

	self.cells = {}

	for iter_5_0 = 0, arg_5_1.x do
		for iter_5_1 = 0, arg_5_1.y do
			local var_5_0 = self.map:GetCell(iter_5_0, iter_5_1)

			if var_5_0 then
				self:AddCellListener(var_5_0)
				table.insert(self.cells, var_5_0)
			end
		end
	end

	return
end

function WSCompass:UpdateMarks(arg_6_1, arg_6_2, arg_6_3)
	_.each(self.cells, function(arg_7_0)
		if WorldConst.InFOVRange(arg_6_2, arg_6_3, arg_7_0.row, arg_7_0.column, self.fov) then
			self:UpdateInnerMark(arg_7_0, arg_6_2, arg_6_3)
		else
			self:UpdateOutsideMark(arg_7_0, arg_6_2, arg_6_3)
		end

		return
	end)

	return
end

function WSCompass:UpdateFleetPos(arg_8_1, arg_8_2, arg_8_3)
	setAnchoredPosition(self.anchor, WorldConst.InFOVRange(arg_8_2, arg_8_3, arg_8_1.row, arg_8_1.column, self.fov) and self:CalcInnerPos(arg_8_1.row, arg_8_1.column, arg_8_2, arg_8_3) or self:CalcOutsidePos(arg_8_1.row, arg_8_1.column, arg_8_2, arg_8_3))

	return
end

function WSCompass:AddCellListener(arg_9_1)
	arg_9_1:AddListener(WorldMapCell.EventAddAttachment, self.onAdd)
	arg_9_1:AddListener(WorldMapCell.EventRemoveAttachment, self.onRemove)
	_.each(arg_9_1.attachments, function(arg_10_0)
		arg_10_0:AddListener(WorldMapAttachment.EventUpdateLurk, self.onUpdateAttachment)
		arg_10_0:AddListener(WorldMapAttachment.EventUpdateData, self.onUpdateAttachment)
		arg_10_0:AddListener(WorldMapAttachment.EventUpdateFlag, self.onUpdateAttachment)

		return
	end)

	return
end

function WSCompass:RemoveCellsListener()
	_.each(self.cells or {}, function(arg_12_0)
		arg_12_0:RemoveListener(WorldMapCell.EventAddAttachment, self.onAdd)
		arg_12_0:RemoveListener(WorldMapCell.EventRemoveAttachment, self.onRemove)
		_.each(arg_12_0.attachments, function(arg_13_0)
			arg_13_0:RemoveListener(WorldMapAttachment.EventUpdateLurk, self.onUpdateAttachment)
			arg_13_0:RemoveListener(WorldMapAttachment.EventUpdateData, self.onUpdateAttachment)
			arg_13_0:RemoveListener(WorldMapAttachment.EventUpdateFlag, self.onUpdateAttachment)

			return
		end)

		return
	end)

	return
end

function WSCompass:OnAdd(arg_14_1, arg_14_2, arg_14_3)
	arg_14_3:AddListener(WorldMapAttachment.EventUpdateLurk, self.onUpdateAttachment)
	arg_14_3:AddListener(WorldMapAttachment.EventUpdateData, self.onUpdateAttachment)
	arg_14_3:AddListener(WorldMapAttachment.EventUpdateFlag, self.onUpdateAttachment)
	self:ClearMarks()
	self:Update(self.entrance, self.map)

	return
end

function WSCompass:OnRemove(arg_15_1, arg_15_2, arg_15_3)
	arg_15_3:RemoveListener(WorldMapAttachment.EventUpdateLurk, self.onUpdateAttachment)
	arg_15_3:RemoveListener(WorldMapAttachment.EventUpdateData, self.onUpdateAttachment)
	arg_15_3:RemoveListener(WorldMapAttachment.EventUpdateFlag, self.onUpdateAttachment)
	self:ClearMarks()
	self:Update(self.entrance, self.map)

	return
end

function WSCompass:OnUpdateAttachment()
	if self.map and self.map.active then
		self:ClearMarks()
		self:Update(self.entrance, self.map)
	end

	return
end

function WSCompass:UpdateCompassRotation(arg_17_1)
	local var_17_0 = Vector2(arg_17_1.column, arg_17_1.row)

	if self.prevFleetPos == var_17_0 then
		return
	end

	self.anchor.localEulerAngles = self.prevFleetPos and Vector3(0, 0, self.ROTATIONOFFSET + calcPositionAngle(self.prevFleetPos.x - var_17_0.x, self.prevFleetPos.y - var_17_0.y)) or Vector3(0, 0, self.ROTATIONOFFSET)
	self.prevFleetPos = Vector2(arg_17_1.column, arg_17_1.row)

	self.anchor:SetAsLastSibling()

	return
end

function WSCompass:GetAnchorEulerAngles()
	return self.anchor.localEulerAngles
end

function WSCompass:SetAnchorEulerAngles(arg_19_1)
	self.anchor.localEulerAngles = arg_19_1

	return
end

function WSCompass:UpdateBorder(arg_20_1, arg_20_2, arg_20_3)
	self.border.sizeDelta = Vector2(arg_20_1.y * self.normal, arg_20_1.x * self.normal)
	self.border.anchoredPosition = Vector2(-arg_20_3 * self.normal, arg_20_2 * self.normal)

	return
end

function WSCompass:getVector(arg_21_1)
	return Vector2(arg_21_1.config.area_pos[1], arg_21_1.config.area_pos[2])
end

function WSCompass:CalcTaskMarkPos(arg_22_1)
	local var_22_0 = calcPositionAngle(arg_22_1.x, arg_22_1.y)

	return Vector3(math.sin(math.rad(var_22_0)) * (self.normal * (self.fov + 1)), math.cos(math.rad(var_22_0)) * (self.normal * (self.fov + 1)), 0)
end

function WSCompass:UpdateInnerMark(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_1:GetCompassAttachment()

	if var_23_0 then
		local var_23_1 = var_23_0:GetCompassType()

		if var_23_1 and var_23_1 ~= WorldMapAttachment.CompassTypeNone then
			self:NewMark(var_23_1, self:CalcInnerPos(arg_23_1.row, arg_23_1.column, arg_23_2, arg_23_3), var_23_0.config.id)
		end
	elseif #self.map.ports > 0 then
		local var_23_2, var_23_3 = unpack(self.map.config.port_id[2])

		if var_23_2 == arg_23_1.row and var_23_3 == arg_23_1.column then
			self:NewMark(WorldMapAttachment.CompassTypePort, (self:CalcInnerPos(arg_23_1.row, arg_23_1.column, arg_23_2, arg_23_3)))
		end
	end

	return
end

function WSCompass:CalcInnerPos(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = Vector2(arg_24_2 - arg_24_4, -1 * (arg_24_1 - arg_24_3))

	return Vector3(self.normal * var_24_0.x, self.normal * var_24_0.y, 0)
end

function WSCompass:UpdateOutsideMark(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1:GetCompassAttachment()

	if var_25_0 then
		local var_25_1 = var_25_0:GetCompassType()

		if var_25_1 ~= WorldMapAttachment.CompassTypeBoss and var_25_1 ~= WorldMapAttachment.CompassTypeTask then
			if var_25_1 == WorldMapAttachment.CompassTypePort then
				self:NewMark(var_25_1, (self:CalcOutsidePos(arg_25_1.row, arg_25_1.column, arg_25_2, arg_25_3)))
			elseif #self.map.ports > 0 then
				local var_25_2, var_25_3 = unpack(self.map.config.port_id[2])

				if var_25_2 == arg_25_1.row and var_25_3 == arg_25_1.column then
					self:NewMark(WorldMapAttachment.CompassTypePort, (self:CalcOutsidePos(arg_25_1.row, arg_25_1.column, arg_25_2, arg_25_3)))
				end
			end
		end
	end

	return
end

function WSCompass:CalcOutsidePos(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = math.abs(Vector2.Angle(Vector2(arg_26_1 - arg_26_3, arg_26_2 - arg_26_4), Vector2.up) - 90)
	local var_26_1 = Vector2(arg_26_2 - arg_26_4, arg_26_3 - arg_26_1)

	return Vector3(math.sin(math.rad(var_26_0)) * (self.normal * (self.fov + 0.5)) * Mathf.Sign(var_26_1.x), math.cos(math.rad(var_26_0)) * (self.normal * (self.fov + 0.5)) * Mathf.Sign(var_26_1.y), 0)
end

function WSCompass:NewMark(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = WSCompass.GetCompassTpl(arg_27_1)
	local var_27_1 = self.pool:Get(var_27_0)

	var_27_1.transform.localScale = self.scaleRate
	var_27_1.name = arg_27_3 or "mark"

	setParent(var_27_1, self.rangeTF)

	tf(var_27_1).localPosition = arg_27_2

	table.insert(self.marks, {
		name = var_27_0,
		go = var_27_1
	})

	return
end

function WSCompass:NewTransportMark(arg_28_1, arg_28_2)
	local var_28_0 = self.pool:Get(arg_28_1)

	setParent(var_28_0, self.border)

	var_28_0.transform.localScale = self.scaleRate
	var_28_0.transform.anchorMin = Vector2(0, 1)
	var_28_0.transform.anchorMax = Vector2(0, 1)
	var_28_0.transform.anchoredPosition3D = Vector3(arg_28_2.y * self.normal, -arg_28_2.x * self.normal, 0)

	table.insert(self.marks, {
		name = arg_28_1,
		go = var_28_0
	})

	return
end

function WSCompass:ClearMarks()
	_.each(self.marks, function(arg_30_0)
		arg_30_0.go.transform.localScale = Vector3.one

		self.pool:Return(arg_30_0.name, arg_30_0.go)

		return
	end)

	self.marks = {}

	return
end

function WSCompass:GetMarkPosition(arg_31_1, arg_31_2)
	assert(self.map)

	local var_31_0 = self.map:GetFleet()

	return self.rangeTF:TransformPoint(WorldConst.InFOVRange(var_31_0.row, var_31_0.column, arg_31_1, arg_31_2, self.fov) and self:CalcInnerPos(arg_31_1, arg_31_2, var_31_0.row, var_31_0.column) or self:CalcOutsidePos(arg_31_1, arg_31_2, var_31_0.row, var_31_0.column))
end

function WSCompass:GetEntranceTrackMark(arg_32_1)
	assert(self.entrance)

	local var_32_0, var_32_1 = self:getVector((nowWorld():GetMap(arg_32_1)))
	local var_32_2, var_32_3 = self:getVector(self.entrance)

	return self.rangeTF:TransformPoint((self:CalcTaskMarkPos(var_32_0, var_32_1, var_32_2, var_32_3)))
end

function WSCompass:Dispose()
	self:RemoveCellsListener()
	self:ClearMarks()
	self:Clear()

	return
end

return WSCompass
