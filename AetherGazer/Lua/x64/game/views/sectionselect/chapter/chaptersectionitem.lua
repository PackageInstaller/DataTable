local var_0_0 = import("game.views.sectionSelect.SectionBaseItem")
local var_0_1 = class("ChapterSectionItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)

	arg_1_0.hasTipsController_ = arg_1_0.controllerEx_:GetController("hasTipsText")
end

function var_0_1.RefreshStar(arg_2_0)
	if #BattleChapterStageCfg[arg_2_0.stageID_].three_star_need == 1 then
		for iter_2_0 = 1, 3 do
			arg_2_0.threeStarBarList_[iter_2_0]:SetData(arg_2_0.starCnt_ >= 1)
		end
	else
		for iter_2_1 = 1, 3 do
			arg_2_0.threeStarBarList_[iter_2_1]:SetData(iter_2_1 <= arg_2_0.starCnt_)
		end
	end
end

function var_0_1.GetTag(arg_3_0)
	local var_3_0 = BattleChapterStageCfg[arg_3_0.stageID_]

	return var_3_0 and var_3_0.tag or 0
end

function var_0_1.GetPosition(arg_4_0)
	local var_4_0 = BattleChapterStageCfg[arg_4_0.stageID_]

	return var_4_0 and var_4_0.position ~= "" and var_4_0.position or {
		0,
		0
	}
end

function var_0_1.RefreshData(arg_5_0)
	local var_5_0 = BattleStageData:GetStageData()[arg_5_0.stageID_]
	local var_5_1 = ChapterCfg[arg_5_0.chapterID_]
	local var_5_2 = PlayerData:GetPlayerInfo().userLevel
	local var_5_3 = BattleChapterStageCfg[arg_5_0.stageID_].level

	if ActivityData:GetActivityIsOpen(var_5_1.activity_id) then
		arg_5_0.enoughLevel_ = true
	else
		arg_5_0.enoughLevel_ = var_5_3 <= var_5_2
	end

	if var_5_0 then
		arg_5_0.isLock_ = false
		arg_5_0.clearTimes_ = var_5_0.clear_times

		local var_5_4 = 0

		for iter_5_0, iter_5_1 in ipairs(var_5_0.stars) do
			if iter_5_1 > 0 then
				var_5_4 = var_5_4 + 1
			end
		end

		arg_5_0.starCnt_ = var_5_4
		arg_5_0.isFinishAllPre = true
	else
		if table.keyof(var_5_1.section_id_list, arg_5_0.stageID_) == 1 then
			arg_5_0.isLock_ = false
			arg_5_0.clearTimes_ = 0
			arg_5_0.starCnt_ = 0
		elseif arg_5_0:IsUnlockPreStage() then
			arg_5_0.isLock_ = false
			arg_5_0.enoughLevel_ = false
			arg_5_0.clearTimes_ = 0
			arg_5_0.starCnt_ = 0
		else
			arg_5_0.isLock_ = true
			arg_5_0.clearTimes_ = -1
			arg_5_0.starCnt_ = 0
		end

		arg_5_0.isFinishAllPre = arg_5_0:IsFinishAllPreUnlockStage()
	end

	if arg_5_0.stageID_ == GameSetting.travel_skuld_new_ending_stage_id.value[1] and arg_5_0.clearTimes_ < 1 then
		arg_5_0.isLock_ = true
	end
end

function var_0_1.IsUnlockPreStage(arg_6_0)
	local var_6_0 = BattleStageData:GetStageData()
	local var_6_1 = BattleChapterStageCfg[arg_6_0.stageID_]

	if var_6_1.pre_show_id_list == nil then
		print(string.format("关卡 %s 未配置前置关卡", arg_6_0.stageID_))

		return true
	end

	for iter_6_0, iter_6_1 in pairs(var_6_1.pre_show_id_list) do
		if var_6_0[iter_6_1] and var_6_0[iter_6_1].clear_times > 0 then
			return true
		end
	end

	return false
end

function var_0_1.IsFinishAllPreUnlockStage(arg_7_0)
	if not BattleStageData:IsFinishAllPreUnlockStage(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, arg_7_0.stageID_, true) then
		return false
	end

	return true
end

function var_0_1.OnClick(arg_8_0)
	if arg_8_0.isLock_ then
		-- block empty
	elseif arg_8_0.isFinishAllPre then
		arg_8_0:Go("chapterSectionInfo", {
			section = arg_8_0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
		})
	else
		BattleStageData:IsFinishAllPreUnlockStage(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, arg_8_0.stageID_)
	end
end

function var_0_1.RefreshText(arg_9_0)
	local var_9_0, var_9_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, arg_9_0.stageID_)

	arg_9_0.text_.text = string.format("%s-%s", GetI18NText(var_9_0), GetI18NText(var_9_1))

	local var_9_2 = BattleChapterStageCfg[arg_9_0.stageID_]

	if var_9_2.line_text == "" then
		arg_9_0.hasTipsController_:SetSelectedState("false")
	else
		arg_9_0.lineText_.text = GetI18NText(var_9_2.line_text)

		arg_9_0.hasTipsController_:SetSelectedState("true")
	end
end

function var_0_1.IsOpenSectionInfo(arg_10_0)
	return arg_10_0:IsOpenRoute("chapterSectionInfo")
end

return var_0_1
