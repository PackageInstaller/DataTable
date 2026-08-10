local var_0_0 = class("GuideManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.view = GuideView.New()
	arg_2_0.weakView = GuideWeakView.New()
	arg_2_0._guides = {}
	arg_2_0._gorupTimes = {}
	arg_2_0._timer = FrameTimer.New(handler(arg_2_0, arg_2_0.Process), 1, -1)
	arg_2_0.stuckTime_ = GameSetting.newbie_stuck_time.value[1]
	arg_2_0.startCheckTime_ = nil
end

function var_0_0.IsPlaying(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._guides) do
		if iter_3_1:IsPlaying() then
			return true, iter_3_1:GetId()
		end
	end

	return false
end

function var_0_0.IsPlayingWeaking(arg_4_0)
	if arg_4_0.weakView then
		return arg_4_0.weakView:GetIsInWeakGuide()
	end

	return false
end

function var_0_0.AddGuide(arg_5_0, arg_5_1)
	local var_5_0 = GuideBaseCfg[arg_5_1]

	if not var_5_0 then
		return
	end

	if GuideData:IsFinish(arg_5_1, true) then
		return
	end

	if var_5_0.skip_condition[1] ~= nil and GuideTool.SatisfyCondition(var_5_0.skip_condition) then
		return
	end

	local var_5_1

	if arg_5_1 == 3 then
		var_5_1 = Guide_3.New(arg_5_1)
	elseif arg_5_1 == 8 then
		var_5_1 = Guide_8.New(arg_5_1)
	elseif arg_5_1 == 1101 then
		var_5_1 = Guide_1101.New(arg_5_1)
	elseif arg_5_1 == 14 then
		var_5_1 = Guide_14.New(arg_5_1)
	elseif arg_5_1 == 15 then
		var_5_1 = Guide_15.New(arg_5_1)
	elseif arg_5_1 == 17 then
		var_5_1 = Guide_17.New(arg_5_1)
	elseif arg_5_1 == 19 then
		var_5_1 = Guide_19.New(arg_5_1)
	elseif arg_5_1 == 27 or arg_5_1 == 29 then
		var_5_1 = Guide_skuld.New(arg_5_1)
	elseif arg_5_1 == 28 then
		var_5_1 = Guide_28.New(arg_5_1)
	elseif arg_5_1 == 4601 then
		var_5_1 = Guide_4601.New(arg_5_1)
	elseif arg_5_1 == 53 then
		var_5_1 = Guide_53.New(arg_5_1)
	elseif arg_5_1 == 60 then
		var_5_1 = Guide_60.New(arg_5_1)
	elseif arg_5_1 == 73 then
		var_5_1 = Guide_73.New(arg_5_1)
	elseif arg_5_1 == 74 then
		var_5_1 = Guide_74.New(arg_5_1)
	elseif arg_5_1 == 76 then
		var_5_1 = Guide_76.New(arg_5_1)
	elseif arg_5_1 == 93 then
		var_5_1 = Guide_93.New(arg_5_1)
	elseif arg_5_1 == 94 then
		var_5_1 = Guide_94.New(arg_5_1)
	elseif arg_5_1 == 95 then
		var_5_1 = Guide_95.New(arg_5_1)
	elseif arg_5_1 == 96 then
		var_5_1 = Guide_96.New(arg_5_1)
	elseif arg_5_1 == 98 then
		var_5_1 = Guide_98.New(arg_5_1)
	elseif arg_5_1 == 108 then
		var_5_1 = Guide_108.New(arg_5_1)
	elseif arg_5_1 == 109 then
		var_5_1 = Guide_109.New(arg_5_1)
	elseif arg_5_1 == 111 then
		var_5_1 = Guide_111.New(arg_5_1)
	elseif arg_5_1 == 350 then
		var_5_1 = Guide_350.New(arg_5_1)
	elseif arg_5_1 == 353 then
		var_5_1 = Guide_353.New(arg_5_1)
	elseif arg_5_1 == 354 then
		var_5_1 = Guide_354.New(arg_5_1)
	elseif arg_5_1 == 508 then
		var_5_1 = Guide_508.New(arg_5_1)
	elseif arg_5_1 == 509 then
		var_5_1 = Guide_509.New(arg_5_1)
	elseif arg_5_1 == 510 then
		var_5_1 = Guide_510.New(arg_5_1)
	elseif arg_5_1 == 511 then
		var_5_1 = Guide_511.New(arg_5_1)
	elseif arg_5_1 == 514 then
		var_5_1 = Guide_514.New(arg_5_1)
	else
		var_5_1 = BaseGuide.New(arg_5_1)
	end

	if var_5_1 ~= nil then
		var_5_1:ClearSteps()
		table.insert(arg_5_0._guides, var_5_1)
	end
end

function var_0_0.InitGuide(arg_6_0)
	if PlayerPrefs.GetInt("OpenGuide", 0) == 1 then
		local var_6_0 = PlayerPrefs.GetString("Editor_Test_Guide_List", "")

		if var_6_0 ~= "" then
			local var_6_1, var_6_2 = pcall(load, "return " .. var_6_0)

			if not var_6_1 then
				return
			end

			local var_6_3 = var_6_2

			if var_6_3 == nil then
				return
			end

			local var_6_4, var_6_5 = pcall(var_6_3)

			if not var_6_4 then
				return
			end

			if type(var_6_5) ~= "table" then
				return
			end

			arg_6_0._guides = {}

			for iter_6_0, iter_6_1 in ipairs(var_6_5) do
				arg_6_0:AddGuide(iter_6_1)
			end

			if table.length(arg_6_0._guides) > 0 then
				arg_6_0:Process()
				arg_6_0._timer:Start()
			end
		end

		return true
	end

	arg_6_0._guides = {}

	for iter_6_2, iter_6_3 in ipairs(GuideBaseCfg.all) do
		arg_6_0:AddGuide(iter_6_3)
	end

	if table.length(arg_6_0._guides) > 0 then
		arg_6_0:Process()
		arg_6_0._timer:Start()
	end
end

function var_0_0.Process(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._guides) do
		if iter_7_1:IsPlaying() then
			if iter_7_1:Check() then
				arg_7_0:onStepStart(iter_7_1)
				iter_7_1:Play()
				arg_7_0:ClearStuck()
			else
				arg_7_0:CheckStuck(iter_7_1)
			end

			return
		end
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0._guides) do
		if iter_7_3:Check() and manager.story.player_ == nil and not manager.posterGirl:IsPlayingDebut() and not gameContext:GetOpenPageHandler("assetPendPop") then
			if gameContext:GetLastOpenPage() == "PureModeView" then
				gameContext:Go("/home", {
					isHomeBack = true
				}, nil, true)
			end

			iter_7_3:InitSteps()
			GuideTool.Log("GuideBase Start id :" .. iter_7_3:GetId())

			if arg_7_0.weakView:GetIsInWeakGuide() then
				arg_7_0.weakView:Hide(true)
			end

			if GuideBaseCfg[iter_7_3:GetId()].is_no_home then
				manager.audio:PlayEffect("ui_battle", "ui_battle_stopbgm")
			end

			manager.notify:Invoke(GUIDE_START)

			return
		end
	end
end

function var_0_0.onStepStart(arg_8_0)
	arg_8_0._timer:Stop()
end

local function var_0_1(arg_9_0)
	local var_9_0 = GuideBaseCfg.get_id_list_by_not_skip_guide[1]

	if var_9_0 == nil then
		return false
	end

	return table.indexof(var_9_0, arg_9_0:GetId())
end

function var_0_0.CheckStuck(arg_10_0, arg_10_1)
	arg_10_0.startCheckTime_ = arg_10_0.startCheckTime_ or Time.time

	if Time.time - arg_10_0.startCheckTime_ > arg_10_0.stuckTime_ and not arg_10_0.ignoreStuck_ and arg_10_1 ~= nil and not var_0_1(arg_10_1) then
		arg_10_0.view:ShowBreakStuck(arg_10_1, true)

		arg_10_0.ignoreStuck_ = true

		GuideTool.Log("GuideBase Stuck id :" .. arg_10_1:GetId())
	end
end

function var_0_0.SetIgnoreStuck(arg_11_0, arg_11_1)
	arg_11_0.ignoreStuck_ = arg_11_1
end

function var_0_0.ClearStuck(arg_12_0)
	arg_12_0.startCheckTime_ = nil

	arg_12_0.view:ShowBreakStuck(nil, false)

	arg_12_0.ignoreStuck_ = false
end

function var_0_0.OnStepEnd(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		arg_13_0.view:Hide()
	else
		arg_13_0.view:HideButton()
	end

	if arg_13_1:IsPlaying() then
		arg_13_0._timer:Start()
	else
		arg_13_0:OnGuideEnd(arg_13_1)

		local var_13_0 = table.indexof(arg_13_0._guides, arg_13_1)

		if var_13_0 then
			table.remove(arg_13_0._guides, var_13_0)
		end

		if table.length(arg_13_0._guides) > 0 then
			arg_13_0._timer:Start()
		else
			SendMessageManagerToSDK("tutorial_complete")
		end
	end
end

function var_0_0.OnGuideFinish(arg_14_0, arg_14_1)
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

function var_0_0.OnGuideEnd(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetId()
	local var_15_1 = arg_15_1:GetStarTime()
	local var_15_2 = Time.realtimeSinceStartup - var_15_1

	NewPlayerGuideAction.GuideUpdateIDEnd(var_15_0, var_15_2)
	GuideTool.Log("GuideBase End id :" .. arg_15_1:GetId() .. "  useTime : " .. var_15_2)

	local var_15_3 = GuideBaseCfg[var_15_0]

	arg_15_0:UpdateGroupLastTime(var_15_3.group)
end

function var_0_0.SkipGuide(arg_16_0, arg_16_1)
	arg_16_0:ClearStuck()
	arg_16_0:OnGuideFinish(arg_16_1)

	local var_16_0 = table.indexof(arg_16_0._guides, arg_16_1)

	if var_16_0 then
		table.remove(arg_16_0._guides, var_16_0)
	end
end

function var_0_0.SkipGuideStep(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._guides) do
		if iter_17_1:IsPlaying() then
			return iter_17_1._steps[1]:OnStepEnd()
		end
	end
end

function var_0_0.PaseGuide(arg_18_0, arg_18_1)
	local var_18_0 = table.indexof(arg_18_0._guides, arg_18_1)

	if var_18_0 then
		table.remove(arg_18_0._guides, var_18_0)
	end
end

function var_0_0.SkipAll(arg_19_0)
	return
end

function var_0_0.OnComponentClick(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._guides) do
		if iter_20_1:IsPlaying() then
			iter_20_1:Click()
		end
	end
end

function var_0_0.OnEventTrigger(arg_21_0, arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0._guides) do
		if iter_21_1:IsPlaying() then
			iter_21_1:EventTrigger(arg_21_1, arg_21_2)
		end
	end
end

function var_0_0.OnBattleFinish(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._guides) do
		if iter_22_1:IsPlaying() then
			iter_22_1:BattleFinish(arg_22_1)
		end
	end
end

function var_0_0.IsGoToHome(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0._guides) do
		if iter_23_1:IsPlaying() then
			return iter_23_1:IsGoToHome()
		end
	end

	return true
end

function var_0_0.OnLogout(arg_24_0)
	arg_24_0._timer:Stop()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._guides) do
		iter_24_1:Dispose()
	end

	arg_24_0._guides = {}
	arg_24_0._gorupTimes = {}

	arg_24_0.view:Dispose()
	arg_24_0.weakView:Dispose()
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0:OnLogout()
end

local var_0_2

function var_0_0.GetIntervalTime(arg_26_0)
	if var_0_2 ~= nil then
		return var_0_2
	end

	var_0_2 = GameSetting.guide_base_time and GameSetting.guide_base_time.value[1] or 0

	return var_0_2
end

function var_0_0.UpdateGroupLastTime(arg_27_0, arg_27_1)
	if arg_27_1 == 0 then
		return
	end

	arg_27_0._gorupTimes[arg_27_1] = os.time()
end

function var_0_0.CheckGroupLastTime(arg_28_0, arg_28_1)
	if arg_28_1 == 0 then
		return true
	else
		local var_28_0 = arg_28_0._gorupTimes[arg_28_1] or 0

		return arg_28_0:GetIntervalTime() < os.time() - var_28_0
	end
end

function var_0_0.ShowWeakView(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0.weakView:Init()
	arg_29_0.weakView:UpdateView(arg_29_1, arg_29_2, arg_29_3)
end

function var_0_0.GetCurrentGuideStepID(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0._guides) do
		if iter_30_1:IsPlaying() then
			return iter_30_1._steps[1]._stepId
		end
	end

	return 0
end

function var_0_0.FinishCurrentStep(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0._guides) do
		if iter_31_1:IsPlaying() then
			iter_31_1:FinishCurrentStep()
		end
	end
end

function var_0_0.GetGuideIsOpen(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0._guides) do
		if iter_32_1:GetId() == arg_32_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetIsSkipBattleResultGuide(arg_33_0)
	local var_33_0, var_33_1 = arg_33_0:IsPlaying()
	local var_33_2 = GameSetting.guide_base_stage_result_skip and GameSetting.guide_base_stage_result_skip.value or {}

	if var_33_0 and table.indexof(var_33_2, var_33_1) then
		return true
	end

	return false
end

return var_0_0
