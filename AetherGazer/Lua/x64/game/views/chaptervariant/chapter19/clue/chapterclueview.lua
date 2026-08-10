local var_0_0 = class("ChapterClueView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationVerClueUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, ChapterClueItem)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.chapterID_ = arg_4_0.params_.chapterID

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0, var_8_1 = ChapterTools.GetChapterClueCnt(arg_8_0.chapterID_)

	arg_8_0.collectClueIDList_ = ChapterTools.GetChapterCollectClueList(arg_8_0.chapterID_)

	arg_8_0.uiList_:StartScroll(var_8_1)

	local var_8_2, var_8_3 = ChapterTools.GetChapterClueCnt(arg_8_0.chapterID_)

	arg_8_0.cntText_.text = string.format("%s/%s", var_8_2, var_8_3)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 > #arg_9_0.collectClueIDList_ then
		arg_9_2:SetData(0, arg_9_1)
	else
		arg_9_2:SetData(arg_9_0.collectClueIDList_[arg_9_1], arg_9_1)
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.uiList_:Dispose()

	arg_10_0.uiList_ = nil

	var_0_0.super.Dispose(arg_10_0)

	arg_10_0.gameObject_ = nil
	arg_10_0.transform_ = nil
end

return var_0_0
