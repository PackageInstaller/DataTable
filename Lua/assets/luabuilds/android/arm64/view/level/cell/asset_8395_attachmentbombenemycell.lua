local AttachmentBombEnemyCell = class("AttachmentBombEnemyCell", import("view.level.cell.StaticCellView"))

AttachmentBombEnemyCell.StateLive = 1
AttachmentBombEnemyCell.StateDead = 2

function AttachmentBombEnemyCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentBombEnemyCell:Update()
	if IsNil(self.go) then
		self:PrepareBase("bomb_enemy_" .. self.info.attachmentId)
	end

	local var_2_0 = self.state

	if self.info.flag == ChapterConst.CellFlagActive and self.state ~= AttachmentBombEnemyCell.StateLive then
		self.state = AttachmentBombEnemyCell.StateLive
		self.dead = nil

		self:ClearLoader()

		local var_2_1 = pg.specialunit_template[self.info.attachmentId]

		assert(pg.specialunit_template[self.info.attachmentId], "specialunit_template not exist: " .. self.info.attachmentId)
		self:GetLoader():GetPrefab("leveluiview/Tpl_Enemy", "Tpl_Enemy", function(arg_3_0)
			setParent(arg_3_0, self.tf)

			tf(arg_3_0).anchoredPosition = Vector2(0, 10)

			self:GetLoader():GetSprite("enemies/" .. var_2_1.prefab, "", findTF(arg_3_0, "icon"))
			setActive(findTF(arg_3_0, "titleContain/bg_s"), var_2_1.enemy_point == 5)
			setActive(findTF(arg_3_0, "titleContain/bg_m"), var_2_1.enemy_point == 8)
			setActive(findTF(arg_3_0, "titleContain/bg_h"), var_2_1.enemy_point == 10)

			self.enemy = arg_3_0

			self:ResetCanvasOrder()
			self:Update()

			return
		end)
	elseif self.info.flag == ChapterConst.CellFlagDisabled and self.state ~= AttachmentBombEnemyCell.StateDead then
		self.state = AttachmentBombEnemyCell.StateDead
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
			setActive(findTF(arg_4_0, "huoqiubaozha"), var_2_0 == AttachmentBombEnemyCell.StateLive)

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

return AttachmentBombEnemyCell
