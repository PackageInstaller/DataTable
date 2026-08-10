local var_0_0 = class("ChapterV2MapEmptyTrackItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.hasNextChapterCon_ = arg_1_0.conEx_:GetController("hasNextChapter")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if not arg_2_0.hasNextChapter_ then
			return
		end

		ChapterV2MapTools.GoMap(arg_2_0.nextChapterMapID_)
	end)
end

function var_0_0.OnTop(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.mapId_ = arg_5_1
	arg_5_0.chapterClientId_ = ChapterV2MapTools.GetChapterClientIDByMap(arg_5_1)
	arg_5_0.hasNextChapter_, arg_5_0.nextChapterClientID_ = ChapterV2MapTools.HasNextChapterClient(arg_5_0.chapterClientId_)

	if arg_5_0.hasNextChapter_ and arg_5_0.nextChapterClientID_ then
		arg_5_0.nextChapterMapID_ = ChapterV2MapTools.GetChapterClientWorkingMap(arg_5_0.nextChapterClientID_)
	end

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.hasNextChapterCon_:SetSelectedState(tostring(arg_6_0.hasNextChapter_))
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
