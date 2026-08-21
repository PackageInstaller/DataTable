local var_0_0 = class("GuidePlayer")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.bgCg = arg_1_1:Find("BG"):GetComponent(typeof(CanvasGroup))
	arg_1_0.windowContainer = arg_1_1:Find("windows")
	arg_1_0.charContainer = arg_1_1:Find("char")
	arg_1_0.maskTr = arg_1_1:Find("mask")
	arg_1_0.dialogueWindows = pg.NewGuideMgr.GetInstance().dialogueWindows
	arg_1_0.counsellors = pg.NewGuideMgr.GetInstance().counsellors
	arg_1_0.uiFinder = pg.NewGuideMgr.GetInstance().uiFinder
	arg_1_0.uiDuplicator = pg.NewGuideMgr.GetInstance().uiDuplicator
	arg_1_0.uiLoader = pg.NewGuideMgr.GetInstance().uiLoader
	arg_1_0.uiFloatCollctor = pg.NewGuideMgr.GetInstance().uiFloatCollctor
	arg_1_0.root = arg_1_1:Find("target")

	return
end

function var_0_0.Execute(arg_2_0, arg_2_1, arg_2_2)
	seriesAsync({
		function(arg_3_0)
			arg_2_0:UpdateCanClickMask(arg_2_1)
			arg_2_0:HideDialogueWindows()
			arg_2_0:UpdateStyle(arg_2_1)
			arg_2_0:DoDelay(arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_2_0:WaitUntilSceneEnter(arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_2_0:CheckBaseUI(arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_2_0:CheckSprite(arg_2_1, arg_6_0)

			return
		end,
		function(arg_7_0)
			arg_2_0:ShowDialogueWindow(arg_2_1, arg_7_0)

			return
		end,
		function(arg_8_0)
			arg_2_0:UpdateHighLight(arg_2_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			arg_2_0:OnExecution(arg_2_1, arg_9_0)

			return
		end,
		function(arg_10_0)
			arg_2_0:RegisterEvent(arg_2_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			arg_2_0:Clear()
			arg_11_0()

			return
		end
	}, arg_2_2)

	return
end

function var_0_0.UpdateCanClickMask(arg_12_0, arg_12_1)
	setActive(arg_12_0.maskTr, not arg_12_1:CanClick())

	return
end

function var_0_0.CheckBaseUI(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1:ShouldCheckBaseUI() then
		arg_13_2()

		return
	end

	arg_13_0:SearchUI(arg_13_1:GetBaseUI(), function(arg_14_0)
		if not arg_14_0 then
			pg.NewGuideMgr.GetInstance():Stop()

			return
		end

		arg_13_2()

		return
	end)

	return
end

local function var_0_1(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetComponent(typeof(Image))
	local var_15_1 = IsNil(var_15_0.sprite) or arg_15_1 and var_15_0.sprite.name == arg_15_1

	return not var_15_1
end

function var_0_0.CheckSprite(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1:ShouldCheckSpriteUI() then
		arg_16_2()

		return
	end

	arg_16_0:SearchUI(arg_16_1:GetSpriteUI(), function(arg_17_0)
		if not arg_17_0 then
			pg.NewGuideMgr.GetInstance():Stop()

			return
		end

		local var_17_0 = var_0.childPath and arg_17_0:Find(var_0.childPath) or arg_17_0

		arg_16_0:ClearSpriteTimer()

		local var_17_1 = 0
		local var_17_2 = 10

		arg_16_0.spriteTimer = Timer.New(function()
			var_17_1 = var_17_1 + 1

			if var_17_1 == var_17_2 then
				arg_16_0:ClearSpriteTimer()

				return
			end

			if var_0_1(var_17_0, var_0.defaultName) then
				arg_16_0:ClearSpriteTimer()
				arg_16_2()
			end

			return
		end, 0.5, -1)

		arg_16_0.spriteTimer:Start()

		return
	end)

	return
end

function var_0_0.ClearSpriteTimer(arg_19_0)
	if arg_19_0.spriteTimer then
		arg_19_0.spriteTimer:Stop()

		arg_19_0.spriteTimer = nil
	end

	return
end

function var_0_0.UpdateStyle(arg_20_0, arg_20_1)
	arg_20_0.bgCg.alpha = arg_20_1:GetAlpha()

	return
end

function var_0_0.DoDelay(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:GetDelay()

	if var_21_0 <= 0 then
		arg_21_2()

		return
	end

	arg_21_0.delayTimer = Timer.New(arg_21_2, var_21_0, 1)

	arg_21_0.delayTimer:Start()

	return
end

function var_0_0.OnSceneEnter(arg_22_0)
	if arg_22_0.waitSceneData then
		if pg.NewGuideMgr.GetInstance():ExistScene(arg_22_0.waitSceneData.sceneName) then
			arg_22_0:ClearWaitUntilSceneTimer()
			arg_22_0.waitSceneData.callback()

			arg_22_0.waitSceneData = nil
		end
	end

	return
end

function var_0_0.WaitUntilSceneEnter(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1:ShouldWaitScene() then
		arg_23_2()

		return
	end

	arg_23_0:ClearWaitUntilSceneTimer()

	local var_23_0 = arg_23_1:GetWaitScene()

	if pg.NewGuideMgr.GetInstance():ExistScene(var_23_0) then
		arg_23_2()
	else
		arg_23_0.waitSceneData = {
			sceneName = var_23_0,
			callback = arg_23_2
		}

		arg_23_0:AddWaitUntilSceneTimer()
	end

	return
end

function var_0_0.AddWaitUntilSceneTimer(arg_24_0)
	arg_24_0.waitUntilSceneTimer = Timer.New(function()
		arg_24_0:ClearWaitUntilSceneTimer()
		pg.NewGuideMgr.GetInstance():Stop()

		return
	end, 10, 1)

	arg_24_0.waitUntilSceneTimer:Start()

	return
end

function var_0_0.ClearWaitUntilSceneTimer(arg_26_0)
	if arg_26_0.waitUntilSceneTimer then
		arg_26_0.waitUntilSceneTimer:Stop()

		arg_26_0.waitUntilSceneTimer = nil
	end

	return
end

function var_0_0.ShowDialogueWindow(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1:ShouldShowDialogue() then
		arg_27_0:HideDialogueWindows()
		arg_27_2()

		return
	end

	local var_27_0 = {}

	if not arg_27_0.dialogueWindows[arg_27_1:GetDialogueType()] then
		table.insert(var_27_0, function(arg_28_0)
			arg_27_0:LoadDialogueWindow(var_0, arg_28_0)

			return
		end)
	end

	table.insert(var_27_0, function(arg_29_0)
		arg_27_0:UpdateDialogue(arg_27_1, arg_27_0.dialogueWindows[var_0], arg_29_0)

		return
	end)
	seriesAsync(var_27_0, arg_27_2)

	return
end

function var_0_0.UpdateDialogue(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0:ActiveDialogueWindow(arg_30_2)

	local var_30_0 = arg_30_1:GetStyleData()

	setText(arg_30_2:Find("content"), var_30_0.text)

	arg_30_2.localScale = var_30_0.scale
	arg_30_2.localPosition = var_30_0.position
	arg_30_2:Find("content").localScale = var_30_0.scale

	local var_30_1 = arg_30_2:Find("hand")

	if not IsNil(var_30_1) then
		var_30_1.localPosition = var_30_0.handPosition
		var_30_1.eulerAngles = var_30_0.handAngle
	end

	if var_30_0.counsellor then
		seriesAsync({
			function(arg_31_0)
				arg_30_0:LoadCounsellor(var_0.name, arg_31_0)

				return
			end,
			function(arg_32_0)
				setActive(arg_30_0.counsellors[var_0.name], true)

				arg_30_0.counsellors[var_0.name].localPosition = arg_30_2.localPosition + Vector3(var_0.position.x, var_0.position.y, 0)
				arg_30_0.counsellors[var_0.name].localScale = Vector3(var_0.scale.x, var_0.scale.y, 1)

				arg_32_0()

				return
			end
		}, arg_30_3)
	else
		for iter_30_0, iter_30_1 in pairs(arg_30_0.counsellors) do
			setActive(iter_30_1, false)
		end

		arg_30_3()
	end

	return
end

function var_0_0.LoadCounsellor(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0.counsellors[arg_33_1] then
		LoadAnyAsync("guideitem/" .. arg_33_1, "", nil, function(arg_34_0)
			if IsNil(arg_34_0) then
				return
			end

			arg_33_0.counsellors[arg_33_1] = Object.Instantiate(arg_34_0, arg_33_0.charContainer).transform

			arg_33_2()

			return
		end)
	else
		arg_33_2()
	end

	return
end

function var_0_0.LoadDialogueWindow(arg_35_0, arg_35_1, arg_35_2)
	LoadAnyAsync("guideitem/window_" .. arg_35_1, "", nil, function(arg_36_0)
		if IsNil(arg_36_0) then
			return
		end

		arg_35_0.dialogueWindows[arg_35_1] = Object.Instantiate(arg_36_0, arg_35_0.windowContainer).transform

		if arg_35_2 then
			arg_35_2()
		end

		return
	end)

	return
end

function var_0_0.ActiveDialogueWindow(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in pairs(arg_37_0.dialogueWindows) do
		setActive(iter_37_1, iter_37_1 == arg_37_1)
	end

	return
end

function var_0_0.HideDialogueWindows(arg_38_0)
	for iter_38_0, iter_38_1 in pairs(arg_38_0.dialogueWindows) do
		setActive(iter_38_1, false)
	end

	return
end

local function var_0_2(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_3.type == GuideStep.HIGH_TYPE_GAMEOBJECT then
		arg_39_0.uiDuplicator:Duplicate(arg_39_2, {
			clearAllEvent = true
		})
	elseif arg_39_3.type == GuideStep.HIGH_TYPE_LINE then
		local var_39_0 = arg_39_0._tf:InverseTransformPoint(arg_39_2.position)

		arg_39_0.uiLoader:LoadHighLightArea({
			position = Vector3(var_39_0.x, var_39_0.y, 0) + Vector3(arg_39_2.rect.x, arg_39_2.rect.y, 0),
			size = Vector2(arg_39_2.rect.width, arg_39_2.rect.height),
			length = arg_39_1:GetHighlightLength(),
			name = arg_39_1:GetHighlightName()
		})
	elseif arg_39_3.type == GuideStep.HIGH_TYPE_FLOAT then
		arg_39_0.uiFloatCollctor:SetFloat(arg_39_2)
	end

	return
end

function var_0_0.UpdateHighLight(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1:GetHighLightTarget()

	if #var_40_0 <= 0 then
		arg_40_2()

		return
	end

	local var_40_1 = {}

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		table.insert(var_40_1, function(arg_41_0)
			arg_40_0:SearchUI(iter_40_1, function(arg_42_0)
				if not arg_42_0 then
					pg.NewGuideMgr.GetInstance():Stop()

					return
				end

				var_0_2(arg_40_0, arg_40_1, arg_42_0, iter_40_1)
				arg_41_0()

				return
			end)

			return
		end)
	end

	parallelAsync(var_40_1, arg_40_2)

	return
end

function var_0_0.SearchUI(arg_43_0, arg_43_1, arg_43_2)
	arg_43_0.uiFinder:Search({
		path = arg_43_1.path,
		delay = arg_43_1.delay,
		childIndex = arg_43_1.pathIndex,
		conditionData = arg_43_1.conditionData,
		callback = arg_43_2
	})

	return
end

function var_0_0.SearchWithoutDelay(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0.uiFinder:SearchWithoutDelay({
		path = arg_44_1.path,
		delay = arg_44_1.delay,
		childIndex = arg_44_1.pathIndex,
		conditionData = arg_44_1.conditionData,
		callback = arg_44_2
	})

	return
end

function var_0_0.RegisterEvent(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1:ExistTrigger() then
		removeOnButton(arg_45_0._tf)
		arg_45_2()

		return
	end

	onButton(pg.NewGuideMgr.GetInstance(), arg_45_0._tf, function()
		if arg_45_1:ShouldGoScene() then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE[arg_45_1.sceneName])
			arg_45_2()
		elseif arg_45_1:ShouldTriggerOtherTarget() then
			arg_45_0:SearchUI(arg_45_1:GetOtherTriggerTarget(), function(arg_47_0)
				triggerButton(arg_47_0)
				arg_45_2()

				return
			end)
		else
			arg_45_2()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.NextOne(arg_48_0)
	triggerButton(arg_48_0._tf)

	return
end

function var_0_0.HideCounsellors(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.counsellors) do
		setActive(iter_49_1, false)
	end

	return
end

function var_0_0.Clear(arg_50_0)
	arg_50_0:HideCounsellors()
	arg_50_0:HideDialogueWindows()
	arg_50_0:ClearSpriteTimer()
	setActive(arg_50_0.maskTr, false)
	removeOnButton(arg_50_0._tf)
	arg_50_0:OnClear()

	if arg_50_0.delayTimer then
		arg_50_0.delayTimer:Stop()

		arg_50_0.delayTimer = nil
	end

	arg_50_0.uiFinder:Clear()
	arg_50_0.uiDuplicator:Clear()
	arg_50_0.uiLoader:Clear()
	arg_50_0.uiFloatCollctor:Clear()

	return
end

function var_0_0.OnExecution(arg_51_0, arg_51_1, arg_51_2)
	arg_51_2()

	return
end

function var_0_0.OnClear(arg_52_0)
	return
end

return var_0_0
