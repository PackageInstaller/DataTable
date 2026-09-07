local StoryPlayer = class("StoryPlayer", import("..animation.StoryAnimtion"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6
local var_0_8 = 7
local var_0_9 = 0
local var_0_10 = 1
local var_0_11 = 2

function StoryPlayer:Ctor(arg_1_1)
	StoryPlayer.super.Ctor(self)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.animationPlayer = self._tf:GetComponent(typeof(Animation))
	self.front = self._tf:Find("front")
	self.actorTr = self._tf:Find("actor")
	self.frontTr = self._tf:Find("front")
	self.backPanel = self._tf:Find("back")
	self.goCG = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.asidePanel = self._tf:Find("front/aside_panel")
	self.bgGlitch = self._tf:Find("back/bg_glitch")
	self.oldPhoto = self._tf:Find("front/oldphoto"):GetComponent(typeof(Image))
	self.bgPanel = self._tf:Find("back/bg")
	self.bgPanelCg = self.bgPanel:GetComponent(typeof(CanvasGroup))

	setActive(self._tf:Find("back/bg/sub"), false)

	self.bgImage = self.bgPanel:Find("image"):GetComponent(typeof(Image))
	self.mainImg = self._tf:GetComponent(typeof(Image))
	self.castPanel = self._tf:Find("front/cast_panel")
	self.spAnimPanel = self._tf:Find("front/sp_anim_panel")
	self.centerPanel = self._tf:Find("center")
	self.actorPanel = self._tf:Find("actor")
	self.dialoguePanel = self._tf:Find("front/dialogue")
	self.effectPanel = self._tf:Find("front/effect")
	self.movePanel = self._tf:Find("front/move_layer")
	self.curtain = self._tf:Find("back/curtain")
	self.curtainCg = self.curtain:GetComponent(typeof(CanvasGroup))
	self.flash = self._tf:Find("front/flash")
	self.flashImg = self.flash:GetComponent(typeof(Image))
	self.flashCg = self.flash:GetComponent(typeof(CanvasGroup))
	self.curtainF = self._tf:Find("back/curtain_front")
	self.curtainFCg = self.curtainF:GetComponent(typeof(CanvasGroup))
	self.locationTr = self._tf:Find("front/location")
	self.locationTxt = self._tf:Find("front/location/Text"):GetComponent(typeof(Text))
	self.locationTrPos = self.locationTr.localPosition
	self.locationAnim = self.locationTr:GetComponent(typeof(Animation))
	self.locationAniEvent = self.locationTr:GetComponent(typeof(DftAniEvent))
	self.iconImage = self._tf:Find("front/icon"):GetComponent(typeof(Image))
	self.topEffectTr = self._tf:Find("top/effect")
	self.dialogueWin = nil
	self.bgs = {}
	self.branchCodeList = {}
	self.stop = false
	self.pause = false

	return
end

function StoryPlayer:Disable()
	setActive(self._tf, false)

	return
end

function StoryPlayer:Enable()
	setActive(self._tf, true)

	return
end

function StoryPlayer:StoryStart(arg_4_1)
	self.branchCodeList = {}

	eachChild(self.dialoguePanel, function(arg_5_0)
		setActive(arg_5_0, false)

		return
	end)

	self.dialogueWin = self.dialoguePanel:Find(arg_4_1:GetDialogueStyleName())

	setActive(self.dialogueWin, true)

	self.optionLUIlist = UIItemList.New(self.dialogueWin:Find("options_panel/options_l"), self.dialogueWin:Find("options_panel/options_l/option_tpl"))
	self.optionCUIlist = UIItemList.New(self.dialogueWin:Find("options_panel/options_c"), self.dialogueWin:Find("options_panel/options_c/option_tpl"))
	self.optionsCg = self.dialogueWin:Find("options_panel"):GetComponent(typeof(CanvasGroup))

	self:OnStart(arg_4_1)

	return
end

function StoryPlayer:GetOptionContainer(arg_6_1)
	if self.script:IsDialogueStyle2() then
		setActive(self.optionLUIlist.container, true)
		setActive(self.optionCUIlist.container, false)

		return self.optionLUIlist, true
	end

	if arg_6_1:GetOptionCnt() <= 3 or arg_6_1:IsOptionForceCenter() then
		setActive(self.optionLUIlist.container, false)
		setActive(self.optionCUIlist.container, true)

		return self.optionCUIlist, false
	else
		setActive(self.optionLUIlist.container, true)
		setActive(self.optionCUIlist.container, false)

		return self.optionLUIlist, true
	end

	return
end

function StoryPlayer:Pause()
	self.pause = true

	self:PauseAllAnimation()
	pg.ViewUtils.SetLayer(self.effectPanel, Layer.UIHidden)

	return
end

function StoryPlayer:Resume()
	self.pause = false

	self:ResumeAllAnimation()
	pg.ViewUtils.SetLayer(self.effectPanel, Layer.UI)

	return
end

function StoryPlayer:Stop()
	self.stop = true

	self:NextOneImmediately()

	return
end

function StoryPlayer:Play(arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 then
		arg_10_3()

		return
	end

	if arg_10_1:GetNextScriptName() or self.stop then
		arg_10_3()

		return
	end

	local var_10_0 = arg_10_1:GetStepByIndex(arg_10_2)

	if not var_10_0 then
		arg_10_3()

		return
	end

	if var_10_0:GetMode() == Story.MODE_SUBPAGE and not var_10_0:ShouldShowSubPage() then
		arg_10_3()

		return
	end

	pg.NewStoryMgr.GetInstance():AddRecord(var_10_0)

	if var_10_0:ShouldJumpToNextScript() then
		arg_10_1:SetNextScriptName(var_10_0:GetNextScriptName())
		arg_10_3()

		return
	end

	local var_10_1 = arg_10_1:ShouldSkipAll()

	if var_10_1 then
		self:ClearEffects()
	end

	local var_10_2 = false

	if var_10_1 and var_10_0:IsImport() then
		if not pg.NewStoryMgr.GetInstance():IsReView() then
			var_10_2 = true

			goto label_10_0
		end
	end

	if var_10_1 then
		arg_10_3()

		return
	end

	::label_10_0::

	self.script = arg_10_1
	self.callback = arg_10_3
	self.step = var_10_0
	self.autoNext = arg_10_1:GetAutoPlayFlag()
	self.stage = var_0_1

	local var_10_3 = arg_10_1:GetTriggerDelayTime()

	if self.autoNext and var_10_0:IsImport() and not var_10_0.optionSelCode then
		self.autoNext = nil
	end

	self:SetTimeScale(1 - arg_10_1:GetPlaySpeed() * 0.1)

	local var_10_4 = arg_10_1:GetPrevStep(arg_10_2)

	seriesAsync({
		function(arg_11_0)
			if not self:NextStage(var_0_2) then
				return
			end

			parallelAsync({
				function(arg_12_0)
					self:Reset(var_10_0, var_10_4, arg_12_0)
					self:UpdateBg(var_10_0)
					self:PlayBgm(var_10_0)

					return
				end,
				function(arg_13_0)
					self:LoadEffects(var_10_0, arg_13_0)

					return
				end,
				function(arg_14_0)
					self:ApplyEffects(var_10_0, arg_14_0)

					return
				end,
				function(arg_15_0)
					self:flashin(var_10_0, arg_15_0)

					return
				end
			}, arg_11_0)

			return
		end,
		function(arg_16_0)
			if var_10_2 then
				arg_10_1:StopSkip()
			end

			var_10_2 = false

			arg_16_0()

			return
		end,
		function(arg_17_0)
			if not self:NextStage(var_0_3) then
				return
			end

			parallelAsync({
				function(arg_18_0)
					self:OnInit(var_10_0, var_10_4, arg_18_0)

					return
				end,
				function(arg_19_0)
					self:PlaySoundEffect(var_10_0)
					self:StartUIAnimations(var_10_0, arg_19_0)

					return
				end,
				function(arg_20_0)
					self:OnEnter(var_10_0, var_10_4, arg_20_0)

					return
				end,
				function(arg_21_0)
					self:StartMoveNode(var_10_0, arg_21_0)

					return
				end,
				function(arg_22_0)
					self:UpdateIcon(var_10_0, arg_22_0)

					return
				end,
				function(arg_23_0)
					self:SetLocation(var_10_0, arg_23_0)

					return
				end,
				function(arg_24_0)
					if self:DispatcherEvent(var_10_0, arg_24_0) then
						self.autoNext = true
						var_10_3 = 0
					end

					return
				end
			}, arg_17_0)

			return
		end,
		function(arg_25_0)
			self:ClearCheckDispatcher()

			if not self:NextStage(var_0_4) then
				return
			end

			if not var_10_0:ShouldDelayEvent() then
				arg_25_0()

				return
			end

			self:DelayCall(var_10_0:GetEventDelayTime(), arg_25_0)

			return
		end,
		function(arg_26_0)
			if not self:NextStage(var_0_5) then
				return
			end

			if self.skipOption then
				arg_26_0()

				return
			end

			if var_10_0:SkipEventForOption() then
				arg_26_0()

				return
			end

			if self:ShouldAutoTrigger() then
				self:UnscaleDelayCall(var_10_3, arg_26_0)

				return
			end

			self:RegisetEvent(var_10_0, arg_26_0)
			self:TriggerEventIfAuto(var_10_3)

			return
		end,
		function(arg_27_0)
			if not self:NextStage(var_0_6) then
				return
			end

			if not var_10_0:ExistOption() then
				arg_27_0()

				return
			end

			if self.skipOption then
				self.skipOption = false

				arg_27_0()

				return
			end

			self:InitBranches(arg_10_1, var_10_0, function(arg_28_0)
				arg_27_0()

				return
			end, function()
				self:TriggerOptionIfAuto(var_10_3, var_10_0)

				return
			end)

			return
		end,
		function(arg_30_0)
			if not self:NextStage(var_0_7) then
				return
			end

			self.autoNext = nil

			local var_30_0 = arg_10_1:GetNextStep(arg_10_2)

			seriesAsync({
				function(arg_31_0)
					self:ClearAnimation()
					self:ClearApplyEffect()
					self:OnWillExit(var_10_0, var_30_0, arg_31_0)

					return
				end,
				function(arg_32_0)
					parallelAsync({
						function(arg_33_0)
							if not var_30_0 then
								arg_33_0()

								return
							end

							self:Flashout(var_30_0, arg_33_0)

							return
						end,
						function(arg_34_0)
							if var_30_0 then
								arg_34_0()

								return
							end

							self:FadeOutStory(self.script, arg_34_0)

							return
						end
					}, arg_32_0)

					return
				end
			}, arg_30_0)

			return
		end,
		function(arg_35_0)
			if not self:NextStage(var_0_8) then
				return
			end

			self:OnWillClear(var_10_0)
			self:Clear(arg_35_0)

			return
		end
	}, arg_10_3)

	return
end

function StoryPlayer:NextStage(arg_36_1)
	if self.stage == arg_36_1 - 1 then
		self.stage = arg_36_1

		return true
	end

	return false
end

function StoryPlayer:ApplyEffects(arg_37_1, arg_37_2)
	if arg_37_1:ShouldShake() then
		self:ApplyShakeEffect(arg_37_1)
	end

	arg_37_2()

	return
end

function StoryPlayer:ApplyShakeEffect(arg_38_1)
	if not arg_38_1:ShouldShake() then
		return
	end

	self.animationPlayer:Play("anim_storyrecordUI_shake_loop")

	self.playingShakeAnim = true

	self:DelayCall(arg_38_1:GetShakeTime(), function()
		self:ClearShakeEffect()

		return
	end)

	return
end

function StoryPlayer:ClearShakeEffect()
	if self.playingShakeAnim then
		self.animationPlayer:Play("anim_storyrecordUI_shake_reset")

		self.playingShakeAnim = nil
	end

	return
end

function StoryPlayer:ClearApplyEffect()
	self:ClearShakeEffect()

	return
end

function StoryPlayer:DispatcherEvent(arg_42_1, arg_42_2)
	if not arg_42_1:ExistDispatcher() then
		arg_42_2()

		return
	end

	local var_42_0 = arg_42_1:GetDispatcher()

	pg.NewStoryMgr.GetInstance():ClearStoryEvent()

	local var_42_1 = {
		data = var_42_0.data,
		callbackData = var_42_0.callbackData
	}

	var_42_1.flags = self.branchCodeList[arg_42_1:GetId()] or {}

	pg.m02:sendNotification(var_42_0.name, var_42_1)

	if arg_42_1:ShouldHideUI() then
		setActive(self._tf, false)
	end

	if arg_42_1:IsRecallDispatcher() then
		self:CheckDispatcher(arg_42_1, arg_42_2)
	else
		arg_42_2()
	end

	return var_42_0.nextOne
end

function StoryPlayer:WaitForEvent()
	return self.checkTimer ~= nil
end

function StoryPlayer:CheckDispatcher(arg_44_1, arg_44_2)
	local var_44_0 = arg_44_1:GetDispatcherRecallName()

	self:ClearCheckDispatcher()

	self.checkTimer = Timer.New(function()
		if pg.NewStoryMgr.GetInstance():CheckStoryEvent(var_44_0) then
			local var_45_0 = pg.NewStoryMgr.GetInstance():GetStoryEventArg(var_44_0)

			if var_45_0 then
				existCall(var_45_0.notifiCallback)
			end

			if var_45_0 and var_45_0.optionIndex then
				self:SetBranchCode(self.script, arg_44_1, var_45_0.optionIndex)

				self.skipOption = true
			end

			if arg_44_1:ShouldHideUI() then
				setActive(self._tf, true)
			end

			self:ClearCheckDispatcher()
			arg_44_2()
		end

		return
	end, 1, -1)

	self.checkTimer:Start()
	self.checkTimer.func()

	return
end

function StoryPlayer:ClearCheckDispatcher()
	if self.checkTimer then
		self.checkTimer:Stop()

		self.checkTimer = nil
	end

	return
end

function StoryPlayer:TriggerEventIfAuto(arg_47_1)
	if not self:ShouldAutoTrigger() then
		return
	end

	self:UnscaleDelayCall(arg_47_1, function()
		if not self.autoNext then
			setButtonEnabled(self._go, true)

			return
		end

		triggerButton(self._go)

		return
	end)

	return
end

function StoryPlayer:TriggerOptionIfAuto(arg_49_1, arg_49_2)
	if not self:ShouldAutoTrigger() then
		return
	end

	if not arg_49_2 or not arg_49_2:ExistOption() then
		return
	end

	self:UnscaleDelayCall(arg_49_1, function()
		if not self.autoNext then
			return
		end

		local var_50_0 = arg_49_2:GetOptionIndexByAutoSel()

		if var_50_0 ~= nil then
			triggerButton((self:GetOptionContainer(arg_49_2).container:GetChild(var_50_0 - 1)))
		end

		return
	end)

	return
end

function StoryPlayer:ShouldAutoTrigger()
	if self.pause or self.stop then
		return false
	end

	return self.autoNext
end

function StoryPlayer:CanSkip()
	return self.step and not self.step:IsImport()
end

function StoryPlayer:CancelAuto()
	self.autoNext = false

	return
end

function StoryPlayer:NextOne()
	self.timeScale = 0.0001

	if self.stage == var_0_1 then
		self.autoNext = true
	elseif self.stage == var_0_5 then
		self.autoNext = true

		self:TriggerEventIfAuto(0)
	elseif self.stage == var_0_6 then
		self:TriggerOptionIfAuto(0, self.step)
	end

	return
end

function StoryPlayer:NextOneImmediately()
	if self.callback then
		self:ClearAnimation()
		self:Clear()
		self.callback()
	end

	return
end

function StoryPlayer:SetLocation(arg_56_1, arg_56_2)
	if not arg_56_1:ExistLocation() then
		self.locationAniEvent:SetEndEvent(nil)
		arg_56_2()

		return
	end

	setActive(self.locationTr, true)

	local var_56_0 = arg_56_1:GetLocation()

	self.locationTxt.text = var_56_0.text

	local function var_56_1()
		self:DelayCall(var_56_0.time, function()
			self.locationAnim:Play("anim_newstoryUI_iocation_out")

			self.locationStatus = var_0_11

			return
		end)

		return
	end

	self.locationAniEvent:SetEndEvent(function()
		if self.locationStatus == var_0_10 then
			var_56_1()
			arg_56_2()
		elseif self.locationStatus == var_0_11 then
			setActive(self.locationTr, false)

			self.locationStatus = var_0_9
		end

		return
	end)
	self.locationAnim:Play("anim_newstoryUI_iocation_in")

	self.locationStatus = var_0_10

	return
end

function StoryPlayer:UpdateIcon(arg_60_1, arg_60_2)
	if not arg_60_1:ExistIcon() then
		setActive(self.iconImage.gameObject, false)
		arg_60_2()

		return
	end

	local var_60_0 = arg_60_1:GetIconData()

	self.iconImage.sprite = LoadSprite(var_60_0.image)

	self.iconImage:SetNativeSize()

	local var_60_1 = self.iconImage.gameObject.transform

	var_60_1.localPosition = var_60_0.pos and Vector3(var_60_0.pos[1], var_60_0.pos[2], 0) or Vector3.one
	var_60_1.localScale = Vector3(var_60_0.scale or 1, var_60_0.scale or 1, 1)

	setActive(self.iconImage.gameObject, true)
	arg_60_2()

	return
end

function StoryPlayer:UpdateOptionTxt(arg_61_1, arg_61_2, arg_61_3, arg_61_4)
	local var_61_0 = arg_61_2:GetComponent(typeof(LayoutElement))
	local var_61_1 = arg_61_2:Find("content")

	if arg_61_1 then
		local var_61_2 = arg_61_2:Find("content_max")
		local var_61_3 = GetPerceptualSize(arg_61_3) >= 17
		local var_61_4 = var_61_3 and var_61_2 or var_61_1

		setActive(var_61_1, not var_61_3)
		setActive(var_61_2, var_61_3)
		setText(var_61_4:Find("Text"), arg_61_3)

		var_61_0.preferredHeight = var_61_4.rect.height
	else
		setText(var_61_1:Find("Text"), arg_61_3)

		var_61_0.preferredHeight = var_61_1.rect.height
	end

	self:UpdateOptionBGWithTB(var_61_1, arg_61_4)

	return
end

function StoryPlayer:UpdateOptionBGWithTB(arg_62_1, arg_62_2)
	local var_62_0 = getProxy(NewEducateProxy):GetCurChar()
	local var_62_1 = arg_62_1:Find("type1")
	local var_62_2 = arg_62_1:Find("type2")

	if var_62_1 then
		setActive(var_62_1, false)
	end

	if var_62_2 then
		setActive(var_62_2, false)
	end

	if var_62_0 and var_62_1 then
		local var_62_3 = arg_62_2 and arg_62_2 == 1

		if arg_62_2 and arg_62_2 == 1 then
			LoadImageSpriteAsync("neweducateicon/" .. var_62_0:GetPersonalityTagOptionBg(arg_62_2), var_62_1)
		end

		setActive(var_62_1, var_62_3)
	end

	if var_62_0 and var_62_2 then
		local var_62_4 = arg_62_2 and arg_62_2 == 2

		if arg_62_2 and arg_62_2 == 2 then
			LoadImageSpriteAsync("neweducateicon/" .. var_62_0:GetPersonalityTagOptionBg(arg_62_2), var_62_2)
		end

		setActive(var_62_2, var_62_4)
	end

	if arg_62_1:Find("type3") then
		if arg_62_2 and arg_62_2 == 3 then
			arg_62_1:Find("Text").localPosition = Vector2(20, 0)

			setActive(arg_62_1:Find("type3"), true)
		else
			arg_62_1:Find("Text").localPosition = Vector2.zero

			setActive(arg_62_1:Find("type3"), false)
		end
	end

	if arg_62_2 and arg_62_2 == 3 and arg_62_1:Find("icon") then
		setActive(arg_62_1:Find("icon"), false)
		setImageSprite(arg_62_1, (GetSpriteFromAtlas("ui/story_atlas", "option_bg_left_global")))
	end

	return
end

function StoryPlayer:InitBranches(arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	local var_63_0 = false
	local var_63_1 = arg_63_2:GetOptions()
	local var_63_2, var_63_3 = self:GetOptionContainer(arg_63_2)
	local var_63_4 = self.branchCodeList[arg_63_2:GetId()] or {}
	local var_63_5 = GetOrAddComponent(var_63_2.container, typeof(CanvasGroup))

	var_63_5.blocksRaycasts = true
	self.selectedBranchID = nil

	var_63_2:make(function(arg_64_0, arg_64_1, arg_64_2)
		if arg_64_0 == UIItemList.EventUpdate then
			local var_64_0 = arg_64_2
			local var_64_1 = var_63_1[arg_64_1 + 1][1]
			local var_64_2 = var_63_1[arg_64_1 + 1][2]
			local var_64_4 = var_63_1[arg_64_1 + 1][4]
			local var_64_5 = table.contains(var_63_4, var_63_1[arg_64_1 + 1][2])

			onButton(self, arg_64_2, function()
				if self.pause or self.stop then
					return
				end

				if not var_63_0 then
					return
				end

				self.selectedBranchID = arg_64_1

				self:SetBranchCode(arg_63_1, arg_63_2, var_64_2)

				if var_64_4 then
					self:SetGlobalOptionFlag(var_64_4)
				end

				pg.NewStoryMgr.GetInstance():TrackingOption(arg_63_2:GetOptionIndex(), var_64_2)

				local var_65_0 = arg_64_2:GetComponent(typeof(Animation))

				if var_65_0 then
					var_63_5.blocksRaycasts = false

					var_65_0:Play(self.script:GetAnimPrefix() .. "confirm")
					arg_64_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
						setActive(self.optionsCg.gameObject, false)

						var_63_5.blocksRaycasts = true

						self:HideBranchesWithoutSelected(arg_63_2)
						arg_63_3(var_64_1)

						return
					end)
				else
					setActive(self.optionsCg.gameObject, false)
					self:HideBranchesWithoutSelected(arg_63_2)
					arg_63_3(var_64_1)
				end

				return
			end, SFX_PANEL)
			setButtonEnabled(var_64_0, not var_64_5)

			GetOrAddComponent(arg_64_2, typeof(CanvasGroup)).alpha = var_64_5 and 0.5 or 1

			self:UpdateOptionTxt(var_63_3, var_64_0, var_64_1, (var_64_4 or nil) and 3)

			if self.script:IsDialogueStyle2() then
				setActive(var_64_0, arg_64_1 == 0)

				if arg_64_1 > 0 then
					LeanTween.delayedCall(0.066 * arg_64_1, System.Action(function()
						setActive(var_64_0, true)

						return
					end))
				end
			end
		end

		return
	end)
	var_63_2:align(#var_63_1)
	self:ShowBranches(arg_63_2, function()
		var_63_0 = true

		if arg_63_4 then
			arg_63_4()
		end

		return
	end)

	return
end

function StoryPlayer:SetBranchCode(arg_69_1, arg_69_2, arg_69_3)
	arg_69_2:SetBranchCode(arg_69_3)
	arg_69_1:SetBranchCode(arg_69_3)

	local var_69_0 = arg_69_2:GetId()

	self.branchCodeList[var_69_0] = self.branchCodeList[var_69_0] or {}

	table.insert(self.branchCodeList[var_69_0], arg_69_3)

	return
end

function StoryPlayer:SetGlobalOptionFlag(arg_70_1)
	PlayerPrefs.SetInt(StoryStep.GetGlobalFlagKey(arg_70_1.flagID) .. arg_70_1.flagIndex, arg_70_1.flagValue)

	return
end

function StoryPlayer:ShowBranches(arg_71_1, arg_71_2)
	setActive(self.optionsCg.gameObject, true)

	local var_71_0 = self:GetOptionContainer(arg_71_1)

	for iter_71_0 = 0, var_71_0.container.childCount - 1 do
		local var_71_1 = var_71_0.container:GetChild(iter_71_0):GetComponent(typeof(Animation))

		if var_71_1 then
			var_71_1:Play(self.script:GetAnimPrefix() .. "in")
		end
	end

	arg_71_2()

	return
end

function StoryPlayer:HideBranchesWithoutSelected(arg_72_1)
	local var_72_0 = self:GetOptionContainer(arg_72_1)

	for iter_72_0 = 0, var_72_0.container.childCount - 1 do
		if iter_72_0 ~= self.selectedBranchID then
			local var_72_1 = var_72_0.container:GetChild(iter_72_0):GetComponent(typeof(Animation))

			if var_72_1 then
				var_72_1:Play(self.script:GetAnimPrefix() .. "unselected")
			end
		end
	end

	return
end

function StoryPlayer:StartMoveNode(arg_73_1, arg_73_2)
	if not arg_73_1:ExistMovableNode() then
		arg_73_2()

		return
	end

	local var_73_0 = arg_73_1:GetMovableNode()
	local var_73_1 = {}
	local var_73_2 = {}

	for iter_73_0, iter_73_1 in pairs(var_73_0) do
		table.insert(var_73_1, function(arg_74_0)
			self:LoadMovableNode(iter_73_1, function(arg_75_0)
				var_73_2[iter_73_0] = arg_75_0

				arg_74_0()

				return
			end)

			return
		end)
	end

	parallelAsync(var_73_1, function()
		self:MoveAllNode(arg_73_1, var_73_2, var_73_0)
		arg_73_2()

		return
	end)

	return
end

function StoryPlayer:MoveAllNode(arg_77_1, arg_77_2, arg_77_3)
	local var_77_0 = {}

	for iter_77_0, iter_77_1 in pairs(arg_77_2) do
		table.insert(var_77_0, function(arg_78_0)
			self:moveLocalPath(iter_77_1, arg_77_3[iter_77_0].path, arg_77_3[iter_77_0].time, arg_77_3[iter_77_0].delay, arg_77_3[iter_77_0].easeType, arg_78_0)

			return
		end)
	end

	self.moveTargets = arg_77_2

	parallelAsync(var_77_0, function()
		self:ClearMoveNodes(arg_77_1)

		return
	end)

	return
end

local function var_0_12(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4)
	arg_80_0.spineChar = SpineAnimChar.New()

	arg_80_0.spineChar:SetPaint(arg_80_1)
	arg_80_0.spineChar:Load(true, function(arg_81_0)
		arg_81_0:SetParent(arg_80_0.movePanel)
		arg_81_0:SetLocalScale(Vector3(arg_80_2.scale, arg_80_2.scale, 0))
		arg_81_0:SetLocalPosition(arg_80_3)
		arg_81_0:SetAction(arg_80_2.action, 0)
		arg_81_0:SetName(arg_80_1)

		if arg_80_4 then
			arg_80_4(arg_80_0.spineChar:GetModel())
		end

		return
	end)

	return
end

local function var_0_13(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	local var_82_0 = GameObject.New("movable")

	var_82_0.transform:SetParent(arg_82_0.movePanel)

	var_82_0.transform.localScale = Vector3.zero

	local var_82_1 = GetOrAddComponent(var_82_0, typeof(RectTransform))
	local var_82_2 = GetOrAddComponent(var_82_0, typeof(Image))

	LoadSpriteAsync(arg_82_1, function(arg_83_0)
		var_82_2.sprite = arg_83_0

		var_82_2:SetNativeSize()

		var_82_1.localScale = Vector3.one
		var_82_1.localPosition = arg_82_2

		arg_82_3(var_82_1.gameObject)

		return
	end)

	return
end

function StoryPlayer:LoadMovableNode(arg_84_1, arg_84_2)
	local var_84_0 = arg_84_1.path[1] or Vector3.zero

	if arg_84_1.isSpine then
		var_0_12(self, arg_84_1.name, arg_84_1.spineData, var_84_0, arg_84_2)
	else
		var_0_13(self, arg_84_1.name, var_84_0, arg_84_2)
	end

	return
end

function StoryPlayer:ClearMoveNodes(arg_85_1)
	if not arg_85_1:ExistMovableNode() then
		return
	end

	if self.movePanel.childCount <= 0 then
		return
	end

	for iter_85_0, iter_85_1 in ipairs(self.moveTargets or {}) do
		if iter_85_1:GetComponent(typeof(SpineAnimUI)) ~= nil then
			PoolMgr.GetInstance():ReturnSpineChar(iter_85_1.name, iter_85_1.gameObject)
		else
			Destroy(self.movePanel:GetChild(iter_85_0 - 1))
		end
	end

	self.moveTargets = {}

	return
end

function StoryPlayer:FadeOutStory(arg_86_1, arg_86_2)
	if not arg_86_1:ShouldFadeout() then
		arg_86_2()

		return
	end

	local var_86_0 = arg_86_1:GetFadeoutTime()

	if not arg_86_1:ShouldWaitFadeout() then
		self:fadeTransform(self._go, 1, 0.3, var_86_0, true)
		arg_86_2()
	else
		self:fadeTransform(self._go, 1, 0.3, var_86_0, true, arg_86_2)
	end

	return
end

function StoryPlayer:GetFadeColor(arg_87_1)
	local var_87_0 = {}
	local var_87_1 = {}

	for iter_87_0, iter_87_1 in ipairs((arg_87_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		local var_87_2 = {
			name = "_Color",
			color = Color.white
		}

		if iter_87_1.material.shader.name == "UI/GrayScale" then
			var_87_2 = {
				name = "_GrayScale",
				color = Color.New(0.21176470588235294, 0.7137254901960784, 0.07058823529411765)
			}
		elseif iter_87_1.material.shader.name == "UI/Line_Add_Blue" then
			var_87_2 = {
				name = "_GrayScale",
				color = Color.New(1, 1, 1, 0.5882352941176471)
			}
		end

		table.insert(var_87_1, var_87_2)

		if iter_87_1.material == iter_87_1.defaultGraphicMaterial then
			iter_87_1.material = Material.Instantiate(iter_87_1.defaultGraphicMaterial)
		end

		table.insert(var_87_0, iter_87_1.material)
	end

	return var_87_0, var_87_1
end

function StoryPlayer:_SetFadeColor(arg_88_1, arg_88_2, arg_88_3)
	for iter_88_0, iter_88_1 in ipairs(arg_88_1) do
		if not IsNil(iter_88_1) then
			iter_88_1:SetColor(arg_88_2[iter_88_0].name, arg_88_2[iter_88_0].color * Color.New(arg_88_3, arg_88_3, arg_88_3))
		end
	end

	return
end

function StoryPlayer:SetFadeColor(arg_89_1, arg_89_2)
	local var_89_0, var_89_1 = self:GetFadeColor(arg_89_1)

	self:_SetFadeColor(var_89_0, var_89_1, arg_89_2)

	return
end

function StoryPlayer:_RevertFadeColor(arg_90_1, arg_90_2)
	self:_SetFadeColor(arg_90_1, arg_90_2, 1)

	return
end

function StoryPlayer:RevertFadeColor(arg_91_1)
	local var_91_0, var_91_1 = self:GetFadeColor(arg_91_1)

	self:_RevertFadeColor(var_91_0, var_91_1)

	return
end

function StoryPlayer:fadeTransform(arg_92_1, arg_92_2, arg_92_3, arg_92_4, arg_92_5, arg_92_6)
	if arg_92_4 <= 0 then
		if arg_92_6 then
			arg_92_6()
		end

		return
	end

	local var_92_0, var_92_1 = self:GetFadeColor(arg_92_1)

	LeanTween.value(go(arg_92_1), arg_92_2, arg_92_3, arg_92_4):setOnUpdate(System.Action_float(function(arg_93_0)
		self:_SetFadeColor(var_92_0, var_92_1, arg_93_0)

		return
	end)):setOnComplete(System.Action(function()
		if arg_92_5 then
			self:_RevertFadeColor(var_92_0, var_92_1)
		end

		if arg_92_6 then
			arg_92_6()
		end

		return
	end))

	return
end

function StoryPlayer:setPaintingAlpha(arg_95_1, arg_95_2)
	local var_95_0 = {}
	local var_95_1 = {}

	for iter_95_0, iter_95_1 in ipairs((arg_95_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		local var_95_2 = {
			name = "_Color",
			color = Color.white
		}

		if iter_95_1.material.shader.name == "UI/GrayScale" then
			var_95_2 = {
				name = "_GrayScale",
				color = Color.New(0.21176470588235294, 0.7137254901960784, 0.07058823529411765)
			}
		elseif iter_95_1.material.shader.name == "UI/Line_Add_Blue" then
			var_95_2 = {
				name = "_GrayScale",
				color = Color.New(1, 1, 1, 0.5882352941176471)
			}
		end

		table.insert(var_95_1, var_95_2)

		if iter_95_1.material == iter_95_1.defaultGraphicMaterial then
			iter_95_1.material = Material.Instantiate(iter_95_1.defaultGraphicMaterial)
		end

		table.insert(var_95_0, iter_95_1.material)
	end

	for iter_95_2, iter_95_3 in ipairs(var_95_0) do
		if not IsNil(iter_95_3) then
			iter_95_3:SetColor(var_95_1[iter_95_2].name, var_95_1[iter_95_2].color * Color.New(arg_95_2, arg_95_2, arg_95_2))
		end
	end

	return
end

function StoryPlayer:RegisetEvent(arg_96_1, arg_96_2)
	setButtonEnabled(self._go, not self.autoNext)
	onButton(self, self._go, function()
		if self.pause or self.stop then
			return
		end

		removeOnButton(self._go)
		arg_96_2()

		return
	end, SFX_PANEL)

	return
end

function StoryPlayer:flashEffect(arg_98_1, arg_98_2, arg_98_3, arg_98_4, arg_98_5, arg_98_6)
	self.flashImg.color = arg_98_4 and Color(0, 0, 0) or Color(1, 1, 1)
	self.flashCg.alpha = arg_98_1

	setActive(self.flash, true)
	self:TweenValueForcanvasGroup(self.flashCg, arg_98_1, arg_98_2, arg_98_3, arg_98_5, arg_98_6)

	return
end

function StoryPlayer:Flashout(arg_99_1, arg_99_2)
	local var_99_0, var_99_1, var_99_2, var_99_3 = arg_99_1:GetFlashoutData()

	if not var_99_0 then
		arg_99_2()

		return
	end

	self:flashEffect(var_99_0, var_99_1, var_99_2, var_99_3, 0, arg_99_2)

	return
end

function StoryPlayer:flashin(arg_100_1, arg_100_2)
	local var_100_0, var_100_1, var_100_2, var_100_3, var_100_4 = arg_100_1:GetFlashinData()

	if not var_100_0 then
		arg_100_2()

		return
	end

	self:flashEffect(var_100_0, var_100_1, var_100_2, var_100_3, var_100_4, arg_100_2)

	return
end

function StoryPlayer:UpdateBg(arg_101_1)
	if arg_101_1:ShouldBgGlitchArt() then
		self:SetBgGlitchArt(arg_101_1)
	else
		local var_101_0 = arg_101_1:GetBgName()

		if var_101_0 then
			setActive(self.bgPanel, true)

			self.bgPanelCg.alpha = 1
			self.bgImage.color = Color.New(1, 1, 1)
			self.bgImage.sprite = self:GetBg(var_101_0)
		end

		local var_101_1 = arg_101_1:GetBgShadow()

		if var_101_1 then
			local var_101_2 = self.bgImage

			self:TweenValue(self.bgImage, var_101_1[1], var_101_1[2], var_101_1[3], 0, function(arg_102_0)
				var_101_2.color = Color.New(arg_102_0, arg_102_0, arg_102_0)

				return
			end, nil)
		end

		if arg_101_1:IsBlackBg() then
			setActive(self.curtain, true)

			self.curtainCg.alpha = 1
		end

		local var_101_3, var_101_4 = arg_101_1:IsBlackFrontGround()

		if var_101_3 then
			self.curtainFCg.alpha = var_101_4
		end

		setActive(self.curtainF, var_101_3)
	end

	self:ApplyOldPhotoEffect(arg_101_1)
	self:OnBgUpdate(arg_101_1)

	self.curtain:GetComponent(typeof(Image)).color = arg_101_1:GetBgColor()

	return
end

function StoryPlayer:ApplyOldPhotoEffect(arg_103_1)
	local var_103_0 = arg_103_1:OldPhotoEffect()
	local var_103_1 = var_103_0 ~= nil

	setActive(self.oldPhoto.gameObject, var_103_0 ~= nil)

	if var_103_1 then
		self.oldPhoto.color = type(var_103_0) == "table" and Color.New(var_103_0[1], var_103_0[2], var_103_0[3], var_103_0[4]) or Color.New(0.62, 0.58, 0.14, 0.36)
	end

	return
end

function StoryPlayer:SetBgGlitchArt(arg_104_1)
	setActive(self.bgPanel, false)
	setActive(self.bgGlitch, true)

	return
end

function StoryPlayer:GetBg(arg_105_1)
	self.bgs[arg_105_1] = self.bgs[arg_105_1] or LoadSprite("bg/" .. arg_105_1)

	return self.bgs[arg_105_1]
end

function StoryPlayer:LoadEffects(arg_106_1, arg_106_2)
	local var_106_0 = arg_106_1:GetEffects()

	if #var_106_0 <= 0 then
		arg_106_2()

		return
	end

	local var_106_1 = {}

	for iter_106_0, iter_106_1 in ipairs(var_106_0) do
		local var_106_2 = iter_106_1.name
		local var_106_3 = iter_106_1.active
		local var_106_4 = iter_106_1.interlayer
		local var_106_5 = iter_106_1.center
		local var_106_6 = iter_106_1.adapt
		local var_106_7 = self.effectPanel:Find(iter_106_1.name) or self.centerPanel:Find(var_106_2)

		if var_106_7 then
			setActive(var_106_7, var_106_3)
			setParent(var_106_7, (iter_106_1.center or nil) and (self.centerPanel or self.effectPanel.transform))

			if var_106_4 then
				self:UpdateEffectInterLayer(var_106_2, var_106_7)
			end

			if not var_106_3 then
				self:ClearEffectInterlayer(var_106_2)
			elseif isActive(var_106_7) then
				setActive(var_106_7, false)
				setActive(var_106_7, true)
			end

			if var_106_6 then
				self:AdaptEffect(var_106_7)
			end
		else
			local var_106_8 = ""

			if checkABExist("ui/" .. var_106_2) then
				var_106_8 = "ui"
			elseif checkABExist("effect/" .. var_106_2) then
				var_106_8 = "effect"
			end

			if var_106_8 and var_106_8 ~= "" then
				table.insert(var_106_1, function(arg_107_0)
					LoadAndInstantiateAsync(var_106_8, var_106_2, function(arg_108_0)
						setParent(arg_108_0, (var_106_5 or nil) and (self.centerPanel or self.effectPanel.transform))

						arg_108_0.transform.localScale = Vector3.one

						setActive(arg_108_0, var_106_3)

						arg_108_0.name = var_106_2

						if var_106_4 then
							self:UpdateEffectInterLayer(var_106_2, arg_108_0)
						end

						if var_106_3 == false then
							self:ClearEffectInterlayer(var_106_2)
						end

						if var_106_6 then
							self:AdaptEffect(arg_108_0)
						end

						arg_107_0()

						return
					end)

					return
				end)
			else
				originalPrint("not found effect", var_106_2)
			end
		end
	end

	parallelAsync(var_106_1, arg_106_2)

	return
end

function StoryPlayer:AdaptEffect(arg_109_1)
	local var_109_0 = pg.UIMgr.GetInstance().OverlayMain.parent.sizeDelta
	local var_109_1 = 1

	var_109_1 = 1.7777777777777777 < var_109_0.x / var_109_0.y and var_109_0.x / var_109_0.y / 1.7777777777777777 or 1.7777777777777777 / (var_109_0.x / var_109_0.y)
	tf(arg_109_1).localScale = Vector3(var_109_1, var_109_1, var_109_1)

	return
end

function StoryPlayer:UpdateEffectInterLayer(arg_110_1, arg_110_2)
	local var_110_0 = self._go:GetComponent(typeof(Canvas)).sortingOrder

	for iter_110_0, iter_110_1 in ipairs((arg_110_2:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
		local var_110_1 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_110_1)

		if var_110_0 < var_110_1 then
			var_110_0 = var_110_1
		end
	end

	local var_110_2 = GetOrAddComponent(self.actorTr, typeof(Canvas))

	var_110_2.overrideSorting = true
	var_110_2.sortingOrder = var_110_0 + 1

	local var_110_3 = GetOrAddComponent(self.frontTr, typeof(Canvas))

	var_110_3.overrideSorting = true
	var_110_3.sortingOrder = var_110_0 + 1 + 1
	self.activeInterLayer = arg_110_1

	GetOrAddComponent(self.frontTr, typeof(GraphicRaycaster))

	return
end

function StoryPlayer:ClearEffectInterlayer(arg_111_1)
	if self.activeInterLayer == arg_111_1 then
		RemoveComponent(self.frontTr, "GraphicRaycaster")
		RemoveComponent(self.actorTr, "Canvas")
		RemoveComponent(self.frontTr, "Canvas")

		self.activeInterLayer = nil
	end

	return
end

function StoryPlayer:ClearEffects()
	removeAllChildren(self.effectPanel)
	removeAllChildren(self.centerPanel)

	if self.activeInterLayer ~= nil then
		self:ClearEffectInterlayer(self.activeInterLayer)
	end

	return
end

function StoryPlayer:PlaySoundEffect(arg_113_1)
	if arg_113_1:ShouldPlaySoundEffect() then
		local var_113_0, var_113_1 = arg_113_1:GetSoundeffect()

		self:DelayCall(var_113_1, function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_113_0)

			return
		end)
	end

	if arg_113_1:ShouldPlayVoice() then
		self:PlayVoice(arg_113_1)
	elseif arg_113_1:ShouldStopVoice() then
		self:StopVoice()
	end

	return
end

function StoryPlayer:StopVoice()
	if self.currentVoice then
		self.currentVoice:Stop(true)

		self.currentVoice = nil
	end

	return
end

function StoryPlayer:PlayVoice(arg_116_1)
	if self.voiceDelayTimer then
		self.voiceDelayTimer:Stop()

		self.voiceDelayTimer = nil
	end

	self:StopVoice()

	local var_116_0, var_116_1 = arg_116_1:GetVoice()
	local var_116_2

	var_116_2 = self:CreateDelayTimer(var_116_1, function()
		if var_116_2 then
			var_116_2:Stop()
		end

		if self.voiceDelayTimer then
			self.voiceDelayTimer = nil
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_116_0, function(arg_118_0)
			if arg_118_0 then
				self.currentVoice = arg_118_0.playback
			end

			return
		end)

		return
	end)
	self.voiceDelayTimer = nil

	return
end

function StoryPlayer:Reset(arg_119_1, arg_119_2, arg_119_3)
	setActive(self.spAnimPanel, false)
	setActive(self.castPanel, false)
	setActive(self.bgPanel, false)

	if arg_119_1 and arg_119_1:IsDialogueMode() and arg_119_2 and arg_119_2:IsDialogueMode() then
		-- block empty
	else
		setActive(self.dialoguePanel, false)
	end

	setActive(self.asidePanel, false)
	setActive(self.curtain, false)
	setActive(self.flash, false)
	setActive(self.optionsCg.gameObject, false)
	setActive(self.bgGlitch, false)
	setActive(self.locationTr, false)

	self.locationTr.localPosition = self.locationTrPos
	self.locationStatus = var_0_9
	self.flashCg.alpha = 1
	self.goCG.alpha = 1

	self.animationPlayer:Stop()
	self:OnReset(arg_119_1, arg_119_2, arg_119_3)

	return
end

function StoryPlayer:Clear(arg_120_1)
	if self.step then
		self:ClearMoveNodes(self.step)
	end

	self.bgs = {}
	self.skipOption = nil
	self.step = nil
	self.goCG.alpha = 1
	self.callback = nil
	self.autoNext = nil
	self.script = nil
	self.bgImage.sprite = nil

	self:OnClear()

	if arg_120_1 then
		arg_120_1()
	end

	pg.DelegateInfo.New(self)

	return
end

function StoryPlayer:StoryEnd(arg_121_1)
	setActive(self.iconImage.gameObject, false)

	self.iconImage.sprite = nil
	self.branchCodeList = {}
	self.stop = false
	self.pause = false

	if self.voiceDelayTimer then
		self.voiceDelayTimer:Stop()

		self.voiceDelayTimer = nil
	end

	if self.currentVoice then
		self.currentVoice:Stop(true)

		self.currentVoice = nil
	end

	self:ClearCheckDispatcher()
	self:ClearEffects()
	self:Clear()
	self:OnEnd(arg_121_1)

	return
end

function StoryPlayer:PlayBgm(arg_122_1)
	if arg_122_1:ShouldStopBgm() then
		self:StopBgm()
	end

	if arg_122_1:ShoulePlayBgm() then
		local var_122_0, var_122_1, var_122_2 = arg_122_1:GetBgmData()

		self:DelayCall(var_122_1, function()
			self:RevertBgmVolume()
			pg.BgmMgr.GetInstance():TempPlay(var_122_0)

			return
		end)

		if var_122_2 and var_122_2 > 0 then
			self.defaultBgmVolume = pg.CriMgr.GetInstance():getBGMVolume()

			pg.CriMgr.GetInstance():setBGMVolume(var_122_2)
		end
	end

	return
end

function StoryPlayer:StopBgm(arg_124_1)
	self:RevertBgmVolume()
	pg.BgmMgr.GetInstance():StopPlay()

	return
end

function StoryPlayer:RevertBgmVolume()
	if self.defaultBgmVolume then
		pg.CriMgr.GetInstance():setBGMVolume(self.defaultBgmVolume)

		self.defaultBgmVolume = nil
	end

	return
end

function StoryPlayer:StartUIAnimations(arg_126_1, arg_126_2)
	parallelAsync({
		function(arg_127_0)
			self:StartBlinkAnimation(arg_126_1, arg_127_0)

			return
		end,
		function(arg_128_0)
			self:StartBlinkWithColorAnimation(arg_126_1, arg_128_0)

			return
		end,
		function(arg_129_0)
			self:OnStartUIAnimations(arg_126_1, arg_129_0)

			return
		end
	}, arg_126_2)

	return
end

function StoryPlayer:StartBlinkAnimation(arg_130_1, arg_130_2)
	if arg_130_1:ShouldBlink() then
		local var_130_0 = arg_130_1:GetBlinkData()
		local var_130_1 = var_130_0.number
		local var_130_2 = var_130_0.dur
		local var_130_4 = var_130_0.alpha[1]
		local var_130_5 = var_130_0.alpha[2]
		local var_130_6 = var_130_0.wait

		self.flashImg.color = var_130_0.black and Color(0, 0, 0) or Color(1, 1, 1)

		setActive(self.flash, true)

		local var_130_8 = {}

		for iter_130_0 = 1, var_130_1 do
			table.insert(var_130_8, function(arg_131_0)
				self:TweenAlpha(self.flash, var_130_4, var_130_5, var_130_2 / 2, 0, function()
					self:TweenAlpha(self.flash, var_130_5, var_130_4, var_130_2 / 2, var_130_6, arg_131_0)

					return
				end)

				return
			end)
		end

		seriesAsync(var_130_8, function()
			setActive(self.flash, false)

			return
		end)
	end

	arg_130_2()

	return
end

function StoryPlayer:StartBlinkWithColorAnimation(arg_134_1, arg_134_2)
	if arg_134_1:ShouldBlinkWithColor() then
		local var_134_0 = arg_134_1:GetBlinkWithColorData()

		self.flashImg.color = Color(var_134_0.color[1], var_134_0.color[2], var_134_0.color[3], var_134_0.color[4])

		setActive(self.flash, true)

		local var_134_1 = {}

		for iter_134_0, iter_134_1 in ipairs(var_134_0.alpha) do
			local var_134_2 = iter_134_1[1]
			local var_134_3 = iter_134_1[2]
			local var_134_4 = iter_134_1[3]
			local var_134_5 = iter_134_1[4]

			table.insert(var_134_1, function(arg_135_0)
				self:TweenValue(self.flash, var_134_2, var_134_3, var_134_4, var_134_5, function(arg_136_0)
					self.flashCg.alpha = arg_136_0

					return
				end, arg_135_0)

				return
			end)
		end

		parallelAsync(var_134_1, function()
			setActive(self.flash, false)

			return
		end)
	end

	arg_134_2()

	return
end

function StoryPlayer:OnStart(arg_138_1)
	return
end

function StoryPlayer:OnReset(arg_139_1, arg_139_2, arg_139_3)
	arg_139_3()

	return
end

function StoryPlayer:OnBgUpdate(arg_140_1)
	return
end

function StoryPlayer:OnInit(arg_141_1, arg_141_2, arg_141_3)
	if arg_141_3 then
		arg_141_3()
	end

	return
end

function StoryPlayer:OnStartUIAnimations(arg_142_1, arg_142_2)
	if arg_142_2 then
		arg_142_2()
	end

	return
end

function StoryPlayer:OnEnter(arg_143_1, arg_143_2, arg_143_3)
	if arg_143_3 then
		arg_143_3()
	end

	return
end

function StoryPlayer:OnWillExit(arg_144_1, arg_144_2, arg_144_3)
	arg_144_3()

	return
end

function StoryPlayer:OnWillClear(arg_145_1)
	return
end

function StoryPlayer:OnClear()
	return
end

function StoryPlayer:OnEnd(arg_147_1)
	return
end

return StoryPlayer
