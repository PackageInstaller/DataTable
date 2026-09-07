local AttachmentLBAntiAirCell = class("AttachmentLBAntiAirCell", import("view.level.cell.StaticCellView"))

function AttachmentLBAntiAirCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentLBAntiAirCell:Update()
	local var_2_0 = self.info

	if IsNil(self.go) then
		self:PrepareBase("antiAir")

		local var_2_1 = pg.land_based_template[self.info.attachmentId]

		assert(pg.land_based_template[self.info.attachmentId], "land_based_template not exist: " .. self.info.attachmentId)
		self:GetLoader():GetPrefab("leveluiview/Tpl_AntiAirGun", "Tpl_AntiAirGun", function(arg_3_0)
			setParent(arg_3_0, self.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3(0, 10, 0)
			self.antiAirGun = arg_3_0

			self:Update()

			return
		end)
		self:GetLoader():GetPrefab("leveluiview/Tpl_AntiAirGunArea", "Tpl_AntiAirGunArea", function(arg_4_0)
			setParent(arg_4_0, self.grid.restrictMap)

			arg_4_0.name = "chapter_cell_mark_" .. var_2_0.row .. "_" .. var_2_0.column .. "#AntiAirGunArea"

			local var_4_0 = self.chapter.theme:GetLinePosition(self.line.row, self.line.column)

			tf(arg_4_0).anchoredPosition = Vector2(var_4_0.x - self.grid.restrictMap.anchoredPosition.x, var_4_0.y - self.grid.restrictMap.anchoredPosition.y)
			tf(arg_4_0).sizeDelta = Vector2((var_2_1.function_args[1] * 2 + 1) * self.chapter.theme.cellSize.x + var_2_1.function_args[1] * 2 * self.chapter.theme.cellSpace.x, (var_2_1.function_args[1] * 2 + 1) * self.chapter.theme.cellSize.y + var_2_1.function_args[1] * 2 * self.chapter.theme.cellSpace.y)

			return
		end)
	end

	if self.antiAirGun and self.info.flag ~= ChapterConst.CellFlagDisabled then
		local var_2_2 = math.ceil(self.info.data / 2)

		assert(pg.land_based_template[self.info.attachmentId], "land_based_template not exist: " .. self.info.attachmentId)

		local var_2_3 = pg.land_based_template[self.info.attachmentId].function_args[2]
		local var_2_4 = self.chapter:getRoundNum()

		setActive(tf(self.antiAirGun):Find("text"), var_2_4 < var_2_2)

		tf(self.antiAirGun):Find("Slider"):GetComponent(typeof(Slider)).value = math.max(var_2_4 - var_2_2 + var_2_3, 0) / var_2_3
	end

	setActive(self.tf, self.info.flag ~= ChapterConst.CellFlagDisabled)

	return
end

return AttachmentLBAntiAirCell
