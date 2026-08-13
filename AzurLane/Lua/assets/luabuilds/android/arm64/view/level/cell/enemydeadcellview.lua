class = var_0_10000

local var_0_0 = "EnemyDeadCellView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.StaticCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.config = nil
	arg_1_0.chapter = nil
	arg_1_0._live2death = nil

	return
end

function var_0_1.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityLittle
end

function var_0_1.Update(arg_3_0)
	local var_3_0 = arg_3_0.info
	local var_3_1 = arg_3_0.config

	IsNil = var_1_10003

	local var_3_2

	if var_1_10003(arg_3_0.go) then
		var_3_2 = arg_3_0
		var_3_2 = arg_3_0.GetLoader(var_3_2)

		var_3.GetPrefab(var_3_2, "leveluiview/Tpl_Dead", "Tpl_Dead", function(arg_4_0)
			arg_4_0.name = "enemy_" .. var_3_0.attachmentId
			arg_3_0.go = arg_4_0

			local var_4_0 = arg_3_0

			tf = var_2_10003
			var_4_0.tf = var_2_10003(arg_4_0)
			setParent = var_4_0

			var_4_0(arg_4_0, arg_3_0.parent)

			local var_4_1 = arg_3_0

			var_2.OverrideCanvas(var_4_1)

			local var_4_2 = arg_3_0

			var_2.ResetCanvasOrder(var_4_2)

			setAnchoredPosition = var_2

			local var_4_3 = arg_3_0.tf

			Vector2 = var_5

			var_2(var_4_3, var_5.zero)

			local var_4_4

			if var_3_1.icon_type == 1 then
				setAnchoredPosition = var_4_4
				var_4_3 = arg_3_0.tf
				Vector2 = var_5

				var_4_4(var_4_3, var_5(0, 10))

				var_4_3 = arg_3_0
				var_4_3 = var_4_4.GetLoader(var_4_3)
				var_4_4 = var_4_4.LoadSprite

				local var_4_5 = "enemies/" .. var_3_1.icon .. "_d_blue"
				local var_4_6 = ""

				tf = var_7

				local var_4_7 = var_7(arg_4_0)

				var_4_4(var_4_3, var_4_5, var_4_6, var_7.Find(var_4_7, "icon"))
			end

			setActive = var_4_4
			findTF = var_4_3

			var_4_4(var_4_3(arg_3_0.tf, "effect_not_open"), false)

			setActive = var_4_4
			findTF = var_4

			var_4_4(var_4(arg_3_0.tf, "effect_open"), false)

			setActive = var_4_4
			findTF = var_4

			var_4_4(var_4(arg_3_0.tf, "huoqiubaozha"), false)

			local var_4_8 = arg_3_0

			var_2.Update(var_4_8)

			return
		end, "Main")

		return
	end

	setActive = var_3
	findTF = var_3_2

	var_3(var_3_2(arg_3_0.tf, "huoqiubaozha"), arg_3_0._live2death)

	return
end

function var_0_1.Clear(arg_5_0)
	arg_5_0._live2death = nil
	arg_5_0.chapter = nil

	var_0_1.super.Clear(arg_5_0)

	return
end

return var_0_1
