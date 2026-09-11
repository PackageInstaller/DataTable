local ContinueBattleCostPopView = class("ContinueBattleCostPopView", ReduxView)

function ContinueBattleCostPopView:UIName()
	return "Widget/System/Operation/OperationContinuousPopUI"
end

function ContinueBattleCostPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ContinueBattleCostPopView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.rewardController_ = self.controllerEx_:GetController("item")
	self.btnController_ = self.controllerEx_:GetController("btn")
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CommonItemView)
end

function ContinueBattleCostPopView:OnEnter()
	self.stageType_ = self.params_.stageType
	self.stageID_ = self.params_.stageID
	self.callBack_ = self.params_.callback
	self.costList_, self.nextStageCnt_ = StageTools.GetContinueBattleCost(self.stageType_, self.stageID_)

	local var_4_0 = self.costList_[1].id

	self.descText_.text = string.format(GetTips("CONTINUE_BATTLE_COST_TIP"), self.nextStageCnt_, ItemTools.getItemName(self.costList_[1].id), self.costList_[1].num)

	local var_4_2 = BattleStageData:GetStageData()[self.stageID_]

	if var_4_2 and var_4_2.clear_times > 0 then
		self.btnController_:SetSelectedState("single")
	else
		self.btnController_:SetSelectedState("out")
	end

	self.stageList_ = StageTools.GetContinueBattleStageList(self.stageType_, self.stageID_)

	self:RefreshReward()
	manager.windowBar:SwitchBar({
		var_4_0
	})
	manager.windowBar:SetBarCanAdd(var_4_0, true)
	manager.windowBar:SetAsLastSibling()
end

function ContinueBattleCostPopView:OnExit()
	manager.windowBar:HideBar()
end

function ContinueBattleCostPopView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	ContinueBattleCostPopView.super.Dispose(self)
end

function ContinueBattleCostPopView:AddListeners()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.singleBtn_, nil, function()
		self:Back()

		local var_9_0 = BattleStageData:GetStageData()[self.stageID_]

		if var_9_0 and var_9_0.clear_times > 0 then
			BattleStageData:SetAutoNextBattle(false)
			self.callBack_()
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		BattleStageData:SetAutoNextBattle(true)
		self:Back()
		self.callBack_()
	end)
end

function ContinueBattleCostPopView:RefreshReward()
	local var_12_0 = self.stageList_[#self.stageList_]

	if ChapterTools.IsClearStage(var_12_0) then
		self.rewardController_:SetSelectedState("none")
	else
		local var_12_1 = BattleStageData:GetStageData()
		local var_12_2 = {}

		for iter_12_0, iter_12_1 in ipairs(self.stageList_) do
			local var_12_3 = not (var_12_1[iter_12_1] and var_12_1[iter_12_1].clear_times > 0)

			table.insertto(var_12_2, getRewardFromDropCfg(BattleStageTools.GetStageCfg(self.stageType_, iter_12_1).drop_lib_id, var_12_3))
		end

		self.rewardIDList_ = mergeReward(var_12_2)

		self.uiList_:StartScroll(#self.rewardIDList_)

		local var_12_5, var_12_6 = BattleStageTools.GetChapterSectionIndex(self.stageType_, var_12_0)

		self.clearTipsText_.text = string.format(GetTips("CLEAR_STAGE_DROP_REWARD"), string.format("%s-%s", GetI18NText(var_12_5), var_12_6))

		self.rewardController_:SetSelectedState("have")
	end
end

function ContinueBattleCostPopView:OnTop()
	self.canvasGroup_.alpha = 1
	self.canvasGroup_.blocksRaycasts = true
end

function ContinueBattleCostPopView:IndexItem(arg_14_1, arg_14_2)
	self.rewardIDList_[arg_14_1].clickFun = function(arg_15_0)
		ShowPopItem(POP_OTHER_ITEM, arg_15_0)

		self.canvasGroup_.alpha = 0
		self.canvasGroup_.blocksRaycasts = false
	end

	arg_14_2:SetData(self.rewardIDList_[arg_14_1])
end

return ContinueBattleCostPopView
