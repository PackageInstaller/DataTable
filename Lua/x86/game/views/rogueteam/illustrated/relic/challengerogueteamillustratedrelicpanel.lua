ChallengeRogueTeamRelicPanelBaseView = import("game.views.rogueTeam.bag.relic.base.ChallengeRogueTeamRelicPanelBaseView")

local var_0_0 = class("ChallengeRogueTeamIllustratedPanelView", ChallengeRogueTeamRelicPanelBaseView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.viewedHandler_ = handler(arg_1_0, arg_1_0.OnViewRelic)
end

function var_0_0.InitCustomUI(arg_2_0)
	arg_2_0.lockController_ = arg_2_0.controller_:GetController("lock")
	arg_2_0.rewardController_ = arg_2_0.btnController_:GetController("rewards")
end

function var_0_0.OnEnter(arg_3_0, arg_3_1)
	arg_3_0.templateID_ = arg_3_1

	local var_3_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(arg_3_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))

	arg_3_0.relicData_ = arg_3_0:GetAllRelicData()

	manager.redPoint:bindUIandKey(arg_3_0.taskBtn_.transform, var_3_0)
	var_0_0.super.OnEnter(arg_3_0)
end

function var_0_0.OnViewRelic(arg_4_0, arg_4_1)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	local var_5_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(arg_5_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))

	manager.redPoint:unbindUIandKey(arg_5_0.taskBtn_.transform, var_5_0)

	local var_5_1 = RogueTeamCfg[arg_5_0.templateID_].item_temp
	local var_5_2 = {}
	local var_5_3 = ChallengeRogueTeamData:GetAllItemIDByTempAndType(var_5_1, ChallengeRogueTeamConst.ITEM_TYPE.RELIC)

	for iter_5_0, iter_5_1 in ipairs(var_5_3) do
		local var_5_4 = ChallengeRogueTeamData:IsIllustratedViewd(arg_5_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, iter_5_1)
		local var_5_5 = ChallengeRogueTeamData:IsIllustratedUnlock(arg_5_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, iter_5_1)

		if not var_5_4 and var_5_5 then
			table.insert(var_5_2, iter_5_1)
		end
	end

	if not table.isEmpty(var_5_2) then
		ChallengeRogueTeamAction.RequestViewCollectionItem(arg_5_0.templateID_, var_5_2, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC)
	end

	var_0_0.super.OnExit(arg_5_0)
end

function var_0_0.GetAllRelicData(arg_6_0)
	local var_6_0 = RogueTeamCfg[arg_6_0.templateID_].item_temp
	local var_6_1 = ChallengeRogueTeamData:GetAllItemIDByTempAndType(var_6_0, ChallengeRogueTeamConst.ITEM_TYPE.RELIC)
	local var_6_2 = ChallengeRogueTeamData:GetIllustratedDataByType(ChallengeRogueTeamData:GetCacheTemplateID(), ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC)
	local var_6_3 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		var_6_3[iter_6_1] = true
	end

	local var_6_4 = {}

	for iter_6_2, iter_6_3 in ipairs(var_6_1) do
		local var_6_5 = RogueTeamItemCfg[iter_6_3].sub_type

		if not var_6_4[var_6_5] then
			var_6_4[var_6_5] = {}
		end

		table.insert(var_6_4[var_6_5], iter_6_3)
	end

	for iter_6_4, iter_6_5 in ipairs(var_6_4) do
		table.sort(iter_6_5, function(arg_7_0, arg_7_1)
			if var_6_3[arg_7_0] ~= var_6_3[arg_7_1] then
				return var_6_3[arg_7_0] ~= nil
			else
				return arg_7_0 < arg_7_1
			end
		end)
	end

	return var_6_4
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.taskBtn_, nil, function()
		local var_9_0 = ChallengeRogueTeamData:GetAllCollectionTaskByType(arg_8_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC)

		JumpTools.OpenPageByJump("challengeRogueTeamIllustratedTaskPop", {
			activityIDList = var_9_0,
			type = ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC
		})
	end)
end

function var_0_0.ShowItemInfo(arg_10_0, arg_10_1)
	if not arg_10_1 then
		SetActive(arg_10_0.infoGo_, false)
	else
		local var_10_0 = RogueTeamItemCfg[arg_10_1]

		SetActive(arg_10_0.infoGo_, true)

		arg_10_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_10_1))
		arg_10_0.relicName_.text = var_10_0.name
		arg_10_0.itemDesc_.text = var_10_0.story_desc
		arg_10_0.effectDesc_.text = var_10_0.desc

		local var_10_1 = ChallengeRogueTeamData:IsIllustratedObtained(arg_10_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_10_1)
		local var_10_2 = ChallengeRogueTeamData:IsIllustratedUnlock(arg_10_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_10_1)

		if var_10_1 then
			arg_10_0.lockController_:SetSelectedState("on")
		elseif var_10_2 then
			arg_10_0.lockController_:SetSelectedState("gray")

			arg_10_0.lockText_.text = GetTips("ROGUE_TEAM_UNCOLLECTED_RELIC")
		else
			arg_10_0.lockController_:SetSelectedState("black")

			arg_10_0.itemDesc_.text = "???"
			arg_10_0.relicName_.text = "???"
			arg_10_0.lockText_.text = RogueTeamConditionCfg[var_10_0.condition].desc
		end
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.loopScrollView_:GetItemList()) do
		iter_10_1.itemView:SetSelectID(arg_10_1)
	end
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = arg_11_0.contentTf_.rect.width
	local var_11_1 = arg_11_0.itemTf_.rect.width
	local var_11_2 = math.floor(var_11_0 / var_11_1)

	arg_11_0.uiDataList_ = {}

	local var_11_3 = arg_11_0:GetAllRelicData()

	for iter_11_0, iter_11_1 in pairs(var_11_3) do
		table.insert(arg_11_0.uiDataList_, {
			objectType = var_0_0.OBJECT_TYPE.TITLE,
			data = iter_11_0,
			type = iter_11_0
		})

		local var_11_4 = {}

		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			local var_11_5 = math.floor((iter_11_2 - 1) / var_11_2) + 1

			var_11_4[var_11_5] = var_11_4[var_11_5] or {}

			table.insert(var_11_4[var_11_5], iter_11_3)
		end

		for iter_11_4, iter_11_5 in ipairs(var_11_4) do
			table.insert(arg_11_0.uiDataList_, {
				objectType = var_0_0.OBJECT_TYPE.ITEM,
				data = iter_11_5,
				type = iter_11_0
			})
		end
	end

	arg_11_0.loopScrollView_:NavigateIndex(1)

	for iter_11_6, iter_11_7 in pairs(arg_11_0.uiDataList_) do
		if iter_11_7.objectType == var_0_0.OBJECT_TYPE.ITEM then
			arg_11_0.selectRelicID_ = iter_11_7.data[1]

			break
		end
	end

	arg_11_0:OnSelectRelic(arg_11_0.selectRelicID_)

	local var_11_6 = ChallengeRogueTeamData:GetAllItemIDByTempAndType(RogueTeamCfg[arg_11_0.templateID_].item_temp, ChallengeRogueTeamConst.ITEM_TYPE.RELIC)
	local var_11_7 = ChallengeRogueTeamData:GetIllustratedDataByType(arg_11_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC)
	local var_11_8 = ChallengeRogueTeamData:GetAllCollectionTaskByType(arg_11_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC)
	local var_11_9 = ChallengeRogueTeamTools.GetCanRewardTask(var_11_8)

	arg_11_0.rewardController_:SetSelectedState(tostring(#var_11_9 > 0))

	arg_11_0.taskProgressText_.text = #var_11_7 .. "/" .. #var_11_6
end

function var_0_0.LsAddItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.objectType
	local var_12_1

	if var_12_0 == var_0_0.OBJECT_TYPE.TITLE then
		var_12_1 = arg_12_0:GetFreeTitleItem(arg_12_0.titleItemPool_, function()
			return ChallengeRogueTeamBagRelicTitleItem.New(arg_12_0.titleItem_, arg_12_0.parent_)
		end)
	else
		var_12_1 = arg_12_0:GetFreeTitleItem(arg_12_0.relicItemPool_, function()
			return ChallengeRogueTeamIllustratedRelicPanelItem.New(arg_12_0.relicItem_, arg_12_0.parent_)
		end)
	end

	var_12_1.itemView:SetData(arg_12_1.data, arg_12_2)

	return var_12_1
end

return var_0_0
