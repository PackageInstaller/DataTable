local AttachmentLBCoastalGunCell = class("AttachmentLBCoastalGunCell", import("view.level.cell.StaticCellView"))

AttachmentLBCoastalGunCell.StateLive = 1
AttachmentLBCoastalGunCell.StateDead = 2

function AttachmentLBCoastalGunCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentLBCoastalGunCell:Update()
	if IsNil(self.go) then
		self:PrepareBase("landbase_" .. self.info.attachmentId)
	end

	local var_2_0 = self.state

	if self.info.flag == ChapterConst.CellFlagActive and self.state ~= AttachmentLBCoastalGunCell.StateLive then
		self.state = AttachmentLBCoastalGunCell.StateLive
		self.dead = nil

		self:ClearLoader()

		local var_2_1 = pg.land_based_template[self.info.attachmentId]

		assert(pg.land_based_template[self.info.attachmentId], "land_based_template not exist: " .. self.info.attachmentId)
		self:GetLoader():GetPrefab("leveluiview/Tpl_Enemy", "Tpl_Enemy", function(arg_3_0)
			setParent(arg_3_0, self.tf)

			tf(arg_3_0).anchoredPosition = Vector2(0, 10)

			self:GetLoader():GetSprite("enemies/" .. var_2_1.prefab, "", findTF(arg_3_0, "icon"))
			setActive(findTF(arg_3_0, "lv"), false)
			setActive(findTF(arg_3_0, "titleContain/bg_boss"), false)
			setActive(findTF(arg_3_0, "damage_count"), false)
			setActive(findTF(arg_3_0, "fighting"), false)

			self.enemy = arg_3_0

			self:Update()

			return
		end)
	elseif self.info.flag == ChapterConst.CellFlagDisabled and self.state ~= AttachmentLBCoastalGunCell.StateDead then
		self.state = AttachmentLBCoastalGunCell.StateDead

		if not IsNil(self.enemy) then
			setActive(findTF(self.enemy, "lv"), true)
			setActive(findTF(self.enemy, "titleContain"), true)
			setActive(findTF(self.enemy, "damage_count"), true)
			setActive(findTF(self.enemy, "fighting"), true)
		end

		self.enemy = nil

		self:ClearLoader()

		local var_2_2 = pg.land_based_template[self.info.attachmentId]

		assert(pg.land_based_template[self.info.attachmentId], "land_based_template not exist: " .. self.info.attachmentId)
		self:GetLoader():GetPrefab("leveluiview/Tpl_Dead", "Tpl_Dead", function(arg_4_0)
			setParent(arg_4_0, self.tf)

			tf(arg_4_0).anchoredPosition = Vector2(0, 10)

			self:GetLoader():GetSprite("enemies/" .. var_2_2.prefab .. "_d_blue", "", findTF(arg_4_0, "icon"))
			setActive(findTF(arg_4_0, "effect_not_open"), false)
			setActive(findTF(arg_4_0, "effect_open"), false)
			setActive(findTF(arg_4_0, "huoqiubaozha"), var_2_0 == AttachmentLBCoastalGunCell.StateLive)

			self.dead = arg_4_0

			self:ResetCanvasOrder()
			self:Update()

			return
		end)
	end

	if self.info.flag == ChapterConst.CellFlagActive and self.enemy then
		setActive(findTF(self.enemy, "effect_found"), self.info.trait == ChapterConst.TraitVirgin)

		if self.info.trait == ChapterConst.TraitVirgin then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
		end
	end

	return
end

function AttachmentLBCoastalGunCell:DestroyGO()
	if not IsNil(self.enemy) then
		setActive(findTF(self.enemy, "lv"), true)
		setActive(findTF(self.enemy, "titleContain"), true)
		setActive(findTF(self.enemy, "damage_count"), true)
		setActive(findTF(self.enemy, "fighting"), true)
	end

	AttachmentLBCoastalGunCell.super.DestroyGO(self)

	return
end

return AttachmentLBCoastalGunCell
