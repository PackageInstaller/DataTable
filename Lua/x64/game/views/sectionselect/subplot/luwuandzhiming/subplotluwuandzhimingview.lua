SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local var_0_0 = class("SubPlotLuWuAndZhiMingView", SubPlotBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/IndiaChapterSectionUI"
end

function var_0_0.GetItemClass(arg_2_0)
	return SubPlotLuWuAndZhiMingItem
end

function var_0_0.Init(arg_3_0)
	var_0_0.super.Init(arg_3_0)

	arg_3_0.chapterPartBtnView_ = ChapterPartBtnView.New(arg_3_0.chapterBranchGo_)

	arg_3_0.chapterPartBtnView_:Show(true)

	arg_3_0.lineList_ = {}
	arg_3_0.itemWidth_ = arg_3_0.sectionItem_.transform:GetComponent("RectTransform").rect.width
end

function var_0_0.OnEnter(arg_4_0)
	var_0_0.super.OnEnter(arg_4_0)
	arg_4_0.chapterPartBtnView_:OnEnter()
end

function var_0_0.OnExit(arg_5_0)
	var_0_0.super.OnExit(arg_5_0)
	arg_5_0.chapterPartBtnView_:OnExit()
end

function var_0_0.RefreshData(arg_6_0)
	var_0_0.super.RefreshData(arg_6_0)

	arg_6_0.openStageList_ = ChapterTools.GetOpenStageList(arg_6_0.chapterID_, arg_6_0:GetCfgName())
end

function var_0_0.RefreshUI(arg_7_0)
	var_0_0.super.RefreshUI(arg_7_0)

	arg_7_0.titleText_.text = ChapterCfg[arg_7_0.chapterID_].subhead

	arg_7_0.chapterPartBtnView_:RefreshUI(arg_7_0.chapterID_)
	arg_7_0:RefreshLineItemList()
	arg_7_0:SwitchBG()
end

function var_0_0.RefreshLineItemList(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.lineList_) do
		iter_8_1:Show(false)
	end

	local var_8_0 = 1
	local var_8_1 = arg_8_0.openStageList_

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		local var_8_2 = table.keyof(arg_8_0.stageList_, iter_8_3)
		local var_8_3 = arg_8_0.stageItemList_[var_8_2]:GetLocalPosition() + Vector3(arg_8_0.itemWidth_ / -2, 0, 0)
		local var_8_4 = arg_8_0:GetCfgName()[iter_8_3].pre_show_id_list or {}
		local var_8_5

		var_8_5 = #var_8_4 > 1

		for iter_8_4, iter_8_5 in ipairs(var_8_4) do
			if arg_8_0.stageData_[iter_8_5] and arg_8_0.stageData_[iter_8_5].clear_times > 0 then
				-- block empty
			else
				local var_8_6 = false

				break
			end
		end

		for iter_8_6, iter_8_7 in ipairs(var_8_4) do
			local var_8_7 = arg_8_0:GetCfgName()[iter_8_3]

			if table.keyof(var_8_1, iter_8_7) then
				local var_8_8 = table.keyof(arg_8_0.stageList_, iter_8_7)
				local var_8_9 = arg_8_0.stageItemList_[var_8_8]:GetLocalPosition() + Vector3(arg_8_0.itemWidth_ / 2, 0, 0)
				local var_8_10 = arg_8_0.lineList_[var_8_0] or SectionSingleLineItem.New(arg_8_0.lineGo_, arg_8_0.content_, 11)

				var_8_10:Show(true)

				arg_8_0.lineList_[var_8_0] = var_8_10

				var_8_10:RefreshUI(var_8_9, var_8_3)

				var_8_0 = var_8_0 + 1
			end
		end
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.chapterPartBtnView_:Dispose()

	arg_9_0.chapterPartBtnView_ = nil

	for iter_9_0, iter_9_1 in pairs(arg_9_0.lineList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.lineList_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
