local var_0_0 = class("ChapterClueView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Xuheng_PlotMap/XuhengTerminalRecordUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.contTrs_ = arg_3_0.scroll_.content
	arg_3_0.viewTrs_ = arg_3_0.scroll_.viewport

	local var_3_0 = arg_3_0.viewTrs_.rect.height
	local var_3_1 = arg_3_0.contTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_3_0.loopScrollView_ = LoopScrollView.New(arg_3_0, arg_3_0.scroll_, arg_3_0.contTrs_, arg_3_0.viewTrs_, var_3_0, var_3_1, nil, false)
	arg_3_0.itemPool1_ = {}
	arg_3_0.emptyControl_ = arg_3_0.controllerEx_:GetController("empty")

	SetActive(arg_3_0.archiveItemGo_, false)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.chapterClientID_ = arg_4_0.params_.chapterClientID

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(ChapterV2MapTools.GetMapIDListByChapterClientID(arg_8_0.chapterClientID_)) do
		for iter_8_2, iter_8_3 in ipairs(ChapterV2MapTools.GetCachedMapSortedEvents(iter_8_1)) do
			if ChapterV2MapEventCfg[iter_8_3].type == ChapterV2MapConst.MapEventType.SUPPLEMENT and ChapterV2MapData:IsEventCompleted(iter_8_3) then
				table.insert(var_8_0, iter_8_3)
			end
		end
	end

	arg_8_0.eventList_ = var_8_0

	arg_8_0.emptyControl_:SetSelectedState(#arg_8_0.eventList_ == 0 and "true" or "false")
	arg_8_0.loopScrollView_:NavigateIndex(1)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 > #arg_9_0.eventList_ then
		arg_9_2:SetData(0, arg_9_1)
	else
		arg_9_2:SetData(arg_9_0.eventList_[arg_9_1], arg_9_1)
	end
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemPool1_) do
		iter_10_1.itemView:Dispose()
	end

	arg_10_0.itemPool1_ = nil

	arg_10_0.loopScrollView_:Dispose()

	arg_10_0.loopScrollView_ = nil

	var_0_0.super.Dispose(arg_10_0)

	arg_10_0.gameObject_ = nil
	arg_10_0.transform_ = nil
end

function var_0_0.LsRemoveItem(arg_11_0, arg_11_1)
	arg_11_1.itemView:Show(false)

	arg_11_1.isFree = true
end

function var_0_0.RefreshItemList(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.itemPool1_) do
		if iter_12_1.isFree == false then
			iter_12_1.itemView:RefreshUI()
		end
	end
end

function var_0_0.GetFreeItem(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		if iter_13_1.isFree == true then
			iter_13_1.isFree = false

			return iter_13_1
		end
	end

	local var_13_0 = {
		isFree = false,
		itemView = arg_13_2()
	}

	table.insert(arg_13_1, var_13_0)

	return var_13_0
end

function var_0_0.LsAddItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0
	local var_14_1 = arg_14_0:GetFreeItem(arg_14_0.itemPool1_, function()
		return ChapterV2MapArchiveCollectItem.New(arg_14_0.archiveItemGo_, arg_14_0.contTrs_.gameObject)
	end)

	var_14_1.itemView:SetData(arg_14_1.id, arg_14_2)

	return var_14_1
end

function var_0_0.LsGetItemData(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.eventList_) do
		table.insert(var_16_0, {
			id = iter_16_1
		})
	end

	return var_16_0
end

function var_0_0.LsUpdateItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_1.itemView:SetData(arg_17_2, arg_17_3)
end

return var_0_0
