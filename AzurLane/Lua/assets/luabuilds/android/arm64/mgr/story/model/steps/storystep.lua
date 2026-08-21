local var_0_0 = class("StoryStep")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.flashout = arg_1_1.flashout
	arg_1_0.flashin = arg_1_1.flashin
	arg_1_0.bgName = arg_1_1.bgName
	arg_1_0.bgShadow = arg_1_1.bgShadow
	arg_1_0.blackBg = arg_1_1.blackBg
	arg_1_0.blackFg = arg_1_1.blackFg or 0
	arg_1_0.bgGlitchArt = arg_1_1.bgNoise
	arg_1_0.oldPhoto = arg_1_1.oldPhoto
	arg_1_0.bgm = arg_1_1.bgm
	arg_1_0.bgmDelay = arg_1_1.bgmDelay or 0
	arg_1_0.bgmVolume = arg_1_1.bgmVolume or -1
	arg_1_0.stopbgm = arg_1_1.stopbgm
	arg_1_0.effects = arg_1_1.effects or {}
	arg_1_0.blink = arg_1_1.flash
	arg_1_0.blinkWithColor = arg_1_1.flashN
	arg_1_0.soundeffect = arg_1_1.soundeffect
	arg_1_0.seDelay = arg_1_1.seDelay or 0
	arg_1_0.voice = arg_1_1.voice
	arg_1_0.voiceDelay = arg_1_1.voiceDelay or 0
	arg_1_0.stopVoice = defaultValue(arg_1_1.stopVoice, false)
	arg_1_0.movableNode = arg_1_1.movableNode
	arg_1_0.options = arg_1_1.options
	arg_1_0.optionForceCenter = arg_1_1.option_force_center
	arg_1_0.important = arg_1_1.important
	arg_1_0.branchCode = arg_1_1.optionFlag
	arg_1_0.globalBranchCode = arg_1_1.globalOptionFlag
	arg_1_0.recallOption = arg_1_1.recallOption
	arg_1_0.nextScriptName = arg_1_1.jumpto
	arg_1_0.eventDelay = arg_1_1.eventDelay or 0
	arg_1_0.bgColor = arg_1_1.bgColor or {
		0,
		0,
		0
	}
	arg_1_0.location = arg_1_1.location
	arg_1_0.icon = arg_1_1.icon
	arg_1_0.dispatcher = arg_1_1.dispatcher
	arg_1_0.shakeTime = defaultValue(arg_1_1.shakeTime, 0)
	arg_1_0.code = arg_1_1.code or -1
	arg_1_0.autoShowOption = defaultValue(arg_1_1.autoShowOption, false)
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

	if type(arg_2_0.code) == "string" or type(arg_2_0.code) == "number" then
		return arg_2_0.code == arg_2_1
	elseif type(arg_2_0.code) == "table" then
		return table.contains(arg_2_0.code, arg_2_1)
	end

	return false
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
	return bit.band(arg_7_0.placeholderType, Story.PLAYER) > 0
end

function var_0_0.ShouldReplaceTb(arg_8_0)
	return bit.band(arg_8_0.placeholderType, Story.TB) > 0
end

function var_0_0.ShouldReplaceDorm(arg_9_0)
	return bit.band(arg_9_0.placeholderType, Story.DORM) > 0
end

function var_0_0.ShouldReplaceCar2026(arg_10_0)
	return bit.band(arg_10_0.placeholderType, Story.CAR2026) > 0
end

function var_0_0.ReplacePlayerName(arg_11_0, arg_11_1)
	if getProxy(PlayerProxy) then
		if not getProxy(PlayerProxy):getRawData() then
			return arg_11_1
		end

		local var_11_0 = getProxy(PlayerProxy):getRawData()

		arg_11_1 = string.gsub(arg_11_1, "{playername}", (var_11_0:GetName()))

		return arg_11_1
	end
end

function var_0_0.ReplaceTbName(arg_12_0, arg_12_1)
	if pg.NewStoryMgr.GetInstance():IsReView() then
		return string.gsub(arg_12_1, "{tb}", i18n("child_story_name"))
	end

	if not getProxy(EducateProxy) or not getProxy(NewEducateProxy) then
		return arg_12_1
	end

	local var_12_0 = getProxy(NewEducateProxy)

	if not var_12_0:GetCurChar() then
		local var_12_1, var_12_2 = getProxy(EducateProxy):GetStoryInfo()

		arg_12_1 = string.gsub(arg_12_1, "{tb}", var_12_2)
	else
		local var_12_3, var_12_4 = getProxy(NewEducateProxy):GetStoryInfo()

		arg_12_1 = string.gsub(arg_12_1, "{tb}", var_12_4)
	end

	return arg_12_1
end

function var_0_0.ReplaceDormName(arg_13_0, arg_13_1)
	if not arg_13_0.actorName then
		return arg_13_1
	end

	local var_13_0 = getProxy(ApartmentProxy):getApartment(arg_13_0.actorName)
	local var_13_1 = var_13_0 and var_13_0:GetCallName() or arg_13_0.actorName

	arg_13_1 = string.gsub(arg_13_1, "{dorm3d}", var_13_1)

	return arg_13_1
end

function var_0_0.ReplaceCar2026Name(arg_14_0, arg_14_1)
	local var_14_0 = getProxy(ActivityProxy)
	local var_14_1 = var_14_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)
	local var_14_2 = ""

	if getProxy(PlayerProxy) then
		var_14_2 = getProxy(PlayerProxy):getRawData():GetName()
	end

	if var_14_1 then
		local var_14_3 = var_14_0:RawGetActivityById(var_14_1:getConfig("config_client").link_act)

		if var_14_3 and not var_14_3:isEnd() then
			var_14_2 = var_14_3.str_data1
		end
	end

	return string.gsub(arg_14_1, "{car2026}", var_14_2)
end

function var_0_0.ExistDispatcher(arg_15_0)
	return arg_15_0.dispatcher ~= nil
end

function var_0_0.GetDispatcher(arg_16_0)
	return arg_16_0.dispatcher
end

function var_0_0.IsRecallDispatcher(arg_17_0)
	if not arg_17_0:ExistDispatcher() then
		return false
	end

	local var_17_0 = arg_17_0:GetDispatcher()

	return var_17_0.callbackData ~= nil and var_17_0.callbackData.name ~= nil
end

function var_0_0.GetDispatcherRecallName(arg_18_0)
	if not arg_18_0:IsRecallDispatcher() then
		return nil
	end

	return arg_18_0:GetDispatcher().callbackData.name
end

function var_0_0.ShouldHideUI(arg_19_0)
	if not arg_19_0:IsRecallDispatcher() then
		return false
	end

	return arg_19_0:GetDispatcher().callbackData.hideUI == true
end

function var_0_0.ExistIcon(arg_20_0)
	return arg_20_0.icon ~= nil
end

function var_0_0.GetIconData(arg_21_0)
	return arg_21_0.icon
end

function var_0_0.SetId(arg_22_0, arg_22_1)
	arg_22_0.id = arg_22_1

	return
end

function var_0_0.GetId(arg_23_0)
	return arg_23_0.id
end

function var_0_0.AutoShowOption(arg_24_0)
	arg_24_0.autoShowOption = true

	return
end

function var_0_0.SkipEventForOption(arg_25_0)
	return arg_25_0:ExistOption() and arg_25_0.autoShowOption
end

function var_0_0.IsRecallOption(arg_26_0)
	if arg_26_0:ExistOption() and arg_26_0:GetOptionCnt() > 1 and arg_26_0.recallOption then
		return true
	end

	return false
end

function var_0_0.IsOptionForceCenter(arg_27_0)
	return arg_27_0.optionForceCenter
end

function var_0_0.SetBranchCode(arg_28_0, arg_28_1)
	arg_28_0.selectedBranchCode = arg_28_1

	return
end

function var_0_0.GetSelectedBranchCode(arg_29_0)
	return arg_29_0.selectedBranchCode
end

function var_0_0.ExistLocation(arg_30_0)
	return arg_30_0.location ~= nil
end

function var_0_0.GetLocation(arg_31_0)
	({}).text = arg_31_0.location[1] or ""
	;({}).time = arg_31_0.location[2] or 999

	return {}
end

function var_0_0.ExistMovableNode(arg_32_0)
	return arg_32_0.movableNode ~= nil and type(arg_32_0.movableNode) == "table" and #arg_32_0.movableNode > 0
end

function var_0_0.GetPathByString(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}
	local var_33_1 = pg.NewStoryMgr.GetInstance():GetRectSize()
	local var_33_2 = Vector3(-var_33_1.x * 0.5, var_33_1.y * 0.5, 0)
	local var_33_3 = Vector3(var_33_1.x * 0.5, var_33_1.y * 0.5, 0)
	local var_33_4 = Vector3(-var_33_1.x * 0.5, -var_33_1.y * 0.5, 0)
	local var_33_5 = Vector3(var_33_1.x * 0.5, -var_33_1.y * 0.5, 0)
	local var_33_6 = arg_33_2 or 200

	if arg_33_1 == "LTLB" then
		local var_33_7 = Vector3(var_33_6, 0, 0)

		var_33_0 = {
			var_33_2 + var_33_7,
			var_33_4 + var_33_7
		}
	elseif arg_33_1 == "LBLT" then
		local var_33_8 = Vector3(var_33_6, 0, 0)

		var_33_0 = {
			var_33_4 + var_33_8,
			var_33_2 + var_33_8
		}
	elseif arg_33_1 == "LTRT" then
		local var_33_9 = Vector3(0, -var_33_6, 0)

		var_33_0 = {
			var_33_2 + var_33_9,
			var_33_3 + var_33_9
		}
	elseif arg_33_1 == "RTLT" then
		local var_33_10 = Vector3(0, -var_33_6, 0)

		var_33_0 = {
			var_33_3 + var_33_10,
			var_33_2 + var_33_10
		}
	elseif arg_33_1 == "RTRB" then
		local var_33_11 = Vector3(var_33_6, 0, 0)

		var_33_0 = {
			var_33_3 + var_33_11,
			var_33_5 + var_33_11
		}
	elseif arg_33_1 == "RBRT" then
		local var_33_12 = Vector3(var_33_6, 0, 0)

		var_33_0 = {
			var_33_5 + var_33_12,
			var_33_3 + var_33_12
		}
	elseif arg_33_1 == "LBRB" then
		local var_33_13 = Vector3(0, -(arg_33_2 or 0), 0)

		var_33_0 = {
			var_33_4 + var_33_13,
			var_33_5 + var_33_13
		}
	elseif arg_33_1 == "RBLB" then
		local var_33_14 = Vector3(0, -(arg_33_2 or 0), 0)

		var_33_0 = {
			var_33_5 + var_33_14,
			var_33_4 + var_33_14
		}
	end

	return var_33_0
end

function var_0_0.GenMoveNode(arg_34_0, arg_34_1)
	local var_34_0 = {}

	if type(arg_34_1.path) == "table" then
		for iter_34_0, iter_34_1 in ipairs(arg_34_1.path) do
			table.insert(var_34_0, Vector3(iter_34_1[1], iter_34_1[2], 0))
		end
	else
		var_34_0 = type(arg_34_1.path) == "string" and arg_34_0:GetPathByString(arg_34_1.path, arg_34_1.offset) or arg_34_0:GetPathByString("LTRT")
	end

	local var_34_1 = type(arg_34_1.spine) == "table" or arg_34_1.spine == true
	local var_34_2

	if arg_34_1.spine == true then
		var_34_2 = {
			action = "walk",
			scale = 0.5
		}
	elseif var_34_1 then
		({}).action = arg_34_1.spine.action or "walk"
		;({}).scale = arg_34_1.spine.scale or 0.5
		var_34_2 = {}
	end

	local var_34_3 = {
		name = arg_34_1.name,
		isSpine = var_34_1,
		spineData = var_34_2,
		path = var_34_0,
		time = arg_34_1.time
	}

	var_34_3.delay = arg_34_1.delay or 0
	var_34_3.easeType = arg_34_1.easeType or LeanTweenType.linear

	return var_34_3
end

function var_0_0.GetMovableNode(arg_35_0)
	if not arg_35_0:ExistMovableNode() then
		return {}
	end

	local var_35_0 = {}
	local var_35_1 = arg_35_0.movableNode or {}

	for iter_35_0, iter_35_1 in pairs(var_35_1) do
		table.insert(var_35_0, (arg_35_0:GenMoveNode(iter_35_1)))
	end

	return var_35_0
end

function var_0_0.OldPhotoEffect(arg_36_0)
	return arg_36_0.oldPhoto
end

function var_0_0.ShouldBgGlitchArt(arg_37_0)
	return arg_37_0.bgGlitchArt
end

function var_0_0.IsSameBranch(arg_38_0, arg_38_1)
	return not arg_38_0.branchCode or arg_38_0.branchCode == arg_38_1
end

function var_0_0.IsGlobalFlagHit(arg_39_0)
	local var_39_0 = var_0_0.GetGlobalFlagKey(arg_39_0.globalBranchCode.id)
	local var_39_1 = 0

	while PlayerPrefs.HasKey(var_39_0 .. 1) do
		var_39_1 = var_39_1 + PlayerPrefs.GetInt(var_39_0 .. 1)
	end

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.globalBranchCode.section) do
		if var_39_1 >= iter_39_1[1] and var_39_1 <= iter_39_1[2] then
			return true
		end
	end

	return false
end

function var_0_0.GetGlobalFlagKey(arg_40_0)
	return getProxy(PlayerProxy):getRawData().id .. "GlobalStoryFlag_" .. arg_40_0 .. "_"
end

function var_0_0.GetMode(arg_41_0)
	assert(false, "should override this function")

	return
end

function var_0_0.GetFlashoutData(arg_42_0)
	if arg_42_0.flashout then
		return arg_42_0.flashout.alpha[1], arg_42_0.flashout.alpha[2], arg_42_0.flashout.dur, arg_42_0.flashout.black
	end

	return
end

function var_0_0.GetFlashinData(arg_43_0)
	if arg_43_0.flashin then
		return arg_43_0.flashin.alpha[1], arg_43_0.flashin.alpha[2], arg_43_0.flashin.dur, arg_43_0.flashin.black, arg_43_0.flashin.delay
	end

	return
end

function var_0_0.GetBgColor(arg_44_0)
	local var_44_0 = arg_44_0.bgColor[1] or 0
	local var_44_1 = arg_44_0.bgColor[2] or 0
	local var_44_2 = arg_44_0.bgColor[3] or 0

	return Color.New(var_44_0, var_44_1, var_44_2)
end

function var_0_0.IsBlackBg(arg_45_0)
	return arg_45_0.blackBg
end

function var_0_0.GetBgName(arg_46_0)
	return arg_46_0.bgName
end

function var_0_0.GetBgShadow(arg_47_0)
	return arg_47_0.bgShadow
end

function var_0_0.IsDialogueMode(arg_48_0)
	return arg_48_0:GetMode() == Story.MODE_DIALOGUE
end

function var_0_0.GetBgmData(arg_49_0)
	return arg_49_0.bgm, arg_49_0.bgmDelay, arg_49_0.bgmVolume
end

function var_0_0.ShoulePlayBgm(arg_50_0)
	return arg_50_0.bgm ~= nil
end

function var_0_0.ShouldStopBgm(arg_51_0)
	return arg_51_0.stopbgm
end

function var_0_0.GetEffects(arg_52_0)
	return arg_52_0.effects
end

function var_0_0.ShouldBlink(arg_53_0)
	return arg_53_0.blink ~= nil
end

function var_0_0.GetBlinkData(arg_54_0)
	return arg_54_0.blink
end

function var_0_0.ShouldBlinkWithColor(arg_55_0)
	return arg_55_0.blinkWithColor ~= nil
end

function var_0_0.GetBlinkWithColorData(arg_56_0)
	return arg_56_0.blinkWithColor
end

function var_0_0.ShouldPlaySoundEffect(arg_57_0)
	return arg_57_0.soundeffect ~= nil
end

function var_0_0.GetSoundeffect(arg_58_0)
	return arg_58_0.soundeffect, arg_58_0.seDelay
end

function var_0_0.ShouldPlayVoice(arg_59_0)
	return arg_59_0.voice ~= nil
end

function var_0_0.ShouldStopVoice(arg_60_0)
	return arg_60_0.stopVoice
end

function var_0_0.GetVoice(arg_61_0)
	return arg_61_0.voice, arg_61_0.voiceDelay
end

function var_0_0.ExistOption(arg_62_0)
	return arg_62_0.options ~= nil and #arg_62_0.options > 0
end

function var_0_0.GetOptionCnt(arg_63_0)
	if arg_63_0:ExistOption() then
		return #arg_63_0.options
	else
		return 0
	end

	return
end

function var_0_0.SetOptionSelCodes(arg_64_0, arg_64_1)
	arg_64_0.optionSelCode = arg_64_1

	return
end

function var_0_0.IsBlackFrontGround(arg_65_0)
	local var_65_1 = Mathf.Clamp01(arg_65_0.blackFg)
end

function var_0_0.GetOptionIndexByAutoSel(arg_66_0)
	local var_66_0 = 0
	local var_66_1 = 0

	for iter_66_0, iter_66_1 in ipairs(arg_66_0.options) do
		if arg_66_0.optionSelCode and iter_66_1.flag == arg_66_0.optionSelCode then
			var_66_0 = iter_66_0

			break
		end

		if iter_66_1.autochoice and iter_66_1.autochoice == 1 then
			var_66_1 = iter_66_0
		end
	end

	if var_66_0 > 0 then
		return var_66_0
	end

	if var_66_1 > 0 then
		return var_66_1
	end

	return nil
end

function var_0_0.IsImport(arg_67_0)
	return arg_67_0.important
end

function var_0_0.SetOptionIndex(arg_68_0, arg_68_1)
	arg_68_0.optionIndex = arg_68_1

	return
end

function var_0_0.GetOptionIndex(arg_69_0)
	return arg_69_0.optionIndex
end

function var_0_0.GetOptions(arg_70_0)
	local var_70_0 = arg_70_0.options or {}

	return _.map(var_70_0, function(arg_71_0)
		local var_71_0 = arg_71_0.content

		if arg_70_0:ShouldReplacePlayer() then
			var_71_0 = arg_70_0:ReplacePlayerName(var_71_0)
		end

		if arg_70_0:ShouldReplaceTb() then
			var_71_0 = arg_70_0:ReplaceTbName(var_71_0)
		end

		if arg_70_0:ShouldReplaceDorm() then
			var_71_0 = arg_70_0:ReplaceDormName(var_71_0)
		end

		if arg_70_0:ShouldReplaceCar2026() then
			var_71_0 = arg_70_0:ReplaceCar2026Name(var_71_0)
		end

		;({})[1] = HXSet.hxLan(var_71_0)
		;({})[2] = arg_71_0.flag
		;({})[3] = arg_71_0.type
		;({})[4] = arg_71_0.globalFlag

		return {}
	end)
end

function var_0_0.ShouldJumpToNextScript(arg_72_0)
	return arg_72_0.nextScriptName ~= nil
end

function var_0_0.GetNextScriptName(arg_73_0)
	return arg_73_0.nextScriptName
end

function var_0_0.ShouldDelayEvent(arg_74_0)
	return arg_74_0.eventDelay and arg_74_0.eventDelay > 0
end

function var_0_0.GetEventDelayTime(arg_75_0)
	return arg_75_0.eventDelay
end

function var_0_0.GetUsingPaintingNames(arg_76_0)
	return {}
end

function var_0_0.GetResList(arg_77_0)
	local var_77_0 = arg_77_0:GetBgName()

	if var_77_0 then
		table.insert({}, var_77_0)
	end

	if arg_77_0.GetSubBg then
		local var_77_1 = arg_77_0:GetSubBg()

		if var_77_1 then
			table.insert({}, var_77_1)
		end
	end

	local var_77_2 = _.map({}, function(arg_78_0)
		return "bg/" .. arg_78_0
	end)
	local var_77_3, var_77_4, var_77_5 = arg_77_0:GetBgmData()

	if var_77_3 then
		table.insert({}, var_77_3)
	end

	local var_77_6 = {}

	_.each({}, function(arg_79_0)
		table.insert(var_77_6, "cue/" .. arg_79_0 .. ".b")
		table.insert(var_77_6, "cue/bgm-" .. arg_79_0 .. ".b")

		return
	end)

	if arg_77_0:ShouldPlaySoundEffect() then
		local var_77_7, var_77_8 = arg_77_0:GetSoundeffect()

		if var_77_7 then
			table.insert({}, var_77_7)
		end
	end

	local var_77_9 = {}

	_.each({}, function(arg_80_0)
		local var_80_0 = pg.CriMgr.GetInstance():CheckFModeEvent(arg_80_0, function()
			return
		end, function()
			return
		end)

		if var_80_0 then
			table.insert(var_77_9, "cue/" .. var_80_0 .. ".b")
		end

		return
	end)

	if arg_77_0:ShouldPlayVoice() then
		local var_77_10, var_77_11 = arg_77_0:GetVoice()

		if var_77_10 then
			table.insert({}, var_77_10)
		end
	end

	local var_77_12 = {}

	_.each({}, function(arg_83_0)
		local var_83_0 = pg.CriMgr.GetInstance():CheckFModeEvent(arg_83_0, function()
			return
		end, function()
			return
		end)

		if var_83_0 then
			table.insert(var_77_12, "cue/" .. var_83_0 .. ".b")
		end

		return
	end)

	local var_77_13 = {}

	_.each(arg_77_0:GetEffects(), function(arg_86_0)
		table.insert(var_77_13, arg_86_0.name)

		return
	end)

	local var_77_14 = {}

	_.each({}, function(arg_87_0)
		table.insert(var_77_14, "ui/" .. arg_87_0)
		table.insert(var_77_14, "effect/" .. arg_87_0)

		return
	end)

	if arg_77_0:ExistIcon() then
		local var_77_15 = arg_77_0:GetIconData()

		if var_77_15 and var_77_15.image then
			table.insert({}, var_77_15.image)
		end
	end

	local var_77_16 = {}
	local var_77_17 = StoryRecorder.New()

	var_77_17:Add(arg_77_0)
	_.each(var_77_17:GetContentList(), function(arg_88_0)
		if arg_88_0.icon then
			table.insert(var_77_16, "squareicon/" .. arg_88_0.icon)
		end

		return
	end)

	return (SplitPackMediatorResMap.MergeLuaArr(var_77_2, var_77_6, var_77_9, var_77_12, {}, {}, var_77_16))
end

return var_0_0
