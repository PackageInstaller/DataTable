SubPlotOuMoFeiSiView = import("game.views.sectionSelect.subPlot.ouMoFeiSi.SubPlotOuMoFeiSiView")

local SubPlotNoahView = class("SubPlotNoahView", SubPlotOuMoFeiSiView)

function SubPlotNoahView:UIName()
	return "Widget/System/Operation/ChapterSectionUI/V4_7_Hodr_ChapterSectionUI"
end

local var_0_1 = {
	{
		1
	},
	{
		2,
		3
	},
	{
		4
	},
	{
		5,
		6
	},
	{
		7,
		8,
		9
	},
	{
		10,
		11
	},
	{
		12,
		13
	},
	{
		14,
		15
	}
}

function SubPlotNoahView:Init()
	SubPlotNoahView.super.Init(self)

	self.partGroupList = {}
end

function SubPlotNoahView:GetScrollWidth()
	return SubPlotNoahView.super.GetScrollWidth(self) + 800
end

function SubPlotNoahView:RefreshSelectItem()
	for iter_4_0, iter_4_1 in pairs(self.partGroupList) do
		iter_4_1:SelectorItem(self.selectSection_)
	end
end

function SubPlotNoahView:RefreshMissionList()
	if self.lastChapterID_ == self.chapterID_ then
		return
	end

	self.lastChapterID_ = self.chapterID_

	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		self.partGroupList[iter_5_0] = self.partGroupList[iter_5_0] or SubPlotNoahGroupItem.New(self.contentRect_:GetChild(iter_5_0 - 1).gameObject)

		local var_5_0 = {}

		if true then
			local var_5_1

			if not (table.indexof(self.oepnStageList_, self.stageList_[iter_5_1[1]]) or false) then
				var_5_1 = false
			else
				for iter_5_2, iter_5_3 in pairs(iter_5_1) do
					table.insert(var_5_0, self.stageList_[iter_5_3])
				end
			end
		end

		if #var_5_0 > 0 then
			self.partGroupList[iter_5_0]:SetData(iter_5_0, self.chapterID_, var_5_0)
			self.partGroupList[iter_5_0]:Show(true)
		else
			self.partGroupList[iter_5_0]:Show(false)
		end
	end
end

function SubPlotNoahView:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.partGroupList) do
		iter_6_1:Dispose()

		iter_6_1 = nil
	end

	self.partGroupList = {}

	SubPlotNoahView.super.Dispose(self)
end

return SubPlotNoahView
