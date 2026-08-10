local var_0_0 = class("HellaPinballChapterSelectPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_ChapterPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.chapterUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.OnCreateChapterItem), arg_4_0.uiList_, HellaPinballChapterItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:UpdateData()
	arg_7_0:RefreshUI()
end

function var_0_0.UpdateData(arg_8_0)
	arg_8_0.selectChapter_ = PinballData:GetLastEnterStageCategory()
	arg_8_0.chapterList_ = PinballData:GetDisplayStageList()
end

function var_0_0.OnCreateChapterItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_1, arg_9_0.chapterList_[arg_9_1])
	arg_9_2:SetSelect(arg_9_0.chapterList_[arg_9_1] == arg_9_0.selectChapter_)
	arg_9_2:SetClickCallBack(function(arg_10_0)
		for iter_10_0, iter_10_1 in pairs(arg_9_0.chapterUIList_:GetItemList()) do
			if iter_10_1.index_ == arg_10_0 then
				iter_10_1:SetSelect(true)
			else
				iter_10_1:SetSelect(false)
			end
		end

		arg_9_0.selectChapter_ = arg_9_0.chapterList_[arg_10_0]

		PinballData:SetLastEnterStageCategory(arg_9_0.chapterList_[arg_10_0])
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.chapterUIList_:StartScroll(#arg_11_0.chapterList_, table.indexof(arg_11_0.chapterList_, arg_11_0.selectChapter_), true)
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.chapterUIList_ then
		arg_13_0.chapterUIList_:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
