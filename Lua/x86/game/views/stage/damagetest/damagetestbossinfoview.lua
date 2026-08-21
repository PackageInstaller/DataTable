local var_0_0 = import("game.views.stage.bossChallenge.BattleBossInfoBaseView")
local var_0_1 = class("DamageTestBossInfoView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/DamageTest/DamageTestBossInformationUI"
end

function var_0_1.OnEnterExtend(arg_2_0)
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")
end

function var_0_1.OnEnter(arg_3_0)
	manager.ui:SetMainCamera("bossChallenge")
	arg_3_0:InitBackScene()

	arg_3_0.exitView_ = false
	arg_3_0.currentBossTemplateID_ = nil

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	arg_3_0:OnEnterExtend()
	arg_3_0:RefreshData()
	arg_3_0:RefreshUI()
end

function var_0_1.OnExit(arg_4_0)
	var_0_1.super.OnExit(arg_4_0)
end

function var_0_1.OnUpdate(arg_5_0)
	var_0_1.super.OnUpdate(arg_5_0)
end

function var_0_1.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.startBattleBtn_, nil, function()
		arg_6_0:Go("/bossCombatSelect", {
			damageTestId = arg_6_0.damageTestId_
		})
	end)
end

function var_0_1.RefreshData(arg_8_0)
	arg_8_0.damageTestId_ = arg_8_0.params_.damageTestId
	arg_8_0.templateID_ = DamageTestCfg[arg_8_0.damageTestId_].boss_id
end

function var_0_1.RefreshLockHero(arg_9_0)
	return
end

function var_0_1.RefreshUI(arg_10_0)
	arg_10_0:RefreshText()
	arg_10_0:LoadModel()
	arg_10_0:RefreshSkill()
end

return var_0_1
