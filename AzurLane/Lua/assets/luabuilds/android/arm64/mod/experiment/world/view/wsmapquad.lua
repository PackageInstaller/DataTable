local var_0_0 = class("WSMapQuad", import("...BaseEntity"))

var_0_0.Fields = {
	static = "boolean",
	twId = "number",
	rtWalkQuad = "userdata",
	transform = "userdata",
	cell = "table",
	twTimer = "userdata",
	theme = "table",
	rtQuad = "userdata"
}

function var_0_0.GetResName()
	return "world_cell_quad"
end

var_0_0.Listeners = {
	onAddAttachment = "OnAddAttachment",
	onRemoveAttachment = "OnRemoveAttachment",
	onUpdate = "Update",
	onUpdateAttachment = "OnUpdateAttachment"
}

function var_0_0.GetName(arg_2_0, arg_2_1)
	return "world_quad_" .. arg_2_0 .. "_" .. arg_2_1
end

function var_0_0.Setup(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.cell = arg_3_1

	arg_3_0.cell:AddListener(WorldMapCell.EventUpdateInFov, arg_3_0.onUpdate)
	arg_3_0.cell:AddListener(WorldMapCell.EventAddAttachment, arg_3_0.onAddAttachment)
	arg_3_0.cell:AddListener(WorldMapCell.EventRemoveAttachment, arg_3_0.onRemoveAttachment)
	arg_3_0.cell:AddListener(WorldMapCell.EventUpdateFog, arg_3_0.onUpdate)
	_.each(arg_3_0.cell.attachments, function(arg_4_0)
		arg_3_0:OnAddAttachment(nil, arg_3_0.cell, arg_4_0)

		return
	end)

	arg_3_0.theme = arg_3_2

	arg_3_0:Init()

	return
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.twId then
		LeanTween.cancel(arg_5_0.twId)
	end

	arg_5_0.cell:RemoveListener(WorldMapCell.EventUpdateInFov, arg_5_0.onUpdate)
	arg_5_0.cell:RemoveListener(WorldMapCell.EventAddAttachment, arg_5_0.onAddAttachment)
	arg_5_0.cell:RemoveListener(WorldMapCell.EventRemoveAttachment, arg_5_0.onRemoveAttachment)
	arg_5_0.cell:RemoveListener(WorldMapCell.EventUpdateFog, arg_5_0.onUpdate)
	_.each(arg_5_0.cell.attachments, function(arg_6_0)
		arg_5_0:OnRemoveAttachment(nil, arg_5_0.cell, arg_6_0)

		return
	end)
	arg_5_0:Clear()

	return
end

function var_0_0.Init(arg_7_0)
	arg_7_0.rtQuad = arg_7_0.transform:Find("quad")
	arg_7_0.transform.name = var_0_0.GetName(arg_7_0.cell.row, arg_7_0.cell.column)
	arg_7_0.transform.anchoredPosition = arg_7_0.theme:GetLinePosition(arg_7_0.cell.row, arg_7_0.cell.column)
	arg_7_0.rtQuad.sizeDelta = arg_7_0.theme.cellSize
	arg_7_0.rtWalkQuad = arg_7_0.transform:Find("walk_quad") or cloneTplTo(arg_7_0.rtQuad, arg_7_0.transform, "walk_quad")

	arg_7_0.rtWalkQuad:SetSiblingIndex(arg_7_0.rtQuad:GetSiblingIndex())
	setImageAlpha(arg_7_0.rtWalkQuad, 0)
	GetImageSpriteFromAtlasAsync("world/cell/base", WorldConst.QuadSpriteWhite, arg_7_0.rtWalkQuad)
	arg_7_0:Update()

	return
end

function var_0_0.Update(arg_8_0, arg_8_1)
	if arg_8_1 == nil or arg_8_1 == WorldMapCell.EventUpdateInFov or arg_8_1 == WorldMapCell.EventUpdateFog then
		arg_8_0:OnUpdateAttachment()
	end

	return
end

function var_0_0.OnAddAttachment(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_3:AddListener(WorldMapAttachment.EventUpdateFlag, arg_9_0.onUpdateAttachment)
	arg_9_3:AddListener(WorldMapAttachment.EventUpdateData, arg_9_0.onUpdateAttachment)
	arg_9_3:AddListener(WorldMapAttachment.EventUpdateLurk, arg_9_0.onUpdateAttachment)

	if arg_9_1 then
		arg_9_0:OnUpdateAttachment()
	end

	return
end

function var_0_0.OnRemoveAttachment(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_3:RemoveListener(WorldMapAttachment.EventUpdateFlag, arg_10_0.onUpdateAttachment)
	arg_10_3:RemoveListener(WorldMapAttachment.EventUpdateData, arg_10_0.onUpdateAttachment)
	arg_10_3:RemoveListener(WorldMapAttachment.EventUpdateLurk, arg_10_0.onUpdateAttachment)

	if arg_10_1 then
		arg_10_0:OnUpdateAttachment()
	end

	return
end

function var_0_0.UpdateStatic(arg_11_0, arg_11_1, arg_11_2)
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

function var_0_0.OnUpdateAttachment(arg_12_0)
	if arg_12_0.twId then
		LeanTween.cancel(arg_12_0.twId)

		arg_12_0.twId = nil
	end

	local var_12_0 = arg_12_0.cell:GetDisplayQuad()

	if arg_12_0.cell:GetInFOV() and not arg_12_0.static and var_12_0 and not arg_12_0.cell:InFog() then
		local var_12_1 = var_12_0[2] or WorldConst.QuadBlinkDuration

		if var_12_0[3] then
			local var_12_2 = var_12_0[3] / 100 or 1

			if var_12_0[4] then
				local var_12_3 = var_12_0[4] / 100 or 0

				GetImageSpriteFromAtlasAsync("world/cell/base", var_12_0[1], arg_12_0.rtQuad)
				setLocalScale(arg_12_0.rtQuad, Vector3.one)

				local var_12_4 = LeanTween.alpha(arg_12_0.rtQuad, var_12_3, var_12_1):setFrom(var_12_2):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

				var_12_4.passed = arg_12_0.twTimer.passed
				var_12_4.direction = arg_12_0.twTimer.direction
				arg_12_0.twId = var_12_4.uniqueId

				local var_12_5 = var_12_4.passed / var_12_1 * (var_12_2 - var_12_3) + var_12_3

				setImageAlpha(arg_12_0.rtQuad, var_12_4.direction > 0 and var_12_5 or 1 - var_12_5)

				goto label_12_0

				setImageAlpha(arg_12_0.rtQuad, 0)

				::label_12_0::

				return
			end
		end
	end
end

function var_0_0.UpdateScannerQuad(arg_13_0)
	if arg_13_0.twId then
		LeanTween.cancel(arg_13_0.twId)

		arg_13_0.twId = nil
	end

	if arg_13_0.cell:GetInFOV() and arg_13_0.cell:GetScannerAttachment() then
		setImageAlpha(arg_13_0.rtQuad, 1)
		GetImageSpriteFromAtlasAsync("world/cell/base", "cell_yellow", arg_13_0.rtQuad)
	else
		setImageAlpha(arg_13_0.rtQuad, 0)
	end

	return
end

return var_0_0
