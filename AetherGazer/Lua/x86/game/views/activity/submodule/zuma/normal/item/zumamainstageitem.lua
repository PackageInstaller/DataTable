local var_0_0 = class("ZumaMainStageItem", ReduxView)
local var_0_1 = {
	progressState = {
		star1 = "state2",
		name = "Progress",
		star2 = "state3",
		noShow = "state0",
		star0 = "state1",
		star3 = "state4"
	},
	selectState = {
		onSelect = "state1",
		name = "sel",
		unSelect = "state0"
	},
	stateState = {
		unComplete = "state2",
		name = "state",
		lock = "state0",
		normal = "state1"
	},
	rankState = {
		state2 = "state2",
		name = "rank",
		state1 = "state1",
		noShow = "no"
	},
	lineState = {
		normalColor = Color(0.611764705882353, 0.7372549019607844, 0.788235294117647, 1),
		lockColor = Color(0.7137254901960784, 0.7764705882352941, 0.8, 0.4)
	}
}
local var_0_2 = {
	UnComplete = 3,
	UnLock = 1,
	Complete = 2
}

function var_0_0.SetRedState(arg_1_0, arg_1_1)
	if arg_1_1 then
		manager.redPoint:bindUIandKey(arg_1_0.stageitemBtn_.transform, string.format("%s_%s", RedPointConst.ZUMA_OPEN, arg_1_0.levelCfg.activity_id))
	else
		manager.redPoint:unbindUIandKey(arg_1_0.stageitemBtn_.transform, string.format("%s_%s", RedPointConst.ZUMA_OPEN, arg_1_0.levelCfg.activity_id))
	end
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.index = arg_2_4
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.levelCfg = arg_2_3
	arg_2_0.levelID = arg_2_3.id
	arg_2_0.difficultType = arg_2_3.difficult

	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.progressController = arg_3_0.controllerexcollection_:GetController(var_0_1.progressState.name)
	arg_3_0.selectController = arg_3_0.controllerexcollection_:GetController(var_0_1.selectState.name)
	arg_3_0.stateController = arg_3_0.controllerexcollection_:GetController(var_0_1.stateState.name)
	arg_3_0.rankController = arg_3_0.controllerexcollection_:GetController(var_0_1.rankState.name)

	arg_3_0:AddBtnListener(arg_3_0.stageitemBtn_, nil, function()
		manager.notify:CallUpdateFunc(ZUMA_SELECT_CHAPTER, arg_3_0.index)
	end)

	arg_3_0.nameText_.text = arg_3_0.levelCfg.name
end

function var_0_0.RefreshUi(arg_5_0)
	local var_5_0 = arg_5_0.levelCfg
	local var_5_1 = ZumaData:GetZumaStageScore(arg_5_0.levelID)

	if arg_5_0.rankNumTxt_ then
		arg_5_0.rankNumTxt_.text = var_5_1 or 0
	end

	arg_5_0:UpdateStageState()
end

function var_0_0.GetLevelCfg(arg_6_0)
	return arg_6_0.levelCfg
end

function var_0_0.UpdateSelectState(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedState(arg_7_1 and var_0_1.selectState.onSelect or var_0_1.selectState.unSelect)
end

function var_0_0.UpdateStageState(arg_8_0)
	local var_8_0 = ActivityZumaLevelCfg[arg_8_0.levelID]
	local var_8_1 = ActivityData:GetActivityData(var_8_0.activity_id)
	local var_8_2 = ZumaData:GetZumaStageScore(arg_8_0.levelID)

	if var_8_1 and var_8_1:IsActivitying() then
		if var_8_2 then
			arg_8_0:CheckStageState(var_0_2.Complete)
		elseif ZumaData:GetZumaBeforeIsFinish(arg_8_0.levelID) then
			arg_8_0:CheckStageState(var_0_2.UnComplete)
		else
			arg_8_0:CheckStageState(var_0_2.UnLock)
		end
	else
		arg_8_0:CheckStageState(var_0_2.UnLock)
	end
end

function var_0_0.CheckStageState(arg_9_0, arg_9_1)
	arg_9_0.stageState = arg_9_1

	arg_9_0:ChangeLockState()
	arg_9_0:ChangeProgressState()
	arg_9_0:ChangeRankState()
end

function var_0_0.ChangeLockState(arg_10_0)
	if arg_10_0.stageState == var_0_2.UnLock then
		arg_10_0.stateController:SetSelectedState(var_0_1.stateState.lock)
	elseif arg_10_0.stageState == var_0_2.Complete then
		arg_10_0.stateController:SetSelectedState(var_0_1.stateState.normal)
	elseif arg_10_0.stageState == var_0_2.UnComplete then
		arg_10_0.stateController:SetSelectedState(var_0_1.stateState.unComplete)
	end
end

function var_0_0.ChangeProgressState(arg_11_0)
	if arg_11_0.stageState == var_0_2.UnLock or arg_11_0.difficultType == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		arg_11_0.progressController:SetSelectedState(var_0_1.progressState.noShow)
	elseif arg_11_0.stageState == var_0_2.Complete then
		local var_11_0 = arg_11_0:GetFinishConditionNums()

		if var_11_0 == 1 then
			arg_11_0.progressController:SetSelectedState(var_0_1.progressState.star1)
		elseif var_11_0 == 2 then
			arg_11_0.progressController:SetSelectedState(var_0_1.progressState.star2)
		elseif var_11_0 == 3 then
			arg_11_0.progressController:SetSelectedState(var_0_1.progressState.star3)
		elseif var_11_0 == 0 then
			arg_11_0.progressController:SetSelectedState(var_0_1.progressState.star0)
		end
	elseif arg_11_0.stageState == var_0_2.UnComplete then
		arg_11_0.progressController:SetSelectedState(var_0_1.progressState.star0)
	end
end

function var_0_0.ChangeRankState(arg_12_0)
	if not arg_12_0.rankController then
		return
	end

	if arg_12_0.difficultType ~= ZumaConst.ZUMA_DIFFICULT.NIGHT then
		arg_12_0.rankController:SetSelectedState(var_0_1.rankState.noShow)

		return
	end

	if arg_12_0.stageState == var_0_2.UnLock then
		arg_12_0.rankController:SetSelectedState(var_0_1.rankState.noShow)
	elseif arg_12_0.stageState == var_0_2.Complete then
		arg_12_0.rankController:SetSelectedState(var_0_1.rankState.state2)
	elseif arg_12_0.stageState == var_0_2.UnComplete then
		arg_12_0.rankController:SetSelectedState(var_0_1.rankState.state1)
	end
end

function var_0_0.GetFinishConditionNums(arg_13_0)
	local var_13_0 = ZumaData:GetZumaStageScore(arg_13_0.levelID)
	local var_13_1 = arg_13_0.levelCfg.activity_point_reward
	local var_13_2 = 0

	for iter_13_0, iter_13_1 in pairs(var_13_1 or {}) do
		if var_13_0 >= ActivityPointRewardCfg[iter_13_1].need then
			var_13_2 = var_13_2 + 1
		end
	end

	return var_13_2
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
