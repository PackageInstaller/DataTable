class = var_0_10000

local var_0_0 = "WSCompass"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
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
var_0_1.Listeners = {
	onAdd = "OnAdd",
	onUpdateAttachment = "OnUpdateAttachment",
	onRemove = "OnRemove"
}

function var_0_1.GetCompassTpl(arg_1_0)
	WorldMapAttachment = var_1_10001

	if arg_1_0 == var_1_10001.CompassTypeBattle then
		return "compassBat_tpl"
	else
		WorldMapAttachment = var_1

		if arg_1_0 == var_1.CompassTypeExploration then
			return "compassExp_tpl"
		else
			WorldMapAttachment = var_1

			if arg_1_0 == var_1.CompassTypeTask then
				return "compassTask_tpl"
			else
				WorldMapAttachment = var_1

				if arg_1_0 == var_1.CompassTypeBoss then
					return "compassBoss_tpl"
				else
					WorldMapAttachment = var_1

					if arg_1_0 == var_1.CompassTypeGuidePost then
						return "compassGuidepost_tpl"
					else
						WorldMapAttachment = var_1

						if arg_1_0 == var_1.CompassTypeTaskTrack then
							return "compassTask_tpl"
						else
							WorldMapAttachment = var_1

							if arg_1_0 == var_1.CompassTypePort then
								return "compassPort_tpl"
							else
								WorldMapAttachment = var_1

								if arg_1_0 == var_1.CompassTypeSalvage then
									return "compassSalvage_tpl"
								else
									WorldMapAttachment = var_1

									if arg_1_0 == var_1.CompassTypeFile then
										return "compassFile_tpl"
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.ROTATIONOFFSET = 45

	local var_2_0 = arg_2_0.tf

	arg_2_0.rangeTF = var_2.Find(var_2_0, "range")

	local var_2_1 = arg_2_0.rangeTF

	arg_2_0.anchor = var_2.Find(var_2_1, "anchor")

	local var_2_2 = arg_2_0.rangeTF

	arg_2_0.border = var_2.Find(var_2_2, "mask/border")
	WorldConst = var_2
	arg_2_0.fov = var_2.GetFOVRadius() * 2
	arg_2_0.diameter = arg_2_0.fov * 2
	arg_2_0.normal = arg_2_0.rangeTF.sizeDelta.x / arg_2_0.diameter
	arg_2_0.marks = {}
	arg_2_0.prevFleetPos = nil

	if arg_2_1 then
		Vector3 = var_2_3

		local var_2_3

		if not var_2_3.one then
			Vector3 = var_2_3
			var_2_3 = var_2_3.New(0.7, 0.7, 1)
		end

		arg_2_0.scaleRate = var_2_3

		return
	end
end

function var_0_1.Update(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2:GetFleet()
	local var_3_1 = arg_3_2
	local var_3_2, var_3_3 = arg_3_2.GetMapSize(var_3_1)

	Vector2 = var_3_1

	local var_3_4 = var_3_1(var_3_2 - 1, var_3_3 - 1)

	if arg_3_0.entrance ~= arg_3_1 or arg_3_0.map ~= arg_3_2 or arg_3_0.gid ~= arg_3_2.gid then
		arg_3_0.entrance = arg_3_1
		arg_3_0.map = arg_3_2
		arg_3_0.gid = arg_3_2.gid

		arg_3_0:InitCells(var_3_4)
	end

	arg_3_0:UpdateMarks(var_3_4, var_3_0.row, var_3_0.column)
	arg_3_0:UpdateBorder(var_3_4, var_3_0.row, var_3_0.column)
	arg_3_0:UpdateFleetPos(var_3_0, var_3_0.row, var_3_0.column)

	return
end

function var_0_1.UpdateByViewer(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_1:GetFleet()
	local var_4_1 = arg_4_1
	local var_4_2, var_4_3 = arg_4_1.GetMapSize(var_4_1)

	Vector2 = var_4_1

	local var_4_4 = var_4_1(var_4_2 - 1, var_4_3 - 1)

	arg_4_0:ClearMarks()
	arg_4_0:UpdateMarks(var_4_4, arg_4_2, arg_4_3)
	arg_4_0:UpdateBorder(var_4_4, arg_4_2, arg_4_3)
	arg_4_0:UpdateFleetPos(var_4_0, arg_4_2, arg_4_3)

	return
end

function var_0_1.InitCells(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.map

	arg_5_0:RemoveCellsListener()

	arg_5_0.cells = {}

	for iter_5_0 = 0, arg_5_1.x do
		for iter_5_1 = 0, arg_5_1.y do
			if var_5_0:GetCell(iter_5_0, iter_5_1) then
				arg_5_0:AddCellListener(var_11)

				table = var_12

				var_12.insert(arg_5_0.cells, var_11)
			end
		end
	end

	return
end

function var_0_1.UpdateMarks(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0.map

	_ = var_1_10005

	var_1_10005.each(arg_6_0.cells, function(arg_7_0)
		WorldConst = var_2_10001

		if var_2_10001.InFOVRange(arg_6_2, arg_6_3, arg_7_0.row, arg_7_0.column, arg_6_0.fov) then
			local var_7_0 = arg_6_0

			var_1.UpdateInnerMark(var_7_0, arg_7_0, arg_6_2, arg_6_3)
		else
			local var_7_1 = arg_6_0

			var_1.UpdateOutsideMark(var_7_1, arg_7_0, arg_6_2, arg_6_3)
		end

		return
	end)

	return
end

function var_0_1.UpdateFleetPos(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0

	WorldConst = var_1_10005

	if var_1_10005.InFOVRange(arg_8_2, arg_8_3, arg_8_1.row, arg_8_1.column, arg_8_0.fov) then
		var_8_0 = arg_8_0:CalcInnerPos(arg_8_1.row, arg_8_1.column, arg_8_2, arg_8_3)
	else
		var_8_0 = arg_8_0:CalcOutsidePos(arg_8_1.row, arg_8_1.column, arg_8_2, arg_8_3)
	end

	setAnchoredPosition = var_5

	var_5(arg_8_0.anchor, var_8_0)

	return
end

function var_0_1.AddCellListener(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.AddListener

	WorldMapCell = var_1_10005

	var_9_1(var_9_0, var_1_10005.EventAddAttachment, arg_9_0.onAdd)

	local var_9_2 = arg_9_1
	local var_9_3 = arg_9_1.AddListener

	WorldMapCell = var_5

	var_9_3(var_9_2, var_5.EventRemoveAttachment, arg_9_0.onRemove)

	_ = var_9_3

	var_9_3.each(arg_9_1.attachments, function(arg_10_0)
		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.AddListener

		WorldMapAttachment = var_2_10004

		var_10_1(var_10_0, var_2_10004.EventUpdateLurk, arg_9_0.onUpdateAttachment)

		local var_10_2 = arg_10_0
		local var_10_3 = arg_10_0.AddListener

		WorldMapAttachment = var_4

		var_10_3(var_10_2, var_4.EventUpdateData, arg_9_0.onUpdateAttachment)

		local var_10_4 = arg_10_0
		local var_10_5 = arg_10_0.AddListener

		WorldMapAttachment = var_4

		var_10_5(var_10_4, var_4.EventUpdateFlag, arg_9_0.onUpdateAttachment)

		return
	end)

	return
end

function var_0_1.RemoveCellsListener(arg_11_0)
	_ = var_1_10001

	local var_11_0 = var_1_10001.each
	local var_11_1

	if not arg_11_0.cells then
		var_11_1 = {}
	end

	var_11_0(var_11_1, function(arg_12_0)
		local var_12_0 = arg_12_0
		local var_12_1 = arg_12_0.RemoveListener

		WorldMapCell = var_2_10004

		var_12_1(var_12_0, var_2_10004.EventAddAttachment, arg_11_0.onAdd)

		local var_12_2 = arg_12_0
		local var_12_3 = arg_12_0.RemoveListener

		WorldMapCell = var_4

		var_12_3(var_12_2, var_4.EventRemoveAttachment, arg_11_0.onRemove)

		_ = var_12_3

		var_12_3.each(arg_12_0.attachments, function(arg_13_0)
			local var_13_0 = arg_13_0
			local var_13_1 = arg_13_0.RemoveListener

			WorldMapAttachment = var_3_10004

			var_13_1(var_13_0, var_3_10004.EventUpdateLurk, arg_11_0.onUpdateAttachment)

			local var_13_2 = arg_13_0
			local var_13_3 = arg_13_0.RemoveListener

			WorldMapAttachment = var_4

			var_13_3(var_13_2, var_4.EventUpdateData, arg_11_0.onUpdateAttachment)

			local var_13_4 = arg_13_0
			local var_13_5 = arg_13_0.RemoveListener

			WorldMapAttachment = var_4

			var_13_5(var_13_4, var_4.EventUpdateFlag, arg_11_0.onUpdateAttachment)

			return
		end)

		return
	end)

	return
end

function var_0_1.OnAdd(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_3
	local var_14_1 = arg_14_3.AddListener

	WorldMapAttachment = var_1_10007

	var_14_1(var_14_0, var_1_10007.EventUpdateLurk, arg_14_0.onUpdateAttachment)

	local var_14_2 = arg_14_3
	local var_14_3 = arg_14_3.AddListener

	WorldMapAttachment = var_7

	var_14_3(var_14_2, var_7.EventUpdateData, arg_14_0.onUpdateAttachment)

	local var_14_4 = arg_14_3
	local var_14_5 = arg_14_3.AddListener

	WorldMapAttachment = var_7

	var_14_5(var_14_4, var_7.EventUpdateFlag, arg_14_0.onUpdateAttachment)
	arg_14_0:ClearMarks()
	arg_14_0:Update(arg_14_0.entrance, arg_14_0.map)

	return
end

function var_0_1.OnRemove(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_3
	local var_15_1 = arg_15_3.RemoveListener

	WorldMapAttachment = var_1_10007

	var_15_1(var_15_0, var_1_10007.EventUpdateLurk, arg_15_0.onUpdateAttachment)

	local var_15_2 = arg_15_3
	local var_15_3 = arg_15_3.RemoveListener

	WorldMapAttachment = var_7

	var_15_3(var_15_2, var_7.EventUpdateData, arg_15_0.onUpdateAttachment)

	local var_15_4 = arg_15_3
	local var_15_5 = arg_15_3.RemoveListener

	WorldMapAttachment = var_7

	var_15_5(var_15_4, var_7.EventUpdateFlag, arg_15_0.onUpdateAttachment)
	arg_15_0:ClearMarks()
	arg_15_0:Update(arg_15_0.entrance, arg_15_0.map)

	return
end

function var_0_1.OnUpdateAttachment(arg_16_0)
	if arg_16_0.map and arg_16_0.map.active then
		arg_16_0:ClearMarks()
		arg_16_0:Update(arg_16_0.entrance, arg_16_0.map)
	end

	return
end

function var_0_1.UpdateCompassRotation(arg_17_0, arg_17_1)
	Vector2 = var_1_10002

	local var_17_0 = var_1_10002(arg_17_1.column, arg_17_1.row)

	if arg_17_0.prevFleetPos == var_17_0 then
		return
	end

	local var_17_1, var_17_2

	if arg_17_0.prevFleetPos then
		calcPositionAngle = var_17_1
		var_17_1 = var_17_1(arg_17_0.prevFleetPos.x - var_17_0.x, arg_17_0.prevFleetPos.y - var_17_0.y)
		var_17_2 = arg_17_0.anchor
		Vector3 = var_5
		var_17_2.localEulerAngles = var_5(0, 0, arg_17_0.ROTATIONOFFSET + var_17_1)
	else
		var_17_1 = arg_17_0.anchor
		Vector3 = var_17_2
		var_17_1.localEulerAngles = var_17_2(0, 0, arg_17_0.ROTATIONOFFSET)
	end

	Vector2 = var_17_1
	arg_17_0.prevFleetPos = var_17_1(arg_17_1.column, arg_17_1.row)

	local var_17_3 = arg_17_0.anchor

	var_3.SetAsLastSibling(var_17_3)

	return
end

function var_0_1.GetAnchorEulerAngles(arg_18_0)
	return arg_18_0.anchor.localEulerAngles
end

function var_0_1.SetAnchorEulerAngles(arg_19_0, arg_19_1)
	arg_19_0.anchor.localEulerAngles = arg_19_1

	return
end

function var_0_1.UpdateBorder(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_1.x
	local var_20_1 = arg_20_1.y * arg_20_0.normal
	local var_20_2 = var_20_0 * arg_20_0.normal
	local var_20_3 = arg_20_0.border

	Vector2 = var_1_10009
	var_20_3.sizeDelta = var_1_10009(var_20_1, var_20_2)

	local var_20_4 = arg_20_0.border

	Vector2 = var_9
	var_20_4.anchoredPosition = var_9(-arg_20_3 * arg_20_0.normal, arg_20_2 * arg_20_0.normal)

	return
end

function var_0_1.getVector(arg_21_0, arg_21_1)
	Vector2 = var_1_10002

	return var_1_10002(arg_21_1.config.area_pos[1], arg_21_1.config.area_pos[2])
end

function var_0_1.CalcTaskMarkPos(arg_22_0, arg_22_1)
	calcPositionAngle = var_1_10002

	local var_22_0 = var_1_10002(arg_22_1.x, arg_22_1.y)
	local var_22_1 = arg_22_0.normal * (arg_22_0.fov + 1)

	math = var_4

	local var_22_2 = var_4.sin

	math = var_1_10006

	local var_22_3 = var_22_2(var_1_10006.rad(var_22_0)) * var_22_1

	math = var_5

	local var_22_4 = var_5.cos

	math = var_1_10007

	local var_22_5 = var_22_4(var_1_10007.rad(var_22_0)) * var_22_1

	Vector3 = var_6

	return var_6(var_22_3, var_22_5, 0)
end

function var_0_1.UpdateInnerMark(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0.map
	local var_23_1 = arg_23_1

	if arg_23_1.GetCompassAttachment(var_23_1) then
		if var_5:GetCompassType() then
			WorldMapAttachment = var_23_1

			if var_6 ~= var_23_1.CompassTypeNone then
				local var_23_2 = arg_23_0:CalcInnerPos(arg_23_1.row, arg_23_1.column, arg_23_2, arg_23_3)

				arg_23_0:NewMark(var_6, var_23_2, var_5.config.id)
			end
		end
	elseif #var_23_0.ports > 0 then
		unpack = var_6

		local var_23_3, var_23_4 = var_6(var_23_0.config.port_id[2])

		if var_23_3 == arg_23_1.row and var_23_4 == arg_23_1.column then
			local var_23_5 = arg_23_0:CalcInnerPos(arg_23_1.row, arg_23_1.column, arg_23_2, arg_23_3)
			local var_23_6 = arg_23_0
			local var_23_7 = arg_23_0.NewMark

			WorldMapAttachment = var_12

			var_23_7(var_23_6, var_12.CompassTypePort, var_23_5)
		end
	end

	return
end

function var_0_1.CalcInnerPos(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	Vector2 = var_1_10005

	local var_24_0 = var_1_10005(arg_24_2 - arg_24_4, -1 * (arg_24_1 - arg_24_3))

	Vector3 = var_1_10006

	return var_1_10006(arg_24_0.normal * var_24_0.x, arg_24_0.normal * var_24_0.y, 0)
end

function var_0_1.UpdateOutsideMark(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0.map
	local var_25_1 = arg_25_1

	if arg_25_1.GetCompassAttachment(var_25_1) then
		local var_25_2 = var_5:GetCompassType()

		WorldMapAttachment = var_25_1

		if var_25_2 ~= var_25_1.CompassTypeBoss then
			WorldMapAttachment = var_7

			if var_25_2 ~= var_7.CompassTypeTask then
				WorldMapAttachment = var_7

				if var_25_2 == var_7.CompassTypePort then
					local var_25_3 = arg_25_0:CalcOutsidePos(arg_25_1.row, arg_25_1.column, arg_25_2, arg_25_3)

					arg_25_0:NewMark(var_25_2, var_25_3)

					goto label_25_0

					if #var_25_0.ports > 0 then
						unpack = var_6

						local var_25_4, var_25_5 = var_6(var_25_0.config.port_id[2])

						if var_25_4 == arg_25_1.row and var_25_5 == arg_25_1.column then
							local var_25_6 = arg_25_0:CalcOutsidePos(arg_25_1.row, arg_25_1.column, arg_25_2, arg_25_3)
							local var_25_7 = arg_25_0
							local var_25_8 = arg_25_0.NewMark

							WorldMapAttachment = var_12

							var_25_8(var_25_7, var_12.CompassTypePort, var_25_6)
						end
					end
				end

				::label_25_0::

				return
			end
		end
	end
end

function var_0_1.CalcOutsidePos(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	Vector2 = var_1_10005

	local var_26_0 = var_1_10005.Angle

	Vector2 = var_1_10007

	local var_26_1 = var_1_10007(arg_26_1 - arg_26_3, arg_26_2 - arg_26_4)

	Vector2 = var_1_10008

	local var_26_2 = var_26_0(var_26_1, var_1_10008.up)

	math = var_1_10006

	local var_26_3 = var_1_10006.abs(var_26_2 - 90)

	Vector2 = var_6

	local var_26_4 = var_6(arg_26_2 - arg_26_4, arg_26_3 - arg_26_1)
	local var_26_5 = arg_26_0.normal * (arg_26_0.fov + 0.5)

	math = var_8

	local var_26_6 = var_8.sin

	math = var_10

	local var_26_7 = var_26_6(var_10.rad(var_26_3)) * var_26_5

	Mathf = var_9

	local var_26_8 = var_26_7 * var_9.Sign(var_26_4.x)

	math = var_9

	local var_26_9 = var_9.cos

	math = var_11

	local var_26_10 = var_26_9(var_11.rad(var_26_3)) * var_26_5

	Mathf = var_10

	local var_26_11 = var_26_10 * var_10.Sign(var_26_4.y)

	Vector3 = var_10

	return var_10(var_26_8, var_26_11, 0)
end

function var_0_1.NewMark(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = var_0_1.GetCompassTpl(arg_27_1)
	local var_27_1 = arg_27_0.pool

	var_5.Get(var_27_1, var_27_0).transform.localScale = arg_27_0.scaleRate
	var_5.name = arg_27_3 or "mark"
	setParent = var_6

	var_6(var_5, arg_27_0.rangeTF)

	tf = var_6

	local var_27_2 = var_6(var_5)

	var_27_2.localPosition = arg_27_2
	table = var_27_2

	var_27_2.insert(arg_27_0.marks, {
		name = var_27_0,
		go = var_5
	})

	return
end

function var_0_1.NewTransportMark(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.pool
	local var_28_1 = var_3.Get(var_28_0, arg_28_1)

	setParent = var_1_10004

	var_1_10004(var_28_1, arg_28_0.border)

	local var_28_2 = var_28_1.transform

	var_28_2.localScale = arg_28_0.scaleRate
	Vector3 = var_28_2

	local var_28_3 = var_28_2(arg_28_2.y * arg_28_0.normal, -arg_28_2.x * arg_28_0.normal, 0)
	local var_28_4 = var_28_1.transform

	Vector2 = var_6
	var_28_4.anchorMin = var_6(0, 1)

	local var_28_5 = var_28_1.transform

	Vector2 = var_6
	var_28_5.anchorMax = var_6(0, 1)

	local var_28_6 = var_28_1.transform

	var_28_6.anchoredPosition3D = var_28_3
	table = var_28_6

	var_28_6.insert(arg_28_0.marks, {
		name = arg_28_1,
		go = var_28_1
	})

	return
end

function var_0_1.ClearMarks(arg_29_0)
	_ = var_1_10001

	var_1_10001.each(arg_29_0.marks, function(arg_30_0)
		local var_30_0 = arg_30_0.go.transform

		Vector3 = var_2_10002
		var_30_0.localScale = var_2_10002.one

		local var_30_1 = arg_29_0.pool

		var_1.Return(var_30_1, arg_30_0.name, arg_30_0.go)

		return
	end)

	arg_29_0.marks = {}

	return
end

function var_0_1.GetMarkPosition(arg_31_0, arg_31_1, arg_31_2)
	assert = var_1_10003

	var_1_10003(arg_31_0.map)

	local var_31_0 = arg_31_0.map
	local var_31_1 = var_3.GetFleet(var_31_0)
	local var_31_2

	WorldConst = var_31_0

	if var_31_0.InFOVRange(var_31_1.row, var_31_1.column, arg_31_1, arg_31_2, arg_31_0.fov) then
		var_31_2 = arg_31_0:CalcInnerPos(arg_31_1, arg_31_2, var_31_1.row, var_31_1.column)
	else
		var_31_2 = arg_31_0:CalcOutsidePos(arg_31_1, arg_31_2, var_31_1.row, var_31_1.column)
	end

	local var_31_3 = arg_31_0.rangeTF

	return var_6.TransformPoint(var_31_3, var_31_2)
end

function var_0_1.GetEntranceTrackMark(arg_32_0, arg_32_1)
	assert = var_1_10002

	var_1_10002(arg_32_0.entrance)

	nowWorld = var_1_10002

	local var_32_0 = var_1_10002()
	local var_32_1 = var_2.GetMap(var_32_0, arg_32_1)
	local var_32_2, var_32_3 = arg_32_0:getVector(var_32_1)
	local var_32_4, var_32_5 = arg_32_0:getVector(arg_32_0.entrance)
	local var_32_6 = arg_32_0:CalcTaskMarkPos(var_32_2, var_32_3, var_32_4, var_32_5)
	local var_32_7 = arg_32_0.rangeTF

	return var_8.TransformPoint(var_32_7, var_32_6)
end

function var_0_1.Dispose(arg_33_0)
	arg_33_0:RemoveCellsListener()
	arg_33_0:ClearMarks()
	arg_33_0:Clear()

	return
end

return var_0_1
