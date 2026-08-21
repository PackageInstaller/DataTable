local var_0_0 = class("HodurChapterSettlementView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hodur/Activity_Hodur_GameOverPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.stageItemList_ = {}
	arg_3_0.chapterID_ = arg_3_0.params_.chapter_id or 1

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:BackFunc()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ActivityHodurChapterCfg[arg_8_0.chapterID_].stage_list

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = var_8_0[iter_8_0][1]

		if not arg_8_0.stageItemList_[iter_8_0] then
			local var_8_2 = Object.Instantiate(arg_8_0.stageItem_, arg_8_0.itenContentTrs_)

			arg_8_0.stageItemList_[iter_8_0] = HodurMainlineSettlementItem.New(var_8_2)
		end

		arg_8_0.stageItemList_[iter_8_0]:SetData(var_8_1)
		arg_8_0.stageItemList_[iter_8_0]:SetActive(true)
	end

	for iter_8_1 = #var_8_0 + 1, #arg_8_0.stageItemList_ do
		arg_8_0.stageItemList_[iter_8_1]:SetActive(false)
	end
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:HideBar()
	manager.windowBar:RegistBackCallBack(function()
		arg_9_0:BackFunc()
	end)
end

function var_0_0.BackFunc(arg_11_0)
	local var_11_0 = ActivityHodurChapterCfg[arg_11_0.chapterID_].story_id
	local var_11_1 = StoryCfg[var_11_0]

	if HodurTools.GetChapterState(arg_11_0.chapterID_) == HodurConst.COMMON_STATE.PASS and not getData("activity_hodur", "hodur_story" .. var_11_0) and var_11_1 then
		saveData("activity_hodur", "hodur_story" .. var_11_0, true)
		manager.story:StartStoryById(var_11_0, function()
			HodurTools.GotoMainlineView()
		end)
	else
		HodurTools.GotoMainlineView()
	end
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	for iter_15_0 = 1, #arg_15_0.stageItemList_ do
		arg_15_0.stageItemList_[iter_15_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()
end

return var_0_0
