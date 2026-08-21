local var_0_0 = class("AutoChessSettleHpItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = arg_2_0.controllerEx_:GetController("status")
end

function var_0_0.SetStatus(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.statusController_:SetSelectedState(arg_3_1)

	if arg_3_2 and arg_3_1 == AutoChessConst.HP_STATUS.HURTING then
		arg_3_0.timer_ = nil
		arg_3_0.timer_ = Timer.New(function()
			if arg_3_0.gameObject_.activeInHierarchy then
				arg_3_0.anim_:Play("U_HPItem_cx", -1, 0)
				arg_3_0.statusController_:SetSelectedState(AutoChessConst.HP_STATUS.HURTING)
				arg_3_0.timer_:Stop()

				arg_3_0.timer_ = nil
			end
		end, 0.33, -1)

		arg_3_0.timer_:Start()
	else
		SetActive(arg_3_0.animGo_, false)
	end
end

function var_0_0.OnExit(arg_5_0)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil

		AnimatorTools.Stop()
	end
end

return var_0_0
