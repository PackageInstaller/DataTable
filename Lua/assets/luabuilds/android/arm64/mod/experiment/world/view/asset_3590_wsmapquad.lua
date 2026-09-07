local WSMapQuad = class("WSMapQuad", import("...BaseEntity"))

WSMapQuad.Fields = {
	static = "boolean",
	twId = "number",
	rtWalkQuad = "userdata",
	transform = "userdata",
	cell = "table",
	twTimer = "userdata",
	theme = "table",
	rtQuad = "userdata"
}

function WSMapQuad.GetResName()
	return "world_cell_quad"
end

WSMapQuad.Listeners = {
	onAddAttachment = "OnAddAttachment",
	onRemoveAttachment = "OnRemoveAttachment",
	onUpdate = "Update",
	onUpdateAttachment = "OnUpdateAttachment"
}

function WSMapQuad:GetName(arg_2_1)
	return "world_quad_" .. self .. "_" .. arg_2_1
end

function WSMapQuad:Setup(arg_3_1, arg_3_2)
	self.cell = arg_3_1

	self.cell:AddListener(WorldMapCell.EventUpdateInFov, self.onUpdate)
	self.cell:AddListener(WorldMapCell.EventAddAttachment, self.onAddAttachment)
	self.cell:AddListener(WorldMapCell.EventRemoveAttachment, self.onRemoveAttachment)
	self.cell:AddListener(WorldMapCell.EventUpdateFog, self.onUpdate)
	_.each(self.cell.attachments, function(arg_4_0)
		self:OnAddAttachment(nil, self.cell, arg_4_0)

		return
	end)

	self.theme = arg_3_2

	self:Init()

	return
end

function WSMapQuad:Dispose()
	if self.twId then
		LeanTween.cancel(self.twId)
	end

	self.cell:RemoveListener(WorldMapCell.EventUpdateInFov, self.onUpdate)
	self.cell:RemoveListener(WorldMapCell.EventAddAttachment, self.onAddAttachment)
	self.cell:RemoveListener(WorldMapCell.EventRemoveAttachment, self.onRemoveAttachment)
	self.cell:RemoveListener(WorldMapCell.EventUpdateFog, self.onUpdate)
	_.each(self.cell.attachments, function(arg_6_0)
		self:OnRemoveAttachment(nil, self.cell, arg_6_0)

		return
	end)
	self:Clear()

	return
end

function WSMapQuad:Init()
	self.rtQuad = self.transform:Find("quad")
	self.transform.name = WSMapQuad.GetName(self.cell.row, self.cell.column)
	self.transform.anchoredPosition = self.theme:GetLinePosition(self.cell.row, self.cell.column)
	self.rtQuad.sizeDelta = self.theme.cellSize
	self.rtWalkQuad = self.transform:Find("walk_quad") or cloneTplTo(self.rtQuad, self.transform, "walk_quad")

	self.rtWalkQuad:SetSiblingIndex(self.rtQuad:GetSiblingIndex())
	setImageAlpha(self.rtWalkQuad, 0)
	GetImageSpriteFromAtlasAsync("world/cell/base", WorldConst.QuadSpriteWhite, self.rtWalkQuad)
	self:Update()

	return
end

function WSMapQuad:Update(arg_8_1)
	if arg_8_1 == nil or arg_8_1 == WorldMapCell.EventUpdateInFov or arg_8_1 == WorldMapCell.EventUpdateFog then
		self:OnUpdateAttachment()
	end

	return
end

function WSMapQuad:OnAddAttachment(arg_9_1, arg_9_2, arg_9_3)
	arg_9_3:AddListener(WorldMapAttachment.EventUpdateFlag, self.onUpdateAttachment)
	arg_9_3:AddListener(WorldMapAttachment.EventUpdateData, self.onUpdateAttachment)
	arg_9_3:AddListener(WorldMapAttachment.EventUpdateLurk, self.onUpdateAttachment)

	if arg_9_1 then
		self:OnUpdateAttachment()
	end

	return
end

function WSMapQuad:OnRemoveAttachment(arg_10_1, arg_10_2, arg_10_3)
	arg_10_3:RemoveListener(WorldMapAttachment.EventUpdateFlag, self.onUpdateAttachment)
	arg_10_3:RemoveListener(WorldMapAttachment.EventUpdateData, self.onUpdateAttachment)
	arg_10_3:RemoveListener(WorldMapAttachment.EventUpdateLurk, self.onUpdateAttachment)

	if arg_10_1 then
		self:OnUpdateAttachment()
	end

	return
end

function WSMapQuad:UpdateStatic(arg_11_1, arg_11_2)
	if self.static ~= arg_11_1 then
		self.static = arg_11_1

		if arg_11_2 then
			self:UpdateScannerQuad()
		else
			self:OnUpdateAttachment()
		end
	end

	return
end

function WSMapQuad:OnUpdateAttachment()
	if self.twId then
		LeanTween.cancel(self.twId)

		self.twId = nil
	end

	local var_12_0 = self.cell:GetDisplayQuad()

	if self.cell:GetInFOV() and not self.static and var_12_0 and not self.cell:InFog() then
		local var_12_1 = var_12_0[2] or WorldConst.QuadBlinkDuration
		local var_12_2

		if var_12_0[3] then
			var_12_2 = var_12_0[3] / 100 or 1

			local var_12_3

			if var_12_0[4] then
				var_12_3 = var_12_0[4] / 100 or 0
			end
		end

		GetImageSpriteFromAtlasAsync("world/cell/base", var_12_0[1], self.rtQuad)
		setLocalScale(self.rtQuad, Vector3.one)

		local var_12_4 = LeanTween.alpha(self.rtQuad, var_12_3, var_12_1):setFrom(var_12_2):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

		var_12_4.passed = self.twTimer.passed
		var_12_4.direction = self.twTimer.direction
		self.twId = var_12_4.uniqueId

		local var_12_5 = var_12_4.passed / var_12_1 * (var_12_2 - var_12_3) + var_12_3

		setImageAlpha(self.rtQuad, var_12_4.direction > 0 and var_12_5 or 1 - var_12_5)
	else
		setImageAlpha(self.rtQuad, 0)
	end

	return
end

function WSMapQuad:UpdateScannerQuad()
	if self.twId then
		LeanTween.cancel(self.twId)

		self.twId = nil
	end

	if self.cell:GetInFOV() and self.cell:GetScannerAttachment() then
		setImageAlpha(self.rtQuad, 1)
		GetImageSpriteFromAtlasAsync("world/cell/base", "cell_yellow", self.rtQuad)
	else
		setImageAlpha(self.rtQuad, 0)
	end

	return
end

return WSMapQuad
