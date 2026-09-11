local EquipBreakThroughMaterialStageInfoView = class("EquipBreakThroughMaterialStageInfoView", (import("game.views.sectionInfo.SectionInfoBaseView")))

function EquipBreakThroughMaterialStageInfoView:Init()
	EquipBreakThroughMaterialStageInfoView.super.Init(self)
	self.controller_:SetSelectedState("equipBTMaterial")

	if self.readyTxt_ then
		self.readyTxt_.text = GetTips("BATTLE_READY_2")
	end

	self.infoController_ = ControllerUtil.GetController(self.equipBTPanel_.transform, "name")

	SetActive(self.resourcePanel_, false)
end

function EquipBreakThroughMaterialStageInfoView:OnClickBtn()
	local var_2_0 = EquipBreakThroughMaterialData:GetChooseMapStageID()

	if EquipBreakThroughMaterialMapCfg[var_2_0].stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL then
		EquipBreakThroughMaterialAction.ChooseHeal(var_2_0, function(arg_3_0)
			if isSuccess(arg_3_0.result) then
				JumpTools.Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
				ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_TEAM_HEAL"), GameSetting.equip_crossroads_healing.value[1]))
			end
		end)
	elseif EquipBreakThroughMaterialMapCfg[var_2_0].stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF then
		JumpTools.Back()
		JumpTools.OpenPageByJump("equipBreakThroughMaterialBuffStage", {
			mapStageID = var_2_0
		})
	else
		self:Go("/sectionSelectHeroEquipBreakThrough", {
			section = self.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
		})
	end
end

function EquipBreakThroughMaterialStageInfoView:RefreshStageInfo()
	if self.oldCfgID_ ~= BattleEquipBreakThroughMaterialStageCfg[self.stageID_].id then
		local var_4_0, var_4_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL, self.stageID_)

		self.sectionText_.text = string.format("%s-%s", GetI18NText(var_4_0), GetI18NText(var_4_1))
		self.sectionName_.text = GetI18NText(BattleEquipBreakThroughMaterialStageCfg[self.stageID_].name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleEquipBreakThroughMaterialStageCfg[self.stageID_].background_1))
		self.tipsText_.text = GetI18NText(BattleEquipBreakThroughMaterialStageCfg[self.stageID_].tips)
		self.oldCfgID_ = BattleEquipBreakThroughMaterialStageCfg[self.stageID_].id
	end

	local var_4_2 = EquipBreakThroughMaterialMapCfg[EquipBreakThroughMaterialData:GetChooseMapStageID()]

	if var_4_2.stage_type ~= EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF and var_4_2.stage_type ~= EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL then
		self.pointText_.text = EquipBreakThroughMaterialPointCfg[var_4_2.stage_type].stage_point[var_4_2.col]

		self.infoController_:SetSelectedState("true")
	else
		self.infoController_:SetSelectedState("false")
	end
end

function EquipBreakThroughMaterialStageInfoView:RefreshRewardPanel(arg_5_1)
	return
end

return EquipBreakThroughMaterialStageInfoView
