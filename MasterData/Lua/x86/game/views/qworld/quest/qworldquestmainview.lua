local QWorldQuestMainView = class("QWorldQuestMainView", ReduxView)

function QWorldQuestMainView:UIName()
	return "Widget/System/SandPlay/SandPlay_Quest/SandPlay_QuestPopUI"
end

function QWorldQuestMainView:UIParent()
	return manager.ui.uiPop.transform
end

function QWorldQuestMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldQuestMainView:InitUI()
	self:BindCfgUI()

	self.rewardList_ = LuaList.New(handler(self, self.IndexRewardItem), self.rewardUiList_, CommonItemView)
	self.allToggle_ = QWorldQuestToggleItem.New(self.allGo_)
	self.mainToggle_ = QWorldQuestToggleItem.New(self.mainGo_)
	self.sideToggle_ = QWorldQuestToggleItem.New(self.sideGo_)
	self.exploreToggle_ = QWorldQuestToggleItem.New(self.exploreGo_)
	self.emptyController_ = self.conEx_:GetController("empty")
	self.showRewardController_ = self.conEx_:GetController("showReward")
	self.questCategoryItems_ = {}
	self.questItems_ = {}
	self.condItems_ = {}

	SetActive(self.questItem_, false)
	SetActive(self.questCondItem_, false)
	SetActive(self.questTypeItem_, false)
end

function QWorldQuestMainView:AddUIListener()
	self:AddBtnListener(self.trackBtn_, nil, function()
		local var_6_0 = self.curMainQuestId_ == QWorldQuestTool.GetMainQuestTrackingId() and -1 or self.curMainQuestId_

		QWorldQuestAction.UpdateTrackingMainQuestId(var_6_0, function()
			self:RefreshQuestContent(self.curMainQuestId_)
			self:RefreshUI()

			if var_6_0 ~= -1 then
				QWorldQuestAction.SendUpdateQuestTrackToSdk(self.curMainQuestId_, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
				self:Back()
			else
				QWorldQuestAction.SendUpdateQuestTrackToSdk(self.curMainQuestId_, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.UNTRACK)
			end
		end)
	end)
	self:AddBtnListener(self.gotoMapBtn_, nil, function()
		local var_8_0 = QWorldQuestTool.GetQuestTrackingEntityIdList(self.curMainQuestId_)

		if var_8_0 and #var_8_0 > 0 then
			JumpTools.GoToSystem("/qWorldMaxMapView", {
				selectEntity = var_8_0[1]
			})
		end
	end)
	self.allToggle_:SetCallback(function()
		self:RefreshQuestCache()
		self:RefreshUI()
	end)
	self.mainToggle_:SetCallback(function()
		self:RefreshQuestCache(QWorldQuestConst.QUEST_TASK_TYPE.MAIN)
		self:RefreshUI()
	end)
	self.sideToggle_:SetCallback(function()
		self:RefreshQuestCache(QWorldQuestConst.QUEST_TASK_TYPE.SIDE)
		self:RefreshUI()
	end)
	self.exploreToggle_:SetCallback(function()
		self:RefreshQuestCache(QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE)
		self:RefreshUI()
	end)
end

function QWorldQuestMainView:IndexRewardItem(arg_13_1, arg_13_2)
	local var_13_0 = self.rewardItemList[arg_13_1]

	if ItemCfg[self.rewardItemList[arg_13_1].id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_13_0.id].type then
		if EquipCfg[var_13_0.id] then
			var_13_0.race = EquipCfg[var_13_0.id].race or 0
		end
	end

	local var_13_1 = clone(ItemTemplateData)

	var_13_1.id = var_13_0.id
	var_13_1.number = var_13_0.num
	var_13_1.race = var_13_0.race

	function var_13_1:clickFun()
		ShowPopItemOnly(POP_OTHER_ITEM, {
			self.id,
			self.number
		})
	end

	arg_13_2:SetData(var_13_1)
end

function QWorldQuestMainView:OnEnter()
	self.allToggle_:SetToggleValue(true)
	self:RefreshQuestCache()
	self:RefreshUI()
end

function QWorldQuestMainView:OnTop()
	JumpTools.RefreshGaussianBg()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:SetAsLastSibling()
end

function QWorldQuestMainView:OnBehind()
	manager.windowBar:HideBar()
end

function QWorldQuestMainView:OnExit()
	return
end

function QWorldQuestMainView:OnQWorldMainQuestUpdate()
	self:RefreshQuestCache(self.lastTaskType_)
	self:RefreshUI()
end

function QWorldQuestMainView:OnQWorldQuestUpdateProgress()
	if QWorldQuestTool.MainQuestHasRealtimeProgress(self.curMainQuestId_) then
		self:RefreshQuestContent(self.curMainQuestId_)
	end
end

function QWorldQuestMainView:RefreshQuestCache(arg_21_1)
	self.lastTaskType_ = arg_21_1
	self.mainQuestIdList_ = {}

	for iter_21_0, iter_21_1 in ipairs(SandplayTaskMainCfg.all) do
		if (not arg_21_1 or SandplayTaskMainCfg[iter_21_1].main_task_type == arg_21_1) and QWorldQuestTool.IsMainQuestTrackable(iter_21_1, true, self.statusText_.gameObject.activeSelf) then
			self.mainQuestIdList_[SandplayTaskMainCfg[iter_21_1].main_task_type] = self.mainQuestIdList_[SandplayTaskMainCfg[iter_21_1].main_task_type] or {}

			table.insert(self.mainQuestIdList_[SandplayTaskMainCfg[iter_21_1].main_task_type], iter_21_1)
		end
	end

	for iter_21_2, iter_21_3 in pairs(self.mainQuestIdList_) do
		table.sort(iter_21_3, function(arg_22_0, arg_22_1)
			local var_22_0 = SandplayTaskMainCfg[arg_22_0]
			local var_22_1 = SandplayTaskMainCfg[arg_22_1]

			if SandplayTaskMainCfg[arg_22_0].priority ~= SandplayTaskMainCfg[arg_22_1].priority then
				return var_22_0.priority < var_22_1.priority
			end

			if var_22_0.priority == var_22_1.priority then
				return var_22_0.main_task_id < var_22_1.main_task_id
			else
				return var_22_0.priority < var_22_1.priority
			end
		end)
	end

	if not table.isEmpty(self.mainQuestIdList_) then
		self.selectedId_ = QWorldQuestTool.GetMainQuestTrackingId()

		if not SandplayTaskMainCfg[self.selectedId_] or not self.mainQuestIdList_[SandplayTaskMainCfg[self.selectedId_].main_task_type] or not table.indexof(self.mainQuestIdList_[SandplayTaskMainCfg[self.selectedId_].main_task_type], self.selectedId_) then
			self.selectedId_ = table.GetFirstElem(self.mainQuestIdList_)[1]
		end
	end
end

function QWorldQuestMainView:RefreshUI()
	self.emptyController_:SetSelectedState(table.isEmpty(self.mainQuestIdList_) and "true" or "false")

	for iter_23_0, iter_23_1 in pairs(self.questCategoryItems_) do
		SetActive(iter_23_1.gameObject_, self.mainQuestIdList_[iter_23_0] ~= nil)
	end

	local var_23_0 = 0

	for iter_23_2, iter_23_3 in pairs(self.mainQuestIdList_) do
		local var_23_1 = self.questCategoryItems_[iter_23_2]

		if not self.questCategoryItems_[iter_23_2] then
			local var_23_2 = Object.Instantiate(self.questTypeItem_, self.questsTrans_)

			SetActive(var_23_2, true)

			var_23_1 = QWorldQuestCategory.New(var_23_2)
			self.questCategoryItems_[iter_23_2] = var_23_1

			var_23_1:SetData(iter_23_2)
		end

		for iter_23_4 = 1, #iter_23_3 do
			var_23_0 = var_23_0 + 1

			local var_23_3 = self.questItems_[var_23_0]

			if not self.questItems_[var_23_0] then
				local var_23_4 = Object.Instantiate(self.questItem_, self.questsTrans_)

				SetActive(var_23_4, true)

				var_23_3 = QWorldMainQuestItem.New(var_23_4)
				self.questItems_[var_23_0] = var_23_3
			end

			local var_23_5 = iter_23_3[iter_23_4]

			var_23_3:SetData(iter_23_3[iter_23_4])
			var_23_3.gameObject_.transform:SetSiblingIndex(var_23_1.transform_:GetSiblingIndex() + iter_23_4)
			var_23_3:SetClickHandler(function(arg_24_0)
				self:RefreshQuestContent(arg_24_0)
				self:RefreshSelectState(arg_24_0)
			end)

			if self.selectedId_ == var_23_5 then
				self:RefreshQuestContent(var_23_5)
			end
		end
	end

	for iter_23_5 = 1, #self.questItems_ do
		SetActive(self.questItems_[iter_23_5].gameObject_, iter_23_5 <= var_23_0)
	end

	self:RefreshSelectState(self.selectedId_)
end

function QWorldQuestMainView:RefreshSelectState(arg_25_1)
	self.selectedId_ = arg_25_1

	for iter_25_0, iter_25_1 in ipairs(self.questItems_) do
		iter_25_1:SetSelected(arg_25_1 == iter_25_1.mainQuestId_)
	end
end

function QWorldQuestMainView:RefreshQuestContent(arg_26_1)
	local var_26_0 = SandplayTaskMainCfg[arg_26_1]

	self.titleText_.text = SandplayTaskMainCfg[arg_26_1].title

	local var_26_1 = QWorldQuestTool.GetMainQuestTrackingId()

	self.trackText_.text = var_26_1 ~= arg_26_1 and GetTips("SANDPLAY_TRACK") or GetTips("SANDPLAY_TRACK_CANCEL")

	SetActive(self.gotoMapBtn_.gameObject, var_26_1 == arg_26_1)

	local var_26_3 = {}

	if var_26_0.reward ~= "" then
		for iter_26_0, iter_26_1 in pairs(var_26_0.reward) do
			table.insert(var_26_3, iter_26_1)
		end
	end

	local var_26_4 = sortReward((mergeReward((formatRewardCfgList(var_26_3)))))

	if self.curMainQuestId_ ~= arg_26_1 then
		self.rewardItemList = var_26_4

		self.rewardList_:StartScroll(#self.rewardItemList)
		self.showRewardController_:SetSelectedIndex(#var_26_4 == 0 and 0 or 1)
	end

	self.questIdList_ = QWorldQuestTool.GetLoadedQuestIdList(arg_26_1)

	local var_26_5 = QWorldQuestTool.GetLoadedQuestIdList(arg_26_1)

	table.sort(var_26_5, function(arg_27_0, arg_27_1)
		return arg_27_1 < arg_27_0
	end)

	self.contentText_.text = SandplayTaskCfg[var_26_5[1]] and (SandplayTaskCfg[var_26_5[1]].main_description or var_26_0.descrption) or var_26_0.descrption

	local var_26_6 = #self.questIdList_

	for iter_26_2, iter_26_3 in ipairs(self.condItems_) do
		SetActive(iter_26_3.gameObject_, iter_26_2 <= var_26_6)
	end

	for iter_26_4 = 1, var_26_6 do
		local var_26_7 = self.condItems_[iter_26_4]

		if not self.condItems_[iter_26_4] then
			local var_26_8 = Object.Instantiate(self.questCondItem_, self.conditionListTrans_)

			SetActive(var_26_8, true)

			var_26_7 = QWorldQuestItem.New(var_26_8)
			self.condItems_[iter_26_4] = var_26_7
		end

		var_26_7:SetData(self.questIdList_[iter_26_4])
	end

	self.curMainQuestId_ = arg_26_1

	if self.statusText_.gameObject.activeSelf then
		local var_26_9 = {
			[QWorldQuestConst.QUEST_STATUS.IN_PROGRESS] = "进行中",
			[QWorldQuestConst.QUEST_STATUS.FINISH] = "已完成",
			[QWorldQuestConst.QUEST_STATUS.NOT_START] = "未开始",
			[QWorldQuestConst.QUEST_STATUS.SKIPPED] = "已跳过"
		}
		local var_26_10 = string.format("主任务ID: %d, 任务状态: %s", arg_26_1, ({
			[QWorldQuestConst.MAIN_QUEST_STATUS.LOCKED] = "锁定中",
			[QWorldQuestConst.MAIN_QUEST_STATUS.UNLOCK] = "已解锁",
			[QWorldQuestConst.MAIN_QUEST_STATUS.UNTAKE] = "未领取",
			[QWorldQuestConst.MAIN_QUEST_STATUS.IN_PROGRESS] = "进行中",
			[QWorldQuestConst.MAIN_QUEST_STATUS.FINISH] = "已完成"
		})[QWorldQuestData:GetMainQuestData(arg_26_1).status])

		if #SandplayTaskCfg.get_id_list_by_main_task_id[arg_26_1] == 0 then
			var_26_10 = string.format("%s\n%s", var_26_10, string.format("任务条件全部完成"))
		end

		for iter_26_5, iter_26_6 in ipairs(SandplayTaskCfg.get_id_list_by_main_task_id[arg_26_1]) do
			var_26_10 = string.format("%s\n%s", var_26_10, string.format("子任务(%d): %d/%d, 状态: %s", iter_26_6, (QWorldQuestData:GetQuestData(iter_26_6) or {
				progress = 0
			}).progress, SandplayTaskCfg[iter_26_6].need, var_26_9[QWorldQuestTool.GetQuestStatus(iter_26_6)]))
		end

		self.statusText_.text = var_26_10
	end
end

function QWorldQuestMainView:Dispose()
	for iter_28_0, iter_28_1 in pairs(self.questCategoryItems_) do
		iter_28_1:Dispose()
	end

	for iter_28_2, iter_28_3 in ipairs(self.questItems_) do
		iter_28_3:Dispose()
	end

	for iter_28_4, iter_28_5 in ipairs(self.condItems_) do
		iter_28_5:Dispose()
	end

	if self.allToggle_ then
		self.allToggle_:Dispose()

		self.allToggle_ = nil
	end

	if self.mainToggle_ then
		self.mainToggle_:Dispose()

		self.mainToggle_ = nil
	end

	if self.sideToggle_ then
		self.sideToggle_:Dispose()

		self.sideToggle_ = nil
	end

	if self.exploreToggle_ then
		self.exploreToggle_:Dispose()

		self.exploreToggle_ = nil
	end

	self.rewardList_:Dispose()
	QWorldQuestMainView.super.Dispose(self)
end

return QWorldQuestMainView
