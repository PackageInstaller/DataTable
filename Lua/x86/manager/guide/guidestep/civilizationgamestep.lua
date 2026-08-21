local var_0_0 = class("CivilizationGameStep", ComponentStep)
local var_0_1 = {
	[12313] = {
		1,
		3,
		1
	},
	[12316] = {
		4,
		4,
		2
	},
	[12321] = {
		3,
		2,
		3
	},
	[12324] = {
		0,
		0,
		0
	}
}

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0._eventName = GuideStepCfg[arg_1_0._stepId].params[1]
end

function var_0_0.EventTrigger(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._stepId == 12312 or arg_2_0._stepId == 12315 or arg_2_0._stepId == 12320 then
		civilization.CivilizationLuaBridge.SetGameCanDrag(true, true)
		arg_2_0:OnStepEnd()

		return
	end

	if arg_2_0._stepId == 12323 and arg_2_1 == "pointerDown" then
		civilization.CivilizationLuaBridge.SetGameCanDrag(true, true)
		arg_2_0:OnStepEnd()

		return
	end

	if arg_2_0._stepId == 12603 then
		civilization.CivilizationLuaBridge.SetGameCanDrag(false, false)
		arg_2_0:OnStepEnd()

		return
	end

	if arg_2_0._stepId == 12609 then
		civilization.CivilizationLuaBridge.SetGameCanDrag(true, false)
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

		if var_3_0 ~= nil and civilization.CivilizationLuaBridge.CheckBlock(var_3_0[1], var_3_0[2], var_3_0[3]) then
			civilization.CivilizationLuaBridge.SetGameCanDrag(false, false)
			arg_2_0:OnStepEnd()
		elseif arg_2_0._stepId == 12324 then
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
