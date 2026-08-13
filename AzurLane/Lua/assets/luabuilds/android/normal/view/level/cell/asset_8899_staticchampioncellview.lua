import = var_0_10000

local var_0_0 = var_0_10000(".StaticCellView")

import = var_1

local var_0_1 = var_1(".ChampionCellView")

class = var_2

local var_0_2 = "StaticChampionCellView"

DecorateClass = var_0_10004

local var_0_3 = var_2(var_0_2, var_0_10004(var_0_0, var_0_1))

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_1.Ctor(arg_1_0)

	return
end

function var_0_3.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityEnemy
end

function var_0_3.InitChampionCellTransform(arg_3_0)
	var_0_1.InitChampionCellTransform(arg_3_0)

	local var_3_0 = arg_3_0.tf

	arg_3_0.textLV = var_1.Find(var_3_0, "lv/Text")

	local var_3_1 = arg_3_0.tf

	arg_3_0.tfBossIcon = var_1.Find(var_3_1, "titleContain/bg_boss")

	local var_3_2 = arg_3_0.tf

	arg_3_0.tfEffectFoundBoss = var_1.Find(var_3_2, "effect_found_boss")

	return
end

function var_0_3.Update(arg_4_0)
	local var_4_0 = arg_4_0.info
	local var_4_1 = arg_4_0.config
	local var_4_2 = var_4_0.trait

	ChapterConst = var_1_10004

	local var_4_3 = var_4_2 ~= var_1_10004.TraitLurk

	ChapterConst = var_4

	local var_4_4

	if var_4.IsEnemyAttach(var_4_0.attachment) then
		var_4_4 = var_4_0.flag
		ChapterConst = var_5

		if var_4_4 == var_5.CellFlagActive then
			local var_4_5 = arg_4_0.chapter

			var_4_4 = var_4_4.existFleet
			FleetType = var_1_10006

			if var_4_4(var_4_5, var_1_10006.Transport, var_4_0.row, var_4_0.column) then
				var_4_3 = false
			end
		end
	end

	IsNil = var_4_4

	if not var_4_4(arg_4_0.go) then
		setActive = var_4

		var_4(arg_4_0.go, var_4_3)
	end

	if not var_4_3 then
		return
	end

	IsNil = var_4

	if var_4(arg_4_0.go) then
		local var_4_6 = arg_4_0:GetLoader()

		var_4.GetPrefab(var_4_6, "leveluiview/Tpl_StaticChampion", "Tpl_StaticChampion", function(arg_5_0)
			arg_5_0.name = "enemy_" .. var_4_0.attachmentId
			arg_4_0.go = arg_5_0

			local var_5_0 = arg_4_0

			tf = var_2_10003
			var_5_0.tf = var_2_10003(arg_5_0)
			setParent = var_5_0

			var_5_0(arg_5_0, arg_4_0.parent)

			local var_5_1 = arg_4_0

			var_2.OverrideCanvas(var_5_1)

			local var_5_2 = arg_4_0

			var_2.ResetCanvasOrder(var_5_2)

			setAnchoredPosition = var_2

			local var_5_3 = arg_4_0.tf

			Vector2 = var_4

			var_2(var_5_3, var_4.zero)

			local var_5_4 = arg_4_0

			var_2.InitChampionCellTransform(var_5_4)
			var_0_3.StartEggCellView(arg_4_0, var_4_1)

			SpineCellView = var_2

			local var_5_5 = var_2.SetAction
			local var_5_6 = arg_4_0

			ChapterConst = var_4

			var_5_5(var_5_6, var_4.ShipIdleAction)
			var_0_1.LoadSpine(arg_4_0, var_4_1.icon, var_4_1.scale, var_4_1.effect_prefab)

			local var_5_7 = arg_4_0

			var_2.Update(var_5_7)

			return
		end, "Main")

		return
	end

	arg_4_0:UpdateChampionCell(arg_4_0.chapter, var_4_0)

	return
end

function var_0_3.UpdateChampionCell(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2.trait

	ChapterConst = var_1_10005

	local var_6_4

	if var_6_0 ~= var_1_10005.TraitLurk then
		local var_6_1 = arg_6_2.flag

		ChapterConst = var_5

		if var_6_1 == var_5.CellFlagActive then
			local var_6_2 = arg_6_1
			local var_6_3 = arg_6_1.existFleet

			FleetType = var_1_10006
			var_6_4 = not var_6_3(var_6_2, var_1_10006.Transport, arg_6_2.row, arg_6_2.column)

			goto label_6_0
		end
	end

	var_6_4 = false

	if false then
		var_6_4 = true
	end

	::label_6_0::

	local var_6_5 = arg_6_1
	local var_6_6 = arg_6_1.existEnemy

	ChapterConst = var_1_10007

	local var_6_7 = var_6_6(var_6_5, var_1_10007.SubjectChampion, arg_6_2.row, arg_6_2.column)

	setActive = var_6_5

	var_6_5(arg_6_0.tfFighting, var_6_4 and var_6_7)

	setActive = var_6_5

	var_6_5(arg_6_0.tfDamageCount, var_6_4 and arg_6_2.data > 0)

	local var_6_8 = arg_6_2.trait

	ChapterConst = var_7

	local var_6_9 = var_6_8 == var_7.TraitVirgin

	ChapterConst = var_7

	local var_6_10 = var_7.IsBossCell(arg_6_2)

	setActive = var_8

	var_8(arg_6_0.tfEffectFound, var_6_9 and not var_6_10)

	setActive = var_8

	var_8(arg_6_0.tfEffectFoundBoss, var_6_9 and var_6_10)

	local var_6_11

	if var_6_9 then
		pg = var_8
		var_6_11 = var_8.CriMgr.GetInstance()

		local var_6_12 = var_8.PlaySoundEffect_V3

		SFX_UI_WEIGHANCHOR_ENEMY = var_10

		var_6_12(var_6_11, var_10)
	end

	local var_6_13 = arg_6_0.tfShadow

	Vector3 = var_6_11
	var_6_13.localEulerAngles = var_6_11(arg_6_1.theme.angle, 0, 0)

	if var_6_4 then
		EnemyCellView = var_6_13

		var_6_13.RefreshEnemyTplIcons(arg_6_0, arg_6_0.config, arg_6_1)
	end

	arg_6_0:SetActive(var_6_4)

	existCall = var_8

	var_8(arg_6_3)

	return
end

function var_0_3.StartEggCellView(arg_7_0, arg_7_1, arg_7_2)
	ChapterConst = var_1_10003

	local var_7_0

	if var_1_10003.EnemySize[arg_7_1.type] == 99 then
		setActive = var_3

		var_3(arg_7_0.tfBossIcon, true)

		var_7_0 = arg_7_0
		var_7_0 = arg_7_0.GetLoader(var_7_0)

		var_3.GetSpriteQuiet(var_7_0, "ui/share/ship_gizmos_atlas", "enemy_boss", arg_7_0.tfBossIcon)
	else
		ChapterConst = var_3

		if var_3.EnemySize[arg_7_1.type] == 98 then
			setActive = var_3

			var_3(arg_7_0.tfBossIcon, true)

			var_7_0 = arg_7_0
			var_7_0 = arg_7_0.GetLoader(var_7_0)

			var_3.GetSpriteQuiet(var_7_0, "ui/share/ship_gizmos_atlas", "enemy_elite", arg_7_0.tfBossIcon)
		else
			setActive = var_3

			var_3(arg_7_0.tfBossIcon, false)
		end
	end

	local var_7_1 = arg_7_0.tfBossIcon

	Vector3 = var_7_0
	var_7_1.localScale = var_7_0(0.5, 0.5, 1)

	local var_7_2 = arg_7_0.tfBossIcon

	Vector2 = var_4
	var_7_2.anchoredPosition = var_4(61.1, -30.6)
	setText = var_7_2

	var_7_2(arg_7_0.textLV, arg_7_1.level)

	existCall = var_7_2

	var_7_2(arg_7_2)

	return
end

function var_0_3.Clear(arg_8_0)
	var_0_1.Clear(arg_8_0)
	var_0_0.Clear(arg_8_0)

	return
end

return var_0_3
