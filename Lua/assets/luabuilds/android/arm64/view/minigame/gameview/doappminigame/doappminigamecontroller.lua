local var_0_0 = class("DOAPPMiniGameController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1

	arg_1_0:InitTimer()
	arg_1_0:InitGameUI(arg_1_2)

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_2_1.speed = arg_2_1
	end

	return
end

function var_0_0.InitTimer(arg_3_0)
	arg_3_0.timer = Timer.New(function()
		arg_3_0:OnTimer(DOAPPGameConfig.TIME_INTERVAL)

		return
	end, DOAPPGameConfig.TIME_INTERVAL, -1)

	if IsUnityEditor and not arg_3_0.handle then
		arg_3_0.handle = UpdateBeat:CreateListener(arg_3_0.AddDebugInput, arg_3_0)

		UpdateBeat:AddListener(arg_3_0.handle)
	end

	return
end

function var_0_0.AddDebugInput(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs({
		"D",
		"S",
		"A",
		"W"
	}) do
		if Input.GetKeyDown(KeyCode[iter_5_1]) then
			arg_5_0.cacheInput = ({
				"E",
				"S",
				"W",
				"N"
			})[iter_5_0]
		end

		if Input.GetKeyUp(KeyCode[iter_5_1]) and arg_5_0.cacheInput == ({
			"E",
			"S",
			"W",
			"N"
		})[iter_5_0] then
			arg_5_0.cacheInput = nil
		end
	end

	return
end

local var_0_2 = {
	"Light",
	"Heavy",
	"Dodge"
}

function var_0_0.InitGameUI(arg_6_0, arg_6_1)
	arg_6_0.rtViewport = arg_6_1:Find("Viewport")
	arg_6_0.rtBg = arg_6_0.rtViewport:Find("MainContent/bg")
	arg_6_0.rtCharacter = arg_6_0.rtViewport:Find("MainContent/character")
	arg_6_0.rtPlayContent = arg_6_0.rtViewport:Find("MainContent/playContent")
	arg_6_0.rtBtns = arg_6_1:Find("Controller/middle/btn")

	eachChild(arg_6_0.rtBtns, function(arg_7_0)
		onButton(arg_6_0.binder, arg_7_0, function()
			arg_6_0.selectAction = table.indexof(var_0_2, arg_7_0.name)

			setActive(arg_6_0.rtBtns, false)
			arg_6_0:AfterSelect()

			return
		end, SFX_CONFIRM)

		return
	end)
	setActive(arg_6_0.rtBtns, false)

	arg_6_0.rtFloatUI = arg_6_1:Find("Controller/middle/targetUI")

	setActive(arg_6_0.rtFloatUI, false)
	eachChild(arg_6_0.rtPlayContent:Find("middle/EffectObject"), function(arg_9_0)
		arg_9_0:Find("Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_9_0, false)

			return
		end)

		return
	end)
	eachChild(arg_6_0.rtPlayContent:Find("middle/EffectOtherObject"), function(arg_11_0)
		arg_11_0:Find("Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_11_0, false)

			return
		end)

		return
	end)

	arg_6_0.rtPointShow = arg_6_1:Find("Controller/middle/point")
	arg_6_0.textTime = arg_6_1:Find("Controller/top/panel/time")
	arg_6_0.rtPoint = arg_6_1:Find("Controller/top/self")
	arg_6_0.rtPointOther = arg_6_1:Find("Controller/top/others")

	return
end

local var_0_3 = {
	"Misaki",
	"Marie",
	"Tamaki",
	"Luna"
}

function var_0_0.SetCharacter(arg_13_0, arg_13_1)
	arg_13_0.rtTarget = cloneTplTo(arg_13_0.rtCharacter:Find(arg_13_1), arg_13_0.rtPlayContent:Find("front"), arg_13_1)

	local var_13_0 = arg_13_0.rtTarget:Find("Image"):GetComponent(typeof(DftAniEvent))

	var_13_0:SetEndEvent(function()
		if math.abs(arg_13_0.deltaMove) > 2 then
			arg_13_0:ReadyPoint()
		else
			arg_13_0:UpdateReady(arg_13_0.rtTarget)
		end

		return
	end)
	var_13_0:SetTriggerEvent(function()
		arg_13_0.countTarget = arg_13_0.countTarget + 1

		eachChild(arg_13_0.rtTarget:Find("effect"), function(arg_16_0)
			if arg_16_0.name == arg_13_0.statusTarget .. "_" .. arg_13_0.countTarget then
				setActive(arg_16_0, true)
			end

			return
		end)

		return
	end)
	eachChild(arg_13_0.rtTarget:Find("effect"), function(arg_17_0)
		arg_17_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_17_0, false)

			return
		end)

		return
	end)
	eachChild(arg_13_0.rtPoint:Find("icon/mask"), function(arg_19_0)
		setActive(arg_19_0, arg_19_0.name == arg_13_1)

		return
	end)

	local var_13_1 = var_0_3[(table.indexof(var_0_3, arg_13_1) + math.random(3) + 3) % 4 + 1]

	arg_13_0.rtOtherTarget = cloneTplTo(arg_13_0.rtCharacter:Find(var_13_1), arg_13_0.rtPlayContent:Find("back"), var_13_1)

	eachChild(arg_13_0.rtOtherTarget, function(arg_20_0)
		setAnchoredPosition(arg_20_0, {
			x = 5
		})

		return
	end)
	setLocalScale(arg_13_0.rtOtherTarget, {
		x = -1
	})

	local var_13_2 = arg_13_0.rtOtherTarget:Find("Image"):GetComponent(typeof(DftAniEvent))

	var_13_2:SetEndEvent(function()
		if math.abs(arg_13_0.deltaMove) > 2 then
			arg_13_0:ReadyPoint()
		else
			arg_13_0:UpdateReady(arg_13_0.rtOtherTarget)
		end

		return
	end)
	var_13_2:SetTriggerEvent(function()
		arg_13_0.countOther = arg_13_0.countOther + 1

		eachChild(arg_13_0.rtOtherTarget:Find("effect"), function(arg_23_0)
			if arg_23_0.name == arg_13_0.statusOther .. "_" .. arg_13_0.countOther then
				setActive(arg_23_0, true)
			end

			return
		end)

		return
	end)
	eachChild(arg_13_0.rtOtherTarget:Find("effect"), function(arg_24_0)
		arg_24_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_24_0, false)

			return
		end)

		return
	end)
	eachChild(arg_13_0.rtPointOther:Find("icon/mask"), function(arg_26_0)
		setActive(arg_26_0, arg_26_0.name == var_13_1)

		return
	end)

	arg_13_0.rtEffectObject = arg_13_0.rtPlayContent:Find("middle/EffectObject")

	return
end

local function var_0_4(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:Find("point")

	for iter_27_0 = var_27_0.childCount, 1, -1 do
		triggerToggle(var_27_0:GetChild(iter_27_0 - 1), iter_27_0 <= arg_27_1)
	end

	return
end

function var_0_0.UpdatePoint(arg_28_0)
	var_0_4(arg_28_0.rtPoint, arg_28_0.myPoint)
	var_0_4(arg_28_0.rtPointOther, arg_28_0.otherPoint)

	return
end

function var_0_0.UpdateReady(arg_29_0, arg_29_1)
	onNextTick(function()
		if arg_29_1 == arg_29_0.rtTarget then
			setActive(arg_29_0.rtBtns, true)
		elseif arg_29_1 == arg_29_0.rtOtherTarget then
			setAnchoredPosition(arg_29_0.rtFloatUI, {
				x = arg_29_0.deltaMove * 60
			})

			arg_29_0.otherSelectAction = math.random(3)

			eachChild(arg_29_0.rtFloatUI, function(arg_31_0)
				setActive(arg_31_0, arg_31_0.name == tostring(arg_29_0.otherSelectAction))

				return
			end)

			arg_29_0.selectCountdown = DOAPPGameConfig.SELECT_TIME

			setSlider(arg_29_0.rtFloatUI:Find(arg_29_0.otherSelectAction .. "/Slider"), 0, DOAPPGameConfig.SELECT_TIME, DOAPPGameConfig.SELECT_TIME - arg_29_0.selectCountdown)
			setActive(arg_29_0.rtFloatUI, true)
			arg_29_0:AfterSelect()
		else
			assert(false)
		end

		setAnchoredPosition(arg_29_1, {
			x = arg_29_0.deltaMove * 10
		})

		return
	end)
	quickPlayAnimator(arg_29_1:Find("Image"), "Idle")

	return
end

function var_0_0.PlayEffect(arg_32_0, arg_32_1)
	setAnchoredPosition(arg_32_0.rtEffectObject, {
		x = arg_32_0.deltaMove * 10
	})

	arg_32_0.effectCountdownDic[arg_32_1] = DOAPPGameConfig.EFFECT_COUNTDOWN[arg_32_1]

	return
end

function var_0_0.AfterSelect(arg_33_0)
	if arg_33_0.selectAction and arg_33_0.otherSelectAction then
		setActive(arg_33_0.rtFloatUI, false)
		switch((arg_33_0.selectAction - arg_33_0.otherSelectAction + 3) % 3, {
			[0] = function()
				quickPlayAnimator(arg_33_0.rtTarget:Find("Image"), "Draw")
				quickPlayAnimator(arg_33_0.rtOtherTarget:Find("Image"), "Draw")

				arg_33_0.stopTarget = nil

				arg_33_0:PlayEffect("Draw")

				arg_33_0.blockMoveBg = true

				return
			end,
			function()
				arg_33_0.deltaMove = arg_33_0.deltaMove + 1

				if math.abs(arg_33_0.deltaMove) > 2 then
					local var_35_0 = {
						"Win_",
						"Lose_"
					}

					if not {
						"Win_",
						"Lose_"
					} then
						var_35_0 = {
							"Attack_",
							"Damage_"
						}
					end

					setParent(arg_33_0.rtTarget, arg_33_0.rtPlayContent:Find("front"))
					quickPlayAnimator(arg_33_0.rtTarget:Find("Image"), var_35_0[1] .. var_0_2[arg_33_0.selectAction])

					arg_33_0.statusTarget = var_35_0[1] .. var_0_2[arg_33_0.selectAction]
					arg_33_0.countTarget = 0

					setParent(arg_33_0.rtOtherTarget, arg_33_0.rtPlayContent:Find("back"))
					quickPlayAnimator(arg_33_0.rtOtherTarget:Find("Image"), var_35_0[2] .. var_0_2[arg_33_0.otherSelectAction])

					arg_33_0.statusOther = var_35_0[2] .. var_0_2[arg_33_0.otherSelectAction]
					arg_33_0.countOther = 0
					arg_33_0.rtEffectObject = arg_33_0.rtPlayContent:Find("middle/EffectObject")
					arg_33_0.stopTarget = arg_33_0.rtOtherTarget

					arg_33_0:PlayEffect(var_0_2[arg_33_0.selectAction])

					arg_33_0.blockMoveBg = true

					if math.abs(arg_33_0.deltaMove) > 2 then
						arg_33_0.loseDropCountdown = DOAPPGameConfig.LOSE_SOUND_COUNTDOWN[var_0_2[arg_33_0.otherSelectAction]] + defaultValue(DOAPPGameConfig.EFFECT_STOP_TIME[var_0_2[arg_33_0.selectAction]], 0)
					end

					return
				end
			end,
			function()
				arg_33_0.deltaMove = arg_33_0.deltaMove - 1

				if math.abs(arg_33_0.deltaMove) > 2 then
					local var_36_0 = {
						"Win_",
						"Lose_"
					}

					if not {
						"Win_",
						"Lose_"
					} then
						var_36_0 = {
							"Attack_",
							"Damage_"
						}
					end

					setParent(arg_33_0.rtTarget, arg_33_0.rtPlayContent:Find("back"))
					quickPlayAnimator(arg_33_0.rtTarget:Find("Image"), var_36_0[2] .. var_0_2[arg_33_0.selectAction])

					arg_33_0.statusTarget = var_36_0[2] .. var_0_2[arg_33_0.selectAction]
					arg_33_0.countTarget = 0

					setParent(arg_33_0.rtOtherTarget, arg_33_0.rtPlayContent:Find("front"))
					quickPlayAnimator(arg_33_0.rtOtherTarget:Find("Image"), var_36_0[1] .. var_0_2[arg_33_0.otherSelectAction])

					arg_33_0.statusOther = var_36_0[1] .. var_0_2[arg_33_0.otherSelectAction]
					arg_33_0.countOther = 0
					arg_33_0.rtEffectObject = arg_33_0.rtPlayContent:Find("middle/EffectOtherObject")
					arg_33_0.stopTarget = arg_33_0.rtTarget

					arg_33_0:PlayEffect(var_0_2[arg_33_0.otherSelectAction])

					arg_33_0.blockMoveBg = true

					if math.abs(arg_33_0.deltaMove) > 2 then
						arg_33_0.loseDropCountdown = DOAPPGameConfig.LOSE_SOUND_COUNTDOWN[var_0_2[arg_33_0.selectAction]] + defaultValue(DOAPPGameConfig.EFFECT_STOP_TIME[var_0_2[arg_33_0.otherSelectAction]], 0)
					end

					return
				end
			end
		})

		arg_33_0.selectAction = nil
		arg_33_0.otherSelectAction = nil
		arg_33_0.selectCountdown = nil
	end

	return
end

function var_0_0.ReadyPoint(arg_37_0)
	if arg_37_0.readyPointCount > 0 then
		arg_37_0.readyPointCount = 0

		if arg_37_0.deltaMove > 0 then
			arg_37_0.myPoint = arg_37_0.myPoint + 1
		else
			arg_37_0.otherPoint = arg_37_0.otherPoint + 1
		end

		arg_37_0:UpdatePoint()

		if arg_37_0.myPoint > 2 or arg_37_0.otherPoint > 2 then
			arg_37_0:EndGame(arg_37_0.myPoint - arg_37_0.otherPoint)
		else
			arg_37_0.nextCountdown = DOAPPGameConfig.NEXT_ROUND_COUNTDOWN

			eachChild(arg_37_0.rtPointShow:Find("left"), function(arg_38_0)
				setActive(arg_38_0, arg_38_0.name == tostring(arg_37_0.myPoint))

				return
			end)
			eachChild(arg_37_0.rtPointShow:Find("right"), function(arg_39_0)
				setActive(arg_39_0, arg_39_0.name == tostring(arg_37_0.otherPoint))

				return
			end)
			setActive(arg_37_0.rtPointShow, true)
		end
	else
		arg_37_0.readyPointCount = arg_37_0.readyPointCount + 1
	end

	return
end

function var_0_0.GetResultInfo(arg_40_0, arg_40_1)
	if arg_40_1 then
		return arg_40_0.rtOtherTarget.name, arg_40_0.otherPoint, arg_40_0.result * -1
	else
		return arg_40_0.rtTarget.name, arg_40_0.myPoint, arg_40_0.result
	end

	return
end

function var_0_0.ResetGame(arg_41_0)
	arg_41_0.timeCount = DOAPPGameConfig.ALL_TIME

	setText(arg_41_0.textTime, string.format("%02ds", arg_41_0.timeCount))

	arg_41_0.deltaMove = 0

	if not IsNil(arg_41_0.rtTarget) then
		Destroy(arg_41_0.rtTarget)

		arg_41_0.rtTarget = nil
	end

	if not IsNil(arg_41_0.rtOtherTarget) then
		Destroy(arg_41_0.rtOtherTarget)

		arg_41_0.rtOtherTarget = nil
	end

	setAnchoredPosition(arg_41_0.rtViewport:Find("MainContent"), {
		x = 0
	})
	eachChild(arg_41_0.rtViewport:Find("MainContent/bg"), function(arg_42_0)
		setAnchoredPosition(arg_42_0, {
			x = 0
		})

		return
	end)

	arg_41_0.myPoint = 0
	arg_41_0.otherPoint = 0
	arg_41_0.readyPointCount = 0

	setActive(arg_41_0.rtPointShow, false)

	arg_41_0.effectCountdownDic = {}

	return
end

function var_0_0.ReadyGame(arg_43_0, arg_43_1)
	arg_43_0:SetCharacter(arg_43_1.name)
	arg_43_0:UpdatePoint()
	arg_43_0:PauseGame()

	return
end

function var_0_0.StartGame(arg_44_0)
	arg_44_0.isStart = true

	arg_44_0:UpdateReady(arg_44_0.rtTarget)
	arg_44_0:UpdateReady(arg_44_0.rtOtherTarget)
	arg_44_0:ResumeGame()

	return
end

function var_0_0.EndGame(arg_45_0, arg_45_1)
	arg_45_0.isStart = false

	arg_45_0:PauseGame()

	arg_45_0.result = arg_45_1 or 0

	arg_45_0.binder:openUI("result")

	return
end

function var_0_0.ResumeGame(arg_46_0)
	arg_46_0.isPause = false

	arg_46_0.timer:Start()
	var_0_1(arg_46_0.rtViewport, 1)

	return
end

function var_0_0.PauseGame(arg_47_0)
	arg_47_0.isPause = true

	arg_47_0.timer:Stop()
	var_0_1(arg_47_0.rtViewport, 0)

	return
end

function var_0_0.OnTimer(arg_48_0, arg_48_1)
	arg_48_0.timeCount = arg_48_0.timeCount - arg_48_1

	setText(arg_48_0.textTime, string.format("%02ds", arg_48_0.timeCount))

	if arg_48_0.timeCount <= 0 then
		arg_48_0:EndGame(arg_48_0.myPoint - arg_48_0.otherPoint)

		return
	end

	if arg_48_0.selectCountdown then
		arg_48_0.selectCountdown = arg_48_0.selectCountdown - arg_48_1

		setSlider(arg_48_0.rtFloatUI:Find(arg_48_0.otherSelectAction .. "/Slider"), 0, DOAPPGameConfig.SELECT_TIME, DOAPPGameConfig.SELECT_TIME - arg_48_0.selectCountdown)
		setText(arg_48_0.rtFloatUI:Find(arg_48_0.otherSelectAction .. "/Text"), string.format("%2d%%", (DOAPPGameConfig.SELECT_TIME - arg_48_0.selectCountdown) * 100 / DOAPPGameConfig.SELECT_TIME))

		if arg_48_0.selectCountdown <= 0 then
			arg_48_0.selectAction = (arg_48_0.otherSelectAction + 1) % 3 + 1

			setActive(arg_48_0.rtBtns, false)
			arg_48_0:AfterSelect()
		end
	end

	if arg_48_0.nextCountdown then
		arg_48_0.nextCountdown = arg_48_0.nextCountdown - arg_48_1

		if arg_48_0.nextCountdown <= 0 then
			arg_48_0.nextCountdown = nil

			setActive(arg_48_0.rtPointShow, false)

			arg_48_0.deltaMove = 0

			arg_48_0:UpdateReady(arg_48_0.rtTarget)
			arg_48_0:UpdateReady(arg_48_0.rtOtherTarget)
		end
	end

	for iter_48_0, iter_48_1 in pairs(arg_48_0.effectCountdownDic) do
		arg_48_0.effectCountdownDic[iter_48_0] = arg_48_0.effectCountdownDic[iter_48_0] - arg_48_1

		if arg_48_0.effectCountdownDic[iter_48_0] <= 0 then
			arg_48_0.effectCountdownDic[iter_48_0] = nil

			setActive(arg_48_0.rtEffectObject:Find(iter_48_0), true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(DOAPPGameConfig.SOUND_EFFECT_PP)

			arg_48_0.blockMoveBg = false

			if arg_48_0.stopTarget then
				arg_48_0.stopCount = DOAPPGameConfig.EFFECT_STOP_TIME[iter_48_0]

				if arg_48_0.stopCount then
					onNextTick(function()
						var_0_1(arg_48_0.stopTarget, 0)

						return
					end)
				end
			end
		end
	end

	if arg_48_0.stopCount then
		arg_48_0.stopCount = arg_48_0.stopCount - arg_48_1

		if arg_48_0.stopCount <= 0 then
			arg_48_0.stopCount = nil

			var_0_1(arg_48_0.stopTarget, 1)
		end
	end

	if arg_48_0.loseDropCountdown then
		arg_48_0.loseDropCountdown = arg_48_0.loseDropCountdown - arg_48_1

		if arg_48_0.loseDropCountdown <= 0 then
			arg_48_0.loseDropCountdown = nil

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(DOAPPGameConfig.SOUND_EFFECT_DROP)
		end
	end

	if not arg_48_0.blockMoveBg then
		local var_48_0 = arg_48_0.rtViewport:Find("MainContent")

		if var_48_0.anchoredPosition.x ~= arg_48_0.deltaMove * DOAPPGameConfig.BG_DISTANCE then
			(function(arg_50_0, arg_50_1)
				local var_50_0 = arg_50_0.anchoredPosition.x / arg_50_1
				local var_50_1 = arg_50_0.anchoredPosition.x / arg_50_1 + (arg_48_0.deltaMove - arg_50_0.anchoredPosition.x / arg_50_1 > 0 and 1 or -1) * (arg_48_1 / DOAPPGameConfig.BG_MOVE_TIME)

				if arg_50_0.anchoredPosition.x / arg_50_1 < arg_48_0.deltaMove then
					local var_50_2 = {
						var_50_0,
						arg_48_0.deltaMove
					}

					if not {
						var_50_0,
						arg_48_0.deltaMove
					} then
						var_50_2 = {
							arg_48_0.deltaMove,
							var_50_0
						}
					end

					;({}).x = math.clamp(var_50_1, unpack(var_50_2)) * arg_50_1

					setAnchoredPosition(arg_50_0, {})

					return
				end
			end)(var_48_0, -1 * DOAPPGameConfig.BG_DISTANCE)

			local var_48_1 = var_48_0:Find("bg")

			for iter_48_2 = 1, var_48_1.childCount - 1 do
				(function(arg_50_0, arg_50_1)
					local var_50_0 = arg_50_0.anchoredPosition.x / arg_50_1
					local var_50_1 = arg_50_0.anchoredPosition.x / arg_50_1 + (arg_48_0.deltaMove - arg_50_0.anchoredPosition.x / arg_50_1 > 0 and 1 or -1) * (arg_48_1 / DOAPPGameConfig.BG_MOVE_TIME)

					if arg_50_0.anchoredPosition.x / arg_50_1 < arg_48_0.deltaMove then
						local var_50_2 = {
							var_50_0,
							arg_48_0.deltaMove
						}

						if not {
							var_50_0,
							arg_48_0.deltaMove
						} then
							var_50_2 = {
								arg_48_0.deltaMove,
								var_50_0
							}
						end

						;({}).x = math.clamp(var_50_1, unpack(var_50_2)) * arg_50_1

						setAnchoredPosition(arg_50_0, {})

						return
					end
				end)(var_48_1:GetChild(iter_48_2 - 1), (iter_48_2 - var_48_1.childCount) * DOAPPGameConfig.BG_DISTANCE)
			end
		end
	end

	return
end

function var_0_0.willExit(arg_51_0)
	if arg_51_0.handle then
		UpdateBeat:RemoveListener(arg_51_0.handle)
	end

	return
end

return var_0_0
