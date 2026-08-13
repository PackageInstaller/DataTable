class = var_0_10000

local var_0_0 = "EggCellView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".EnemyCellView"))

function var_0_1.InitEggCellTransform(arg_1_0)
	local var_1_0 = arg_1_0.tf

	arg_1_0.tfIcon = var_1.Find(var_1_0, "icon")

	local var_1_1 = arg_1_0.tf

	arg_1_0.tfBufficons = var_1.Find(var_1_1, "random_buff_container")

	local var_1_2 = arg_1_0.tf

	arg_1_0.tfBossIcon = var_1.Find(var_1_2, "titleContain/bg_boss")

	local var_1_3 = arg_1_0.tf

	arg_1_0.textLV = var_1.Find(var_1_3, "lv/Text")

	local var_1_4 = arg_1_0.tf

	arg_1_0.tfEffectFound = var_1.Find(var_1_4, "effect_found")

	local var_1_5 = arg_1_0.tf

	arg_1_0.tfEffectFoundBoss = var_1.Find(var_1_5, "effect_found_boss")

	local var_1_6 = arg_1_0.tf

	arg_1_0.tfFighting = var_1.Find(var_1_6, "fighting")
	setText = var_1
	findTF = var_1_6

	local var_1_7 = var_1_6(arg_1_0.tfFighting, "Text")

	i18n = var_3

	var_1(var_1_7, var_3("ui_word_levelui2_inevent"))

	local var_1_8 = arg_1_0.tf

	arg_1_0.tfDamageCount = var_1.Find(var_1_8, "damage_count")
	GetComponent = var_1

	local var_1_9 = arg_1_0.go

	typeof = var_3
	Animator = var_4
	arg_1_0.animator = var_1(var_1_9, var_3(var_4))

	local var_1_10 = arg_1_0.tf

	arg_1_0.effectFireball = var_1.Find(var_1_10, "huoqiubaozha")

	return
end

function var_0_1.StartEggCellView(arg_2_0, arg_2_1, arg_2_2)
	ChapterConst = var_1_10003

	if var_1_10003.EnemySize[arg_2_1.type] == 99 then
		setActive = var_3

		var_3(arg_2_0.tfBossIcon, true)

		local var_2_0 = arg_2_0:GetLoader()

		var_3.GetSpriteQuiet(var_2_0, "ui/share/ship_gizmos_atlas", "enemy_boss", arg_2_0.tfBossIcon)
	else
		ChapterConst = var_3

		if var_3.EnemySize[arg_2_1.type] == 98 then
			setActive = var_3

			var_3(arg_2_0.tfBossIcon, true)

			local var_2_1 = arg_2_0:GetLoader()

			var_3.GetSpriteQuiet(var_2_1, "ui/share/ship_gizmos_atlas", "enemy_elite", arg_2_0.tfBossIcon)
		else
			setActive = var_3

			var_3(arg_2_0.tfBossIcon, false)
		end
	end

	ChapterConst = var_3

	if var_3.EnemySize[arg_2_1.type] == 98 then
		local var_2_2 = arg_2_0.tfBossIcon

		Vector3 = var_4
		var_2_2.localScale = var_4(0.5, 0.5, 1)

		local var_2_3 = arg_2_0.tfBossIcon

		Vector2 = var_4
		var_2_3.anchoredPosition = var_4(61.1, -30.6)
	else
		local var_2_4 = arg_2_0.tfBossIcon

		Vector3 = var_4
		var_2_4.localScale = var_4(1, 1, 1)

		local var_2_5 = arg_2_0.tfBossIcon

		Vector2 = var_4
		var_2_5.anchoredPosition = var_4(39.5, -23)
	end

	var_0_1.ClearExtraEffects(arg_2_0)
	var_0_1.LoadExtraEffects(arg_2_0, arg_2_1.effect_prefab)

	defaultValue = var_3

	if var_3(arg_2_0.visible, true) then
		local var_2_6 = arg_2_0:GetLoader()

		var_3.GetSprite(var_2_6, "enemies/" .. arg_2_1.icon, "", arg_2_0.tfIcon)
	else
		local var_2_7 = arg_2_0:GetLoader()

		var_3.GetSprite(var_2_7, "enemies/fogsrqz", "", arg_2_0.tfIcon)
	end

	setText = var_3

	var_3(arg_2_0.textLV, arg_2_1.level)

	existCall = var_3

	var_3(arg_2_2)

	return
end

function var_0_1.UpdateEggCell(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_2.row
	local var_3_1 = arg_3_2.column
	local var_3_2 = arg_3_2.trait

	ChapterConst = var_1_10008

	local var_3_6

	if var_3_2 ~= var_1_10008.TraitLurk then
		local var_3_3 = arg_3_2.flag

		ChapterConst = var_8

		if var_3_3 == var_8.CellFlagActive then
			local var_3_4 = arg_3_1
			local var_3_5 = arg_3_1.existFleet

			FleetType = var_1_10009
			var_3_6 = not var_3_5(var_3_4, var_1_10009.Transport, var_3_0, var_3_1)

			goto label_3_0
		end
	end

	var_3_6 = false

	if false then
		var_3_6 = true
	end

	::label_3_0::

	local var_3_7 = arg_3_1
	local var_3_8 = arg_3_1.existEnemy

	ChapterConst = var_1_10010

	local var_3_9 = var_3_8(var_3_7, var_1_10010.SubjectChampion, var_3_0, var_3_1)

	setActive = var_3_7

	var_3_7(arg_3_0.tfFighting, var_3_6 and var_3_9)

	local var_3_10 = arg_3_0.animator

	var_3_10.enabled = var_3_6 and arg_3_2.data > 0
	setActive = var_3_10

	var_3_10(arg_3_0.tfDamageCount, var_3_6 and arg_3_2.data > 0)

	setActive = var_3_10

	var_3_10(arg_3_0.effectFireball, false)

	local var_3_11 = arg_3_2.trait

	ChapterConst = var_10

	if var_3_11 == var_10.TraitVirgin then
		pg = var_3_11

		local var_3_12 = var_3_11.CriMgr.GetInstance()

		var_3_11 = var_3_11.PlaySoundEffect_V3
		SFX_UI_WEIGHANCHOR_ENEMY = var_11

		var_3_11(var_3_12, var_11)
	end

	if var_3_6 then
		EnemyCellView = var_3_11

		var_3_11.RefreshEnemyTplIcons(arg_3_0, arg_3_3, arg_3_1)
	end

	local var_3_13 = arg_3_0

	arg_3_0.SetActive(var_3_13, var_3_6)

	local var_3_14 = arg_3_2.trait

	ChapterConst = var_3_13

	local var_3_15 = var_3_14 == var_3_13.TraitVirgin

	ChapterConst = var_10

	local var_3_16 = var_10.IsBossCell(arg_3_2)

	setActive = var_3_18

	var_3_18(arg_3_0.tfEffectFound, var_3_15 and not var_3_16)

	setActive = var_3_18

	var_3_18(arg_3_0.tfEffectFoundBoss, var_3_15 and var_3_16)

	local var_3_18

	if var_3_15 then
		pg = var_3_18

		local var_3_17 = var_3_18.CriMgr.GetInstance()

		var_3_18 = var_3_18.PlaySoundEffect_V3
		SFX_UI_WEIGHANCHOR_ENEMY = var_13

		var_3_18(var_3_17, var_13)
	end

	existCall = var_3_18

	var_3_18(arg_3_4)

	return
end

return var_0_1
