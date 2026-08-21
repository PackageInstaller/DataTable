local var_0_0 = class("BattlePushSnowBallSingleResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballResultSingleModeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:CloseFunc()
	end)
	arg_5_0:AddBtnListener(arg_5_0.restartBtn_, nil, function()
		arg_5_0:OnClickRestart()
	end)
	arg_5_0:AddBtnListener(arg_5_0.shareBtn_, nil, function()
		manager.share:Share(function()
			arg_5_0:HideAllUI()
		end, function()
			arg_5_0:RecoverAllUI()
		end, function()
			return
		end)
	end)
end

function var_0_0.HideAllUI(arg_12_0)
	SetActive(arg_12_0.backBtn_.gameObject, false)
	SetActive(arg_12_0.shareBtn_.gameObject, false)
	SetActive(arg_12_0.restartBtn_.gameObject, false)
end

function var_0_0.RecoverAllUI(arg_13_0)
	SetActive(arg_13_0.backBtn_.gameObject, true)
	SetActive(arg_13_0.shareBtn_.gameObject, true)
	SetActive(arg_13_0.restartBtn_.gameObject, true)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.stageData = arg_14_0.params_.stageData
	arg_14_0.score = arg_14_0.params_.score
	arg_14_0.useSecond = arg_14_0.params_.useSecond
	arg_14_0.stageId = arg_14_0.stageData:GetStageId()
	arg_14_0.stageType = arg_14_0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	arg_14_0:RefreshUI()

	if arg_14_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_14_0:CloseFunc()
			end
		})
	end
end

function var_0_0.CloseFunc(arg_16_0)
	OperationRecorder.Record(arg_16_0.class.__cname, "closeCombat")
	BattleInstance.QuitBattle(arg_16_0.stageData)
end

function var_0_0.OnClickRestart(arg_17_0)
	if arg_17_0.params_.condition then
		local var_17_0, var_17_1 = arg_17_0.params_.condition()

		if var_17_0 then
			BattleController.GetInstance():LaunchBattle(arg_17_0.params_.stageData)
		else
			ShowTips(var_17_1)
		end
	else
		BattleController.GetInstance():LaunchBattle(arg_17_0.params_.stageData)
	end
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0.scoreText_.text = arg_18_0.score
	arg_18_0.useSecondText_.text = arg_18_0.useSecond
	arg_18_0.nameText_.text = arg_18_0.stageData:GetName()
	arg_18_0.playerNameText_.text = PlayerData:GetPlayerInfo().nick
	arg_18_0.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait2/" .. PushSnowBallData:GetSelectedHeroID())
end

function var_0_0.OnExit(arg_19_0)
	return
end

function var_0_0.Dispose(arg_20_0)
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
