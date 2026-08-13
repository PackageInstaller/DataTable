class = var_0_10000

local var_0_0 = var_0_10000("GuidePlayer")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	local var_1_0 = arg_1_1:Find("BG")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10005
	arg_1_0.bgCg = var_1_1(var_1_0, var_4(var_1_10005))
	arg_1_0.windowContainer = arg_1_1:Find("windows")
	arg_1_0.charContainer = arg_1_1:Find("char")
	arg_1_0.maskTr = arg_1_1:Find("mask")
	pg = var_2
	arg_1_0.dialogueWindows = var_2.NewGuideMgr.GetInstance().dialogueWindows
	pg = var_2
	arg_1_0.counsellors = var_2.NewGuideMgr.GetInstance().counsellors
	pg = var_2
	arg_1_0.uiFinder = var_2.NewGuideMgr.GetInstance().uiFinder
	pg = var_2
	arg_1_0.uiDuplicator = var_2.NewGuideMgr.GetInstance().uiDuplicator
	pg = var_2
	arg_1_0.uiLoader = var_2.NewGuideMgr.GetInstance().uiLoader
	pg = var_2
	arg_1_0.uiFloatCollctor = var_2.NewGuideMgr.GetInstance().uiFloatCollctor
	arg_1_0.root = arg_1_1:Find("target")

	return
end

function var_0_0.Execute(arg_2_0, arg_2_1, arg_2_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.UpdateCanClickMask(var_3_0, arg_2_1)

			local var_3_1 = arg_2_0

			var_1.HideDialogueWindows(var_3_1)

			local var_3_2 = arg_2_0

			var_1.UpdateStyle(var_3_2, arg_2_1)

			local var_3_3 = arg_2_0

			var_1.DoDelay(var_3_3, arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.WaitUntilSceneEnter(var_4_0, arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0

			var_1.CheckBaseUI(var_5_0, arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_2_0

			var_1.CheckSprite(var_6_0, arg_2_1, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_2_0

			var_1.ShowDialogueWindow(var_7_0, arg_2_1, arg_7_0)

			return
		end,
		function(arg_8_0)
			local var_8_0 = arg_2_0

			var_1.UpdateHighLight(var_8_0, arg_2_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			local var_9_0 = arg_2_0

			var_1.OnExecution(var_9_0, arg_2_1, arg_9_0)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_2_0

			var_1.RegisterEvent(var_10_0, arg_2_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			local var_11_0 = arg_2_0

			var_1.Clear(var_11_0)
			arg_11_0()

			return
		end
	}, arg_2_2)

	return
end

function var_0_0.UpdateCanClickMask(arg_12_0, arg_12_1)
	setActive = var_1_10002

	var_1_10002(arg_12_0.maskTr, not arg_12_1:CanClick())

	return
end

function var_0_0.CheckBaseUI(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1:ShouldCheckBaseUI() then
		arg_13_2()

		return
	end

	arg_13_0:SearchUI(arg_13_1:GetBaseUI(), function(arg_14_0)
		if not arg_14_0 then
			pg = var_2_10001

			local var_14_0 = var_2_10001.NewGuideMgr.GetInstance()

			var_1.Stop(var_14_0)

			return
		end

		arg_13_2()

		return
	end)

	return
end

local function var_0_1(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetComponent

	typeof = var_1_10004
	Image = var_1_10005

	local var_15_2 = var_15_1(var_15_0, var_1_10004(var_1_10005))

	IsNil = var_15_0

	local var_15_3

	if not var_15_0(var_15_2.sprite) then
		var_15_3 = arg_15_1 and var_15_2.sprite.name == arg_15_1
	end

	return not var_15_3
end

function var_0_0.CheckSprite(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1:ShouldCheckSpriteUI() then
		arg_16_2()

		return
	end

	local var_16_0 = arg_16_1:GetSpriteUI()

	arg_16_0:SearchUI(var_16_0, function(arg_17_0)
		if not arg_17_0 then
			pg = var_2_10001

			local var_17_0 = var_2_10001.NewGuideMgr.GetInstance()

			var_1.Stop(var_17_0)

			return
		end

		local var_17_1

		if not var_16_0.childPath or not arg_17_0:Find(var_16_0.childPath) then
			var_17_1 = arg_17_0
		end

		local var_17_2 = arg_16_0

		var_2.ClearSpriteTimer(var_17_2)

		local var_17_3 = 0
		local var_17_4 = 10
		local var_17_5 = arg_16_0

		Timer = var_2_10005
		var_17_5.spriteTimer = var_2_10005.New(function()
			var_17_3 = var_17_3 + 1

			if var_17_3 == var_17_4 then
				local var_18_0 = arg_16_0

				var_0.ClearSpriteTimer(var_18_0)

				return
			end

			if var_0_1(var_17_1, var_16_0.defaultName) then
				local var_18_1 = arg_16_0

				var_0.ClearSpriteTimer(var_18_1)
				arg_16_2()
			end

			return
		end, 0.5, -1)

		local var_17_6 = arg_16_0.spriteTimer

		var_4.Start(var_17_6)

		return
	end)

	return
end

function var_0_0.ClearSpriteTimer(arg_19_0)
	if arg_19_0.spriteTimer then
		local var_19_0 = arg_19_0.spriteTimer

		var_1.Stop(var_19_0)

		arg_19_0.spriteTimer = nil
	end

	return
end

function var_0_0.UpdateStyle(arg_20_0, arg_20_1)
	arg_20_0.bgCg.alpha = arg_20_1:GetAlpha()

	return
end

function var_0_0.DoDelay(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1:GetDelay() <= 0 then
		arg_21_2()

		return
	end

	Timer = var_4
	arg_21_0.delayTimer = var_4.New(arg_21_2, var_3, 1)

	local var_21_0 = arg_21_0.delayTimer

	var_4.Start(var_21_0)

	return
end

function var_0_0.OnSceneEnter(arg_22_0)
	if arg_22_0.waitSceneData then
		pg = var_1

		local var_22_0 = var_1.NewGuideMgr.GetInstance()

		if var_1.ExistScene(var_22_0, arg_22_0.waitSceneData.sceneName) then
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

	local var_23_0 = arg_23_1
	local var_23_1 = arg_23_1.GetWaitScene(var_23_0)

	pg = var_23_0

	local var_23_2 = var_23_0.NewGuideMgr.GetInstance()

	if var_4.ExistScene(var_23_2, var_23_1) then
		arg_23_2()
	else
		arg_23_0.waitSceneData = {
			sceneName = var_23_1,
			callback = arg_23_2
		}

		arg_23_0:AddWaitUntilSceneTimer()
	end

	return
end

function var_0_0.AddWaitUntilSceneTimer(arg_24_0)
	Timer = var_1_10001
	arg_24_0.waitUntilSceneTimer = var_1_10001.New(function()
		local var_25_0 = arg_24_0

		var_0.ClearWaitUntilSceneTimer(var_25_0)

		pg = var_0

		local var_25_1 = var_0.NewGuideMgr.GetInstance()

		var_0.Stop(var_25_1)

		return
	end, 10, 1)

	local var_24_0 = arg_24_0.waitUntilSceneTimer

	var_1.Start(var_24_0)

	return
end

function var_0_0.ClearWaitUntilSceneTimer(arg_26_0)
	if arg_26_0.waitUntilSceneTimer then
		local var_26_0 = arg_26_0.waitUntilSceneTimer

		var_1.Stop(var_26_0)

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
	local var_27_1 = arg_27_1:GetDialogueType()

	if not arg_27_0.dialogueWindows[var_27_1] then
		table = var_1_10006

		var_1_10006.insert(var_27_0, function(arg_28_0)
			local var_28_0 = arg_27_0

			var_1.LoadDialogueWindow(var_28_0, var_27_1, arg_28_0)

			return
		end)
	end

	table = var_1_10006

	var_1_10006.insert(var_27_0, function(arg_29_0)
		local var_29_0 = arg_27_0.dialogueWindows[var_27_1]
		local var_29_1 = arg_27_0

		var_2.UpdateDialogue(var_29_1, arg_27_1, var_29_0, arg_29_0)

		return
	end)

	seriesAsync = var_6

	var_6(var_27_0, arg_27_2)

	return
end

function var_0_0.UpdateDialogue(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0:ActiveDialogueWindow(arg_30_2)

	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_1.GetStyleData(var_30_0)

	setText = var_30_0

	var_30_0(arg_30_2:Find("content"), var_30_1.text)

	arg_30_2.localScale = var_30_1.scale
	arg_30_2.localPosition = var_30_1.position
	arg_30_2:Find("content").localScale = var_30_1.scale

	local var_30_2 = arg_30_2
	local var_30_3 = arg_30_2.Find(var_30_2, "hand")

	IsNil = var_30_2

	if not var_30_2(var_30_3) then
		var_30_3.localPosition = var_30_1.handPosition
		var_30_3.eulerAngles = var_30_1.handAngle
	end

	if var_30_1.counsellor then
		seriesAsync = var_7

		var_7({
			function(arg_31_0)
				local var_31_0 = arg_30_0

				var_1.LoadCounsellor(var_31_0, var_0.name, arg_31_0)

				return
			end,
			function(arg_32_0)
				local var_32_0 = arg_30_0.counsellors[var_0.name]

				setActive = var_2

				var_2(var_32_0, true)

				local var_32_1 = arg_30_2.localPosition

				Vector3 = var_3
				var_32_0.localPosition = var_32_1 + var_3(var_0.position.x, var_0.position.y, 0)
				Vector3 = var_2
				var_32_0.localScale = var_2(var_0.scale.x, var_0.scale.y, 1)

				arg_32_0()

				return
			end
		}, arg_30_3)
	else
		pairs = var_7

		for iter_30_0, iter_30_1 in var_7(arg_30_0.counsellors) do
			setActive = var_1_10012

			var_1_10012(iter_30_1, false)
		end

		arg_30_3()
	end

	return
end

function var_0_0.LoadCounsellor(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0.counsellors[arg_33_1] then
		LoadAnyAsync = var_3

		var_3("guideitem/" .. arg_33_1, "", nil, function(arg_34_0)
			IsNil = var_2_10001

			if var_2_10001(arg_34_0) then
				return
			end

			Object = var_1

			local var_34_0 = var_1.Instantiate(arg_34_0, arg_33_0.charContainer)

			arg_33_0.counsellors[arg_33_1] = var_34_0.transform

			arg_33_2()

			return
		end)
	else
		arg_33_2()
	end

	return
end

function var_0_0.LoadDialogueWindow(arg_35_0, arg_35_1, arg_35_2)
	LoadAnyAsync = var_1_10003

	var_1_10003("guideitem/window_" .. arg_35_1, "", nil, function(arg_36_0)
		IsNil = var_2_10001

		if var_2_10001(arg_36_0) then
			return
		end

		Object = var_1

		local var_36_0 = var_1.Instantiate(arg_36_0, arg_35_0.windowContainer)

		arg_35_0.dialogueWindows[arg_35_1] = var_36_0.transform

		if arg_35_2 then
			arg_35_2()
		end

		return
	end)

	return
end

function var_0_0.ActiveDialogueWindow(arg_37_0, arg_37_1)
	pairs = var_1_10002

	for iter_37_0, iter_37_1 in var_1_10002(arg_37_0.dialogueWindows) do
		setActive = var_1_10007

		var_1_10007(iter_37_1, iter_37_1 == arg_37_1)
	end

	return
end

function var_0_0.HideDialogueWindows(arg_38_0)
	pairs = var_1_10001

	for iter_38_0, iter_38_1 in var_1_10001(arg_38_0.dialogueWindows) do
		setActive = var_1_10006

		var_1_10006(iter_38_1, false)
	end

	return
end

local function var_0_2(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = arg_39_3.type

	GuideStep = var_1_10005

	local var_39_1

	if var_39_0 == var_1_10005.HIGH_TYPE_GAMEOBJECT then
		var_39_1 = arg_39_0.uiDuplicator

		var_4.Duplicate(var_39_1, arg_39_2, {
			clearAllEvent = true
		})
	else
		local var_39_2 = arg_39_3.type

		GuideStep = var_39_1

		local var_39_5

		if var_39_2 == var_39_1.HIGH_TYPE_LINE then
			local var_39_3 = arg_39_2.rect
			local var_39_4 = arg_39_0._tf

			var_39_5 = var_39_5.InverseTransformPoint(var_39_4, arg_39_2.position)

			local var_39_6 = arg_39_0.uiLoader
			local var_39_7 = var_6.LoadHighLightArea
			local var_39_8 = {}

			Vector3 = var_1_10009

			local var_39_9 = var_1_10009(var_39_5.x, var_39_5.y, 0)

			Vector3 = var_10
			var_39_8.position = var_39_9 + var_10(var_39_3.x, var_39_3.y, 0)
			Vector2 = var_9
			var_39_8.size = var_9(var_39_3.width, var_39_3.height)
			var_39_8.length = arg_39_1:GetHighlightLength()
			var_39_8.name = arg_39_1:GetHighlightName()

			var_39_7(var_39_6, var_39_8)
		else
			local var_39_10 = arg_39_3.type

			GuideStep = var_39_5

			if var_39_10 == var_39_5.HIGH_TYPE_FLOAT then
				local var_39_11 = arg_39_0.uiFloatCollctor

				var_4.SetFloat(var_39_11, arg_39_2)
			end
		end
	end

	return
end

function var_0_0.UpdateHighLight(arg_40_0, arg_40_1, arg_40_2)
	if #arg_40_1:GetHighLightTarget() <= 0 then
		arg_40_2()

		return
	end

	local var_40_0 = {}

	ipairs = var_5

	for iter_40_0, iter_40_1 in var_5(var_3) do
		table = var_1_10010

		var_1_10010.insert(var_40_0, function(arg_41_0)
			local var_41_0 = arg_40_0

			var_1.SearchUI(var_41_0, iter_40_1, function(arg_42_0)
				if not arg_42_0 then
					pg = var_3_10001

					local var_42_0 = var_3_10001.NewGuideMgr.GetInstance()

					var_1.Stop(var_42_0)

					return
				end

				var_0_2(arg_40_0, arg_40_1, arg_42_0, iter_40_1)
				arg_41_0()

				return
			end)

			return
		end)
	end

	parallelAsync = var_5

	var_5(var_40_0, arg_40_2)

	return
end

function var_0_0.SearchUI(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.uiFinder

	var_3.Search(var_43_0, {
		path = arg_43_1.path,
		delay = arg_43_1.delay,
		childIndex = arg_43_1.pathIndex,
		conditionData = arg_43_1.conditionData,
		callback = arg_43_2
	})

	return
end

function var_0_0.SearchWithoutDelay(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.uiFinder

	var_3.SearchWithoutDelay(var_44_0, {
		path = arg_44_1.path,
		delay = arg_44_1.delay,
		childIndex = arg_44_1.pathIndex,
		conditionData = arg_44_1.conditionData,
		callback = arg_44_2
	})

	return
end

function var_0_0.RegisterEvent(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_1

	if arg_45_1.ExistTrigger(var_45_0) then
		removeOnButton = var_3

		var_3(arg_45_0._tf)
		arg_45_2()

		return
	end

	onButton = var_3
	pg = var_45_0

	local var_45_1 = var_45_0.NewGuideMgr.GetInstance()
	local var_45_2 = arg_45_0._tf

	local function var_45_3()
		local var_46_0 = arg_45_1

		if var_0.ShouldGoScene(var_46_0) then
			pg = var_0

			local var_46_1 = var_0.m02
			local var_46_2 = var_0.sendNotification

			GAME = var_2_10002

			local var_46_3 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_46_2(var_46_1, var_46_3, var_2_10003[arg_45_1.sceneName])
			arg_45_2()
		else
			local var_46_4 = arg_45_1

			if var_0.ShouldTriggerOtherTarget(var_46_4) then
				local var_46_5 = arg_45_0
				local var_46_6 = var_0.SearchUI
				local var_46_7 = arg_45_1

				var_46_6(var_46_5, var_2.GetOtherTriggerTarget(var_46_7), function(arg_47_0)
					triggerButton = var_3_10001

					var_3_10001(arg_47_0)
					arg_45_2()

					return
				end)
			else
				arg_45_2()
			end
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_45_1, var_45_2, var_45_3, var_1_10007)

	return
end

function var_0_0.NextOne(arg_48_0)
	triggerButton = var_1_10001

	var_1_10001(arg_48_0._tf)

	return
end

function var_0_0.HideCounsellors(arg_49_0)
	pairs = var_1_10001

	for iter_49_0, iter_49_1 in var_1_10001(arg_49_0.counsellors) do
		setActive = var_1_10006

		var_1_10006(iter_49_1, false)
	end

	return
end

function var_0_0.Clear(arg_50_0)
	arg_50_0:HideCounsellors()
	arg_50_0:HideDialogueWindows()
	arg_50_0:ClearSpriteTimer()

	setActive = var_1

	var_1(arg_50_0.maskTr, false)

	removeOnButton = var_1

	var_1(arg_50_0._tf)
	arg_50_0:OnClear()

	if arg_50_0.delayTimer then
		local var_50_0 = arg_50_0.delayTimer

		var_1.Stop(var_50_0)

		arg_50_0.delayTimer = nil
	end

	local var_50_1 = arg_50_0.uiFinder

	var_1.Clear(var_50_1)

	local var_50_2 = arg_50_0.uiDuplicator

	var_1.Clear(var_50_2)

	local var_50_3 = arg_50_0.uiLoader

	var_1.Clear(var_50_3)

	local var_50_4 = arg_50_0.uiFloatCollctor

	var_1.Clear(var_50_4)

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
