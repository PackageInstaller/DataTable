class = var_0_10000

local var_0_0 = "MainBaseView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseEventLogic"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject
	MainFoldableHelper = var_3

	local var_1_0 = var_3.New
	local var_1_1 = arg_1_1
	local var_1_2 = arg_1_0

	arg_1_0.foldableHelper = var_1_0(var_1_1, arg_1_0.GetDirection(var_1_2))
	GetOrAddComponent = var_3

	local var_1_3 = arg_1_0._tf

	typeof = var_5
	CanvasGroup = var_1_2
	arg_1_0._canvasGroup = var_3(var_1_3, var_5(var_1_2))

	return
end

function var_0_1.Init(arg_2_0)
	return
end

function var_0_1.Fold(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.foldableHelper

	var_3.Fold(var_3_0, arg_3_1, arg_3_2)

	return
end

function var_0_1.Refresh(arg_4_0)
	return
end

function var_0_1.Disable(arg_5_0)
	return
end

function var_0_1.GetDirection(arg_6_0)
	Vector2 = var_1_10001

	return var_1_10001.zero
end

function var_0_1.SetVisible(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0._tf, arg_7_1)

	return
end

function var_0_1.SetEffectVisible(arg_8_0, arg_8_1)
	return
end

function var_0_1.SetAlpha(arg_9_0, arg_9_1)
	arg_9_0._canvasGroup.alpha = arg_9_1

	return
end

function var_0_1.SetInteractable(arg_10_0, arg_10_1)
	arg_10_0._canvasGroup.interactable = arg_10_1 and arg_10_1 or false

	return
end

function var_0_1.SetBlocksRaycasts(arg_11_0, arg_11_1)
	arg_11_0._canvasGroup.blocksRaycasts = arg_11_1 and arg_11_1 or false

	return
end

function var_0_1.IgnoreParentGroups(arg_12_0, arg_12_1)
	arg_12_0._canvasGroup.ignoreParentGroups = arg_12_1

	return
end

function var_0_1.Dispose(arg_13_0)
	arg_13_0.exited = true

	arg_13_0:disposeEvent()

	if arg_13_0.foldableHelper then
		pg = var_1

		var_1.DelegateInfo.Dispose(arg_13_0)

		local var_13_0 = arg_13_0.foldableHelper

		var_1.Dispose(var_13_0)

		arg_13_0.foldableHelper = nil
	end

	return
end

return var_0_1
