local var_0_0 = class("DrawNormalPool", DrawBasePool)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.firstController = ControllerUtil.GetController(arg_1_0.transform_, "first")
end

function var_0_0.Refresh(arg_2_0)
	if DrawData:GetIsFirstSSR() then
		local var_2_0 = DrawData:GetPoolDrawTimes(arg_2_0.poolId)
		local var_2_1 = GameSetting.draw_ssr_lucky_num_first_time.value[1]

		arg_2_0.drawTime_.text = string.format("%d/%d", var_2_0, var_2_1)

		arg_2_0.firstController:SetSelectedIndex(1)
	else
		arg_2_0.firstController:SetSelectedIndex(0)
	end
end

return var_0_0
