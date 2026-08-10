local var_0_0 = class("ChapterVariantBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/ChaptePlot/ChaptePlot12UI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.chapterItemList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.chapterClientID_ = arg_4_0.params_.chapterClientID

	for iter_4_0, iter_4_1 in ipairs(ChapterClientCfg[arg_4_0.chapterClientID_].chapter_list) do
		if arg_4_0.chapterItemList_[iter_4_0] == nil then
			arg_4_0.chapterItemList_[iter_4_0] = arg_4_0:GetItemClass().New(arg_4_0[string.format("chapterBtn%s_", iter_4_0)], iter_4_1)
		end

		arg_4_0.chapterItemList_[iter_4_0]:OnEnter(iter_4_1)
	end

	for iter_4_2 = #arg_4_0.chapterItemList_, #ChapterClientCfg[arg_4_0.chapterClientID_].chapter_list + 1, -1 do
		arg_4_0.chapterItemList_[iter_4_2]:Dispose()

		arg_4_0.chapterItemList_[iter_4_2] = nil
	end
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.chapterItemList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.chapterItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.chapterItemList_ = nil
end

function var_0_0.GetItemClass(arg_7_0)
	return ChapterVariantBaseItem
end

function var_0_0.AddListeners(arg_8_0)
	return
end

return var_0_0
