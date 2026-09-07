local AttachmentLBDockCell = class("AttachmentLBDockCell", import("view.level.cell.StaticCellView"))

function AttachmentLBDockCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentLBDockCell:Update()
	if IsNil(self.go) then
		self:PrepareBase("dock")
		self:GetLoader():GetPrefab("leveluiview/Tpl_Dockyard", "Tpl_Dockyard", function(arg_3_0)
			setParent(arg_3_0, self.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3(0, 10, 0)
			self.dock = tf(arg_3_0)

			self:Update()

			return
		end)
	end

	if self.dock then
		local var_2_0 = pg.land_based_template[self.info.attachmentId]

		assert(pg.land_based_template[self.info.attachmentId], "land_based_template not exist: " .. self.info.attachmentId)

		local var_2_1 = self.chapter:getRoundNum()
		local var_2_2 = math.ceil(self.info.data / 2)

		setActive(self.dock:Find("text"), var_2_1 < var_2_2)

		self.dock:Find("Slider"):GetComponent(typeof(Slider)).value = math.max(var_2_1 - var_2_2 + var_2_0.function_args[2], 0) / var_2_0.function_args[2]
	end

	setActive(self.tf, self.info.flag == ChapterConst.CellFlagActive)

	return
end

return AttachmentLBDockCell
