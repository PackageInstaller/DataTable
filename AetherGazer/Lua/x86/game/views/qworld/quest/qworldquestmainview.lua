local var_0_0 = class("QWorldQuestMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_Quest/SandPlay_QuestPopUI"
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

	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexRewardItem), arg_4_0.rewardUiList_, CommonItemView)
	arg_4_0.allToggle_ = QWorldQuestToggleItem.New(arg_4_0.allGo_)
	arg_4_0.mainToggle_ = QWorldQuestToggleItem.New(arg_4_0.mainGo_)
	arg_4_0.sideToggle_ = QWorldQuestToggleItem.New(arg_4_0.sideGo_)
	arg_4_0.exploreToggle_ = QWorldQuestToggleItem.New(arg_4_0.exploreGo_)
	arg_4_0.emptyController_ = arg_4_0.conEx_:GetController("empty")
	arg_4_0.showRewardController_ = arg_4_0.conEx_:GetController("showReward")
	arg_4_0.questCategoryItems_ = {}
	arg_4_0.questItems_ = {}
	arg_4_0.condItems_ = {}

	SetActive(arg_4_0.questItem_, false)
	SetActive(arg_4_0.questCondItem_, false)
	SetActive(arg_4_0.questTypeItem_, false)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.trackBtn_, nil, function()
		local var_6_0 = arg_5_0.curMainQuestId_ == QWorldQuestTool.GetMainQuestTrackingId() and -1 or arg_5_0.curMainQuestId_

		QWorldQuestAction.UpdateTrackingMainQuestId(var_6_0, function()
			arg_5_0:RefreshQuestContent(arg_5_0.curMainQuestId_)
			arg_5_0:RefreshUI()

			if var_6_0 ~= -1 then
				QWorldQuestAction.SendUpdateQuestTrackToSdk(arg_5_0.curMainQuestId_, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
				arg_5_0:Back()
			else
				QWorldQuestAction.SendUpdateQuestTrackToSdk(arg_5_0.curMainQuestId_, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.UNTRACK)
			end
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.gotoMapBtn_, nil, function()
		local var_8_0 = QWorldQuestTool.GetQuestTrackingEntityIdList(arg_5_0.curMainQuestId_)

		if var_8_0 and #var_8_0 > 0 then
			JumpTools.GoToSystem("/qWorldMaxMapView", {
				selectEntity = var_8_0[1]
			})
		end
	end)
	arg_5_0.allToggle_:SetCallback(function()
		arg_5_0:RefreshQuestCache()
		arg_5_0:RefreshUI()
	end)
	arg_5_0.mainToggle_:SetCallback(function()
		arg_5_0:RefreshQuestCache(QWorldQuestConst.QUEST_TASK_TYPE.MAIN)
		arg_5_0:RefreshUI()
	end)
	arg_5_0.sideToggle_:SetCallback(function()
		arg_5_0:RefreshQuestCache(QWorldQuestConst.QUEST_TASK_TYPE.SIDE)
		arg_5_0:RefreshUI()
	end)
	arg_5_0.exploreToggle_:SetCallback(function()
		arg_5_0:RefreshQuestCache(QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE)
		arg_5_0:RefreshUI()
	end)
end

function var_0_0.IndexRewardItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.rewardItemList[arg_13_1]

	if ItemCfg[var_13_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_13_0.id].type then
		var_13_0.race = EquipCfg[var_13_0.id] and EquipCfg[var_13_0.id].race or 0
	end

	local var_13_1 = clone(ItemTemplateData)

	var_13_1.id = var_13_0.id
	var_13_1.number = var_13_0.num
	var_13_1.race = var_13_0.race

	function var_13_1.clickFun(arg_14_0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			arg_14_0.id,
			arg_14_0.number
		})
	end

	arg_13_2:SetData(var_13_1)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.allToggle_:SetToggleValue(true)
	arg_15_0:RefreshQuestCache()
	arg_15_0:RefreshUI()
end

function var_0_0.OnTop(arg_16_0)
	JumpTools.RefreshGaussianBg()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnBehind(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_18_0)
	return
end

function var_0_0.OnQWorldMainQuestUpdate(arg_19_0)
	arg_19_0:RefreshQuestCache(arg_19_0.lastTaskType_)
	arg_19_0:RefreshUI()
end

function var_0_0.OnQWorldQuestUpdateProgress(arg_20_0)
	if QWorldQuestTool.MainQuestHasRealtimeProgress(arg_20_0.curMainQuestId_) then
		arg_20_0:RefreshQuestContent(arg_20_0.curMainQuestId_)
	end
end

function var_0_0.RefreshQuestCache(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.statusText_.gameObject.activeSelf

	arg_21_0.lastTaskType_ = arg_21_1
	arg_21_0.mainQuestIdList_ = {}

	for iter_21_0, iter_21_1 in ipairs(SandplayTaskMainCfg.all) do
		local var_21_1 = SandplayTaskMainCfg[iter_21_1]

		if (not arg_21_1 or var_21_1.main_task_type == arg_21_1) and QWorldQuestTool.IsMainQuestTrackable(iter_21_1, true, var_21_0) then
			if not arg_21_0.mainQuestIdList_[var_21_1.main_task_type] then
				arg_21_0.mainQuestIdList_[var_21_1.main_task_type] = {}
			end

			table.insert(arg_21_0.mainQuestIdList_[var_21_1.main_task_type], iter_21_1)
		end
	end

	for iter_21_2, iter_21_3 in pairs(arg_21_0.mainQuestIdList_) do
		table.sort(iter_21_3, function(arg_22_0, arg_22_1)
			local var_22_0 = SandplayTaskMainCfg[arg_22_0]
			local var_22_1 = SandplayTaskMainCfg[arg_22_1]

			if var_22_0.priority ~= var_22_1.priority then
				return var_22_0.priority < var_22_1.priority
			end

			if var_22_0.priority == var_22_1.priority then
				return var_22_0.main_task_id < var_22_1.main_task_id
			else
				return var_22_0.priority < var_22_1.priority
			end
		end)
	end

	if not table.isEmpty(arg_21_0.mainQuestIdList_) then
		arg_21_0.selectedId_ = QWorldQuestTool.GetMainQuestTrackingId()

		local var_21_2 = SandplayTaskMainCfg[arg_21_0.selectedId_]

		if not var_21_2 or not arg_21_0.mainQuestIdList_[var_21_2.main_task_type] or not table.indexof(arg_21_0.mainQuestIdList_[var_21_2.main_task_type], arg_21_0.selectedId_) then
			arg_21_0.selectedId_ = table.GetFirstElem(arg_21_0.mainQuestIdList_)[1]
		end
	end
end

function var_0_0.RefreshUI(arg_23_0)
	arg_23_0.emptyController_:SetSelectedState(table.isEmpty(arg_23_0.mainQuestIdList_) and "true" or "false")

	for iter_23_0, iter_23_1 in pairs(arg_23_0.questCategoryItems_) do
		SetActive(iter_23_1.gameObject_, arg_23_0.mainQuestIdList_[iter_23_0] ~= nil)
	end

	local var_23_0 = 0

	for iter_23_2, iter_23_3 in pairs(arg_23_0.mainQuestIdList_) do
		local var_23_1 = arg_23_0.questCategoryItems_[iter_23_2]

		if not var_23_1 then
			local var_23_2 = Object.Instantiate(arg_23_0.questTypeItem_, arg_23_0.questsTrans_)

			SetActive(var_23_2, true)

			var_23_1 = QWorldQuestCategory.New(var_23_2)
			arg_23_0.questCategoryItems_[iter_23_2] = var_23_1

			var_23_1:SetData(iter_23_2)
		end

		for iter_23_4 = 1, #iter_23_3 do
			var_23_0 = var_23_0 + 1

			local var_23_3 = arg_23_0.questItems_[var_23_0]

			if not var_23_3 then
				local var_23_4 = Object.Instantiate(arg_23_0.questItem_, arg_23_0.questsTrans_)

				SetActive(var_23_4, true)

				var_23_3 = QWorldMainQuestItem.New(var_23_4)
				arg_23_0.questItems_[var_23_0] = var_23_3
			end

			local var_23_5 = iter_23_3[iter_23_4]

			var_23_3:SetData(var_23_5)
			var_23_3.gameObject_.transform:SetSiblingIndex(var_23_1.transform_:GetSiblingIndex() + iter_23_4)
			var_23_3:SetClickHandler(function(arg_24_0)
				arg_23_0:RefreshQuestContent(arg_24_0)
				arg_23_0:RefreshSelectState(arg_24_0)
			end)

			if arg_23_0.selectedId_ == var_23_5 then
				arg_23_0:RefreshQuestContent(var_23_5)
			end
		end
	end

	for iter_23_5 = 1, #arg_23_0.questItems_ do
		SetActive(arg_23_0.questItems_[iter_23_5].gameObject_, iter_23_5 <= var_23_0)
	end

	arg_23_0:RefreshSelectState(arg_23_0.selectedId_)
end

function var_0_0.RefreshSelectState(arg_25_0, arg_25_1)
	arg_25_0.selectedId_ = arg_25_1

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.questItems_) do
		iter_25_1:SetSelected(arg_25_1 == iter_25_1.mainQuestId_)
	end
end

function var_0_0.RefreshQuestContent(arg_26_0, arg_26_1)
	local var_26_0 = SandplayTaskMainCfg[arg_26_1]

	arg_26_0.titleText_.text = var_26_0.title

	local var_26_1 = QWorldQuestTool.GetMainQuestTrackingId()

	arg_26_0.trackText_.text = var_26_1 ~= arg_26_1 and GetTips("SANDPLAY_TRACK") or GetTips("SANDPLAY_TRACK_CANCEL")

	SetActive(arg_26_0.gotoMapBtn_.gameObject, var_26_1 == arg_26_1)

	local var_26_2 = {}

	if var_26_0.reward ~= "" then
		for iter_26_0, iter_26_1 in pairs(var_26_0.reward) do
			table.insert(var_26_2, iter_26_1)
		end
	end

	local var_26_3 = formatRewardCfgList(var_26_2)
	local var_26_4 = mergeReward(var_26_3)
	local var_26_5 = sortReward(var_26_4)

	if arg_26_0.curMainQuestId_ ~= arg_26_1 then
		arg_26_0.rewardItemList = var_26_5

		arg_26_0.rewardList_:StartScroll(#arg_26_0.rewardItemList)
		arg_26_0.showRewardController_:SetSelectedIndex(#var_26_5 == 0 and 0 or 1)
	end

	arg_26_0.questIdList_ = QWorldQuestTool.GetLoadedQuestIdList(arg_26_1)

	local var_26_6 = QWorldQuestTool.GetLoadedQuestIdList(arg_26_1)

	table.sort(var_26_6, function(arg_27_0, arg_27_1)
		return arg_27_1 < arg_27_0
	end)

	local var_26_7 = SandplayTaskCfg[var_26_6[1]]

	if var_26_7 then
		arg_26_0.contentText_.text = var_26_7.main_description or var_26_0.descrption
	else
		arg_26_0.contentText_.text = var_26_0.descrption
	end

	local var_26_8 = #arg_26_0.questIdList_

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.condItems_) do
		SetActive(iter_26_3.gameObject_, iter_26_2 <= var_26_8)
	end

	for iter_26_4 = 1, var_26_8 do
		local var_26_9 = arg_26_0.condItems_[iter_26_4]

		if not var_26_9 then
			local var_26_10 = Object.Instantiate(arg_26_0.questCondItem_, arg_26_0.conditionListTrans_)

			SetActive(var_26_10, true)

			var_26_9 = QWorldQuestItem.New(var_26_10)
			arg_26_0.condItems_[iter_26_4] = var_26_9
		end

		var_26_9:SetData(arg_26_0.questIdList_[iter_26_4])
	end

	arg_26_0.curMainQuestId_ = arg_26_1

	if arg_26_0.statusText_.gameObject.activeSelf then
		local var_26_11 = {
			[QWorldQuestConst.MAIN_QUEST_STATUS.LOCKED] = "锁定中",
			[QWorldQuestConst.MAIN_QUEST_STATUS.UNLOCK] = "已解锁",
			[QWorldQuestConst.MAIN_QUEST_STATUS.UNTAKE] = "未领取",
			[QWorldQuestConst.MAIN_QUEST_STATUS.IN_PROGRESS] = "进行中",
			[QWorldQuestConst.MAIN_QUEST_STATUS.FINISH] = "已完成"
		}
		local var_26_12 = {
			[QWorldQuestConst.QUEST_STATUS.IN_PROGRESS] = "进行中",
			[QWorldQuestConst.QUEST_STATUS.FINISH] = "已完成",
			[QWorldQuestConst.QUEST_STATUS.NOT_START] = "未开始",
			[QWorldQuestConst.QUEST_STATUS.SKIPPED] = "已跳过"
		}
		local var_26_13 = SandplayTaskCfg.get_id_list_by_main_task_id[arg_26_1]
		local var_26_14 = QWorldQuestData:GetMainQuestData(arg_26_1)
		local var_26_15 = string.format("主任务ID: %d, 任务状态: %s", arg_26_1, var_26_11[var_26_14.status])

		if #var_26_13 == 0 then
			var_26_15 = string.format("%s\n%s", var_26_15, string.format("任务条件全部完成"))
		end

		for iter_26_5, iter_26_6 in ipairs(var_26_13) do
			local var_26_16 = QWorldQuestData:GetQuestData(iter_26_6) or {
				progress = 0
			}
			local var_26_17 = SandplayTaskCfg[iter_26_6]

			var_26_15 = string.format("%s\n%s", var_26_15, string.format("子任务(%d): %d/%d, 状态: %s", iter_26_6, var_26_16.progress, var_26_17.need, var_26_12[QWorldQuestTool.GetQuestStatus(iter_26_6)]))
		end

		arg_26_0.statusText_.text = var_26_15
	end
end

function var_0_0.Dispose(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.questCategoryItems_) do
		iter_28_1:Dispose()
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.questItems_) do
		iter_28_3:Dispose()
	end

	for iter_28_4, iter_28_5 in ipairs(arg_28_0.condItems_) do
		iter_28_5:Dispose()
	end

	if arg_28_0.allToggle_ then
		arg_28_0.allToggle_:Dispose()

		arg_28_0.allToggle_ = nil
	end

	if arg_28_0.mainToggle_ then
		arg_28_0.mainToggle_:Dispose()

		arg_28_0.mainToggle_ = nil
	end

	if arg_28_0.sideToggle_ then
		arg_28_0.sideToggle_:Dispose()

		arg_28_0.sideToggle_ = nil
	end

	if arg_28_0.exploreToggle_ then
		arg_28_0.exploreToggle_:Dispose()

		arg_28_0.exploreToggle_ = nil
	end

	arg_28_0.rewardList_:Dispose()
	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
