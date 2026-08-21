ChapterChallengeItemWithCD = import("game.views.chapter.challenge.ChapterChallengeItemWithCD")

local var_0_0 = class("ChapterEquipItemView", ChapterChallengeItemWithCD)

function var_0_0.GetLostTime(arg_1_0)
	local var_1_0 = BattleEquipData:GetBattleEquipData().next_refresh_time

	if var_1_0 < manager.time:GetServerTime() then
		BattleEquipAction.RequestBattleEquipInfo()

		return var_1_0 + 86400
	end

	return var_1_0
end

function var_0_0.ClickItem(arg_2_0, arg_2_1)
	if arg_2_0:CheckLock() then
		return
	end

	local var_2_0 = ChapterClientCfg[arg_2_1].chapter_list[1]

	JumpTools.OpenPageByJump("/equipSection", {
		chapterID = var_2_0
	}, ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION)
end

function var_0_0.AddRedPoint(arg_3_0)
	arg_3_0.multiTag_ = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(nil, arg_3_0.chapterClientID_, true)

	if arg_3_0.multiTag_ <= 0 and RegressionDataNew:IsRegressionOpen() then
		local var_3_0, var_3_1, var_3_2 = RegressionDataNew:GetMultipleValue()

		if var_3_0 and var_3_0 > 0 and var_3_2 then
			arg_3_0.multiTag_ = var_3_2
		end
	end

	if arg_3_0.multiTag_ <= 0 then
		SetActive(arg_3_0.multiGo_, false)
		manager.redPoint:bindUIandKey(arg_3_0.panelTf_, ChapterTools.GetRedPoint(arg_3_0.chapterClientID_))
	else
		arg_3_0.multiRatioText_.text = arg_3_0.multiTag_ / 100

		SetActive(arg_3_0.multiGo_, true)

		local var_3_3 = arg_3_0.panelTf_:Find("notice_img")

		if var_3_3 then
			SetActive(var_3_3.gameObject, false)
		end
	end
end

function var_0_0.RemoveRedPoint(arg_4_0)
	if not arg_4_0.multiTag_ or arg_4_0.multiTag_ <= 0 then
		manager.redPoint:unbindUIandKey(arg_4_0.panelTf_, ChapterTools.GetRedPoint(arg_4_0.chapterClientID_))
	end
end

return var_0_0
