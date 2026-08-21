local var_0_0 = class("WSCompass", import("...BaseEntity"))

var_0_0.Fields = {
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
var_0_0.Listeners = {
	onAdd = "OnAdd",
	onUpdateAttachment = "OnUpdateAttachment",
	onRemove = "OnRemove"
}

function var_0_0.GetCompassTpl(arg_1_0)
	if arg_1_0 == WorldMapAttachment.CompassTypeBattle then
		return "compassBat_tpl"
	elseif arg_1_0 == WorldMapAttachment.CompassTypeExploration then
		return "compassExp_tpl"
	elseif arg_1_0 == WorldMapAttachment.CompassTypeTask then
		return "compassTask_tpl"
	elseif arg_1_0 == WorldMapAttachment.CompassTypeBoss then
		return "compassBoss_tpl"
	elseif arg_1_0 == WorldMapAttachment.CompassTypeGuidePost then
		return "compassGuidepost_tpl"
	elseif arg_1_0 == WorldMapAttachment.CompassTypeTaskTrack then
		return "compassTask_tpl"
	elseif arg_1_0 == WorldMapAttachment.CompassTypePort then
		return "compassPort_tpl"
	elseif arg_1_0 == WorldMapAttachment.CompassTypeSalvage then
		return "compassSalvage_tpl"
	elseif arg_1_0 == WorldMapAttachment.CompassTypeFile then
		return "compassFile_tpl"
	end

	return
end

function var_0_0.Setup(arg_2_0, arg_2_1)
	arg_2_0.ROTATIONOFFSET = 45
	arg_2_0.rangeTF = arg_2_0.tf:Find("range")
	arg_2_0.anchor = arg_2_0.rangeTF:Find("anchor")
	arg_2_0.border = arg_2_0.rangeTF:Find("mask/border")
	arg_2_0.fov = WorldConst.GetFOVRadius() * 2
	arg_2_0.diameter = arg_2_0.fov * 2
	arg_2_0.normal = arg_2_0.rangeTF.sizeDelta.x / arg_2_0.diameter
	arg_2_0.marks = {}
	arg_2_0.prevFleetPos = nil

	if arg_2_1 then
		arg_2_0.scaleRate = Vector3.one or Vector3.New(0.7, 0.7, 1)

		return
	end
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2:GetFleet()
	local var_3_1, var_3_2 = arg_3_2:GetMapSize()
	local var_3_3 = Vector2(var_3_1 - 1, var_3_2 - 1)

	if arg_3_0.entrance ~= arg_3_1 or arg_3_0.map ~= arg_3_2 or arg_3_0.gid ~= arg_3_2.gid then
		arg_3_0.entrance = arg_3_1
		arg_3_0.map = arg_3_2
		arg_3_0.gid = arg_3_2.gid

		arg_3_0:InitCells(var_3_3)
	end

	arg_3_0:UpdateMarks(var_3_3, var_3_0.row, var_3_0.column)
	arg_3_0:UpdateBorder(var_3_3, var_3_0.row, var_3_0.column)
	arg_3_0:UpdateFleetPos(var_3_0, var_3_0.row, var_3_0.column)

	return
end

function var_0_0.UpdateByViewer(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0, var_4_1 = arg_4_1:GetMapSize()
	local var_4_2 = Vector2(var_4_0 - 1, var_4_1 - 1)

	arg_4_0:ClearMarks()
	arg_4_0:UpdateMarks(var_4_2, arg_4_2, arg_4_3)
	arg_4_0:UpdateBorder(var_4_2, arg_4_2, arg_4_3)
	arg_4_0:UpdateFleetPos(arg_4_1:GetFleet(), arg_4_2, arg_4_3)

	return
end

function var_0_0.InitCells(arg_5_0, arg_5_1)
	arg_5_0:RemoveCellsListener()

	arg_5_0.cells = {}

	for iter_5_0 = 0, arg_5_1.x do
		for iter_5_1 = 0, arg_5_1.y do
			local var_5_0 = arg_5_0.map:GetCell(iter_5_0, iter_5_1)

			if var_5_0 then
				arg_5_0:AddCellListener(var_5_0)
				table.insert(arg_5_0.cells, var_5_0)
			end
		end
	end

	return
end

function var_0_0.UpdateMarks(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	_.each(arg_6_0.cells, function(arg_7_0)
		if WorldConst.InFOVRange(arg_6_2, arg_6_3, arg_7_0.row, arg_7_0.column, arg_6_0.fov) then
			arg_6_0:UpdateInnerMark(arg_7_0, arg_6_2, arg_6_3)
		else
			arg_6_0:UpdateOutsideMark(arg_7_0, arg_6_2, arg_6_3)
		end

		return
	end)

	return
end

function var_0_0.UpdateFleetPos(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = WorldConst.InFOVRange(arg_8_2, arg_8_3, arg_8_1.row, arg_8_1.column, arg_8_0.fov) and arg_8_0:CalcInnerPos(arg_8_1.row, arg_8_1.column, arg_8_2, arg_8_3) or arg_8_0:CalcOutsidePos(arg_8_1.row, arg_8_1.column, arg_8_2, arg_8_3)

	setAnchoredPosition(arg_8_0.anchor, var_8_0)

	return
end

function var_0_0.AddCellListener(arg_9_0, arg_9_1)
	arg_9_1:AddListener(WorldMapCell.EventAddAttachment, arg_9_0.onAdd)
	arg_9_1:AddListener(WorldMapCell.EventRemoveAttachment, arg_9_0.onRemove)
	_.each(arg_9_1.attachments, function(arg_10_0)
		arg_10_0:AddListener(WorldMapAttachment.EventUpdateLurk, arg_9_0.onUpdateAttachment)
		arg_10_0:AddListener(WorldMapAttachment.EventUpdateData, arg_9_0.onUpdateAttachment)
		arg_10_0:AddListener(WorldMapAttachment.EventUpdateFlag, arg_9_0.onUpdateAttachment)

		return
	end)

	return
end

function var_0_0.RemoveCellsListener(arg_11_0)
	local var_11_0 = arg_11_0.cells or {}

	_.each(var_11_0, function(arg_12_0)
		arg_12_0:RemoveListener(WorldMapCell.EventAddAttachment, arg_11_0.onAdd)
		arg_12_0:RemoveListener(WorldMapCell.EventRemoveAttachment, arg_11_0.onRemove)
		_.each(arg_12_0.attachments, function(arg_13_0)
			arg_13_0:RemoveListener(WorldMapAttachment.EventUpdateLurk, arg_11_0.onUpdateAttachment)
			arg_13_0:RemoveListener(WorldMapAttachment.EventUpdateData, arg_11_0.onUpdateAttachment)
			arg_13_0:RemoveListener(WorldMapAttachment.EventUpdateFlag, arg_11_0.onUpdateAttachment)

			return
		end)

		return
	end)

	return
end

function var_0_0.OnAdd(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_3:AddListener(WorldMapAttachment.EventUpdateLurk, arg_14_0.onUpdateAttachment)
	arg_14_3:AddListener(WorldMapAttachment.EventUpdateData, arg_14_0.onUpdateAttachment)
	arg_14_3:AddListener(WorldMapAttachment.EventUpdateFlag, arg_14_0.onUpdateAttachment)
	arg_14_0:ClearMarks()
	arg_14_0:Update(arg_14_0.entrance, arg_14_0.map)

	return
end

function var_0_0.OnRemove(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_3:RemoveListener(WorldMapAttachment.EventUpdateLurk, arg_15_0.onUpdateAttachment)
	arg_15_3:RemoveListener(WorldMapAttachment.EventUpdateData, arg_15_0.onUpdateAttachment)
	arg_15_3:RemoveListener(WorldMapAttachment.EventUpdateFlag, arg_15_0.onUpdateAttachment)
	arg_15_0:ClearMarks()
	arg_15_0:Update(arg_15_0.entrance, arg_15_0.map)

	return
end

function var_0_0.OnUpdateAttachment(arg_16_0)
	if arg_16_0.map and arg_16_0.map.active then
		arg_16_0:ClearMarks()
		arg_16_0:Update(arg_16_0.entrance, arg_16_0.map)
	end

	return
end

function var_0_0.UpdateCompassRotation(arg_17_0, arg_17_1)
	local var_17_0 = Vector2(arg_17_1.column, arg_17_1.row)

	if arg_17_0.prevFleetPos == var_17_0 then
		return
	end

	arg_17_0.anchor.localEulerAngles = arg_17_0.prevFleetPos and Vector3(0, 0, arg_17_0.ROTATIONOFFSET + calcPositionAngle(arg_17_0.prevFleetPos.x - var_17_0.x, arg_17_0.prevFleetPos.y - var_17_0.y)) or Vector3(0, 0, arg_17_0.ROTATIONOFFSET)
	arg_17_0.prevFleetPos = Vector2(arg_17_1.column, arg_17_1.row)

	arg_17_0.anchor:SetAsLastSibling()

	return
end

function var_0_0.GetAnchorEulerAngles(arg_18_0)
	return arg_18_0.anchor.localEulerAngles
end

function var_0_0.SetAnchorEulerAngles(arg_19_0, arg_19_1)
	arg_19_0.anchor.localEulerAngles = arg_19_1

	return
end

function var_0_0.UpdateBorder(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0.border.sizeDelta = Vector2(arg_20_1.y * arg_20_0.normal, arg_20_1.x * arg_20_0.normal)
	arg_20_0.border.anchoredPosition = Vector2(-arg_20_3 * arg_20_0.normal, arg_20_2 * arg_20_0.normal)

	return
end

function var_0_0.getVector(arg_21_0, arg_21_1)
	return Vector2(arg_21_1.config.area_pos[1], arg_21_1.config.area_pos[2])
end

function var_0_0.CalcTaskMarkPos(arg_22_0, arg_22_1)
	local var_22_0 = calcPositionAngle(arg_22_1.x, arg_22_1.y)

	return Vector3(math.sin(math.rad(var_22_0)) * (arg_22_0.normal * (arg_22_0.fov + 1)), math.cos(math.rad(var_22_0)) * (arg_22_0.normal * (arg_22_0.fov + 1)), 0)
end

function var_0_0.UpdateInnerMark(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_1:GetCompassAttachment()

	if var_23_0 then
		local var_23_1 = var_23_0:GetCompassType()

		if var_23_1 and var_23_1 ~= WorldMapAttachment.CompassTypeNone then
			arg_23_0:NewMark(var_23_1, arg_23_0:CalcInnerPos(arg_23_1.row, arg_23_1.column, arg_23_2, arg_23_3), var_23_0.config.id)
		end
	elseif #arg_23_0.map.ports > 0 then
		local var_23_2, var_23_3 = unpack(arg_23_0.map.config.port_id[2])

		if var_23_2 == arg_23_1.row and var_23_3 == arg_23_1.column then
			arg_23_0:NewMark(WorldMapAttachment.CompassTypePort, (arg_23_0:CalcInnerPos(arg_23_1.row, arg_23_1.column, arg_23_2, arg_23_3)))
		end
	end

	return
end

function var_0_0.CalcInnerPos(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = Vector2(arg_24_2 - arg_24_4, -1 * (arg_24_1 - arg_24_3))

	return Vector3(arg_24_0.normal * var_24_0.x, arg_24_0.normal * var_24_0.y, 0)
end

function var_0_0.UpdateOutsideMark(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1:GetCompassAttachment()

	if var_25_0 then
		local var_25_1 = var_25_0:GetCompassType()

		if var_25_1 ~= WorldMapAttachment.CompassTypeBoss and var_25_1 ~= WorldMapAttachment.CompassTypeTask then
			if var_25_1 == WorldMapAttachment.CompassTypePort then
				arg_25_0:NewMark(var_25_1, (arg_25_0:CalcOutsidePos(arg_25_1.row, arg_25_1.column, arg_25_2, arg_25_3)))

				goto label_25_0

				if #arg_25_0.map.ports > 0 then
					local var_25_2, var_25_3 = unpack(arg_25_0.map.config.port_id[2])

					if var_25_2 == arg_25_1.row and var_25_3 == arg_25_1.column then
						arg_25_0:NewMark(WorldMapAttachment.CompassTypePort, (arg_25_0:CalcOutsidePos(arg_25_1.row, arg_25_1.column, arg_25_2, arg_25_3)))
					end
				end
			end

			::label_25_0::

			return
		end
	end
end

function var_0_0.CalcOutsidePos(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = math.abs(Vector2.Angle(Vector2(arg_26_1 - arg_26_3, arg_26_2 - arg_26_4), Vector2.up) - 90)
	local var_26_1 = Vector2(arg_26_2 - arg_26_4, arg_26_3 - arg_26_1)

	return Vector3(math.sin(math.rad(var_26_0)) * (arg_26_0.normal * (arg_26_0.fov + 0.5)) * Mathf.Sign(var_26_1.x), math.cos(math.rad(var_26_0)) * (arg_26_0.normal * (arg_26_0.fov + 0.5)) * Mathf.Sign(var_26_1.y), 0)
end

function var_0_0.NewMark(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = var_0_0.GetCompassTpl(arg_27_1)
	local var_27_1 = arg_27_0.pool:Get(var_27_0)

	var_27_1.transform.localScale = arg_27_0.scaleRate
	var_27_1.name = arg_27_3 or "mark"

	setParent(var_27_1, arg_27_0.rangeTF)

	tf(var_27_1).localPosition = arg_27_2

	table.insert(arg_27_0.marks, {
		name = var_27_0,
		go = var_27_1
	})

	return
end

function var_0_0.NewTransportMark(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.pool:Get(arg_28_1)

	setParent(var_28_0, arg_28_0.border)

	var_28_0.transform.localScale = arg_28_0.scaleRate
	var_28_0.transform.anchorMin = Vector2(0, 1)
	var_28_0.transform.anchorMax = Vector2(0, 1)
	var_28_0.transform.anchoredPosition3D = Vector3(arg_28_2.y * arg_28_0.normal, -arg_28_2.x * arg_28_0.normal, 0)

	table.insert(arg_28_0.marks, {
		name = arg_28_1,
		go = var_28_0
	})

	return
end

function var_0_0.ClearMarks(arg_29_0)
	_.each(arg_29_0.marks, function(arg_30_0)
		arg_30_0.go.transform.localScale = Vector3.one

		arg_29_0.pool:Return(arg_30_0.name, arg_30_0.go)

		return
	end)

	arg_29_0.marks = {}

	return
end

function var_0_0.GetMarkPosition(arg_31_0, arg_31_1, arg_31_2)
	assert(arg_31_0.map)

	local var_31_0 = arg_31_0.map:GetFleet()
	local var_31_1 = WorldConst.InFOVRange(var_31_0.row, var_31_0.column, arg_31_1, arg_31_2, arg_31_0.fov) and arg_31_0:CalcInnerPos(arg_31_1, arg_31_2, var_31_0.row, var_31_0.column) or arg_31_0:CalcOutsidePos(arg_31_1, arg_31_2, var_31_0.row, var_31_0.column)

	return arg_31_0.rangeTF:TransformPoint(var_31_1)
end

function var_0_0.GetEntranceTrackMark(arg_32_0, arg_32_1)
	assert(arg_32_0.entrance)

	local var_32_0, var_32_1 = arg_32_0:getVector((nowWorld():GetMap(arg_32_1)))
	local var_32_2, var_32_3 = arg_32_0:getVector(arg_32_0.entrance)

	return arg_32_0.rangeTF:TransformPoint((arg_32_0:CalcTaskMarkPos(var_32_0, var_32_1, var_32_2, var_32_3)))
end

function var_0_0.Dispose(arg_33_0)
	arg_33_0:RemoveCellsListener()
	arg_33_0:ClearMarks()
	arg_33_0:Clear()

	return
end

return var_0_0
