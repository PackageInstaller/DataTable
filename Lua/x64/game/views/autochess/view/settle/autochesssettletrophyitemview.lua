local var_0_0 = class("AutoChessSettleTrophyItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = arg_2_0.controllerEx_:GetController("status")
end

function var_0_0.SetStatus(arg_3_0, arg_3_1)
	arg_3_0.statusController_:SetSelectedState(arg_3_1)

	if arg_3_1 == AutoChessConst.TROPHY_STATUS.NEW then
		if arg_3_0.timer then
			arg_3_0.timer:Stop()

			arg_3_0.timer = nil
		end

		arg_3_0.timer = nil
		arg_3_0.timer = Timer.New(function()
			if arg_3_0.gameObject_.activeInHierarchy then
				arg_3_0.anim_:Play("U_TrophyItem_cx", -1, 0)
				arg_3_0.timer:Stop()

				arg_3_0.timer = nil
			end
		end, 0.33, -1)

		arg_3_0.timer:Start()
	end
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.timer then
		arg_6_0.timer:Stop()

		arg_6_0.timer = nil
	end
end

return var_0_0
