local var_0_0 = class("BattlePushSnowBallTeamSurvivalResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballResultNeckingModeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()

	arg_3_0.resultController_ = ControllerUtil.GetController(arg_3_0.transform_, "result")
	arg_3_0.killController_ = ControllerUtil.GetController(arg_3_0.transform_, "killNum")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, PushSnowBallTeamResultItem)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:CloseFunc()
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

function var_0_0.HideAllUI(arg_11_0)
	SetActive(arg_11_0.backBtn_.gameObject, false)
	SetActive(arg_11_0.shareBtn_.gameObject, false)
end

function var_0_0.RecoverAllUI(arg_12_0)
	SetActive(arg_12_0.backBtn_.gameObject, true)
	SetActive(arg_12_0.shareBtn_.gameObject, true)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.stageData = arg_13_0.params_.stageData
	arg_13_0.resultInfo = arg_13_0.params_.resultInfo
	arg_13_0.stageId = arg_13_0.stageData:GetStageId()
	arg_13_0.stageType = arg_13_0.stageData:GetType()
	arg_13_0.playerID = tostring(PlayerData:GetPlayerInfo().userID)

	table.sort(arg_13_0.resultInfo, function(arg_14_0, arg_14_1)
		return arg_14_0.score > arg_14_1.score
	end)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.resultInfo) do
		iter_13_1.rank = iter_13_0

		if iter_13_1.user_id == arg_13_0.playerID then
			arg_13_0.info = iter_13_1
		end
	end

	BattleInstance.hideBattlePanel()
	arg_13_0:RefreshUI()

	if arg_13_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_13_0:CloseFunc()
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
	arg_18_0.rankText_.text = arg_18_0.info.rank
	arg_18_0.killNumText_.text = arg_18_0.info.score
	arg_18_0.nameText_.text = arg_18_0.stageData:GetName()
	arg_18_0.playerNameText_.text = PlayerData:GetPlayerInfo().nick

	if arg_18_0.info.rank == 1 then
		arg_18_0.resultController_:SetSelectedState("win")
	else
		arg_18_0.resultController_:SetSelectedState("lose")
	end

	arg_18_0.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait2/" .. PushSnowBallData:GetSelectedHeroID())

	arg_18_0.uiList_:StartScroll(#arg_18_0.resultInfo)
end

function var_0_0.IndexItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_1, arg_19_0.resultInfo[arg_19_1])
end

function var_0_0.OnExit(arg_20_0)
	return
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.uiList_ then
		arg_21_0.uiList_:Dispose()

		arg_21_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
