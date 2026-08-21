local var_0_0 = {
	PIECE = 2,
	BATTLE = 1
}

SectionInfoBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local var_0_1 = class("SkuldSystemStageSectionView", SectionInfoBaseView)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_StageBaseUI"
end

function var_0_1.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.battleBtn_, nil, function()
		SkuldSystemAction.OpenSkuldBattle(arg_2_0.levelID_, arg_2_0.stageType_)
	end)
end

function var_0_1.OnEnter(arg_4_0)
	arg_4_0.levelID_ = arg_4_0.params_.levelID
	arg_4_0.systemCfg_ = SkuldStageCfg[arg_4_0.levelID_]
	arg_4_0.stageID_ = arg_4_0.systemCfg_.type[2]
	arg_4_0.stageType_ = arg_4_0.params_.battleType

	manager.notify:RegistListener(CURRENCY_UPDATE, arg_4_0.currencyUpdateHandle_)
	arg_4_0.hideFatigueController_:SetSelectedState("close")
	arg_4_0.hideStageDescController_:SetSelectedState("false")
	arg_4_0:RefreshData()
	arg_4_0:RefreshUI()
	arg_4_0:RefreshTitleDesc()
end

function var_0_1.OnTop(arg_5_0)
	arg_5_0:UpdateBar()
end

function var_0_1.OnUpdate(arg_6_0)
	if arg_6_0.levelID_ == arg_6_0.params_.levelID then
		return
	end

	arg_6_0.levelID_ = arg_6_0.params_.levelID
	arg_6_0.systemCfg_ = SkuldStageCfg[arg_6_0.levelID_]
	arg_6_0.stageID_ = arg_6_0.systemCfg_.type[2]

	arg_6_0:RefreshData()
	arg_6_0:RefreshUI()
end

function var_0_1.UpdateBar(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_1.RefreshData(arg_8_0)
	if SkuldSystemData:GetLevelIDIsOpen(arg_8_0.levelID_) then
		arg_8_0.lock_ = false
	else
		arg_8_0.lock_ = true
		arg_8_0.lockTips_ = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end

	arg_8_0.cost_ = 0

	if SkuldSystemData:GetLevelIDIsClear(arg_8_0.levelID_) then
		arg_8_0.isFirstClear_ = false
	else
		arg_8_0.isFirstClear_ = true
	end

	arg_8_0.dropLibID_ = arg_8_0.systemCfg_.reward
end

function var_0_1.HaveCostCntFlag(arg_9_0)
	return false
end

function var_0_1.RefreshStageInfo(arg_10_0)
	arg_10_0.skuldLevelNameText_.text = arg_10_0.systemCfg_.name
	arg_10_0.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, arg_10_0.systemCfg_.background_1)
end

function var_0_1.RefreshUI(arg_11_0)
	var_0_1.super.RefreshUI(arg_11_0)

	arg_11_0.storyText_.text = formatText(arg_11_0.systemCfg_.desc)
end

function var_0_1.Dispose(arg_12_0)
	var_0_1.super.Dispose(arg_12_0)
end

return var_0_1
