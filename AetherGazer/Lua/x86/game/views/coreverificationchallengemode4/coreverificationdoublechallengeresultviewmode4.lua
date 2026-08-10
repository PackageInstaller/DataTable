local var_0_0 = class("CoreVerificationDoubleChallengeResultViewMode4", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode4/Core_verification_ResultUI04"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.hasSnapshot_ = GetBattleResultSnapShot()

	arg_2_0:InitUI()
	arg_2_0:AddListener()

	arg_2_0.lockController = arg_2_0.iconController_:GetController("lock")
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.bgBtn_, nil, function()
		arg_3_0:CloseFunc()
	end)
	arg_3_0:AddBtnListener(arg_3_0.statisticsBtn_, nil, function()
		arg_3_0:GoToBattleStatistics()
	end)
end

function var_0_0.RenderScore(arg_6_0)
	arg_6_0.curScoreText_.text = CoreVerificationChallengeMode4Data:GetLastBattleScore()
	arg_6_0.scoreText_.text = CoreVerificationChallengeMode4Data:GetCurPoint()
end

function var_0_0.RenderTitleView(arg_7_0)
	arg_7_0.stageNameText_.text = GetI18NText(BattleStageTools.GetStageName(arg_7_0.stageType, arg_7_0.stageId)) or ""
	arg_7_0.playerNameText_.text = PlayerData:GetPlayerInfo().nick

	arg_7_0:RenderScore()

	local var_7_0 = CoreVerificationChallengeTools.GetIllustrated()

	if var_7_0 and #var_7_0 > 0 then
		local var_7_1 = CoreVerificationChallengeTools.GetMaxIllustrated()

		if var_7_1 == 0 then
			arg_7_0.lockController:SetSelectedIndex(1)
		else
			arg_7_0.lockController:SetSelectedIndex(0)

			arg_7_0.affixIcon_.spriteAsync = string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_7_1)
		end
	else
		arg_7_0.lockController:SetSelectedIndex(1)
	end
end

function var_0_0.onRenderMissionContent(arg_8_0)
	return
end

function var_0_0.RenderMaskBg(arg_9_0)
	return
end

function var_0_0.RefreshBottomBtn(arg_10_0)
	return
end

function var_0_0.CloseFunc(arg_11_0)
	OperationRecorder.Record(arg_11_0.class.__cname, "closeCombat")
	arg_11_0:ShowVitalityBox(function()
		arg_11_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_11_0.params_.stageData, false)
		end)
	end)
end

return var_0_0
