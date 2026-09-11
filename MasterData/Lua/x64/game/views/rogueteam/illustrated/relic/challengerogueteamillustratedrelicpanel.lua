ChallengeRogueTeamRelicPanelBaseView = import("game.views.rogueTeam.bag.relic.base.ChallengeRogueTeamRelicPanelBaseView")

local ChallengeRogueTeamIllustratedPanelView = class("ChallengeRogueTeamIllustratedPanelView", ChallengeRogueTeamRelicPanelBaseView)

function ChallengeRogueTeamIllustratedPanelView:Init()
	ChallengeRogueTeamIllustratedPanelView.super.Init(self)

	self.viewedHandler_ = handler(self, self.OnViewRelic)
end

function ChallengeRogueTeamIllustratedPanelView:InitCustomUI()
	self.lockController_ = self.controller_:GetController("lock")
	self.rewardController_ = self.btnController_:GetController("rewards")
end

function ChallengeRogueTeamIllustratedPanelView:OnEnter(arg_3_1)
	self.templateID_ = arg_3_1
	self.relicData_ = self:GetAllRelicData()

	manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))))
	ChallengeRogueTeamIllustratedPanelView.super.OnEnter(self)
end

function ChallengeRogueTeamIllustratedPanelView:OnViewRelic(arg_4_1)
	self:RefreshUI()
end

function ChallengeRogueTeamIllustratedPanelView:OnExit()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))))

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs((ChallengeRogueTeamData:GetAllItemIDByTempAndType(RogueTeamCfg[self.templateID_].item_temp, ChallengeRogueTeamConst.ITEM_TYPE.RELIC))) do
		if not ChallengeRogueTeamData:IsIllustratedViewd(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, iter_5_1) and ChallengeRogueTeamData:IsIllustratedUnlock(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, iter_5_1) then
			table.insert(var_5_0, iter_5_1)
		end
	end

	if not table.isEmpty(var_5_0) then
		ChallengeRogueTeamAction.RequestViewCollectionItem(self.templateID_, var_5_0, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC)
	end

	ChallengeRogueTeamIllustratedPanelView.super.OnExit(self)
end

function ChallengeRogueTeamIllustratedPanelView:GetAllRelicData()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((ChallengeRogueTeamData:GetIllustratedDataByType(ChallengeRogueTeamData:GetCacheTemplateID(), ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC))) do
		var_6_0[iter_6_1] = true
	end

	local var_6_1 = {}

	for iter_6_2, iter_6_3 in ipairs((ChallengeRogueTeamData:GetAllItemIDByTempAndType(RogueTeamCfg[self.templateID_].item_temp, ChallengeRogueTeamConst.ITEM_TYPE.RELIC))) do
		var_6_1[RogueTeamItemCfg[iter_6_3].sub_type] = var_6_1[RogueTeamItemCfg[iter_6_3].sub_type] or {}

		table.insert(var_6_1[RogueTeamItemCfg[iter_6_3].sub_type], iter_6_3)
	end

	for iter_6_4, iter_6_5 in ipairs(var_6_1) do
		table.sort(iter_6_5, function(arg_7_0, arg_7_1)
			if var_6_0[arg_7_0] ~= var_6_0[arg_7_1] then
				return var_6_0[arg_7_0] ~= nil
			else
				return arg_7_0 < arg_7_1
			end
		end)
	end

	return var_6_1
end

function ChallengeRogueTeamIllustratedPanelView:AddListeners()
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamIllustratedTaskPop", {
			activityIDList = ChallengeRogueTeamData:GetAllCollectionTaskByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC),
			type = ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC
		})
	end)
end

function ChallengeRogueTeamIllustratedPanelView:ShowItemInfo(arg_10_1)
	if not arg_10_1 then
		SetActive(self.infoGo_, false)
	else
		local var_10_0 = RogueTeamItemCfg[arg_10_1]

		SetActive(self.infoGo_, true)

		self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_10_1))
		self.relicName_.text = var_10_0.name
		self.itemDesc_.text = var_10_0.story_desc
		self.effectDesc_.text = var_10_0.desc

		if ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_10_1) then
			self.lockController_:SetSelectedState("on")
		elseif ChallengeRogueTeamData:IsIllustratedUnlock(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, arg_10_1) then
			self.lockController_:SetSelectedState("gray")

			self.lockText_.text = GetTips("ROGUE_TEAM_UNCOLLECTED_RELIC")
		else
			self.lockController_:SetSelectedState("black")

			self.itemDesc_.text = "???"
			self.relicName_.text = "???"
			self.lockText_.text = RogueTeamConditionCfg[var_10_0.condition].desc
		end
	end

	for iter_10_0, iter_10_1 in ipairs(self.loopScrollView_:GetItemList()) do
		iter_10_1.itemView:SetSelectID(arg_10_1)
	end
end

function ChallengeRogueTeamIllustratedPanelView:RefreshUI()
	local var_11_0 = math.floor(self.contentTf_.rect.width / self.itemTf_.rect.width)

	self.uiDataList_ = {}

	for iter_11_0, iter_11_1 in pairs((self:GetAllRelicData())) do
		table.insert(self.uiDataList_, {
			objectType = ChallengeRogueTeamIllustratedPanelView.OBJECT_TYPE.TITLE,
			data = iter_11_0,
			type = iter_11_0
		})

		local var_11_1 = {}

		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			local var_11_2 = math.floor((iter_11_2 - 1) / var_11_0) + 1

			var_11_1[var_11_2] = var_11_1[var_11_2] or {}

			table.insert(var_11_1[var_11_2], iter_11_3)
		end

		for iter_11_4, iter_11_5 in ipairs(var_11_1) do
			table.insert(self.uiDataList_, {
				objectType = ChallengeRogueTeamIllustratedPanelView.OBJECT_TYPE.ITEM,
				data = iter_11_5,
				type = iter_11_0
			})
		end
	end

	self.loopScrollView_:NavigateIndex(1)

	for iter_11_6, iter_11_7 in pairs(self.uiDataList_) do
		if iter_11_7.objectType == ChallengeRogueTeamIllustratedPanelView.OBJECT_TYPE.ITEM then
			self.selectRelicID_ = iter_11_7.data[1]

			break
		end
	end

	self:OnSelectRelic(self.selectRelicID_)

	local var_11_3 = ChallengeRogueTeamData:GetAllItemIDByTempAndType(RogueTeamCfg[self.templateID_].item_temp, ChallengeRogueTeamConst.ITEM_TYPE.RELIC)
	local var_11_4 = ChallengeRogueTeamData:GetIllustratedDataByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC)

	self.rewardController_:SetSelectedState(tostring(#ChallengeRogueTeamTools.GetCanRewardTask((ChallengeRogueTeamData:GetAllCollectionTaskByType(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))) > 0))

	self.taskProgressText_.text = #var_11_4 .. "/" .. #var_11_3
end

function ChallengeRogueTeamIllustratedPanelView:LsAddItem(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.objectType == ChallengeRogueTeamIllustratedPanelView.OBJECT_TYPE.TITLE and self:GetFreeTitleItem(self.titleItemPool_, function()
		return ChallengeRogueTeamBagRelicTitleItem.New(self.titleItem_, self.parent_)
	end) or self:GetFreeTitleItem(self.relicItemPool_, function()
		return ChallengeRogueTeamIllustratedRelicPanelItem.New(self.relicItem_, self.parent_)
	end)

	var_12_0.itemView:SetData(arg_12_1.data, arg_12_2)

	return var_12_0
end

return ChallengeRogueTeamIllustratedPanelView
