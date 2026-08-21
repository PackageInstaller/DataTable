local var_0_0 = class("CombineGameStep", ComponentStep)
local var_0_1 = {
	[5919] = {
		1,
		3,
		1
	},
	[5924] = {
		3,
		2,
		3
	},
	[5930] = {
		3,
		3,
		2
	},
	[5935] = {
		0,
		0,
		0
	},
	[5939] = {
		4,
		0,
		0
	}
}

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0._eventName = GuideStepCfg[arg_1_0._stepId].params[1]
end

function var_0_0.EventTrigger(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._stepId == 5918 or arg_2_0._stepId == 5923 or arg_2_0._stepId == 5929 then
		CombineGameWorld.Instance.canDrag = true

		arg_2_0:OnStepEnd()

		return
	end

	if (arg_2_0._stepId == 5934 or arg_2_0._stepId == 5938) and arg_2_1 == "pointerDown" then
		CombineGameWorld.Instance.canDrag = true

		arg_2_0:OnStepEnd()

		return
	end

	if arg_2_0._stepId == 5943 then
		CombineGameWorld.Instance.isTeach = false
		CombineGameWorld.Instance.canDrag = true

		arg_2_0:OnStepEnd()

		return
	end

	TimeTools.StartAfterSeconds(0.1, function()
		if arg_2_0._stepId == nil then
			return
		end

		local var_3_0 = var_0_1[arg_2_0._stepId]

		if var_3_0 == nil then
			return
		end

		if CombineGameWorld.Instance:CheckBlock(var_3_0[1], var_3_0[2], var_3_0[3]) then
			CombineGameWorld.Instance.canDrag = false

			arg_2_0:OnStepEnd()
		elseif arg_2_0._stepId == 5935 or arg_2_0._stepId == 5939 then
			if arg_2_0._guide == nil then
				return
			end

			arg_2_0._guide:AddNextStep(GuideStepCfg[arg_2_0._stepId])
			arg_2_0._guide:AddNextStep(GuideStepCfg[arg_2_0._stepId - 1])
			arg_2_0:OnStepEnd()
		end
	end, {})
end

return var_0_0
