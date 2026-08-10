return {
	SetButtonEnable = function(arg_1_0, arg_1_1)
		local var_1_0 = ControllerUtil.GetController(arg_1_0.gameObject.transform, "enabled")

		if var_1_0 ~= nil then
			var_1_0:SetSelectedState(arg_1_1 and "true" or "false")
		end

		arg_1_0:GetComponent(typeof(Button)).enabled = arg_1_1
	end
}
