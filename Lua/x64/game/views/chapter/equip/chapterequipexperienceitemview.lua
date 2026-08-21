ChapterChallengeItemView = import("game.views.chapter.challenge.ChapterChallengeItemView")

local var_0_0 = class("ChapterEquipExperienceItemView", ChapterChallengeItemView)

function var_0_0.ClickItem(arg_1_0, arg_1_1)
	if arg_1_0:CheckLock() then
		return
	end

	local var_1_0 = ChapterClientCfg[arg_1_1].chapter_list[1]

	JumpTools.OpenPageByJump("/daily", {
		chapterID = var_1_0
	})
end

function var_0_0.AddRedPoint(arg_2_0)
	arg_2_0.multiTag_ = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(nil, arg_2_0.chapterClientID_, true)

	if arg_2_0.multiTag_ <= 0 and RegressionDataNew:IsRegressionOpen() then
		local var_2_0, var_2_1, var_2_2 = RegressionDataNew:GetMultipleValue()

		if var_2_0 and var_2_0 > 0 and var_2_2 then
			arg_2_0.multiTag_ = var_2_2
		end
	end

	if arg_2_0.multiTag_ <= 0 then
		SetActive(arg_2_0.multiGo_, false)
		manager.redPoint:bindUIandKey(arg_2_0.panelTf_, ChapterTools.GetRedPoint(arg_2_0.chapterClientID_))
	else
		arg_2_0.multiRatioText_.text = arg_2_0.multiTag_ / 100

		SetActive(arg_2_0.multiGo_, true)

		local var_2_3 = arg_2_0.panelTf_:Find("notice_img")

		if var_2_3 then
			SetActive(var_2_3.gameObject, false)
		end
	end
end

function var_0_0.RemoveRedPoint(arg_3_0)
	if not arg_3_0.multiTag_ or arg_3_0.multiTag_ <= 0 then
		manager.redPoint:unbindUIandKey(arg_3_0.panelTf_, ChapterTools.GetRedPoint(arg_3_0.chapterClientID_))
	end
end

return var_0_0
