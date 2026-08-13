import = var_0_10000

local var_0_0 = var_0_10000(".DynamicCellView")

import = var_0_10001

local var_0_1 = var_0_10001(".SpineCellView")

class = var_2

local var_0_2 = "SubCellView"

DecorateClass = var_0_10005

local var_0_3 = var_2(var_0_2, var_0_10005(var_0_0, var_0_1))

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_1.Ctor(arg_1_0)
	var_0_1.InitCellTransform(arg_1_0)

	local var_1_0 = arg_1_0.tf

	arg_1_0.tfAmmo = var_2.Find(var_1_0, "ammo")

	local var_1_1 = arg_1_0.tfAmmo

	arg_1_0.tfAmmoText = var_2.Find(var_1_1, "text")
	arg_1_0.showFlag = true
	AutoLoader = var_2
	arg_1_0.shuihuaLoader = var_2.New()

	arg_1_0:LoadEffectShuihua()

	return
end

function var_0_3.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityFleet
end

function var_0_3.OverrideCanvas(arg_3_0)
	var_0_3.super.OverrideCanvas(arg_3_0)

	GetOrAddComponent = var_1

	local var_3_0 = arg_3_0.tf
	local var_3_1 = var_3.Find(var_3_0, "mark")

	typeof = var_1_10004
	Canvas = var_6
	arg_3_0.markCanvas = var_1(var_3_1, var_1_10004(var_6))
	arg_3_0.markCanvas.overrideSorting = true

	return
end

function var_0_3.ResetCanvasOrder(arg_4_0)
	var_0_3.super.ResetCanvasOrder(arg_4_0)

	if not arg_4_0.markCanvas then
		return
	end

	local var_4_0 = arg_4_0.line.row

	ChapterConst = var_1_10002

	local var_4_1 = var_4_0 * var_1_10002.PriorityPerRow

	ChapterConst = var_2

	local var_4_2 = var_4_1 + var_2.CellPriorityTopMark

	pg = var_2

	var_2.ViewUtils.SetSortingOrder(arg_4_0.markCanvas, var_4_2)

	return
end

function var_0_3.LoadEffectShuihua(arg_5_0)
	local var_5_0 = "qianting_01"
	local var_5_1 = arg_5_0.shuihuaLoader

	var_2.GetPrefab(var_5_1, "Effect/" .. var_5_0, var_5_0, function(arg_6_0)
		local var_6_0 = arg_5_0

		var_6_0.effect_shuihua = arg_6_0
		tf = var_6_0

		local var_6_1 = var_6_0(arg_6_0)

		var_1.SetParent(var_6_1, arg_5_0.tf)

		tf = var_1

		local var_6_2 = var_1(arg_6_0)

		Vector3 = var_2_10002
		var_6_2.localPosition = var_2_10002.zero
		setActive = var_6_2

		var_6_2(arg_6_0, false)

		return
	end, "Shuihua")

	return
end

function var_0_3.PlayShuiHua(arg_7_0)
	if not arg_7_0.effect_shuihua then
		return
	end

	setActive = var_1

	var_1(arg_7_0.effect_shuihua, false)

	setActive = var_1

	var_1(arg_7_0.effect_shuihua, true)

	return
end

function var_0_3.SetActive(arg_8_0, arg_8_1)
	arg_8_0:SetActiveModel(arg_8_1)

	return
end

function var_0_3.SetActiveModel(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0.tfShadow, arg_9_1)
	arg_9_0:SetSpineVisible(arg_9_1)

	return
end

function var_0_3.Clear(arg_10_0)
	arg_10_0.showFlag = nil

	local var_10_0 = arg_10_0.shuihuaLoader

	var_1.Clear(var_10_0)
	var_0_1.ClearSpine(arg_10_0)
	var_0_0.Clear(arg_10_0)

	return
end

return var_0_3
