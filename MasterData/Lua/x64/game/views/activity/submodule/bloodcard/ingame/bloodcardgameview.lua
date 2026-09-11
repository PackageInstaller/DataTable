local BloodCardGameView = class("BloodCardGameView", ReduxView)

function BloodCardGameView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardGameUI"
end

function BloodCardGameView:UIParent()
	return manager.ui.uiMain.transform
end

function BloodCardGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BloodCardGameView:InitUI()
	self:BindCfgUI()

	self.onLoginHandler = handler(self, self.OnLogin)
	self.onClickCardHandler = handler(self, self.OnClickCard)
end

function BloodCardGameView:AddUIListener()
	return
end

function BloodCardGameView:OnEnter()
	manager.ui:SetMainCamera("bloodCard")

	if self.params_.callBack then
		self.time_ = Timer.New(function()
			self.params_.callBack()
		end, 1, 1)

		self.time_:Start()
	end

	self.timer_ = Timer.New(function()
		local var_8_0, var_8_1 = GuideTool.CheckWeakGuide(self.routeName_)

		if var_8_0 then
			self:RealCheckWeakGuide()
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
			self:UpdateBar()
		end

		if BloodCardManager.Instance:GetCurrentStatus() ~= 5 and gameContext:IsOpenRoute("bloodCardDetailView") then
			self:Back()
		end
	end, 1, -1)

	self.timer_:Start()
	manager.notify:RegistListener(BLOOD_CARD_IN_GAME_CLICK_CARD, self.onClickCardHandler)
	manager.notify:RegistListener(ON_LOGIN, self.onLoginHandler)
end

function BloodCardGameView:OnLogin()
	LaunchQWorld(true)
end

function BloodCardGameView:OnClickCard(arg_10_1, arg_10_2)
	JumpTools.OpenPageByJump("bloodCardDetailView", {
		cardID = arg_10_1,
		isEnemy = arg_10_2
	})
end

function BloodCardGameView:OnTop()
	if BloodCardManager.Instance:GetCurrentStatus() ~= 8 and BloodCardManager.Instance.playerSufferAniDone then
		self:UpdateBar()
	end
end

function BloodCardGameView:UpdateBar()
	if manager.windowBar:GetIsShow() then
		return
	end

	if GameSetting.v310_bloodcard_describe then
		local var_12_0 = GameSetting.v310_bloodcard_describe.value or {}
	end

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

function BloodCardGameView:OnExit()
	self:RemoveAllEventListener()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.notify:RemoveListener(BLOOD_CARD_IN_GAME_CLICK_CARD, self.onClickCardHandler)
	manager.notify:RemoveListener(ON_LOGIN, self.onLoginHandler)
	manager.windowBar:HideBar()
end

function BloodCardGameView:Dispose()
	BloodCardGameView.super.Dispose(self)
end

return BloodCardGameView
