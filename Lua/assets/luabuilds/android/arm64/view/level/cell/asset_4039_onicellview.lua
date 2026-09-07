local OniCellView = class("OniCellView", (import(".DynamicCellView")))

function OniCellView:Ctor(arg_1_1)
	OniCellView.super.Ctor(self, arg_1_1)

	self.tfShadow = self.tf:Find("shadow")
	self.tfIcon = self.tf:Find("ship/icon")

	return
end

function OniCellView:GetOrder()
	return ChapterConst.CellPriorityLittle
end

function OniCellView:SetActive(arg_3_1)
	SetActive(self.tf, arg_3_1)

	return
end

function OniCellView:UpdateChampionCell(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_2.trait ~= ChapterConst.TraitLurk and arg_4_1:getChampionVisibility(arg_4_2) and not arg_4_1:existFleet(FleetType.Transport, arg_4_2.row, arg_4_2.column)
	local var_4_1 = 1

	_.each(arg_4_1.fleets, function(arg_5_0)
		if arg_4_2:inAlertRange(arg_5_0.line.row, arg_5_0.line.column) then
			var_4_1 = var_4_1 + 1
		end

		return
	end)
	GetImageSpriteFromAtlasAsync("enemies/sp_" .. var_4_1, "", self.tfIcon, true)

	self.tfShadow.localEulerAngles = Vector3(arg_4_1.theme.angle, 0, 0)

	self:RefreshLinePosition(arg_4_1, arg_4_2)
	self:SetActive(var_4_0)
	existCall(arg_4_3)

	return
end

return OniCellView
