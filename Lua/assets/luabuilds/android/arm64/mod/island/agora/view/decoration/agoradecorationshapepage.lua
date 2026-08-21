local var_0_0 = class("AgoraDecorationShapePage")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.tr = arg_1_1
	arg_1_0.parentTr = arg_1_1.parent
	arg_1_0.shapes = {
		[IslandConst.AGORA_TILE_SHAPE_ALL] = arg_1_0.tr:Find("bg/list/1"),
		[IslandConst.AGORA_TILE_SHAPE_FAN] = arg_1_0.tr:Find("bg/list/2"),
		[IslandConst.AGORA_TILE_SHAPE_TRIANGLE] = arg_1_0.tr:Find("bg/list/3"),
		[IslandConst.AGORA_TILE_SHAPE_ARC] = arg_1_0.tr:Find("bg/list/4")
	}

	arg_1_0:InitShapes()

	arg_1_0.bgTr = arg_1_1:Find("bg")
	arg_1_0.localPosition = arg_1_0.bgTr.localPosition

	return
end

function var_0_0.InitShapes(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.shapes) do
		onButton(arg_2_0, iter_2_1, function()
			if arg_2_0.callback then
				arg_2_0.callback(iter_2_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.Show(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.callback = arg_4_2

	setParent(arg_4_0.tr, arg_4_1._go.transform.parent)
	arg_4_0.tr:SetSiblingIndex(arg_4_1._go.transform:GetSiblingIndex() + 1)
	setActive(arg_4_0.tr, true)
	arg_4_0:AdjustPosition(arg_4_1._go.transform.parent)

	return
end

function var_0_0.AdjustPosition(arg_5_0, arg_5_1)
	arg_5_0.bgTr.localPosition = arg_5_0.localPosition - Vector3(arg_5_1:GetComponent(typeof(HorizontalLayoutGroup)).spacing, 0, 0)

	return
end

function var_0_0.Hide(arg_6_0)
	arg_6_0.callback = nil

	setParent(arg_6_0.tr, arg_6_0.parentTr)
	setActive(arg_6_0.tr, false)

	return
end

function var_0_0.Destroy(arg_7_0)
	pg.DelegateInfo.Dispose(arg_7_0)

	return
end

return var_0_0
