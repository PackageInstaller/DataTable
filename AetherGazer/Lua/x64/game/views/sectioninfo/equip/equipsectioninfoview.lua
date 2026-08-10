local var_0_0 = class("EquipSectionInfoView", import("..SectionInfoMultipleBaseView"))

function var_0_0.OnClickBtn(arg_1_0)
	local var_1_0 = arg_1_0.stageID_

	arg_1_0:Go("/sectionSelectHero", {
		section = var_1_0,
		multiple = arg_1_0.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP
	})
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)
	arg_2_0.hideStageDescController_:SetSelectedState("false")
	arg_2_0.hideDropPanelController_:SetSelectedState("false")
end

function var_0_0.RefreshData(arg_3_0)
	local var_3_0 = BattleEquipStageCfg[arg_3_0.stageID_]
	local var_3_1 = GameSetting.equip_stage_unlock.value
	local var_3_2 = BattleInstance.GetHardLevel(arg_3_0.stageID_)

	arg_3_0.lock_ = JumpTools.IsConditionLocked({
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		var_3_1[var_3_2]
	}) and true or false
	arg_3_0.lockTips_ = JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION, {
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		var_3_1[var_3_2]
	})
	arg_3_0.cost_ = var_3_0.cost
	arg_3_0.dropLibID_ = var_3_0.drop_lib_id
	arg_3_0.isFirstClear_ = false

	var_0_0.super.RefreshData(arg_3_0)
end

function var_0_0.RefreshStageInfo(arg_4_0)
	local var_4_0 = BattleEquipStageCfg[arg_4_0.stageID_]
	local var_4_1 = BattleInstance.GetHardLevel(arg_4_0.stageID_)

	if arg_4_0.oldCfgID_ ~= var_4_0.id then
		arg_4_0.sectionName_.text = GetI18NText(var_4_0.name)
		arg_4_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_4_0.background_1))
		arg_4_0.oldCfgID_ = var_4_0.id
	end

	local var_4_2 = BattleEquipData:GetGuaranteeNum()[var_4_1] or 0
	local var_4_3 = EquipStageInsureCfg[var_4_1].insure_times

	if var_4_3 == 0 then
		arg_4_0.storyText_.text = GetI18NText(var_4_0.tips)
	else
		arg_4_0.storyText_.text = GetI18NText(var_4_0.tips) .. string.format(GetTips("EQUIP_STAGE_INSURE"), var_4_3 - var_4_2)
	end

	local var_4_4, var_4_5 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP, arg_4_0.stageID_)

	arg_4_0.sectionText_.text = string.format("%s%s", GetI18NText(var_4_4), GetI18NText(var_4_5))
end

return var_0_0
