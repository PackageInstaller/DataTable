local IlluPlotDetail = class("IlluPlotDetail", ReduxView)

function IlluPlotDetail:UIName()
	return "Widget/System/IllustratedHandbook/IlluPlotDetailUI"
end

function IlluPlotDetail:UIParent()
	return manager.ui.uiMain.transform
end

function IlluPlotDetail:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluPlotDetail:InitUI()
	self:BindCfgUI()

	self.bgImg_.immediate = true
	self.scroll_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, IlluPlotDetailItem)
end

function IlluPlotDetail:AddUIListener()
	self:AddBtnListener(self.illuStrationBtn_, nil, function()
		local var_6_0 = 1
		local var_6_1 = self.chapterID_

		if self.selType_ == 2 then
			var_6_0 = 3
			var_6_1 = self.activtyChapterID_
		elseif self.selType_ == 3 then
			var_6_0 = 4
		end

		self:Go("/illuIllustration", {
			selectSubMenuChapterID = var_6_1,
			index = var_6_0
		})
	end)
end

function IlluPlotDetail:UpdateDate()
	self.itemList_ = self.list_

	table.sort(self.itemList_, function(arg_8_0, arg_8_1)
		if CollectStoryCfg[arg_8_0].order ~= CollectStoryCfg[arg_8_1].order then
			return CollectStoryCfg[arg_8_0].order < CollectStoryCfg[arg_8_1].order
		end

		return arg_8_0 < arg_8_1
	end)
end

function IlluPlotDetail:indexItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(self.itemList_[arg_9_1], self.selType_)
end

function IlluPlotDetail:RefreshUI(arg_10_1)
	if arg_10_1 == 1 then
		self.bgImg_.spriteSync = SpritePathCfg.CollectPlotBig.path .. ChapterClientCfg[self.chapterID_].chapter_paint
	elseif arg_10_1 == 2 then
		self.activtyChapterID_ = CollectStoryCfg[CollectStoryCfg.get_id_list_by_activity[self.chapterID_][1]].chapter_client_id
		self.bgImg_.spriteSync = SpritePathCfg.CollectPlotBig.path .. CollectStoryCfg[CollectStoryCfg.get_id_list_by_activity[self.chapterID_][1]].picture
	elseif arg_10_1 == 3 then
		self.bgImg_.spriteSync = SpritePathCfg.CollectPlotBig.path .. CollectStoryCfg[self.list_[1]].picture
	end

	self:UpdateDate()
	self.scroll_:StartScroll(#self.itemList_)
end

function IlluPlotDetail:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if not self:CheckIsRefresh() then
		return
	end

	self.list_ = self.params_.storyList
	self.chapterID_ = self.params_.chapterID
	self.chapterClientID_ = self.params_.chapterClientID
	self.selType_ = self.params_.selType

	self:RefreshUI(self.selType_)
end

function IlluPlotDetail:CheckIsRefresh()
	if not self.list_ then
		return true
	end

	for iter_12_0, iter_12_1 in pairs(self.params_.storyList) do
		if self.list_[iter_12_0] ~= iter_12_1 then
			return true
		end
	end

	if self.chapterID_ ~= self.params_.chapterID or self.selType_ ~= self.params_.selType then
		return true
	end

	return false
end

function IlluPlotDetail:OnExit()
	manager.windowBar:HideBar()
end

function IlluPlotDetail:Dispose()
	self.scroll_:Dispose()

	self.scroll_ = nil

	IlluPlotDetail.super.Dispose(self)
end

return IlluPlotDetail
