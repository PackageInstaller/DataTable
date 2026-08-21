local var_0_0 = class("ChallengeRogueTeamIllustratedTreasureEntraceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedTreasureEnterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.schoolItemList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.templateID_ = arg_4_0.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()

	arg_4_0:RefreshUI()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.schoolIDList_) do
		local var_4_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(arg_4_0.templateID_, iter_4_1))

		manager.redPoint:bindUIandKey(arg_4_0.schoolItemList_[iter_4_0].redpointTrs_, var_4_0)
	end
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = RogueTeamCfg[arg_6_0.templateID_].item_temp

	arg_6_0.treasureID_, arg_6_0.schoolIDList_ = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(var_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.schoolItemList_) do
		SetActive(iter_6_1.gameObject_, false)
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.schoolIDList_) do
		if not arg_6_0.schoolItemList_[iter_6_2] then
			local var_6_1 = GameObject.Instantiate(arg_6_0.schoolItem_, arg_6_0.schoolContent_)

			arg_6_0.schoolItemList_[iter_6_2] = ChallengeRogueTeamIllustratedSchoolItem.New(var_6_1)
		end

		arg_6_0.schoolItemList_[iter_6_2]:SetData(iter_6_2, iter_6_3, var_6_0)
		SetActive(arg_6_0.schoolItemList_[iter_6_2].gameObject_, true)
	end
end

function var_0_0.OnExit(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.schoolIDList_) do
		local var_7_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(arg_7_0.templateID_, iter_7_1))

		manager.redPoint:unbindUIandKey(arg_7_0.schoolItemList_[iter_7_0].redpointTrs_, var_7_0)
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	if arg_8_0.schoolItemList_ then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.schoolItemList_) do
			iter_8_1:Dispose()
		end

		arg_8_0.schoolItemList_ = nil
	end
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_9_0:RefreshUI()
end

return var_0_0
