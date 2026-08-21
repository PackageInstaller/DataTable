local var_0_0 = class("StrongholdOperateBasePage", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	SetActive(arg_1_0.gameObject_, arg_1_1)

	if arg_1_1 == arg_1_0.active then
		return
	end

	arg_1_0.active = arg_1_1

	if arg_1_1 then
		arg_1_0:OnShow()
	else
		arg_1_0:OnHide()
	end
end

function var_0_0.OnShow(arg_2_0)
	return
end

function var_0_0.OnHide(arg_3_0)
	return
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	return
end

return var_0_0
