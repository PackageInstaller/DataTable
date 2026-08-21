local var_0_0 = class("IlluPlotDetail", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluPlotDetailUI"
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

	arg_4_0.bgImg_.immediate = true
	arg_4_0.scroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, IlluPlotDetailItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.illuStrationBtn_, nil, function()
		local var_6_0 = 1
		local var_6_1 = arg_5_0.chapterID_

		if arg_5_0.selType_ == 2 then
			var_6_0 = 3
			var_6_1 = arg_5_0.activtyChapterID_
		elseif arg_5_0.selType_ == 3 then
			var_6_0 = 4
		end

		arg_5_0:Go("/illuIllustration", {
			selectSubMenuChapterID = var_6_1,
			index = var_6_0
		})
	end)
end

function var_0_0.UpdateDate(arg_7_0)
	arg_7_0.itemList_ = arg_7_0.list_

	table.sort(arg_7_0.itemList_, function(arg_8_0, arg_8_1)
		local var_8_0 = CollectStoryCfg[arg_8_0]
		local var_8_1 = CollectStoryCfg[arg_8_1]

		if var_8_0.order ~= var_8_1.order then
			return var_8_0.order < var_8_1.order
		end

		return arg_8_0 < arg_8_1
	end)
end

function var_0_0.indexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(arg_9_0.itemList_[arg_9_1], arg_9_0.selType_)
end

function var_0_0.RefreshUI(arg_10_0, arg_10_1)
	if arg_10_1 == 1 then
		local var_10_0 = SpritePathCfg.CollectPlotBig.path .. ChapterClientCfg[arg_10_0.chapterID_].chapter_paint

		arg_10_0.bgImg_.spriteSync = var_10_0
	elseif arg_10_1 == 2 then
		local var_10_1 = CollectStoryCfg.get_id_list_by_activity[arg_10_0.chapterID_]
		local var_10_2 = CollectStoryCfg.get_id_list_by_activity[arg_10_0.chapterID_][1]
		local var_10_3 = CollectStoryCfg[var_10_2].picture
		local var_10_4 = SpritePathCfg.CollectPlotBig.path .. var_10_3

		arg_10_0.activtyChapterID_ = CollectStoryCfg[var_10_2].chapter_client_id
		arg_10_0.bgImg_.spriteSync = var_10_4
	elseif arg_10_1 == 3 then
		local var_10_5 = CollectStoryCfg[arg_10_0.list_[1]].picture
		local var_10_6 = SpritePathCfg.CollectPlotBig.path .. var_10_5

		arg_10_0.bgImg_.spriteSync = var_10_6
	end

	arg_10_0:UpdateDate()
	arg_10_0.scroll_:StartScroll(#arg_10_0.itemList_)
end

function var_0_0.OnEnter(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if not arg_11_0:CheckIsRefresh() then
		return
	end

	arg_11_0.list_ = arg_11_0.params_.storyList
	arg_11_0.chapterID_ = arg_11_0.params_.chapterID
	arg_11_0.chapterClientID_ = arg_11_0.params_.chapterClientID
	arg_11_0.selType_ = arg_11_0.params_.selType

	arg_11_0:RefreshUI(arg_11_0.selType_)
end

function var_0_0.CheckIsRefresh(arg_12_0)
	if not arg_12_0.list_ then
		return true
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.params_.storyList) do
		if arg_12_0.list_[iter_12_0] ~= iter_12_1 then
			return true
		end
	end

	if arg_12_0.chapterID_ ~= arg_12_0.params_.chapterID or arg_12_0.selType_ ~= arg_12_0.params_.selType then
		return true
	end

	return false
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.scroll_:Dispose()

	arg_14_0.scroll_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
