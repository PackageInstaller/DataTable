class = var_0_10000

local var_0_0 = "StoryPerformPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BasePerformPlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._tf.parent

	arg_1_0.noDrawGraphicCom = var_2.GetComponent(var_1_0, "NoDrawingGraphic")

	return
end

function var_0_1.Play(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:Show()

	local var_2_0 = arg_2_0.noDrawGraphicCom

	var_2_0.enabled = false
	pg = var_2_0

	local var_2_1 = var_2_0.NewStoryMgr.GetInstance()
	local var_2_2 = var_3.Play
	local var_2_3

	if not arg_2_1.param then
		var_2_3 = ""
	end

	var_2_2(var_2_1, var_2_3, function()
		arg_2_0.noDrawGraphicCom.enabled = true

		if arg_2_2 then
			arg_2_2()
		end

		return
	end, true)

	return
end

function var_0_1.Clear(arg_4_0)
	arg_4_0:Hide()

	return
end

return var_0_1
