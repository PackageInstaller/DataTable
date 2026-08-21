local var_0_0 = class("StaticChampionCellView", DecorateClass(import(".StaticCellView"), (import(".ChampionCellView"))))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0)

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityEnemy
end

function var_0_0.InitChampionCellTransform(arg_3_0)
	var_0.InitChampionCellTransform(arg_3_0)

	arg_3_0.textLV = arg_3_0.tf:Find("lv/Text")
	arg_3_0.tfBossIcon = arg_3_0.tf:Find("titleContain/bg_boss")
	arg_3_0.tfEffectFoundBoss = arg_3_0.tf:Find("effect_found_boss")

	return
end

function var_0_0.Update(arg_4_0)
	local var_4_0 = arg_4_0.info
	local var_4_1 = arg_4_0.config
	local var_4_2 = arg_4_0.info.trait ~= ChapterConst.TraitLurk

	if ChapterConst.IsEnemyAttach(arg_4_0.info.attachment) and arg_4_0.info.flag == ChapterConst.CellFlagActive and arg_4_0.chapter:existFleet(FleetType.Transport, arg_4_0.info.row, arg_4_0.info.column) then
		var_4_2 = false
	end

	if not IsNil(arg_4_0.go) then
		setActive(arg_4_0.go, var_4_2)
	end

	if not var_4_2 then
		return
	end

	if IsNil(arg_4_0.go) then
		arg_4_0:GetLoader():GetPrefab("leveluiview/Tpl_StaticChampion", "Tpl_StaticChampion", function(arg_5_0)
			arg_5_0.name = "enemy_" .. var_4_0.attachmentId
			arg_4_0.go = arg_5_0
			arg_4_0.tf = tf(arg_5_0)

			setParent(arg_5_0, arg_4_0.parent)
			arg_4_0:OverrideCanvas()
			arg_4_0:ResetCanvasOrder()
			setAnchoredPosition(arg_4_0.tf, Vector2.zero)
			arg_4_0:InitChampionCellTransform()
			var_0_0.StartEggCellView(arg_4_0, var_4_1)
			SpineCellView.SetAction(arg_4_0, ChapterConst.ShipIdleAction)
			var_0.LoadSpine(arg_4_0, var_4_1.icon, var_4_1.scale, var_4_1.effect_prefab)
			arg_4_0:Update()

			return
		end, "Main")

		return
	end

	arg_4_0:UpdateChampionCell(arg_4_0.chapter, arg_4_0.info)

	return
end

function var_0_0.UpdateChampionCell(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2.trait ~= ChapterConst.TraitLurk and arg_6_2.flag == ChapterConst.CellFlagActive and not arg_6_1:existFleet(FleetType.Transport, arg_6_2.row, arg_6_2.column)
	local var_6_1 = arg_6_1:existEnemy(ChapterConst.SubjectChampion, arg_6_2.row, arg_6_2.column)

	setActive(arg_6_0.tfFighting, var_6_0 and var_6_1)
	setActive(arg_6_0.tfDamageCount, var_6_0 and arg_6_2.data > 0)

	local var_6_2 = arg_6_2.trait == ChapterConst.TraitVirgin
	local var_6_3 = ChapterConst.IsBossCell(arg_6_2)

	setActive(arg_6_0.tfEffectFound, arg_6_2.trait == ChapterConst.TraitVirgin and not var_6_3)
	setActive(arg_6_0.tfEffectFoundBoss, var_6_2 and var_6_3)

	if var_6_2 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
	end

	arg_6_0.tfShadow.localEulerAngles = Vector3(arg_6_1.theme.angle, 0, 0)

	if var_6_0 then
		EnemyCellView.RefreshEnemyTplIcons(arg_6_0, arg_6_0.config, arg_6_1)
	end

	arg_6_0:SetActive(var_6_0)
	existCall(arg_6_3)

	return
end

function var_0_0.StartEggCellView(arg_7_0, arg_7_1, arg_7_2)
	if ChapterConst.EnemySize[arg_7_1.type] == 99 then
		setActive(arg_7_0.tfBossIcon, true)
		arg_7_0:GetLoader():GetSpriteQuiet("ui/share/ship_gizmos_atlas", "enemy_boss", arg_7_0.tfBossIcon)
	elseif ChapterConst.EnemySize[arg_7_1.type] == 98 then
		setActive(arg_7_0.tfBossIcon, true)
		arg_7_0:GetLoader():GetSpriteQuiet("ui/share/ship_gizmos_atlas", "enemy_elite", arg_7_0.tfBossIcon)
	else
		setActive(arg_7_0.tfBossIcon, false)
	end

	arg_7_0.tfBossIcon.localScale = Vector3(0.5, 0.5, 1)
	arg_7_0.tfBossIcon.anchoredPosition = Vector2(61.1, -30.6)

	setText(arg_7_0.textLV, arg_7_1.level)
	existCall(arg_7_2)

	return
end

function var_0_0.Clear(arg_8_0)
	var_0.Clear(arg_8_0)
	var_0.Clear(arg_8_0)

	return
end

return var_0_0
