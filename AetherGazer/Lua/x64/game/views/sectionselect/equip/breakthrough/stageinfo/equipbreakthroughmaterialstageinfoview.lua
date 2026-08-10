local var_0_0 = import("game.views.sectionInfo.SectionInfoBaseView")
local var_0_1 = class("EquipBreakThroughMaterialStageInfoView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	arg_1_0.controller_:SetSelectedState("equipBTMaterial")

	if arg_1_0.readyTxt_ then
		arg_1_0.readyTxt_.text = GetTips("BATTLE_READY_2")
	end

	arg_1_0.infoController_ = ControllerUtil.GetController(arg_1_0.equipBTPanel_.transform, "name")

	SetActive(arg_1_0.resourcePanel_, false)
end

function var_0_1.OnClickBtn(arg_2_0)
	local var_2_0 = arg_2_0.stageID_
	local var_2_1 = EquipBreakThroughMaterialData:GetChooseMapStageID()
	local var_2_2 = EquipBreakThroughMaterialMapCfg[var_2_1]

	if var_2_2.stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL then
		EquipBreakThroughMaterialAction.ChooseHeal(var_2_1, function(arg_3_0)
			if isSuccess(arg_3_0.result) then
				JumpTools.Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
				ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_TEAM_HEAL"), GameSetting.equip_crossroads_healing.value[1]))
			end
		end)
	elseif var_2_2.stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF then
		JumpTools.Back()
		JumpTools.OpenPageByJump("equipBreakThroughMaterialBuffStage", {
			mapStageID = var_2_1
		})
	else
		arg_2_0:Go("/sectionSelectHeroEquipBreakThrough", {
			section = var_2_0,
			sectionType = BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
		})
	end
end

function var_0_1.RefreshStageInfo(arg_4_0)
	local var_4_0 = BattleEquipBreakThroughMaterialStageCfg[arg_4_0.stageID_]

	if arg_4_0.oldCfgID_ ~= var_4_0.id then
		local var_4_1, var_4_2 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL, arg_4_0.stageID_)

		arg_4_0.sectionText_.text = string.format("%s-%s", GetI18NText(var_4_1), GetI18NText(var_4_2))
		arg_4_0.sectionName_.text = GetI18NText(var_4_0.name)
		arg_4_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_4_0.background_1))
		arg_4_0.tipsText_.text = GetI18NText(var_4_0.tips)
		arg_4_0.oldCfgID_ = var_4_0.id
	end

	local var_4_3 = EquipBreakThroughMaterialData:GetChooseMapStageID()
	local var_4_4 = EquipBreakThroughMaterialMapCfg[var_4_3]

	if var_4_4.stage_type ~= EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF and var_4_4.stage_type ~= EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL then
		arg_4_0.pointText_.text = EquipBreakThroughMaterialPointCfg[var_4_4.stage_type].stage_point[var_4_4.col]

		arg_4_0.infoController_:SetSelectedState("true")
	else
		arg_4_0.infoController_:SetSelectedState("false")
	end
end

function var_0_1.RefreshRewardPanel(arg_5_0, arg_5_1)
	return
end

return var_0_1
