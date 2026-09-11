local var_0_0 = {}
local var_0_1 = 0.4

function var_0_0:PlayAnimationWithCallback(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_3 = arg_1_3 or 0

	local var_1_0 = false

	if self:GetCurrentAnimatorStateInfo(0):IsName("ui_stand") or arg_1_1 == "ui_stand" then
		-- block empty
	else
		var_1_0 = true
	end

	var_0_0.PlayAnimatorWithCallback(self, arg_1_1, arg_1_2, var_1_0, arg_1_3, arg_1_4)
end

function var_0_0:PlayAnimatorWithCallback(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self.speed = 1
	arg_2_4 = arg_2_4 or 0

	if arg_2_3 then
		var_0_0.CrossFade(self, arg_2_1, arg_2_4, arg_2_5)
	elseif arg_2_5 then
		self:Play(arg_2_1, arg_2_4, arg_2_5)
	else
		self:Play(arg_2_1, arg_2_4)
	end

	if var_0_0.timer_ ~= nil then
		var_0_0.timer_:Stop()
	end

	var_0_0.timer_ = Timer.New(function()
		local var_3_0 = self:GetCurrentAnimatorStateInfo(0)

		if var_3_0:IsName(arg_2_1) and var_3_0.normalizedTime >= 1 - ((arg_2_3 or nil) and (var_0_1 or 0)) / var_3_0.length then
			if var_0_0.timer_ ~= nil then
				var_0_0.timer_:Stop()

				var_0_0.timer_ = nil
			end

			if arg_2_2 ~= nil then
				arg_2_2()
			end
		end
	end, 0.033, -1)

	var_0_0.timer_:Start()
end

function var_0_0.Stop()
	if var_0_0.timer_ ~= nil then
		var_0_0.timer_:Stop()

		var_0_0.timer_ = nil
	end
end

function var_0_0:CrossFade(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = var_0_1 / self:GetCurrentAnimatorStateInfo(0).length

	arg_5_2 = arg_5_2 or 0

	if arg_5_3 then
		self:CrossFade(arg_5_1, var_5_0, arg_5_2, arg_5_3)
	else
		self:CrossFade(arg_5_1, var_5_0, arg_5_2)
	end
end

return var_0_0
