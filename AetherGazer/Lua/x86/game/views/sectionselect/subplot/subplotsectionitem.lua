local var_0_0 = import("game.views.sectionSelect.SectionBaseItem")
local var_0_1 = class("SubPlotSectionItem", var_0_0)

function var_0_1.InitCustom(arg_1_0)
	SetActive(arg_1_0.collectGo_, false)
	arg_1_0.showStarController_:SetSelectedState("false")
end

function var_0_1.GetTag(arg_2_0)
	local var_2_0 = BattleActivityStoryStageCfg[arg_2_0.stageID_]

	return var_2_0 and var_2_0.tag or 0
end

function var_0_1.GetPosition(arg_3_0)
	local var_3_0 = BattleActivityStoryStageCfg[arg_3_0.stageID_]

	return var_3_0 and var_3_0.position or {
		0,
		0
	}
end

function var_0_1.RefreshData(arg_4_0)
	local var_4_0 = BattleStageData:GetStageData()[arg_4_0.stageID_]
	local var_4_1 = ChapterCfg[arg_4_0.chapterID_]

	if var_4_0 then
		arg_4_0.isLock_ = false
		arg_4_0.clearTimes_ = var_4_0.clear_times
	elseif table.keyof(var_4_1.section_id_list, arg_4_0.stageID_) == 1 then
		arg_4_0.isLock_ = false
		arg_4_0.clearTimes_ = 0
	else
		arg_4_0.isLock_ = true
		arg_4_0.clearTimes_ = -1
	end

	local var_4_2 = PlayerData:GetPlayerInfo().userLevel
	local var_4_3 = BattleActivityStoryStageCfg[arg_4_0.stageID_].level

	if ActivityData:GetActivityIsOpen(var_4_1.activity_id) then
		arg_4_0.enoughLevel_ = true
	else
		arg_4_0.enoughLevel_ = var_4_3 <= var_4_2
	end
end

function var_0_1.OnClick(arg_5_0)
	if arg_5_0.isLock_ then
		-- block empty
	else
		arg_5_0:Go("subPlotSectionInfo", {
			section = arg_5_0.stageID_,
			chapterID = arg_5_0.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		})
	end
end

function var_0_1.RefreshText(arg_6_0)
	arg_6_0.text_.text = GetI18NText(BattleActivityStoryStageCfg[arg_6_0.stageID_].name)
end

function var_0_1.IsOpenSectionInfo(arg_7_0)
	return arg_7_0:IsOpenRoute("subPlotSectionInfo")
end

return var_0_1
