local ShowTransitionMgr = class("ShowTransitionMgr", import("game.extend.BaseView"))

function ShowTransitionMgr:Ctor()
	if not self.gameObject_ then
		self.gameObject_ = Object.Instantiate(Asset.Load("UI/Common/switch"), manager.ui.uiMessage.transform)

		SetActive(self.gameObject_, false)

		self.image_ = self.gameObject_.transform:GetComponentInChildren(typeof(Image))
		self.color_ = self.image_.color
		self.color_.a = 0
		self.image_.color = self.color_
		self.animator_ = self.gameObject_:GetComponent("Animator")
	end

	gameContext:SetActions(handler(self, self.Show), handler(self, self.Hide))
end

function ShowTransitionMgr:RegistCanEndFunc(arg_2_1)
	self.canEndFunc_ = arg_2_1
end

local var_0_1 = {
	menuPop = true,
	GuelGameSeclectView = true,
	DanceGameView = true,
	TZeroGameChangeView = true,
	DrawCardT0GameView = true,
	GuelGameView = true,
	setting = true,
	posterGirlInteractBlankView = true
}

function ShowTransitionMgr:CheckGoHome(arg_3_1, arg_3_2)
	return arg_3_2 and gameContext:IsOpenRoute("home")
end

function ShowTransitionMgr:OverrideIgnoreTrainsition(arg_4_1)
	if gameContext:IsRouteBack() and arg_4_1 == "menuPop" then
		return false
	end

	return var_0_1[arg_4_1]
end

local var_0_2 = {
	"chat",
	"clubBoss",
	"DrawCardT0GameView",
	"posterGirlInteractBlankView"
}

local function var_0_3()
	for iter_5_0, iter_5_1 in ipairs(var_0_2) do
		if table.indexof(gameContext.oldRoutes_, iter_5_1) then
			return false
		end
	end

	return true
end

function ShowTransitionMgr:Show(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0
	local var_6_1

	if arg_6_3 then
		local var_6_3 = gameContext:GetAllOpenRoute()

		if gameContext.oldRoutes_[1] ~= "home" and var_6_3[1] == "home" and var_0_3() then
			PlayerTools.UpdateRandomData(HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER)
		end

		local var_6_4

		var_6_1, var_6_4 = manager.loadScene:GetNeedLoadSceneName(var_6_3)

		if not var_6_4 then
			manager.loadScene:StopSceneSoundEffect()
		else
			manager.loadScene:TryStopSceneSoundEffect(var_6_4)
		end
	end

	manager.loadScene:HideLastSceneList()
	self:DoCallBack()
	self:ClearTimer()

	self.callBackFun_ = arg_6_1

	if gameContext ~= nil then
		var_6_0 = gameContext:GetLastOpenPage()

		if (not ViewConst.PLAY_TRANSITION_URL_LIST[var_6_0] or not arg_6_2) and (not arg_6_3 or not var_6_1) and (self:OverrideIgnoreTrainsition(var_6_0) or not self:CheckGoHome(var_6_0, arg_6_3)) then
			self:ClearTimer()
			self:DoCallBack()

			return
		end
	end

	SetActive(self.gameObject_, true)
	self:PlayAnimator("enter")

	if arg_6_3 and var_6_1 then
		var_6_0 = var_6_1
	end

	if var_6_0 and var_6_0 ~= "home" then
		manager.loadScene:SetShouldLoadSceneName(var_6_0)
	end

	self.waitNextFrameToCallback = false

	local var_6_5 = false

	self.timer_ = FrameTimer.New(function()
		local var_7_0 = true

		if self.canEndFunc_ then
			var_7_0 = self.canEndFunc_() and manager.loadScene:CanEnd()
		end

		local var_7_1 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if not var_7_1:IsName("enter") then
			self:PlayAnimator("enter")
		end

		if var_7_1.normalizedTime > 1 and var_7_1:IsName("enter") and var_7_0 then
			if not self.waitNextFrameToCallback then
				self.waitNextFrameToCallback = true
			else
				self:ClearTimer()
				self:DoCallBack()

				self.waitNextFrameToCallback = false
			end
		end

		if self.canEndFunc_() and var_7_1.normalizedTime > 0.5 and var_7_1:IsName("enter") and not var_6_5 then
			if var_6_0 and var_6_0 == "home" then
				manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
				manager.loadScene:SetShouldLoadSceneName(var_6_0)
			end

			var_6_5 = true
		end
	end, 1, -1)

	self.timer_:Start()
end

function ShowTransitionMgr:Hide(arg_8_1, arg_8_2, arg_8_3)
	if gameContext ~= nil then
		local var_8_0 = gameContext:GetLastOpenPage()

		if (not ViewConst.PLAY_TRANSITION_URL_LIST[var_8_0] or not arg_8_2) and (self:OverrideIgnoreTrainsition(var_8_0) or not self:CheckGoHome(var_8_0, arg_8_3)) then
			self:DoCallBack()
			self:ClearTimer()
			SetActive(self.gameObject_, false)

			if arg_8_1 then
				arg_8_1()
			end

			return
		end
	end

	self:DoCallBack()
	self:ClearTimer()

	self.callBackFun_ = arg_8_1

	SetActive(self.gameObject_, true)

	self.waitNextFrameToHide = false
	self.timer_ = FrameTimer.New(function()
		if not self.waitNextFrameToHide then
			self:PlayAnimator("out")

			self.waitNextFrameToHide = true

			return
		end

		local var_9_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if not var_9_0:IsName("out") then
			self:PlayAnimator("out", true)
		end

		if var_9_0.normalizedTime > 1 and var_9_0:IsName("out") then
			self:ClearTimer()
			SetActive(self.gameObject_, false)
			self:DoCallBack()

			self.waitNextFrameToHide = false
		end
	end, 1, -1)

	self.timer_:Start()
end

function ShowTransitionMgr:OnlyShowEffect(arg_10_1, arg_10_2)
	if isNil(self.animator_) then
		return
	end

	self:DoCallBack()
	self:ClearTimer()

	self.callBackFun_ = arg_10_2

	if arg_10_1 then
		self.color_.a = 0
		self.image_.color = self.color_
	else
		self.color_.a = 1
		self.image_.color = self.color_
	end

	SetActive(self.gameObject_, true)

	local var_10_0 = arg_10_1 and "enter" or "out"

	if not self.animator_:GetCurrentAnimatorStateInfo(0):IsName(arg_10_1 and "enter" or "out") then
		self:PlayAnimator(var_10_0)
	end

	self.timer_ = FrameTimer.New(function()
		local var_11_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if not var_11_0:IsName(var_10_0) then
			self:PlayAnimator(var_10_0)
		end

		if var_11_0.normalizedTime > 1 and var_11_0:IsName(var_10_0) then
			self:ClearTimer()
			self:DoCallBack()
		end
	end, 1, -1)

	self.timer_:Start()
end

function ShowTransitionMgr:Dispose()
	gameContext:SetActions(nil, nil)

	if self.gameObject_ ~= nil then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
	end

	self:ClearTimer()

	self.image_ = nil
	self.canEndFunc_ = nil
	self.animator_ = nil

	ShowTransitionMgr.super.Dispose(self)
end

function ShowTransitionMgr:ClearTimer()
	if self.timer_ then
		manager.loadScene:AddCachePage()
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ShowTransitionMgr:DoCallBack()
	if self.callBackFun_ then
		self.callBackFun_ = nil

		self.callBackFun_()
	end
end

function ShowTransitionMgr:AnimatorWillPlay()
	return gameContext ~= nil and not var_0_1[gameContext:GetLastOpenPage()]
end

function ShowTransitionMgr:PlayAnimator(arg_16_1, arg_16_2)
	local var_16_0 = self:AnimatorWillPlay() and self.animator_.isActiveAndEnabled

	if arg_16_2 then
		var_16_0 = true

		SetActive(self.gameObject_, true)
	end

	if var_16_0 then
		self.animator_:Play(arg_16_1, -1, 0)
		self.animator_:Update(0)
	end
end

return ShowTransitionMgr
