local AttachmentBarrierCell = class("AttachmentBarrierCell", import("view.level.cell.StaticCellView"))

function AttachmentBarrierCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentBarrierCell:Update()
	if IsNil(self.go) then
		self:PrepareBase("zulanwangheng")
		self:GetLoader():GetPrefab("chapter/zulanwangheng", "zulanwangheng", function(arg_3_0)
			setParent(arg_3_0, self.tf)
			setActive(arg_3_0, true)

			self.barrier = arg_3_0

			self:Update()

			return
		end)
	end

	setActive(self.tf, self.info.flag == ChapterConst.CellFlagActive)

	return
end

return AttachmentBarrierCell
