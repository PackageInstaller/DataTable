local Story = class("Story")

Story.MODE_ASIDE = 1
Story.MODE_DIALOGUE = 2
Story.MODE_BG = 3
Story.MODE_CAROUSE = 4
Story.MODE_VEDIO = 5
Story.MODE_CAST = 6
Story.MODE_SPANIM = 7
Story.MODE_BLINK = 8
Story.MODE_TDDIALOGUE = 9
Story.MODE_SUBPAGE = 10
Story.STORY_AUTO_SPEED = {
	-9,
	0,
	5,
	9
}
Story.TRIGGER_DELAY_TIME = {
	4,
	3,
	1.5,
	0
}

function Story:GetStoryStepCls()
	return ({
		AsideStep,
		DialogueStep,
		BgStep,
		CarouselStep,
		VedioStep,
		CastStep,
		SpAnimStep,
		BlinkStep,
		TDDialogueStep,
		SubPageStep
	})[self]
end

Story.PLAYER = 2
Story.TB = 4
Story.DORM = 8
Story.CAR2026 = 16
Story.PlaceholderMap = {
	playername = Story.PLAYER,
	tb = Story.TB,
	dorm3d = Story.DORM,
	car2026 = Story.CAR2026
}
Story.PLAY_TYPE_STORY = 1
Story.PLAY_TYPE_BUBBLE = 2

function Story:Ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	self.name = arg_2_1.id
	self.mode = arg_2_1.mode
	self.playType = arg_2_1.playType or Story.PLAY_TYPE_STORY
	self.once = arg_2_1.once
	self.fadeOut = arg_2_1.fadeOut
	self.hideSkip = defaultValue(arg_2_1.hideSkip, false)
	self.skipTip = defaultValue(arg_2_1.skipTip, true)
	self.noWaitFade = defaultValue(arg_2_1.noWaitFade, false)
	self.dialogueBox = arg_2_1.dialogbox or 1
	self.interaction = defaultValue(arg_2_1.interaction, false)
	self.defaultTb = arg_2_1.defaultTb
	self.placeholder = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.placeholder or {}) do
		local var_2_0 = Story.PlaceholderMap[iter_2_1] or 0

		assert(var_2_0 > 0, iter_2_1)

		self.placeholder = bit.bor(self.placeholder, var_2_0)
	end

	self.hideRecord = defaultValue(arg_2_1.hideRecord, false)
	self.hideAutoBtn = defaultValue(arg_2_1.hideAuto, false)
	self.storyAlpha = self:IsTDDMode() and defaultValue(arg_2_1.alpha, 0) or defaultValue(arg_2_1.alpha, 0.568)

	if UnGamePlayState then
		self.speedData = arg_2_1.speed or 0
	else
		local var_2_1 = arg_2_1.speed

		if not arg_2_1.speed then
			var_2_1 = getProxy(SettingsProxy):GetStorySpeed()
			var_2_1 = var_2_1 or 0
		end

		self.speedData = var_2_1
	end

	self.steps = {}

	local var_2_2 = 0
	local var_2_3 = arg_2_3 or {}
	local var_2_4 = {}

	self.globalOptionBranchJump = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.scripts or {}) do
		local var_2_6 = Story.GetStoryStepCls(iter_2_3.mode or self.mode).New(iter_2_3)

		if var_2_6:IsValid(arg_2_6) then
			if var_2_6:IsDialogueMode() and self:IsDialogueStyle2() then
				var_2_6:SetDefaultSide()
			end

			var_2_6:SetId(iter_2_2)
			var_2_6:SetPlaceholderType(self:GetPlaceholder())
			var_2_6:SetDefaultTb(self.defaultTb)

			if var_2_6:ExistOption() then
				var_2_2 = var_2_2 + 1

				var_2_6:SetOptionIndex(var_2_2)

				if var_2_3[var_2_2] then
					var_2_6:SetOptionSelCodes(var_2_3[var_2_2])
				end

				if arg_2_4 then
					var_2_6.important = true
				end

				table.insert(var_2_4, iter_2_2)

				if arg_2_5 then
					var_2_6:AutoShowOption()
				end
			end

			table.insert(self.steps, var_2_6)
		end

		if iter_2_3.globalOptionFlag and iter_2_3.jumpto then
			table.insert(self.globalOptionBranchJump, iter_2_3.jumpto)
		end
	end

	if #self.steps > 0 then
		table.insert(var_2_4, #self.steps)
	end

	self:HandleRecallOptions(var_2_4)

	self.branchCode = nil
	self.force = arg_2_2

	if UnGamePlayState then
		self.isPlayed = false
	else
		self.isPlayed = pg.NewStoryMgr.GetInstance():IsPlayed(self.name)
	end

	self.nextScriptName = nil
	self.skipAll = false
	self.isAuto = false
	self.speed = 0

	return
end

function Story:IsTDDMode()
	return self.mode and self.mode == Story.MODE_TDDIALOGUE
end

function Story:GetPlayType()
	return self.playType
end

function Story:IsBubbleType()
	return self.playType == Story.PLAY_TYPE_BUBBLE
end

function Story:CanInteraction()
	return self.interaction
end

function Story:HandleRecallOptions(arg_7_1)
	local function var_7_0(arg_8_0, arg_8_1)
		local var_8_0 = {}

		for iter_8_0 = arg_8_0, arg_8_1 do
			table.insert(var_8_0, self.steps[iter_8_0])
		end

		return {
			var_8_0,
			self.steps[arg_8_0]:GetOptionCnt(),
			arg_8_1,
			arg_8_0
		}
	end

	local function var_7_1(arg_9_0)
		for iter_9_0 = arg_9_0, 1, -1 do
			if self.steps[iter_9_0] and self.steps[iter_9_0].branchCode ~= nil then
				return iter_9_0
			end
		end

		assert(false)

		return
	end

	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if self.steps[iter_7_1]:IsRecallOption() then
			if iter_7_1 and arg_7_1[iter_7_0 + 1] then
				table.insert(var_7_2, var_7_0(iter_7_1, (var_7_1(arg_7_1[iter_7_0 + 1]))))
			end
		end
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_2) do
		for iter_7_4 = 1, iter_7_3[2] - 1 do
			for iter_7_5, iter_7_6 in ipairs(iter_7_3[1]) do
				local var_7_4 = Clone(iter_7_6)

				var_7_4:SetId(iter_7_3[4])
				table.insert(self.steps, iter_7_3[3] + 0 + iter_7_5, var_7_4)
			end
		end
	end

	return
end

function Story:GetPlaceholder()
	return self.placeholder
end

function Story:ShouldReplaceContent()
	return self.placeholder > 0
end

function Story:GetStoryAlpha()
	return self.storyAlpha
end

function Story:ShouldHideAutoBtn()
	return self.hideAutoBtn
end

function Story:ShouldHideRecord()
	return self.hideRecord
end

function Story:GetDialogueStyleName()
	return self.dialogueBox
end

function Story:IsDialogueStyle2()
	return self:GetDialogueStyleName() == 2
end

function Story:GetAnimPrefix()
	return switch(self:GetDialogueStyleName(), {
		function()
			return "anim_storydialogue_optiontpl_"
		end,
		function()
			return "anim_newstory_dialogue2_"
		end
	})
end

function Story:GetTriggerDelayTime()
	local var_20_0 = table.indexof(Story.STORY_AUTO_SPEED, self.speed)

	if var_20_0 then
		return Story.TRIGGER_DELAY_TIME[var_20_0] or 0
	end

	return 0
end

function Story:SetAutoPlay()
	self.isAuto = true

	self:SetPlaySpeed(self.speedData)

	return
end

function Story:UpdatePlaySpeed()
	local var_22_0 = getProxy(SettingsProxy):GetStorySpeed()

	var_22_0 = var_22_0 or 0

	self:SetPlaySpeed(var_22_0)

	return
end

function Story:GetPlaySpeed()
	return self.speed
end

function Story:StopAutoPlay()
	self.isAuto = false

	self:ResetSpeed()

	return
end

function Story:SetPlaySpeed(arg_25_1)
	self.speed = arg_25_1

	return
end

function Story:ResetSpeed()
	self.speed = 0

	return
end

function Story:GetPlaySpeed()
	return self.speed
end

function Story:GetAutoPlayFlag()
	return self.isAuto
end

function Story:ShowSkipTip()
	return self.skipTip
end

function Story:ShouldWaitFadeout()
	return not self.noWaitFade
end

function Story:ShouldHideSkip()
	return self.hideSkip
end

function Story:CanPlay()
	return self.force or not self.isPlayed
end

function Story:GetId()
	return self.name
end

function Story:GetName()
	return self.name
end

function Story:GetStepByIndex(arg_35_1)
	if not self.steps[arg_35_1] or self.branchCode and not self.steps[arg_35_1]:IsSameBranch(self.branchCode) or self.steps[arg_35_1].globalBranchCode and not self.steps[arg_35_1]:IsGlobalFlagHit() then
		return nil
	end

	return self.steps[arg_35_1]
end

function Story:GetNextStep(arg_36_1)
	if arg_36_1 >= #self.steps then
		return nil
	end

	local var_36_0 = arg_36_1 + 1
	local var_36_1 = self:GetStepByIndex(arg_36_1 + 1)

	if not var_36_1 and var_36_0 < #self.steps then
		return self:GetNextStep(var_36_0)
	else
		return var_36_1
	end

	return
end

function Story:GetPrevStep(arg_37_1)
	if arg_37_1 <= 1 then
		return nil
	end

	local var_37_0 = arg_37_1 - 1
	local var_37_1 = self:GetStepByIndex(arg_37_1 - 1)

	if not var_37_1 and var_37_0 > 1 then
		return self:GetPrevStep(var_37_0)
	else
		return var_37_1
	end

	return
end

function Story:ShouldFadeout()
	return self.fadeOut ~= nil
end

function Story:GetFadeoutTime()
	return self.fadeOut
end

function Story:IsPlayed()
	return self.isPlayed
end

function Story:SetBranchCode(arg_41_1)
	self.branchCode = arg_41_1

	return
end

function Story:GetBranchCode()
	return self.branchCode
end

function Story:GetNextScriptName()
	return self.nextScriptName
end

function Story:SetNextScriptName(arg_44_1)
	self.nextScriptName = arg_44_1

	return
end

function Story:SkipAll()
	self.skipAll = true

	return
end

function Story:StopSkip()
	self.skipAll = false

	return
end

function Story:ShouldSkipAll()
	return self.skipAll
end

function Story:GetUsingPaintingNames()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs(self.steps) do
		for iter_48_2, iter_48_3 in ipairs((iter_48_1:GetUsingPaintingNames())) do
			var_48_0[iter_48_3] = true
		end
	end

	local var_48_1 = {}

	for iter_48_4, iter_48_5 in pairs(var_48_0) do
		table.insert(var_48_1, iter_48_4)
	end

	return var_48_1
end

function Story:GetAllStepDispatcherRecallName()
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(self.steps) do
		local var_49_1 = iter_49_1:GetDispatcherRecallName()

		if var_49_1 then
			var_49_0[var_49_1] = true
		end
	end

	local var_49_2 = {}

	for iter_49_2, iter_49_3 in pairs(var_49_0) do
		table.insert(var_49_2, iter_49_2)
	end

	return var_49_2
end

function Story:GlobalOptionBranch()
	return self.globalOptionBranchJump
end

return Story
