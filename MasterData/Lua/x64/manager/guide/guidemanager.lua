local GuideManager = class("GuideManager")

function GuideManager:Ctor()
	self:Init()
end

function GuideManager:Init()
	self.view = GuideView.New()
	self.weakView = GuideWeakView.New()
	self._guides = {}
	self._gorupTimes = {}
	self._timer = FrameTimer.New(handler(self, self.Process), 1, -1)
	self.stuckTime_ = GameSetting.newbie_stuck_time.value[1]
	self.startCheckTime_ = nil
end

function GuideManager:IsPlaying()
	for iter_3_0, iter_3_1 in ipairs(self._guides) do
		if iter_3_1:IsPlaying() then
			return true, iter_3_1:GetId()
		end
	end

	return false
end

function GuideManager:IsPlayingWeaking()
	if self.weakView then
		return self.weakView:GetIsInWeakGuide()
	end

	return false
end

function GuideManager:AddGuide(arg_5_1)
	if not GuideBaseCfg[arg_5_1] then
		return
	end

	if GuideData:IsFinish(arg_5_1, true) then
		return
	end

	if GuideBaseCfg[arg_5_1].skip_condition[1] ~= nil and GuideTool.SatisfyCondition(GuideBaseCfg[arg_5_1].skip_condition) then
		return
	end

	local var_5_0 = arg_5_1 == 3 and Guide_3.New(arg_5_1) or arg_5_1 == 8 and Guide_8.New(arg_5_1) or arg_5_1 == 1101 and Guide_1101.New(arg_5_1) or arg_5_1 == 14 and Guide_14.New(arg_5_1) or arg_5_1 == 15 and Guide_15.New(arg_5_1) or arg_5_1 == 17 and Guide_17.New(arg_5_1) or arg_5_1 == 19 and Guide_19.New(arg_5_1) or (arg_5_1 == 27 or arg_5_1 == 29) and Guide_skuld.New(arg_5_1) or arg_5_1 == 28 and Guide_28.New(arg_5_1) or arg_5_1 == 4601 and Guide_4601.New(arg_5_1) or arg_5_1 == 53 and Guide_53.New(arg_5_1) or arg_5_1 == 60 and Guide_60.New(arg_5_1) or arg_5_1 == 73 and Guide_73.New(arg_5_1) or arg_5_1 == 74 and Guide_74.New(arg_5_1) or arg_5_1 == 76 and Guide_76.New(arg_5_1) or arg_5_1 == 93 and Guide_93.New(arg_5_1) or arg_5_1 == 94 and Guide_94.New(arg_5_1) or arg_5_1 == 95 and Guide_95.New(arg_5_1) or arg_5_1 == 96 and Guide_96.New(arg_5_1) or arg_5_1 == 98 and Guide_98.New(arg_5_1) or arg_5_1 == 108 and Guide_108.New(arg_5_1) or arg_5_1 == 109 and Guide_109.New(arg_5_1) or arg_5_1 == 111 and Guide_111.New(arg_5_1) or arg_5_1 == 350 and Guide_350.New(arg_5_1) or arg_5_1 == 353 and Guide_353.New(arg_5_1) or arg_5_1 == 354 and Guide_354.New(arg_5_1) or arg_5_1 == 508 and Guide_508.New(arg_5_1) or arg_5_1 == 509 and Guide_509.New(arg_5_1) or arg_5_1 == 510 and Guide_510.New(arg_5_1) or arg_5_1 == 511 and Guide_511.New(arg_5_1) or arg_5_1 == 514 and Guide_514.New(arg_5_1) or BaseGuide.New(arg_5_1)

	if var_5_0 ~= nil then
		var_5_0:ClearSteps()
		table.insert(self._guides, var_5_0)
	end
end

function GuideManager:InitGuide()
	if PlayerPrefs.GetInt("OpenGuide", 0) == 1 then
		local var_6_0 = PlayerPrefs.GetString("Editor_Test_Guide_List", "")

		if var_6_0 ~= "" then
			local var_6_1, var_6_2 = pcall(load, "return " .. var_6_0)

			if not var_6_1 then
				return
			end

			local var_6_3 = var_6_2

			if var_6_2 == nil then
				return
			end

			local var_6_4, var_6_5 = pcall(var_6_3)

			if not var_6_4 then
				return
			end

			if type(var_6_5) ~= "table" then
				return
			end

			self._guides = {}

			for iter_6_0, iter_6_1 in ipairs(var_6_5) do
				self:AddGuide(iter_6_1)
			end

			if table.length(self._guides) > 0 then
				self:Process()
				self._timer:Start()
			end
		end

		return true
	end

	self._guides = {}

	for iter_6_2, iter_6_3 in ipairs(GuideBaseCfg.all) do
		self:AddGuide(iter_6_3)
	end

	if table.length(self._guides) > 0 then
		self:Process()
		self._timer:Start()
	end
end

function GuideManager:Process()
	for iter_7_0, iter_7_1 in ipairs(self._guides) do
		if iter_7_1:IsPlaying() then
			if iter_7_1:Check() then
				self:onStepStart(iter_7_1)
				iter_7_1:Play()
				self:ClearStuck()
			else
				self:CheckStuck(iter_7_1)
			end

			return
		end
	end

	for iter_7_2, iter_7_3 in ipairs(self._guides) do
		if iter_7_3:Check() and manager.story.player_ == nil and not manager.posterGirl:IsPlayingDebut() and not gameContext:GetOpenPageHandler("assetPendPop") then
			if gameContext:GetLastOpenPage() == "PureModeView" then
				gameContext:Go("/home", {
					isHomeBack = true
				}, nil, true)
			end

			iter_7_3:InitSteps()
			GuideTool.Log("GuideBase Start id :" .. iter_7_3:GetId())

			if self.weakView:GetIsInWeakGuide() then
				self.weakView:Hide(true)
			end

			if GuideBaseCfg[iter_7_3:GetId()].is_no_home then
				manager.audio:PlayEffect("ui_battle", "ui_battle_stopbgm")
			end

			manager.notify:Invoke(GUIDE_START)

			return
		end
	end
end

function GuideManager:onStepStart()
	self._timer:Stop()
end

local function var_0_1(arg_9_0)
	if GuideBaseCfg.get_id_list_by_not_skip_guide[1] == nil then
		return false
	end

	return table.indexof(GuideBaseCfg.get_id_list_by_not_skip_guide[1], arg_9_0:GetId())
end

function GuideManager:CheckStuck(arg_10_1)
	self.startCheckTime_ = self.startCheckTime_ or Time.time

	if Time.time - self.startCheckTime_ > self.stuckTime_ and not self.ignoreStuck_ and arg_10_1 ~= nil and not var_0_1(arg_10_1) then
		self.view:ShowBreakStuck(arg_10_1, true)

		self.ignoreStuck_ = true

		GuideTool.Log("GuideBase Stuck id :" .. arg_10_1:GetId())
	end
end

function GuideManager:SetIgnoreStuck(arg_11_1)
	self.ignoreStuck_ = arg_11_1
end

function GuideManager:ClearStuck()
	self.startCheckTime_ = nil

	self.view:ShowBreakStuck(nil, false)

	self.ignoreStuck_ = false
end

function GuideManager:OnStepEnd(arg_13_1, arg_13_2)
	if arg_13_2 then
		self.view:Hide()
	else
		self.view:HideButton()
	end

	if arg_13_1:IsPlaying() then
		self._timer:Start()
	else
		self:OnGuideEnd(arg_13_1)

		local var_13_0 = table.indexof(self._guides, arg_13_1)

		if var_13_0 then
			table.remove(self._guides, var_13_0)
		end

		if table.length(self._guides) > 0 then
			self._timer:Start()
		else
			SendMessageManagerToSDK("tutorial_complete")
		end
	end
end

function GuideManager:OnGuideFinish(arg_14_1)
	local var_14_0 = arg_14_1:GetId()

	NewPlayerGuideAction.GuideUpdateID(var_14_0)
	SendMessageManagerToSDK("tutorial", {
		guideId = var_14_0
	})

	if var_14_0 == 8 then
		SendMessageManagerToSDK("tutorial_complete")
	end

	GuideTool.Log("GuideBase Finish id :" .. arg_14_1:GetId())
end

function GuideManager:OnGuideEnd(arg_15_1)
	local var_15_0 = arg_15_1:GetId()
	local var_15_1 = Time.realtimeSinceStartup - arg_15_1:GetStarTime()

	NewPlayerGuideAction.GuideUpdateIDEnd(var_15_0, var_15_1)
	GuideTool.Log("GuideBase End id :" .. arg_15_1:GetId() .. "  useTime : " .. var_15_1)
	self:UpdateGroupLastTime(GuideBaseCfg[var_15_0].group)
end

function GuideManager:SkipGuide(arg_16_1)
	self:ClearStuck()
	self:OnGuideFinish(arg_16_1)

	local var_16_0 = table.indexof(self._guides, arg_16_1)

	if var_16_0 then
		table.remove(self._guides, var_16_0)
	end
end

function GuideManager:SkipGuideStep()
	for iter_17_0, iter_17_1 in ipairs(self._guides) do
		if iter_17_1:IsPlaying() then
			return iter_17_1._steps[1]:OnStepEnd()
		end
	end
end

function GuideManager:PaseGuide(arg_18_1)
	local var_18_0 = table.indexof(self._guides, arg_18_1)

	if var_18_0 then
		table.remove(self._guides, var_18_0)
	end
end

function GuideManager:SkipAll()
	return
end

function GuideManager:OnComponentClick()
	for iter_20_0, iter_20_1 in ipairs(self._guides) do
		if iter_20_1:IsPlaying() then
			iter_20_1:Click()
		end
	end
end

function GuideManager:OnEventTrigger(arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in ipairs(self._guides) do
		if iter_21_1:IsPlaying() then
			iter_21_1:EventTrigger(arg_21_1, arg_21_2)
		end
	end
end

function GuideManager:OnBattleFinish(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(self._guides) do
		if iter_22_1:IsPlaying() then
			iter_22_1:BattleFinish(arg_22_1)
		end
	end
end

function GuideManager:IsGoToHome()
	for iter_23_0, iter_23_1 in ipairs(self._guides) do
		if iter_23_1:IsPlaying() then
			return iter_23_1:IsGoToHome()
		end
	end

	return true
end

function GuideManager:OnLogout()
	self._timer:Stop()

	for iter_24_0, iter_24_1 in ipairs(self._guides) do
		iter_24_1:Dispose()
	end

	self._guides = {}
	self._gorupTimes = {}

	self.view:Dispose()
	self.weakView:Dispose()
end

function GuideManager:Dispose()
	self:OnLogout()
end

local var_0_2

function GuideManager:GetIntervalTime()
	if var_0_2 ~= nil then
		return var_0_2
	end

	if GameSetting.guide_base_time then
		var_0_2 = GameSetting.guide_base_time.value[1] or 0
	end

	return var_0_2
end

function GuideManager:UpdateGroupLastTime(arg_27_1)
	if arg_27_1 == 0 then
		return
	end

	self._gorupTimes[arg_27_1] = os.time()
end

function GuideManager:CheckGroupLastTime(arg_28_1)
	if arg_28_1 == 0 then
		return true
	else
		return self:GetIntervalTime() < os.time() - (self._gorupTimes[arg_28_1] or 0)
	end
end

function GuideManager:ShowWeakView(arg_29_1, arg_29_2, arg_29_3)
	self.weakView:Init()
	self.weakView:UpdateView(arg_29_1, arg_29_2, arg_29_3)
end

function GuideManager:GetCurrentGuideStepID()
	for iter_30_0, iter_30_1 in ipairs(self._guides) do
		if iter_30_1:IsPlaying() then
			return iter_30_1._steps[1]._stepId
		end
	end

	return 0
end

function GuideManager:FinishCurrentStep()
	for iter_31_0, iter_31_1 in ipairs(self._guides) do
		if iter_31_1:IsPlaying() then
			iter_31_1:FinishCurrentStep()
		end
	end
end

function GuideManager:GetGuideIsOpen(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(self._guides) do
		if iter_32_1:GetId() == arg_32_1 then
			return true
		end
	end

	return false
end

function GuideManager:GetIsSkipBattleResultGuide()
	local var_33_0, var_33_1 = self:IsPlaying()

	if GameSetting.guide_base_stage_result_skip then
		if var_33_0 and table.indexof(GameSetting.guide_base_stage_result_skip.value or {}, var_33_1) then
			return true
		end
	end

	return false
end

return GuideManager
