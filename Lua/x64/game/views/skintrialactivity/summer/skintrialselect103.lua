local var_0_0 = class("SkinTrialSelect103", SkinTrialActivitySelectView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerSkinTrialUI_" .. arg_1_0.params_.skinTrialID
end

function var_0_0.OnEnter(arg_2_0)
	if arg_2_0.params_.canPlayTimeLine == true and arg_2_0.director_ ~= nil then
		arg_2_0.params_.canPlayTimeLine = false
		arg_2_0.director_.time = 0

		arg_2_0.director_:Play()
	end

	var_0_0.super.OnEnter(arg_2_0)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.director_:Stop()
	var_0_0.super.OnExit(arg_3_0)
end

return var_0_0
