local EquipSectionInfoView = class("EquipSectionInfoView", import("..SectionInfoMultipleBaseView"))

function EquipSectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.stageID_,
		multiple = self.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP
	})
end

function EquipSectionInfoView:Init()
	EquipSectionInfoView.super.Init(self)
	self.hideStageDescController_:SetSelectedState("false")
	self.hideDropPanelController_:SetSelectedState("false")
end

function EquipSectionInfoView:RefreshData()
	local var_3_0 = BattleEquipStageCfg[self.stageID_]
	local var_3_1 = GameSetting.equip_stage_unlock.value
	local var_3_2 = BattleInstance.GetHardLevel(self.stageID_)

	self.lock_ = not not JumpTools.IsConditionLocked({
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		GameSetting.equip_stage_unlock.value[var_3_2]
	})
	self.lockTips_ = JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION, {
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		var_3_1[var_3_2]
	})
	self.cost_ = var_3_0.cost
	self.dropLibID_ = var_3_0.drop_lib_id
	self.isFirstClear_ = false

	EquipSectionInfoView.super.RefreshData(self)
end

function EquipSectionInfoView:RefreshStageInfo()
	local var_4_0 = BattleInstance.GetHardLevel(self.stageID_)

	if self.oldCfgID_ ~= BattleEquipStageCfg[self.stageID_].id then
		self.sectionName_.text = GetI18NText(BattleEquipStageCfg[self.stageID_].name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleEquipStageCfg[self.stageID_].background_1))
		self.oldCfgID_ = BattleEquipStageCfg[self.stageID_].id
	end

	self.storyText_.text = EquipStageInsureCfg[var_4_0].insure_times == 0 and GetI18NText(BattleEquipStageCfg[self.stageID_].tips) or GetI18NText(BattleEquipStageCfg[self.stageID_].tips) .. string.format(GetTips("EQUIP_STAGE_INSURE"), EquipStageInsureCfg[var_4_0].insure_times - (BattleEquipData:GetGuaranteeNum()[var_4_0] or 0))

	local var_4_3, var_4_4 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP, self.stageID_)

	self.sectionText_.text = string.format("%s%s", GetI18NText(var_4_3), GetI18NText(var_4_4))
end

return EquipSectionInfoView
