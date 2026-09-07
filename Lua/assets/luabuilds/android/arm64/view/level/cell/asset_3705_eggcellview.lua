local EggCellView = class("EggCellView", import(".EnemyCellView"))

function EggCellView:InitEggCellTransform()
	self.tfIcon = self.tf:Find("icon")
	self.tfBufficons = self.tf:Find("random_buff_container")
	self.tfBossIcon = self.tf:Find("titleContain/bg_boss")
	self.textLV = self.tf:Find("lv/Text")
	self.tfEffectFound = self.tf:Find("effect_found")
	self.tfEffectFoundBoss = self.tf:Find("effect_found_boss")
	self.tfFighting = self.tf:Find("fighting")

	setText(findTF(self.tfFighting, "Text"), i18n("ui_word_levelui2_inevent"))

	self.tfDamageCount = self.tf:Find("damage_count")
	self.animator = GetComponent(self.go, typeof(Animator))
	self.effectFireball = self.tf:Find("huoqiubaozha")

	return
end

function EggCellView:StartEggCellView(arg_2_1, arg_2_2)
	if ChapterConst.EnemySize[arg_2_1.type] == 99 then
		setActive(self.tfBossIcon, true)
		self:GetLoader():GetSpriteQuiet("ui/share/ship_gizmos_atlas", "enemy_boss", self.tfBossIcon)
	elseif ChapterConst.EnemySize[arg_2_1.type] == 98 then
		setActive(self.tfBossIcon, true)
		self:GetLoader():GetSpriteQuiet("ui/share/ship_gizmos_atlas", "enemy_elite", self.tfBossIcon)
	else
		setActive(self.tfBossIcon, false)
	end

	if ChapterConst.EnemySize[arg_2_1.type] == 98 then
		self.tfBossIcon.localScale = Vector3(0.5, 0.5, 1)
		self.tfBossIcon.anchoredPosition = Vector2(61.1, -30.6)
	else
		self.tfBossIcon.localScale = Vector3(1, 1, 1)
		self.tfBossIcon.anchoredPosition = Vector2(39.5, -23)
	end

	EggCellView.ClearExtraEffects(self)
	EggCellView.LoadExtraEffects(self, arg_2_1.effect_prefab)

	if defaultValue(self.visible, true) then
		self:GetLoader():GetSprite("enemies/" .. arg_2_1.icon, "", self.tfIcon)
	else
		self:GetLoader():GetSprite("enemies/fogsrqz", "", self.tfIcon)
	end

	setText(self.textLV, arg_2_1.level)
	existCall(arg_2_2)

	return
end

function EggCellView:UpdateEggCell(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_1 = arg_3_2.trait ~= ChapterConst.TraitLurk and arg_3_2.flag == ChapterConst.CellFlagActive and not arg_3_1:existFleet(FleetType.Transport, arg_3_2.row, arg_3_2.column)

	setActive(self.tfFighting, var_3_1 and arg_3_1:existEnemy(ChapterConst.SubjectChampion, arg_3_2.row, arg_3_2.column))

	self.animator.enabled = var_3_1 and arg_3_2.data > 0

	setActive(self.tfDamageCount, var_3_1 and arg_3_2.data > 0)
	setActive(self.effectFireball, false)

	if arg_3_2.trait == ChapterConst.TraitVirgin then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
	end

	if var_3_1 then
		EnemyCellView.RefreshEnemyTplIcons(self, arg_3_3, arg_3_1)
	end

	self:SetActive(var_3_1)

	local var_3_2 = arg_3_2.trait == ChapterConst.TraitVirgin
	local var_3_3 = ChapterConst.IsBossCell(arg_3_2)

	setActive(self.tfEffectFound, arg_3_2.trait == ChapterConst.TraitVirgin and not var_3_3)
	setActive(self.tfEffectFoundBoss, var_3_2 and var_3_3)

	if var_3_2 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
	end

	existCall(arg_3_4)

	return
end

return EggCellView
