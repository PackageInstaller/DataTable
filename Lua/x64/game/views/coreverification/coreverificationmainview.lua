local var_0_0 = class("CoreVerificationMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_Verification/CoreVerificationMain"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.updateInfoHandler = handler(arg_4_0, arg_4_0.UpdateCoreVerification)
	arg_4_0.mainBossItem_ = CoreVerificationBossItem.New(arg_4_0.boss1Go_, 1)
	arg_4_0.subBossItem_ = CoreVerificationBossItem.New(arg_4_0.boss2Go_, 2)
	arg_4_0.recordController = arg_4_0.rankingControllerexcollection_:GetController("haveRecord")
	arg_4_0.isSuperController = arg_4_0.coreverificationmainControllerexcollection_:GetController("isSuper")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("coreVerificationPre", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_flushedBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_RESETTIPS1"),
			OkCallback = function()
				CoreVerificationAction.ResetChallenge(0)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_flushed2Btn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_TAB_DES_5"),
			OkCallback = function()
				CoreVerificationAction.ResetChallenge(1)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.scourebtnBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationTeamCheck", {
			dataList = {
				CoreVerificationData:GetMaxScoreHeroInfo(1),
				(CoreVerificationData:GetMaxScoreHeroInfo(2))
			}
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankbtnBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationRank", {})
	end)
end

function var_0_0.UpdateCoreVerification(arg_15_0)
	CoreVerificationAction.UpdateChallengeRedPoints()
	arg_15_0:RefreshTitle()
	arg_15_0:RefreshRecord()
end

function var_0_0.OnEnter(arg_16_0)
	saveData("CoreVerification", "click_time", _G.gameTimer:GetNextDayFreshTime())
	CoreVerificationAction.UpdateChallengeRedPoints()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.redPoint:bindUIandKey(arg_16_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	arg_16_0:RefreshTitle()
	arg_16_0:RefreshRecord()
	manager.notify:RegistListener(CORE_VERIFICATION_CYCLE_UPDATE, arg_16_0.updateInfoHandler)
	SetActive(arg_16_0.rankingGo_, false)
end

function var_0_0.OnExit(arg_17_0)
	manager.redPoint:unbindUIandKey(arg_17_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	manager.notify:RemoveListener(CORE_VERIFICATION_CYCLE_UPDATE, arg_17_0.updateInfoHandler)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshTitle(arg_18_0)
	arg_18_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(CoreVerificationData:GetRefreshTime())

	arg_18_0.mainBossItem_:RefreshUI()
	arg_18_0.subBossItem_:RefreshUI()
	SetActive(arg_18_0.btn_flushedBtn_.gameObject, CoreVerificationData:GetCanReset())

	local var_18_0 = CoreVerificationTool.IsPassSuperStage()

	arg_18_0.isSuperController:SetSelectedState(var_18_0 and "true" or "false")
end

function var_0_0.RefreshRecord(arg_19_0)
	arg_19_0.scoreText_.text = CoreVerificationData:GetMaxScore()
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.subBossItem_ then
		arg_20_0.subBossItem_:Dispose()

		arg_20_0.subBossItem_ = nil
	end

	if arg_20_0.mainBossItem_ then
		arg_20_0.mainBossItem_:Dispose()

		arg_20_0.mainBossItem_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
