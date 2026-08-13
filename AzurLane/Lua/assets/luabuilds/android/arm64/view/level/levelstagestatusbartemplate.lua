class = var_0_10000

local var_0_0 = "LevelStageStatusBarTemplate"

BaseSubPanel = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._go
	local var_1_1 = var_1.GetComponent

	typeof = var_1_10004
	Animator = var_1_10006
	arg_1_0.anim = var_1_1(var_1_0, var_1_10004(var_1_10006))

	local var_1_2 = arg_1_0._go
	local var_1_3 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_1_0.animEvent = var_1_3(var_1_2, var_4(var_1_10006))

	return
end

function var_0_1.OnShow(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_1, function()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end)

	return
end

function var_0_1.OnHide(arg_4_0)
	local var_4_0 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_0, nil)

	pg = var_1

	local var_4_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_1, arg_4_0._tf)

	return
end

function var_0_1.PlayAnim(arg_5_0)
	arg_5_0:Hide()
	arg_5_0:Show()

	return
end

return var_0_1
