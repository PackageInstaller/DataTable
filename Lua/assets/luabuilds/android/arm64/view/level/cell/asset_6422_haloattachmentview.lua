local HaloAttachmentView = class("HaloAttachmentView", import(".StaticCellView"))

function HaloAttachmentView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	HaloAttachmentView.super.Ctor(self, arg_1_1)

	self.line = {
		row = arg_1_2,
		column = arg_1_3
	}

	return
end

function HaloAttachmentView:GetOrder()
	return ChapterConst.CellPriorityUpperEffect
end

function HaloAttachmentView:Update()
	local var_3_0 = self.info.flag == ChapterConst.CellFlagTriggerActive and self.info.trait ~= ChapterConst.TraitLurk

	if IsNil(self.go) then
		self:PrepareBase("story_" .. self.line.row .. "_" .. self.line.column .. "_" .. self.info.attachmentId .. "_upper")

		if pg.map_event_template[self.info.attachmentId].icon and #pg.map_event_template[self.info.attachmentId].icon > 0 then
			self:GetLoader():GetPrefab("ui/" .. pg.map_event_template[self.info.attachmentId].icon .. "_1shangceng", pg.map_event_template[self.info.attachmentId].icon .. "_1shangceng", function(arg_4_0)
				tf(arg_4_0):SetParent(self.tf, false)
				self:ResetCanvasOrder()

				return
			end)
		end
	end

	setActive(self.tf, var_3_0)

	return
end

return HaloAttachmentView
