class = var_0_10000

local var_0_0 = "AttachmentLBHarborCell"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.StaticCellView"))

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

		arg_2_0.PrepareBase(var_2_1, "box_gangkou")

		var_2_1 = arg_2_0
		var_2_1 = arg_2_0.GetLoader(var_2_1)

		var_2.GetPrefab(var_2_1, "leveluiview/Tpl_Box", "Tpl_Box", function(arg_3_0)
			setParent = var_2_10001

			var_2_10001(arg_3_0, arg_2_0.tf)

			tf = var_2_10001

			local var_3_0 = var_2_10001(arg_3_0)

			Vector3 = var_2_10002
			var_3_0.anchoredPosition3D = var_2_10002(0, 30, 0)

			local var_3_1 = arg_2_0
			local var_3_2 = var_1.GetLoader(var_3_1)

			var_1.GetPrefab(var_3_2, "boxprefab/gangkou", "gangkou", function(arg_4_0)
				tf = var_3_10001

				local var_4_0 = var_3_10001(arg_4_0)
				local var_4_1 = var_1.SetParent

				tf = var_3_10004

				local var_4_2 = var_3_10004(arg_3_0)

				var_4_1(var_4_0, var_4.Find(var_4_2, "icon"), false)

				return
			end)

			arg_2_0.box = arg_3_0

			local var_3_3 = arg_2_0

			var_1.Update(var_3_3)

			return
		end)
	end

	local var_2_4

	if arg_2_0.box then
		setActive = var_2_4
		findTF = var_2_1

		local var_2_2 = var_2_1(arg_2_0.box, "effect_found")
		local var_2_3 = var_2_0.trait

		ChapterConst = var_1_10006

		var_2_4(var_2_2, var_2_3 == var_1_10006.TraitVirgin)

		var_2_4 = var_2_0.trait
		ChapterConst = var_1_10003

		if var_2_4 == var_1_10003.TraitVirgin then
			pg = var_2_4

			local var_2_5 = var_2_4.CriMgr.GetInstance()

			var_2_4 = var_2_4.PlaySoundEffect_V3
			SFX_UI_WEIGHANCHOR_ENEMY = var_5

			var_2_4(var_2_5, var_5)
		end
	end

	setActive = var_2_4

	local var_2_6 = arg_2_0.tf
	local var_2_7 = var_2_0.flag

	ChapterConst = var_1_10006

	var_2_4(var_2_6, var_2_7 == var_1_10006.CellFlagActive)

	return
end

return var_0_1
