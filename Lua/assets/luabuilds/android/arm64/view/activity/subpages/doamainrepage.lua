local var_0_0 = class("DoaMainRePage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.charactorTf = arg_1_0.bg:Find("charactor")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.bg:Find("btnMiniGame"), function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	local var_4_0 = math.random(1, 9)

	for iter_4_0 = 1, 9 do
		setActive(findTF(arg_4_0.charactorTf, "charactor" .. iter_4_0), var_4_0 == iter_4_0)
	end

	return
end

return var_0_0
