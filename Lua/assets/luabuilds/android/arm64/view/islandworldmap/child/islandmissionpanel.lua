local var_0_0 = class("IslandMissionPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2

	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/confirm"), function()
		arg_1_0:onClickConfirm()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.buildType = arg_3_1

	return
end

function var_0_0.onClickConfirm(arg_4_0)
	arg_4_0:setActive(false)

	return
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	setActive(arg_5_0._tf, arg_5_1)

	return
end

function var_0_0.dispose(arg_6_0)
	return
end

return var_0_0
