local var_0_0 = class("WarChessStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Stage/WarChessStageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.chapterList_ = {}
	arg_3_0.itemList_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	arg_4_0.chapterClientID_ = arg_4_0.params_.chapterClientID

	local var_4_0 = ChapterClientCfg[arg_4_0.chapterClientID_]
	local var_4_1 = ChapterClientCfg[var_4_0.chapter_list[1]].toggle

	arg_4_0.chapterList = ChapterClientCfg.get_id_list_by_toggle[var_4_1]

	local var_4_2 = ChapterClientCfg[arg_4_0.chapterList[1]].chapter_list[1]

	BattleFieldData:SetCacheChapterClient(getChapterToggle(arg_4_0.chapterClientID_), arg_4_0.chapterClientID_)
	WarChessData:SetChapterClientID(arg_4_0.chapterClientID_)
	arg_4_0:RefreshItems()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.itemList_) do
		iter_4_1:OnEnter()
	end

	if arg_4_0.params_.firstChapter then
		arg_4_0.scrollView_.horizontalNormalizedPosition = 0.95
	else
		local var_4_3 = WarChessData:GetCurrentChapter(0)
		local var_4_4 = table.indexof(arg_4_0.chapterList_, var_4_3)

		if var_4_4 then
			local var_4_5 = (var_4_4 - 1) / #arg_4_0.chapterList_

			arg_4_0.scrollView_.horizontalNormalizedPosition = var_4_5
		else
			arg_4_0.scrollView_.horizontalNormalizedPosition = WarChessData:GetViewPos()
		end
	end

	WarChessAction.CancelWarChessRedPoint()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in pairs(arg_5_0.itemList_) do
		iter_5_1:OnExit()
	end

	WarChessData:CacheViewPos(arg_5_0.scrollView_.horizontalNormalizedPosition)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:RemoveListeners()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.itemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.itemList_ = nil

	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.scrollView_ = nil
	arg_6_0.item_ = nil
	arg_6_0.itemParent_ = nil
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_8_0)
	return
end

function var_0_0.RemoveListeners(arg_9_0)
	return
end

function var_0_0.RefreshItems(arg_10_0)
	arg_10_0:UpdateChapterList()

	for iter_10_0, iter_10_1 in pairs(arg_10_0.itemList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.itemList_ = {}

	for iter_10_2 = #arg_10_0.itemList_ + 1, #arg_10_0.chapterList_ do
		local var_10_0 = arg_10_0.chapterList_[iter_10_2]
		local var_10_1 = arg_10_0:CreateItem(var_10_0)

		var_10_1:Show(true)
		table.insert(arg_10_0.itemList_, var_10_1)
	end
end

function var_0_0.CreateItem(arg_11_0, arg_11_1)
	return (WarChessStageItemView.New(arg_11_0.item_, arg_11_0.itemParent_, arg_11_1))
end

function var_0_0.UpdateChapterList(arg_12_0)
	arg_12_0.chapterList_ = ChapterClientCfg[arg_12_0.chapterClientID_].chapter_list
end

function var_0_0.OnSystemSwitchUpdate(arg_13_0)
	arg_13_0:RefreshItems()
end

return var_0_0
