return {
	SetButtonEnable = function(self, arg_1_1)
		local var_1_0 = ControllerUtil.GetController(self.gameObject.transform, "enabled")

		if var_1_0 ~= nil then
			var_1_0:SetSelectedState(arg_1_1 and "true" or "false")
		end

		self:GetComponent(typeof(Button)).enabled = arg_1_1
	end
}
