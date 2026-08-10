ChapterChallengeItemView = import("game.views.chapter.challenge.ChapterChallengeItemView")

local var_0_0 = class("ChapterEquipEnchantmentItemView", ChapterChallengeItemView)

function var_0_0.AddRedPoint(arg_1_0)
	arg_1_0.multiTag_ = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(nil, arg_1_0.chapterClientID_, true)

	if arg_1_0.multiTag_ <= 0 and RegressionDataNew:IsRegressionOpen() then
		local var_1_0, var_1_1, var_1_2 = RegressionDataNew:GetMultipleValue()

		if var_1_0 and var_1_0 > 0 and var_1_2 then
			arg_1_0.multiTag_ = var_1_2
		end
	end

	if arg_1_0.multiTag_ <= 0 then
		SetActive(arg_1_0.multiGo_, false)
		manager.redPoint:bindUIandKey(arg_1_0.panelTf_, RedPointConst.DAILY_EQUIP_ENCHANT)
	else
		arg_1_0.multiRatioText_.text = arg_1_0.multiTag_ / 100

		SetActive(arg_1_0.multiGo_, true)

		local var_1_3 = arg_1_0.panelTf_:Find("notice_img")

		if var_1_3 then
			SetActive(var_1_3.gameObject, false)
		end
	end
end

function var_0_0.RemoveRedPoint(arg_2_0)
	if not arg_2_0.multiTag_ or arg_2_0.multiTag_ <= 0 then
		manager.redPoint:unbindUIandKey(arg_2_0.panelTf_, RedPointConst.DAILY_EQUIP_ENCHANT)
	end
end

function var_0_0.ClickItem(arg_3_0, arg_3_1)
	if arg_3_0:CheckLock() then
		return
	end

	local var_3_0 = ChapterClientCfg[arg_3_1].chapter_list[1]

	JumpTools.OpenPageByJump("/enchantment")
end

return var_0_0
