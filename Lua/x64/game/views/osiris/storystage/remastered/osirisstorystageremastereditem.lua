local var_0_0 = import("game.views.osiris.storyStage.section.OsirisStoryStageItem")
local var_0_1 = class("OsirisStoryStageRemasteredItem", var_0_0)

function var_0_1.SetData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.stageID_ = arg_1_1
	arg_1_0.chapterID_ = arg_1_2

	arg_1_0:RefreshData()
	arg_1_0:RefreshUI()
end

function var_0_1.IsOpenSectionInfo(arg_2_0)
	return arg_2_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_1.RefreshData(arg_3_0)
	local var_3_0 = BattleStageData:GetStageData()[arg_3_0.stageID_]

	if var_3_0 and var_3_0.clear_times > 0 then
		arg_3_0.isClear_ = true
	else
		arg_3_0.isClear_ = false
	end
end

function var_0_1.OnClick(arg_4_0)
	BattleFieldData:SetCacheStage(arg_4_0.chapterID_, arg_4_0.stageID_)
	arg_4_0:Go("subPlotSectionInfo", {
		section = arg_4_0.stageID_,
		chapterID = arg_4_0.chapterID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function var_0_1.RefreshUI(arg_5_0)
	local var_5_0 = arg_5_0:GetPosition()

	arg_5_0.transform_.localPosition = Vector3(var_5_0[1], var_5_0[2], 0)

	local var_5_1 = ChapterCfg[arg_5_0.chapterID_]
	local var_5_2 = table.keyof(var_5_1.section_id_list, arg_5_0.stageID_)

	arg_5_0.textIndex_.text = string.format("%02d", var_5_2)

	local var_5_3 = BattleActivityStoryStageCfg[arg_5_0.stageID_]

	arg_5_0.textName_.text = GetI18NText(var_5_3.name)
	arg_5_0.imageBg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_5_3.background_1))

	if var_5_2 == 1 or BattleStageData:GetStageData()[arg_5_0.stageID_] then
		arg_5_0:Show(true)
	else
		arg_5_0:Show(false)
	end

	arg_5_0:RefreshClear()
end

return var_0_1
