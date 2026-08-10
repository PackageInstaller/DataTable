local var_0_0 = class("ChapterPlot19MapLocationInfo", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/ChapterVerStageListInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.titleView_ = ChapterPlot19MapLocationTitleItem.New(arg_3_0.titleItem_)
	arg_3_0.eventTitleView_ = ChapterPlot19MapLocationTitleItem.New(arg_3_0.eventTitleItem_)
	arg_3_0.finishTitleView_ = ChapterPlot19MapLocationTitleItem.New(arg_3_0.finishTitleItem_)
	arg_3_0.stageItemList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:SetData()
	arg_4_0:RefreshUI()
end

function var_0_0.SetData(arg_5_0)
	arg_5_0.chapterID_ = arg_5_0.params_.chapterID
	arg_5_0.locationID_ = arg_5_0.params_.locationID
end

function var_0_0.OnUpdate(arg_6_0)
	arg_6_0:SetData()
	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	arg_8_0.titleView_:Dispose()

	arg_8_0.titleView_ = nil

	arg_8_0.eventTitleView_:Dispose()

	arg_8_0.eventTitleView_ = nil

	arg_8_0.finishTitleView_:Dispose()

	arg_8_0.finishTitleView_ = nil

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.stageItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.stageItemList_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	return
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = ChapterLocationCfg[arg_10_0.locationID_]

	arg_10_0.nameText_.text = var_10_0.name

	local var_10_1, var_10_2, var_10_3 = arg_10_0:GetSortStageList()

	if #var_10_1 > 0 then
		arg_10_0.titleView_:Show(true)
	else
		arg_10_0.titleView_:Show(false)
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		arg_10_0.stageItemList_[iter_10_0] = arg_10_0.stageItemList_[iter_10_0] or ChapterPlot19MapLocationStageItem.New(arg_10_0.stageItem_, arg_10_0.parentGo_)

		arg_10_0.stageItemList_[iter_10_0]:SetData(arg_10_0.chapterID_, iter_10_1)
	end

	if #var_10_2 > 0 then
		arg_10_0.eventTitleView_:Show(true)
	else
		arg_10_0.eventTitleView_:Show(false)
	end

	for iter_10_2, iter_10_3 in ipairs(var_10_2) do
		local var_10_4 = iter_10_2 + #var_10_1

		arg_10_0.stageItemList_[var_10_4] = arg_10_0.stageItemList_[var_10_4] or ChapterPlot19MapLocationStageItem.New(arg_10_0.stageItem_, arg_10_0.parentGo_)

		arg_10_0.stageItemList_[var_10_4]:SetData(arg_10_0.chapterID_, iter_10_3)
	end

	if #var_10_3 > 0 then
		arg_10_0.finishTitleView_:Show(true)
	else
		arg_10_0.finishTitleView_:Show(false)
	end

	for iter_10_4, iter_10_5 in ipairs(var_10_3) do
		local var_10_5 = iter_10_4 + #var_10_1 + #var_10_2

		arg_10_0.stageItemList_[var_10_5] = arg_10_0.stageItemList_[var_10_5] or ChapterPlot19MapLocationStageItem.New(arg_10_0.stageItem_, arg_10_0.parentGo_)

		arg_10_0.stageItemList_[var_10_5]:SetData(arg_10_0.chapterID_, iter_10_5)
	end

	for iter_10_6 = #var_10_1 + #var_10_2 + #var_10_3 + 1, #arg_10_0.stageItemList_ do
		arg_10_0.stageItemList_[iter_10_6]:Show(false)
	end
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:Show(true)
end

function var_0_0.OnBehind(arg_12_0)
	arg_12_0:Show(false)
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObjet_, arg_13_1)
end

function var_0_0.GetSortStageList(arg_14_0)
	local var_14_0 = ChapterLocationCfg[arg_14_0.locationID_]
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0.stage_list) do
		local var_14_4 = BattleStageData:GetStageData()[iter_14_1]

		if var_14_4 and var_14_4.clear_times > 0 then
			table.insert(var_14_3, {
				id = iter_14_1,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY
			})
		elseif var_14_4 then
			table.insert(var_14_1, {
				id = iter_14_1,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY
			})
		end
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_0.sub_stage_list) do
		local var_14_5 = BattleStageData:GetStageData()[iter_14_3]

		if var_14_5 and var_14_5.clear_times > 0 then
			table.insert(var_14_3, {
				id = iter_14_3,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.SIDE_STORY
			})
		elseif var_14_5 then
			table.insert(var_14_1, {
				id = iter_14_3,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.SIDE_STORY
			})
		end
	end

	for iter_14_4, iter_14_5 in ipairs(var_14_0.event_list) do
		if BattleStageData:HasReadLocationEvent(iter_14_5) then
			table.insert(var_14_3, {
				id = iter_14_5,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.EVENT
			})
		elseif ChapterTools.IsUnlockEvent(iter_14_5) then
			table.insert(var_14_2, {
				id = iter_14_5,
				stageType = BattleConst.PLOT_19_STAGE_TYPE.EVENT
			})
		end
	end

	return var_14_1, var_14_2, var_14_3
end

return var_0_0
