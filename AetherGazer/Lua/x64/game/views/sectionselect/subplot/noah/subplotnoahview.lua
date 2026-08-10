SubPlotOuMoFeiSiView = import("game.views.sectionSelect.subPlot.ouMoFeiSi.SubPlotOuMoFeiSiView")

local var_0_0 = class("SubPlotNoahView", SubPlotOuMoFeiSiView)

function var_0_0.UIName(arg_1_0)
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

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.partGroupList = {}
end

function var_0_0.GetScrollWidth(arg_3_0)
	return var_0_0.super.GetScrollWidth(arg_3_0) + 800
end

function var_0_0.RefreshSelectItem(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.partGroupList) do
		iter_4_1:SelectorItem(arg_4_0.selectSection_)
	end
end

function var_0_0.RefreshMissionList(arg_5_0)
	if arg_5_0.lastChapterID_ == arg_5_0.chapterID_ then
		return
	end

	arg_5_0.lastChapterID_ = arg_5_0.chapterID_

	local var_5_0 = true

	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		if not arg_5_0.partGroupList[iter_5_0] then
			local var_5_1 = arg_5_0.contentRect_:GetChild(iter_5_0 - 1).gameObject

			arg_5_0.partGroupList[iter_5_0] = SubPlotNoahGroupItem.New(var_5_1)
		end

		local var_5_2 = {}

		if var_5_0 then
			local var_5_3 = arg_5_0.stageList_[iter_5_1[1]]

			if not (table.indexof(arg_5_0.oepnStageList_, var_5_3) or false) then
				var_5_0 = false
			else
				for iter_5_2, iter_5_3 in pairs(iter_5_1) do
					local var_5_4 = arg_5_0.stageList_[iter_5_3]

					table.insert(var_5_2, var_5_4)
				end
			end
		end

		if #var_5_2 > 0 then
			arg_5_0.partGroupList[iter_5_0]:SetData(iter_5_0, arg_5_0.chapterID_, var_5_2)
			arg_5_0.partGroupList[iter_5_0]:Show(true)
		else
			arg_5_0.partGroupList[iter_5_0]:Show(false)
		end
	end
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.partGroupList) do
		iter_6_1:Dispose()

		iter_6_1 = nil
	end

	arg_6_0.partGroupList = {}

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
