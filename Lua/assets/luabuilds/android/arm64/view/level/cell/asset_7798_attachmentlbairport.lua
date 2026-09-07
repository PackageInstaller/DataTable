local AttachmentLBAirport = class("AttachmentLBAirport", import("view.level.cell.StaticCellView"))

AttachmentLBAirport.StateOutControl = 1
AttachmentLBAirport.StateUnderControl = 2

function AttachmentLBAirport:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentLBAirport:Update()
	if IsNil(self.go) then
		self:PrepareBase("airport")
	end

	if table.contains(self.extraFlagList, ChapterConst.StatusAirportOutControl) and self.state ~= AttachmentLBAirport.StateOutControl then
		self.state = AttachmentLBAirport.StateOutControl

		self:GetLoader():ClearRequest("Dead", AutoLoader.PartLoading)
		self:GetLoader():GetPrefab("chapter/dexiv3_2x2_2", "dexiv3_2x2_2", function(arg_3_0)
			self:GetLoader():ClearRequest("Dead")
			setParent(arg_3_0, self.tf)

			return
		end, "Enemy")
	elseif table.contains(self.extraFlagList, ChapterConst.StatusAirportUnderControl) and self.state ~= AttachmentLBAirport.StateUnderControl then
		self.state = AttachmentLBAirport.StateUnderControl

		self:GetLoader():ClearRequest("Enemy", AutoLoader.PartLoading)
		self:GetLoader():GetPrefab("chapter/dexiv3_2x2_1", "dexiv3_2x2_1", function(arg_4_0)
			self:GetLoader():ClearRequest("Enemy")
			setParent(arg_4_0, self.tf)

			return
		end, "Dead")
	end

	return
end

return AttachmentLBAirport
