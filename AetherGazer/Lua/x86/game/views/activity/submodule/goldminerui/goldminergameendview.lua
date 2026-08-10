local var_0_0 = class("GoldMinerGameEndView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEaterUI_GoldenMiner_ResultUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController_ = arg_4_0.controllerEx_:GetController("state")
	arg_4_0.starController1_ = arg_4_0.starControllerEx1_:GetController("complet")
	arg_4_0.starController2_ = arg_4_0.starControllerEx2_:GetController("complet")
	arg_4_0.starController3_ = arg_4_0.starControllerEx3_:GetController("complet")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.resetBtn_, nil, function()
		local var_6_0 = GodEaterData:GetCurHeroID()

		JumpTools.OpenPageByJump("/goldMinerGameView", {
			subActivityID = arg_5_0.stageID_,
			heroID = var_6_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.continueBtn_, nil, function()
		JumpTools.OpenPageByJump("/goldMinerSelectLevelView", {
			activityID = ActivityConst.ACTIVITY_GOLDMINER
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.stageID_ = arg_8_0.params_.stageID
	arg_8_0.star_ = arg_8_0.params_.star
	arg_8_0.cfg_ = ActivityGodEaterGoldminerStageCfg[arg_8_0.stageID_]

	for iter_8_0 = 1, 3 do
		arg_8_0["text" .. iter_8_0 .. "_"].text = string.format(GetTips("GOLDMINER_STAGE_POINT_NEED"), arg_8_0.cfg_.score[iter_8_0])

		if iter_8_0 <= arg_8_0.star_ then
			arg_8_0["starController" .. iter_8_0 .. "_"]:SetSelectedState("true")
		else
			arg_8_0["starController" .. iter_8_0 .. "_"]:SetSelectedState("false")
		end
	end

	if arg_8_0.star_ <= 0 then
		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_lose", "")
		arg_8_0.stateController_:SetSelectedState("lose")
	else
		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_win", "")
		arg_8_0.stateController_:SetSelectedState("win")
	end

	if arg_8_0.params_.reward_list[1] then
		getReward(mergeReward(arg_8_0.params_.reward_list))
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
