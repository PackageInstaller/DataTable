class = var_0_10000

local var_0_0 = "WSMapQuad"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	static = "boolean",
	twId = "number",
	rtWalkQuad = "userdata",
	transform = "userdata",
	cell = "table",
	twTimer = "userdata",
	theme = "table",
	rtQuad = "userdata"
}

function var_0_1.GetResName()
	return "world_cell_quad"
end

var_0_1.Listeners = {
	onAddAttachment = "OnAddAttachment",
	onRemoveAttachment = "OnRemoveAttachment",
	onUpdate = "Update",
	onUpdateAttachment = "OnUpdateAttachment"
}

function var_0_1.GetName(arg_2_0, arg_2_1)
	return "world_quad_" .. arg_2_0 .. "_" .. arg_2_1
end

function var_0_1.Setup(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.cell = arg_3_1

	local var_3_0 = arg_3_0.cell
	local var_3_1 = var_3.AddListener

	WorldMapCell = var_1_10005

	var_3_1(var_3_0, var_1_10005.EventUpdateInFov, arg_3_0.onUpdate)

	local var_3_2 = arg_3_0.cell
	local var_3_3 = var_3.AddListener

	WorldMapCell = var_5

	var_3_3(var_3_2, var_5.EventAddAttachment, arg_3_0.onAddAttachment)

	local var_3_4 = arg_3_0.cell
	local var_3_5 = var_3.AddListener

	WorldMapCell = var_5

	var_3_5(var_3_4, var_5.EventRemoveAttachment, arg_3_0.onRemoveAttachment)

	local var_3_6 = arg_3_0.cell
	local var_3_7 = var_3.AddListener

	WorldMapCell = var_5

	var_3_7(var_3_6, var_5.EventUpdateFog, arg_3_0.onUpdate)

	_ = var_3_7

	var_3_7.each(arg_3_0.cell.attachments, function(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.OnAddAttachment(var_4_0, nil, arg_3_0.cell, arg_4_0)

		return
	end)

	arg_3_0.theme = arg_3_2

	arg_3_0:Init()

	return
end

function var_0_1.Dispose(arg_5_0)
	if arg_5_0.twId then
		LeanTween = var_1

		var_1.cancel(arg_5_0.twId)
	end

	local var_5_0 = arg_5_0.cell
	local var_5_1 = var_1.RemoveListener

	WorldMapCell = var_1_10003

	var_5_1(var_5_0, var_1_10003.EventUpdateInFov, arg_5_0.onUpdate)

	local var_5_2 = arg_5_0.cell
	local var_5_3 = var_1.RemoveListener

	WorldMapCell = var_3

	var_5_3(var_5_2, var_3.EventAddAttachment, arg_5_0.onAddAttachment)

	local var_5_4 = arg_5_0.cell
	local var_5_5 = var_1.RemoveListener

	WorldMapCell = var_3

	var_5_5(var_5_4, var_3.EventRemoveAttachment, arg_5_0.onRemoveAttachment)

	local var_5_6 = arg_5_0.cell
	local var_5_7 = var_1.RemoveListener

	WorldMapCell = var_3

	var_5_7(var_5_6, var_3.EventUpdateFog, arg_5_0.onUpdate)

	_ = var_5_7

	var_5_7.each(arg_5_0.cell.attachments, function(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.OnRemoveAttachment(var_6_0, nil, arg_5_0.cell, arg_6_0)

		return
	end)
	arg_5_0:Clear()

	return
end

function var_0_1.Init(arg_7_0)
	local var_7_0 = arg_7_0.cell
	local var_7_1 = arg_7_0.transform

	arg_7_0.rtQuad = var_2.Find(var_7_1, "quad")
	var_2.name = var_0_1.GetName(var_7_0.row, var_7_0.column)

	local var_7_2 = arg_7_0.theme

	var_2.anchoredPosition = var_3.GetLinePosition(var_7_2, var_7_0.row, var_7_0.column)
	arg_7_0.rtQuad.sizeDelta = arg_7_0.theme.cellSize

	local var_7_3

	if not var_2:Find("walk_quad") then
		cloneTplTo = var_7_3
		var_7_3 = var_7_3(arg_7_0.rtQuad, var_2, "walk_quad")
	end

	arg_7_0.rtWalkQuad = var_7_3

	local var_7_4 = arg_7_0.rtWalkQuad
	local var_7_5 = var_3.SetSiblingIndex
	local var_7_6 = arg_7_0.rtQuad

	var_7_5(var_7_4, var_5.GetSiblingIndex(var_7_6))

	setImageAlpha = var_7_5

	var_7_5(arg_7_0.rtWalkQuad, 0)

	GetImageSpriteFromAtlasAsync = var_7_5

	local var_7_7 = "world/cell/base"

	WorldConst = var_5

	var_7_5(var_7_7, var_5.QuadSpriteWhite, arg_7_0.rtWalkQuad)
	arg_7_0:Update()

	return
end

function var_0_1.Update(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.cell

	if arg_8_1 ~= nil then
		WorldMapCell = var_1_10003

		if arg_8_1 ~= var_1_10003.EventUpdateInFov then
			WorldMapCell = var_3

			if arg_8_1 == var_3.EventUpdateFog then
				arg_8_0:OnUpdateAttachment()
			end

			return
		end
	end
end

function var_0_1.OnAddAttachment(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_3
	local var_9_1 = arg_9_3.AddListener

	WorldMapAttachment = var_1_10006

	var_9_1(var_9_0, var_1_10006.EventUpdateFlag, arg_9_0.onUpdateAttachment)

	local var_9_2 = arg_9_3
	local var_9_3 = arg_9_3.AddListener

	WorldMapAttachment = var_6

	var_9_3(var_9_2, var_6.EventUpdateData, arg_9_0.onUpdateAttachment)

	local var_9_4 = arg_9_3
	local var_9_5 = arg_9_3.AddListener

	WorldMapAttachment = var_6

	var_9_5(var_9_4, var_6.EventUpdateLurk, arg_9_0.onUpdateAttachment)

	if arg_9_1 then
		arg_9_0:OnUpdateAttachment()
	end

	return
end

function var_0_1.OnRemoveAttachment(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_3
	local var_10_1 = arg_10_3.RemoveListener

	WorldMapAttachment = var_1_10006

	var_10_1(var_10_0, var_1_10006.EventUpdateFlag, arg_10_0.onUpdateAttachment)

	local var_10_2 = arg_10_3
	local var_10_3 = arg_10_3.RemoveListener

	WorldMapAttachment = var_6

	var_10_3(var_10_2, var_6.EventUpdateData, arg_10_0.onUpdateAttachment)

	local var_10_4 = arg_10_3
	local var_10_5 = arg_10_3.RemoveListener

	WorldMapAttachment = var_6

	var_10_5(var_10_4, var_6.EventUpdateLurk, arg_10_0.onUpdateAttachment)

	if arg_10_1 then
		arg_10_0:OnUpdateAttachment()
	end

	return
end

function var_0_1.UpdateStatic(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.static ~= arg_11_1 then
		arg_11_0.static = arg_11_1

		if arg_11_2 then
			arg_11_0:UpdateScannerQuad()
		else
			arg_11_0:OnUpdateAttachment()
		end
	end

	return
end

function var_0_1.OnUpdateAttachment(arg_12_0)
	if arg_12_0.twId then
		LeanTween = var_1

		var_1.cancel(arg_12_0.twId)

		arg_12_0.twId = nil
	end

	local var_12_0 = arg_12_0.cell
	local var_12_1 = var_1.GetDisplayQuad(var_12_0)
	local var_12_2 = arg_12_0.cell
	local var_12_4

	if var_2.GetInFOV(var_12_2) and not arg_12_0.static and var_12_1 then
		local var_12_3 = arg_12_0.cell

		if not var_12_4.InFog(var_12_3) then
			if not var_12_1[2] then
				WorldConst = var_12_4
				var_12_4 = var_12_4.QuadBlinkDuration
			end

			local var_12_5

			if not var_12_1[3] or not (var_12_1[3] / 100) then
				var_12_5 = 1
			end

			local var_12_6

			if not var_12_1[4] or not (var_12_1[4] / 100) then
				var_12_6 = 0
			end

			GetImageSpriteFromAtlasAsync = var_1_10005

			var_1_10005("world/cell/base", var_12_1[1], arg_12_0.rtQuad)

			setLocalScale = var_1_10005

			local var_12_7 = arg_12_0.rtQuad

			Vector3 = var_7

			var_1_10005(var_12_7, var_7.one)

			LeanTween = var_1_10005

			local var_12_8 = var_1_10005.alpha(arg_12_0.rtQuad, var_12_6, var_12_4)
			local var_12_9 = var_5.setFrom(var_12_8, var_12_5)
			local var_12_10 = var_5.setEase

			LeanTweenType = var_7

			local var_12_11 = var_12_10(var_12_9, var_7.easeInOutSine)
			local var_12_12 = var_5.setLoopPingPong(var_12_11)

			var_12_12.passed = arg_12_0.twTimer.passed
			var_12_12.direction = arg_12_0.twTimer.direction
			arg_12_0.twId = var_12_12.uniqueId

			local var_12_13 = var_12_12.passed / var_12_4 * (var_12_5 - var_12_6) + var_12_6

			setImageAlpha = var_7

			var_7(arg_12_0.rtQuad, var_12_12.direction > 0 and var_12_13 or 1 - var_12_13)

			goto label_12_0
		end
	end

	setImageAlpha = var_12_4

	var_12_4(arg_12_0.rtQuad, 0)

	::label_12_0::

	return
end

function var_0_1.UpdateScannerQuad(arg_13_0)
	if arg_13_0.twId then
		LeanTween = var_1

		var_1.cancel(arg_13_0.twId)

		arg_13_0.twId = nil
	end

	local var_13_0 = arg_13_0.cell
	local var_13_2

	if var_1.GetInFOV(var_13_0) then
		local var_13_1 = arg_13_0.cell

		if var_13_2.GetScannerAttachment(var_13_1) then
			var_13_2 = "cell_yellow"
			setImageAlpha = var_13_1

			var_13_1(arg_13_0.rtQuad, 1)

			GetImageSpriteFromAtlasAsync = var_13_1

			var_13_1("world/cell/base", var_13_2, arg_13_0.rtQuad)

			goto label_13_0
		end
	end

	setImageAlpha = var_13_2

	var_13_2(arg_13_0.rtQuad, 0)

	::label_13_0::

	return
end

return var_0_1
