local var_0_0 = import("game.quiz.QuizFunction")
local var_0_1 = class("ActivityQuizRankItem", ReduxView)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.mineCon_ = ControllerUtil.GetController(arg_3_0.transform_, "mine")
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "rank")
end

function var_0_1.AddUIListeners(arg_4_0)
	return
end

function var_0_1.RefreshData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id_ = arg_5_1
	arg_5_0.index_ = arg_5_2
	arg_5_0.data_ = var_0_0:GetRankData(arg_5_1)
	arg_5_0.scroe_.text = arg_5_0.data_.score
	arg_5_0.nick_.text = arg_5_0.data_.nick
	arg_5_0.rank_.text = arg_5_0.index_

	if arg_5_0.index_ > 3 then
		arg_5_0.stateCon_:SetSelectedState("other")
	else
		arg_5_0.stateCon_:SetSelectedState(arg_5_0.index_)
	end
end

function var_0_1.SetMine(arg_6_0, arg_6_1)
	if arg_6_0.mineCon_ then
		arg_6_0.mineCon_:SetSelectedState(arg_6_1 and "me" or "other")
	end
end

function var_0_1.OnExit(arg_7_0)
	return
end

function var_0_1.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	arg_8_0.super.Dispose(arg_8_0)
end

return var_0_1
