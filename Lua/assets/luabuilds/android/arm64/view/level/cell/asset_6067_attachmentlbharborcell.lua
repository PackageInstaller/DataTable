local AttachmentLBHarborCell = class("AttachmentLBHarborCell", import("view.level.cell.StaticCellView"))

function AttachmentLBHarborCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentLBHarborCell:Update()
	if IsNil(self.go) then
		self:PrepareBase("box_gangkou")
		self:GetLoader():GetPrefab("leveluiview/Tpl_Box", "Tpl_Box", function(arg_3_0)
			setParent(arg_3_0, self.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3(0, 30, 0)

			self:GetLoader():GetPrefab("boxprefab/gangkou", "gangkou", function(arg_4_0)
				tf(arg_4_0):SetParent(tf(arg_3_0):Find("icon"), false)

				return
			end)

			self.box = arg_3_0

			self:Update()

			return
		end)
	end

	if self.box then
		setActive(findTF(self.box, "effect_found"), self.info.trait == ChapterConst.TraitVirgin)

		if self.info.trait == ChapterConst.TraitVirgin then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
		end
	end

	setActive(self.tf, self.info.flag == ChapterConst.CellFlagActive)

	return
end

return AttachmentLBHarborCell
