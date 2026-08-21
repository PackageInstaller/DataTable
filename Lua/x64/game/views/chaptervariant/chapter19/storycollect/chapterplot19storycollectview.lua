local var_0_0 = class("ChapterPlot19StoryCollectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationVerStoryUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.chapterID_ = arg_4_0.params_.chapterID

	arg_4_0:RefreshItemList()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.itemList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.backBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.RefreshItemList(arg_9_0)
	local var_9_0 = arg_9_0:GetItemDataList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if arg_9_0.itemList_[iter_9_0] == nil then
			arg_9_0.itemList_[iter_9_0] = ChapterPlot19StoryCollectItem.New(arg_9_0.item_, arg_9_0.itemParent_)
		end

		arg_9_0.itemList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #arg_9_0.itemList_, #var_9_0 + 1, -1 do
		arg_9_0.itemList_[iter_9_2]:Dispose()

		arg_9_0.itemList_[iter_9_2] = nil
	end
end

function var_0_0.GetItemDataList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(ChapterStoryCollectCfg.get_id_list_by_chapter_id[arg_10_0.chapterID_]) do
		if ChapterTools.HasReadEvent(iter_10_1) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

return var_0_0
