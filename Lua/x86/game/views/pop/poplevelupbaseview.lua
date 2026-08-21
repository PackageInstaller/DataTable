local var_0_0 = class("PopLevelUpBaseView", ReduxView)

function var_0_0.CheckBack(arg_1_0)
	if not manager.guide:IsPlaying() then
		if arg_1_0.backTimer_ then
			arg_1_0.backTimer_:Stop()

			arg_1_0.backTimer_ = nil
		end

		local var_1_0 = GameSetting.normal_pop_view_time.value[1]

		arg_1_0.btnBack_.enabled = false
		arg_1_0.backTimer_ = Timer.New(function()
			arg_1_0.btnBack_.enabled = true
		end, var_1_0, 1)

		arg_1_0.backTimer_:Start()
	end
end

function var_0_0.Dispose(arg_3_0)
	if arg_3_0.backTimer_ then
		arg_3_0.backTimer_:Stop()

		arg_3_0.backTimer_ = nil
	end

	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
