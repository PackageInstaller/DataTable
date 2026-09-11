SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local SubPlotLuWuAndZhiMingView = class("SubPlotLuWuAndZhiMingView", SubPlotBaseView)

function SubPlotLuWuAndZhiMingView:UIName()
	return "UI/BranchlineUI/IndiaChapterSectionUI"
end

function SubPlotLuWuAndZhiMingView:GetItemClass()
	return SubPlotLuWuAndZhiMingItem
end

function SubPlotLuWuAndZhiMingView:Init()
	SubPlotLuWuAndZhiMingView.super.Init(self)

	self.chapterPartBtnView_ = ChapterPartBtnView.New(self.chapterBranchGo_)

	self.chapterPartBtnView_:Show(true)

	self.lineList_ = {}
	self.itemWidth_ = self.sectionItem_.transform:GetComponent("RectTransform").rect.width
end

function SubPlotLuWuAndZhiMingView:OnEnter()
	SubPlotLuWuAndZhiMingView.super.OnEnter(self)
	self.chapterPartBtnView_:OnEnter()
end

function SubPlotLuWuAndZhiMingView:OnExit()
	SubPlotLuWuAndZhiMingView.super.OnExit(self)
	self.chapterPartBtnView_:OnExit()
end

function SubPlotLuWuAndZhiMingView:RefreshData()
	SubPlotLuWuAndZhiMingView.super.RefreshData(self)

	self.openStageList_ = ChapterTools.GetOpenStageList(self.chapterID_, self:GetCfgName())
end

function SubPlotLuWuAndZhiMingView:RefreshUI()
	SubPlotLuWuAndZhiMingView.super.RefreshUI(self)

	self.titleText_.text = ChapterCfg[self.chapterID_].subhead

	self.chapterPartBtnView_:RefreshUI(self.chapterID_)
	self:RefreshLineItemList()
	self:SwitchBG()
end

function SubPlotLuWuAndZhiMingView:RefreshLineItemList()
	for iter_8_0, iter_8_1 in pairs(self.lineList_) do
		iter_8_1:Show(false)
	end

	local var_8_0 = 1
	local var_8_1 = self.openStageList_

	for iter_8_2, iter_8_3 in ipairs(self.openStageList_) do
		local var_8_2 = self.stageItemList_[table.keyof(self.stageList_, iter_8_3)]:GetLocalPosition() + Vector3(self.itemWidth_ / -2, 0, 0)
		local var_8_3 = self:GetCfgName()[iter_8_3].pre_show_id_list or {}

		for iter_8_4, iter_8_5 in ipairs(var_8_3) do
			if self.stageData_[iter_8_5] and self.stageData_[iter_8_5].clear_times > 0 then
				-- block empty
			else
				break
			end
		end

		for iter_8_6, iter_8_7 in ipairs(var_8_3) do
			local var_8_6 = self:GetCfgName()[iter_8_3]

			if table.keyof(var_8_1, iter_8_7) then
				local var_8_7 = self.stageItemList_[table.keyof(self.stageList_, iter_8_7)]:GetLocalPosition() + Vector3(self.itemWidth_ / 2, 0, 0)
				local var_8_8 = self.lineList_[var_8_0] or SectionSingleLineItem.New(self.lineGo_, self.content_, 11)

				var_8_8:Show(true)

				self.lineList_[var_8_0] = var_8_8

				var_8_8:RefreshUI(var_8_7, var_8_2)

				var_8_0 = var_8_0 + 1
			end
		end
	end
end

function SubPlotLuWuAndZhiMingView:Dispose()
	self.chapterPartBtnView_:Dispose()

	self.chapterPartBtnView_ = nil

	for iter_9_0, iter_9_1 in pairs(self.lineList_) do
		iter_9_1:Dispose()
	end

	self.lineList_ = nil

	SubPlotLuWuAndZhiMingView.super.Dispose(self)
end

return SubPlotLuWuAndZhiMingView
