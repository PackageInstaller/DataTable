local var_0_0 = class("Guide_350", BaseGuide)

function var_0_0.Check(arg_1_0)
	if arg_1_0:IsPlaying() then
		local var_1_0 = arg_1_0._steps[1]
		local var_1_1 = gameContext:IsOpenRoute("summerRaceCutScenesPopView") ~= nil

		if var_1_1 then
			manager.guide.view:Hide()
		end

		if var_1_0 ~= nil and var_1_0:GetStepId() == 35002 and var_1_1 then
			return false
		end
	end

	return var_0_0.super.Check(arg_1_0)
end

return var_0_0
