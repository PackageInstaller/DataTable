local var_0_0 = class("ChapterDailyItemView", import("..ChapterBaseItemView"))

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	arg_1_0:AddRedPoint()
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
	arg_2_0:RemoveRedPoint()
end

function var_0_0.RefreshCustomItem(arg_3_0, arg_3_1)
	if arg_3_0.oldCfgID_ ~= arg_3_1.id then
		arg_3_0.nameText_.text = GetI18NText(arg_3_1.name)

		SetSpriteWithoutAtlasAsync(arg_3_0.icon_, arg_3_1.drop_icon)

		arg_3_0.oldCfgID_ = arg_3_1.id
	end
end

function var_0_0.ClickItem(arg_4_0, arg_4_1)
	if arg_4_0:CheckLock() then
		return
	end

	local var_4_0 = ChapterClientCfg[arg_4_1].chapter_list[1]
	local var_4_1 = BattleFieldData:GetStageByClientID(arg_4_1)

	if var_4_1 then
		var_4_0 = getChapterIDByStageID(var_4_1)
	end

	JumpTools.OpenPageByJump("/daily", {
		chapterID = var_4_0
	})
end

function var_0_0.AddRedPoint(arg_5_0)
	arg_5_0.multiTag_ = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(nil, arg_5_0.chapterClientID_, true)

	if arg_5_0.multiTag_ <= 0 and RegressionDataNew:IsRegressionOpen() then
		local var_5_0, var_5_1, var_5_2 = RegressionDataNew:GetMultipleValue()

		if var_5_0 and var_5_0 > 0 and var_5_2 then
			arg_5_0.multiTag_ = var_5_2
		end
	end

	if arg_5_0.multiTag_ <= 0 then
		SetActive(arg_5_0.multiGo_, false)
		manager.redPoint:bindUIandKey(arg_5_0.panelTf_, ChapterTools.GetRedPoint(arg_5_0.chapterClientID_))
	else
		arg_5_0.multiRatioText_.text = arg_5_0.multiTag_ / 100

		SetActive(arg_5_0.multiGo_, true)

		local var_5_3 = arg_5_0.panelTf_:Find("notice_img")

		if var_5_3 then
			SetActive(var_5_3.gameObject, false)
		end
	end
end

function var_0_0.RemoveRedPoint(arg_6_0)
	if not arg_6_0.multiTag_ or arg_6_0.multiTag_ <= 0 then
		manager.redPoint:unbindUIandKey(arg_6_0.panelTf_, ChapterTools.GetRedPoint(arg_6_0.chapterClientID_))
	end
end

return var_0_0
