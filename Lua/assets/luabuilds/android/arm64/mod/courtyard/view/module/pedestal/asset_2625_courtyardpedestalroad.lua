local CourtYardPedestalRoad = class("CourtYardPedestalRoad", import(".CourtYardPedestalStructure"))
local var_0_1 = {
	-920,
	-1080,
	-1230,
	-1230
}

function CourtYardPedestalRoad:GetAssetPath()
	return "furnitrues/base/road_" .. self.level
end

function CourtYardPedestalRoad:OnLoaded(arg_2_1)
	setAnchoredPosition(arg_2_1, Vector3(0, var_0_1[self.level], 0))

	if self.level ~= 4 then
		onButton(self, arg_2_1.transform:Find("warn"), function()
			if CourtYardConst.MAX_STOREY_LEVEL + 1 == self.level then
				return
			end

			if self:IsEditModeOrIsVisit() then
				return
			end

			self.parent.msgBox:ExecuteAction("Show")

			return
		end, SFX_PANEL)
		onButton(self, arg_2_1, function()
			if CourtYardConst.MAX_STOREY_LEVEL + 1 == self.level then
				return
			end

			if self:IsEditModeOrIsVisit() then
				return
			end

			self.parent.msgBox:ExecuteAction("Show")

			return
		end, SFX_PANEL)
	end

	tf(arg_2_1):SetSiblingIndex(0)

	return
end

function CourtYardPedestalRoad:GetParent()
	return self.parent._tf:Find("base")
end

return CourtYardPedestalRoad
