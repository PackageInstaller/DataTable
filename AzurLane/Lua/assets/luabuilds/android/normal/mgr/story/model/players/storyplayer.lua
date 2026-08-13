class = var_0_10000

local var_0_0 = "StoryPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..animation.StoryAnimtion"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4
local var_0_7 = 5
local var_0_8 = 6
local var_0_9 = 7
local var_0_10 = 0
local var_0_11 = 1
local var_0_12 = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	pg = var_2

	var_2.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10004
	Animation = var_1_10005
	arg_1_0.animationPlayer = var_1_1(var_1_0, var_1_10004(var_1_10005))

	local var_1_2 = arg_1_0._tf

	arg_1_0.front = var_2.Find(var_1_2, "front")

	local var_1_3 = arg_1_0._tf

	arg_1_0.actorTr = var_2.Find(var_1_3, "actor")

	local var_1_4 = arg_1_0._tf

	arg_1_0.frontTr = var_2.Find(var_1_4, "front")

	local var_1_5 = arg_1_0._tf

	arg_1_0.backPanel = var_2.Find(var_1_5, "back")
	GetOrAddComponent = var_2

	local var_1_6 = arg_1_0._tf

	typeof = var_4
	CanvasGroup = var_1_10005
	arg_1_0.goCG = var_2(var_1_6, var_4(var_1_10005))

	local var_1_7 = arg_1_0._tf

	arg_1_0.asidePanel = var_2.Find(var_1_7, "front/aside_panel")

	local var_1_8 = arg_1_0._tf

	arg_1_0.bgGlitch = var_2.Find(var_1_8, "back/bg_glitch")

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_2.Find(var_1_9, "front/oldphoto")
	local var_1_11 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.oldPhoto = var_1_11(var_1_10, var_4(var_1_10005))

	local var_1_12 = arg_1_0._tf

	arg_1_0.bgPanel = var_2.Find(var_1_12, "back/bg")

	local var_1_13 = arg_1_0.bgPanel
	local var_1_14 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10005
	arg_1_0.bgPanelCg = var_1_14(var_1_13, var_4(var_1_10005))
	setActive = var_2

	local var_1_15 = arg_1_0._tf

	var_2(var_3.Find(var_1_15, "back/bg/sub"), false)

	local var_1_16 = arg_1_0.bgPanel
	local var_1_17 = var_2.Find(var_1_16, "image")
	local var_1_18 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.bgImage = var_1_18(var_1_17, var_4(var_5))

	local var_1_19 = arg_1_0._tf
	local var_1_20 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.mainImg = var_1_20(var_1_19, var_4(var_5))

	local var_1_21 = arg_1_0._tf

	arg_1_0.castPanel = var_2.Find(var_1_21, "front/cast_panel")

	local var_1_22 = arg_1_0._tf

	arg_1_0.spAnimPanel = var_2.Find(var_1_22, "front/sp_anim_panel")

	local var_1_23 = arg_1_0._tf

	arg_1_0.centerPanel = var_2.Find(var_1_23, "center")

	local var_1_24 = arg_1_0._tf

	arg_1_0.actorPanel = var_2.Find(var_1_24, "actor")

	local var_1_25 = arg_1_0._tf

	arg_1_0.dialoguePanel = var_2.Find(var_1_25, "front/dialogue")

	local var_1_26 = arg_1_0._tf

	arg_1_0.effectPanel = var_2.Find(var_1_26, "front/effect")

	local var_1_27 = arg_1_0._tf

	arg_1_0.movePanel = var_2.Find(var_1_27, "front/move_layer")

	local var_1_28 = arg_1_0._tf

	arg_1_0.curtain = var_2.Find(var_1_28, "back/curtain")

	local var_1_29 = arg_1_0.curtain
	local var_1_30 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_5
	arg_1_0.curtainCg = var_1_30(var_1_29, var_4(var_5))

	local var_1_31 = arg_1_0._tf

	arg_1_0.flash = var_2.Find(var_1_31, "front/flash")

	local var_1_32 = arg_1_0.flash
	local var_1_33 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.flashImg = var_1_33(var_1_32, var_4(var_5))

	local var_1_34 = arg_1_0.flash
	local var_1_35 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_5
	arg_1_0.flashCg = var_1_35(var_1_34, var_4(var_5))

	local var_1_36 = arg_1_0._tf

	arg_1_0.curtainF = var_2.Find(var_1_36, "back/curtain_front")

	local var_1_37 = arg_1_0.curtainF
	local var_1_38 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_5
	arg_1_0.curtainFCg = var_1_38(var_1_37, var_4(var_5))

	local var_1_39 = arg_1_0._tf

	arg_1_0.locationTr = var_2.Find(var_1_39, "front/location")

	local var_1_40 = arg_1_0._tf
	local var_1_41 = var_2.Find(var_1_40, "front/location/Text")
	local var_1_42 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0.locationTxt = var_1_42(var_1_41, var_4(var_5))
	arg_1_0.locationTrPos = arg_1_0.locationTr.localPosition

	local var_1_43 = arg_1_0.locationTr
	local var_1_44 = var_2.GetComponent

	typeof = var_4
	Animation = var_5
	arg_1_0.locationAnim = var_1_44(var_1_43, var_4(var_5))

	local var_1_45 = arg_1_0.locationTr
	local var_1_46 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5
	arg_1_0.locationAniEvent = var_1_46(var_1_45, var_4(var_5))

	local var_1_47 = arg_1_0._tf
	local var_1_48 = var_2.Find(var_1_47, "front/icon")
	local var_1_49 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.iconImage = var_1_49(var_1_48, var_4(var_5))

	local var_1_50 = arg_1_0._tf

	arg_1_0.topEffectTr = var_2.Find(var_1_50, "top/effect")
	arg_1_0.dialogueWin = nil
	arg_1_0.bgs = {}
	arg_1_0.branchCodeList = {}
	arg_1_0.stop = false
	arg_1_0.pause = false

	return
end

function var_0_1.Disable(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0._tf, false)

	return
end

function var_0_1.Enable(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0._tf, true)

	return
end

function var_0_1.StoryStart(arg_4_0, arg_4_1)
	arg_4_0.branchCodeList = {}
	eachChild = var_2

	var_2(arg_4_0.dialoguePanel, function(arg_5_0)
		setActive = var_2_10001

		var_2_10001(arg_5_0, false)

		return
	end)

	local var_4_0 = arg_4_0.dialoguePanel

	arg_4_0.dialogueWin = var_2.Find(var_4_0, arg_4_1:GetDialogueStyleName())
	setActive = var_2

	var_2(arg_4_0.dialogueWin, true)

	UIItemList = var_2

	local var_4_1 = var_2.New
	local var_4_2 = arg_4_0.dialogueWin
	local var_4_3 = var_3.Find(var_4_2, "options_panel/options_l")
	local var_4_4 = arg_4_0.dialogueWin

	arg_4_0.optionLUIlist = var_4_1(var_4_3, var_4.Find(var_4_4, "options_panel/options_l/option_tpl"))
	UIItemList = var_2

	local var_4_5 = var_2.New
	local var_4_6 = arg_4_0.dialogueWin
	local var_4_7 = var_3.Find(var_4_6, "options_panel/options_c")
	local var_4_8 = arg_4_0.dialogueWin

	arg_4_0.optionCUIlist = var_4_5(var_4_7, var_4.Find(var_4_8, "options_panel/options_c/option_tpl"))

	local var_4_9 = arg_4_0.dialogueWin
	local var_4_10 = var_2.Find(var_4_9, "options_panel")
	local var_4_11 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_4_8
	arg_4_0.optionsCg = var_4_11(var_4_10, var_4(var_4_8))

	arg_4_0:OnStart(arg_4_1)

	return
end

function var_0_1.GetOptionContainer(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetOptionCnt()
	local var_6_1 = arg_6_0.script

	if var_3.IsDialogueStyle2(var_6_1) then
		setActive = var_3

		var_3(arg_6_0.optionLUIlist.container, true)

		setActive = var_3

		var_3(arg_6_0.optionCUIlist.container, false)

		return arg_6_0.optionLUIlist, true
	end

	if var_6_0 <= 3 or arg_6_1:IsOptionForceCenter() then
		setActive = var_3

		var_3(arg_6_0.optionLUIlist.container, false)

		setActive = var_3

		var_3(arg_6_0.optionCUIlist.container, true)

		return arg_6_0.optionCUIlist, false
	else
		setActive = var_3

		var_3(arg_6_0.optionLUIlist.container, true)

		setActive = var_3

		var_3(arg_6_0.optionCUIlist.container, false)

		return arg_6_0.optionLUIlist, true
	end

	return
end

function var_0_1.Pause(arg_7_0)
	arg_7_0.pause = true

	arg_7_0:PauseAllAnimation()

	pg = var_1

	local var_7_0 = var_1.ViewUtils.SetLayer
	local var_7_1 = arg_7_0.effectPanel

	Layer = var_1_10003

	var_7_0(var_7_1, var_1_10003.UIHidden)

	return
end

function var_0_1.Resume(arg_8_0)
	arg_8_0.pause = false

	arg_8_0:ResumeAllAnimation()

	pg = var_1

	local var_8_0 = var_1.ViewUtils.SetLayer
	local var_8_1 = arg_8_0.effectPanel

	Layer = var_1_10003

	var_8_0(var_8_1, var_1_10003.UI)

	return
end

function var_0_1.Stop(arg_9_0)
	arg_9_0.stop = true

	arg_9_0:NextOneImmediately()

	return
end

function var_0_1.Play(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 then
		arg_10_3()

		return
	end

	if arg_10_1:GetNextScriptName() or arg_10_0.stop then
		arg_10_3()

		return
	end

	local var_10_0 = arg_10_1

	if not arg_10_1.GetStepByIndex(var_10_0, arg_10_2) then
		arg_10_3()

		return
	end

	pg = var_10_0

	local var_10_1 = var_10_0.NewStoryMgr.GetInstance()

	var_5.AddRecord(var_10_1, var_4)

	if var_4:ShouldJumpToNextScript() then
		arg_10_1:SetNextScriptName(var_4:GetNextScriptName())
		arg_10_3()

		return
	end

	if arg_10_1:ShouldSkipAll() then
		arg_10_0:ClearEffects()
	end

	local var_10_2 = false

	if var_5 and var_4:IsImport() then
		pg = var_7

		local var_10_3 = var_7.NewStoryMgr.GetInstance()

		if not var_7.IsReView(var_10_3) then
			var_10_2 = true

			goto label_10_0
		end
	end

	if var_5 then
		arg_10_3()

		return
	end

	::label_10_0::

	arg_10_0.script = arg_10_1
	arg_10_0.callback = arg_10_3
	arg_10_0.step = var_4
	arg_10_0.autoNext = arg_10_1:GetAutoPlayFlag()
	arg_10_0.stage = var_0_2

	local var_10_4 = arg_10_1:GetTriggerDelayTime()

	if arg_10_0.autoNext and var_4:IsImport() and not var_4.optionSelCode then
		arg_10_0.autoNext = nil
	end

	arg_10_0:SetTimeScale(1 - arg_10_1:GetPlaySpeed() * 0.1)

	local var_10_5 = arg_10_1
	local var_10_6 = arg_10_1.GetPrevStep(var_10_5, arg_10_2)

	seriesAsync = var_10_5

	var_10_5({
		function(arg_11_0)
			local var_11_0 = arg_10_0

			if not var_1.NextStage(var_11_0, var_0_3) then
				return
			end

			parallelAsync = var_1

			var_1({
				function(arg_12_0)
					local var_12_0 = arg_10_0

					var_1.Reset(var_12_0, var_0, var_10_6, arg_12_0)

					local var_12_1 = arg_10_0

					var_1.UpdateBg(var_12_1, var_0)

					local var_12_2 = arg_10_0

					var_1.PlayBgm(var_12_2, var_0)

					return
				end,
				function(arg_13_0)
					local var_13_0 = arg_10_0

					var_1.LoadEffects(var_13_0, var_0, arg_13_0)

					return
				end,
				function(arg_14_0)
					local var_14_0 = arg_10_0

					var_1.ApplyEffects(var_14_0, var_0, arg_14_0)

					return
				end,
				function(arg_15_0)
					local var_15_0 = arg_10_0

					var_1.flashin(var_15_0, var_0, arg_15_0)

					return
				end
			}, arg_11_0)

			return
		end,
		function(arg_16_0)
			if var_10_2 then
				local var_16_0 = arg_10_1

				var_1.StopSkip(var_16_0)
			end

			var_10_2 = false

			arg_16_0()

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_10_0

			if not var_1.NextStage(var_17_0, var_0_4) then
				return
			end

			parallelAsync = var_1

			var_1({
				function(arg_18_0)
					local var_18_0 = arg_10_0

					var_1.OnInit(var_18_0, var_0, var_10_6, arg_18_0)

					return
				end,
				function(arg_19_0)
					local var_19_0 = arg_10_0

					var_1.PlaySoundEffect(var_19_0, var_0)

					local var_19_1 = arg_10_0

					var_1.StartUIAnimations(var_19_1, var_0, arg_19_0)

					return
				end,
				function(arg_20_0)
					local var_20_0 = arg_10_0

					var_1.OnEnter(var_20_0, var_0, var_10_6, arg_20_0)

					return
				end,
				function(arg_21_0)
					local var_21_0 = arg_10_0

					var_1.StartMoveNode(var_21_0, var_0, arg_21_0)

					return
				end,
				function(arg_22_0)
					local var_22_0 = arg_10_0

					var_1.UpdateIcon(var_22_0, var_0, arg_22_0)

					return
				end,
				function(arg_23_0)
					local var_23_0 = arg_10_0

					var_1.SetLocation(var_23_0, var_0, arg_23_0)

					return
				end,
				function(arg_24_0)
					local var_24_0 = arg_10_0

					if var_1.DispatcherEvent(var_24_0, var_0, arg_24_0) then
						arg_10_0.autoNext = true
						var_10_4 = 0
					end

					return
				end
			}, arg_17_0)

			return
		end,
		function(arg_25_0)
			local var_25_0 = arg_10_0

			var_1.ClearCheckDispatcher(var_25_0)

			local var_25_1 = arg_10_0

			if not var_1.NextStage(var_25_1, var_0_5) then
				return
			end

			local var_25_2 = var_0

			if not var_1.ShouldDelayEvent(var_25_2) then
				arg_25_0()

				return
			end

			local var_25_3 = arg_10_0
			local var_25_4 = var_1.DelayCall
			local var_25_5 = var_0

			var_25_4(var_25_3, var_3.GetEventDelayTime(var_25_5), arg_25_0)

			return
		end,
		function(arg_26_0)
			local var_26_0 = arg_10_0

			if not var_1.NextStage(var_26_0, var_0_6) then
				return
			end

			if arg_10_0.skipOption then
				arg_26_0()

				return
			end

			local var_26_1 = var_0

			if var_1.SkipEventForOption(var_26_1) then
				arg_26_0()

				return
			end

			local var_26_2 = arg_10_0

			if var_1.ShouldAutoTrigger(var_26_2) then
				local var_26_3 = arg_10_0

				var_1.UnscaleDelayCall(var_26_3, var_10_4, arg_26_0)

				return
			end

			local var_26_4 = arg_10_0

			var_1.RegisetEvent(var_26_4, var_0, arg_26_0)

			local var_26_5 = arg_10_0

			var_1.TriggerEventIfAuto(var_26_5, var_10_4)

			return
		end,
		function(arg_27_0)
			local var_27_0 = arg_10_0

			if not var_1.NextStage(var_27_0, var_0_7) then
				return
			end

			local var_27_1 = var_0

			if not var_1.ExistOption(var_27_1) then
				arg_27_0()

				return
			end

			if arg_10_0.skipOption then
				arg_10_0.skipOption = false

				arg_27_0()

				return
			end

			local var_27_2 = arg_10_0

			var_1.InitBranches(var_27_2, arg_10_1, var_0, function(arg_28_0)
				arg_27_0()

				return
			end, function()
				local var_29_0 = arg_10_0

				var_0.TriggerOptionIfAuto(var_29_0, var_10_4, var_0)

				return
			end)

			return
		end,
		function(arg_30_0)
			local var_30_0 = arg_10_0

			if not var_1.NextStage(var_30_0, var_0_8) then
				return
			end

			arg_10_0.autoNext = nil

			local var_30_1 = arg_10_1
			local var_30_2 = var_1.GetNextStep(var_30_1, arg_10_2)

			seriesAsync = var_30_1

			var_30_1({
				function(arg_31_0)
					local var_31_0 = arg_10_0

					var_1.ClearAnimation(var_31_0)

					local var_31_1 = arg_10_0

					var_1.ClearApplyEffect(var_31_1)

					local var_31_2 = arg_10_0

					var_1.OnWillExit(var_31_2, var_0, var_30_2, arg_31_0)

					return
				end,
				function(arg_32_0)
					parallelAsync = var_3_10001

					var_3_10001({
						function(arg_33_0)
							if not var_30_2 then
								arg_33_0()

								return
							end

							local var_33_0 = arg_10_0

							var_1.Flashout(var_33_0, var_30_2, arg_33_0)

							return
						end,
						function(arg_34_0)
							if var_30_2 then
								arg_34_0()

								return
							end

							local var_34_0 = arg_10_0

							var_1.FadeOutStory(var_34_0, arg_10_0.script, arg_34_0)

							return
						end
					}, arg_32_0)

					return
				end
			}, arg_30_0)

			return
		end,
		function(arg_35_0)
			local var_35_0 = arg_10_0

			if not var_1.NextStage(var_35_0, var_0_9) then
				return
			end

			local var_35_1 = arg_10_0

			var_1.OnWillClear(var_35_1, var_0)

			local var_35_2 = arg_10_0

			var_1.Clear(var_35_2, arg_35_0)

			return
		end
	}, arg_10_3)

	return
end

function var_0_1.NextStage(arg_36_0, arg_36_1)
	if arg_36_0.stage == arg_36_1 - 1 then
		arg_36_0.stage = arg_36_1

		return true
	end

	return false
end

function var_0_1.ApplyEffects(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1:ShouldShake() then
		arg_37_0:ApplyShakeEffect(arg_37_1)
	end

	arg_37_2()

	return
end

function var_0_1.ApplyShakeEffect(arg_38_0, arg_38_1)
	if not arg_38_1:ShouldShake() then
		return
	end

	local var_38_0 = arg_38_0.animationPlayer

	var_2.Play(var_38_0, "anim_storyrecordUI_shake_loop")

	local var_38_1 = arg_38_1:GetShakeTime()

	arg_38_0.playingShakeAnim = true

	arg_38_0:DelayCall(var_38_1, function()
		local var_39_0 = arg_38_0

		var_0.ClearShakeEffect(var_39_0)

		return
	end)

	return
end

function var_0_1.ClearShakeEffect(arg_40_0)
	if arg_40_0.playingShakeAnim then
		local var_40_0 = arg_40_0.animationPlayer

		var_1.Play(var_40_0, "anim_storyrecordUI_shake_reset")

		arg_40_0.playingShakeAnim = nil
	end

	return
end

function var_0_1.ClearApplyEffect(arg_41_0)
	arg_41_0:ClearShakeEffect()

	return
end

function var_0_1.DispatcherEvent(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_1:ExistDispatcher() then
		arg_42_2()

		return
	end

	local var_42_0 = arg_42_1
	local var_42_1 = arg_42_1.GetDispatcher(var_42_0)

	pg = var_42_0

	local var_42_2 = var_42_0.NewStoryMgr.GetInstance()

	var_4.ClearStoryEvent(var_42_2)

	pg = var_4

	local var_42_3 = var_4.m02
	local var_42_4 = var_4.sendNotification
	local var_42_5 = var_42_1.name
	local var_42_6 = {
		data = var_42_1.data,
		callbackData = var_42_1.callbackData
	}
	local var_42_7

	if not arg_42_0.branchCodeList[arg_42_1:GetId()] then
		var_42_7 = {}
	end

	var_42_6.flags = var_42_7

	var_42_4(var_42_3, var_42_5, var_42_6)

	if arg_42_1:ShouldHideUI() then
		setActive = var_4

		var_4(arg_42_0._tf, false)
	end

	if arg_42_1:IsRecallDispatcher() then
		arg_42_0:CheckDispatcher(arg_42_1, arg_42_2)
	else
		arg_42_2()
	end

	return var_42_1.nextOne
end

function var_0_1.WaitForEvent(arg_43_0)
	return arg_43_0.checkTimer ~= nil
end

function var_0_1.CheckDispatcher(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_1:GetDispatcherRecallName()

	arg_44_0:ClearCheckDispatcher()

	Timer = var_4
	arg_44_0.checkTimer = var_4.New(function()
		pg = var_2_10000

		local var_45_0 = var_2_10000.NewStoryMgr.GetInstance()

		if var_0.CheckStoryEvent(var_45_0, var_44_0) then
			pg = var_0

			local var_45_1 = var_0.NewStoryMgr.GetInstance()

			if var_0.GetStoryEventArg(var_45_1, var_44_0) then
				existCall = var_45_1

				var_45_1(var_0.notifiCallback)
			end

			if var_0 and var_0.optionIndex then
				local var_45_2 = arg_44_0

				var_1.SetBranchCode(var_45_2, arg_44_0.script, arg_44_1, var_0.optionIndex)

				arg_44_0.skipOption = true
			end

			local var_45_3 = arg_44_1

			if var_1.ShouldHideUI(var_45_3) then
				setActive = var_1

				var_1(arg_44_0._tf, true)
			end

			local var_45_4 = arg_44_0

			var_1.ClearCheckDispatcher(var_45_4)
			arg_44_2()
		end

		return
	end, 1, -1)

	local var_44_1 = arg_44_0.checkTimer

	var_4.Start(var_44_1)
	arg_44_0.checkTimer.func()

	return
end

function var_0_1.ClearCheckDispatcher(arg_46_0)
	if arg_46_0.checkTimer then
		local var_46_0 = arg_46_0.checkTimer

		var_1.Stop(var_46_0)

		arg_46_0.checkTimer = nil
	end

	return
end

function var_0_1.TriggerEventIfAuto(arg_47_0, arg_47_1)
	if not arg_47_0:ShouldAutoTrigger() then
		return
	end

	arg_47_0:UnscaleDelayCall(arg_47_1, function()
		if not arg_47_0.autoNext then
			setButtonEnabled = var_0

			var_0(arg_47_0._go, true)

			return
		end

		triggerButton = var_0

		var_0(arg_47_0._go)

		return
	end)

	return
end

function var_0_1.TriggerOptionIfAuto(arg_49_0, arg_49_1, arg_49_2)
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

		local var_50_0 = arg_49_2

		if var_0.GetOptionIndexByAutoSel(var_50_0) ~= nil then
			local var_50_1 = arg_49_0
			local var_50_2 = var_1.GetOptionContainer(var_50_1, arg_49_2).container
			local var_50_3 = var_1.GetChild(var_50_2, var_0 - 1)

			triggerButton = var_50_2

			var_50_2(var_50_3)
		end

		return
	end)

	return
end

function var_0_1.ShouldAutoTrigger(arg_51_0)
	if arg_51_0.pause or arg_51_0.stop then
		return false
	end

	return arg_51_0.autoNext
end

function var_0_1.CanSkip(arg_52_0)
	local var_52_1

	if arg_52_0.step then
		local var_52_0 = arg_52_0.step

		var_52_1 = not var_1.IsImport(var_52_0)
	end

	return var_52_1
end

function var_0_1.CancelAuto(arg_53_0)
	arg_53_0.autoNext = false

	return
end

function var_0_1.NextOne(arg_54_0)
	arg_54_0.timeScale = 0.0001

	if arg_54_0.stage == var_0_2 then
		arg_54_0.autoNext = true
	elseif arg_54_0.stage == var_0_6 then
		arg_54_0.autoNext = true

		arg_54_0:TriggerEventIfAuto(0)
	elseif arg_54_0.stage == var_0_7 then
		arg_54_0:TriggerOptionIfAuto(0, arg_54_0.step)
	end

	return
end

function var_0_1.NextOneImmediately(arg_55_0)
	if arg_55_0.callback then
		arg_55_0:ClearAnimation()
		arg_55_0:Clear()
		var_1()
	end

	return
end

function var_0_1.SetLocation(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_1

	if not arg_56_1.ExistLocation(var_56_0) then
		local var_56_1 = arg_56_0.locationAniEvent

		var_56_0.SetEndEvent(var_56_1, nil)
		arg_56_2()

		return
	end

	setActive = var_56_0

	var_56_0(arg_56_0.locationTr, true)

	local var_56_2 = arg_56_1:GetLocation()

	arg_56_0.locationTxt.text = var_56_2.text

	local function var_56_3()
		local var_57_0 = arg_56_0

		var_0.DelayCall(var_57_0, var_56_2.time, function()
			local var_58_0 = arg_56_0.locationAnim

			var_0.Play(var_58_0, "anim_newstoryUI_iocation_out")

			arg_56_0.locationStatus = var_0_12

			return
		end)

		return
	end

	local var_56_4 = arg_56_0.locationAniEvent

	var_6.SetEndEvent(var_56_4, function()
		if arg_56_0.locationStatus == var_0_11 then
			var_56_3()
			arg_56_2()
		elseif arg_56_0.locationStatus == var_0_12 then
			setActive = var_0

			var_0(arg_56_0.locationTr, false)

			arg_56_0.locationStatus = var_0_10
		end

		return
	end)

	local var_56_5 = arg_56_0.locationAnim

	var_6.Play(var_56_5, "anim_newstoryUI_iocation_in")

	arg_56_0.locationStatus = var_0_11

	return
end

function var_0_1.UpdateIcon(arg_60_0, arg_60_1, arg_60_2)
	if not arg_60_1:ExistIcon() then
		setActive = var_3

		var_3(arg_60_0.iconImage.gameObject, false)
		arg_60_2()

		return
	end

	local var_60_0 = arg_60_1:GetIconData()
	local var_60_1 = arg_60_0.iconImage

	LoadSprite = var_1_10005
	var_60_1.sprite = var_1_10005(var_60_0.image)

	local var_60_2 = arg_60_0.iconImage

	var_4.SetNativeSize(var_60_2)

	local var_60_3 = arg_60_0.iconImage.gameObject.transform

	if var_60_0.pos then
		Vector3 = var_5
		var_60_3.localPosition = var_5(var_60_0.pos[1], var_60_0.pos[2], 0)
	else
		Vector3 = var_5
		var_60_3.localPosition = var_5.one
	end

	Vector3 = var_5

	local var_60_4

	if not var_60_0.scale then
		var_60_4 = 1
	end

	local var_60_5

	if not var_60_0.scale then
		var_60_5 = 1
	end

	var_60_3.localScale = var_5(var_60_4, var_60_5, 1)
	setActive = var_5

	var_5(arg_60_0.iconImage.gameObject, true)
	arg_60_2()

	return
end

function var_0_1.UpdateOptionTxt(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4)
	local var_61_0 = arg_61_2
	local var_61_1 = arg_61_2.GetComponent

	typeof = var_1_10007
	LayoutElement = var_1_10008

	local var_61_2 = var_61_1(var_61_0, var_1_10007(var_1_10008))
	local var_61_3 = arg_61_2
	local var_61_4 = arg_61_2.Find(var_61_3, "content")

	if arg_61_1 then
		GetPerceptualSize = var_61_3
		var_61_3 = var_61_3(arg_61_3)

		local var_61_5 = arg_61_2:Find("content_max")
		local var_61_6 = var_61_3 >= 17 and var_61_5 or var_61_4

		setActive = var_1_10011

		var_1_10011(var_61_4, not var_9)

		setActive = var_1_10011

		var_1_10011(var_61_5, var_9)

		setText = var_1_10011

		var_1_10011(var_61_6:Find("Text"), arg_61_3)

		var_61_2.preferredHeight = var_61_6.rect.height
	else
		setText = var_61_3

		var_61_3(var_61_4:Find("Text"), arg_61_3)

		var_61_2.preferredHeight = var_61_4.rect.height
	end

	arg_61_0:UpdateOptionBGWithTB(var_61_4, arg_61_4)

	return
end

function var_0_1.UpdateOptionBGWithTB(arg_62_0, arg_62_1, arg_62_2)
	getProxy = var_1_10003
	NewEducateProxy = var_1_10004

	local var_62_0 = var_1_10003(var_1_10004)
	local var_62_1 = var_3.GetCurChar(var_62_0)
	local var_62_2 = arg_62_1:Find("type1")
	local var_62_3 = arg_62_1
	local var_62_4 = arg_62_1.Find(var_62_3, "type2")

	if var_62_2 then
		setActive = var_62_3

		var_62_3(var_62_2, false)
	end

	if var_62_4 then
		setActive = var_62_3

		var_62_3(var_62_4, false)
	end

	local var_62_6

	if var_62_1 and var_62_2 then
		if arg_62_2 and arg_62_2 == 1 then
			local var_62_5 = var_62_1

			var_62_6 = var_62_1.GetPersonalityTagOptionBg(var_62_5, arg_62_2)
			LoadImageSpriteAsync = var_62_5

			var_62_5("neweducateicon/" .. var_62_6, var_62_2)
		end

		setActive = var_62_6

		var_62_6(var_62_2, var_6)
	end

	if var_62_1 and var_62_4 then
		if arg_62_2 and arg_62_2 == 2 then
			local var_62_7 = var_62_1

			var_62_6 = var_62_1.GetPersonalityTagOptionBg(var_62_7, arg_62_2)
			LoadImageSpriteAsync = var_62_7

			var_62_7("neweducateicon/" .. var_62_6, var_62_4)
		end

		setActive = var_62_6

		var_62_6(var_62_4, var_6)
	end

	if arg_62_1:Find("type3") then
		if arg_62_2 and arg_62_2 == 3 then
			local var_62_8 = arg_62_1
			local var_62_9 = arg_62_1.Find(var_62_8, "Text")

			Vector2 = var_62_8
			var_62_9.localPosition = var_62_8(20, 0)
			setActive = var_62_9

			var_62_9(arg_62_1:Find("type3"), true)
		else
			local var_62_10 = arg_62_1
			local var_62_11 = arg_62_1.Find(var_62_10, "Text")

			Vector2 = var_62_10
			var_62_11.localPosition = var_62_10.zero
			setActive = var_62_11

			var_62_11(arg_62_1:Find("type3"), false)
		end
	end

	if arg_62_2 and arg_62_2 == 3 and arg_62_1:Find("icon") then
		setActive = var_6

		var_6(arg_62_1:Find("icon"), false)

		GetSpriteFromAtlas = var_6

		local var_62_12 = var_6("ui/story_atlas", "option_bg_left_global")

		setImageSprite = var_7

		var_7(arg_62_1, var_62_12)
	end

	return
end

function var_0_1.InitBranches(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	local var_63_0 = false
	local var_63_1 = arg_63_2:GetOptions()
	local var_63_2, var_63_3 = arg_63_0:GetOptionContainer(arg_63_2)
	local var_63_4 = arg_63_2:GetId()
	local var_63_5

	if not arg_63_0.branchCodeList[var_63_4] then
		var_63_5 = {}
	end

	GetOrAddComponent = var_1_10011

	local var_63_6 = var_63_2.container

	typeof = var_1_10013
	CanvasGroup = var_1_10014

	local var_63_7 = var_1_10011(var_63_6, var_1_10013(var_1_10014))

	var_63_7.blocksRaycasts = true
	arg_63_0.selectedBranchID = nil

	var_63_2:make(function(arg_64_0, arg_64_1, arg_64_2)
		UIItemList = var_2_10003

		if arg_64_0 == var_2_10003.EventUpdate then
			local var_64_0 = arg_64_2
			local var_64_1 = var_63_1[arg_64_1 + 1][1]
			local var_64_2 = var_63_1[arg_64_1 + 1][2]
			local var_64_3 = var_63_1[arg_64_1 + 1][3]
			local var_64_4 = var_63_1[arg_64_1 + 1][4]

			table = var_8

			local var_64_5 = var_8.contains(var_63_5, var_64_2)

			onButton = var_9

			local var_64_6 = arg_63_0
			local var_64_7 = var_64_0

			local function var_64_8()
				if arg_63_0.pause or arg_63_0.stop then
					return
				end

				if not var_63_0 then
					return
				end

				arg_63_0.selectedBranchID = arg_64_1

				local var_65_0 = arg_63_0

				var_0.SetBranchCode(var_65_0, arg_63_1, arg_63_2, var_64_2)

				if var_64_4 then
					local var_65_1 = arg_63_0

					var_0.SetGlobalOptionFlag(var_65_1, var_64_4)
				end

				pg = var_0

				local var_65_2 = var_0.NewStoryMgr.GetInstance()
				local var_65_3 = var_0.TrackingOption
				local var_65_4 = arg_63_2

				var_65_3(var_65_2, var_2.GetOptionIndex(var_65_4), var_64_2)

				local var_65_5 = arg_64_2
				local var_65_6 = var_0.GetComponent

				typeof = var_2
				Animation = var_3

				if var_65_6(var_65_5, var_2(var_3)) then
					var_65_5 = var_63_7
					var_65_5.blocksRaycasts = false

					local var_65_7 = var_0

					var_65_5 = var_0.Play

					local var_65_8 = arg_63_0.script

					var_65_5(var_65_7, var_3.GetAnimPrefix(var_65_8) .. "confirm")

					local var_65_9 = arg_64_2

					var_65_5 = var_65_5.GetComponent
					typeof = var_3
					DftAniEvent = var_4

					local var_65_10 = var_65_5(var_65_9, var_3(var_4))

					var_65_5.SetEndEvent(var_65_10, function()
						setActive = var_4_10000

						var_4_10000(arg_63_0.optionsCg.gameObject, false)

						var_63_7.blocksRaycasts = true

						local var_66_0 = arg_63_0

						var_0.HideBranchesWithoutSelected(var_66_0, arg_63_2)
						arg_63_3(var_64_1)

						return
					end)
				else
					setActive = var_65_5

					var_65_5(arg_63_0.optionsCg.gameObject, false)

					local var_65_11 = arg_63_0

					var_1.HideBranchesWithoutSelected(var_65_11, arg_63_2)
					arg_63_3(var_64_1)
				end

				return
			end

			SFX_PANEL = var_2_10013

			var_9(var_64_6, var_64_7, var_64_8, var_2_10013)

			setButtonEnabled = var_9

			var_9(var_64_0, not var_64_5)

			GetOrAddComponent = var_9

			local var_64_9 = arg_64_2

			typeof = var_11
			CanvasGroup = var_64_8
			var_9(var_64_9, var_11(var_64_8)).alpha = var_64_5 and 0.5 or 1

			if var_64_4 then
				var_64_3 = 3
			end

			local var_64_10 = arg_63_0

			var_9.UpdateOptionTxt(var_64_10, var_63_3, var_64_0, var_64_1, var_64_3)

			local var_64_11 = arg_63_0.script

			if var_9.IsDialogueStyle2(var_64_11) then
				setActive = var_9

				var_9(var_64_0, arg_64_1 == 0)

				if 0 < arg_64_1 then
					LeanTween = var_9

					local var_64_12 = var_9.delayedCall
					local var_64_13 = 0.066 * arg_64_1

					System = var_11

					var_64_12(var_64_13, var_11.Action(function()
						setActive = var_3_10000

						var_3_10000(var_64_0, true)

						return
					end))
				end
			end
		end

		return
	end)
	var_63_2:align(#var_63_1)
	arg_63_0:ShowBranches(arg_63_2, function()
		var_63_0 = true

		if arg_63_4 then
			arg_63_4()
		end

		return
	end)

	return
end

function var_0_1.SetBranchCode(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	arg_69_2:SetBranchCode(arg_69_3)
	arg_69_1:SetBranchCode(arg_69_3)

	local var_69_0 = arg_69_2:GetId()
	local var_69_1

	if not arg_69_0.branchCodeList[var_69_0] then
		var_69_1 = arg_69_0.branchCodeList
		var_69_1[var_69_0] = {}
	end

	table = var_69_1

	var_69_1.insert(arg_69_0.branchCodeList[var_69_0], arg_69_3)

	return
end

function var_0_1.SetGlobalOptionFlag(arg_70_0, arg_70_1)
	StoryStep = var_1_10002

	local var_70_0 = var_1_10002.GetGlobalFlagKey(arg_70_1.flagID) .. arg_70_1.flagIndex

	PlayerPrefs = var_3

	var_3.SetInt(var_70_0, arg_70_1.flagValue)

	return
end

function var_0_1.ShowBranches(arg_71_0, arg_71_1, arg_71_2)
	setActive = var_1_10003

	var_1_10003(arg_71_0.optionsCg.gameObject, true)

	local var_71_0 = arg_71_0:GetOptionContainer(arg_71_1)

	for iter_71_0 = 0, var_71_0.container.childCount - 1 do
		local var_71_1 = var_71_0.container
		local var_71_2 = var_8.GetChild(var_71_1, iter_71_0)
		local var_71_3 = var_8.GetComponent

		typeof = var_1_10011
		Animation = var_1_10012

		if var_71_3(var_71_2, var_1_10011(var_1_10012)) then
			var_1_10011 = var_9

			local var_71_4 = var_9.Play
			local var_71_5 = arg_71_0.script

			var_71_4(var_1_10011, var_1_10012.GetAnimPrefix(var_71_5) .. "in")
		end
	end

	arg_71_2()

	return
end

function var_0_1.HideBranchesWithoutSelected(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0:GetOptionContainer(arg_72_1)

	for iter_72_0 = 0, var_72_0.container.childCount - 1 do
		if iter_72_0 ~= arg_72_0.selectedBranchID then
			local var_72_1 = var_72_0.container
			local var_72_2 = var_7.GetChild(var_72_1, iter_72_0)
			local var_72_3 = var_7.GetComponent

			typeof = var_1_10010
			Animation = var_1_10011

			if var_72_3(var_72_2, var_1_10010(var_1_10011)) then
				var_1_10010 = var_8

				local var_72_4 = var_8.Play
				local var_72_5 = arg_72_0.script

				var_72_4(var_1_10010, var_1_10011.GetAnimPrefix(var_72_5) .. "unselected")
			end
		end
	end

	return
end

function var_0_1.StartMoveNode(arg_73_0, arg_73_1, arg_73_2)
	if not arg_73_1:ExistMovableNode() then
		arg_73_2()

		return
	end

	local var_73_0 = arg_73_1:GetMovableNode()
	local var_73_1 = {}
	local var_73_2 = {}

	pairs = var_1_10006

	for iter_73_0, iter_73_1 in var_1_10006(var_73_0) do
		table = var_1_10011

		var_1_10011.insert(var_73_1, function(arg_74_0)
			local var_74_0 = arg_73_0

			var_1.LoadMovableNode(var_74_0, iter_73_1, function(arg_75_0)
				var_73_2[iter_73_0] = arg_75_0

				arg_74_0()

				return
			end)

			return
		end)
	end

	parallelAsync = var_6

	var_6(var_73_1, function()
		local var_76_0 = arg_73_0

		var_0.MoveAllNode(var_76_0, arg_73_1, var_73_2, var_73_0)
		arg_73_2()

		return
	end)

	return
end

function var_0_1.MoveAllNode(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	local var_77_0 = {}

	pairs = var_1_10005

	for iter_77_0, iter_77_1 in var_1_10005(arg_77_2) do
		table = var_1_10010

		var_1_10010.insert(var_77_0, function(arg_78_0)
			local var_78_0 = arg_77_3[iter_77_0].path
			local var_78_1 = var_1.time
			local var_78_2 = var_1.easeType
			local var_78_3 = var_1.delay
			local var_78_4 = arg_77_0

			var_6.moveLocalPath(var_78_4, iter_77_1, var_78_0, var_78_1, var_78_3, var_78_2, arg_78_0)

			return
		end)
	end

	arg_77_0.moveTargets = arg_77_2
	parallelAsync = var_5

	var_5(var_77_0, function()
		local var_79_0 = arg_77_0

		var_0.ClearMoveNodes(var_79_0, arg_77_1)

		return
	end)

	return
end

local function var_0_13(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4)
	SpineAnimChar = var_1_10005
	arg_80_0.spineChar = var_1_10005.New()

	local var_80_0 = arg_80_0.spineChar

	var_5.SetPaint(var_80_0, arg_80_1)

	local var_80_1 = arg_80_0.spineChar

	var_5.Load(var_80_1, true, function(arg_81_0)
		arg_81_0:SetParent(arg_80_0.movePanel)

		local var_81_0 = arg_81_0
		local var_81_1 = arg_81_0.SetLocalScale

		Vector3 = var_3

		var_81_1(var_81_0, var_3(arg_80_2.scale, arg_80_2.scale, 0))
		arg_81_0:SetLocalPosition(arg_80_3)
		arg_81_0:SetAction(arg_80_2.action, 0)
		arg_81_0:SetName(arg_80_1)

		if arg_80_4 then
			local var_81_2 = arg_80_4
			local var_81_3 = arg_80_0.spineChar

			var_81_2(var_2.GetModel(var_81_3))
		end

		return
	end)

	return
end

local function var_0_14(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	GameObject = var_1_10004

	local var_82_0 = var_1_10004.New("movable").transform

	var_5.SetParent(var_82_0, arg_82_0.movePanel)

	local var_82_1 = var_4.transform

	Vector3 = var_82_0
	var_82_1.localScale = var_82_0.zero
	GetOrAddComponent = var_82_1

	local var_82_2 = var_4

	typeof = var_7
	RectTransform = var_1_10008

	local var_82_3 = var_82_1(var_82_2, var_7(var_1_10008))

	GetOrAddComponent = var_82_2

	local var_82_4 = var_4

	typeof = var_1_10008
	Image = var_1_10009

	local var_82_5 = var_82_2(var_82_4, var_1_10008(var_1_10009))

	LoadSpriteAsync = var_82_4

	var_82_4(arg_82_1, function(arg_83_0)
		var_82_5.sprite = arg_83_0

		local var_83_0 = var_82_5

		var_1.SetNativeSize(var_83_0)

		local var_83_1 = var_82_3

		Vector3 = var_83_0
		var_83_1.localScale = var_83_0.one
		var_82_3.localPosition = arg_82_2

		arg_82_3(var_82_3.gameObject)

		return
	end)

	return
end

function var_0_1.LoadMovableNode(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0

	if not arg_84_1.path[1] then
		Vector3 = var_84_0
		var_84_0 = var_84_0.zero
	end

	if arg_84_1.isSpine then
		var_0_13(arg_84_0, arg_84_1.name, arg_84_1.spineData, var_84_0, arg_84_2)
	else
		var_0_14(arg_84_0, arg_84_1.name, var_84_0, arg_84_2)
	end

	return
end

function var_0_1.ClearMoveNodes(arg_85_0, arg_85_1)
	if not arg_85_1:ExistMovableNode() then
		return
	end

	if arg_85_0.movePanel.childCount <= 0 then
		return
	end

	ipairs = var_2

	local var_85_0

	if not arg_85_0.moveTargets then
		var_85_0 = {}
	end

	for iter_85_0, iter_85_1 in var_2(var_85_0) do
		local var_85_1 = iter_85_1
		local var_85_2 = iter_85_1.GetComponent

		typeof = var_1_10009
		SpineAnimUI = var_1_10010

		if var_85_2(var_85_1, var_1_10009(var_1_10010)) ~= nil then
			PoolMgr = var_85_1
			var_1_10009 = var_85_1.GetInstance()

			var_85_1.ReturnSpineChar(var_1_10009, iter_85_1.name, iter_85_1.gameObject)
		else
			Destroy = var_85_1
			var_1_10010 = arg_85_0.movePanel

			var_85_1(var_1_10009.GetChild(var_1_10010, iter_85_0 - 1))
		end
	end

	arg_85_0.moveTargets = {}

	return
end

function var_0_1.FadeOutStory(arg_86_0, arg_86_1, arg_86_2)
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

function var_0_1.GetFadeColor(arg_87_0, arg_87_1)
	local var_87_0 = {}
	local var_87_1 = {}
	local var_87_2 = arg_87_1
	local var_87_3 = arg_87_1.GetComponentsInChildren

	typeof = var_1_10006
	Image = var_1_10007

	local var_87_4 = var_87_3(var_87_2, var_1_10006(var_1_10007))
	local var_87_5 = var_4.ToTable(var_87_4)

	ipairs = var_87_4

	for iter_87_0, iter_87_1 in var_87_4(var_87_5) do
		local var_87_6 = {
			name = "_Color"
		}

		Color = var_1_10011
		var_87_6.color = var_1_10011.white

		if iter_87_1.material.shader.name == "UI/GrayScale" then
			var_1_10011 = {
				name = "_GrayScale"
			}
			Color = var_1_10012
			var_1_10011.color = var_1_10012.New(0.21176470588235294, 0.7137254901960784, 0.07058823529411765)
			var_87_6 = var_1_10011
		elseif iter_87_1.material.shader.name == "UI/Line_Add_Blue" then
			var_1_10011 = {
				name = "_GrayScale"
			}
			Color = var_1_10012
			var_1_10011.color = var_1_10012.New(1, 1, 1, 0.5882352941176471)
			var_87_6 = var_1_10011
		end

		table = var_1_10011

		var_1_10011.insert(var_87_1, var_87_6)

		if iter_87_1.material == iter_87_1.defaultGraphicMaterial then
			Material = var_1_10011
			iter_87_1.material = var_1_10011.Instantiate(iter_87_1.defaultGraphicMaterial)
		end

		table = var_1_10011

		var_1_10011.insert(var_87_0, iter_87_1.material)
	end

	return var_87_0, var_87_1
end

function var_0_1._SetFadeColor(arg_88_0, arg_88_1, arg_88_2, arg_88_3)
	ipairs = var_1_10004

	for iter_88_0, iter_88_1 in var_1_10004(arg_88_1) do
		IsNil = var_1_10009

		if not var_1_10009(iter_88_1) then
			local var_88_0 = iter_88_1

			var_1_10009 = iter_88_1.SetColor

			local var_88_1 = arg_88_2[iter_88_0].name
			local var_88_2 = arg_88_2[iter_88_0].color

			Color = var_1_10013

			var_1_10009(var_88_0, var_88_1, var_88_2 * var_1_10013.New(arg_88_3, arg_88_3, arg_88_3))
		end
	end

	return
end

function var_0_1.SetFadeColor(arg_89_0, arg_89_1, arg_89_2)
	local var_89_0, var_89_1 = arg_89_0:GetFadeColor(arg_89_1)

	arg_89_0:_SetFadeColor(var_89_0, var_89_1, arg_89_2)

	return
end

function var_0_1._RevertFadeColor(arg_90_0, arg_90_1, arg_90_2)
	arg_90_0:_SetFadeColor(arg_90_1, arg_90_2, 1)

	return
end

function var_0_1.RevertFadeColor(arg_91_0, arg_91_1)
	local var_91_0, var_91_1 = arg_91_0:GetFadeColor(arg_91_1)

	arg_91_0:_RevertFadeColor(var_91_0, var_91_1)

	return
end

function var_0_1.fadeTransform(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4, arg_92_5, arg_92_6)
	if arg_92_4 <= 0 then
		if arg_92_6 then
			arg_92_6()
		end

		return
	end

	local var_92_0, var_92_1 = arg_92_0:GetFadeColor(arg_92_1)

	LeanTween = var_9

	local var_92_2 = var_9.value

	go = var_1_10010

	local var_92_3 = var_92_2(var_1_10010(arg_92_1), arg_92_2, arg_92_3, arg_92_4)
	local var_92_4 = var_9.setOnUpdate

	System = var_11

	local var_92_5 = var_92_4(var_92_3, var_11.Action_float(function(arg_93_0)
		local var_93_0 = arg_92_0

		var_1._SetFadeColor(var_93_0, var_92_0, var_92_1, arg_93_0)

		return
	end))
	local var_92_6 = var_9.setOnComplete

	System = var_11

	var_92_6(var_92_5, var_11.Action(function()
		if arg_92_5 then
			local var_94_0 = arg_92_0

			var_0._RevertFadeColor(var_94_0, var_92_0, var_92_1)
		end

		if arg_92_6 then
			arg_92_6()
		end

		return
	end))

	return
end

function var_0_1.setPaintingAlpha(arg_95_0, arg_95_1, arg_95_2)
	local var_95_0 = {}
	local var_95_1 = {}
	local var_95_2 = arg_95_1
	local var_95_3 = arg_95_1.GetComponentsInChildren

	typeof = var_1_10007
	Image = var_1_10008

	local var_95_4 = var_95_3(var_95_2, var_1_10007(var_1_10008))
	local var_95_5 = var_5.ToTable(var_95_4)

	ipairs = var_95_4

	for iter_95_0, iter_95_1 in var_95_4(var_95_5) do
		var_1_10011 = {
			name = "_Color"
		}
		Color = var_1_10012
		var_1_10011.color = var_1_10012.white

		if iter_95_1.material.shader.name == "UI/GrayScale" then
			var_1_10012 = {
				name = "_GrayScale"
			}
			Color = var_1_10013
			var_1_10012.color = var_1_10013.New(0.21176470588235294, 0.7137254901960784, 0.07058823529411765)
			var_1_10011 = var_1_10012
		elseif iter_95_1.material.shader.name == "UI/Line_Add_Blue" then
			var_1_10012 = {
				name = "_GrayScale"
			}
			Color = var_1_10013
			var_1_10012.color = var_1_10013.New(1, 1, 1, 0.5882352941176471)
			var_1_10011 = var_1_10012
		end

		table = var_1_10012

		var_1_10012.insert(var_95_1, var_1_10011)

		if iter_95_1.material == iter_95_1.defaultGraphicMaterial then
			Material = var_1_10012
			iter_95_1.material = var_1_10012.Instantiate(iter_95_1.defaultGraphicMaterial)
		end

		table = var_1_10012

		var_1_10012.insert(var_95_0, iter_95_1.material)
	end

	ipairs = var_6

	for iter_95_2, iter_95_3 in var_6(var_95_0) do
		IsNil = var_1_10011

		if not var_1_10011(iter_95_3) then
			local var_95_6 = iter_95_3

			var_1_10011 = iter_95_3.SetColor

			local var_95_7 = var_95_1[iter_95_2].name
			local var_95_8 = var_95_1[iter_95_2].color

			Color = var_1_10015

			var_1_10011(var_95_6, var_95_7, var_95_8 * var_1_10015.New(arg_95_2, arg_95_2, arg_95_2))
		end
	end

	return
end

function var_0_1.RegisetEvent(arg_96_0, arg_96_1, arg_96_2)
	setButtonEnabled = var_1_10003

	var_1_10003(arg_96_0._go, not arg_96_0.autoNext)

	onButton = var_1_10003

	local var_96_0 = arg_96_0
	local var_96_1 = arg_96_0._go

	local function var_96_2()
		if arg_96_0.pause or arg_96_0.stop then
			return
		end

		removeOnButton = var_0

		var_0(arg_96_0._go)
		arg_96_2()

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_96_0, var_96_1, var_96_2, var_1_10007)

	return
end

function var_0_1.flashEffect(arg_98_0, arg_98_1, arg_98_2, arg_98_3, arg_98_4, arg_98_5, arg_98_6)
	local var_98_0 = arg_98_0.flashImg

	if arg_98_4 then
		Color = var_1_10008

		if not var_1_10008(0, 0, 0) then
			Color = var_1_10008
			var_1_10008 = var_1_10008(1, 1, 1)
		end

		var_98_0.color = var_1_10008

		local var_98_1 = arg_98_0.flashCg

		var_98_1.alpha = arg_98_1
		setActive = var_98_1

		var_98_1(arg_98_0.flash, true)
		arg_98_0:TweenValueForcanvasGroup(arg_98_0.flashCg, arg_98_1, arg_98_2, arg_98_3, arg_98_5, arg_98_6)

		return
	end
end

function var_0_1.Flashout(arg_99_0, arg_99_1, arg_99_2)
	local var_99_0, var_99_1, var_99_2, var_99_3 = arg_99_1:GetFlashoutData()

	if not var_99_0 then
		arg_99_2()

		return
	end

	arg_99_0:flashEffect(var_99_0, var_99_1, var_99_2, var_99_3, 0, arg_99_2)

	return
end

function var_0_1.flashin(arg_100_0, arg_100_1, arg_100_2)
	local var_100_0, var_100_1, var_100_2, var_100_3, var_100_4 = arg_100_1:GetFlashinData()

	if not var_100_0 then
		arg_100_2()

		return
	end

	arg_100_0:flashEffect(var_100_0, var_100_1, var_100_2, var_100_3, var_100_4, arg_100_2)

	return
end

function var_0_1.UpdateBg(arg_101_0, arg_101_1)
	if arg_101_1:ShouldBgGlitchArt() then
		arg_101_0:SetBgGlitchArt(arg_101_1)
	else
		local var_101_0 = arg_101_1

		if arg_101_1.GetBgName(var_101_0) then
			setActive = var_101_0

			var_101_0(arg_101_0.bgPanel, true)

			arg_101_0.bgPanelCg.alpha = 1

			local var_101_1 = arg_101_0.bgImage

			Color = var_4
			var_101_1.color = var_4.New(1, 1, 1)
			var_1_10005 = arg_101_0
			var_101_1.sprite = arg_101_0.GetBg(var_1_10005, var_2)
		end

		if arg_101_1:GetBgShadow() then
			local var_101_2 = arg_101_0.bgImage

			var_1_10006 = arg_101_0

			arg_101_0.TweenValue(var_1_10006, var_101_2, var_3[1], var_3[2], var_3[3], 0, function(arg_102_0)
				local var_102_0 = var_101_2

				Color = var_2_10002
				var_102_0.color = var_2_10002.New(arg_102_0, arg_102_0, arg_102_0)

				return
			end, nil)
		end

		var_1_10005 = arg_101_1

		if arg_101_1.IsBlackBg(var_1_10005) then
			setActive = var_4

			var_4(arg_101_0.curtain, true)

			arg_101_0.curtainCg.alpha = 1
		end

		var_1_10005 = arg_101_1

		local var_101_3

		var_101_3, var_1_10005 = arg_101_1.IsBlackFrontGround(var_1_10005)

		if var_101_3 then
			var_1_10006 = arg_101_0.curtainFCg
			var_1_10006.alpha = var_1_10005
		end

		setActive = var_1_10006

		var_1_10006(arg_101_0.curtainF, var_101_3)
	end

	arg_101_0:ApplyOldPhotoEffect(arg_101_1)
	arg_101_0:OnBgUpdate(arg_101_1)

	local var_101_4 = arg_101_1:GetBgColor()
	local var_101_5 = arg_101_0.curtain
	local var_101_6 = var_3.GetComponent

	typeof = var_1_10005
	Image = var_1_10006
	var_101_6(var_101_5, var_1_10005(var_1_10006)).color = var_101_4

	return
end

function var_0_1.ApplyOldPhotoEffect(arg_103_0, arg_103_1)
	local var_103_0 = arg_103_1:OldPhotoEffect() ~= nil

	setActive = var_1_10004

	var_1_10004(arg_103_0.oldPhoto.gameObject, var_103_0)

	if var_103_0 then
		type = var_1_10004

		if var_1_10004(var_2) == "table" then
			local var_103_1 = arg_103_0.oldPhoto

			Color = var_5
			var_103_1.color = var_5.New(var_2[1], var_2[2], var_2[3], var_2[4])
		else
			local var_103_2 = arg_103_0.oldPhoto

			Color = var_5
			var_103_2.color = var_5.New(0.62, 0.58, 0.14, 0.36)
		end
	end

	return
end

function var_0_1.SetBgGlitchArt(arg_104_0, arg_104_1)
	setActive = var_1_10002

	var_1_10002(arg_104_0.bgPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_104_0.bgGlitch, true)

	return
end

function var_0_1.GetBg(arg_105_0, arg_105_1)
	if not arg_105_0.bgs[arg_105_1] then
		local var_105_0 = arg_105_0.bgs

		LoadSprite = var_1_10003
		var_105_0[arg_105_1] = var_1_10003("bg/" .. arg_105_1)
	end

	return arg_105_0.bgs[arg_105_1]
end

function var_0_1.LoadEffects(arg_106_0, arg_106_1, arg_106_2)
	if #arg_106_1:GetEffects() <= 0 then
		arg_106_2()

		return
	end

	local var_106_0 = {}

	ipairs = var_5

	for iter_106_0, iter_106_1 in var_5(var_3) do
		local var_106_1 = iter_106_1.name
		local var_106_2 = iter_106_1.active
		local var_106_3 = iter_106_1.interlayer
		local var_106_4 = iter_106_1.center
		local var_106_5 = iter_106_1.adapt
		local var_106_6 = arg_106_0.effectPanel
		local var_106_7

		if not var_15.Find(var_106_6, var_106_1) then
			var_106_6 = arg_106_0.centerPanel
			var_106_7 = var_15.Find(var_106_6, var_106_1)
		end

		local var_106_8

		if var_106_7 then
			setActive = var_106_6

			var_106_6(var_106_7, var_106_2)

			setParent = var_106_6
			var_106_8 = var_106_7

			local var_106_9

			if not var_106_4 or not arg_106_0.centerPanel then
				var_106_9 = arg_106_0.effectPanel.transform
			end

			var_106_6(var_106_8, var_106_9)

			if var_106_3 then
				var_106_8 = arg_106_0

				arg_106_0.UpdateEffectInterLayer(var_106_8, var_106_1, var_106_7)
			end

			if not var_106_2 then
				var_106_8 = arg_106_0

				arg_106_0.ClearEffectInterlayer(var_106_8, var_106_1)
			else
				isActive = var_106_6

				if var_106_6(var_106_7) then
					setActive = var_16

					var_16(var_106_7, false)

					setActive = var_16

					var_16(var_106_7, true)
				end
			end

			if var_106_5 then
				var_106_8 = arg_106_0

				arg_106_0.AdaptEffect(var_106_8, var_106_7)
			end
		else
			local var_106_10 = ""

			checkABExist = var_106_8

			if var_106_8("ui/" .. var_106_1) then
				var_106_10 = "ui"
			else
				checkABExist = var_17

				if var_17("effect/" .. var_106_1) then
					var_106_10 = "effect"
				end
			end

			if var_106_10 and var_106_10 ~= "" then
				table = var_17

				var_17.insert(var_106_0, function(arg_107_0)
					LoadAndInstantiateAsync = var_2_10001

					var_2_10001(var_106_10, var_106_1, function(arg_108_0)
						setParent = var_3_10001

						local var_108_0 = arg_108_0
						local var_108_1

						if not var_106_4 or not arg_106_0.centerPanel then
							var_108_1 = arg_106_0.effectPanel.transform
						end

						var_3_10001(var_108_0, var_108_1)

						local var_108_2 = arg_108_0.transform

						Vector3 = var_108_0
						var_108_2.localScale = var_108_0.one
						setActive = var_108_2

						var_108_2(arg_108_0, var_106_2)

						arg_108_0.name = var_106_1

						if var_106_3 then
							local var_108_3 = arg_106_0

							var_1.UpdateEffectInterLayer(var_108_3, var_106_1, arg_108_0)
						end

						if var_106_2 == false then
							local var_108_4 = arg_106_0

							var_1.ClearEffectInterlayer(var_108_4, var_106_1)
						end

						if var_106_5 then
							local var_108_5 = arg_106_0

							var_1.AdaptEffect(var_108_5, arg_108_0)
						end

						arg_107_0()

						return
					end)

					return
				end)
			else
				originalPrint = var_17

				var_17("not found effect", var_106_1)
			end
		end
	end

	parallelAsync = var_5

	var_5(var_106_0, arg_106_2)

	return
end

function var_0_1.AdaptEffect(arg_109_0, arg_109_1)
	local var_109_0 = 1.7777777777777777

	pg = var_1_10003

	local var_109_1 = var_1_10003.UIMgr.GetInstance().OverlayMain.parent.sizeDelta.x / var_3.y
	local var_109_2 = 1

	if var_109_0 < var_109_1 then
		var_109_2 = var_109_1 / var_109_0
	else
		var_109_2 = var_109_0 / var_109_1
	end

	tf = var_1_10006

	local var_109_3 = var_1_10006(arg_109_1)

	Vector3 = var_7
	var_109_3.localScale = var_7(var_109_2, var_109_2, var_109_2)

	return
end

function var_0_1.UpdateEffectInterLayer(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = arg_110_0._go
	local var_110_1 = var_3.GetComponent

	typeof = var_1_10005
	Canvas = var_1_10006

	local var_110_2 = var_110_1(var_110_0, var_1_10005(var_1_10006)).sortingOrder
	local var_110_3 = arg_110_2
	local var_110_4 = arg_110_2.GetComponentsInChildren

	typeof = var_1_10006

	local var_110_5 = var_110_4(var_110_3, var_1_10006("UnityEngine.ParticleSystemRenderer"))
	local var_110_6 = var_4.ToTable(var_110_5)

	ipairs = var_110_5

	for iter_110_0, iter_110_1 in var_110_5(var_110_6) do
		ReflectionHelp = var_1_10010
		var_1_10010 = var_1_10010.RefGetProperty
		typeof = var_1_10011

		if var_110_2 < var_1_10010(var_1_10011("UnityEngine.ParticleSystemRenderer"), "sortingOrder", iter_110_1) then
			var_110_2 = var_1_10010
		end
	end

	local var_110_7 = var_110_2 + 1

	GetOrAddComponent = var_5

	local var_110_8 = arg_110_0.actorTr

	typeof = var_7
	Canvas = iter_110_0

	local var_110_9 = var_5(var_110_8, var_7(iter_110_0))

	var_110_9.overrideSorting = true
	var_110_9.sortingOrder = var_110_7
	GetOrAddComponent = var_6

	local var_110_10 = arg_110_0.frontTr

	typeof = iter_110_0
	Canvas = iter_110_1

	local var_110_11 = var_6(var_110_10, iter_110_0(iter_110_1))

	var_110_11.overrideSorting = true
	var_110_11.sortingOrder = var_110_7 + 1
	arg_110_0.activeInterLayer = arg_110_1
	GetOrAddComponent = var_7

	local var_110_12 = arg_110_0.frontTr

	typeof = iter_110_1
	GraphicRaycaster = var_1_10010

	var_7(var_110_12, iter_110_1(var_1_10010))

	return
end

function var_0_1.ClearEffectInterlayer(arg_111_0, arg_111_1)
	if arg_111_0.activeInterLayer == arg_111_1 then
		RemoveComponent = var_2

		var_2(arg_111_0.frontTr, "GraphicRaycaster")

		RemoveComponent = var_2

		var_2(arg_111_0.actorTr, "Canvas")

		RemoveComponent = var_2

		var_2(arg_111_0.frontTr, "Canvas")

		arg_111_0.activeInterLayer = nil
	end

	return
end

function var_0_1.ClearEffects(arg_112_0)
	removeAllChildren = var_1_10001

	var_1_10001(arg_112_0.effectPanel)

	removeAllChildren = var_1_10001

	var_1_10001(arg_112_0.centerPanel)

	if arg_112_0.activeInterLayer ~= nil then
		arg_112_0:ClearEffectInterlayer(arg_112_0.activeInterLayer)
	end

	return
end

function var_0_1.PlaySoundEffect(arg_113_0, arg_113_1)
	if arg_113_1:ShouldPlaySoundEffect() then
		local var_113_0, var_113_1 = arg_113_1:GetSoundeffect()

		arg_113_0:DelayCall(var_113_1, function()
			pg = var_2_10000

			local var_114_0 = var_2_10000.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_114_0, var_113_0)

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

function var_0_1.StopVoice(arg_115_0)
	if arg_115_0.currentVoice then
		local var_115_0 = arg_115_0.currentVoice

		var_1.Stop(var_115_0, true)

		arg_115_0.currentVoice = nil
	end

	return
end

function var_0_1.PlayVoice(arg_116_0, arg_116_1)
	if arg_116_0.voiceDelayTimer then
		local var_116_0 = arg_116_0.voiceDelayTimer

		var_2.Stop(var_116_0)

		arg_116_0.voiceDelayTimer = nil
	end

	arg_116_0:StopVoice()

	local var_116_1, var_116_2 = arg_116_1:GetVoice()
	local var_116_3

	arg_116_0.voiceDelayTimer = arg_116_0:CreateDelayTimer(var_116_2, function()
		if var_116_3 then
			local var_117_0 = var_116_3

			var_0.Stop(var_117_0)
		end

		local var_117_1

		if arg_116_0.voiceDelayTimer then
			var_117_1 = arg_116_0
			var_117_1.voiceDelayTimer = nil
		end

		pg = var_117_1

		local var_117_2 = var_117_1.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_117_2, var_116_1, function(arg_118_0)
			if arg_118_0 then
				arg_116_0.currentVoice = arg_118_0.playback
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.Reset(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	setActive = var_1_10004

	var_1_10004(arg_119_0.spAnimPanel, false)

	setActive = var_1_10004

	var_1_10004(arg_119_0.castPanel, false)

	setActive = var_1_10004

	var_1_10004(arg_119_0.bgPanel, false)

	if arg_119_1 and arg_119_1:IsDialogueMode() and arg_119_2 and arg_119_2:IsDialogueMode() then
		-- block empty
	else
		setActive = var_1_10004

		var_1_10004(arg_119_0.dialoguePanel, false)
	end

	setActive = var_1_10004

	var_1_10004(arg_119_0.asidePanel, false)

	setActive = var_1_10004

	var_1_10004(arg_119_0.curtain, false)

	setActive = var_1_10004

	var_1_10004(arg_119_0.flash, false)

	setActive = var_1_10004

	var_1_10004(arg_119_0.optionsCg.gameObject, false)

	setActive = var_1_10004

	var_1_10004(arg_119_0.bgGlitch, false)

	setActive = var_1_10004

	var_1_10004(arg_119_0.locationTr, false)

	arg_119_0.locationTr.localPosition = arg_119_0.locationTrPos
	arg_119_0.locationStatus = var_0_10
	arg_119_0.flashCg.alpha = 1
	arg_119_0.goCG.alpha = 1

	local var_119_0 = arg_119_0.animationPlayer

	var_4.Stop(var_119_0)
	arg_119_0:OnReset(arg_119_1, arg_119_2, arg_119_3)

	return
end

function var_0_1.Clear(arg_120_0, arg_120_1)
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

	pg = var_2

	var_2.DelegateInfo.New(arg_120_0)

	return
end

function var_0_1.StoryEnd(arg_121_0, arg_121_1)
	setActive = var_1_10002

	var_1_10002(arg_121_0.iconImage.gameObject, false)

	arg_121_0.iconImage.sprite = nil
	arg_121_0.branchCodeList = {}
	arg_121_0.stop = false
	arg_121_0.pause = false

	if arg_121_0.voiceDelayTimer then
		local var_121_0 = arg_121_0.voiceDelayTimer

		var_2.Stop(var_121_0)

		arg_121_0.voiceDelayTimer = nil
	end

	if arg_121_0.currentVoice then
		local var_121_1 = arg_121_0.currentVoice

		var_2.Stop(var_121_1, true)

		arg_121_0.currentVoice = nil
	end

	arg_121_0:ClearCheckDispatcher()
	arg_121_0:ClearEffects()
	arg_121_0:Clear()
	arg_121_0:OnEnd(arg_121_1)

	return
end

function var_0_1.PlayBgm(arg_122_0, arg_122_1)
	if arg_122_1:ShouldStopBgm() then
		arg_122_0:StopBgm()
	end

	if arg_122_1:ShoulePlayBgm() then
		local var_122_0, var_122_1, var_122_2 = arg_122_1:GetBgmData()

		arg_122_0:DelayCall(var_122_1, function()
			local var_123_0 = arg_122_0

			var_0.RevertBgmVolume(var_123_0)

			pg = var_0

			local var_123_1 = var_0.BgmMgr.GetInstance()

			var_0.TempPlay(var_123_1, var_122_0)

			return
		end)

		if var_122_2 and 0 < var_122_2 then
			pg = var_5

			local var_122_3 = var_5.CriMgr.GetInstance()

			arg_122_0.defaultBgmVolume = var_5.getBGMVolume(var_122_3)
			pg = var_122_3

			local var_122_4 = var_122_3.CriMgr.GetInstance()

			var_6.setBGMVolume(var_122_4, var_122_2)
		end
	end

	return
end

function var_0_1.StopBgm(arg_124_0, arg_124_1)
	arg_124_0:RevertBgmVolume()

	pg = var_2

	local var_124_0 = var_2.BgmMgr.GetInstance()

	var_2.StopPlay(var_124_0)

	return
end

function var_0_1.RevertBgmVolume(arg_125_0)
	if arg_125_0.defaultBgmVolume then
		pg = var_1

		local var_125_0 = var_1.CriMgr.GetInstance()

		var_1.setBGMVolume(var_125_0, arg_125_0.defaultBgmVolume)

		arg_125_0.defaultBgmVolume = nil
	end

	return
end

function var_0_1.StartUIAnimations(arg_126_0, arg_126_1, arg_126_2)
	parallelAsync = var_1_10003

	var_1_10003({
		function(arg_127_0)
			local var_127_0 = arg_126_0

			var_1.StartBlinkAnimation(var_127_0, arg_126_1, arg_127_0)

			return
		end,
		function(arg_128_0)
			local var_128_0 = arg_126_0

			var_1.StartBlinkWithColorAnimation(var_128_0, arg_126_1, arg_128_0)

			return
		end,
		function(arg_129_0)
			local var_129_0 = arg_126_0

			var_1.OnStartUIAnimations(var_129_0, arg_126_1, arg_129_0)

			return
		end
	}, arg_126_2)

	return
end

function var_0_1.StartBlinkAnimation(arg_130_0, arg_130_1, arg_130_2)
	if arg_130_1:ShouldBlink() then
		local var_130_0 = arg_130_1:GetBlinkData().black
		local var_130_1 = var_3.number
		local var_130_2 = var_3.dur
		local var_130_3 = var_3.delay
		local var_130_4 = var_3.alpha[1]
		local var_130_5 = var_3.alpha[2]
		local var_130_6 = var_3.wait
		local var_130_7 = arg_130_0.flashImg

		if var_130_0 then
			Color = var_1_10012

			if not var_1_10012(0, 0, 0) then
				Color = var_1_10012
				var_1_10012 = var_1_10012(1, 1, 1)
			end

			var_130_7.color = var_1_10012
			setActive = var_130_7

			var_130_7(arg_130_0.flash, true)

			local var_130_8 = {}

			for iter_130_0 = 1, var_130_1 do
				table = var_1_10016

				var_1_10016.insert(var_130_8, function(arg_131_0)
					local var_131_0 = arg_130_0

					var_1.TweenAlpha(var_131_0, arg_130_0.flash, var_130_4, var_130_5, var_130_2 / 2, 0, function()
						local var_132_0 = arg_130_0

						var_0.TweenAlpha(var_132_0, arg_130_0.flash, var_130_5, var_130_4, var_130_2 / 2, var_130_6, arg_131_0)

						return
					end)

					return
				end)
			end

			seriesAsync = var_12

			var_12(var_130_8, function()
				setActive = var_2_10000

				var_2_10000(arg_130_0.flash, false)

				return
			end)
			arg_130_2()

			return
		end
	end
end

function var_0_1.StartBlinkWithColorAnimation(arg_134_0, arg_134_1, arg_134_2)
	if arg_134_1:ShouldBlinkWithColor() then
		local var_134_0 = arg_134_1:GetBlinkWithColorData().color
		local var_134_1 = var_3.alpha
		local var_134_2 = arg_134_0.flashImg

		Color = var_1_10007
		var_134_2.color = var_1_10007(var_134_0[1], var_134_0[2], var_134_0[3], var_134_0[4])
		setActive = var_134_2

		var_134_2(arg_134_0.flash, true)

		local var_134_3 = {}

		ipairs = var_7

		for iter_134_0, iter_134_1 in var_7(var_134_1) do
			local var_134_4 = iter_134_1[1]
			local var_134_5 = iter_134_1[2]
			local var_134_6 = iter_134_1[3]
			local var_134_7 = iter_134_1[4]

			table = var_1_10016

			var_1_10016.insert(var_134_3, function(arg_135_0)
				local var_135_0 = arg_134_0

				var_1.TweenValue(var_135_0, arg_134_0.flash, var_134_4, var_134_5, var_134_6, var_134_7, function(arg_136_0)
					arg_134_0.flashCg.alpha = arg_136_0

					return
				end, arg_135_0)

				return
			end)
		end

		parallelAsync = var_7

		var_7(var_134_3, function()
			setActive = var_2_10000

			var_2_10000(arg_134_0.flash, false)

			return
		end)
	end

	arg_134_2()

	return
end

function var_0_1.OnStart(arg_138_0, arg_138_1)
	return
end

function var_0_1.OnReset(arg_139_0, arg_139_1, arg_139_2, arg_139_3)
	arg_139_3()

	return
end

function var_0_1.OnBgUpdate(arg_140_0, arg_140_1)
	return
end

function var_0_1.OnInit(arg_141_0, arg_141_1, arg_141_2, arg_141_3)
	if arg_141_3 then
		arg_141_3()
	end

	return
end

function var_0_1.OnStartUIAnimations(arg_142_0, arg_142_1, arg_142_2)
	if arg_142_2 then
		arg_142_2()
	end

	return
end

function var_0_1.OnEnter(arg_143_0, arg_143_1, arg_143_2, arg_143_3)
	if arg_143_3 then
		arg_143_3()
	end

	return
end

function var_0_1.OnWillExit(arg_144_0, arg_144_1, arg_144_2, arg_144_3)
	arg_144_3()

	return
end

function var_0_1.OnWillClear(arg_145_0, arg_145_1)
	return
end

function var_0_1.OnClear(arg_146_0)
	return
end

function var_0_1.OnEnd(arg_147_0, arg_147_1)
	return
end

return var_0_1
