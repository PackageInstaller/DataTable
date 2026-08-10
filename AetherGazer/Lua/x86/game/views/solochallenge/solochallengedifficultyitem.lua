local var_0_0 = class("SoloChallengeDifficultyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1.gameObject
	arg_1_0.transform_ = arg_1_1

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.completeController_ = ControllerUtil.GetController(arg_3_0.transform_, "complete")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.Btn_, nil, function()
		if arg_4_0.selectCallBack_ then
			arg_4_0.selectCallBack_(arg_4_0.difficultyIndex_)
		end
	end)
end

function var_0_0.SetSelectCallBack(arg_6_0, arg_6_1)
	arg_6_0.selectCallBack_ = arg_6_1
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.difficultyIndex_ = arg_7_2

	if arg_7_0.completeController_ ~= nil then
		local var_7_0 = SoloChallengeData:GetCompletedActivityList()[arg_7_1]

		if table.keyof(var_7_0, arg_7_0.difficultyIndex_) ~= nil then
			arg_7_0.completeController_:SetSelectedState("true")
		else
			arg_7_0.completeController_:SetSelectedState("false")
		end
	end
end

function var_0_0.SetSelectCallBack(arg_8_0, arg_8_1)
	arg_8_0.selectCallBack_ = arg_8_1
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	if arg_9_0.selectController_ ~= nil then
		if arg_9_0.difficultyIndex_ == arg_9_1 then
			arg_9_0.selectController_:SetSelectedState("true")
		else
			arg_9_0.selectController_:SetSelectedState("false")
		end
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.gameObject_ = nil
	arg_10_0.transform_ = nil
	arg_10_0.selectCallBack_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
