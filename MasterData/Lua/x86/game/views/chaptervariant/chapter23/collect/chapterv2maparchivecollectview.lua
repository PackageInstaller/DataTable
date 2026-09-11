local ChapterClueView = class("ChapterClueView", ReduxView)

function ChapterClueView:UIName()
	return "Widget/System/Xuheng_PlotMap/XuhengTerminalRecordUI"
end

function ChapterClueView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterClueView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.contTrs_ = self.scroll_.content
	self.viewTrs_ = self.scroll_.viewport
	self.loopScrollView_ = LoopScrollView.New(self, self.scroll_, self.contTrs_, self.viewTrs_, self.viewTrs_.rect.height, self.contTrs_:GetComponent("VerticalLayoutGroup").spacing, nil, false)
	self.itemPool1_ = {}
	self.emptyControl_ = self.controllerEx_:GetController("empty")

	SetActive(self.archiveItemGo_, false)
end

function ChapterClueView:OnEnter()
	self.chapterClientID_ = self.params_.chapterClientID

	self:RefreshUI()
end

function ChapterClueView:OnExit()
	return
end

function ChapterClueView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function ChapterClueView:RefreshUI()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(ChapterV2MapTools.GetMapIDListByChapterClientID(self.chapterClientID_)) do
		for iter_8_2, iter_8_3 in ipairs(ChapterV2MapTools.GetCachedMapSortedEvents(iter_8_1)) do
			if ChapterV2MapEventCfg[iter_8_3].type == ChapterV2MapConst.MapEventType.SUPPLEMENT and ChapterV2MapData:IsEventCompleted(iter_8_3) then
				table.insert(var_8_0, iter_8_3)
			end
		end
	end

	self.eventList_ = var_8_0

	self.emptyControl_:SetSelectedState(#self.eventList_ == 0 and "true" or "false")
	self.loopScrollView_:NavigateIndex(1)
end

function ChapterClueView:IndexItem(arg_9_1, arg_9_2)
	if arg_9_1 > #self.eventList_ then
		arg_9_2:SetData(0, arg_9_1)
	else
		arg_9_2:SetData(self.eventList_[arg_9_1], arg_9_1)
	end
end

function ChapterClueView:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.itemPool1_) do
		iter_10_1.itemView:Dispose()
	end

	self.itemPool1_ = nil

	self.loopScrollView_:Dispose()

	self.loopScrollView_ = nil

	ChapterClueView.super.Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterClueView:LsRemoveItem(arg_11_1)
	arg_11_1.itemView:Show(false)

	arg_11_1.isFree = true
end

function ChapterClueView:RefreshItemList()
	for iter_12_0, iter_12_1 in ipairs(self.itemPool1_) do
		if iter_12_1.isFree == false then
			iter_12_1.itemView:RefreshUI()
		end
	end
end

function ChapterClueView:GetFreeItem(arg_13_1, arg_13_2)
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

function ChapterClueView:LsAddItem(arg_14_1, arg_14_2)
	(nil).itemView:SetData(arg_14_1.id, arg_14_2)

	return (self:GetFreeItem(self.itemPool1_, function()
		return ChapterV2MapArchiveCollectItem.New(self.archiveItemGo_, self.contTrs_.gameObject)
	end))
end

function ChapterClueView:LsGetItemData()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self.eventList_) do
		table.insert(var_16_0, {
			id = iter_16_1
		})
	end

	return var_16_0
end

function ChapterClueView:LsUpdateItem(arg_17_1, arg_17_2, arg_17_3)
	arg_17_1.itemView:SetData(arg_17_2, arg_17_3)
end

return ChapterClueView
