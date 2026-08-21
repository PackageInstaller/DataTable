local var_0_0 = class("StoryPlayer", import("..animation.StoryAnimtion"))
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

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.animationPlayer = arg_1_0._tf:GetComponent(typeof(Animation))
	arg_1_0.front = arg_1_0._tf:Find("front")
	arg_1_0.actorTr = arg_1_0._tf:Find("actor")
	arg_1_0.frontTr = arg_1_0._tf:Find("front")
	arg_1_0.backPanel = arg_1_0._tf:Find("back")
	arg_1_0.goCG = GetOrAddComponent(arg_1_0._tf, typeof(CanvasGroup))
	arg_1_0.asidePanel = arg_1_0._tf:Find("front/aside_panel")
	arg_1_0.bgGlitch = arg_1_0._tf:Find("back/bg_glitch")
	arg_1_0.oldPhoto = arg_1_0._tf:Find("front/oldphoto"):GetComponent(typeof(Image))
	arg_1_0.bgPanel = arg_1_0._tf:Find("back/bg")
	arg_1_0.bgPanelCg = arg_1_0.bgPanel:GetComponent(typeof(CanvasGroup))

	setActive(arg_1_0._tf:Find("back/bg/sub"), false)

	arg_1_0.bgImage = arg_1_0.bgPanel:Find("image"):GetComponent(typeof(Image))
	arg_1_0.mainImg = arg_1_0._tf:GetComponent(typeof(Image))
	arg_1_0.castPanel = arg_1_0._tf:Find("front/cast_panel")
	arg_1_0.spAnimPanel = arg_1_0._tf:Find("front/sp_anim_panel")
	arg_1_0.centerPanel = arg_1_0._tf:Find("center")
	arg_1_0.actorPanel = arg_1_0._tf:Find("actor")
	arg_1_0.dialoguePanel = arg_1_0._tf:Find("front/dialogue")
	arg_1_0.effectPanel = arg_1_0._tf:Find("front/effect")
	arg_1_0.movePanel = arg_1_0._tf:Find("front/move_layer")
	arg_1_0.curtain = arg_1_0._tf:Find("back/curtain")
	arg_1_0.curtainCg = arg_1_0.curtain:GetComponent(typeof(CanvasGroup))
	arg_1_0.flash = arg_1_0._tf:Find("front/flash")
	arg_1_0.flashImg = arg_1_0.flash:GetComponent(typeof(Image))
	arg_1_0.flashCg = arg_1_0.flash:GetComponent(typeof(CanvasGroup))
	arg_1_0.curtainF = arg_1_0._tf:Find("back/curtain_front")
	arg_1_0.curtainFCg = arg_1_0.curtainF:GetComponent(typeof(CanvasGroup))
	arg_1_0.locationTr = arg_1_0._tf:Find("front/location")
	arg_1_0.locationTxt = arg_1_0._tf:Find("front/location/Text"):GetComponent(typeof(Text))
	arg_1_0.locationTrPos = arg_1_0.locationTr.localPosition
	arg_1_0.locationAnim = arg_1_0.locationTr:GetComponent(typeof(Animation))
	arg_1_0.locationAniEvent = arg_1_0.locationTr:GetComponent(typeof(DftAniEvent))
	arg_1_0.iconImage = arg_1_0._tf:Find("front/icon"):GetComponent(typeof(Image))
	arg_1_0.topEffectTr = arg_1_0._tf:Find("top/effect")
	arg_1_0.dialogueWin = nil
	arg_1_0.bgs = {}
	arg_1_0.branchCodeList = {}
	arg_1_0.stop = false
	arg_1_0.pause = false

	return
end

function var_0_0.Disable(arg_2_0)
	setActive(arg_2_0._tf, false)

	return
end

function var_0_0.Enable(arg_3_0)
	setActive(arg_3_0._tf, true)

	return
end

function var_0_0.StoryStart(arg_4_0, arg_4_1)
	arg_4_0.branchCodeList = {}

	eachChild(arg_4_0.dialoguePanel, function(arg_5_0)
		setActive(arg_5_0, false)

		return
	end)

	arg_4_0.dialogueWin = arg_4_0.dialoguePanel:Find(arg_4_1:GetDialogueStyleName())

	setActive(arg_4_0.dialogueWin, true)

	arg_4_0.optionLUIlist = UIItemList.New(arg_4_0.dialogueWin:Find("options_panel/options_l"), arg_4_0.dialogueWin:Find("options_panel/options_l/option_tpl"))
	arg_4_0.optionCUIlist = UIItemList.New(arg_4_0.dialogueWin:Find("options_panel/options_c"), arg_4_0.dialogueWin:Find("options_panel/options_c/option_tpl"))
	arg_4_0.optionsCg = arg_4_0.dialogueWin:Find("options_panel"):GetComponent(typeof(CanvasGroup))

	arg_4_0:OnStart(arg_4_1)

	return
end

function var_0_0.GetOptionContainer(arg_6_0, arg_6_1)
	if arg_6_0.script:IsDialogueStyle2() then
		setActive(arg_6_0.optionLUIlist.container, true)
		setActive(arg_6_0.optionCUIlist.container, false)

		return arg_6_0.optionLUIlist, true
	end

	if arg_6_1:GetOptionCnt() <= 3 or arg_6_1:IsOptionForceCenter() then
		setActive(arg_6_0.optionLUIlist.container, false)
		setActive(arg_6_0.optionCUIlist.container, true)

		return arg_6_0.optionCUIlist, false
	else
		setActive(arg_6_0.optionLUIlist.container, true)
		setActive(arg_6_0.optionCUIlist.container, false)

		return arg_6_0.optionLUIlist, true
	end

	return
end

function var_0_0.Pause(arg_7_0)
	arg_7_0.pause = true

	arg_7_0:PauseAllAnimation()
	pg.ViewUtils.SetLayer(arg_7_0.effectPanel, Layer.UIHidden)

	return
end

function var_0_0.Resume(arg_8_0)
	arg_8_0.pause = false

	arg_8_0:ResumeAllAnimation()
	pg.ViewUtils.SetLayer(arg_8_0.effectPanel, Layer.UI)

	return
end

function var_0_0.Stop(arg_9_0)
	arg_9_0.stop = true

	arg_9_0:NextOneImmediately()

	return
end

function var_0_0.Play(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 then
		arg_10_3()

		return
	end

	if arg_10_1:GetNextScriptName() or arg_10_0.stop then
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
		arg_10_0:ClearEffects()
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

	arg_10_0.script = arg_10_1
	arg_10_0.callback = arg_10_3
	arg_10_0.step = var_10_0
	arg_10_0.autoNext = arg_10_1:GetAutoPlayFlag()
	arg_10_0.stage = var_0_1

	local var_10_3 = arg_10_1:GetTriggerDelayTime()

	if arg_10_0.autoNext and var_10_0:IsImport() and not var_10_0.optionSelCode then
		arg_10_0.autoNext = nil
	end

	arg_10_0:SetTimeScale(1 - arg_10_1:GetPlaySpeed() * 0.1)

	local var_10_4 = arg_10_1:GetPrevStep(arg_10_2)

	seriesAsync({
		function(arg_11_0)
			if not arg_10_0:NextStage(var_0_2) then
				return
			end

			parallelAsync({
				function(arg_12_0)
					arg_10_0:Reset(var_10_0, var_10_4, arg_12_0)
					arg_10_0:UpdateBg(var_10_0)
					arg_10_0:PlayBgm(var_10_0)

					return
				end,
				function(arg_13_0)
					arg_10_0:LoadEffects(var_10_0, arg_13_0)

					return
				end,
				function(arg_14_0)
					arg_10_0:ApplyEffects(var_10_0, arg_14_0)

					return
				end,
				function(arg_15_0)
					arg_10_0:flashin(var_10_0, arg_15_0)

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
			if not arg_10_0:NextStage(var_0_3) then
				return
			end

			parallelAsync({
				function(arg_18_0)
					arg_10_0:OnInit(var_10_0, var_10_4, arg_18_0)

					return
				end,
				function(arg_19_0)
					arg_10_0:PlaySoundEffect(var_10_0)
					arg_10_0:StartUIAnimations(var_10_0, arg_19_0)

					return
				end,
				function(arg_20_0)
					arg_10_0:OnEnter(var_10_0, var_10_4, arg_20_0)

					return
				end,
				function(arg_21_0)
					arg_10_0:StartMoveNode(var_10_0, arg_21_0)

					return
				end,
				function(arg_22_0)
					arg_10_0:UpdateIcon(var_10_0, arg_22_0)

					return
				end,
				function(arg_23_0)
					arg_10_0:SetLocation(var_10_0, arg_23_0)

					return
				end,
				function(arg_24_0)
					if arg_10_0:DispatcherEvent(var_10_0, arg_24_0) then
						arg_10_0.autoNext = true
						var_10_3 = 0
					end

					return
				end
			}, arg_17_0)

			return
		end,
		function(arg_25_0)
			arg_10_0:ClearCheckDispatcher()

			if not arg_10_0:NextStage(var_0_4) then
				return
			end

			if not var_10_0:ShouldDelayEvent() then
				arg_25_0()

				return
			end

			arg_10_0:DelayCall(var_10_0:GetEventDelayTime(), arg_25_0)

			return
		end,
		function(arg_26_0)
			if not arg_10_0:NextStage(var_0_5) then
				return
			end

			if arg_10_0.skipOption then
				arg_26_0()

				return
			end

			if var_10_0:SkipEventForOption() then
				arg_26_0()

				return
			end

			if arg_10_0:ShouldAutoTrigger() then
				arg_10_0:UnscaleDelayCall(var_10_3, arg_26_0)

				return
			end

			arg_10_0:RegisetEvent(var_10_0, arg_26_0)
			arg_10_0:TriggerEventIfAuto(var_10_3)

			return
		end,
		function(arg_27_0)
			if not arg_10_0:NextStage(var_0_6) then
				return
			end

			if not var_10_0:ExistOption() then
				arg_27_0()

				return
			end

			if arg_10_0.skipOption then
				arg_10_0.skipOption = false

				arg_27_0()

				return
			end

			arg_10_0:InitBranches(arg_10_1, var_10_0, function(arg_28_0)
				arg_27_0()

				return
			end, function()
				arg_10_0:TriggerOptionIfAuto(var_10_3, var_10_0)

				return
			end)

			return
		end,
		function(arg_30_0)
			if not arg_10_0:NextStage(var_0_7) then
				return
			end

			arg_10_0.autoNext = nil

			local var_30_0 = arg_10_1:GetNextStep(arg_10_2)

			seriesAsync({
				function(arg_31_0)
					arg_10_0:ClearAnimation()
					arg_10_0:ClearApplyEffect()
					arg_10_0:OnWillExit(var_10_0, var_30_0, arg_31_0)

					return
				end,
				function(arg_32_0)
					parallelAsync({
						function(arg_33_0)
							if not var_30_0 then
								arg_33_0()

								return
							end

							arg_10_0:Flashout(var_30_0, arg_33_0)

							return
						end,
						function(arg_34_0)
							if var_30_0 then
								arg_34_0()

								return
							end

							arg_10_0:FadeOutStory(arg_10_0.script, arg_34_0)

							return
						end
					}, arg_32_0)

					return
				end
			}, arg_30_0)

			return
		end,
		function(arg_35_0)
			if not arg_10_0:NextStage(var_0_8) then
				return
			end

			arg_10_0:OnWillClear(var_10_0)
			arg_10_0:Clear(arg_35_0)

			return
		end
	}, arg_10_3)

	return
end

function var_0_0.NextStage(arg_36_0, arg_36_1)
	if arg_36_0.stage == arg_36_1 - 1 then
		arg_36_0.stage = arg_36_1

		return true
	end

	return false
end

function var_0_0.ApplyEffects(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1:ShouldShake() then
		arg_37_0:ApplyShakeEffect(arg_37_1)
	end

	arg_37_2()

	return
end

function var_0_0.ApplyShakeEffect(arg_38_0, arg_38_1)
	if not arg_38_1:ShouldShake() then
		return
	end

	arg_38_0.animationPlayer:Play("anim_storyrecordUI_shake_loop")

	arg_38_0.playingShakeAnim = true

	arg_38_0:DelayCall(arg_38_1:GetShakeTime(), function()
		arg_38_0:ClearShakeEffect()

		return
	end)

	return
end

function var_0_0.ClearShakeEffect(arg_40_0)
	if arg_40_0.playingShakeAnim then
		arg_40_0.animationPlayer:Play("anim_storyrecordUI_shake_reset")

		arg_40_0.playingShakeAnim = nil
	end

	return
end

function var_0_0.ClearApplyEffect(arg_41_0)
	arg_41_0:ClearShakeEffect()

	return
end

function var_0_0.DispatcherEvent(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_1:ExistDispatcher() then
		arg_42_2()

		return
	end

	local var_42_0 = arg_42_1:GetDispatcher()

	pg.NewStoryMgr.GetInstance():ClearStoryEvent()

	;({
		data = var_42_0.data,
		callbackData = var_42_0.callbackData
	}).flags = arg_42_0.branchCodeList[arg_42_1:GetId()] or {}

	pg.m02:sendNotification(var_42_0.name, {
		data = var_42_0.data,
		callbackData = var_42_0.callbackData
	})

	if arg_42_1:ShouldHideUI() then
		setActive(arg_42_0._tf, false)
	end

	if arg_42_1:IsRecallDispatcher() then
		arg_42_0:CheckDispatcher(arg_42_1, arg_42_2)
	else
		arg_42_2()
	end

	return var_42_0.nextOne
end

function var_0_0.WaitForEvent(arg_43_0)
	return arg_43_0.checkTimer ~= nil
end

function var_0_0.CheckDispatcher(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_1:GetDispatcherRecallName()

	arg_44_0:ClearCheckDispatcher()

	arg_44_0.checkTimer = Timer.New(function()
		if pg.NewStoryMgr.GetInstance():CheckStoryEvent(var_44_0) then
			local var_45_0 = pg.NewStoryMgr.GetInstance():GetStoryEventArg(var_44_0)

			if var_45_0 then
				existCall(var_45_0.notifiCallback)
			end

			if var_45_0 and var_45_0.optionIndex then
				arg_44_0:SetBranchCode(arg_44_0.script, arg_44_1, var_45_0.optionIndex)

				arg_44_0.skipOption = true
			end

			if arg_44_1:ShouldHideUI() then
				setActive(arg_44_0._tf, true)
			end

			arg_44_0:ClearCheckDispatcher()
			arg_44_2()
		end

		return
	end, 1, -1)

	arg_44_0.checkTimer:Start()
	arg_44_0.checkTimer.func()

	return
end

function var_0_0.ClearCheckDispatcher(arg_46_0)
	if arg_46_0.checkTimer then
		arg_46_0.checkTimer:Stop()

		arg_46_0.checkTimer = nil
	end

	return
end

function var_0_0.TriggerEventIfAuto(arg_47_0, arg_47_1)
	if not arg_47_0:ShouldAutoTrigger() then
		return
	end

	arg_47_0:UnscaleDelayCall(arg_47_1, function()
		if not arg_47_0.autoNext then
			setButtonEnabled(arg_47_0._go, true)

			return
		end

		triggerButton(arg_47_0._go)

		return
	end)

	return
end

function var_0_0.TriggerOptionIfAuto(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_0:ShouldAutoTrigger() then
		return
	end

	if not arg_49_2 or not arg_49_2:ExistOption() then
		return
	end

	arg_49_0:UnscaleDelayCall(arg_49_1, function()
		if not arg_49_0.autoNext then
			return
		end

		local var_50_0 = arg_49_2:GetOptionIndexByAutoSel()

		if var_50_0 ~= nil then
			triggerButton((arg_49_0:GetOptionContainer(arg_49_2).container:GetChild(var_50_0 - 1)))
		end

		return
	end)

	return
end

function var_0_0.ShouldAutoTrigger(arg_51_0)
	if arg_51_0.pause or arg_51_0.stop then
		return false
	end

	return arg_51_0.autoNext
end

function var_0_0.CanSkip(arg_52_0)
	return arg_52_0.step and not arg_52_0.step:IsImport()
end

function var_0_0.CancelAuto(arg_53_0)
	arg_53_0.autoNext = false

	return
end

function var_0_0.NextOne(arg_54_0)
	arg_54_0.timeScale = 0.0001

	if arg_54_0.stage == var_0_1 then
		arg_54_0.autoNext = true
	elseif arg_54_0.stage == var_0_5 then
		arg_54_0.autoNext = true

		arg_54_0:TriggerEventIfAuto(0)
	elseif arg_54_0.stage == var_0_6 then
		arg_54_0:TriggerOptionIfAuto(0, arg_54_0.step)
	end

	return
end

function var_0_0.NextOneImmediately(arg_55_0)
	if arg_55_0.callback then
		arg_55_0:ClearAnimation()
		arg_55_0:Clear()
		arg_55_0.callback()
	end

	return
end

function var_0_0.SetLocation(arg_56_0, arg_56_1, arg_56_2)
	if not arg_56_1:ExistLocation() then
		arg_56_0.locationAniEvent:SetEndEvent(nil)
		arg_56_2()

		return
	end

	setActive(arg_56_0.locationTr, true)

	arg_56_0.locationTxt.text = arg_56_1:GetLocation().text

	local function var_56_0()
		arg_56_0:DelayCall(var_0.time, function()
			arg_56_0.locationAnim:Play("anim_newstoryUI_iocation_out")

			arg_56_0.locationStatus = var_0_11

			return
		end)

		return
	end

	arg_56_0.locationAniEvent:SetEndEvent(function()
		if arg_56_0.locationStatus == var_0_10 then
			var_56_0()
			arg_56_2()
		elseif arg_56_0.locationStatus == var_0_11 then
			setActive(arg_56_0.locationTr, false)

			arg_56_0.locationStatus = var_0_9
		end

		return
	end)
	arg_56_0.locationAnim:Play("anim_newstoryUI_iocation_in")

	arg_56_0.locationStatus = var_0_10

	return
end

function var_0_0.UpdateIcon(arg_60_0, arg_60_1, arg_60_2)
	if not arg_60_1:ExistIcon() then
		setActive(arg_60_0.iconImage.gameObject, false)
		arg_60_2()

		return
	end

	local var_60_0 = arg_60_1:GetIconData()

	arg_60_0.iconImage.sprite = LoadSprite(var_60_0.image)

	arg_60_0.iconImage:SetNativeSize()

	local var_60_1 = arg_60_0.iconImage.gameObject.transform

	var_60_1.localPosition = var_60_0.pos and Vector3(var_60_0.pos[1], var_60_0.pos[2], 0) or Vector3.one

	local var_60_3 = var_60_0.scale or 1
	local var_60_4 = var_60_0.scale or 1

	var_60_1.localScale = var_60_2(var_60_3, var_60_4, 1)

	setActive(arg_60_0.iconImage.gameObject, true)
	arg_60_2()

	return
end

function var_0_0.UpdateOptionTxt(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4)
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

	arg_61_0:UpdateOptionBGWithTB(var_61_1, arg_61_4)

	return
end

function var_0_0.UpdateOptionBGWithTB(arg_62_0, arg_62_1, arg_62_2)
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

function var_0_0.InitBranches(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	local var_63_0 = false
	local var_63_1 = arg_63_2:GetOptions()
	local var_63_2, var_63_3 = arg_63_0:GetOptionContainer(arg_63_2)
	local var_63_4

	if not arg_63_0.branchCodeList[arg_63_2:GetId()] then
		var_63_4 = {}
	end

	local var_63_5 = GetOrAddComponent(var_63_2.container, typeof(CanvasGroup))

	var_63_5.blocksRaycasts = true
	arg_63_0.selectedBranchID = nil

	var_63_2:make(function(arg_64_0, arg_64_1, arg_64_2)
		if arg_64_0 == UIItemList.EventUpdate then
			local var_64_0 = arg_64_2
			local var_64_1 = var_63_1[arg_64_1 + 1][1]
			local var_64_2 = var_63_1[arg_64_1 + 1][3]
			local var_64_3 = var_63_1[arg_64_1 + 1][4]
			local var_64_4 = table.contains(var_63_4, var_63_1[arg_64_1 + 1][2])

			onButton(arg_63_0, arg_64_2, function()
				if arg_63_0.pause or arg_63_0.stop then
					return
				end

				if not var_63_0 then
					return
				end

				arg_63_0.selectedBranchID = arg_64_1

				arg_63_0:SetBranchCode(arg_63_1, arg_63_2, var_0)

				if var_64_3 then
					arg_63_0:SetGlobalOptionFlag(var_64_3)
				end

				pg.NewStoryMgr.GetInstance():TrackingOption(arg_63_2:GetOptionIndex(), var_0)

				local var_65_0 = arg_64_2:GetComponent(typeof(Animation))

				if var_65_0 then
					var_63_5.blocksRaycasts = false

					var_65_0:Play(arg_63_0.script:GetAnimPrefix() .. "confirm")
					arg_64_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
						setActive(arg_63_0.optionsCg.gameObject, false)

						var_63_5.blocksRaycasts = true

						arg_63_0:HideBranchesWithoutSelected(arg_63_2)
						arg_63_3(var_64_1)

						return
					end)
				else
					setActive(arg_63_0.optionsCg.gameObject, false)
					arg_63_0:HideBranchesWithoutSelected(arg_63_2)
					arg_63_3(var_64_1)
				end

				return
			end, SFX_PANEL)
			setButtonEnabled(var_64_0, not var_64_4)

			GetOrAddComponent(arg_64_2, typeof(CanvasGroup)).alpha = var_64_4 and 0.5 or 1

			if var_64_3 then
				var_64_2 = 3
			end

			arg_63_0:UpdateOptionTxt(var_63_3, var_64_0, var_64_1, var_64_2)

			if arg_63_0.script:IsDialogueStyle2() then
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
	var_63_2:align(#arg_63_2:GetOptions())
	arg_63_0:ShowBranches(arg_63_2, function()
		var_63_0 = true

		if arg_63_4 then
			arg_63_4()
		end

		return
	end)

	return
end

function var_0_0.SetBranchCode(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	arg_69_2:SetBranchCode(arg_69_3)
	arg_69_1:SetBranchCode(arg_69_3)

	local var_69_0 = arg_69_2:GetId()

	arg_69_0.branchCodeList[var_69_0] = arg_69_0.branchCodeList[var_69_0] or {}

	table.insert(arg_69_0.branchCodeList[var_69_0], arg_69_3)

	return
end

function var_0_0.SetGlobalOptionFlag(arg_70_0, arg_70_1)
	PlayerPrefs.SetInt(StoryStep.GetGlobalFlagKey(arg_70_1.flagID) .. arg_70_1.flagIndex, arg_70_1.flagValue)

	return
end

function var_0_0.ShowBranches(arg_71_0, arg_71_1, arg_71_2)
	setActive(arg_71_0.optionsCg.gameObject, true)

	local var_71_0 = arg_71_0:GetOptionContainer(arg_71_1)

	for iter_71_0 = 0, var_71_0.container.childCount - 1 do
		local var_71_1 = var_71_0.container:GetChild(iter_71_0):GetComponent(typeof(Animation))

		if var_71_1 then
			var_71_1:Play(arg_71_0.script:GetAnimPrefix() .. "in")
		end
	end

	arg_71_2()

	return
end

function var_0_0.HideBranchesWithoutSelected(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0:GetOptionContainer(arg_72_1)

	for iter_72_0 = 0, var_72_0.container.childCount - 1 do
		if iter_72_0 ~= arg_72_0.selectedBranchID then
			local var_72_1 = var_72_0.container:GetChild(iter_72_0):GetComponent(typeof(Animation))

			if var_72_1 then
				var_72_1:Play(arg_72_0.script:GetAnimPrefix() .. "unselected")
			end
		end
	end

	return
end

function var_0_0.StartMoveNode(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0

	if not arg_73_1:ExistMovableNode() then
		arg_73_2()

		do return end

		var_73_0 = {}
	end

	for iter_73_0, iter_73_1 in pairs((arg_73_1:GetMovableNode())) do
		table.insert({}, function(arg_74_0)
			arg_73_0:LoadMovableNode(iter_73_1, function(arg_75_0)
				var_73_0[iter_73_0] = arg_75_0

				arg_74_0()

				return
			end)

			return
		end)
	end

	parallelAsync({}, function()
		arg_73_0:MoveAllNode(arg_73_1, var_73_0, var_0)
		arg_73_2()

		return
	end)

	return
end

function var_0_0.MoveAllNode(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	for iter_77_0, iter_77_1 in pairs(arg_77_2) do
		table.insert({}, function(arg_78_0)
			arg_77_0:moveLocalPath(iter_77_1, arg_77_3[iter_77_0].path, arg_77_3[iter_77_0].time, arg_77_3[iter_77_0].delay, arg_77_3[iter_77_0].easeType, arg_78_0)

			return
		end)
	end

	arg_77_0.moveTargets = arg_77_2

	parallelAsync({}, function()
		arg_77_0:ClearMoveNodes(arg_77_1)

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

function var_0_0.LoadMovableNode(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = arg_84_1.path[1] or Vector3.zero

	if arg_84_1.isSpine then
		var_0_12(arg_84_0, arg_84_1.name, arg_84_1.spineData, var_84_0, arg_84_2)
	else
		var_0_13(arg_84_0, arg_84_1.name, var_84_0, arg_84_2)
	end

	return
end

function var_0_0.ClearMoveNodes(arg_85_0, arg_85_1)
	if not arg_85_1:ExistMovableNode() then
		return
	end

	if arg_85_0.movePanel.childCount <= 0 then
		return
	end

	local var_85_1 = arg_85_0.moveTargets or {}

	for iter_85_0, iter_85_1 in var_85_0(var_85_1) do
		if iter_85_1:GetComponent(typeof(SpineAnimUI)) ~= nil then
			PoolMgr.GetInstance():ReturnSpineChar(iter_85_1.name, iter_85_1.gameObject)
		else
			Destroy(arg_85_0.movePanel:GetChild(iter_85_0 - 1))
		end
	end

	arg_85_0.moveTargets = {}

	return
end

function var_0_0.FadeOutStory(arg_86_0, arg_86_1, arg_86_2)
	if not arg_86_1:ShouldFadeout() then
		arg_86_2()

		return
	end

	local var_86_0 = arg_86_1:GetFadeoutTime()

	if not arg_86_1:ShouldWaitFadeout() then
		arg_86_0:fadeTransform(arg_86_0._go, 1, 0.3, var_86_0, true)
		arg_86_2()
	else
		arg_86_0:fadeTransform(arg_86_0._go, 1, 0.3, var_86_0, true, arg_86_2)
	end

	return
end

function var_0_0.GetFadeColor(arg_87_0, arg_87_1)
	local var_87_0 = {}

	for iter_87_0, iter_87_1 in ipairs((arg_87_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		local var_87_1 = {
			name = "_Color",
			color = Color.white
		}

		if iter_87_1.material.shader.name == "UI/GrayScale" then
			var_87_1 = {
				name = "_GrayScale",
				color = Color.New(0.21176470588235294, 0.7137254901960784, 0.07058823529411765)
			}
		elseif iter_87_1.material.shader.name == "UI/Line_Add_Blue" then
			var_87_1 = {
				name = "_GrayScale",
				color = Color.New(1, 1, 1, 0.5882352941176471)
			}
		end

		table.insert(var_87_0, var_87_1)

		if iter_87_1.material == iter_87_1.defaultGraphicMaterial then
			iter_87_1.material = Material.Instantiate(iter_87_1.defaultGraphicMaterial)
		end

		table.insert({}, iter_87_1.material)
	end

	return {}, var_87_0
end

function var_0_0._SetFadeColor(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	for iter_88_0, iter_88_1 in ipairs(arg_88_1) do
		if not IsNil(iter_88_1) then
			iter_88_1:SetColor(arg_88_2[iter_88_0].name, arg_88_2[iter_88_0].color * Color.New(arg_88_3, arg_88_3, arg_88_3))
		end
	end

	return
end

function var_0_0.SetFadeColor(arg_89_0, arg_89_1, arg_89_2)
	local var_89_0, var_89_1 = arg_89_0:GetFadeColor(arg_89_1)

	arg_89_0:_SetFadeColor(var_89_0, var_89_1, arg_89_2)

	return
end

function var_0_0._RevertFadeColor(arg_90_0, arg_90_1, arg_90_2)
	arg_90_0:_SetFadeColor(arg_90_1, arg_90_2, 1)

	return
end

function var_0_0.RevertFadeColor(arg_91_0, arg_91_1)
	local var_91_0, var_91_1 = arg_91_0:GetFadeColor(arg_91_1)

	arg_91_0:_RevertFadeColor(var_91_0, var_91_1)

	return
end

function var_0_0.fadeTransform(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4, arg_92_5, arg_92_6)
	if arg_92_4 <= 0 then
		if arg_92_6 then
			arg_92_6()
		end

		return
	end

	local var_92_0, var_92_1 = arg_92_0:GetFadeColor(arg_92_1)

	LeanTween.value(go(arg_92_1), arg_92_2, arg_92_3, arg_92_4):setOnUpdate(System.Action_float(function(arg_93_0)
		arg_92_0:_SetFadeColor(var_92_0, var_92_1, arg_93_0)

		return
	end)):setOnComplete(System.Action(function()
		if arg_92_5 then
			arg_92_0:_RevertFadeColor(var_92_0, var_92_1)
		end

		if arg_92_6 then
			arg_92_6()
		end

		return
	end))

	return
end

function var_0_0.setPaintingAlpha(arg_95_0, arg_95_1, arg_95_2)
	local var_95_0 = {}

	for iter_95_0, iter_95_1 in ipairs((arg_95_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		local var_95_1 = {
			name = "_Color",
			color = Color.white
		}

		if iter_95_1.material.shader.name == "UI/GrayScale" then
			var_95_1 = {
				name = "_GrayScale",
				color = Color.New(0.21176470588235294, 0.7137254901960784, 0.07058823529411765)
			}
		elseif iter_95_1.material.shader.name == "UI/Line_Add_Blue" then
			var_95_1 = {
				name = "_GrayScale",
				color = Color.New(1, 1, 1, 0.5882352941176471)
			}
		end

		table.insert(var_95_0, var_95_1)

		if iter_95_1.material == iter_95_1.defaultGraphicMaterial then
			iter_95_1.material = Material.Instantiate(iter_95_1.defaultGraphicMaterial)
		end

		table.insert({}, iter_95_1.material)
	end

	for iter_95_2, iter_95_3 in ipairs({}) do
		if not IsNil(iter_95_3) then
			iter_95_3:SetColor(var_95_0[iter_95_2].name, var_95_0[iter_95_2].color * Color.New(arg_95_2, arg_95_2, arg_95_2))
		end
	end

	return
end

function var_0_0.RegisetEvent(arg_96_0, arg_96_1, arg_96_2)
	setButtonEnabled(arg_96_0._go, not arg_96_0.autoNext)
	onButton(arg_96_0, arg_96_0._go, function()
		if arg_96_0.pause or arg_96_0.stop then
			return
		end

		removeOnButton(arg_96_0._go)
		arg_96_2()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.flashEffect(arg_98_0, arg_98_1, arg_98_2, arg_98_3, arg_98_4, arg_98_5, arg_98_6)
	arg_98_0.flashImg.color = arg_98_4 and Color(0, 0, 0) or Color(1, 1, 1)
	arg_98_0.flashCg.alpha = arg_98_1

	setActive(arg_98_0.flash, true)
	arg_98_0:TweenValueForcanvasGroup(arg_98_0.flashCg, arg_98_1, arg_98_2, arg_98_3, arg_98_5, arg_98_6)

	return
end

function var_0_0.Flashout(arg_99_0, arg_99_1, arg_99_2)
	local var_99_0, var_99_1, var_99_2, var_99_3 = arg_99_1:GetFlashoutData()

	if not var_99_0 then
		arg_99_2()

		return
	end

	arg_99_0:flashEffect(var_99_0, var_99_1, var_99_2, var_99_3, 0, arg_99_2)

	return
end

function var_0_0.flashin(arg_100_0, arg_100_1, arg_100_2)
	local var_100_0, var_100_1, var_100_2, var_100_3, var_100_4 = arg_100_1:GetFlashinData()

	if not var_100_0 then
		arg_100_2()

		return
	end

	arg_100_0:flashEffect(var_100_0, var_100_1, var_100_2, var_100_3, var_100_4, arg_100_2)

	return
end

function var_0_0.UpdateBg(arg_101_0, arg_101_1)
	if arg_101_1:ShouldBgGlitchArt() then
		arg_101_0:SetBgGlitchArt(arg_101_1)
	else
		local var_101_0 = arg_101_1:GetBgName()

		if var_101_0 then
			setActive(arg_101_0.bgPanel, true)

			arg_101_0.bgPanelCg.alpha = 1
			arg_101_0.bgImage.color = Color.New(1, 1, 1)
			arg_101_0.bgImage.sprite = arg_101_0:GetBg(var_101_0)
		end

		local var_101_1 = arg_101_1:GetBgShadow()

		if var_101_1 then
			arg_101_0:TweenValue(arg_101_0.bgImage, var_101_1[1], var_101_1[2], var_101_1[3], 0, function(arg_102_0)
				var_0.color = Color.New(arg_102_0, arg_102_0, arg_102_0)

				return
			end, nil)
		end

		if arg_101_1:IsBlackBg() then
			setActive(arg_101_0.curtain, true)

			arg_101_0.curtainCg.alpha = 1
		end

		local var_101_2, var_101_3 = arg_101_1:IsBlackFrontGround()

		if var_101_2 then
			arg_101_0.curtainFCg.alpha = var_101_3
		end

		setActive(arg_101_0.curtainF, var_101_2)
	end

	arg_101_0:ApplyOldPhotoEffect(arg_101_1)
	arg_101_0:OnBgUpdate(arg_101_1)

	arg_101_0.curtain:GetComponent(typeof(Image)).color = arg_101_1:GetBgColor()

	return
end

function var_0_0.ApplyOldPhotoEffect(arg_103_0, arg_103_1)
	local var_103_0 = arg_103_1:OldPhotoEffect()
	local var_103_1 = var_103_0 ~= nil

	setActive(arg_103_0.oldPhoto.gameObject, var_103_0 ~= nil)

	if var_103_1 then
		arg_103_0.oldPhoto.color = type(var_103_0) == "table" and Color.New(var_103_0[1], var_103_0[2], var_103_0[3], var_103_0[4]) or Color.New(0.62, 0.58, 0.14, 0.36)
	end

	return
end

function var_0_0.SetBgGlitchArt(arg_104_0, arg_104_1)
	setActive(arg_104_0.bgPanel, false)
	setActive(arg_104_0.bgGlitch, true)

	return
end

function var_0_0.GetBg(arg_105_0, arg_105_1)
	arg_105_0.bgs[arg_105_1] = arg_105_0.bgs[arg_105_1] or LoadSprite("bg/" .. arg_105_1)

	return arg_105_0.bgs[arg_105_1]
end

function var_0_0.LoadEffects(arg_106_0, arg_106_1, arg_106_2)
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
		local var_106_7 = arg_106_0.effectPanel:Find(iter_106_1.name) or arg_106_0.centerPanel:Find(var_106_2)

		if var_106_7 then
			setActive(var_106_7, var_106_3)

			local var_106_9 = var_106_7

			if iter_106_1.center then
				local var_106_10 = arg_106_0.centerPanel or arg_106_0.effectPanel.transform

				var_106_8(var_106_9, var_106_10)

				if var_106_4 then
					arg_106_0:UpdateEffectInterLayer(var_106_2, var_106_7)
				end

				if not var_106_3 then
					arg_106_0:ClearEffectInterlayer(var_106_2)
				elseif isActive(var_106_7) then
					setActive(var_106_7, false)
					setActive(var_106_7, true)
				end

				if var_106_6 then
					arg_106_0:AdaptEffect(var_106_7)
				end

				if false then
					local var_106_11 = ""

					if checkABExist("ui/" .. var_106_2) then
						var_106_11 = "ui"
					elseif checkABExist("effect/" .. var_106_2) then
						var_106_11 = "effect"
					end

					if var_106_11 and var_106_11 ~= "" then
						table.insert(var_106_1, function(arg_107_0)
							LoadAndInstantiateAsync(var_106_11, var_106_2, function(arg_108_0)
								local var_108_0 = arg_108_0

								if var_106_5 then
									local var_108_1 = arg_106_0.centerPanel or arg_106_0.effectPanel.transform

									setParent(var_108_0, var_108_1)

									arg_108_0.transform.localScale = Vector3.one

									setActive(arg_108_0, var_106_3)

									arg_108_0.name = var_106_2

									if var_106_4 then
										arg_106_0:UpdateEffectInterLayer(var_106_2, arg_108_0)
									end

									if var_106_3 == false then
										arg_106_0:ClearEffectInterlayer(var_106_2)
									end

									if var_106_6 then
										arg_106_0:AdaptEffect(arg_108_0)
									end

									arg_107_0()

									return
								end
							end)

							return
						end)
					else
						originalPrint("not found effect", var_106_2)
					end
				end
			end
		end
	end

	parallelAsync(var_106_1, arg_106_2)

	return
end

function var_0_0.AdaptEffect(arg_109_0, arg_109_1)
	local var_109_0 = pg.UIMgr.GetInstance().OverlayMain.parent.sizeDelta
	local var_109_1 = 1

	var_109_1 = 1.7777777777777777 < var_109_0.x / var_109_0.y and var_109_0.x / var_109_0.y / 1.7777777777777777 or 1.7777777777777777 / (var_109_0.x / var_109_0.y)
	tf(arg_109_1).localScale = Vector3(var_109_1, var_109_1, var_109_1)

	return
end

function var_0_0.UpdateEffectInterLayer(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = arg_110_0._go:GetComponent(typeof(Canvas)).sortingOrder

	for iter_110_0, iter_110_1 in ipairs((arg_110_2:GetComponentsInChildren(typeof("UnityEngine.ParticleSystemRenderer")):ToTable())) do
		local var_110_1 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_110_1)

		if var_110_0 < var_110_1 then
			var_110_0 = var_110_1
		end
	end

	local var_110_2 = GetOrAddComponent(arg_110_0.actorTr, typeof(Canvas))

	var_110_2.overrideSorting = true
	var_110_2.sortingOrder = var_110_0 + 1

	local var_110_3 = GetOrAddComponent(arg_110_0.frontTr, typeof(Canvas))

	var_110_3.overrideSorting = true
	var_110_3.sortingOrder = var_110_0 + 1 + 1
	arg_110_0.activeInterLayer = arg_110_1

	GetOrAddComponent(arg_110_0.frontTr, typeof(GraphicRaycaster))

	return
end

function var_0_0.ClearEffectInterlayer(arg_111_0, arg_111_1)
	if arg_111_0.activeInterLayer == arg_111_1 then
		RemoveComponent(arg_111_0.frontTr, "GraphicRaycaster")
		RemoveComponent(arg_111_0.actorTr, "Canvas")
		RemoveComponent(arg_111_0.frontTr, "Canvas")

		arg_111_0.activeInterLayer = nil
	end

	return
end

function var_0_0.ClearEffects(arg_112_0)
	removeAllChildren(arg_112_0.effectPanel)
	removeAllChildren(arg_112_0.centerPanel)

	if arg_112_0.activeInterLayer ~= nil then
		arg_112_0:ClearEffectInterlayer(arg_112_0.activeInterLayer)
	end

	return
end

function var_0_0.PlaySoundEffect(arg_113_0, arg_113_1)
	if arg_113_1:ShouldPlaySoundEffect() then
		local var_113_0, var_113_1 = arg_113_1:GetSoundeffect()

		arg_113_0:DelayCall(var_113_1, function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_113_0)

			return
		end)
	end

	if arg_113_1:ShouldPlayVoice() then
		arg_113_0:PlayVoice(arg_113_1)
	elseif arg_113_1:ShouldStopVoice() then
		arg_113_0:StopVoice()
	end

	return
end

function var_0_0.StopVoice(arg_115_0)
	if arg_115_0.currentVoice then
		arg_115_0.currentVoice:Stop(true)

		arg_115_0.currentVoice = nil
	end

	return
end

function var_0_0.PlayVoice(arg_116_0, arg_116_1)
	if arg_116_0.voiceDelayTimer then
		arg_116_0.voiceDelayTimer:Stop()

		arg_116_0.voiceDelayTimer = nil
	end

	arg_116_0:StopVoice()

	local var_116_0, var_116_1 = arg_116_1:GetVoice()
	local var_116_2

	arg_116_0.voiceDelayTimer = arg_116_0:CreateDelayTimer(var_116_1, function()
		if var_116_2 then
			var_116_2:Stop()
		end

		if arg_116_0.voiceDelayTimer then
			arg_116_0.voiceDelayTimer = nil
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_116_0, function(arg_118_0)
			if arg_118_0 then
				arg_116_0.currentVoice = arg_118_0.playback
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.Reset(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	setActive(arg_119_0.spAnimPanel, false)
	setActive(arg_119_0.castPanel, false)
	setActive(arg_119_0.bgPanel, false)

	if arg_119_1 and arg_119_1:IsDialogueMode() and arg_119_2 and arg_119_2:IsDialogueMode() then
		-- block empty
	else
		setActive(arg_119_0.dialoguePanel, false)
	end

	setActive(arg_119_0.asidePanel, false)
	setActive(arg_119_0.curtain, false)
	setActive(arg_119_0.flash, false)
	setActive(arg_119_0.optionsCg.gameObject, false)
	setActive(arg_119_0.bgGlitch, false)
	setActive(arg_119_0.locationTr, false)

	arg_119_0.locationTr.localPosition = arg_119_0.locationTrPos
	arg_119_0.locationStatus = var_0_9
	arg_119_0.flashCg.alpha = 1
	arg_119_0.goCG.alpha = 1

	arg_119_0.animationPlayer:Stop()
	arg_119_0:OnReset(arg_119_1, arg_119_2, arg_119_3)

	return
end

function var_0_0.Clear(arg_120_0, arg_120_1)
	if arg_120_0.step then
		arg_120_0:ClearMoveNodes(arg_120_0.step)
	end

	arg_120_0.bgs = {}
	arg_120_0.skipOption = nil
	arg_120_0.step = nil
	arg_120_0.goCG.alpha = 1
	arg_120_0.callback = nil
	arg_120_0.autoNext = nil
	arg_120_0.script = nil
	arg_120_0.bgImage.sprite = nil

	arg_120_0:OnClear()

	if arg_120_1 then
		arg_120_1()
	end

	pg.DelegateInfo.New(arg_120_0)

	return
end

function var_0_0.StoryEnd(arg_121_0, arg_121_1)
	setActive(arg_121_0.iconImage.gameObject, false)

	arg_121_0.iconImage.sprite = nil
	arg_121_0.branchCodeList = {}
	arg_121_0.stop = false
	arg_121_0.pause = false

	if arg_121_0.voiceDelayTimer then
		arg_121_0.voiceDelayTimer:Stop()

		arg_121_0.voiceDelayTimer = nil
	end

	if arg_121_0.currentVoice then
		arg_121_0.currentVoice:Stop(true)

		arg_121_0.currentVoice = nil
	end

	arg_121_0:ClearCheckDispatcher()
	arg_121_0:ClearEffects()
	arg_121_0:Clear()
	arg_121_0:OnEnd(arg_121_1)

	return
end

function var_0_0.PlayBgm(arg_122_0, arg_122_1)
	if arg_122_1:ShouldStopBgm() then
		arg_122_0:StopBgm()
	end

	if arg_122_1:ShoulePlayBgm() then
		local var_122_0, var_122_1, var_122_2 = arg_122_1:GetBgmData()

		arg_122_0:DelayCall(var_122_1, function()
			arg_122_0:RevertBgmVolume()
			pg.BgmMgr.GetInstance():TempPlay(var_122_0)

			return
		end)

		if var_122_2 and var_122_2 > 0 then
			arg_122_0.defaultBgmVolume = pg.CriMgr.GetInstance():getBGMVolume()

			pg.CriMgr.GetInstance():setBGMVolume(var_122_2)
		end
	end

	return
end

function var_0_0.StopBgm(arg_124_0, arg_124_1)
	arg_124_0:RevertBgmVolume()
	pg.BgmMgr.GetInstance():StopPlay()

	return
end

function var_0_0.RevertBgmVolume(arg_125_0)
	if arg_125_0.defaultBgmVolume then
		pg.CriMgr.GetInstance():setBGMVolume(arg_125_0.defaultBgmVolume)

		arg_125_0.defaultBgmVolume = nil
	end

	return
end

function var_0_0.StartUIAnimations(arg_126_0, arg_126_1, arg_126_2)
	parallelAsync({
		function(arg_127_0)
			arg_126_0:StartBlinkAnimation(arg_126_1, arg_127_0)

			return
		end,
		function(arg_128_0)
			arg_126_0:StartBlinkWithColorAnimation(arg_126_1, arg_128_0)

			return
		end,
		function(arg_129_0)
			arg_126_0:OnStartUIAnimations(arg_126_1, arg_129_0)

			return
		end
	}, arg_126_2)

	return
end

function var_0_0.StartBlinkAnimation(arg_130_0, arg_130_1, arg_130_2)
	if arg_130_1:ShouldBlink() then
		local var_130_0 = arg_130_1:GetBlinkData()
		local var_130_1 = var_130_0.number
		local var_130_2 = var_130_0.dur
		local var_130_4 = var_130_0.alpha[1]
		local var_130_5 = var_130_0.alpha[2]
		local var_130_6 = var_130_0.wait
		local var_130_7 = arg_130_0.flashImg

		var_130_7.color = var_130_0.black and Color(0, 0, 0) or Color(1, 1, 1)

		setActive(arg_130_0.flash, true)

		for iter_130_0 = 1, var_130_1 do
			table.insert({}, function(arg_131_0)
				arg_130_0:TweenAlpha(arg_130_0.flash, var_130_4, var_130_5, var_130_2 / 2, 0, function()
					arg_130_0:TweenAlpha(arg_130_0.flash, var_130_5, var_130_4, var_130_2 / 2, var_130_6, arg_131_0)

					return
				end)

				return
			end)
		end

		seriesAsync({}, function()
			setActive(arg_130_0.flash, false)

			return
		end)
	end

	arg_130_2()

	return
end

function var_0_0.StartBlinkWithColorAnimation(arg_134_0, arg_134_1, arg_134_2)
	if arg_134_1:ShouldBlinkWithColor() then
		local var_134_0 = arg_134_1:GetBlinkWithColorData()

		arg_134_0.flashImg.color = Color(var_134_0.color[1], var_134_0.color[2], var_134_0.color[3], var_134_0.color[4])

		setActive(arg_134_0.flash, true)

		for iter_134_0, iter_134_1 in ipairs(var_134_0.alpha) do
			local var_134_1 = iter_134_1[1]
			local var_134_2 = iter_134_1[2]
			local var_134_3 = iter_134_1[3]
			local var_134_4 = iter_134_1[4]

			table.insert({}, function(arg_135_0)
				arg_134_0:TweenValue(arg_134_0.flash, var_134_1, var_134_2, var_134_3, var_134_4, function(arg_136_0)
					arg_134_0.flashCg.alpha = arg_136_0

					return
				end, arg_135_0)

				return
			end)
		end

		parallelAsync({}, function()
			setActive(arg_134_0.flash, false)

			return
		end)
	end

	arg_134_2()

	return
end

function var_0_0.OnStart(arg_138_0, arg_138_1)
	return
end

function var_0_0.OnReset(arg_139_0, arg_139_1, arg_139_2, arg_139_3)
	arg_139_3()

	return
end

function var_0_0.OnBgUpdate(arg_140_0, arg_140_1)
	return
end

function var_0_0.OnInit(arg_141_0, arg_141_1, arg_141_2, arg_141_3)
	if arg_141_3 then
		arg_141_3()
	end

	return
end

function var_0_0.OnStartUIAnimations(arg_142_0, arg_142_1, arg_142_2)
	if arg_142_2 then
		arg_142_2()
	end

	return
end

function var_0_0.OnEnter(arg_143_0, arg_143_1, arg_143_2, arg_143_3)
	if arg_143_3 then
		arg_143_3()
	end

	return
end

function var_0_0.OnWillExit(arg_144_0, arg_144_1, arg_144_2, arg_144_3)
	arg_144_3()

	return
end

function var_0_0.OnWillClear(arg_145_0, arg_145_1)
	return
end

function var_0_0.OnClear(arg_146_0)
	return
end

function var_0_0.OnEnd(arg_147_0, arg_147_1)
	return
end

return var_0_0
