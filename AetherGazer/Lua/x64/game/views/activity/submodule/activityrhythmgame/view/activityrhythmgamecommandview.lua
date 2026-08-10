local var_0_0 = class("ActivityRhythmGameCommandView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MuiscUI/SummerUI_3_4_InstructionsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitOwnData()
	arg_3_0:BindCfgUI()

	arg_3_0.imageController_ = arg_3_0.controllerEx_:GetController("stageState")
	arg_3_0.commandItemList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, ActivityRhythmGameCommandItem)
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.commandItemList_ then
		arg_4_0.commandItemList_:Dispose()
	end

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitOwnData(arg_5_0)
	arg_5_0.chapterID_ = -1
	arg_5_0.activityID_ = -1
	arg_5_0.commandIDList_ = {}
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.chapterID_ = arg_8_0.params_.chapterID
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:RefreshUI()
	var_0_0.super.OnEnter(arg_8_0)
end

function var_0_0.OnExit(arg_9_0)
	var_0_0.super.OnExit(arg_9_0)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.commandItemList_) do
		if iter_9_1 and iter_9_1.OnExit then
			iter_9_1:OnExit()
		end
	end
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshCommandList()
	arg_10_0:RefreshImage()
end

function var_0_0.RefreshCommandList(arg_11_0)
	arg_11_0.commandIDList_ = ActivityRhythmGameData:GetCommandListByChapterIDForUI(arg_11_0.chapterID_)

	arg_11_0.commandItemList_:StartScroll(#arg_11_0.commandIDList_)
end

function var_0_0.RefreshImage(arg_12_0)
	arg_12_0.imageController_:SetSelectedIndex(arg_12_0.chapterID_ == ActivityRhythmGameConst.Chapter_ID.ONE and 0 or 1)
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, arg_13_0.commandIDList_[arg_13_1], arg_13_0.activityID_)
end

return var_0_0
