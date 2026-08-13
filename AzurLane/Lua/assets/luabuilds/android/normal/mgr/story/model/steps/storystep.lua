class = var_0_10000

local var_0_0 = var_0_10000("StoryStep")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.flashout = arg_1_1.flashout
	arg_1_0.flashin = arg_1_1.flashin
	arg_1_0.bgName = arg_1_1.bgName
	arg_1_0.bgShadow = arg_1_1.bgShadow
	arg_1_0.blackBg = arg_1_1.blackBg

	local var_1_0

	if not arg_1_1.blackFg then
		var_1_0 = 0
	end

	arg_1_0.blackFg = var_1_0
	arg_1_0.bgGlitchArt = arg_1_1.bgNoise
	arg_1_0.oldPhoto = arg_1_1.oldPhoto
	arg_1_0.bgm = arg_1_1.bgm

	local var_1_1

	if not arg_1_1.bgmDelay then
		var_1_1 = 0
	end

	arg_1_0.bgmDelay = var_1_1

	local var_1_2

	if not arg_1_1.bgmVolume then
		var_1_2 = -1
	end

	arg_1_0.bgmVolume = var_1_2
	arg_1_0.stopbgm = arg_1_1.stopbgm

	local var_1_3

	if not arg_1_1.effects then
		var_1_3 = {}
	end

	arg_1_0.effects = var_1_3
	arg_1_0.blink = arg_1_1.flash
	arg_1_0.blinkWithColor = arg_1_1.flashN
	arg_1_0.soundeffect = arg_1_1.soundeffect

	local var_1_4

	if not arg_1_1.seDelay then
		var_1_4 = 0
	end

	arg_1_0.seDelay = var_1_4
	arg_1_0.voice = arg_1_1.voice

	local var_1_5

	if not arg_1_1.voiceDelay then
		var_1_5 = 0
	end

	arg_1_0.voiceDelay = var_1_5
	defaultValue = var_1_5
	arg_1_0.stopVoice = var_1_5(arg_1_1.stopVoice, false)
	arg_1_0.movableNode = arg_1_1.movableNode
	arg_1_0.options = arg_1_1.options
	arg_1_0.optionForceCenter = arg_1_1.option_force_center
	arg_1_0.important = arg_1_1.important
	arg_1_0.branchCode = arg_1_1.optionFlag
	arg_1_0.globalBranchCode = arg_1_1.globalOptionFlag
	arg_1_0.recallOption = arg_1_1.recallOption
	arg_1_0.nextScriptName = arg_1_1.jumpto

	local var_1_6

	if not arg_1_1.eventDelay then
		var_1_6 = 0
	end

	arg_1_0.eventDelay = var_1_6

	local var_1_7

	if not arg_1_1.bgColor then
		var_1_7 = {
			0,
			0,
			0
		}
	end

	arg_1_0.bgColor = var_1_7
	arg_1_0.location = arg_1_1.location
	arg_1_0.icon = arg_1_1.icon
	arg_1_0.dispatcher = arg_1_1.dispatcher
	defaultValue = var_2
	arg_1_0.shakeTime = var_2(arg_1_1.shakeTime, 0)

	local var_1_8

	if not arg_1_1.code then
		var_1_8 = -1
	end

	arg_1_0.code = var_1_8
	defaultValue = var_1_8
	arg_1_0.autoShowOption = var_1_8(arg_1_1.autoShowOption, false)
	arg_1_0.selectedBranchCode = 0
	arg_1_0.id = 0
	arg_1_0.placeholderType = 0
	arg_1_0.defaultTb = arg_1_1.defaultTb
	arg_1_0.optionIndex = 0

	return
end

function var_0_0.IsValid(arg_2_0, arg_2_1)
	if arg_2_0.code == -1 then
		return true
	end

	type = var_2

	if var_2(arg_2_0.code) ~= "string" then
		type = var_2_0

		local var_2_0

		if var_2_0(arg_2_0.code) == "number" then
			var_2_0 = arg_2_0.code == arg_2_1

			return var_2_0
		else
			type = var_2_0

			if var_2_0(arg_2_0.code) == "table" then
				table = var_2

				return var_2.contains(arg_2_0.code, arg_2_1)
			end
		end

		return false
	end
end

function var_0_0.ShouldShake(arg_3_0)
	return arg_3_0.shakeTime > 0
end

function var_0_0.GetShakeTime(arg_4_0)
	return arg_4_0.shakeTime
end

function var_0_0.SetDefaultTb(arg_5_0, arg_5_1)
	if not arg_5_0.defaultTb or arg_5_0.defaultTb <= 0 then
		arg_5_0.defaultTb = arg_5_1
	end

	return
end

function var_0_0.SetPlaceholderType(arg_6_0, arg_6_1)
	arg_6_0.placeholderType = arg_6_1

	return
end

function var_0_0.ShouldReplacePlayer(arg_7_0)
	bit = var_1_10001

	local var_7_0 = var_1_10001.band
	local var_7_1 = arg_7_0.placeholderType

	Story = var_1_10003

	return var_7_0(var_7_1, var_1_10003.PLAYER) > 0
end

function var_0_0.ShouldReplaceTb(arg_8_0)
	bit = var_1_10001

	local var_8_0 = var_1_10001.band
	local var_8_1 = arg_8_0.placeholderType

	Story = var_1_10003

	return var_8_0(var_8_1, var_1_10003.TB) > 0
end

function var_0_0.ShouldReplaceDorm(arg_9_0)
	bit = var_1_10001

	local var_9_0 = var_1_10001.band
	local var_9_1 = arg_9_0.placeholderType

	Story = var_1_10003

	return var_9_0(var_9_1, var_1_10003.DORM) > 0
end

function var_0_0.ReplacePlayerName(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	if var_1_10002(var_1_10003) then
		getProxy = var_2
		PlayerProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)

		if not var_2.getRawData(var_1_10003) then
			return arg_10_1
		end

		getProxy = var_2
		PlayerProxy = var_1_10003

		local var_10_0 = var_2(var_1_10003)
		local var_10_1 = var_2.getRawData(var_10_0)
		local var_10_2 = var_2.GetName(var_10_1)

		string = var_10_1

		return (var_10_1.gsub(arg_10_1, "{playername}", var_10_2))
	end
end

function var_0_0.ReplaceTbName(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.NewStoryMgr.GetInstance()
	local var_11_1

	if var_2.IsReView(var_11_0) then
		string = var_11_1
		var_11_1 = var_11_1.gsub
		var_11_0 = arg_11_1
		var_1_10004 = "{tb}"
		i18n = var_1_10005

		return var_11_1(var_11_0, var_1_10004, var_1_10005("child_story_name"))
	end

	getProxy = var_11_1
	EducateProxy = var_11_0

	if var_11_1(var_11_0) then
		getProxy = var_2
		NewEducateProxy = var_11_0

		if not var_2(var_11_0) then
			return arg_11_1
		end

		getProxy = var_2
		NewEducateProxy = var_11_0

		local var_11_2 = var_2(var_11_0)
		local var_11_3

		if not var_2.GetCurChar(var_11_2) then
			getProxy = var_11_3
			EducateProxy = var_11_2
			var_11_2 = var_11_3(var_11_2)
			var_11_3, var_11_2 = var_11_3.GetStoryInfo(var_11_2)
			string = var_1_10004
			arg_11_1 = var_1_10004.gsub(arg_11_1, "{tb}", var_11_2)
		else
			getProxy = var_11_3
			NewEducateProxy = var_11_2

			local var_11_4 = var_11_3(var_11_2)
			local var_11_5, var_11_6 = var_2.GetStoryInfo(var_11_4)

			string = var_1_10004
			arg_11_1 = var_1_10004.gsub(arg_11_1, "{tb}", var_11_6)
		end

		return arg_11_1
	end
end

function var_0_0.ReplaceDormName(arg_12_0, arg_12_1)
	if not arg_12_0.actorName then
		return arg_12_1
	end

	getProxy = var_2
	ApartmentProxy = var_1_10003

	local var_12_0 = var_2(var_1_10003)

	if var_2.getApartment(var_12_0, arg_12_0.actorName) then
		local var_12_1 = var_2
		local var_12_2

		if not var_2.GetCallName(var_12_1) then
			var_12_2 = arg_12_0.actorName
		end

		string = var_12_1

		return (var_12_1.gsub(arg_12_1, "{dorm3d}", var_12_2))
	end
end

function var_0_0.ExistDispatcher(arg_13_0)
	return arg_13_0.dispatcher ~= nil
end

function var_0_0.GetDispatcher(arg_14_0)
	return arg_14_0.dispatcher
end

function var_0_0.IsRecallDispatcher(arg_15_0)
	if not arg_15_0:ExistDispatcher() then
		return false
	end

	return arg_15_0:GetDispatcher().callbackData ~= nil and var_1.callbackData.name ~= nil
end

function var_0_0.GetDispatcherRecallName(arg_16_0)
	if not arg_16_0:IsRecallDispatcher() then
		return nil
	end

	return arg_16_0:GetDispatcher().callbackData.name
end

function var_0_0.ShouldHideUI(arg_17_0)
	if not arg_17_0:IsRecallDispatcher() then
		return false
	end

	return arg_17_0:GetDispatcher().callbackData.hideUI == true
end

function var_0_0.ExistIcon(arg_18_0)
	return arg_18_0.icon ~= nil
end

function var_0_0.GetIconData(arg_19_0)
	return arg_19_0.icon
end

function var_0_0.SetId(arg_20_0, arg_20_1)
	arg_20_0.id = arg_20_1

	return
end

function var_0_0.GetId(arg_21_0)
	return arg_21_0.id
end

function var_0_0.AutoShowOption(arg_22_0)
	arg_22_0.autoShowOption = true

	return
end

function var_0_0.SkipEventForOption(arg_23_0)
	local var_23_0

	if arg_23_0:ExistOption() then
		var_23_0 = arg_23_0.autoShowOption
	end

	return var_23_0
end

function var_0_0.IsRecallOption(arg_24_0)
	if arg_24_0:ExistOption() and arg_24_0:GetOptionCnt() > 1 and arg_24_0.recallOption then
		return true
	end

	return false
end

function var_0_0.IsOptionForceCenter(arg_25_0)
	return arg_25_0.optionForceCenter
end

function var_0_0.SetBranchCode(arg_26_0, arg_26_1)
	arg_26_0.selectedBranchCode = arg_26_1

	return
end

function var_0_0.GetSelectedBranchCode(arg_27_0)
	return arg_27_0.selectedBranchCode
end

function var_0_0.ExistLocation(arg_28_0)
	return arg_28_0.location ~= nil
end

function var_0_0.GetLocation(arg_29_0)
	local var_29_0 = {}
	local var_29_1

	if not arg_29_0.location[1] then
		var_29_1 = ""
	end

	var_29_0.text = var_29_1

	local var_29_2

	if not arg_29_0.location[2] then
		var_29_2 = 999
	end

	var_29_0.time = var_29_2

	return var_29_0
end

function var_0_0.ExistMovableNode(arg_30_0)
	if arg_30_0.movableNode ~= nil then
		type = var_1

		local var_30_0

		if var_1(arg_30_0.movableNode) ~= "table" or not (#arg_30_0.movableNode > 0) then
			var_30_0 = false
		else
			var_30_0 = true
		end

		return var_30_0
	end
end

function var_0_0.GetPathByString(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {}

	pg = var_1_10004

	local var_31_1 = var_1_10004.NewStoryMgr.GetInstance()
	local var_31_2 = var_4.GetRectSize(var_31_1)

	Vector3 = var_31_1

	local var_31_3 = var_31_1(-var_31_2.x * 0.5, var_31_2.y * 0.5, 0)

	Vector3 = var_6

	local var_31_4 = var_6(var_31_2.x * 0.5, var_31_2.y * 0.5, 0)

	Vector3 = var_7

	local var_31_5 = var_7(-var_31_2.x * 0.5, -var_31_2.y * 0.5, 0)

	Vector3 = var_8

	local var_31_6 = var_8(var_31_2.x * 0.5, -var_31_2.y * 0.5, 0)
	local var_31_7 = arg_31_2 or 200
	local var_31_8

	if arg_31_1 == "LTLB" then
		Vector3 = var_31_8
		var_31_8 = var_31_8(var_31_7, 0, 0)
		var_31_0 = {
			var_31_3 + var_31_8,
			var_31_5 + var_31_8
		}
	elseif arg_31_1 == "LBLT" then
		Vector3 = var_31_8
		var_31_8 = var_31_8(var_31_7, 0, 0)
		var_31_0 = {
			var_31_5 + var_31_8,
			var_31_3 + var_31_8
		}
	elseif arg_31_1 == "LTRT" then
		Vector3 = var_31_8
		var_31_8 = var_31_8(0, -var_31_7, 0)
		var_31_0 = {
			var_31_3 + var_31_8,
			var_31_4 + var_31_8
		}
	elseif arg_31_1 == "RTLT" then
		Vector3 = var_31_8
		var_31_8 = var_31_8(0, -var_31_7, 0)
		var_31_0 = {
			var_31_4 + var_31_8,
			var_31_3 + var_31_8
		}
	elseif arg_31_1 == "RTRB" then
		Vector3 = var_31_8
		var_31_8 = var_31_8(var_31_7, 0, 0)
		var_31_0 = {
			var_31_4 + var_31_8,
			var_31_6 + var_31_8
		}
	elseif arg_31_1 == "RBRT" then
		Vector3 = var_31_8
		var_31_8 = var_31_8(var_31_7, 0, 0)
		var_31_0 = {
			var_31_6 + var_31_8,
			var_31_4 + var_31_8
		}
	elseif arg_31_1 == "LBRB" then
		Vector3 = var_31_8
		var_31_8 = var_31_8(0, -(arg_31_2 or 0), 0)
		var_31_0 = {
			var_31_5 + var_31_8,
			var_31_6 + var_31_8
		}
	elseif arg_31_1 == "RBLB" then
		Vector3 = var_31_8

		local var_31_9 = var_31_8(0, -(arg_31_2 or 0), 0)

		var_31_0 = {
			var_31_6 + var_31_9,
			var_31_5 + var_31_9
		}
	end

	return var_31_0
end

function var_0_0.GenMoveNode(arg_32_0, arg_32_1)
	local var_32_0 = {}

	type = var_1_10003

	if var_1_10003(arg_32_1.path) == "table" then
		ipairs = var_3

		for iter_32_0, iter_32_1 in var_3(arg_32_1.path) do
			table = var_1_10008
			var_1_10008 = var_1_10008.insert

			local var_32_1 = var_32_0

			Vector3 = var_1_10010

			var_1_10008(var_32_1, var_1_10010(iter_32_1[1], iter_32_1[2], 0))
		end
	else
		type = var_3

		if var_3(arg_32_1.path) == "string" then
			var_32_0 = arg_32_0:GetPathByString(arg_32_1.path, arg_32_1.offset)
		else
			var_32_0 = arg_32_0:GetPathByString("LTRT")
		end
	end

	type = var_3

	local var_32_2 = var_3(arg_32_1.spine) == "table" or arg_32_1.spine == true
	local var_32_3

	if arg_32_1.spine == true then
		var_32_3 = {
			action = "walk",
			scale = 0.5
		}
	elseif var_32_2 then
		local var_32_4 = {}
		local var_32_5

		if not arg_32_1.spine.action then
			var_32_5 = "walk"
		end

		var_32_4.action = var_32_5

		local var_32_6

		if not arg_32_1.spine.scale then
			var_32_6 = 0.5
		end

		var_32_4.scale = var_32_6
		var_32_3 = var_32_4
	end

	local var_32_7 = {
		name = arg_32_1.name,
		isSpine = var_32_2,
		spineData = var_32_3,
		path = var_32_0,
		time = arg_32_1.time
	}
	local var_32_8

	if not arg_32_1.delay then
		var_32_8 = 0
	end

	var_32_7.delay = var_32_8

	local var_32_9

	if not arg_32_1.easeType then
		LeanTweenType = var_32_9
		var_32_9 = var_32_9.linear
	end

	var_32_7.easeType = var_32_9

	return var_32_7
end

function var_0_0.GetMovableNode(arg_33_0)
	local var_33_0 = arg_33_0

	if not arg_33_0.ExistMovableNode(var_33_0) then
		return {}
	end

	local var_33_1 = {}

	pairs = var_33_0

	local var_33_2

	if not arg_33_0.movableNode then
		var_33_2 = {}
	end

	for iter_33_0, iter_33_1 in var_33_0(var_33_2) do
		local var_33_3 = arg_33_0
		local var_33_4 = arg_33_0.GenMoveNode(var_33_3, iter_33_1)

		table = var_33_3

		var_33_3.insert(var_33_1, var_33_4)
	end

	return var_33_1
end

function var_0_0.OldPhotoEffect(arg_34_0)
	return arg_34_0.oldPhoto
end

function var_0_0.ShouldBgGlitchArt(arg_35_0)
	return arg_35_0.bgGlitchArt
end

function var_0_0.IsSameBranch(arg_36_0, arg_36_1)
	return not arg_36_0.branchCode or arg_36_0.branchCode == arg_36_1
end

function var_0_0.IsGlobalFlagHit(arg_37_0)
	local var_37_0 = var_0_0.GetGlobalFlagKey(arg_37_0.globalBranchCode.id)
	local var_37_1 = 1
	local var_37_2 = 0

	::label_37_0::

	PlayerPrefs = var_1_10004

	if var_1_10004.HasKey(var_37_0 .. var_37_1) then
		repeat
			PlayerPrefs = var_1_10004
			var_37_2 = var_37_2 + var_1_10004.GetInt(var_37_0 .. var_37_1)
			var_37_1 = var_37_1 + 1

			goto label_37_0
		until true
	end

	local var_37_3 = arg_37_0.globalBranchCode.section

	ipairs = var_5

	for iter_37_0, iter_37_1 in var_5(var_37_3) do
		if var_37_2 >= iter_37_1[1] and var_37_2 <= iter_37_1[2] then
			return true
		end
	end

	return false
end

function var_0_0.GetGlobalFlagKey(arg_38_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_38_0 = var_1_10001(var_1_10002)

	return var_1.getRawData(var_38_0).id .. "GlobalStoryFlag_" .. arg_38_0 .. "_"
end

function var_0_0.GetMode(arg_39_0)
	assert = var_1_10001

	var_1_10001(false, "should override this function")

	return
end

function var_0_0.GetFlashoutData(arg_40_0)
	if arg_40_0.flashout then
		local var_40_0 = arg_40_0.flashout.alpha[1]
		local var_40_1 = arg_40_0.flashout.alpha[2]
		local var_40_2 = arg_40_0.flashout.dur
		local var_40_3 = arg_40_0.flashout.black

		return var_40_0, var_40_1, var_40_2, var_40_3
	end

	return
end

function var_0_0.GetFlashinData(arg_41_0)
	if arg_41_0.flashin then
		local var_41_0 = arg_41_0.flashin.alpha[1]
		local var_41_1 = arg_41_0.flashin.alpha[2]
		local var_41_2 = arg_41_0.flashin.dur
		local var_41_3 = arg_41_0.flashin.black
		local var_41_4 = arg_41_0.flashin.delay

		return var_41_0, var_41_1, var_41_2, var_41_3, var_41_4
	end

	return
end

function var_0_0.GetBgColor(arg_42_0)
	Color = var_1_10001

	local var_42_0 = var_1_10001.New
	local var_42_1

	if not arg_42_0.bgColor[1] then
		var_42_1 = 0
	end

	local var_42_2

	if not arg_42_0.bgColor[2] then
		var_42_2 = 0
	end

	local var_42_3

	if not arg_42_0.bgColor[3] then
		var_42_3 = 0
	end

	return var_42_0(var_42_1, var_42_2, var_42_3)
end

function var_0_0.IsBlackBg(arg_43_0)
	return arg_43_0.blackBg
end

function var_0_0.GetBgName(arg_44_0)
	return arg_44_0.bgName
end

function var_0_0.GetBgShadow(arg_45_0)
	return arg_45_0.bgShadow
end

function var_0_0.IsDialogueMode(arg_46_0)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.GetMode(var_46_0)

	Story = var_46_0

	return var_46_1 == var_46_0.MODE_DIALOGUE
end

function var_0_0.GetBgmData(arg_47_0)
	return arg_47_0.bgm, arg_47_0.bgmDelay, arg_47_0.bgmVolume
end

function var_0_0.ShoulePlayBgm(arg_48_0)
	return arg_48_0.bgm ~= nil
end

function var_0_0.ShouldStopBgm(arg_49_0)
	return arg_49_0.stopbgm
end

function var_0_0.GetEffects(arg_50_0)
	return arg_50_0.effects
end

function var_0_0.ShouldBlink(arg_51_0)
	return arg_51_0.blink ~= nil
end

function var_0_0.GetBlinkData(arg_52_0)
	return arg_52_0.blink
end

function var_0_0.ShouldBlinkWithColor(arg_53_0)
	return arg_53_0.blinkWithColor ~= nil
end

function var_0_0.GetBlinkWithColorData(arg_54_0)
	return arg_54_0.blinkWithColor
end

function var_0_0.ShouldPlaySoundEffect(arg_55_0)
	return arg_55_0.soundeffect ~= nil
end

function var_0_0.GetSoundeffect(arg_56_0)
	return arg_56_0.soundeffect, arg_56_0.seDelay
end

function var_0_0.ShouldPlayVoice(arg_57_0)
	return arg_57_0.voice ~= nil
end

function var_0_0.ShouldStopVoice(arg_58_0)
	return arg_58_0.stopVoice
end

function var_0_0.GetVoice(arg_59_0)
	return arg_59_0.voice, arg_59_0.voiceDelay
end

function var_0_0.ExistOption(arg_60_0)
	return arg_60_0.options ~= nil and #arg_60_0.options > 0
end

function var_0_0.GetOptionCnt(arg_61_0)
	if arg_61_0:ExistOption() then
		return #arg_61_0.options
	else
		return 0
	end

	return
end

function var_0_0.SetOptionSelCodes(arg_62_0, arg_62_1)
	arg_62_0.optionSelCode = arg_62_1

	return
end

function var_0_0.IsBlackFrontGround(arg_63_0)
	local var_63_0 = arg_63_0.blackFg
	local var_63_1

	var_63_1 = 0 < var_63_0
	Mathf = var_2

	local var_63_2 = var_2.Clamp01(arg_63_0.blackFg)
end

function var_0_0.GetOptionIndexByAutoSel(arg_64_0)
	local var_64_0 = 0
	local var_64_1 = 0

	ipairs = var_1_10003

	for iter_64_0, iter_64_1 in var_1_10003(arg_64_0.options) do
		if arg_64_0.optionSelCode and iter_64_1.flag == arg_64_0.optionSelCode then
			var_64_0 = iter_64_0

			break
		end

		if iter_64_1.autochoice and iter_64_1.autochoice == 1 then
			var_64_1 = iter_64_0
		end
	end

	if var_64_0 > 0 then
		return var_64_0
	end

	if var_64_1 > 0 then
		return var_64_1
	end

	return nil
end

function var_0_0.IsImport(arg_65_0)
	return arg_65_0.important
end

function var_0_0.SetOptionIndex(arg_66_0, arg_66_1)
	arg_66_0.optionIndex = arg_66_1

	return
end

function var_0_0.GetOptionIndex(arg_67_0)
	return arg_67_0.optionIndex
end

function var_0_0.GetOptions(arg_68_0)
	_ = var_1_10001

	local var_68_0 = var_1_10001.map
	local var_68_1

	if not arg_68_0.options then
		var_68_1 = {}
	end

	return var_68_0(var_68_1, function(arg_69_0)
		local var_69_0 = arg_69_0.content
		local var_69_1 = arg_68_0

		if var_2.ShouldReplacePlayer(var_69_1) then
			local var_69_2 = arg_68_0

			var_69_0 = var_2.ReplacePlayerName(var_69_2, var_69_0)
		end

		local var_69_3 = arg_68_0

		if var_2.ShouldReplaceTb(var_69_3) then
			local var_69_4 = arg_68_0

			var_69_0 = var_2.ReplaceTbName(var_69_4, var_69_0)
		end

		local var_69_5 = arg_68_0

		if var_2.ShouldReplaceDorm(var_69_5) then
			local var_69_6 = arg_68_0

			var_69_0 = var_2.ReplaceDormName(var_69_6, var_69_0)
		end

		HXSet = var_2

		local var_69_7 = var_2.hxLan(var_69_0)

		return {
			var_69_7,
			arg_69_0.flag,
			arg_69_0.type,
			arg_69_0.globalFlag
		}
	end)
end

function var_0_0.ShouldJumpToNextScript(arg_70_0)
	return arg_70_0.nextScriptName ~= nil
end

function var_0_0.GetNextScriptName(arg_71_0)
	return arg_71_0.nextScriptName
end

function var_0_0.ShouldDelayEvent(arg_72_0)
	local var_72_0

	if arg_72_0.eventDelay then
		var_72_0 = arg_72_0.eventDelay > 0
	end

	return var_72_0
end

function var_0_0.GetEventDelayTime(arg_73_0)
	return arg_73_0.eventDelay
end

function var_0_0.GetUsingPaintingNames(arg_74_0)
	return {}
end

function var_0_0.GetResList(arg_75_0)
	local var_75_0 = {}
	local var_75_1 = arg_75_0

	if arg_75_0.GetBgName(var_75_1) then
		table = var_75_1

		var_75_1.insert(var_75_0, var_2)
	end

	if arg_75_0.GetSubBg then
		local var_75_2 = arg_75_0

		if arg_75_0.GetSubBg(var_75_2) then
			table = var_75_2

			var_75_2.insert(var_75_0, var_3)
		end
	end

	_ = var_3

	local var_75_3 = var_3.map(var_75_0, function(arg_76_0)
		return "bg/" .. arg_76_0
	end)
	local var_75_4 = {}
	local var_75_5, var_75_6, var_75_7 = arg_75_0:GetBgmData()

	if var_75_5 then
		table = var_1_10008

		var_1_10008.insert(var_75_4, var_75_5)
	end

	local var_75_8 = {}

	_ = var_1_10009

	var_1_10009.each(var_75_4, function(arg_77_0)
		table = var_2_10001

		var_2_10001.insert(var_75_8, "cue/" .. arg_77_0 .. ".b")

		table = var_1

		var_1.insert(var_75_8, "cue/bgm-" .. arg_77_0 .. ".b")

		return
	end)

	local var_75_9 = {}
	local var_75_10 = arg_75_0

	if arg_75_0.ShouldPlaySoundEffect(var_75_10) then
		var_75_10 = arg_75_0

		local var_75_11

		var_75_11, var_75_10 = arg_75_0.GetSoundeffect(var_75_10)

		if var_75_11 then
			table = var_1_10012

			var_1_10012.insert(var_75_9, var_75_11)
		end
	end

	local var_75_12 = {}

	_ = var_75_10

	var_75_10.each(var_75_9, function(arg_78_0)
		pg = var_2_10001

		local var_78_0 = var_2_10001.CriMgr.GetInstance()

		if var_1.CheckFModeEvent(var_78_0, arg_78_0, function()
			return
		end, function()
			return
		end) then
			table = var_78_0

			var_78_0.insert(var_75_12, "cue/" .. var_1 .. ".b")
		end

		return
	end)

	local var_75_13 = {}
	local var_75_14 = arg_75_0

	if arg_75_0.ShouldPlayVoice(var_75_14) then
		var_75_14 = arg_75_0

		local var_75_15

		var_75_15, var_75_14 = arg_75_0.GetVoice(var_75_14)

		if var_75_15 then
			table = var_1_10014

			var_1_10014.insert(var_75_13, var_75_15)
		end
	end

	local var_75_16 = {}

	_ = var_75_14

	var_75_14.each(var_75_13, function(arg_81_0)
		pg = var_2_10001

		local var_81_0 = var_2_10001.CriMgr.GetInstance()

		if var_1.CheckFModeEvent(var_81_0, arg_81_0, function()
			return
		end, function()
			return
		end) then
			table = var_81_0

			var_81_0.insert(var_75_16, "cue/" .. var_1 .. ".b")
		end

		return
	end)

	local var_75_17 = {}
	local var_75_18 = arg_75_0
	local var_75_19 = arg_75_0.GetEffects(var_75_18)

	_ = var_75_18

	var_75_18.each(var_75_19, function(arg_84_0)
		local var_84_0 = arg_84_0.name

		table = var_2_10002

		var_2_10002.insert(var_75_17, var_84_0)

		return
	end)

	local var_75_20 = {}

	_ = var_16

	var_16.each(var_75_17, function(arg_85_0)
		table = var_2_10001

		var_2_10001.insert(var_75_20, "ui/" .. arg_85_0)

		table = var_1

		var_1.insert(var_75_20, "effect/" .. arg_85_0)

		return
	end)

	local var_75_21 = {}
	local var_75_22 = arg_75_0

	if arg_75_0.ExistIcon(var_75_22) then
		var_75_22 = arg_75_0

		if arg_75_0.GetIconData(var_75_22) and var_17.image then
			table = var_75_22

			var_75_22.insert(var_75_21, var_17.image)
		end
	end

	local var_75_23 = {}

	StoryRecorder = var_75_22

	local var_75_24 = var_75_22.New()

	var_18.Add(var_75_24, arg_75_0)

	local var_75_25 = var_18
	local var_75_26 = var_18.GetContentList(var_75_25)

	_ = var_75_25

	var_75_25.each(var_75_26, function(arg_86_0)
		if arg_86_0.icon then
			local var_86_0 = "squareicon/" .. arg_86_0.icon

			table = var_2

			var_2.insert(var_75_23, var_86_0)
		end

		return
	end)

	SplitPackMediatorResMap = var_20

	return (var_20.MergeLuaArr(var_75_3, var_75_8, var_75_12, var_75_16, var_75_20, var_75_21, var_75_23))
end

return var_0_0
