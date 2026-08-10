local var_0_0 = class("TaskDailyGiftItem", ReduxView)
local var_0_1 = import("game.const.ActivityPtConst")

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.parent_ = arg_1_2

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.index_ = arg_1_3
	arg_1_0.pointType_ = arg_1_4

	arg_1_0:Init()
end

function var_0_0.SetIndex(arg_2_0, arg_2_1)
	arg_2_0.index_ = arg_2_1

	arg_2_0:RefrshUI()
	arg_2_0:RefreshGift()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
	arg_3_0:RefrshUI()
	arg_3_0:RefreshGift()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveListeners()
	arg_4_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0.valueText_ = arg_5_0:FindCom(typeof(Text), "value")
	arg_5_0.giftBtn_ = arg_5_0.gameObject_:GetComponent(typeof(Button))
	arg_5_0.canReceiveGo_ = arg_5_0:FindGo("lizi")
	arg_5_0.alreadyReceiveGo_ = arg_5_0:FindGo("unlock")
	arg_5_0.lockReceiveGo_ = arg_5_0:FindGo("lock")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.giftBtn_, nil, function()
		local var_7_0 = ActivityPtCfg[arg_6_0.pointType_].reward[arg_6_0.index_]

		if arg_6_0:GetIsReceived() then
			-- block empty
		elseif arg_6_0:GetCanReceive() then
			ActivityPtAction:TaskDailyGetReward(arg_6_0.index_, arg_6_0.pointType_)

			return
		end

		OperationRecorder.Record(arg_6_0.class.__cname, "rewardPreview")
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = var_7_0
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
end

function var_0_0.RemoveListeners(arg_8_0)
	arg_8_0.giftBtn_.onClick:RemoveAllListeners()
end

function var_0_0.GetCanReceive(arg_9_0)
	return ActivityPtCfg[arg_9_0.pointType_].target[arg_9_0.index_] <= ActivityPtData:GetCurrentActivityPt(arg_9_0.pointType_)
end

function var_0_0.GetIsReceived(arg_10_0)
	local var_10_0 = ActivityPtCfg[arg_10_0.pointType_]

	if ActivityPtData:GetDailyGetRewardList()[arg_10_0.pointType_][var_10_0.target[arg_10_0.index_]] then
		return true
	end

	return false
end

function var_0_0.RefrshUI(arg_11_0)
	local var_11_0 = ActivityPtData:GetGiftPt(arg_11_0.pointType_, arg_11_0.index_)
	local var_11_1 = ActivityPtData:GetTotalPt(arg_11_0.pointType_)

	arg_11_0.valueText_.text = var_11_0
end

function var_0_0.RefreshGift(arg_12_0)
	local var_12_0 = false
	local var_12_1 = false
	local var_12_2 = false

	if arg_12_0:GetIsReceived() then
		var_12_1 = true
	elseif arg_12_0:GetCanReceive() then
		var_12_2 = true
		var_12_0 = true
	else
		var_12_2 = true
	end

	SetActive(arg_12_0.canReceiveGo_, var_12_0)
	SetActive(arg_12_0.alreadyReceiveGo_, var_12_1)
	SetActive(arg_12_0.lockReceiveGo_, var_12_2)
end

return var_0_0
