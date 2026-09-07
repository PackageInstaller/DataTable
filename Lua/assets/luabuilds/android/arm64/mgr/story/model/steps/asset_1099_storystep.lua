local StoryStep = class("StoryStep")

function StoryStep:Ctor(arg_1_1)
	self.flashout = arg_1_1.flashout
	self.flashin = arg_1_1.flashin
	self.bgName = arg_1_1.bgName
	self.bgShadow = arg_1_1.bgShadow
	self.blackBg = arg_1_1.blackBg
	self.blackFg = arg_1_1.blackFg or 0
	self.bgGlitchArt = arg_1_1.bgNoise
	self.oldPhoto = arg_1_1.oldPhoto
	self.bgm = arg_1_1.bgm
	self.bgmDelay = arg_1_1.bgmDelay or 0
	self.bgmVolume = arg_1_1.bgmVolume or -1
	self.stopbgm = arg_1_1.stopbgm
	self.effects = arg_1_1.effects or {}
	self.blink = arg_1_1.flash
	self.blinkWithColor = arg_1_1.flashN
	self.soundeffect = arg_1_1.soundeffect
	self.seDelay = arg_1_1.seDelay or 0
	self.voice = arg_1_1.voice
	self.voiceDelay = arg_1_1.voiceDelay or 0
	self.stopVoice = defaultValue(arg_1_1.stopVoice, false)
	self.movableNode = arg_1_1.movableNode
	self.options = arg_1_1.options
	self.optionForceCenter = arg_1_1.option_force_center
	self.important = arg_1_1.important
	self.branchCode = arg_1_1.optionFlag
	self.globalBranchCode = arg_1_1.globalOptionFlag
	self.recallOption = arg_1_1.recallOption
	self.nextScriptName = arg_1_1.jumpto
	self.eventDelay = arg_1_1.eventDelay or 0
	self.bgColor = arg_1_1.bgColor or {
		0,
		0,
		0
	}
	self.location = arg_1_1.location
	self.icon = arg_1_1.icon
	self.dispatcher = arg_1_1.dispatcher
	self.shakeTime = defaultValue(arg_1_1.shakeTime, 0)
	self.code = arg_1_1.code or -1
	self.autoShowOption = defaultValue(arg_1_1.autoShowOption, false)
	self.selectedBranchCode = 0
	self.id = 0
	self.placeholderType = 0
	self.defaultTb = arg_1_1.defaultTb
	self.optionIndex = 0

	return
end

function StoryStep:IsValid(arg_2_1)
	if self.code == -1 then
		return true
	end

	if type(self.code) == "string" or type(self.code) == "number" then
		return self.code == arg_2_1
	elseif type(self.code) == "table" then
		return table.contains(self.code, arg_2_1)
	end

	return false
end

function StoryStep:ShouldShake()
	return self.shakeTime > 0
end

function StoryStep:GetShakeTime()
	return self.shakeTime
end

function StoryStep:SetDefaultTb(arg_5_1)
	if not self.defaultTb or self.defaultTb <= 0 then
		self.defaultTb = arg_5_1
	end

	return
end

function StoryStep:SetPlaceholderType(arg_6_1)
	self.placeholderType = arg_6_1

	return
end

function StoryStep:ShouldReplacePlayer()
	return bit.band(self.placeholderType, Story.PLAYER) > 0
end

function StoryStep:ShouldReplaceTb()
	return bit.band(self.placeholderType, Story.TB) > 0
end

function StoryStep:ShouldReplaceDorm()
	return bit.band(self.placeholderType, Story.DORM) > 0
end

function StoryStep:ShouldReplaceCar2026()
	return bit.band(self.placeholderType, Story.CAR2026) > 0
end

function StoryStep:ReplacePlayerName(arg_11_1)
	if getProxy(PlayerProxy) then
		if not getProxy(PlayerProxy):getRawData() then
			return arg_11_1
		end
	end

	arg_11_1 = string.gsub(arg_11_1, "{playername}", (getProxy(PlayerProxy):getRawData():GetName()))

	return arg_11_1
end

function StoryStep:ReplaceTbName(arg_12_1)
	if pg.NewStoryMgr.GetInstance():IsReView() then
		return string.gsub(arg_12_1, "{tb}", i18n("child_story_name"))
	end

	if not getProxy(EducateProxy) or not getProxy(NewEducateProxy) then
		return arg_12_1
	end

	if not getProxy(NewEducateProxy):GetCurChar() then
		local var_12_0, var_12_1 = getProxy(EducateProxy):GetStoryInfo()

		arg_12_1 = string.gsub(arg_12_1, "{tb}", var_12_1)
	else
		local var_12_2, var_12_3 = getProxy(NewEducateProxy):GetStoryInfo()

		arg_12_1 = string.gsub(arg_12_1, "{tb}", var_12_3)
	end

	return arg_12_1
end

function StoryStep:ReplaceDormName(arg_13_1)
	if not self.actorName then
		return arg_13_1
	end

	local var_13_0 = getProxy(ApartmentProxy):getApartment(self.actorName)

	arg_13_1 = string.gsub(arg_13_1, "{dorm3d}", var_13_0 and var_13_0:GetCallName() or self.actorName)

	return arg_13_1
end

function StoryStep:ReplaceCar2026Name(arg_14_1)
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

function StoryStep:ExistDispatcher()
	return self.dispatcher ~= nil
end

function StoryStep:GetDispatcher()
	return self.dispatcher
end

function StoryStep:IsRecallDispatcher()
	if not self:ExistDispatcher() then
		return false
	end

	local var_17_0 = self:GetDispatcher()

	return var_17_0.callbackData ~= nil and var_17_0.callbackData.name ~= nil
end

function StoryStep:GetDispatcherRecallName()
	if not self:IsRecallDispatcher() then
		return nil
	end

	return self:GetDispatcher().callbackData.name
end

function StoryStep:ShouldHideUI()
	if not self:IsRecallDispatcher() then
		return false
	end

	return self:GetDispatcher().callbackData.hideUI == true
end

function StoryStep:ExistIcon()
	return self.icon ~= nil
end

function StoryStep:GetIconData()
	return self.icon
end

function StoryStep:SetId(arg_22_1)
	self.id = arg_22_1

	return
end

function StoryStep:GetId()
	return self.id
end

function StoryStep:AutoShowOption()
	self.autoShowOption = true

	return
end

function StoryStep:SkipEventForOption()
	return self:ExistOption() and self.autoShowOption
end

function StoryStep:IsRecallOption()
	if self:ExistOption() and self:GetOptionCnt() > 1 and self.recallOption then
		return true
	end

	return false
end

function StoryStep:IsOptionForceCenter()
	return self.optionForceCenter
end

function StoryStep:SetBranchCode(arg_28_1)
	self.selectedBranchCode = arg_28_1

	return
end

function StoryStep:GetSelectedBranchCode()
	return self.selectedBranchCode
end

function StoryStep:ExistLocation()
	return self.location ~= nil
end

function StoryStep:GetLocation()
	local var_31_0 = {}

	var_31_0.text = self.location[1] or ""
	var_31_0.time = self.location[2] or 999

	return var_31_0
end

function StoryStep:ExistMovableNode()
	return self.movableNode ~= nil and type(self.movableNode) == "table" and #self.movableNode > 0
end

function StoryStep:GetPathByString(arg_33_1, arg_33_2)
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

function StoryStep:GenMoveNode(arg_34_1)
	local var_34_0 = {}

	if type(arg_34_1.path) == "table" then
		for iter_34_0, iter_34_1 in ipairs(arg_34_1.path) do
			table.insert(var_34_0, Vector3(iter_34_1[1], iter_34_1[2], 0))
		end
	else
		var_34_0 = type(arg_34_1.path) == "string" and self:GetPathByString(arg_34_1.path, arg_34_1.offset) or self:GetPathByString("LTRT")
	end

	local var_34_1 = type(arg_34_1.spine) == "table" or arg_34_1.spine == true
	local var_34_2

	if arg_34_1.spine == true then
		var_34_2 = {
			action = "walk",
			scale = 0.5
		}
	elseif var_34_1 then
		local var_34_3 = {}

		var_34_3.action = arg_34_1.spine.action or "walk"
		var_34_3.scale = arg_34_1.spine.scale or 0.5
		var_34_2 = var_34_3
	end

	local var_34_4 = {
		name = arg_34_1.name,
		isSpine = var_34_1,
		spineData = var_34_2,
		path = var_34_0,
		time = arg_34_1.time
	}

	var_34_4.delay = arg_34_1.delay or 0
	var_34_4.easeType = arg_34_1.easeType or LeanTweenType.linear

	return var_34_4
end

function StoryStep:GetMovableNode()
	if not self:ExistMovableNode() then
		return {}
	end

	local var_35_0 = {}

	for iter_35_0, iter_35_1 in pairs(self.movableNode or {}) do
		table.insert(var_35_0, (self:GenMoveNode(iter_35_1)))
	end

	return var_35_0
end

function StoryStep:OldPhotoEffect()
	return self.oldPhoto
end

function StoryStep:ShouldBgGlitchArt()
	return self.bgGlitchArt
end

function StoryStep:IsSameBranch(arg_38_1)
	return not self.branchCode or self.branchCode == arg_38_1
end

function StoryStep:IsGlobalFlagHit()
	local var_39_0 = StoryStep.GetGlobalFlagKey(self.globalBranchCode.id)
	local var_39_1 = 0

	while PlayerPrefs.HasKey(var_39_0 .. 1) do
		var_39_1 = var_39_1 + PlayerPrefs.GetInt(var_39_0 .. 1)
	end

	for iter_39_0, iter_39_1 in ipairs(self.globalBranchCode.section) do
		if var_39_1 >= iter_39_1[1] and var_39_1 <= iter_39_1[2] then
			return true
		end
	end

	return false
end

function StoryStep:GetGlobalFlagKey()
	return getProxy(PlayerProxy):getRawData().id .. "GlobalStoryFlag_" .. self .. "_"
end

function StoryStep:GetMode()
	assert(false, "should override this function")

	return
end

function StoryStep:GetFlashoutData()
	if self.flashout then
		return self.flashout.alpha[1], self.flashout.alpha[2], self.flashout.dur, self.flashout.black
	end

	return
end

function StoryStep:GetFlashinData()
	if self.flashin then
		return self.flashin.alpha[1], self.flashin.alpha[2], self.flashin.dur, self.flashin.black, self.flashin.delay
	end

	return
end

function StoryStep:GetBgColor()
	return Color.New(self.bgColor[1] or 0, self.bgColor[2] or 0, self.bgColor[3] or 0)
end

function StoryStep:IsBlackBg()
	return self.blackBg
end

function StoryStep:GetBgName()
	return self.bgName
end

function StoryStep:GetBgShadow()
	return self.bgShadow
end

function StoryStep:IsDialogueMode()
	return self:GetMode() == Story.MODE_DIALOGUE
end

function StoryStep:GetBgmData()
	return self.bgm, self.bgmDelay, self.bgmVolume
end

function StoryStep:ShoulePlayBgm()
	return self.bgm ~= nil
end

function StoryStep:ShouldStopBgm()
	return self.stopbgm
end

function StoryStep:GetEffects()
	return self.effects
end

function StoryStep:ShouldBlink()
	return self.blink ~= nil
end

function StoryStep:GetBlinkData()
	return self.blink
end

function StoryStep:ShouldBlinkWithColor()
	return self.blinkWithColor ~= nil
end

function StoryStep:GetBlinkWithColorData()
	return self.blinkWithColor
end

function StoryStep:ShouldPlaySoundEffect()
	return self.soundeffect ~= nil
end

function StoryStep:GetSoundeffect()
	return self.soundeffect, self.seDelay
end

function StoryStep:ShouldPlayVoice()
	return self.voice ~= nil
end

function StoryStep:ShouldStopVoice()
	return self.stopVoice
end

function StoryStep:GetVoice()
	return self.voice, self.voiceDelay
end

function StoryStep:ExistOption()
	return self.options ~= nil and #self.options > 0
end

function StoryStep:GetOptionCnt()
	if self:ExistOption() then
		return #self.options
	else
		return 0
	end

	return
end

function StoryStep:SetOptionSelCodes(arg_64_1)
	self.optionSelCode = arg_64_1

	return
end

function StoryStep:IsBlackFrontGround()
	local var_65_1 = Mathf.Clamp01(self.blackFg)
end

function StoryStep:GetOptionIndexByAutoSel()
	local var_66_0 = 0
	local var_66_1 = 0

	for iter_66_0, iter_66_1 in ipairs(self.options) do
		if self.optionSelCode and iter_66_1.flag == self.optionSelCode then
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

function StoryStep:IsImport()
	return self.important
end

function StoryStep:SetOptionIndex(arg_68_1)
	self.optionIndex = arg_68_1

	return
end

function StoryStep:GetOptionIndex()
	return self.optionIndex
end

function StoryStep:GetOptions()
	return _.map(self.options or {}, function(arg_71_0)
		local var_71_0 = arg_71_0.content

		if self:ShouldReplacePlayer() then
			var_71_0 = self:ReplacePlayerName(var_71_0)
		end

		if self:ShouldReplaceTb() then
			var_71_0 = self:ReplaceTbName(var_71_0)
		end

		if self:ShouldReplaceDorm() then
			var_71_0 = self:ReplaceDormName(var_71_0)
		end

		local var_71_1

		if self:ShouldReplaceCar2026() then
			var_71_0 = self:ReplaceCar2026Name(var_71_0)
			var_71_1 = {}
		end

		var_71_1[1] = HXSet.hxLan(var_71_0)
		var_71_1[2] = arg_71_0.flag
		var_71_1[3] = arg_71_0.type
		var_71_1[4] = arg_71_0.globalFlag

		return var_71_1
	end)
end

function StoryStep:ShouldJumpToNextScript()
	return self.nextScriptName ~= nil
end

function StoryStep:GetNextScriptName()
	return self.nextScriptName
end

function StoryStep:ShouldDelayEvent()
	return self.eventDelay and self.eventDelay > 0
end

function StoryStep:GetEventDelayTime()
	return self.eventDelay
end

function StoryStep:GetUsingPaintingNames()
	return {}
end

function StoryStep:GetResList()
	local var_77_0 = {}
	local var_77_1 = self:GetBgName()

	if var_77_1 then
		table.insert(var_77_0, var_77_1)
	end

	if self.GetSubBg then
		local var_77_2 = self:GetSubBg()

		if var_77_2 then
			table.insert(var_77_0, var_77_2)
		end
	end

	local var_77_3 = _.map(var_77_0, function(arg_78_0)
		return "bg/" .. arg_78_0
	end)
	local var_77_4 = {}
	local var_77_5, var_77_6, var_77_7 = self:GetBgmData()

	if var_77_5 then
		table.insert(var_77_4, var_77_5)
	end

	local var_77_8 = {}

	_.each(var_77_4, function(arg_79_0)
		table.insert(var_77_8, "cue/" .. arg_79_0 .. ".b")
		table.insert(var_77_8, "cue/bgm-" .. arg_79_0 .. ".b")

		return
	end)

	local var_77_9 = {}

	if self:ShouldPlaySoundEffect() then
		local var_77_10, var_77_11 = self:GetSoundeffect()

		if var_77_10 then
			table.insert(var_77_9, var_77_10)
		end
	end

	local var_77_12 = {}

	_.each(var_77_9, function(arg_80_0)
		local var_80_0 = pg.CriMgr.GetInstance():CheckFModeEvent(arg_80_0, function()
			return
		end, function()
			return
		end)

		if var_80_0 then
			table.insert(var_77_12, "cue/" .. var_80_0 .. ".b")
		end

		return
	end)

	local var_77_13 = {}

	if self:ShouldPlayVoice() then
		local var_77_14, var_77_15 = self:GetVoice()

		if var_77_14 then
			table.insert(var_77_13, var_77_14)
		end
	end

	local var_77_16 = {}

	_.each(var_77_13, function(arg_83_0)
		local var_83_0 = pg.CriMgr.GetInstance():CheckFModeEvent(arg_83_0, function()
			return
		end, function()
			return
		end)

		if var_83_0 then
			table.insert(var_77_16, "cue/" .. var_83_0 .. ".b")
		end

		return
	end)

	local var_77_17 = {}

	_.each(self:GetEffects(), function(arg_86_0)
		table.insert(var_77_17, arg_86_0.name)

		return
	end)

	local var_77_18 = {}

	_.each(var_77_17, function(arg_87_0)
		table.insert(var_77_18, "ui/" .. arg_87_0)
		table.insert(var_77_18, "effect/" .. arg_87_0)

		return
	end)

	local var_77_19 = {}

	if self:ExistIcon() then
		local var_77_20 = self:GetIconData()

		if var_77_20 and var_77_20.image then
			table.insert(var_77_19, var_77_20.image)
		end
	end

	local var_77_21 = {}
	local var_77_22 = StoryRecorder.New()

	var_77_22:Add(self)
	_.each(var_77_22:GetContentList(), function(arg_88_0)
		if arg_88_0.icon then
			table.insert(var_77_21, "squareicon/" .. arg_88_0.icon)
		end

		return
	end)

	return (SplitPackMediatorResMap.MergeLuaArr(var_77_3, var_77_8, var_77_12, var_77_16, var_77_18, var_77_19, var_77_21))
end

return StoryStep
