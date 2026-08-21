local var_0_0 = class("SubCellView", DecorateClass(import(".DynamicCellView"), (import(".SpineCellView"))))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0, arg_1_1)
	var_0.Ctor(arg_1_0)
	var_0.InitCellTransform(arg_1_0)

	arg_1_0.tfAmmo = arg_1_0.tf:Find("ammo")
	arg_1_0.tfAmmoText = arg_1_0.tfAmmo:Find("text")
	arg_1_0.showFlag = true
	arg_1_0.shuihuaLoader = AutoLoader.New()

	arg_1_0:LoadEffectShuihua()

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityFleet
end

function var_0_0.OverrideCanvas(arg_3_0)
	var_0_0.super.OverrideCanvas(arg_3_0)

	arg_3_0.markCanvas = GetOrAddComponent(arg_3_0.tf:Find("mark"), typeof(Canvas))
	arg_3_0.markCanvas.overrideSorting = true

	return
end

function var_0_0.ResetCanvasOrder(arg_4_0)
	var_0_0.super.ResetCanvasOrder(arg_4_0)

	if not arg_4_0.markCanvas then
		return
	end

	pg.ViewUtils.SetSortingOrder(arg_4_0.markCanvas, arg_4_0.line.row * ChapterConst.PriorityPerRow + ChapterConst.CellPriorityTopMark)

	return
end

function var_0_0.LoadEffectShuihua(arg_5_0)
	arg_5_0.shuihuaLoader:GetPrefab("Effect/" .. "qianting_01", "qianting_01", function(arg_6_0)
		arg_5_0.effect_shuihua = arg_6_0

		tf(arg_6_0):SetParent(arg_5_0.tf)

		tf(arg_6_0).localPosition = Vector3.zero

		setActive(arg_6_0, false)

		return
	end, "Shuihua")

	return
end

function var_0_0.PlayShuiHua(arg_7_0)
	if not arg_7_0.effect_shuihua then
		return
	end

	setActive(arg_7_0.effect_shuihua, false)
	setActive(arg_7_0.effect_shuihua, true)

	return
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	arg_8_0:SetActiveModel(arg_8_1)

	return
end

function var_0_0.SetActiveModel(arg_9_0, arg_9_1)
	setActive(arg_9_0.tfShadow, arg_9_1)
	arg_9_0:SetSpineVisible(arg_9_1)

	return
end

function var_0_0.Clear(arg_10_0)
	arg_10_0.showFlag = nil

	arg_10_0.shuihuaLoader:Clear()
	var_0.ClearSpine(arg_10_0)
	var_0.Clear(arg_10_0)

	return
end

return var_0_0
