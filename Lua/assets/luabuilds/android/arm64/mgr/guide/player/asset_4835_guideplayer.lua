local GuidePlayer = class("GuidePlayer")

function GuidePlayer:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.bgCg = arg_1_1:Find("BG"):GetComponent(typeof(CanvasGroup))
	self.windowContainer = arg_1_1:Find("windows")
	self.charContainer = arg_1_1:Find("char")
	self.maskTr = arg_1_1:Find("mask")
	self.dialogueWindows = pg.NewGuideMgr.GetInstance().dialogueWindows
	self.counsellors = pg.NewGuideMgr.GetInstance().counsellors
	self.uiFinder = pg.NewGuideMgr.GetInstance().uiFinder
	self.uiDuplicator = pg.NewGuideMgr.GetInstance().uiDuplicator
	self.uiLoader = pg.NewGuideMgr.GetInstance().uiLoader
	self.uiFloatCollctor = pg.NewGuideMgr.GetInstance().uiFloatCollctor
	self.root = arg_1_1:Find("target")

	return
end

function GuidePlayer:Execute(arg_2_1, arg_2_2)
	seriesAsync({
		function(arg_3_0)
			self:UpdateCanClickMask(arg_2_1)
			self:HideDialogueWindows()
			self:UpdateStyle(arg_2_1)
			self:DoDelay(arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			self:WaitUntilSceneEnter(arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			self:CheckBaseUI(arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			self:CheckSprite(arg_2_1, arg_6_0)

			return
		end,
		function(arg_7_0)
			self:ShowDialogueWindow(arg_2_1, arg_7_0)

			return
		end,
		function(arg_8_0)
			self:UpdateHighLight(arg_2_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			self:OnExecution(arg_2_1, arg_9_0)

			return
		end,
		function(arg_10_0)
			self:RegisterEvent(arg_2_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			self:Clear()
			arg_11_0()

			return
		end
	}, arg_2_2)

	return
end

function GuidePlayer:UpdateCanClickMask(arg_12_1)
	setActive(self.maskTr, not arg_12_1:CanClick())

	return
end

function GuidePlayer:CheckBaseUI(arg_13_1, arg_13_2)
	if not arg_13_1:ShouldCheckBaseUI() then
		arg_13_2()

		return
	end

	self:SearchUI(arg_13_1:GetBaseUI(), function(arg_14_0)
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

	return not (IsNil(var_15_0.sprite) or arg_15_1 and var_15_0.sprite.name == arg_15_1)
end

function GuidePlayer:CheckSprite(arg_16_1, arg_16_2)
	if not arg_16_1:ShouldCheckSpriteUI() then
		arg_16_2()

		return
	end

	local var_16_0 = arg_16_1:GetSpriteUI()

	self:SearchUI(var_16_0, function(arg_17_0)
		if not arg_17_0 then
			pg.NewGuideMgr.GetInstance():Stop()

			return
		end

		local var_17_0 = var_16_0.childPath and arg_17_0:Find(var_16_0.childPath) or arg_17_0

		self:ClearSpriteTimer()

		local var_17_1 = 0
		local var_17_2 = 10

		self.spriteTimer = Timer.New(function()
			var_17_1 = var_17_1 + 1

			if var_17_1 == var_17_2 then
				self:ClearSpriteTimer()

				return
			end

			if var_0_1(var_17_0, var_16_0.defaultName) then
				self:ClearSpriteTimer()
				arg_16_2()
			end

			return
		end, 0.5, -1)

		self.spriteTimer:Start()

		return
	end)

	return
end

function GuidePlayer:ClearSpriteTimer()
	if self.spriteTimer then
		self.spriteTimer:Stop()

		self.spriteTimer = nil
	end

	return
end

function GuidePlayer:UpdateStyle(arg_20_1)
	self.bgCg.alpha = arg_20_1:GetAlpha()

	return
end

function GuidePlayer:DoDelay(arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:GetDelay()

	if var_21_0 <= 0 then
		arg_21_2()

		return
	end

	self.delayTimer = Timer.New(arg_21_2, var_21_0, 1)

	self.delayTimer:Start()

	return
end

function GuidePlayer:OnSceneEnter()
	if self.waitSceneData then
		if pg.NewGuideMgr.GetInstance():ExistScene(self.waitSceneData.sceneName) then
			self:ClearWaitUntilSceneTimer()
			self.waitSceneData.callback()

			self.waitSceneData = nil
		end
	end

	return
end

function GuidePlayer:WaitUntilSceneEnter(arg_23_1, arg_23_2)
	if not arg_23_1:ShouldWaitScene() then
		arg_23_2()

		return
	end

	self:ClearWaitUntilSceneTimer()

	local var_23_0 = arg_23_1:GetWaitScene()

	if pg.NewGuideMgr.GetInstance():ExistScene(var_23_0) then
		arg_23_2()
	else
		self.waitSceneData = {
			sceneName = var_23_0,
			callback = arg_23_2
		}

		self:AddWaitUntilSceneTimer()
	end

	return
end

function GuidePlayer:AddWaitUntilSceneTimer()
	self.waitUntilSceneTimer = Timer.New(function()
		self:ClearWaitUntilSceneTimer()
		pg.NewGuideMgr.GetInstance():Stop()

		return
	end, 10, 1)

	self.waitUntilSceneTimer:Start()

	return
end

function GuidePlayer:ClearWaitUntilSceneTimer()
	if self.waitUntilSceneTimer then
		self.waitUntilSceneTimer:Stop()

		self.waitUntilSceneTimer = nil
	end

	return
end

function GuidePlayer:ShowDialogueWindow(arg_27_1, arg_27_2)
	if not arg_27_1:ShouldShowDialogue() then
		self:HideDialogueWindows()
		arg_27_2()

		return
	end

	local var_27_0 = {}
	local var_27_1 = arg_27_1:GetDialogueType()

	if not self.dialogueWindows[var_27_1] then
		table.insert(var_27_0, function(arg_28_0)
			self:LoadDialogueWindow(var_27_1, arg_28_0)

			return
		end)
	end

	table.insert(var_27_0, function(arg_29_0)
		self:UpdateDialogue(arg_27_1, self.dialogueWindows[var_27_1], arg_29_0)

		return
	end)
	seriesAsync(var_27_0, arg_27_2)

	return
end

function GuidePlayer:UpdateDialogue(arg_30_1, arg_30_2, arg_30_3)
	self:ActiveDialogueWindow(arg_30_2)

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

	local var_30_2 = var_30_0.counsellor

	if var_30_0.counsellor then
		seriesAsync({
			function(arg_31_0)
				self:LoadCounsellor(var_30_2.name, arg_31_0)

				return
			end,
			function(arg_32_0)
				setActive(self.counsellors[var_30_2.name], true)

				self.counsellors[var_30_2.name].localPosition = arg_30_2.localPosition + Vector3(var_30_2.position.x, var_30_2.position.y, 0)
				self.counsellors[var_30_2.name].localScale = Vector3(var_30_2.scale.x, var_30_2.scale.y, 1)

				arg_32_0()

				return
			end
		}, arg_30_3)
	else
		for iter_30_0, iter_30_1 in pairs(self.counsellors) do
			setActive(iter_30_1, false)
		end

		arg_30_3()
	end

	return
end

function GuidePlayer:LoadCounsellor(arg_33_1, arg_33_2)
	if not self.counsellors[arg_33_1] then
		LoadAnyAsync("guideitem/" .. arg_33_1, "", nil, function(arg_34_0)
			if IsNil(arg_34_0) then
				return
			end

			self.counsellors[arg_33_1] = Object.Instantiate(arg_34_0, self.charContainer).transform

			arg_33_2()

			return
		end)
	else
		arg_33_2()
	end

	return
end

function GuidePlayer:LoadDialogueWindow(arg_35_1, arg_35_2)
	LoadAnyAsync("guideitem/window_" .. arg_35_1, "", nil, function(arg_36_0)
		if IsNil(arg_36_0) then
			return
		end

		self.dialogueWindows[arg_35_1] = Object.Instantiate(arg_36_0, self.windowContainer).transform

		if arg_35_2 then
			arg_35_2()
		end

		return
	end)

	return
end

function GuidePlayer:ActiveDialogueWindow(arg_37_1)
	for iter_37_0, iter_37_1 in pairs(self.dialogueWindows) do
		setActive(iter_37_1, iter_37_1 == arg_37_1)
	end

	return
end

function GuidePlayer:HideDialogueWindows()
	for iter_38_0, iter_38_1 in pairs(self.dialogueWindows) do
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

function GuidePlayer:UpdateHighLight(arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1:GetHighLightTarget()

	if #var_40_0 <= 0 then
		arg_40_2()

		return
	end

	local var_40_1 = {}

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		table.insert(var_40_1, function(arg_41_0)
			self:SearchUI(iter_40_1, function(arg_42_0)
				if not arg_42_0 then
					pg.NewGuideMgr.GetInstance():Stop()

					return
				end

				var_0_2(self, arg_40_1, arg_42_0, iter_40_1)
				arg_41_0()

				return
			end)

			return
		end)
	end

	parallelAsync(var_40_1, arg_40_2)

	return
end

function GuidePlayer:SearchUI(arg_43_1, arg_43_2)
	self.uiFinder:Search({
		path = arg_43_1.path,
		delay = arg_43_1.delay,
		childIndex = arg_43_1.pathIndex,
		conditionData = arg_43_1.conditionData,
		callback = arg_43_2
	})

	return
end

function GuidePlayer:SearchWithoutDelay(arg_44_1, arg_44_2)
	self.uiFinder:SearchWithoutDelay({
		path = arg_44_1.path,
		delay = arg_44_1.delay,
		childIndex = arg_44_1.pathIndex,
		conditionData = arg_44_1.conditionData,
		callback = arg_44_2
	})

	return
end

function GuidePlayer:RegisterEvent(arg_45_1, arg_45_2)
	if arg_45_1:ExistTrigger() then
		removeOnButton(self._tf)
		arg_45_2()

		return
	end

	onButton(pg.NewGuideMgr.GetInstance(), self._tf, function()
		if arg_45_1:ShouldGoScene() then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE[arg_45_1.sceneName])
			arg_45_2()
		elseif arg_45_1:ShouldTriggerOtherTarget() then
			self:SearchUI(arg_45_1:GetOtherTriggerTarget(), function(arg_47_0)
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

function GuidePlayer:NextOne()
	triggerButton(self._tf)

	return
end

function GuidePlayer:HideCounsellors()
	for iter_49_0, iter_49_1 in pairs(self.counsellors) do
		setActive(iter_49_1, false)
	end

	return
end

function GuidePlayer:Clear()
	self:HideCounsellors()
	self:HideDialogueWindows()
	self:ClearSpriteTimer()
	setActive(self.maskTr, false)
	removeOnButton(self._tf)
	self:OnClear()

	if self.delayTimer then
		self.delayTimer:Stop()

		self.delayTimer = nil
	end

	self.uiFinder:Clear()
	self.uiDuplicator:Clear()
	self.uiLoader:Clear()
	self.uiFloatCollctor:Clear()

	return
end

function GuidePlayer:OnExecution(arg_51_1, arg_51_2)
	arg_51_2()

	return
end

function GuidePlayer:OnClear()
	return
end

return GuidePlayer
