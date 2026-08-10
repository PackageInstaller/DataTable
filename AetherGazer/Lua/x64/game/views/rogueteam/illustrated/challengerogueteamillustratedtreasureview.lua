local var_0_0 = class("ChallengeRogueTeamIllustratedTreasureView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedTreasureUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.treasureItemList_ = {}

	arg_3_0:AddListeners()

	arg_3_0.rewardController_ = arg_3_0.taskController_:GetController("rewards")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.forwardBtn_, nil, function()
		arg_4_0:UnBindRedPoint()

		arg_4_0.index_ = arg_4_0.index_ - 1

		arg_4_0:RefreshUI()
		arg_4_0:BindRedPoint()
	end)
	arg_4_0:AddBtnListener(arg_4_0.nextBtn_, nil, function()
		arg_4_0:UnBindRedPoint()

		arg_4_0.index_ = arg_4_0.index_ + 1

		arg_4_0:RefreshUI()
		arg_4_0:BindRedPoint()
	end)
	arg_4_0:AddBtnListener(arg_4_0.taskBtn_, nil, function()
		local var_7_0 = ChallengeRogueTeamData:GetTreasureCollectionTaskByCamp(arg_4_0.templateID_, arg_4_0.campID_)

		JumpTools.OpenPageByJump("challengeRogueTeamIllustratedTaskPop", {
			activityIDList = var_7_0,
			type = ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP,
			campID = arg_4_0.campID_
		})
	end)
	TerminologyTools.AddTerminologyHandler(arg_4_0, arg_4_0.campSkillDescText_, nil, nil)
end

function var_0_0.UnBindRedPoint(arg_8_0)
	local var_8_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(arg_8_0.templateID_, arg_8_0.campID_))

	manager.redPoint:unbindUIandKey(arg_8_0.taskBtn_.transform, var_8_0)
end

function var_0_0.BindRedPoint(arg_9_0)
	local var_9_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(arg_9_0.templateID_, arg_9_0.campID_))

	manager.redPoint:bindUIandKey(arg_9_0.taskBtn_.transform, var_9_0)
end

function var_0_0.OnEnter(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_10_0.campID_ = arg_10_0.params_.id or 1
	arg_10_0.templateID_ = arg_10_0.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	arg_10_0.itemTempID_ = RogueTeamCfg[arg_10_0.templateID_].item_temp
	arg_10_0.treasureID_, arg_10_0.schoolIDList_ = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(arg_10_0.itemTempID_)
	arg_10_0.treasureUnlockDataList_ = ChallengeRogueTeamData:GetIllustratedDataByType(arg_10_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP)
	arg_10_0.index_ = table.indexof(arg_10_0.schoolIDList_, arg_10_0.campID_)

	arg_10_0:RefreshUI()
	arg_10_0:BindRedPoint()
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.campID_ = arg_11_0.schoolIDList_[arg_11_0.index_]
	arg_11_0.campIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.CAMP_BIG_ICON_PATH_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[arg_11_0.index_])
	arg_11_0.campTitleText_.text = GetTips("ROGUE_TEAM_SCHOOL_NAME_" .. arg_11_0.campID_)
	arg_11_0.campDataList_ = ChallengeRogueTeamData:GetIllustratedDataByType(arg_11_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP)
	arg_11_0.campSkllID_ = ChallengeRogueTeamData:GetCampUltimateByCamp(arg_11_0.itemTempID_, arg_11_0.campID_)
	arg_11_0.treasureIDList_ = ChallengeRogueTeamData:GetAllCampTreasureIDByCamp(arg_11_0.itemTempID_, arg_11_0.campID_)
	arg_11_0.campSkillCfg_ = RogueTeamItemCfg[arg_11_0.campSkllID_]
	arg_11_0.campSkillIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_11_0.campSkllID_))
	arg_11_0.campSkillTitleText_.text = arg_11_0.campSkillCfg_.name
	arg_11_0.campSkillDescText_.text = ChallengeRogueTeamTools.GetItemDesc(arg_11_0.campSkllID_, nil, arg_11_0.campSkillDescText_.color)
	arg_11_0.unlockTresureList_ = ChallengeRogueTeamData:GetUnlockIllustratedTreasureDataByCamp(arg_11_0.templateID_, arg_11_0.campID_)

	local var_11_0 = ChallengeRogueTeamData:GetTreasureCollectionTaskByCamp(arg_11_0.templateID_, arg_11_0.campID_)
	local var_11_1 = ChallengeRogueTeamTools.GetCanRewardTask(var_11_0)

	arg_11_0.rewardController_:SetSelectedState(tostring(#var_11_1 > 0))

	arg_11_0.taskProgressText_.text = #arg_11_0.unlockTresureList_ .. "/" .. #arg_11_0.treasureIDList_

	table.sort(arg_11_0.treasureIDList_, function(arg_12_0, arg_12_1)
		local var_12_0 = ChallengeRogueTeamData:IsIllustratedObtained(arg_11_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP, arg_12_0)
		local var_12_1 = ChallengeRogueTeamData:IsIllustratedObtained(arg_11_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP, arg_12_1)

		if var_12_0 ~= var_12_1 then
			if var_12_0 and not var_12_1 then
				return true
			elseif not var_12_0 and var_12_1 then
				return false
			end
		elseif arg_12_0 ~= arg_12_1 then
			return arg_12_1 < arg_12_0
		else
			return false
		end
	end)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.treasureItemList_) do
		SetActive(iter_11_1.gameObject_, false)
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_0.treasureIDList_) do
		if not arg_11_0.treasureItemList_[iter_11_2] then
			local var_11_2 = GameObject.Instantiate(arg_11_0.treasureItem_, arg_11_0.treasureContent_)
			local var_11_3 = ChallengeRogueTeamIllustratedTreasureItem.New(var_11_2)

			table.insert(arg_11_0.treasureItemList_, var_11_3)
		end

		local var_11_4 = ChallengeRogueTeamData:IsIllustratedObtained(arg_11_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.CAMP, iter_11_3)

		arg_11_0.treasureItemList_[iter_11_2]:SetData(iter_11_2, iter_11_3, var_11_4)
		SetActive(arg_11_0.treasureItemList_[iter_11_2].gameObject_, true)
	end

	SetActive(arg_11_0.forwardBtn_.gameObject, arg_11_0.index_ > 1)
	SetActive(arg_11_0.nextBtn_.gameObject, arg_11_0.index_ < #arg_11_0.schoolIDList_)

	arg_11_0.slidetText_.text = arg_11_0.index_ .. "/" .. #arg_11_0.schoolIDList_
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:UnBindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:RefreshUI()
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.treasureItemList_ then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.treasureItemList_) do
			iter_15_1:Dispose()
		end
	end

	arg_15_0.treasureItemList_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
