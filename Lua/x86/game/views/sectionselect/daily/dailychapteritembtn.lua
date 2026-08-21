local var_0_0 = class("DailyChapterItemBtn", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.parentView_ = arg_1_1
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_2, arg_1_3.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.chapterID_ = arg_1_4

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()
	arg_2_0:IsLock()
	arg_2_0:RefreshItem()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.parentView_ = nil

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.btn_ = nil
	arg_3_0.gameObject_ = nil
	arg_3_0.text_ = nil
	arg_3_0.canvasGroup_ = nil
	arg_3_0.unsubscribeFun = nil
	arg_3_0.selector_ = nil
	arg_3_0.lockGo_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.chapterID_ = arg_4_1

	arg_4_0:IsLock()
	arg_4_0:RefreshItem()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if arg_5_0.isLock_ then
			return
		end

		arg_5_0.parentView_:SwitchDailyChapter(arg_5_0.chapterID_)
	end)
end

function var_0_0.RefreshItem(arg_7_0)
	if arg_7_0.isLock_ then
		SetActive(arg_7_0.lockGo_, true)

		arg_7_0.canvasGroup_.alpha = 0.5
	else
		SetActive(arg_7_0.lockGo_, false)

		arg_7_0.canvasGroup_.alpha = 1
	end

	arg_7_0.text_.text = GetI18NText(ChapterCfg[arg_7_0.chapterID_].subhead)
end

function var_0_0.SetSiblingIndex(arg_8_0, arg_8_1)
	arg_8_0.transform_:SetSiblingIndex(arg_8_1)
end

function var_0_0.IsLock(arg_9_0)
	local var_9_0 = ChapterCfg[arg_9_0.chapterID_].section_id_list[1]

	arg_9_0.isLock_ = BattleStageData:GetStageData()[var_9_0] == nil
end

return var_0_0
