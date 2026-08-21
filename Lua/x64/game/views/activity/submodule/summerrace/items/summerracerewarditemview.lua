local var_0_0 = class("SummerRaceRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:BindItemRuntime_()
	arg_2_0:AddUIListener()
end

function var_0_0.BindItemRuntime_(arg_3_0)
	arg_3_0.stateController_ = arg_3_0.controllerEx_:GetController("state")
	arg_3_0.highlightController_ = arg_3_0.controllerEx_:GetController("highlight")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.index_, arg_4_0.rewardData_, "receive")
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.rewardData_ = arg_6_1
	arg_6_0.index_ = arg_6_2
	arg_6_0.clickHandler_ = arg_6_3

	arg_6_0:RefreshView()
end

function var_0_0.RefreshView(arg_7_0)
	if arg_7_0.rewardData_ == nil then
		return
	end

	arg_7_0.rewardNameText_.text = tostring(arg_7_0.rewardData_.rewardName or "")
	arg_7_0.rewardCountText_.text = "x" .. tostring(arg_7_0.rewardData_.rewardCount or 0)
	arg_7_0.progressText_.text = tostring(arg_7_0.rewardData_.progressText or "")

	SetActive(arg_7_0.receivedGo_, arg_7_0.rewardData_.state == "received")
	arg_7_0.stateController_:SetSelectedState(arg_7_0.rewardData_.state or "locked")
	arg_7_0.highlightController_:SetSelectedState(arg_7_0.rewardData_.state == "canReceive" and "on" or "off")

	arg_7_0.receiveBtn_.interactable = arg_7_0.rewardData_.state == "canReceive"
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.rewardData_ = nil
	arg_8_0.clickHandler_ = nil

	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
