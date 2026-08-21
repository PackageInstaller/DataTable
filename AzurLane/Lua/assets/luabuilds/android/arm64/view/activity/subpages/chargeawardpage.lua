local var_0_0 = class("ChargeAwardPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.charge = arg_1_0._tf:Find("charge")
	arg_1_0.take = arg_1_0._tf:Find("take")
	arg_1_0.finish = arg_1_0._tf:Find("finish")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.charge, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_DIAMOND
		})

		return
	end)
	onButton(arg_3_0, arg_3_0.take, function()
		arg_3_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.activity.id
		})

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	setActive(arg_6_0.charge, arg_6_0.activity.data2 == 0 and arg_6_0.activity.data1 == 0)
	setButtonEnabled(arg_6_0.take, arg_6_0.activity.data2 == 0)
	setActive(arg_6_0.take, arg_6_0.activity.data1 > 0)
	setActive(arg_6_0.finish, arg_6_0.activity.data2 == 1)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	clearImageSprite(arg_7_0.bg)

	return
end

return var_0_0
