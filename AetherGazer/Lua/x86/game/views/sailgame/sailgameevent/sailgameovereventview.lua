local var_0_0 = import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")
local var_0_1 = class("SailGameOverEventView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageTreasureChestUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
	arg_2_0.rewardItemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList_, CommonItem)
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.openBoxBtn_, nil, function()
		if not arg_3_0.isOpend_ then
			arg_3_0.isOpend_ = true

			SailGameAction.EventOperate(arg_3_0.activityID_, arg_3_0.stageIndex_)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.overBtn_, nil, function()
		arg_3_0:RefreshSettlement()
	end)
	arg_3_0:AddBtnListener(arg_3_0.backBtn_, nil, function()
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = arg_3_0.activityID_
		})
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID
	arg_7_0.stageIndex_ = SailGameData:GetCurGameData(arg_7_0.activityID_).curStageIndex
	arg_7_0.isOpend_ = false

	arg_7_0:RefreshUI()
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_pop2", "")
end

function var_0_1.OnExit(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end

	var_0_1.super.OnExit(arg_8_0)
end

function var_0_1.Dispose(arg_9_0)
	arg_9_0.rewardItemList_:Dispose()

	arg_9_0.rewardItemList_ = nil

	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end

	var_0_1.super.Dispose(arg_9_0)
end

function var_0_1.RefreshUI(arg_10_0)
	arg_10_0.statusController_:SetSelectedState("start")
	arg_10_0:RefreshReward()
end

function var_0_1.RefreshReward(arg_11_0)
	local var_11_0 = GameSetting.activity_skadi_sea_be_out_end_reward.value

	arg_11_0.rewardCfgList_ = {}
	arg_11_0.rewardCfgList_[1] = var_11_0

	arg_11_0.rewardItemList_:StartScroll(#arg_11_0.rewardCfgList_)
end

function var_0_1.OnEventOperateSuccess(arg_12_0)
	arg_12_0:PlayBoxAnim(0, function()
		arg_12_0.statusController_:SetSelectedState("end")
	end)
end

function var_0_1.RefreshSettlement(arg_14_0)
	local var_14_0 = SailGameData:GetTempSettlementData(arg_14_0.activityID_).getDic

	arg_14_0.rewardCfgList_ = {}

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		arg_14_0.rewardCfgList_[#arg_14_0.rewardCfgList_ + 1] = {
			iter_14_0,
			iter_14_1
		}
	end

	arg_14_0.rewardItemList_:StartScroll(#arg_14_0.rewardCfgList_)
	arg_14_0.statusController_:SetSelectedState("settlement")
end

function var_0_1.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:RefreshData(formatReward(arg_15_0.rewardCfgList_[arg_15_1]))
	arg_15_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, arg_15_0.rewardCfgList_[arg_15_1])
	end)
	arg_15_2.starController_:SetSelectedState(0)
end

function var_0_1.PlayBoxAnim(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = "XH3rdVoyageTreasureChestUI_icon"

	arg_17_0.animator_:Play(var_17_0, -1, arg_17_1)
	arg_17_0.animator_:Update(0)

	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end

	arg_17_0.timer_ = Timer.New(function()
		local var_18_0 = arg_17_0.animator_:GetCurrentAnimatorStateInfo(0)

		if var_18_0:IsName(var_17_0) and var_18_0.normalizedTime >= 1 then
			if arg_17_0.timer_ ~= nil then
				arg_17_0.timer_:Stop()

				arg_17_0.timer_ = nil
			end

			if arg_17_2 then
				arg_17_2()
			end
		end
	end, 0.033, -1)

	arg_17_0.timer_:Start()
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_award", "")
end

return var_0_1
