local AttachmentLBFogLightBase = class("AttachmentLBFogLightBase", import("view.level.cell.StaticCellView"))

AttachmentLBFogLightBase.StateLive = 1
AttachmentLBFogLightBase.StateDead = 2

function AttachmentLBFogLightBase:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentLBFogLightBase:Update()
	if IsNil(self.go) then
		self:PrepareBase("landbase_" .. self.info.attachmentId)
	end

	if self.info.flag == ChapterConst.CellFlagActive and self.state ~= AttachmentLBFogLightBase.StateLive then
		self.state = AttachmentLBFogLightBase.StateLive
		self.dead = nil

		self:ClearLoader()
		assert(pg.land_based_template[self.info.attachmentId], "land_based_template not exist: " .. self.info.attachmentId)
		self:GetLoader():GetPrefab("chapter/" .. pg.land_based_template[self.info.attachmentId].prefab, "", function(arg_3_0)
			setParent(arg_3_0, self.tf)

			self.enemy = arg_3_0

			self:ResetCanvasOrder()
			self:Update()

			return
		end)
	elseif self.info.flag == ChapterConst.CellFlagDisabled and self.state ~= AttachmentLBFogLightBase.StateDead then
		self.state = AttachmentLBFogLightBase.StateDead
		self.enemy = nil

		self:ClearLoader()
		assert(pg.land_based_template[self.info.attachmentId], "land_based_template not exist: " .. self.info.attachmentId)
		self:GetLoader():GetPrefab("chapter/" .. pg.land_based_template[self.info.attachmentId].prefab .. "_d_blue", "", function(arg_4_0)
			setParent(arg_4_0, self.tf)

			self.dead = arg_4_0

			self:ResetCanvasOrder()
			self:Update()

			return
		end)
	end

	return
end

return AttachmentLBFogLightBase
