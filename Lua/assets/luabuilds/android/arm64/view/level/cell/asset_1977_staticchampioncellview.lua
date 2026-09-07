local StaticCellView = import(".StaticCellView")
local ChampionCellView = import(".ChampionCellView")
local StaticChampionCellView = class("StaticChampionCellView", DecorateClass(StaticCellView, ChampionCellView))

function StaticChampionCellView:Ctor(arg_1_1)
	StaticCellView.Ctor(self, arg_1_1)
	ChampionCellView.Ctor(self)

	return
end

function StaticChampionCellView:GetOrder()
	return ChapterConst.CellPriorityEnemy
end

function StaticChampionCellView:InitChampionCellTransform()
	ChampionCellView.InitChampionCellTransform(self)

	self.textLV = self.tf:Find("lv/Text")
	self.tfBossIcon = self.tf:Find("titleContain/bg_boss")
	self.tfEffectFoundBoss = self.tf:Find("effect_found_boss")

	return
end

function StaticChampionCellView:Update()
	local var_4_0 = self.info
	local var_4_1 = self.config
	local var_4_2 = self.info.trait ~= ChapterConst.TraitLurk

	if ChapterConst.IsEnemyAttach(self.info.attachment) and self.info.flag == ChapterConst.CellFlagActive and self.chapter:existFleet(FleetType.Transport, self.info.row, self.info.column) then
		var_4_2 = false
	end

	if not IsNil(self.go) then
		setActive(self.go, var_4_2)
	end

	if not var_4_2 then
		return
	end

	if IsNil(self.go) then
		self:GetLoader():GetPrefab("leveluiview/Tpl_StaticChampion", "Tpl_StaticChampion", function(arg_5_0)
			arg_5_0.name = "enemy_" .. var_4_0.attachmentId
			self.go = arg_5_0
			self.tf = tf(arg_5_0)

			setParent(arg_5_0, self.parent)
			self:OverrideCanvas()
			self:ResetCanvasOrder()
			setAnchoredPosition(self.tf, Vector2.zero)
			self:InitChampionCellTransform()
			StaticChampionCellView.StartEggCellView(self, var_4_1)
			SpineCellView.SetAction(self, ChapterConst.ShipIdleAction)
			ChampionCellView.LoadSpine(self, var_4_1.icon, var_4_1.scale, var_4_1.effect_prefab)
			self:Update()

			return
		end, "Main")

		return
	end

	self:UpdateChampionCell(self.chapter, self.info)

	return
end

function StaticChampionCellView:UpdateChampionCell(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2.trait ~= ChapterConst.TraitLurk and arg_6_2.flag == ChapterConst.CellFlagActive and not arg_6_1:existFleet(FleetType.Transport, arg_6_2.row, arg_6_2.column)

	setActive(self.tfFighting, var_6_0 and arg_6_1:existEnemy(ChapterConst.SubjectChampion, arg_6_2.row, arg_6_2.column))
	setActive(self.tfDamageCount, var_6_0 and arg_6_2.data > 0)

	local var_6_1 = arg_6_2.trait == ChapterConst.TraitVirgin
	local var_6_2 = ChapterConst.IsBossCell(arg_6_2)

	setActive(self.tfEffectFound, arg_6_2.trait == ChapterConst.TraitVirgin and not var_6_2)
	setActive(self.tfEffectFoundBoss, var_6_1 and var_6_2)

	if var_6_1 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
	end

	self.tfShadow.localEulerAngles = Vector3(arg_6_1.theme.angle, 0, 0)

	if var_6_0 then
		EnemyCellView.RefreshEnemyTplIcons(self, self.config, arg_6_1)
	end

	self:SetActive(var_6_0)
	existCall(arg_6_3)

	return
end

function StaticChampionCellView:StartEggCellView(arg_7_1, arg_7_2)
	if ChapterConst.EnemySize[arg_7_1.type] == 99 then
		setActive(self.tfBossIcon, true)
		self:GetLoader():GetSpriteQuiet("ui/share/ship_gizmos_atlas", "enemy_boss", self.tfBossIcon)
	elseif ChapterConst.EnemySize[arg_7_1.type] == 98 then
		setActive(self.tfBossIcon, true)
		self:GetLoader():GetSpriteQuiet("ui/share/ship_gizmos_atlas", "enemy_elite", self.tfBossIcon)
	else
		setActive(self.tfBossIcon, false)
	end

	self.tfBossIcon.localScale = Vector3(0.5, 0.5, 1)
	self.tfBossIcon.anchoredPosition = Vector2(61.1, -30.6)

	setText(self.textLV, arg_7_1.level)
	existCall(arg_7_2)

	return
end

function StaticChampionCellView:Clear()
	ChampionCellView.Clear(self)
	StaticCellView.Clear(self)

	return
end

return StaticChampionCellView
