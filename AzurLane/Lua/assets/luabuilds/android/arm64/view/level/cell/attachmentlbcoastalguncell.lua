class = var_0_10000

local var_0_0 = "AttachmentLBCoastalGunCell"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.StaticCellView"))

var_0_1.StateLive = 1
var_0_1.StateDead = 2

function var_0_1.GetOrder(arg_1_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityAttachment
end

function var_0_1.Update(arg_2_0)
	local var_2_0 = arg_2_0.info

	IsNil = var_1_10002

	local var_2_1

	if var_1_10002(arg_2_0.go) then
		var_2_1 = arg_2_0

		arg_2_0.PrepareBase(var_2_1, "landbase_" .. var_2_0.attachmentId)
	end

	local var_2_2 = arg_2_0.state
	local var_2_3 = var_2_0.flag

	ChapterConst = var_2_1

	if var_2_3 == var_2_1.CellFlagActive and arg_2_0.state ~= var_0_1.StateLive then
		arg_2_0.state = var_0_1.StateLive
		arg_2_0.dead = nil
		var_1_10005 = arg_2_0

		arg_2_0.ClearLoader(var_1_10005)

		pg = var_3

		local var_2_4 = var_3.land_based_template[var_2_0.attachmentId]

		assert = var_4

		var_4(var_2_4, "land_based_template not exist: " .. var_2_0.attachmentId)

		var_1_10006 = arg_2_0
		var_1_10006 = arg_2_0.GetLoader(var_1_10006)

		var_4.GetPrefab(var_1_10006, "leveluiview/Tpl_Enemy", "Tpl_Enemy", function(arg_3_0)
			setParent = var_2_10001

			var_2_10001(arg_3_0, arg_2_0.tf)

			tf = var_2_10001

			local var_3_0 = var_2_10001(arg_3_0)

			Vector2 = var_2_10002
			var_3_0.anchoredPosition = var_2_10002(0, 10)

			local var_3_1 = arg_2_0
			local var_3_2 = var_1.GetLoader(var_3_1)
			local var_3_3 = var_1.GetSprite
			local var_3_4 = "enemies/" .. var_2_4.prefab
			local var_3_5 = ""

			findTF = var_2_10006

			var_3_3(var_3_2, var_3_4, var_3_5, var_2_10006(arg_3_0, "icon"))

			setActive = var_3_3
			findTF = var_3_2

			var_3_3(var_3_2(arg_3_0, "lv"), false)

			setActive = var_3_3
			findTF = var_3

			var_3_3(var_3(arg_3_0, "titleContain/bg_boss"), false)

			setActive = var_3_3
			findTF = var_3

			var_3_3(var_3(arg_3_0, "damage_count"), false)

			setActive = var_3_3
			findTF = var_3

			var_3_3(var_3(arg_3_0, "fighting"), false)

			arg_2_0.enemy = arg_3_0

			local var_3_6 = arg_2_0

			var_1.Update(var_3_6)

			return
		end)
	else
		local var_2_5 = var_2_0.flag

		ChapterConst = var_4

		if var_2_5 == var_4.CellFlagDisabled and arg_2_0.state ~= var_0_1.StateDead then
			arg_2_0.state = var_0_1.StateDead
			IsNil = var_3

			if not var_3(arg_2_0.enemy) then
				local var_2_6 = arg_2_0.enemy

				setActive = var_4
				findTF = var_1_10006

				var_4(var_1_10006(var_2_6, "lv"), true)

				setActive = var_4
				findTF = var_6

				var_4(var_6(var_2_6, "titleContain"), true)

				setActive = var_4
				findTF = var_6

				var_4(var_6(var_2_6, "damage_count"), true)

				setActive = var_4
				findTF = var_6

				var_4(var_6(var_2_6, "fighting"), true)
			end

			arg_2_0.enemy = nil
			var_1_10005 = arg_2_0

			arg_2_0.ClearLoader(var_1_10005)

			pg = var_3

			local var_2_7 = var_3.land_based_template[var_2_0.attachmentId]

			assert = var_4

			var_4(var_2_7, "land_based_template not exist: " .. var_2_0.attachmentId)

			local var_2_8 = arg_2_0:GetLoader()

			var_4.GetPrefab(var_2_8, "leveluiview/Tpl_Dead", "Tpl_Dead", function(arg_4_0)
				setParent = var_2_10001

				var_2_10001(arg_4_0, arg_2_0.tf)

				tf = var_2_10001

				local var_4_0 = var_2_10001(arg_4_0)

				Vector2 = var_2_10002
				var_4_0.anchoredPosition = var_2_10002(0, 10)

				local var_4_1 = arg_2_0
				local var_4_2 = var_1.GetLoader(var_4_1)
				local var_4_3 = var_1.GetSprite
				local var_4_4 = "enemies/" .. var_2_7.prefab .. "_d_blue"
				local var_4_5 = ""

				findTF = var_6

				var_4_3(var_4_2, var_4_4, var_4_5, var_6(arg_4_0, "icon"))

				setActive = var_4_3
				findTF = var_4_2

				var_4_3(var_4_2(arg_4_0, "effect_not_open"), false)

				setActive = var_4_3
				findTF = var_3

				var_4_3(var_3(arg_4_0, "effect_open"), false)

				setActive = var_4_3
				findTF = var_3

				var_4_3(var_3(arg_4_0, "huoqiubaozha"), var_2_2 == var_0_1.StateLive)

				arg_2_0.dead = arg_4_0

				local var_4_6 = arg_2_0

				var_1.ResetCanvasOrder(var_4_6)

				local var_4_7 = arg_2_0

				var_1.Update(var_4_7)

				return
			end)
		end
	end

	local var_2_9 = var_2_0.flag

	ChapterConst = var_4

	if var_2_9 == var_4.CellFlagActive and arg_2_0.enemy then
		setActive = var_3
		findTF = var_1_10005

		local var_2_10 = var_1_10005(arg_2_0.enemy, "effect_found")
		local var_2_11 = var_2_0.trait

		ChapterConst = var_7

		var_3(var_2_10, var_2_11 == var_7.TraitVirgin)

		local var_2_12 = var_2_0.trait

		ChapterConst = var_4

		if var_2_12 == var_4.TraitVirgin then
			pg = var_2_12

			local var_2_13 = var_2_12.CriMgr.GetInstance()
			local var_2_14 = var_3.PlaySoundEffect_V3

			SFX_UI_WEIGHANCHOR_ENEMY = var_6

			var_2_14(var_2_13, var_6)
		end
	end

	return
end

function var_0_1.DestroyGO(arg_5_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_5_0.enemy) then
		local var_5_0 = arg_5_0.enemy

		setActive = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(var_5_0, "lv"), true)

		setActive = var_1_10002
		findTF = var_4

		var_1_10002(var_4(var_5_0, "titleContain"), true)

		setActive = var_1_10002
		findTF = var_4

		var_1_10002(var_4(var_5_0, "damage_count"), true)

		setActive = var_1_10002
		findTF = var_4

		var_1_10002(var_4(var_5_0, "fighting"), true)
	end

	var_0_1.super.DestroyGO(arg_5_0)

	return
end

return var_0_1
