local CowboyGameView = class("CowboyGameView", ReduxView)
local cjson = require("cjson")

function CowboyGameView:UIName()
	return CowboyTools.GetGameUIName(self.params_.mainActivityID)
end

function CowboyGameView:UIParent()
	return manager.ui.uiMain.transform
end

function CowboyGameView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyGameView:InitUI()
	self:BindCfgUI()

	self.onSenceLoadedHandler_ = handler(self, self.OnCowboySenceLoaded)
	self.onTimeChangeHandler_ = handler(self, self.OnTimeChange)
	self.onScoreChangeHandler_ = handler(self, self.OnScoreChange)
	self.onAttackHandler_ = handler(self, self.OnAttack)
	self.OnGameFocusChange_ = handler(self, self.OnGameFocusChange1)
end

function CowboyGameView:AddUIListeners()
	self:AddBtnListener(self.catchBtn_, nil, function()
		CowboyTools:Attack()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		if self.isPause_ then
			return
		end

		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		self:OnCowboyPause()
		JumpTools.OpenPageByJump("cowboyGameBack", {
			mainActivityID = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.stopBtn_, nil, function()
		if self.isPause_ then
			return
		end

		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		self:OnCowboyPause()
		JumpTools.OpenPageByJump("cowboyGamePause", {
			mainActivityID = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.hideBtn_, nil, function()
		CowboyTools:Hide()
	end)
end

function CowboyGameView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.activityID_ = self.params_.activityID
	self.isPause_ = false

	SetActive(self.cdImg_, false)

	self.attackMask_.fillAmount = 0

	self:RegisterEvents()
	self:InitializeCowboy()
end

function CowboyGameView:InitializeCowboy()
	manager.ui:SetMainCamera("cowboy")

	manager.ui.mainCameraCom_.orthographic = true

	CowboyTools:LoadCowboyLevel(self.onSenceLoadedHandler_, self.onTimeChangeHandler_, self.onScoreChangeHandler_, self.onAttackHandler_)
end

function CowboyGameView:OnCowboySenceLoaded()
	CowboyTools:InitCowboySence(self.mainActivityID_, self.activityID_)
end

function CowboyGameView:OnTimeChange(arg_13_1)
	self.time_.text = arg_13_1
end

function CowboyGameView:OnScoreChange(arg_14_1)
	self.scoreText_.text = arg_14_1
end

function CowboyGameView:OnAttack(arg_15_1)
	self:StopTimer()
	SetActive(self.cdImg_, true)

	local var_15_0 = 0

	self.timer_ = Timer.New(function()
		if var_15_0 > arg_15_1 then
			self:StopTimer()
			SetActive(self.cdImg_, false)
		end

		self.attackMask_.fillAmount = 1 - var_15_0 / arg_15_1

		if not self.isPause_ then
			var_15_0 = var_15_0 + 0.01
		end
	end, 0.01, -1)

	self.timer_:Start()
end

function CowboyGameView:OnGameFocusChange1(arg_17_1, arg_17_2)
	if arg_17_2 or not arg_17_1 then
		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		CowboyTools:Pause()
	elseif self.isPause_ == false then
		manager.audio:Pause("music", false)
		manager.audio:Pause("effect", false)
		CowboyTools:Continue()
	end
end

function CowboyGameView:OnCowboyPause()
	self.isPause_ = true

	CowboyTools:Pause()
end

function CowboyGameView:OnCowboyContinue()
	self.isPause_ = false

	SetActive(self.cdImg_, false)
	CowboyTools:Continue()
end

function CowboyGameView:OnCowboyRestart()
	self:StopTimer()

	self.isPause_ = false

	SetActive(self.cdImg_, false)
	CowboyTools:Restart()
end

function CowboyGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.attackMask_.fillAmount = 0
end

function CowboyGameView:RegisterEvents()
	manager.notify:RegistListener(GAME_FOCUS_CHANGE, self.OnGameFocusChange_)
end

function CowboyGameView:RemoveEvents()
	manager.notify:RemoveListener(GAME_FOCUS_CHANGE, self.OnGameFocusChange_)
end

function CowboyGameView:OnExit()
	self:RemoveEvents()
	self:StopTimer()
	CowboyTools:GameOver()
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	CowboyTools:UnLoadCowboyLevel()
end

function CowboyGameView:Dispose()
	self:RemoveAllListeners()
	CowboyGameView.super.Dispose(self)
end

return CowboyGameView
