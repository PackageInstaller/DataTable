import = var_0_10000

local var_0_0 = var_0_10000(".EnemyCellView")

import = var_0_10001

local var_0_1 = var_0_10001(".SpineCellView")

class = var_2

local var_0_2 = "ChampionCellView"

DecorateClass = var_0_10005

local var_0_3 = var_2(var_0_2, var_0_10005(var_0_0, var_0_1))

function var_0_3.Ctor(arg_1_0)
	var_0_0.Ctor(arg_1_0)
	var_0_1.Ctor(arg_1_0)

	AutoLoader = var_1
	arg_1_0.autoLoader = var_1.New()

	return
end

function var_0_3.InitChampionCellTransform(arg_2_0)
	var_0_1.InitCellTransform(arg_2_0)

	local var_2_0 = arg_2_0.tf

	arg_2_0.tfEffectFound = var_1.Find(var_2_0, "effect_found")

	local var_2_1 = arg_2_0.tf

	arg_2_0.tfFighting = var_1.Find(var_2_1, "fighting")
	setText = var_1
	findTF = var_2_1

	local var_2_2 = var_2_1(arg_2_0.tfFighting, "Text")

	i18n = var_4

	var_1(var_2_2, var_4("ui_word_levelui2_inevent"))

	local var_2_3 = arg_2_0.tf

	arg_2_0.tfDamageCount = var_1.Find(var_2_3, "damage_count")

	local var_2_4 = arg_2_0.tf

	arg_2_0.tfBufficons = var_1.Find(var_2_4, "random_buff_container")

	return
end

function var_0_3.UpdateChampionCell(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_2.trait

	ChapterConst = var_1_10005

	local var_3_3

	if var_3_0 ~= var_1_10005.TraitLurk then
		local var_3_1 = arg_3_2.flag

		ChapterConst = var_5

		if var_3_1 == var_5.CellFlagActive then
			var_1_10006 = arg_3_1

			local var_3_2 = arg_3_1.existFleet

			FleetType = var_1_10007
			var_3_3 = not var_3_2(var_1_10006, var_1_10007.Transport, arg_3_2.row, arg_3_2.column)

			goto label_3_0
		end
	end

	var_3_3 = false

	if false then
		var_3_3 = true
	end

	::label_3_0::

	local var_3_4 = arg_3_1
	local var_3_5 = arg_3_1.existEnemy

	ChapterConst = var_1_10008

	local var_3_6 = var_3_5(var_3_4, var_1_10008.SubjectChampion, arg_3_2.row, arg_3_2.column)

	setActive = var_1_10006

	var_1_10006(arg_3_0.tfFighting, var_3_3 and var_3_6)

	setActive = var_1_10006

	local var_3_7 = arg_3_0.tfEffectFound
	local var_3_8

	if var_3_3 then
		::label_3_1::

		var_3_8 = arg_3_2.trait
		ChapterConst = var_10
		var_3_8 = var_3_8 == var_10.TraitVirgin
	end

	var_1_10006(var_3_7, var_3_8)

	setActive = var_1_10006

	var_1_10006(arg_3_0.tfDamageCount, var_3_3 and arg_3_2.data > 0)

	setActive = var_1_10006

	local var_3_9 = arg_3_0.tf

	var_1_10006(var_8.Find(var_3_9, "huoqiubaozha"), false)

	local var_3_10 = arg_3_2.trait

	ChapterConst = var_3_4

	if var_3_10 == var_3_4.TraitVirgin then
		pg = var_3_10

		local var_3_11 = var_3_10.CriMgr.GetInstance()
		local var_3_12 = var_6.PlaySoundEffect_V3

		SFX_UI_WEIGHANCHOR_ENEMY = var_9

		var_3_12(var_3_11, var_9)
	end

	local var_3_13 = arg_3_0.tfShadow

	Vector3 = var_7
	var_3_13.localEulerAngles = var_7(arg_3_1.theme.angle, 0, 0)

	if var_3_3 then
		var_0_0.RefreshEnemyTplIcons(arg_3_0, arg_3_2:getConfigTable(), arg_3_1)
	end

	arg_3_0:SetActive(var_3_3)

	existCall = var_6

	var_6(arg_3_3)

	return
end

function var_0_3.LoadSpine(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	var_0_1.LoadSpine(arg_4_0, arg_4_1, arg_4_2, nil, function()
		existCall = var_2_10000

		var_2_10000(arg_4_4)
		arg_4_0.LoadExtraEffects(arg_4_0, arg_4_3)

		return
	end)

	return
end

function var_0_3.LoadExtraEffects(arg_6_0, arg_6_1)
	if arg_6_1 and #arg_6_1 > 0 then
		local var_6_0 = "effect/" .. arg_6_1
		local var_6_1 = arg_6_0.autoLoader

		var_3.LoadPrefab(var_6_1, var_6_0, arg_6_1, function(arg_7_0)
			arg_6_0._extraEffectList[var_6_0] = arg_7_0

			local var_7_0 = arg_7_0.transform.localScale

			setParent = var_2

			var_2(arg_7_0, arg_6_0.tf, false)

			arg_7_0.transform.localScale = var_7_0

			local var_7_1 = arg_6_0

			var_2.ResetCanvasOrder(var_7_1)

			return
		end)
	end

	return
end

function var_0_3.Clear(arg_8_0)
	var_0_1.ClearSpine(arg_8_0)
	var_0_0.Clear(arg_8_0)

	if arg_8_0.autoLoader then
		local var_8_0 = arg_8_0.autoLoader

		var_1.ClearRequests(var_8_0)
	end

	return
end

return var_0_3
