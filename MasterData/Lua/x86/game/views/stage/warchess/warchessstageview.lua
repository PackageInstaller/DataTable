local WarChessStageView = class("WarChessStageView", ReduxView)

function WarChessStageView:UIName()
	return "Widget/System/WarChess_Stage/WarChessStageUI"
end

function WarChessStageView:UIParent()
	return manager.ui.uiMain.transform
end

function WarChessStageView:Init()
	self.chapterList_ = {}
	self.itemList_ = {}

	self:InitUI()
	self:AddListeners()
end

function WarChessStageView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	self.chapterClientID_ = self.params_.chapterClientID
	self.chapterList = ChapterClientCfg.get_id_list_by_toggle[ChapterClientCfg[ChapterClientCfg[self.chapterClientID_].chapter_list[1]].toggle]

	BattleFieldData:SetCacheChapterClient(getChapterToggle(self.chapterClientID_), self.chapterClientID_)
	WarChessData:SetChapterClientID(self.chapterClientID_)
	self:RefreshItems()

	for iter_4_0, iter_4_1 in ipairs(self.itemList_) do
		iter_4_1:OnEnter()
	end

	if self.params_.firstChapter then
		self.scrollView_.horizontalNormalizedPosition = 0.95
	else
		local var_4_1 = table.indexof(self.chapterList_, (WarChessData:GetCurrentChapter(0)))

		self.scrollView_.horizontalNormalizedPosition = var_4_1 and (var_4_1 - 1) / #self.chapterList_ or WarChessData:GetViewPos()
	end

	WarChessAction.CancelWarChessRedPoint()
end

function WarChessStageView:OnExit()
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in pairs(self.itemList_) do
		iter_5_1:OnExit()
	end

	WarChessData:CacheViewPos(self.scrollView_.horizontalNormalizedPosition)
end

function WarChessStageView:Dispose()
	self:RemoveListeners()

	for iter_6_0, iter_6_1 in pairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.itemList_ = nil

	WarChessStageView.super.Dispose(self)

	self.scrollView_ = nil
	self.item_ = nil
	self.itemParent_ = nil
end

function WarChessStageView:InitUI()
	self:BindCfgUI()
end

function WarChessStageView:AddListeners()
	return
end

function WarChessStageView:RemoveListeners()
	return
end

function WarChessStageView:RefreshItems()
	self:UpdateChapterList()

	for iter_10_0, iter_10_1 in pairs(self.itemList_) do
		iter_10_1:Dispose()
	end

	self.itemList_ = {}

	for iter_10_2 = #self.itemList_ + 1, #self.chapterList_ do
		local var_10_0 = self:CreateItem(self.chapterList_[iter_10_2])

		var_10_0:Show(true)
		table.insert(self.itemList_, var_10_0)
	end
end

function WarChessStageView:CreateItem(arg_11_1)
	return (WarChessStageItemView.New(self.item_, self.itemParent_, arg_11_1))
end

function WarChessStageView:UpdateChapterList()
	self.chapterList_ = ChapterClientCfg[self.chapterClientID_].chapter_list
end

function WarChessStageView:OnSystemSwitchUpdate()
	self:RefreshItems()
end

return WarChessStageView
