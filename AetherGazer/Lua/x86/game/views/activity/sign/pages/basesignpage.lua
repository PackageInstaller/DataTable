local var_0_0 = class("BaseSignPage", ReduxView)

function var_0_0.AutoGetReward(arg_1_0)
	return
end

function var_0_0.SetActive(arg_2_0, arg_2_1)
	SetActive(arg_2_0.gameObject_, arg_2_1)

	if arg_2_1 then
		arg_2_0:OnShow()
	else
		arg_2_0:OnHide()
	end
end

function var_0_0.OnShow(arg_3_0)
	return
end

function var_0_0.OnHide(arg_4_0)
	return
end

return var_0_0
