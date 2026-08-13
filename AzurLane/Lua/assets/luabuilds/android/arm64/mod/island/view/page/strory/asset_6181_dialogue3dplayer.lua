class = var_0_10000

local var_0_0 = "Dialogue3DPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mgr.Story.model.animation.StoryAnimtion"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	pg = var_2

	var_2.DelegateInfo.New(arg_1_0)

	arg_1_0.view = arg_1_1
	arg_1_0._tf = arg_1_1._tf

	local var_1_0 = arg_1_0._tf

	arg_1_0.dialogueContainer = var_2.Find(var_1_0, "front/dialogue")

	local var_1_1 = arg_1_0._tf

	arg_1_0.asideContainer = var_2.Find(var_1_1, "front/aside")

	local var_1_2 = arg_1_0._tf

	arg_1_0.dialoguePanel = var_2.Find(var_1_2, "front/dialogue/1")

	local var_1_3 = arg_1_0.dialoguePanel

	arg_1_0.nameContainer = var_2.Find(var_1_3, "content/name/tags")

	local var_1_4 = arg_1_0.dialoguePanel
	local var_1_5 = var_2.Find(var_1_4, "content/name/tags/3/Text")
	local var_1_6 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTxt = var_1_6(var_1_5, var_5(var_1_10007))

	local var_1_7 = arg_1_0.dialoguePanel

	arg_1_0.iconImg = var_2.Find(var_1_7, "content/name/tags/3/icon")

	local var_1_8 = arg_1_0.dialoguePanel
	local var_1_9 = var_2.Find(var_1_8, "content")
	local var_1_10 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.contentTxt = var_1_10(var_1_9, var_5(var_1_10007))

	local var_1_11 = arg_1_0.contentTxt
	local var_1_12 = var_2.GetComponent

	typeof = var_5
	Typewriter = var_1_10007
	arg_1_0.typewriter = var_1_12(var_1_11, var_5(var_1_10007))

	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_2.Find(var_1_13, "black")
	local var_1_15 = var_2.GetComponent

	typeof = var_5
	CanvasGroup = var_1_10007
	arg_1_0.blackBg = var_1_15(var_1_14, var_5(var_1_10007))

	local var_1_16 = arg_1_0.dialoguePanel

	arg_1_0.optionPanel = var_2.Find(var_1_16, "options_panel")
	UIItemList = var_2

	local var_1_17 = var_2.New
	local var_1_18 = arg_1_0.dialoguePanel
	local var_1_19 = var_4.Find(var_1_18, "options_panel/options_l")
	local var_1_20 = arg_1_0.dialoguePanel

	arg_1_0.uiOptionList = var_1_17(var_1_19, var_5.Find(var_1_20, "options_panel/options_l/option_tpl"))
	IslandAsidePlayer = var_2
	arg_1_0.asidePlayer = var_2.New(arg_1_0.asideContainer)
	arg_1_0.canvasGroup = arg_1_1.canvasGroup

	return
end

function var_0_1.NextOne(arg_2_0)
	if arg_2_0.script then
		local var_2_0 = arg_2_0.script

		if var_1.IsSkipAll(var_2_0) then
			-- block empty
		end
	end

	if arg_2_0.nextOneFlag then
		return
	end

	if arg_2_0.step then
		local var_2_1 = arg_2_0.step

		if not var_1.CanSkip(var_2_1) then
			return
		end
	end

	arg_2_0.autoNext = true

	if arg_2_0.isRegisterEvent then
		triggerButton = var_1

		var_1(arg_2_0._tf)
	else
		arg_2_0.nextOneFlag = true

		arg_2_0:Clear()

		local var_2_2 = arg_2_0.callback

		arg_2_0.callback = nil

		var_2_2()
	end

	return
end

function var_0_1.CancelAuto(arg_3_0)
	arg_3_0.autoNext = false

	arg_3_0:ClearTimer(arg_3_0.callback)

	return
end

function var_0_1.OnStart(arg_4_0, arg_4_1)
	return
end

function var_0_1.OnStartAction(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:ActiveDefaultCamera(arg_5_1)
	arg_5_0:StartFadeIn(arg_5_1)
	arg_5_2()

	return
end

function var_0_1.OnEndAction(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:StartFadeOut(arg_6_1, arg_6_2)

	return
end

function var_0_1.Reset(arg_7_0, arg_7_1)
	setActive = var_1_10002

	local var_7_0 = arg_7_0.dialogueContainer

	Dialogue3DStep = var_1_10005

	var_1_10002(var_7_0, arg_7_1 == var_1_10005.STYLE_DIALOGUE)

	setActive = var_1_10002

	local var_7_1 = arg_7_0.asideContainer

	Dialogue3DStep = var_5

	var_1_10002(var_7_1, arg_7_1 == var_5.STYLE_ASIDE)

	removeOnButton = var_1_10002

	var_1_10002(arg_7_0._tf)

	local var_7_2 = arg_7_0.uiOptionList

	var_2.align(var_7_2, 0)

	arg_7_0.isRegisterEvent = false
	arg_7_0.nextOneFlag = false
	arg_7_0.blackBg.alpha = 0

	return
end

function var_0_1.Play(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not arg_8_3:GetStepByIndex(arg_8_2) then
		arg_8_4()

		return
	end

	arg_8_0.isUnmarkedSkipAll = false

	if var_5:ExistOption() and arg_8_3:IsSkipAll() then
		arg_8_3:UnMarkSkipAll()

		arg_8_0.isUnmarkedSkipAll = true
	end

	if arg_8_3:IsSkipAll() then
		arg_8_4()

		return
	end

	arg_8_0.canvasGroup.blocksRaycasts = true
	arg_8_0.playerUnit = arg_8_3:GetPlayerRole()

	if not var_5 then
		arg_8_4()

		return
	end

	arg_8_1:Add(var_5)

	arg_8_0.script = arg_8_3
	arg_8_0.callback = arg_8_4
	arg_8_0.autoNext = arg_8_3:GetAutoPlayFlag()
	arg_8_0.step = var_5

	arg_8_0:SetTimeScale(1 - arg_8_3:GetPlaySpeed() * 0.1)

	arg_8_0.isRegisterEvent = false

	local var_8_0 = var_5:GetStyle()

	arg_8_0:Reset(var_8_0)

	Dialogue3DStep = var_7

	if var_8_0 == var_7.STYLE_DIALOGUE then
		arg_8_0:PlayDialogue(var_5, arg_8_4)
	else
		Dialogue3DStep = var_7

		if var_8_0 == var_7.STYLE_ASIDE then
			local var_8_1 = arg_8_0.asidePlayer

			var_7.Play(var_8_1, var_5:GetAsideSequences(), arg_8_4)
		else
			Dialogue3DStep = var_7

			if var_8_0 == var_7.STYLE_EXIT_GROUP then
				arg_8_0:PlayNavObject(var_5, function()
					local var_9_0 = var_0

					if var_0.GetNavObject(var_9_0) then
						IslandCameraMgr = var_2_10001

						local var_9_1 = var_2_10001.instance

						var_1.RemoveFromGroup(var_9_1, var_0.transform)
					end

					return
				end, arg_8_4)
			else
				Dialogue3DStep = var_7

				if var_8_0 == var_7.STYLE_JOIN_GROUP then
					arg_8_0:PlayNavObject(var_5, nil, function()
						local var_10_0 = var_0

						if var_0.GetNavObject(var_10_0) then
							IslandCameraMgr = var_2_10001

							local var_10_1 = var_2_10001.instance

							var_1.AddIntoGroup(var_10_1, var_0.transform, 1, 0)
						end

						arg_8_4()

						return
					end)
				end
			end
		end
	end

	return
end

function var_0_1.PlayNavObject(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetNavData()

	arg_11_0:DelayCall(var_11_0.delay, function()
		if arg_11_2 then
			arg_11_2()
		end

		local var_12_0 = {
			unitId = var_11_0.object,
			position = var_11_0.position,
			speed = var_11_0.speed,
			hide = var_11_0.hide,
			waitUntilDone = var_11_0.waitUntilDone,
			index = var_11_0.navData
		}
		local var_12_1 = arg_11_0.view
		local var_12_2 = var_1.emit

		IslandBaseScene = var_2_10004

		local var_12_3 = var_2_10004.LINK_CORE_EVENT

		IslandProxy = var_2_10005

		var_12_2(var_12_1, var_12_3, var_2_10005.START_PATHFINDER, {
			navData = var_12_0,
			callback = arg_11_3
		})

		return
	end)

	return
end

function var_0_1.PlayDialogue(arg_13_0, arg_13_1, arg_13_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_14_0)
			local var_14_0 = arg_13_0

			var_1.SetCustomCameraBlend(var_14_0, arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			parallelAsync = var_2_10001

			var_2_10001({
				function(arg_16_0)
					local var_16_0 = arg_13_0

					var_1.ActiveCamera(var_16_0, arg_13_1, arg_16_0)

					return
				end,
				function(arg_17_0)
					local var_17_0 = arg_13_0

					var_1.ShakeCamera(var_17_0, arg_13_1, arg_17_0)

					return
				end,
				function(arg_18_0)
					local var_18_0 = arg_13_0

					var_1.StartAction(var_18_0, arg_13_1, arg_18_0)

					return
				end
			}, arg_15_0)

			return
		end,
		function(arg_19_0)
			local var_19_0 = arg_13_0

			var_1.Clear(var_19_0)
			arg_19_0()

			return
		end
	}, arg_13_2)

	return
end

function var_0_1.StartFadeIn(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1:GetFadeInTime() <= 0 then
		if arg_20_2 then
			arg_20_2()
		end

		return
	end

	local var_20_0 = {}

	arg_20_0:CollectFadeInFunc(var_20_0, var_3)

	seriesAsync = var_5

	var_5(var_20_0, arg_20_2)

	return
end

function var_0_1.StartFadeOut(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1:GetFadeOutTime() <= 0 then
		if arg_21_2 then
			arg_21_2()
		end

		return
	end

	local var_21_0 = {}

	arg_21_0:CollectFadeOutFunc(var_21_0, var_3)

	seriesAsync = var_5

	var_5(var_21_0, arg_21_2)

	return
end

function var_0_1.ActiveDefaultCamera(arg_22_0, arg_22_1)
	local var_22_0, var_22_1, var_22_2 = arg_22_1:GetLookGroup()

	System = var_1_10005

	local var_22_3 = var_1_10005.Array.CreateInstance

	typeof = var_1_10007
	Transform = var_1_10009

	local var_22_4 = var_22_3(var_1_10007(var_1_10009), #var_22_0)

	System = var_1_10006

	local var_22_5 = var_1_10006.Array.CreateInstance

	typeof = var_8
	UnityEngine = var_1_10010

	local var_22_6 = var_22_5(var_8(var_1_10010.Vector2), #var_22_0)

	for iter_22_0 = 0, #var_22_0 - 1 do
		var_22_4[iter_22_0] = var_22_0[iter_22_0 + 1].transform
		UnityEngine = var_1_10011
		var_1_10011 = var_1_10011.Vector2.New

		local var_22_7

		if not var_22_1[iter_22_0 + 1] then
			var_22_7 = 1
		end

		local var_22_8

		if not var_22_2[iter_22_0 + 1] then
			var_22_8 = 0
		end

		var_22_6[iter_22_0] = var_1_10011(var_22_7, var_22_8)
	end

	local var_22_9 = var_22_4.Length

	if 1 < var_22_9 then
		local var_22_10

		if arg_22_1:ShouldSetCamOffset() then
			var_22_10 = arg_22_1:GetFollowOffset()
			IslandCameraMgr = var_8
			iter_22_0 = var_8.instance

			local var_22_11 = var_8.SetVirtualCameraBodyOffset

			IslandConst = var_1_10011

			var_22_11(iter_22_0, var_1_10011.INTERACTION_CAMERA_NAME, var_22_10)
		end

		IslandCameraMgr = var_22_10

		local var_22_12 = var_22_10.instance

		var_7.LookAtGroup(var_22_12, var_22_4, var_22_6)
	else
		local var_22_14

		if var_22_4.Length == 1 then
			IslandCameraMgr = var_22_14

			local var_22_13 = var_22_14.instance

			var_22_14 = var_22_14.SetVirtualCameraBodyOffset
			IslandConst = iter_22_0

			var_22_14(var_22_13, iter_22_0.SOLO_INTERACTION_CAMERA_NAME, arg_22_1:IsFacingWhenSolo())

			IslandCameraMgr = var_22_14

			local var_22_15 = var_22_14.instance

			var_22_14 = var_22_14.LookAt
			IslandConst = var_10

			var_22_14(var_22_15, var_10.SOLO_INTERACTION_CAMERA_NAME, var_22_4[0])
		else
			assert = var_22_14

			var_22_14(false, "should have at least one target")
		end
	end

	return
end

function var_0_1.DisactiveDefaultCamera(arg_23_0)
	IslandCameraMgr = var_1_10001

	local var_23_0 = var_1_10001.instance

	var_1.LookAt(var_23_0, arg_23_0.playerUnit.transform)

	return
end

function var_0_1.ShowOptions(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1:GetOptionList()
	local var_24_1 = arg_24_0.uiOptionList

	var_4.make(var_24_1, function(arg_25_0, arg_25_1, arg_25_2)
		UIItemList = var_2_10003

		if arg_25_0 == var_2_10003.EventUpdate then
			local var_25_0 = var_24_0[arg_25_1 + 1]

			setText = var_4

			local var_25_1 = arg_25_2.transform
			local var_25_2 = var_6.Find(var_25_1, "main/content/Text")

			HXSet = var_2_10007

			var_4(var_25_2, var_2_10007.hxLan(var_25_0.content))

			GetSpriteFromAtlas = var_4

			local var_25_3 = var_4("ui/story_atlas", var_25_0.icon)
			local var_25_4 = arg_25_2.transform
			local var_25_5 = var_5.Find(var_25_4, "main/icon")
			local var_25_6 = var_5.GetComponent

			typeof = var_8
			Image = var_2_10010

			local var_25_7 = var_25_6(var_25_5, var_8(var_2_10010))

			var_25_7.sprite = var_25_3

			var_25_7:SetNativeSize()

			onButton = var_6

			local var_25_8 = arg_24_0
			local var_25_9 = arg_25_2

			local function var_25_10()
				local var_26_0 = arg_24_0

				var_0.ResponseOption(var_26_0, var_25_0, arg_24_2)

				return
			end

			SFX_PANEL = var_2_10011

			var_6(var_25_8, var_25_9, var_25_10, var_2_10011)
		end

		return
	end)

	local var_24_2 = arg_24_0.uiOptionList

	var_4.align(var_24_2, #var_24_0)

	return
end

function var_0_1.ResponseOption(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1.type

	Dialogue3DStep = var_1_10004

	if var_27_0 == var_1_10004.OPTION_TYPE_TEXT then
		local var_27_1 = arg_27_0.script

		var_3.SetBranchCode(var_27_1, arg_27_1.param)
	else
		local var_27_2 = arg_27_1.type

		Dialogue3DStep = var_4

		if var_27_2 == var_4.OPTION_TYPE_PAGE then
			local var_27_3 = arg_27_0.script

			var_3.MarkSkipAll(var_27_3)

			local var_27_4 = arg_27_0.view
			local var_27_5 = var_3.emit

			ISLAND_EX_EVT = var_1_10006
			var_1_10006 = var_1_10006.OPEN_PAGE
			_G = var_1_10007

			var_27_5(var_27_4, var_1_10006, var_1_10007[arg_27_1.param])
		else
			local var_27_6 = arg_27_1.type

			Dialogue3DStep = var_4

			if var_27_6 == var_4.OPTION_TYPE_TASK then
				local var_27_7 = arg_27_0.script

				var_3.MarkSkipAll(var_27_7)

				local var_27_8 = arg_27_0.view
				local var_27_9 = var_3.emit

				ISLAND_EX_EVT = var_1_10006

				var_27_9(var_27_8, var_1_10006.TRIGGER_TASK, arg_27_1.param)
			else
				local var_27_10 = arg_27_1.type

				Dialogue3DStep = var_4

				if var_27_10 == var_4.OPTION_TYPE_EXIT then
					local var_27_11 = arg_27_0.script

					var_3.MarkSkipAll(var_27_11)
				end
			end
		end
	end

	arg_27_0:PlayOptionExitAnimation(arg_27_2)

	return
end

function var_0_1.PlayOptionExitAnimation(arg_28_0, arg_28_1)
	local var_28_0 = {}
	local var_28_1 = arg_28_0.uiOptionList

	var_3.eachActive(var_28_1, function(arg_29_0, arg_29_1)
		table = var_2_10002

		var_2_10002.insert(var_28_0, function(arg_30_0)
			local var_30_0 = arg_29_1
			local var_30_1 = var_1.GetComponent

			typeof = var_3_10004
			DftAniEvent = var_3_10006

			local var_30_2 = var_30_1(var_30_0, var_3_10004(var_3_10006))

			var_1.SetEndEvent(var_30_2, function()
				arg_30_0()

				return
			end)

			local var_30_3 = arg_29_1
			local var_30_4 = var_2.GetComponent

			typeof = var_5
			Animation = var_3_10007

			local var_30_5 = var_30_4(var_30_3, var_5(var_3_10007))

			var_2.Play(var_30_5, "anim_IslandStoryUI_Tpl_Out")

			return
		end)

		return
	end)

	parallelAsync = var_3

	var_3(var_28_0, function()
		local var_32_0 = arg_28_0.uiOptionList

		var_0.each(var_32_0, function(arg_33_0, arg_33_1)
			local var_33_0 = arg_33_1
			local var_33_1 = arg_33_1.GetComponent

			typeof = var_3_10005
			DftAniEvent = var_3_10007

			local var_33_2 = var_33_1(var_33_0, var_3_10005(var_3_10007))

			var_2.SetEndEvent(var_33_2, nil)

			return
		end)
		arg_28_1()

		return
	end)

	return
end

function var_0_1.SetCustomCameraBlend(arg_34_0, arg_34_1, arg_34_2)
	arg_34_2()

	return
end

function var_0_1.ClearCustomCameraBlend(arg_35_0)
	return
end

function var_0_1.StartAction(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1:GetPlayMode()

	Dialogue3DStep = var_1_10004

	local var_36_2

	if var_36_0 == var_1_10004.PLAY_MODE_SCENE_TIMELINE then
		setActive = var_36_2

		var_36_2(arg_36_0._tf, false)

		local var_36_1 = arg_36_0.view

		var_36_2 = var_36_2.emit
		ISLAND_EX_EVT = var_7

		var_36_2(var_36_1, var_7.PLAY_TIMELINE, arg_36_1:GetSceneTimelinePath(), {}, function()
			setActive = var_2_10000

			var_2_10000(arg_36_0._tf, true)
			arg_36_2()

			return
		end)
	else
		Dialogue3DStep = var_36_2

		if var_36_0 == var_36_2.PLAY_MODE_TIMELINE then
			arg_36_2()
		else
			Dialogue3DStep = var_4

			if var_36_0 == var_4.PLAY_MODE_DIALOGUE then
				arg_36_0:UpdateDialogue(arg_36_1, arg_36_2)
			else
				assert = var_4

				var_4(false, "not support play mode")
				arg_36_2()
			end
		end
	end

	return
end

function var_0_1.CollectFadeInFunc(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0.blackBg

	var_38_0.alpha = 1
	table = var_38_0

	var_38_0.insert(arg_38_1, function(arg_39_0)
		local var_39_0 = arg_38_0
		local var_39_1 = var_1.TweenValueForcanvasGroup
		local var_39_2 = arg_38_0.blackBg
		local var_39_3 = 1
		local var_39_4 = 0
		local var_39_5

		if not arg_38_2 then
			var_39_5 = 0.5
		end

		var_39_1(var_39_0, var_39_2, var_39_3, var_39_4, var_39_5, 0, arg_39_0)

		return
	end)

	table = var_3

	var_3.insert(arg_38_1, function(arg_40_0)
		local var_40_0 = arg_38_0

		var_1.UnscaleDelayCall(var_40_0, 1, arg_40_0)

		return
	end)

	return
end

function var_0_1.CollectFadeOutFunc(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.blackBg

	var_41_0.alpha = 0
	table = var_41_0

	var_41_0.insert(arg_41_1, function(arg_42_0)
		local var_42_0 = arg_41_0
		local var_42_1 = var_1.TweenValueForcanvasGroup
		local var_42_2 = arg_41_0.blackBg
		local var_42_3 = 0
		local var_42_4 = 1
		local var_42_5

		if not arg_41_2 then
			var_42_5 = 0.5
		end

		var_42_1(var_42_0, var_42_2, var_42_3, var_42_4, var_42_5, 0, arg_42_0)

		return
	end)

	return
end

function var_0_1.ActiveCamera(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_1:ShouldActiveCamera() then
		arg_43_2()

		return
	end

	local var_43_0 = arg_43_1
	local var_43_1 = arg_43_1.ShouldFadeCamera(var_43_0)
	local var_43_2 = {}

	if var_43_1 then
		arg_43_0:CollectFadeOutFunc(var_43_2)
	end

	table = var_43_0

	var_43_0.insert(var_43_2, function(arg_44_0)
		local var_44_0 = arg_43_1
		local var_44_1 = var_1.GetActiveCamera(var_44_0)

		IslandCameraMgr = var_2_10002

		local var_44_2 = var_2_10002.instance

		var_2.ActiveVirtualCamera(var_44_2, var_44_1)
		arg_44_0()

		return
	end)

	if var_43_1 then
		arg_43_0:CollectFadeInFunc(var_43_2)
	end

	seriesAsync = var_5

	var_5(var_43_2, arg_43_2)

	return
end

function var_0_1.ShakeCamera(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_1:ShouldCameraShake() then
		arg_45_2()

		return
	end

	seriesAsync = var_3

	var_3({
		function(arg_46_0)
			local var_46_0 = arg_45_0

			var_1.LoadShakeSrc(var_46_0, arg_45_1, arg_46_0)

			return
		end,
		function(arg_47_0)
			if arg_45_0.shakeCameraSrc then
				local var_47_0 = arg_45_0.shakeCameraSrc
				local var_47_1 = var_1.GetComponent(var_47_0, "Cinemachine.CinemachineImpulseSource")

				var_1.GenerateImpulse(var_47_1)
			end

			arg_47_0()

			return
		end
	}, arg_45_2)

	return
end

function var_0_1.LoadShakeSrc(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_1:GetCameraShakeSrc()

	PoolMgr = var_1_10004

	local var_48_1 = var_1_10004.GetInstance()

	var_4.GetUI(var_48_1, var_48_0, true, function(arg_49_0)
		arg_48_0.shakeCameraSrc = arg_49_0

		arg_48_2()

		return
	end)

	return
end

function var_0_1.UpdateDialogue(arg_50_0, arg_50_1, arg_50_2)
	parallelAsync = var_1_10003

	var_1_10003({
		function(arg_51_0)
			local var_51_0 = arg_50_0

			var_1.LoadContentAndIcon(var_51_0, arg_50_1, arg_51_0)

			return
		end,
		function(arg_52_0)
			local var_52_0 = arg_50_0

			var_1.PlayCharatorAnimation(var_52_0, arg_50_1, arg_52_0)

			return
		end,
		function(arg_53_0)
			local var_53_0 = arg_50_0

			var_1.UpdateTypeWriter(var_53_0, arg_50_1, arg_53_0)

			return
		end,
		function(arg_54_0)
			local var_54_0 = arg_50_0

			var_1.StartUIAnimations(var_54_0, arg_50_1, arg_54_0)

			return
		end,
		function(arg_55_0)
			local var_55_0 = arg_50_0

			var_1.TryFace2Face(var_55_0, arg_50_1, arg_55_0)

			return
		end,
		function(arg_56_0)
			local var_56_0 = arg_50_0

			var_1.TryTurn2Unit(var_56_0, arg_50_1, arg_56_0)

			return
		end
	}, function()
		local var_57_0 = arg_50_0

		var_0.RegisterEvent(var_57_0, arg_50_1, arg_50_2)

		return
	end)

	return
end

function var_0_1.TryTurn2Unit(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = {}

	ipairs = var_1_10004

	for iter_58_0, iter_58_1 in var_1_10004(arg_58_1:GetTurntoList()) do
		table = var_1_10009

		var_1_10009.insert(var_58_0, function(arg_59_0)
			local var_59_0 = arg_58_0.script
			local var_59_1 = var_1.GetRole(var_59_0, iter_58_1[1])
			local var_59_2 = arg_58_0.script

			if var_2.GetRole(var_59_2, iter_58_1[2]) == nil or var_59_1 == nil then
				arg_59_0()

				return
			end

			local var_59_3 = var_59_1.transform
			local var_59_4 = var_2.transform
			local var_59_5 = arg_58_0

			var_5.Turn2Unit(var_59_5, var_59_3, var_59_4, arg_59_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_58_0, arg_58_2)

	return
end

function var_0_1.Turn2Unit(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	local var_60_0 = arg_60_2.position - arg_60_1.position

	Quaternion = var_5

	local var_60_1 = var_5.LookRotation(var_60_0)

	Quaternion = var_1_10006
	arg_60_1.rotation = var_1_10006.Euler(0, var_60_1.eulerAngles.y, 0)

	arg_60_3()

	return
end

function var_0_1.TryFace2Face(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = {}

	ipairs = var_1_10004

	for iter_61_0, iter_61_1 in var_1_10004(arg_61_1:GetFace2FaceList()) do
		table = var_1_10009

		var_1_10009.insert(var_61_0, function(arg_62_0)
			local var_62_0 = arg_61_0.script
			local var_62_1 = var_1.GetRole(var_62_0, iter_61_1[1])
			local var_62_2 = arg_61_0.script

			if var_2.GetRole(var_62_2, iter_61_1[2]) == nil or var_62_1 == nil then
				arg_62_0()

				return
			end

			local var_62_3 = var_62_1.transform
			local var_62_4 = var_2.transform
			local var_62_5 = arg_61_0

			var_5.Face2Face(var_62_5, var_62_3, var_62_4, arg_62_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_61_0, arg_61_2)

	return
end

function var_0_1.Face2Face(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	local var_63_0 = arg_63_2.position - arg_63_1.position
	local var_63_1 = arg_63_1.position - arg_63_2.position
	local var_63_2 = var_63_0.sqrMagnitude

	if 0.0001 < var_63_2 then
		Quaternion = var_63_2

		local var_63_3 = var_63_2.LookRotation(var_63_0)

		Quaternion = var_7
		arg_63_1.rotation = var_7.Euler(0, var_63_3.eulerAngles.y, 0)
	end

	local var_63_4 = var_63_1.sqrMagnitude

	if 0.0001 < var_63_4 then
		Quaternion = var_63_4

		local var_63_5 = var_63_4.LookRotation(var_63_1)

		Quaternion = var_7
		arg_63_2.rotation = var_7.Euler(0, var_63_5.eulerAngles.y, 0)
	end

	if arg_63_3 then
		arg_63_3()
	end

	return
end

function var_0_1.StartUIAnimations(arg_64_0, arg_64_1, arg_64_2)
	if not arg_64_1:ShouldShakeDailogue() then
		arg_64_2()

		return
	end

	local var_64_0 = arg_64_1:GetShakeDailogueData().x
	local var_64_1 = var_3.number
	local var_64_2 = var_3.delay
	local var_64_3 = var_3.speed
	local var_64_4 = arg_64_0.dialoguePanel.localPosition.x

	arg_64_0:TweenMovex(arg_64_0.dialoguePanel, var_64_0, var_64_4, var_64_3, var_64_2, var_64_1, arg_64_2)

	return
end

function var_0_1.RegisterEvent(arg_65_0, arg_65_1, arg_65_2)
	if not arg_65_0.callback then
		return
	end

	setActive = var_3

	local var_65_0 = arg_65_0.optionPanel
	local var_65_1 = arg_65_1

	var_3(var_65_0, arg_65_1.ExistOption(var_65_1))

	if arg_65_1:ExistOption() then
		arg_65_0:ShowOptions(arg_65_1, arg_65_2)
	else
		local var_65_3

		if arg_65_0.autoNext then
			local var_65_2 = arg_65_0.script

			var_65_3 = var_65_3.GetTriggerDelayTime(var_65_2)

			arg_65_0:UnscaleDelayCall(var_65_3, arg_65_2)
		else
			onButton = var_65_3

			local var_65_4 = arg_65_0
			local var_65_5 = arg_65_0._tf
			local var_65_6 = arg_65_2

			SFX_PANEL = var_65_1

			var_65_3(var_65_4, var_65_5, var_65_6, var_65_1)
		end
	end

	arg_65_0.isRegisterEvent = true

	return
end

function var_0_1.UpdateTypeWriter(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = arg_66_1
	local var_66_1 = arg_66_1.GetSay(var_66_0)
	local var_66_2 = 999

	if var_66_1 and var_66_1 ~= "" then
		System = var_66_0
		var_66_2 = var_66_0.String.New(var_66_1).Length
	end

	if not var_66_1 or var_66_1 == "" or var_66_1 == "…" or not (#var_66_1 > 1) or not (var_66_2 > 1) then
		arg_66_2()

		return
	end

	if not arg_66_1:GetTypewriter() or arg_66_0.isUnmarkedSkipAll then
		arg_66_2()

		return
	end

	local var_66_3 = arg_66_0.typewriter

	function var_66_3.endFunc()
		arg_66_0.typewriterSpeed = 0

		local var_67_0 = arg_66_0.typewriter

		var_67_0.endFunc = nil
		removeOnButton = var_67_0

		var_67_0(arg_66_0._tf)
		arg_66_2()

		return
	end

	math = var_66_3

	local var_66_4 = var_66_3.max
	local var_66_5

	if not var_5.speed then
		var_66_5 = 0.1
	end

	arg_66_0.typewriterSpeed = var_66_4(var_66_5 * arg_66_0.timeScale, 0.001)

	local var_66_6

	if not var_5.speedUp then
		var_66_6 = arg_66_0.typewriterSpeed
	end

	local var_66_7 = arg_66_0.typewriter

	var_7.setSpeed(var_66_7, arg_66_0.typewriterSpeed)

	local var_66_8 = arg_66_0.typewriter

	var_7.Play(var_66_8)

	onButton = var_7

	local var_66_9 = arg_66_0
	local var_66_10 = arg_66_0._tf

	local function var_66_11()
		if arg_66_0.puase or arg_66_0.stop then
			return
		end

		local var_68_0 = arg_66_0

		math = var_2_10001
		var_68_0.typewriterSpeed = var_2_10001.min(arg_66_0.typewriterSpeed, var_66_6)

		local var_68_1 = arg_66_0.typewriter

		var_0.setSpeed(var_68_1, arg_66_0.typewriterSpeed)

		return
	end

	SFX_PANEL = var_1_10012

	var_7(var_66_9, var_66_10, var_66_11, var_1_10012)

	return
end

function var_0_1.LoadContentAndIcon(arg_69_0, arg_69_1, arg_69_2)
	setActive = var_1_10003

	var_1_10003(arg_69_0.nameContainer, not arg_69_1:IsHideName())

	local var_69_0 = "<size=24>" .. arg_69_1:GetSubName() .. "</size>"

	arg_69_0.nameTxt.text = arg_69_1:GetName() .. var_69_0
	arg_69_0.contentTxt.text = arg_69_1:GetSay()

	if arg_69_1:GetActorIcon() then
		GetImageSpriteFromAtlasAsync = var_5

		var_5("island/IslandShipIcon/" .. var_4, "", arg_69_0.iconImg)
	end

	setActive = var_5

	var_5(arg_69_0.iconImg, not arg_69_1:IsHideIcon())
	arg_69_2()

	return
end

function var_0_1.PlayCharatorAnimation(arg_70_0, arg_70_1, arg_70_2)
	if not arg_70_1:ExistAnimation() then
		arg_70_2()

		return
	end

	local var_70_0 = arg_70_0.script
	local var_70_1 = var_3.GetRole
	local var_70_2 = arg_70_1

	if not var_70_1(var_70_0, arg_70_1.GetUnitData(var_70_2)) then
		arg_70_2()

		return
	end

	local var_70_3 = arg_70_1:GetAnimation()
	local var_70_4 = var_3
	local var_70_5 = var_3.GetComponent

	typeof = var_70_2
	Animator = var_1_10010

	local var_70_9

	if not var_70_5(var_70_4, var_70_2(var_1_10010)) then
		local var_70_6 = var_3.transform
		local var_70_7 = var_6.GetChild(var_70_6, 0)
		local var_70_8 = var_6.GetComponent

		typeof = var_9
		Animator = var_1_10011
		var_70_9 = var_70_8(var_70_7, var_9(var_1_10011))
	end

	local var_70_10 = var_70_9:GetCurrentAnimatorStateInfo(0)

	if not var_6.IsName(var_70_10, var_70_3) then
		Animator = var_6

		local var_70_11 = var_6.StringToHash(var_70_3)

		for iter_70_0 = 1, var_70_9.layerCount do
			var_70_9:CrossFadeInFixedTime(var_70_11, 0.2, iter_70_0 - 1)
		end
	end

	arg_70_2()

	return
end

function var_0_1.Clear(arg_71_0)
	local var_71_0 = arg_71_0.asidePlayer

	var_1.Clear(var_71_0)

	arg_71_0.canvasGroup.blocksRaycasts = true

	local var_71_1 = arg_71_0.uiOptionList

	var_1.align(var_71_1, 0)

	removeOnButton = var_1

	var_1(arg_71_0._tf)
	arg_71_0:ClearAnimation()

	arg_71_0.blackBg.alpha = 0

	if arg_71_0.shakeCameraSrc then
		Object = var_1

		var_1.Destroy(arg_71_0.shakeCameraSrc)

		arg_71_0.shakeCameraSrc = nil
	end

	return
end

function var_0_1.OnEnd(arg_72_0)
	arg_72_0:DisactiveDefaultCamera()
	arg_72_0:ClearCustomCameraBlend()

	return
end

function var_0_1.Dispose(arg_73_0)
	local var_73_0 = arg_73_0.asidePlayer

	var_1.Dispose(var_73_0)

	arg_73_0.asidePlayer = nil
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_73_0)

	return
end

return var_0_1
