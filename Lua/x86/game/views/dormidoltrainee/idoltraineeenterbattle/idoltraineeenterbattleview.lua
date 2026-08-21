local var_0_0 = class("IdolTraineeEnterBattleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleEnterView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.raceData_ = {}
	arg_4_0.styleData_ = {}
	arg_4_0.selectHeroPage_ = EnterBattleSelectHeroPage.New(arg_4_0.selectHeroGo_)

	arg_4_0.selectHeroPage_:ShowPage(false)

	arg_4_0.selectOpponentPage_ = EnterBattleSelectOpponentPage.New(arg_4_0.selectOpponentGo_)

	arg_4_0.selectOpponentPage_:ShowPage(false)

	arg_4_0.stageInfoPage = IdolTraineeStageInfoPage.New(arg_4_0.stageInfo)

	arg_4_0.stageInfoPage:ShowPage(true)

	arg_4_0.showHistoryController = arg_4_0.mainControllerEx_:GetController("showHistory")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.historyBtn_, nil, function()
		if arg_5_0.pvpBattle_ then
			IdolTraineeAction.AskHistoryBattleData(function()
				JumpTools.OpenPageByJump("idolTraineeBattleHistoryPop")
			end)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.enterBtn_, nil, function()
		if arg_5_0.selectOpponentPage_.showFlag and arg_5_0.pvpBattle_ then
			return
		end

		local var_8_0 = IdolTraineeData:GetCurAttackHero()
		local var_8_1

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if iter_8_1 == true then
				var_8_1 = iter_8_0
			end
		end

		if var_8_1 then
			if arg_5_0.pvpBattle_ then
				arg_5_0.selectOpponentPage_:ShowPage(true)
				SetActive(arg_5_0.maskImg_.gameObject, true)
			elseif arg_5_0.stageID_ then
				BackHomeCricketAction:AskPvEBattleData(arg_5_0.stageID_)
			end
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.heroBtn, nil, function()
		arg_5_0.selectHeroPage_:ShowPage(true)
		SetActive(arg_5_0.maskImg_.gameObject, true)
	end)
end

function var_0_0.RefreshBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_10_0.selectOpponentPage_.showFlag then
			arg_10_0.selectOpponentPage_:ShowPage(false)

			if not arg_10_0.selectHeroPage_.showFlag then
				SetActive(arg_10_0.maskImg_.gameObject, false)
			end

			return
		end

		if arg_10_0.selectHeroPage_.showFlag then
			arg_10_0.selectHeroPage_:ShowPage(false)
			SetActive(arg_10_0.maskImg_.gameObject, false)

			arg_10_0.selectHeroPage_.curHeroID_ = nil

			arg_10_0.showHistoryController:SetSelectedState("open")

			if arg_10_0.pvpBattle_ then
				arg_10_0.showHistoryController:SetSelectedState("open")
			else
				arg_10_0.showHistoryController:SetSelectedState("close")
			end

			return
		end

		IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
		arg_10_0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		arg_10_0.selectOpponentPage_:ShowPage(false)
		SetActive(arg_10_0.maskImg_.gameObject, false)
		arg_10_0.selectHeroPage_:ShowPage(false)

		arg_10_0.selectHeroPage_.curHeroID_ = nil

		IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
		JumpTools.OpenPageByJump("/idolTraineeCamp")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", true)
	arg_13_0:RefreshBar()

	arg_13_0.pvpBattle_ = arg_13_0.params_.pvpBattle
	arg_13_0.stageID_ = arg_13_0.params_.stageID

	if arg_13_0.pvpBattle_ then
		arg_13_0.stageID_ = IdolTraineeData:GetCurPVPStage()

		arg_13_0.showHistoryController:SetSelectedState("open")
	else
		arg_13_0.showHistoryController:SetSelectedState("close")
	end

	arg_13_0.stageInfoPage:SetParams(arg_13_0.params_)
	arg_13_0.stageInfoPage:OnEnter()
	arg_13_0.selectHeroPage_:OnEnter()
	arg_13_0.selectHeroPage_:RefreshUI()
	arg_13_0.selectOpponentPage_:OnEnter()
end

function var_0_0.StopWaitCamBlend(arg_14_0)
	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0.selectHeroPage_:OnExit()
	arg_15_0.selectOpponentPage_:OnExit()
	arg_15_0:StopWaitCamBlend()
end

function var_0_0.OnIdolPvpStageUpdateFromServer(arg_16_0)
	if arg_16_0.pvpBattle_ and arg_16_0.stageInfoPage then
		arg_16_0.stageID_ = IdolTraineeData:GetCurPVPStage()

		arg_16_0.stageInfoPage:OnIdolPvpStageUpdateFromServer()
	end
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:StopWaitCamBlend()
	arg_17_0.selectHeroPage_:Dispose()
	arg_17_0.selectOpponentPage_:Dispose()
	arg_17_0.stageInfoPage:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.OnTop(arg_18_0)
	arg_18_0.gameObject_.layer = 18
	arg_18_0.maskImg_.enabled = true
end

function var_0_0.OnBehind(arg_19_0)
	arg_19_0.gameObject_.layer = 5
	arg_19_0.maskImg_.enabled = false
end

return var_0_0
