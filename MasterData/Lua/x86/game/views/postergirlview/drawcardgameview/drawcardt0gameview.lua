local DrawCardT0GameView = class("DrawCardT0GameView", ReduxView)

function DrawCardT0GameView:UIName()
	return "Widget/System/Main_T0SceneGame/102003/102003_JokerGameUI"
end

function DrawCardT0GameView:UIParent()
	return manager.ui.uiMain.transform
end

function DrawCardT0GameView:OnCtor()
	return
end

function DrawCardT0GameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawCardT0GameView:InitUI()
	self:BindCfgUI()

	self.selfHpController = self.controllers_:GetController("self")
	self.enemyHpController = self.controllers_:GetController("enemy")
	self.selfAniMaskController = self.controllers_:GetController("selfAniMask")
	self.enemyAniMaskController = self.controllers_:GetController("enemyAniMask")
	self.hideController = self.controllers_:GetController("hide")
	self.subtitleBubble = MainHomeView_SubtitleBubble.New(self.talkBubbleGo_)
end

local var_0_1 = 3

function DrawCardT0GameView:OnEnter()
	self:RegisterEvents()
	self.subtitleBubble:OnEnter()
	self.hideController:SetSelectedState("true")
	SetActive(self.tipsGo_, false)
	self.jokergameuiAni_:Play("enter", 0, 0)

	self.winData = 0
	self.loseData = 0

	self:UpdateHP(0, 0)
end

function DrawCardT0GameView:UpdateHP(arg_7_1, arg_7_2)
	if arg_7_2 then
		self.selfHpController:SetSelectedState(var_0_1 - arg_7_2)
	end

	if arg_7_1 then
		self.enemyHpController:SetSelectedState(var_0_1 - arg_7_1)
	end
end

function DrawCardT0GameView:GetPlayBackwardsAnimator()
	return {
		{
			self.jokergameuiAni_,
			"extra",
			false
		}
	}, handler(self, self.PlayBackwardsAnimatorFun)
end

function DrawCardT0GameView:PlayBackwardsAnimatorFun()
	return
end

function DrawCardT0GameView:SetTipsValue(arg_10_1, arg_10_2)
	local var_10_0 = {
		[1] = "legTips",
		[2] = "bodyTips"
	}

	SetActive(self.tipsGo_, arg_10_1)
	self.clickpromptAni_:Play(var_10_0[arg_10_2] or var_10_0[1], 0, 0)
end

function DrawCardT0GameView:OnTop()
	self:ChangeBar()
	self.subtitleBubble:Clear()
end

function DrawCardT0GameView:OnBehind()
	manager.windowBar:HideBar()
end

function DrawCardT0GameView:OnExit()
	DrawCardT0GameView.super.OnExit(self)
	self.subtitleBubble:OnExit()
	SetActive(self.tipsGo_, false)
	AnimatorTools.Stop()
	self:RemoveAllEventListener()
end

function DrawCardT0GameView:RegisterEvents()
	self:RegistEventListener(INTERRUPT_HOME_POSTER_TALK, handler(self, self.ClearHomePosterTalk))
	self:RegistEventListener(REFRESH_DRAW_CARD_INFO, function(...)
		self:OnUpdateDrawCardInfo(...)
	end)
	self:RegistEventListener(DRAW_CARD_TIPS, handler(self, self.SetTipsValue))
	self:RegistEventListener("POSTERGIRL_T0_MINIGAME_ENTER_STATE", function(arg_16_0)
		self:OnMinigameEnterState(arg_16_0)
	end)
end

function DrawCardT0GameView:AddUIListener()
	return
end

function DrawCardT0GameView:OnMinigameEnterState(arg_18_1)
	if isa(arg_18_1, require("manager.posterGirl.tgame.DrawCardGame.States.Include").DrawCardState) then
		self.hideController:SetSelectedState("false")
	end
end

function DrawCardT0GameView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self.subtitleBubble:Clear()
		manager.transition:OnlyShowEffect(true, function()
			manager.windowBar:HideBar()
			manager.transition:OnlyShowEffect(false)
			manager.posterGirl:SetStateCanChange(true)
			manager.notify:Invoke(HOME_BTN_VISIBE, true)
			DrawCardGameManager.ExitGame(PosterGirlConst.StateKay.init_no_blend)
			JumpTools.Back()
		end)
	end)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = GameSetting.brahma_t0_desc1.value
		}
	})
end

function DrawCardT0GameView:OnUpdateDrawCardInfo(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1.win or 3
	local var_22_1 = arg_22_1.lose or 3

	if arg_22_2 then
		local var_22_2 = var_22_0 ~= self.winData

		if var_22_1 ~= self.loseData then
			self.selfAniMaskController:SetSelectedState(var_0_1 - arg_22_1.lose + 1)
			AnimatorTools.PlayAnimationWithCallback(self.selfitemAni_, "Shake", function()
				self:UpdateHP(nil, var_22_1)
			end, 0, 0)
		end

		if var_22_2 then
			self.enemyAniMaskController:SetSelectedState(var_0_1 - arg_22_1.win + 1)
			AnimatorTools.PlayAnimationWithCallback(self.enemyitemAni_, "Shake", function()
				self:UpdateHP(var_22_0, nil)
			end, 0, 0)
		end
	else
		self:UpdateHP(var_22_0, var_22_1)
	end

	self.winData = var_22_0
	self.loseData = var_22_1
end

function DrawCardT0GameView:ClearHomePosterTalk()
	self.subtitleBubble:Clear()
end

function DrawCardT0GameView:Dispose()
	DrawCardT0GameView.super.Dispose(self)
end

return DrawCardT0GameView
