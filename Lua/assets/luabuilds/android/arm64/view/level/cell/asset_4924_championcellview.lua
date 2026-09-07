local EnemyCellView = import(".EnemyCellView")
local SpineCellView = import(".SpineCellView")
local ChampionCellView = class("ChampionCellView", DecorateClass(EnemyCellView, SpineCellView))

function ChampionCellView:Ctor()
	EnemyCellView.Ctor(self)
	SpineCellView.Ctor(self)

	self.autoLoader = AutoLoader.New()

	return
end

function ChampionCellView:InitChampionCellTransform()
	SpineCellView.InitCellTransform(self)

	self.tfEffectFound = self.tf:Find("effect_found")
	self.tfFighting = self.tf:Find("fighting")

	setText(findTF(self.tfFighting, "Text"), i18n("ui_word_levelui2_inevent"))

	self.tfDamageCount = self.tf:Find("damage_count")
	self.tfBufficons = self.tf:Find("random_buff_container")

	return
end

function ChampionCellView:UpdateChampionCell(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_2.trait ~= ChapterConst.TraitLurk and arg_3_2.flag == ChapterConst.CellFlagActive and not arg_3_1:existFleet(FleetType.Transport, arg_3_2.row, arg_3_2.column)

	setActive(self.tfFighting, var_3_0 and arg_3_1:existEnemy(ChapterConst.SubjectChampion, arg_3_2.row, arg_3_2.column))
	setActive(self.tfEffectFound, var_3_0 and arg_3_2.trait == ChapterConst.TraitVirgin)
	setActive(self.tfDamageCount, var_3_0 and arg_3_2.data > 0)
	setActive(self.tf:Find("huoqiubaozha"), false)

	if arg_3_2.trait == ChapterConst.TraitVirgin then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
	end

	self.tfShadow.localEulerAngles = Vector3(arg_3_1.theme.angle, 0, 0)

	if var_3_0 then
		EnemyCellView.RefreshEnemyTplIcons(self, arg_3_2:getConfigTable(), arg_3_1)
	end

	self:SetActive(var_3_0)
	existCall(arg_3_3)

	return
end

function ChampionCellView:LoadSpine(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	SpineCellView.LoadSpine(self, arg_4_1, arg_4_2, nil, function()
		existCall(arg_4_4)
		self:LoadExtraEffects(arg_4_3)

		return
	end)

	return
end

function ChampionCellView:LoadExtraEffects(arg_6_1)
	if arg_6_1 and #arg_6_1 > 0 then
		local var_6_0 = "effect/" .. arg_6_1

		self.autoLoader:LoadPrefab("effect/" .. arg_6_1, arg_6_1, function(arg_7_0)
			self._extraEffectList[var_6_0] = arg_7_0

			setParent(arg_7_0, self.tf, false)

			arg_7_0.transform.localScale = arg_7_0.transform.localScale

			self:ResetCanvasOrder()

			return
		end)
	end

	return
end

function ChampionCellView:Clear()
	SpineCellView.ClearSpine(self)
	EnemyCellView.Clear(self)

	if self.autoLoader then
		self.autoLoader:ClearRequests()
	end

	return
end

return ChampionCellView
