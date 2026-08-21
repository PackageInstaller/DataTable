local var_0_0 = class("BloodCardGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardGameUI"
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

	arg_4_0.onLoginHandler = handler(arg_4_0, arg_4_0.OnLogin)
	arg_4_0.onClickCardHandler = handler(arg_4_0, arg_4_0.OnClickCard)
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	manager.ui:SetMainCamera("bloodCard")

	if arg_6_0.params_.callBack then
		arg_6_0.time_ = Timer.New(function()
			arg_6_0.params_.callBack()
		end, 1, 1)

		arg_6_0.time_:Start()
	end

	arg_6_0.timer_ = Timer.New(function()
		local var_8_0, var_8_1 = GuideTool.CheckWeakGuide(arg_6_0.routeName_)

		if var_8_0 then
			arg_6_0:RealCheckWeakGuide()
		end

		if not manager.guide:IsPlaying() then
			BloodCardManager.Instance.guideID = 0

			if not GuideData:IsFinish(108) and BloodCardManager.Instance.guideIndex == 1 then
				BloodCardManager.Instance.guideID = 108
			elseif not GuideData:IsFinish(109) and BloodCardManager.Instance.guideIndex == 2 then
				BloodCardManager.Instance.guideID = 109

				BloodCardManager.Instance:LockCardLisener(true)
			end
		end

		if BloodCardManager.Instance:GetCurrentStatus() == 8 or not BloodCardManager.Instance.playerSufferAniDone then
			manager.windowBar:HideBar()
		else
			arg_6_0:UpdateBar()
		end

		if BloodCardManager.Instance:GetCurrentStatus() ~= 5 and gameContext:IsOpenRoute("bloodCardDetailView") then
			arg_6_0:Back()
		end
	end, 1, -1)

	arg_6_0.timer_:Start()
	manager.notify:RegistListener(BLOOD_CARD_IN_GAME_CLICK_CARD, arg_6_0.onClickCardHandler)
	manager.notify:RegistListener(ON_LOGIN, arg_6_0.onLoginHandler)
end

function var_0_0.OnLogin(arg_9_0)
	LaunchQWorld(true)
end

function var_0_0.OnClickCard(arg_10_0, arg_10_1, arg_10_2)
	JumpTools.OpenPageByJump("bloodCardDetailView", {
		cardID = arg_10_1,
		isEnemy = arg_10_2
	})
end

function var_0_0.OnTop(arg_11_0)
	if BloodCardManager.Instance:GetCurrentStatus() ~= 8 and BloodCardManager.Instance.playerSufferAniDone then
		arg_11_0:UpdateBar()
	end
end

function var_0_0.UpdateBar(arg_12_0)
	if manager.windowBar:GetIsShow() then
		return
	end

	local var_12_0 = GameSetting.v310_bloodcard_describe and GameSetting.v310_bloodcard_describe.value or {}

	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		if manager.guide:IsPlaying() or not BloodCardManager.Instance.playerSufferAniDone then
			return
		end

		JumpTools.OpenPageByJump("/gameHelpPro", {
			isPrefab = true,
			pages = var_12_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		if manager.guide:IsPlaying() or not BloodCardManager.Instance.playerSufferAniDone or BloodCardManager.Instance.guideID == 108 then
			return
		end

		if BloodCardManager.Instance:GetCurrentStatus() == 8 then
			LaunchQWorld(true)
		else
			JumpTools.OpenPageByJump("eatSnakeQuitPop", {
				content = GetTips("ACTIVITY_BLOOD_CARD_GAME_GIVE_UP_CONFIRMATION"),
				cancelAction = function()
					return
				end,
				failAction = function()
					if BloodCardManager.Instance:GetCurrentStatus() == 8 then
						LaunchQWorld(true)
					else
						SendResetGameRequest()

						BloodCardManager.Instance.isAbandon = true
					end
				end
			})
		end
	end)
	manager.windowBar:SetWhereTag("qworld")
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:RemoveAllEventListener()

	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end

	manager.notify:RemoveListener(BLOOD_CARD_IN_GAME_CLICK_CARD, arg_17_0.onClickCardHandler)
	manager.notify:RemoveListener(ON_LOGIN, arg_17_0.onLoginHandler)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
