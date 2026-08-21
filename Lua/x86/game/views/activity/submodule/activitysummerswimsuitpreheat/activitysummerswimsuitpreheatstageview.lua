local var_0_0 = class("ActivitySummerSwimsuitPreheatStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_SummerUI_PreheatUI/Alone_SummerUI_PreheatPopUI"
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

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, CommonItemView)
	arg_4_0.stateController_ = arg_4_0.conEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, function()
		arg_5_0:OnClickPlayBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.finPlayBtn_, nil, function()
		return
	end)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		arg_5_0:OnClickGetBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		if arg_5_0.isAniPlaying_ then
			return
		end

		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	manager.windowBar:HideBar()

	arg_10_0.cfgId_ = arg_10_0.params_.cfgId

	local var_10_0 = ActivitySummerSwimsuitPreheatCfg[arg_10_0.cfgId_]
	local var_10_1 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(var_10_0)

	SetActive(arg_10_0.shutterAni_.gameObject, false)
	arg_10_0:RefreshUI()
end

function var_0_0.OnExit(arg_11_0)
	local var_11_0 = ActivitySummerSwimsuitPreheatCfg[arg_11_0.cfgId_]
	local var_11_1 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(var_11_0)

	AnimatorTools.Stop()
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.itemList_[arg_12_1].clickFun = function(arg_13_0)
		ShowPopItem(POP_ITEM, {
			arg_13_0.id,
			arg_13_0.number
		})
	end

	arg_12_2:SetData(arg_12_0.itemList_[arg_12_1])
end

function var_0_0.RefreshUI(arg_14_0)
	local var_14_0 = ActivitySummerSwimsuitPreheatCfg[arg_14_0.cfgId_]
	local var_14_1 = var_14_0.activity_id
	local var_14_2 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(var_14_0)
	local var_14_3 = ActivitySummerSwimsuitPreheatTools.GetCfgStageImage(var_14_0)

	arg_14_0.isStageClear_ = ActivitySummerSwimsuitPreheatData.IsStageClear(var_14_2, var_14_0.id)
	arg_14_0.isRewardGot_ = ActivitySummerSwimsuitPreheatData.IsGotStageReward(var_14_2, var_14_0.id)

	if arg_14_0.isStageClear_ then
		arg_14_0.stateController_:SetSelectedState(arg_14_0.isRewardGot_ and "finished" or "get")
	else
		arg_14_0.stateController_:SetSelectedState("play")
	end

	arg_14_0.itemList_ = {}

	for iter_14_0, iter_14_1 in pairs(var_14_0.reward_list) do
		local var_14_4 = clone(ItemTemplateData)

		var_14_4.id = iter_14_1[1]
		var_14_4.number = iter_14_1[2]
		var_14_4.completedFlag = arg_14_0.isRewardGot_

		table.insert(arg_14_0.itemList_, var_14_4)
	end

	arg_14_0.img_.sprite = var_14_3
	arg_14_0.text1_.text = var_14_0.preview_desc
	arg_14_0.text2_.text = var_14_0.comment_desc

	arg_14_0.uiList_:StartScroll(#arg_14_0.itemList_, 1)
end

function var_0_0.OnClickPlayBtn(arg_15_0)
	if arg_15_0.isAniPlaying_ then
		return
	end

	arg_15_0:PlayEffects(function()
		arg_15_0:Back()
		JumpTools.GoToSystem("/activitySummerSwimsuitPreheatGame", {
			cfgId = arg_15_0.cfgId_
		})
	end)
end

function var_0_0.PlayEffects(arg_17_0, arg_17_1)
	arg_17_0.isAniPlaying_ = true

	SetActive(arg_17_0.shutterAni_.gameObject, true)
	AnimatorTools.PlayAnimationWithCallback(arg_17_0.shutterAni_, "shutter_01_enter", function()
		arg_17_0.isAniPlaying_ = false

		arg_17_1()
	end)
end

function var_0_0.OnClickGetBtn(arg_19_0)
	local var_19_0 = ActivitySummerSwimsuitPreheatCfg[arg_19_0.cfgId_]
	local var_19_1 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(var_19_0)

	ActivitySummerSwimsuitPreheatAction.GetStageReward(var_19_1, var_19_0.id, function(arg_20_0, arg_20_1, arg_20_2)
		ActivitySummerSwimsuitPreheatAction.UpdateRedPoint(var_19_1)
		getReward(arg_20_2, nil, function()
			arg_19_0:RefreshUI()
		end)
	end)
end

function var_0_0.OnExitInput(arg_22_0)
	arg_22_0:Back()

	return true
end

function var_0_0.Back(arg_23_0)
	arg_23_0.isAniPlaying_ = false

	var_0_0.super.Back(arg_23_0)
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.uiList_:Dispose()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
