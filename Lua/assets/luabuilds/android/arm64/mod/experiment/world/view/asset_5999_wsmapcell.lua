local WSMapCell = class("WSMapCell", import("...BaseEntity"))

WSMapCell.Fields = {
	cell = "table",
	map = "table",
	rtFog = "userdata",
	transform = "userdata",
	wsMapResource = "table",
	rtAttachments = "userdata",
	maskTimer = "table",
	maskUid = "number",
	wsTimer = "table",
	fogTimer = "table",
	fogUid = "number",
	rtMask = "userdata"
}
WSMapCell.Listeners = {
	onUpdate = "Update",
	onUpdateFogImage = "UpdateFogImage"
}

function WSMapCell.GetResName()
	return "world_cell"
end

function WSMapCell:GetName(arg_2_1)
	return "cell_" .. self .. "_" .. arg_2_1
end

function WSMapCell:Setup(arg_3_1, arg_3_2)
	assert(self.cell == nil)

	self.map = arg_3_1
	self.cell = arg_3_2

	self.cell:AddListener(WorldMapCell.EventUpdateInFov, self.onUpdate)
	self.cell:AddListener(WorldMapCell.EventUpdateDiscovered, self.onUpdate)
	self.cell:AddListener(WorldMapCell.EventUpdateFog, self.onUpdate)
	self.cell:AddListener(WorldMapCell.EventUpdateFogImage, self.onUpdateFogImage)
	self:Init()

	return
end

function WSMapCell:Dispose()
	if self.fogTimer then
		self.wsTimer:RemoveInMapTimer(self.fogTimer)

		self.fogTimer = nil
	end

	if self.fogUid then
		self.wsTimer:RemoveInMapTween(self.fogUid)

		self.fogUid = nil
	end

	if self.maskTimer then
		self.wsTimer:RemoveInMapTimer(self.maskTimer)

		self.maskTimer = nil
	end

	if self.maskUid then
		self.wsTimer:RemoveInMapTween(self.maskUid)

		self.maskUid = nil
	end

	clearImageSprite(self.rtFog:Find("dark_fog"))
	clearImageSprite(self.rtFog:Find("sairen_fog"))
	setCanvasGroupAlpha(self.rtFog, 1)
	self.cell:RemoveListener(WorldMapCell.EventUpdateInFov, self.onUpdate)
	self.cell:RemoveListener(WorldMapCell.EventUpdateDiscovered, self.onUpdate)
	self.cell:RemoveListener(WorldMapCell.EventUpdateFog, self.onUpdate)
	self.cell:RemoveListener(WorldMapCell.EventUpdateFogImage, self.onUpdateFogImage)
	self:Clear()

	return
end

local function var_0_1(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.anchoredPosition = arg_5_1.anchoredPosition + Vector2((arg_5_2.column % 3 - 1) * -arg_5_3.x, (arg_5_2.row % 3 - 1) * arg_5_3.y)
	arg_5_0.localScale = arg_5_1.localScale

	setImageSprite(arg_5_0, getImageSprite(arg_5_1), true)

	return
end

function WSMapCell:Init()
	self.transform.name = WSMapCell.GetName(self.cell.row, self.cell.column)
	self.transform.anchoredPosition = self.map.theme:GetLinePosition(self.cell.row, self.cell.column)
	self.transform.sizeDelta = self.map.theme.cellSize
	self.rtAttachments = self.transform:Find("attachments")
	self.rtAttachments.localEulerAngles = Vector3(-self.map.theme.angle, 0, 0)
	self.rtMask = self.transform:Find("mask")
	self.rtMask.sizeDelta = self.map.theme.cellSize + Vector2(WorldConst.LineCross * 2, WorldConst.LineCross * 2)
	self.rtFog = self.transform:Find("fog")

	local var_6_0 = self.map.theme.cellSize + self.map.theme.cellSpace

	var_0_1(self.rtFog:Find("dark_fog"), self.wsMapResource.rtDarkFog:Find(WorldConst.Pos2FogRes(self.cell.row, self.cell.column)), self.cell, var_6_0)
	var_0_1(self.rtFog:Find("sairen_fog"), self.wsMapResource.rtSairenFog:Find(WorldConst.Pos2FogRes(self.cell.row, self.cell.column)), self.cell, var_6_0)
	self:Update()
	self:UpdateFogImage()

	return
end

function WSMapCell:Update(arg_7_1)
	local var_7_1 = 0
	local var_7_2 = 0

	if self.map.centerCellFOV then
		var_7_1 = math.sqrt((self.map.centerCellFOV.row - self.cell.row) * (self.map.centerCellFOV.row - self.cell.row) + (self.map.centerCellFOV.column - self.cell.column) * (self.map.centerCellFOV.column - self.cell.column)) * 0.1
		var_7_2 = 0.2
	end

	if arg_7_1 ~= nil and arg_7_1 ~= WorldMapCell.EventUpdateInFov then
		if arg_7_1 == WorldMapCell.EventUpdateFog then
			setActive(self.rtAttachments, self.cell:GetInFOV() and not self.cell:InFog())
		end

		if arg_7_1 == nil or arg_7_1 == WorldMapCell.EventUpdateFog then
			if self.fogTimer then
				self.wsTimer:RemoveInMapTimer(self.fogTimer)

				self.fogTimer = nil
			end

			if self.fogUid then
				self.wsTimer:RemoveInMapTween(self.fogUid)

				self.fogUid = nil
			end

			if self.cell:InFog() then
				if arg_7_1 and var_7_1 > 0 then
					setCanvasGroupAlpha(self.rtFog, 0)

					self.fogTimer = self.wsTimer:AddInMapTimer(function()
						self.fogUid = LeanTween.alphaCanvas(GetComponent(self.rtFog, typeof(CanvasGroup)), 1, var_7_2).uniqueId

						self.wsTimer:AddInMapTween(self.fogUid)

						return
					end, var_7_1)

					self.fogTimer:Start()
				else
					setCanvasGroupAlpha(self.rtFog, 1)
				end
			elseif arg_7_1 and var_7_1 > 0 then
				self.fogTimer = self.wsTimer:AddInMapTimer(function()
					self.fogUid = LeanTween.alphaCanvas(GetComponent(self.rtFog, typeof(CanvasGroup)), 0, var_7_2).uniqueId

					self.wsTimer:AddInMapTween(self.fogUid)

					return
				end, var_7_1)

				self.fogTimer:Start()
			else
				setCanvasGroupAlpha(self.rtFog, 0)
			end
		end

		if arg_7_1 == nil or arg_7_1 == WorldMapCell.EventUpdateInFov or arg_7_1 == WorldMapCell.EventUpdateDiscovered then
			if self.maskTimer then
				self.wsTimer:RemoveInMapTimer(self.maskTimer)

				self.maskTimer = nil
			end

			if self.maskUid then
				self.wsTimer:RemoveInMapTween(self.maskUid)

				self.maskUid = nil
			end

			if self.cell:GetInFOV() then
				if arg_7_1 and var_7_1 > 0 then
					self.maskTimer = self.wsTimer:AddInMapTimer(function()
						self.maskUid = LeanTween.alpha(self.rtMask, 0, var_7_2).uniqueId

						self.wsTimer:AddInMapTween(self.maskUid)

						return
					end, var_7_1)

					self.maskTimer:Start()
				else
					setImageAlpha(self.rtMask, 0)
				end
			else
				local var_7_3 = self.cell.discovered and 0.3 or 0.8

				if arg_7_1 and var_7_1 > 0 then
					self.maskTimer = self.wsTimer:AddInMapTimer(function()
						self.maskUid = LeanTween.alpha(self.rtMask, var_7_3, var_7_2).uniqueId

						self.wsTimer:AddInMapTween(self.maskUid)

						return
					end, var_7_1)

					self.maskTimer:Start()
				else
					setImageAlpha(self.rtMask, var_7_3)
				end
			end
		end
	end

	return
end

function WSMapCell:UpdateFogImage()
	local var_12_0 = self.cell:LookSairenFog()

	setImageAlpha(self.rtFog:Find("dark_fog"), var_12_0 and 0 or 1)
	setImageAlpha(self.rtFog:Find("sairen_fog"), var_12_0 and 1 or 0)

	return
end

function WSMapCell:GetWorldPos()
	return self.transform.parent:TransformPoint((Vector3.New(self.transform.localPosition.x, self.transform.localPosition.y, 0)))
end

return WSMapCell
