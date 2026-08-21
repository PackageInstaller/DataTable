local var_0_0 = class("Dialogue3DPlayer", import("Mgr.Story.model.animation.StoryAnimtion"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.view = arg_1_1
	arg_1_0._tf = arg_1_1._tf
	arg_1_0.dialogueContainer = arg_1_0._tf:Find("front/dialogue")
	arg_1_0.asideContainer = arg_1_0._tf:Find("front/aside")
	arg_1_0.dialoguePanel = arg_1_0._tf:Find("front/dialogue/1")
	arg_1_0.nameContainer = arg_1_0.dialoguePanel:Find("content/name/tags")
	arg_1_0.nameTxt = arg_1_0.dialoguePanel:Find("content/name/tags/3/Text"):GetComponent(typeof(Text))
	arg_1_0.iconImg = arg_1_0.dialoguePanel:Find("content/name/tags/3/icon")
	arg_1_0.contentTxt = arg_1_0.dialoguePanel:Find("content"):GetComponent(typeof(Text))
	arg_1_0.typewriter = arg_1_0.contentTxt:GetComponent(typeof(Typewriter))
	arg_1_0.blackBg = arg_1_0._tf:Find("black"):GetComponent(typeof(CanvasGroup))
	arg_1_0.optionPanel = arg_1_0.dialoguePanel:Find("options_panel")
	arg_1_0.uiOptionList = UIItemList.New(arg_1_0.dialoguePanel:Find("options_panel/options_l"), arg_1_0.dialoguePanel:Find("options_panel/options_l/option_tpl"))
	arg_1_0.asidePlayer = IslandAsidePlayer.New(arg_1_0.asideContainer)
	arg_1_0.canvasGroup = arg_1_1.canvasGroup

	return
end

function var_0_0.NextOne(arg_2_0)
	if arg_2_0.script and arg_2_0.script:IsSkipAll() then
		-- block empty
	end

	if arg_2_0.nextOneFlag then
		return
	end

	if arg_2_0.step and not arg_2_0.step:CanSkip() then
		return
	end

	arg_2_0.autoNext = true

	if arg_2_0.isRegisterEvent then
		triggerButton(arg_2_0._tf)
	else
		arg_2_0.nextOneFlag = true

		arg_2_0:Clear()

		arg_2_0.callback = nil

		arg_2_0.callback()
	end

	return
end

function var_0_0.CancelAuto(arg_3_0)
	arg_3_0.autoNext = false

	arg_3_0:ClearTimer(arg_3_0.callback)

	return
end

function var_0_0.OnStart(arg_4_0, arg_4_1)
	return
end

function var_0_0.OnStartAction(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:ActiveDefaultCamera(arg_5_1)
	arg_5_0:StartFadeIn(arg_5_1)
	arg_5_2()

	return
end

function var_0_0.OnEndAction(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:StartFadeOut(arg_6_1, arg_6_2)

	return
end

function var_0_0.Reset(arg_7_0, arg_7_1)
	setActive(arg_7_0.dialogueContainer, arg_7_1 == Dialogue3DStep.STYLE_DIALOGUE)
	setActive(arg_7_0.asideContainer, arg_7_1 == Dialogue3DStep.STYLE_ASIDE)
	removeOnButton(arg_7_0._tf)
	arg_7_0.uiOptionList:align(0)

	arg_7_0.isRegisterEvent = false
	arg_7_0.nextOneFlag = false
	arg_7_0.blackBg.alpha = 0

	return
end

function var_0_0.Play(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_3:GetStepByIndex(arg_8_2)

	if not var_8_0 then
		arg_8_4()

		return
	end

	arg_8_0.isUnmarkedSkipAll = false

	if var_8_0:ExistOption() and arg_8_3:IsSkipAll() then
		arg_8_3:UnMarkSkipAll()

		arg_8_0.isUnmarkedSkipAll = true
	end

	if arg_8_3:IsSkipAll() then
		arg_8_4()

		return
	end

	arg_8_0.canvasGroup.blocksRaycasts = true
	arg_8_0.playerUnit = arg_8_3:GetPlayerRole()

	if not var_8_0 then
		arg_8_4()

		return
	end

	arg_8_1:Add(var_8_0)

	arg_8_0.script = arg_8_3
	arg_8_0.callback = arg_8_4
	arg_8_0.autoNext = arg_8_3:GetAutoPlayFlag()
	arg_8_0.step = var_8_0

	arg_8_0:SetTimeScale(1 - arg_8_3:GetPlaySpeed() * 0.1)

	arg_8_0.isRegisterEvent = false

	local var_8_1 = var_8_0:GetStyle()

	arg_8_0:Reset(var_8_1)

	if var_8_1 == Dialogue3DStep.STYLE_DIALOGUE then
		arg_8_0:PlayDialogue(var_8_0, arg_8_4)
	elseif var_8_1 == Dialogue3DStep.STYLE_ASIDE then
		arg_8_0.asidePlayer:Play(var_8_0:GetAsideSequences(), arg_8_4)
	elseif var_8_1 == Dialogue3DStep.STYLE_EXIT_GROUP then
		arg_8_0:PlayNavObject(var_8_0, function()
			local var_9_0 = var_8_0:GetNavObject()

			if var_9_0 then
				IslandCameraMgr.instance:RemoveFromGroup(var_9_0.transform)
			end

			return
		end, arg_8_4)
	elseif var_8_1 == Dialogue3DStep.STYLE_JOIN_GROUP then
		arg_8_0:PlayNavObject(var_8_0, nil, function()
			local var_10_0 = var_8_0:GetNavObject()

			if var_10_0 then
				IslandCameraMgr.instance:AddIntoGroup(var_10_0.transform, 1, 0)
			end

			arg_8_4()

			return
		end)
	end

	return
end

function var_0_0.PlayNavObject(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0:DelayCall(arg_11_1:GetNavData().delay, function()
		if arg_11_2 then
			arg_11_2()
		end

		;({}).navData = {
			unitId = var_0.object,
			position = var_0.position,
			speed = var_0.speed,
			hide = var_0.hide,
			waitUntilDone = var_0.waitUntilDone,
			index = var_0.navData
		}
		;({}).callback = arg_11_3

		arg_11_0.view:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.START_PATHFINDER, {})

		return
	end)

	return
end

function var_0_0.PlayDialogue(arg_13_0, arg_13_1, arg_13_2)
	seriesAsync({
		function(arg_14_0)
			arg_13_0:SetCustomCameraBlend(arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			parallelAsync({
				function(arg_16_0)
					arg_13_0:ActiveCamera(arg_13_1, arg_16_0)

					return
				end,
				function(arg_17_0)
					arg_13_0:ShakeCamera(arg_13_1, arg_17_0)

					return
				end,
				function(arg_18_0)
					arg_13_0:StartAction(arg_13_1, arg_18_0)

					return
				end
			}, arg_15_0)

			return
		end,
		function(arg_19_0)
			arg_13_0:Clear()
			arg_19_0()

			return
		end
	}, arg_13_2)

	return
end

function var_0_0.StartFadeIn(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:GetFadeInTime()

	if var_20_0 <= 0 then
		if arg_20_2 then
			arg_20_2()
		end

		return
	end

	local var_20_1 = {}

	arg_20_0:CollectFadeInFunc({}, var_20_0)
	seriesAsync(var_20_1, arg_20_2)

	return
end

function var_0_0.StartFadeOut(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:GetFadeOutTime()

	if var_21_0 <= 0 then
		if arg_21_2 then
			arg_21_2()
		end

		return
	end

	local var_21_1 = {}

	arg_21_0:CollectFadeOutFunc({}, var_21_0)
	seriesAsync(var_21_1, arg_21_2)

	return
end

function var_0_0.ActiveDefaultCamera(arg_22_0, arg_22_1)
	local var_22_0, var_22_1, var_22_2 = arg_22_1:GetLookGroup()
	local var_22_3 = System.Array.CreateInstance(typeof(Transform), #var_22_0)
	local var_22_4 = System.Array.CreateInstance(typeof(UnityEngine.Vector2), #var_22_0)

	for iter_22_0 = 0, #var_22_0 - 1 do
		var_22_3[iter_22_0] = var_22_0[iter_22_0 + 1].transform

		local var_22_5 = var_22_1[iter_22_0 + 1] or 1
		local var_22_6 = var_22_2[iter_22_0 + 1] or 0

		var_22_4[iter_22_0] = UnityEngine.Vector2.New(var_22_5, var_22_6)
	end

	if var_22_3.Length > 1 then
		if arg_22_1:ShouldSetCamOffset() then
			IslandCameraMgr.instance:SetVirtualCameraBodyOffset(IslandConst.INTERACTION_CAMERA_NAME, (arg_22_1:GetFollowOffset()))
		end

		IslandCameraMgr.instance:LookAtGroup(var_22_3, var_22_4)
	elseif var_22_3.Length == 1 then
		IslandCameraMgr.instance:SetVirtualCameraBodyOffset(IslandConst.SOLO_INTERACTION_CAMERA_NAME, arg_22_1:IsFacingWhenSolo())
		IslandCameraMgr.instance:LookAt(IslandConst.SOLO_INTERACTION_CAMERA_NAME, var_22_3[0])
	else
		assert(false, "should have at least one target")
	end

	return
end

function var_0_0.DisactiveDefaultCamera(arg_23_0)
	IslandCameraMgr.instance:LookAt(arg_23_0.playerUnit.transform)

	return
end

function var_0_0.ShowOptions(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1:GetOptionList()

	arg_24_0.uiOptionList:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			local var_25_0 = var_24_0[arg_25_1 + 1]

			setText(arg_25_2.transform:Find("main/content/Text"), HXSet.hxLan(var_24_0[arg_25_1 + 1].content))

			local var_25_1 = arg_25_2.transform:Find("main/icon"):GetComponent(typeof(Image))

			var_25_1.sprite = GetSpriteFromAtlas("ui/story_atlas", var_24_0[arg_25_1 + 1].icon)

			var_25_1:SetNativeSize()
			onButton(arg_24_0, arg_25_2, function()
				arg_24_0:ResponseOption(var_25_0, arg_24_2)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_24_0.uiOptionList:align(#arg_24_1:GetOptionList())

	return
end

function var_0_0.ResponseOption(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1.type == Dialogue3DStep.OPTION_TYPE_TEXT then
		arg_27_0.script:SetBranchCode(arg_27_1.param)
	elseif arg_27_1.type == Dialogue3DStep.OPTION_TYPE_PAGE then
		arg_27_0.script:MarkSkipAll()
		arg_27_0.view:emit(ISLAND_EX_EVT.OPEN_PAGE, _G[arg_27_1.param])
	elseif arg_27_1.type == Dialogue3DStep.OPTION_TYPE_TASK then
		arg_27_0.script:MarkSkipAll()
		arg_27_0.view:emit(ISLAND_EX_EVT.TRIGGER_TASK, arg_27_1.param)
	elseif arg_27_1.type == Dialogue3DStep.OPTION_TYPE_EXIT then
		arg_27_0.script:MarkSkipAll()
	end

	arg_27_0:PlayOptionExitAnimation(arg_27_2)

	return
end

function var_0_0.PlayOptionExitAnimation(arg_28_0, arg_28_1)
	local var_28_0 = {}

	arg_28_0.uiOptionList:eachActive(function(arg_29_0, arg_29_1)
		table.insert(var_28_0, function(arg_30_0)
			arg_29_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				arg_30_0()

				return
			end)
			arg_29_1:GetComponent(typeof(Animation)):Play("anim_IslandStoryUI_Tpl_Out")

			return
		end)

		return
	end)
	parallelAsync({}, function()
		arg_28_0.uiOptionList:each(function(arg_33_0, arg_33_1)
			arg_33_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(nil)

			return
		end)
		arg_28_1()

		return
	end)

	return
end

function var_0_0.SetCustomCameraBlend(arg_34_0, arg_34_1, arg_34_2)
	arg_34_2()

	return
end

function var_0_0.ClearCustomCameraBlend(arg_35_0)
	return
end

function var_0_0.StartAction(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1:GetPlayMode()

	if var_36_0 == Dialogue3DStep.PLAY_MODE_SCENE_TIMELINE then
		setActive(arg_36_0._tf, false)
		arg_36_0.view:emit(ISLAND_EX_EVT.PLAY_TIMELINE, arg_36_1:GetSceneTimelinePath(), {}, function()
			setActive(arg_36_0._tf, true)
			arg_36_2()

			return
		end)
	elseif var_36_0 == Dialogue3DStep.PLAY_MODE_TIMELINE then
		arg_36_2()
	elseif var_36_0 == Dialogue3DStep.PLAY_MODE_DIALOGUE then
		arg_36_0:UpdateDialogue(arg_36_1, arg_36_2)
	else
		assert(false, "not support play mode")
		arg_36_2()
	end

	return
end

function var_0_0.CollectFadeInFunc(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0.blackBg.alpha = 1

	table.insert(arg_38_1, function(arg_39_0)
		local var_39_0 = arg_38_2 or 0.5

		arg_38_0:TweenValueForcanvasGroup(arg_38_0.blackBg, 1, 0, var_39_0, 0, arg_39_0)

		return
	end)
	table.insert(arg_38_1, function(arg_40_0)
		arg_38_0:UnscaleDelayCall(1, arg_40_0)

		return
	end)

	return
end

function var_0_0.CollectFadeOutFunc(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.blackBg.alpha = 0

	table.insert(arg_41_1, function(arg_42_0)
		local var_42_0 = arg_41_2 or 0.5

		arg_41_0:TweenValueForcanvasGroup(arg_41_0.blackBg, 0, 1, var_42_0, 0, arg_42_0)

		return
	end)

	return
end

function var_0_0.ActiveCamera(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_1:ShouldActiveCamera() then
		arg_43_2()

		return
	end

	local var_43_0 = arg_43_1:ShouldFadeCamera()

	if var_43_0 then
		arg_43_0:CollectFadeOutFunc({})
	end

	table.insert({}, function(arg_44_0)
		IslandCameraMgr.instance:ActiveVirtualCamera((arg_43_1:GetActiveCamera()))
		arg_44_0()

		return
	end)

	if var_43_0 then
		arg_43_0:CollectFadeInFunc({})
	end

	seriesAsync({}, arg_43_2)

	return
end

function var_0_0.ShakeCamera(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_1:ShouldCameraShake() then
		arg_45_2()

		return
	end

	seriesAsync({
		function(arg_46_0)
			arg_45_0:LoadShakeSrc(arg_45_1, arg_46_0)

			return
		end,
		function(arg_47_0)
			if arg_45_0.shakeCameraSrc then
				arg_45_0.shakeCameraSrc:GetComponent("Cinemachine.CinemachineImpulseSource"):GenerateImpulse()
			end

			arg_47_0()

			return
		end
	}, arg_45_2)

	return
end

function var_0_0.LoadShakeSrc(arg_48_0, arg_48_1, arg_48_2)
	PoolMgr.GetInstance():GetUI(arg_48_1:GetCameraShakeSrc(), true, function(arg_49_0)
		arg_48_0.shakeCameraSrc = arg_49_0

		arg_48_2()

		return
	end)

	return
end

function var_0_0.UpdateDialogue(arg_50_0, arg_50_1, arg_50_2)
	parallelAsync({
		function(arg_51_0)
			arg_50_0:LoadContentAndIcon(arg_50_1, arg_51_0)

			return
		end,
		function(arg_52_0)
			arg_50_0:PlayCharatorAnimation(arg_50_1, arg_52_0)

			return
		end,
		function(arg_53_0)
			arg_50_0:UpdateTypeWriter(arg_50_1, arg_53_0)

			return
		end,
		function(arg_54_0)
			arg_50_0:StartUIAnimations(arg_50_1, arg_54_0)

			return
		end,
		function(arg_55_0)
			arg_50_0:TryFace2Face(arg_50_1, arg_55_0)

			return
		end,
		function(arg_56_0)
			arg_50_0:TryTurn2Unit(arg_50_1, arg_56_0)

			return
		end
	}, function()
		arg_50_0:RegisterEvent(arg_50_1, arg_50_2)

		return
	end)

	return
end

function var_0_0.TryTurn2Unit(arg_58_0, arg_58_1, arg_58_2)
	for iter_58_0, iter_58_1 in ipairs(arg_58_1:GetTurntoList()) do
		table.insert({}, function(arg_59_0)
			local var_59_0 = arg_58_0.script:GetRole(iter_58_1[1])
			local var_59_1 = arg_58_0.script:GetRole(iter_58_1[2])

			if var_59_1 == nil or var_59_0 == nil then
				arg_59_0()

				return
			end

			arg_58_0:Turn2Unit(var_59_0.transform, var_59_1.transform, arg_59_0)

			return
		end)
	end

	seriesAsync({}, arg_58_2)

	return
end

function var_0_0.Turn2Unit(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	arg_60_1.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_60_2.position - arg_60_1.position).eulerAngles.y, 0)

	arg_60_3()

	return
end

function var_0_0.TryFace2Face(arg_61_0, arg_61_1, arg_61_2)
	for iter_61_0, iter_61_1 in ipairs(arg_61_1:GetFace2FaceList()) do
		table.insert({}, function(arg_62_0)
			local var_62_0 = arg_61_0.script:GetRole(iter_61_1[1])
			local var_62_1 = arg_61_0.script:GetRole(iter_61_1[2])

			if var_62_1 == nil or var_62_0 == nil then
				arg_62_0()

				return
			end

			arg_61_0:Face2Face(var_62_0.transform, var_62_1.transform, arg_62_0)

			return
		end)
	end

	seriesAsync({}, arg_61_2)

	return
end

function var_0_0.Face2Face(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	if (arg_63_2.position - arg_63_1.position).sqrMagnitude > 0.0001 then
		arg_63_1.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_63_2.position - arg_63_1.position).eulerAngles.y, 0)
	end

	if (arg_63_1.position - arg_63_2.position).sqrMagnitude > 0.0001 then
		arg_63_2.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_63_1.position - arg_63_2.position).eulerAngles.y, 0)
	end

	if arg_63_3 then
		arg_63_3()
	end

	return
end

function var_0_0.StartUIAnimations(arg_64_0, arg_64_1, arg_64_2)
	if not arg_64_1:ShouldShakeDailogue() then
		arg_64_2()

		return
	end

	local var_64_0 = arg_64_1:GetShakeDailogueData()

	arg_64_0:TweenMovex(arg_64_0.dialoguePanel, var_64_0.x, arg_64_0.dialoguePanel.localPosition.x, var_64_0.speed, var_64_0.delay, var_64_0.number, arg_64_2)

	return
end

function var_0_0.RegisterEvent(arg_65_0, arg_65_1, arg_65_2)
	if not arg_65_0.callback then
		return
	end

	setActive(arg_65_0.optionPanel, arg_65_1:ExistOption())

	if arg_65_1:ExistOption() then
		arg_65_0:ShowOptions(arg_65_1, arg_65_2)
	elseif arg_65_0.autoNext then
		arg_65_0:UnscaleDelayCall(arg_65_0.script:GetTriggerDelayTime(), arg_65_2)
	else
		onButton(arg_65_0, arg_65_0._tf, arg_65_2, SFX_PANEL)
	end

	arg_65_0.isRegisterEvent = true

	return
end

function var_0_0.UpdateTypeWriter(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = arg_66_1:GetSay()
	local var_66_1 = 999

	if var_66_0 and var_66_0 ~= "" then
		var_66_1 = System.String.New(var_66_0).Length
	end

	if not var_66_0 or var_66_0 == "" or var_66_0 == "…" or #var_66_0 <= 1 or var_66_1 <= 1 then
		arg_66_2()

		return
	end

	local var_66_2 = arg_66_1:GetTypewriter()

	if not var_66_2 or arg_66_0.isUnmarkedSkipAll then
		arg_66_2()

		return
	end

	function arg_66_0.typewriter.endFunc()
		arg_66_0.typewriterSpeed = 0
		arg_66_0.typewriter.endFunc = nil

		removeOnButton(arg_66_0._tf)
		arg_66_2()

		return
	end

	local var_66_3 = var_66_2.speed or 0.1

	arg_66_0.typewriterSpeed = math.max(var_66_3 * arg_66_0.timeScale, 0.001)

	local var_66_4

	if not var_66_2.speedUp then
		var_66_4 = arg_66_0.typewriterSpeed
	end

	arg_66_0.typewriter:setSpeed(arg_66_0.typewriterSpeed)
	arg_66_0.typewriter:Play()
	onButton(arg_66_0, arg_66_0._tf, function()
		if arg_66_0.puase or arg_66_0.stop then
			return
		end

		arg_66_0.typewriterSpeed = math.min(arg_66_0.typewriterSpeed, var_66_4)

		arg_66_0.typewriter:setSpeed(arg_66_0.typewriterSpeed)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.LoadContentAndIcon(arg_69_0, arg_69_1, arg_69_2)
	setActive(arg_69_0.nameContainer, not arg_69_1:IsHideName())

	arg_69_0.nameTxt.text = arg_69_1:GetName() .. "<size=24>" .. arg_69_1:GetSubName() .. "</size>"
	arg_69_0.contentTxt.text = arg_69_1:GetSay()

	local var_69_0 = arg_69_1:GetActorIcon()

	if var_69_0 then
		GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. var_69_0, "", arg_69_0.iconImg)
	end

	setActive(arg_69_0.iconImg, not arg_69_1:IsHideIcon())
	arg_69_2()

	return
end

function var_0_0.PlayCharatorAnimation(arg_70_0, arg_70_1, arg_70_2)
	if not arg_70_1:ExistAnimation() then
		arg_70_2()

		return
	end

	local var_70_0 = arg_70_0.script:GetRole(arg_70_1:GetUnitData())

	if not var_70_0 then
		arg_70_2()

		return
	end

	local var_70_1 = arg_70_1:GetAnimation()
	local var_70_2 = var_70_0:GetComponent(typeof(Animator))

	var_70_2 = var_70_2 or var_70_0.transform:GetChild(0):GetComponent(typeof(Animator))

	local var_70_3 = var_70_2:GetCurrentAnimatorStateInfo(0)

	if not var_70_3:IsName(var_70_1) then
		local var_70_4 = Animator.StringToHash(var_70_1)

		for iter_70_0 = 1, var_70_2.layerCount do
			var_70_2:CrossFadeInFixedTime(var_70_4, 0.2, iter_70_0 - 1)
		end
	end

	arg_70_2()

	return
end

function var_0_0.Clear(arg_71_0)
	arg_71_0.asidePlayer:Clear()

	arg_71_0.canvasGroup.blocksRaycasts = true

	arg_71_0.uiOptionList:align(0)
	removeOnButton(arg_71_0._tf)
	arg_71_0:ClearAnimation()

	arg_71_0.blackBg.alpha = 0

	if arg_71_0.shakeCameraSrc then
		Object.Destroy(arg_71_0.shakeCameraSrc)

		arg_71_0.shakeCameraSrc = nil
	end

	return
end

function var_0_0.OnEnd(arg_72_0)
	arg_72_0:DisactiveDefaultCamera()
	arg_72_0:ClearCustomCameraBlend()

	return
end

function var_0_0.Dispose(arg_73_0)
	arg_73_0.asidePlayer:Dispose()

	arg_73_0.asidePlayer = nil

	pg.DelegateInfo.Dispose(arg_73_0)

	return
end

return var_0_0
