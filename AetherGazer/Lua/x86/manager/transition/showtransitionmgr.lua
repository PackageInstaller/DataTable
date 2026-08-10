local var_0_0 = class("ShowTransitionMgr", import("game.extend.BaseView"))

function var_0_0.Ctor(arg_1_0)
	if not arg_1_0.gameObject_ then
		arg_1_0.gameObject_ = Object.Instantiate(Asset.Load("UI/Common/switch"), manager.ui.uiMessage.transform)

		SetActive(arg_1_0.gameObject_, false)

		arg_1_0.image_ = arg_1_0.gameObject_.transform:GetComponentInChildren(typeof(Image))
		arg_1_0.color_ = arg_1_0.image_.color
		arg_1_0.color_.a = 0
		arg_1_0.image_.color = arg_1_0.color_
		arg_1_0.animator_ = arg_1_0.gameObject_:GetComponent("Animator")
	end

	gameContext:SetActions(handler(arg_1_0, arg_1_0.Show), handler(arg_1_0, arg_1_0.Hide))
end

function var_0_0.RegistCanEndFunc(arg_2_0, arg_2_1)
	arg_2_0.canEndFunc_ = arg_2_1
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

function var_0_0.CheckGoHome(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_2 and gameContext:IsOpenRoute("home")
end

function var_0_0.OverrideIgnoreTrainsition(arg_4_0, arg_4_1)
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
	local var_5_0 = gameContext.oldRoutes_

	for iter_5_0, iter_5_1 in ipairs(var_0_2) do
		if table.indexof(var_5_0, iter_5_1) then
			return false
		end
	end

	return true
end

function var_0_0.Show(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0
	local var_6_1
	local var_6_2

	if arg_6_3 then
		local var_6_3 = gameContext.oldRoutes_[1]
		local var_6_4 = gameContext:GetAllOpenRoute()

		if var_6_3 ~= "home" and var_6_4[1] == "home" and var_0_3() then
			PlayerTools.UpdateRandomData(HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER)
		end

		local var_6_5

		var_6_1, var_6_5 = manager.loadScene:GetNeedLoadSceneName(var_6_4)

		if not var_6_5 then
			manager.loadScene:StopSceneSoundEffect()
		else
			manager.loadScene:TryStopSceneSoundEffect(var_6_5)
		end
	end

	manager.loadScene:HideLastSceneList()
	arg_6_0:DoCallBack()
	arg_6_0:ClearTimer()

	arg_6_0.callBackFun_ = arg_6_1

	if gameContext ~= nil then
		var_6_0 = gameContext:GetLastOpenPage()

		if (not ViewConst.PLAY_TRANSITION_URL_LIST[var_6_0] or not arg_6_2) and (not arg_6_3 or not var_6_1) and (arg_6_0:OverrideIgnoreTrainsition(var_6_0) or not arg_6_0:CheckGoHome(var_6_0, arg_6_3)) then
			arg_6_0:ClearTimer()
			arg_6_0:DoCallBack()

			return
		end
	end

	SetActive(arg_6_0.gameObject_, true)
	arg_6_0:PlayAnimator("enter")

	if arg_6_3 and var_6_1 then
		var_6_0 = var_6_1
	end

	if var_6_0 and var_6_0 ~= "home" then
		manager.loadScene:SetShouldLoadSceneName(var_6_0)
	end

	arg_6_0.waitNextFrameToCallback = false

	local var_6_6 = false

	arg_6_0.timer_ = FrameTimer.New(function()
		local var_7_0 = true

		if arg_6_0.canEndFunc_ then
			var_7_0 = arg_6_0.canEndFunc_() and manager.loadScene:CanEnd()
		end

		local var_7_1 = arg_6_0.animator_:GetCurrentAnimatorStateInfo(0)

		if not var_7_1:IsName("enter") then
			arg_6_0:PlayAnimator("enter")
		end

		if var_7_1.normalizedTime > 1 and var_7_1:IsName("enter") and var_7_0 then
			if not arg_6_0.waitNextFrameToCallback then
				arg_6_0.waitNextFrameToCallback = true
			else
				arg_6_0:ClearTimer()
				arg_6_0:DoCallBack()

				arg_6_0.waitNextFrameToCallback = false
			end
		end

		if arg_6_0.canEndFunc_() and var_7_1.normalizedTime > 0.5 and var_7_1:IsName("enter") and not var_6_6 then
			if var_6_0 and var_6_0 == "home" then
				manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
				manager.loadScene:SetShouldLoadSceneName(var_6_0)
			end

			var_6_6 = true
		end
	end, 1, -1)

	arg_6_0.timer_:Start()
end

function var_0_0.Hide(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if gameContext ~= nil then
		local var_8_0 = gameContext:GetLastOpenPage()

		if (not ViewConst.PLAY_TRANSITION_URL_LIST[var_8_0] or not arg_8_2) and (arg_8_0:OverrideIgnoreTrainsition(var_8_0) or not arg_8_0:CheckGoHome(var_8_0, arg_8_3)) then
			arg_8_0:DoCallBack()
			arg_8_0:ClearTimer()
			SetActive(arg_8_0.gameObject_, false)

			if arg_8_1 then
				arg_8_1()
			end

			return
		end
	end

	arg_8_0:DoCallBack()
	arg_8_0:ClearTimer()

	arg_8_0.callBackFun_ = arg_8_1

	SetActive(arg_8_0.gameObject_, true)

	arg_8_0.waitNextFrameToHide = false
	arg_8_0.timer_ = FrameTimer.New(function()
		if not arg_8_0.waitNextFrameToHide then
			arg_8_0:PlayAnimator("out")

			arg_8_0.waitNextFrameToHide = true

			return
		end

		local var_9_0 = arg_8_0.animator_:GetCurrentAnimatorStateInfo(0)

		if not var_9_0:IsName("out") then
			arg_8_0:PlayAnimator("out", true)
		end

		if var_9_0.normalizedTime > 1 and var_9_0:IsName("out") then
			arg_8_0:ClearTimer()
			SetActive(arg_8_0.gameObject_, false)
			arg_8_0:DoCallBack()

			arg_8_0.waitNextFrameToHide = false
		end
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.OnlyShowEffect(arg_10_0, arg_10_1, arg_10_2)
	if isNil(arg_10_0.animator_) then
		return
	end

	arg_10_0:DoCallBack()
	arg_10_0:ClearTimer()

	arg_10_0.callBackFun_ = arg_10_2

	if arg_10_1 then
		arg_10_0.color_.a = 0
		arg_10_0.image_.color = arg_10_0.color_
	else
		arg_10_0.color_.a = 1
		arg_10_0.image_.color = arg_10_0.color_
	end

	SetActive(arg_10_0.gameObject_, true)

	local var_10_0 = arg_10_1 and "enter" or "out"

	if not arg_10_0.animator_:GetCurrentAnimatorStateInfo(0):IsName(var_10_0) then
		arg_10_0:PlayAnimator(var_10_0)
	end

	arg_10_0.timer_ = FrameTimer.New(function()
		local var_11_0 = arg_10_0.animator_:GetCurrentAnimatorStateInfo(0)

		if not var_11_0:IsName(var_10_0) then
			arg_10_0:PlayAnimator(var_10_0)
		end

		if var_11_0.normalizedTime > 1 and var_11_0:IsName(var_10_0) then
			arg_10_0:ClearTimer()
			arg_10_0:DoCallBack()
		end
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.Dispose(arg_12_0)
	gameContext:SetActions(nil, nil)

	if arg_12_0.gameObject_ ~= nil then
		Object.Destroy(arg_12_0.gameObject_)

		arg_12_0.gameObject_ = nil
	end

	arg_12_0:ClearTimer()

	arg_12_0.image_ = nil
	arg_12_0.canEndFunc_ = nil
	arg_12_0.animator_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.ClearTimer(arg_13_0)
	if arg_13_0.timer_ then
		manager.loadScene:AddCachePage()
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_0.DoCallBack(arg_14_0)
	if arg_14_0.callBackFun_ then
		local var_14_0 = arg_14_0.callBackFun_

		arg_14_0.callBackFun_ = nil

		var_14_0()
	end
end

function var_0_0.AnimatorWillPlay(arg_15_0)
	return gameContext ~= nil and not var_0_1[gameContext:GetLastOpenPage()]
end

function var_0_0.PlayAnimator(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:AnimatorWillPlay() and arg_16_0.animator_.isActiveAndEnabled

	if arg_16_2 then
		var_16_0 = true

		SetActive(arg_16_0.gameObject_, true)
	end

	if var_16_0 then
		arg_16_0.animator_:Play(arg_16_1, -1, 0)
		arg_16_0.animator_:Update(0)
	end
end

return var_0_0
