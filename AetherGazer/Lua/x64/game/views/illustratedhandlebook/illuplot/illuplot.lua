local var_0_0 = class("IlluPlot", ReduxView)
local var_0_1 = {
	MAIN_STORY = 1,
	BRITHDAY_STORY = 3,
	ACTIVITY_STORY = 2
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluplotUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, IlluPlotItem)
	arg_4_0.btn1Controller = ControllerUtil.GetController(arg_4_0.btn1trs_, "name")
	arg_4_0.btn2Controller = ControllerUtil.GetController(arg_4_0.btn2trs_, "name")
	arg_4_0.btn3Controller = ControllerUtil.GetController(arg_4_0.btn3trs_, "name")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_1, nil, function()
		arg_5_0.params_.index = 1
		arg_5_0.selType_ = 1

		arg_5_0:RefreshUI(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_2, nil, function()
		arg_5_0.params_.index = 2
		arg_5_0.selType_ = 2

		arg_5_0:RefreshUI(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_3, nil, function()
		arg_5_0.params_.index = 3
		arg_5_0.selType_ = 3

		arg_5_0:RefreshUI(3)
	end)
end

function var_0_0.UpdateDate(arg_9_0, arg_9_1)
	arg_9_0.itemList_ = {}

	local var_9_0 = {}
	local var_9_1 = {}

	if not CollectStoryCfg.get_id_list_by_type[arg_9_1] then
		return
	end

	if arg_9_1 == var_0_1.MAIN_STORY then
		local var_9_2 = {}

		for iter_9_0, iter_9_1 in ipairs(CollectStoryCfg.get_id_list_by_type[arg_9_1]) do
			local var_9_3 = StoryCfg[iter_9_1]

			if var_9_3 and var_9_3.trigger[2] then
				local var_9_4 = var_9_3.trigger[2]
				local var_9_5 = getChapterIDByStageID(var_9_4)

				if var_9_5 then
					if not var_9_2[var_9_5] then
						var_9_2[var_9_5] = {
							chapterID = var_9_5,
							storyList = {}
						}
					end

					table.insert(var_9_2[var_9_5].storyList, var_9_3.id)
				end
			end
		end

		for iter_9_2, iter_9_3 in pairs(var_9_2) do
			local var_9_6 = ChapterClientCfg[iter_9_2]

			if var_9_6 then
				local var_9_7 = {
					chapterID = iter_9_2,
					storyList = {}
				}

				for iter_9_4, iter_9_5 in ipairs(var_9_6.chapter_list) do
					if var_9_2[iter_9_5] then
						table.insertto(var_9_7.storyList, var_9_2[iter_9_5].storyList)
					end
				end

				table.insert(arg_9_0.itemList_, var_9_7)

				var_9_0[iter_9_2] = #var_9_7.storyList
			end
		end
	elseif arg_9_1 == var_0_1.ACTIVITY_STORY then
		for iter_9_6, iter_9_7 in ipairs(CollectStoryCfg.get_id_list_by_type[arg_9_1]) do
			local var_9_8 = CollectStoryCfg[iter_9_7].activity

			if not var_9_1[var_9_8] then
				var_9_1[var_9_8] = {}
			end

			table.insert(var_9_1[var_9_8], iter_9_7)
		end

		for iter_9_8, iter_9_9 in pairs(var_9_1) do
			for iter_9_10, iter_9_11 in ipairs(iter_9_9) do
				if IllustratedData:GetPlotInfo()[iter_9_11] then
					table.insert(arg_9_0.itemList_, {
						chapterID = iter_9_8,
						storyList = iter_9_9
					})

					var_9_0[iter_9_8] = #iter_9_9

					break
				end
			end
		end
	elseif arg_9_1 == var_0_1.BRITHDAY_STORY then
		for iter_9_12, iter_9_13 in ipairs(CollectStoryCfg.get_id_list_by_type[arg_9_1]) do
			local var_9_9 = CollectStoryCfg[iter_9_13].order

			table.insert(arg_9_0.itemList_, {
				chapterID = var_9_9,
				storyList = {
					iter_9_13
				}
			})

			var_9_0[var_9_9] = 1
		end
	end

	for iter_9_14, iter_9_15 in ipairs(arg_9_0.itemList_) do
		iter_9_15.all = var_9_0[iter_9_15.chapterID]
	end

	table.sort(arg_9_0.itemList_, function(arg_10_0, arg_10_1)
		local var_10_0 = table.indexof(ChapterCfg.all, arg_10_0.chapterID)
		local var_10_1 = table.indexof(ChapterCfg.all, arg_10_1.chapterID)

		if var_10_0 and var_10_1 then
			return var_10_0 < var_10_1
		else
			return arg_10_0.chapterID < arg_10_1.chapterID
		end
	end)
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(arg_11_0.itemList_[arg_11_1], arg_11_0.selType_)
end

function var_0_0.IsShowToggleByType(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(CollectStoryCfg.get_id_list_by_type[arg_12_1] or {}) do
		if IllustratedData:GetPlotInfo()[iter_12_1] then
			return true
		end
	end

	return false
end

function var_0_0.RefreshUI(arg_13_0, arg_13_1)
	SetActive(arg_13_0.btn2trs_, arg_13_0:IsShowToggleByType(var_0_1.ACTIVITY_STORY))
	SetActive(arg_13_0.btn3trs_, arg_13_0:IsShowToggleByType(var_0_1.BRITHDAY_STORY))
	arg_13_0:UpdateDate(arg_13_1)
	arg_13_0.scroll_:StartScroll(#arg_13_0.itemList_)
	arg_13_0.btn1Controller:SetSelectedIndex(arg_13_1 == 1 and 0 or 1)
	arg_13_0.btn2Controller:SetSelectedIndex(arg_13_1 == 2 and 0 or 1)
	arg_13_0.btn3Controller:SetSelectedIndex(arg_13_1 == 3 and 0 or 1)
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.selType_ = arg_15_0.params_.index or 1

	arg_15_0:RefreshUI(arg_15_0.selType_)
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.scroll_:Dispose()

	arg_17_0.scroll_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.OnAssetPendDownloadEnd(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.itemList_ then
		local var_18_0 = arg_18_0.scroll_:GetScrolledPosition()

		arg_18_0.scroll_:StartScroll(#arg_18_0.itemList_)
		arg_18_0.scroll_:SetScrolledPosition(var_18_0)
	end
end

return var_0_0
