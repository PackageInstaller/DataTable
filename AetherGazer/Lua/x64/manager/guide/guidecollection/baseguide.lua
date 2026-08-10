local var_0_0 = class("BaseGuide")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:Init(arg_1_1)
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0._starTime = 0
	arg_2_0._guideId = arg_2_1
	arg_2_0._cfg = GuideBaseCfg[arg_2_1]
	arg_2_0.open_condition = arg_2_0._cfg.open_condition
	arg_2_0.is_no_home = arg_2_0._cfg.is_no_home
	arg_2_0.narrator_name = arg_2_0._cfg.narrator_name or ""
	arg_2_0.narrator_icon = arg_2_0._cfg.narrator_icon or ""
	arg_2_0.talk_item_path = arg_2_0._cfg.talk_format or ""
	arg_2_0.talk_icon_path = arg_2_0._cfg.icon_path or ""
	arg_2_0.group = arg_2_0._cfg.group or 0
	arg_2_0.ignore_group_condition = arg_2_0._cfg.ignore_group_condition
end

function var_0_0.ProduceStep(arg_3_0, arg_3_1)
	local var_3_0 = GuideStepCfg[arg_3_1]

	if var_3_0 then
		local var_3_1 = var_3_0.type

		if var_3_1 == "EnterStage" then
			return EnterStageStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "WaitBattleResult" then
			return WaitBattleResultStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "ClickButton" then
			return ClickButtonStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "ClickCToggle" then
			return ClickCToggleStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "EventTrigger" then
			return EventTriggerStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "ClickButtonNoMask" then
			return ClickButtonNoMaskStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "HighLight" then
			return HighLightStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "JumpTo" then
			return JumpToStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "SetTeam" then
			return SetTeamStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "CombineGameStep" then
			return CombineGameStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "BloodCardGameStep" then
			return BloodCardGameStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "TetrisGameStep" then
			return TetrisGameStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "BilliardGameDragStep" then
			return BilliardGameDragStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "CivilizationGameStep" then
			return CivilizationGameStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "AutoChessDragStep" then
			return AutoChessDragStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "RogueCardGameStep" then
			return RogueCardGameStep.New(arg_3_0, arg_3_1)
		elseif var_3_1 == "RogueCardEmptyStep" then
			return RogueCardEmptyStep.New(arg_3_0, arg_3_1)
		end
	end

	error("Guide Produce Step Error by Id : " .. arg_3_1)

	return nil
end

function var_0_0.InitSteps(arg_4_0)
	arg_4_0._steps = {}

	arg_4_0:OnGuideStart()

	local var_4_0 = arg_4_0._cfg.steps
	local var_4_1 = 1
	local var_4_2 = arg_4_0._cfg.leaps

	for iter_4_0, iter_4_1 in ipairs(var_4_2) do
		local var_4_3 = iter_4_1[1]
		local var_4_4 = iter_4_1[2]

		if GuideTool.SatisfyCondition({
			{
				"uiName",
				var_4_3
			}
		}) then
			var_4_1 = var_4_4
		end
	end

	local var_4_5 = #var_4_0

	for iter_4_2 = var_4_1, var_4_5 do
		local var_4_6 = var_4_0[iter_4_2]
		local var_4_7 = arg_4_0:ProduceStep(var_4_6)

		if var_4_7 then
			table.insert(arg_4_0._steps, var_4_7)
		end
	end
end

function var_0_0.OnGuideStart(arg_5_0)
	arg_5_0._starTime = Time.realtimeSinceStartup
end

function var_0_0.CheckGuide(arg_6_0)
	return GuideTool.SatisfyCondition(arg_6_0.open_condition)
end

function var_0_0.Check(arg_7_0)
	if arg_7_0:IsPlaying() then
		return arg_7_0._steps[1]:Check()
	else
		if arg_7_0:CheckGuide() and (manager.guide:CheckGroupLastTime(arg_7_0.group) or #arg_7_0.ignore_group_condition > 0 and GuideTool.SatisfyCondition(arg_7_0.ignore_group_condition)) then
			return true
		end

		return false
	end
end

function var_0_0.Play(arg_8_0)
	local var_8_0 = arg_8_0._steps[1]:GetStepId()

	arg_8_0._steps[1]:UpdateStarTime()
	GuideTool.Log("Guide Start Step :" .. var_8_0)
	arg_8_0._steps[1]:Play()
end

function var_0_0.OnStepEnd(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetStepId()
	local var_9_1 = arg_9_1:GetStarTime()
	local var_9_2 = Time.realtimeSinceStartup - var_9_1

	SDKTools.SendMessageToSDK("guide_complete", {
		guide_id = var_9_0,
		use_time = var_9_2
	})
	GuideTool.Log("Guide End Step :" .. var_9_0)

	local var_9_3 = table.indexof(arg_9_0._steps, arg_9_1)

	if var_9_3 then
		table.remove(arg_9_0._steps, var_9_3)
	end

	local var_9_4 = not (table.length(arg_9_0._steps) > 0) or arg_9_0._steps[1]:GetShowMask() ~= true

	manager.guide:OnStepEnd(arg_9_0, var_9_4)

	if arg_9_1:IsFinish() then
		manager.guide:OnGuideFinish(arg_9_0)
	end
end

function var_0_0.AddSteps(arg_10_0, arg_10_1)
	for iter_10_0 = #arg_10_1, 1, -1 do
		local var_10_0 = arg_10_1[iter_10_0]
		local var_10_1 = arg_10_0:ProduceStep(var_10_0)

		if var_10_1 then
			table.insert(arg_10_0._steps, 2, var_10_1)
		end
	end
end

function var_0_0.IsPlaying(arg_11_0)
	return arg_11_0._steps ~= nil and table.length(arg_11_0._steps) > 0
end

function var_0_0.GetNarratorInfo(arg_12_0)
	return arg_12_0.narrator_name, arg_12_0.narrator_icon
end

function var_0_0.GetId(arg_13_0)
	return arg_13_0._guideId
end

function var_0_0.IsGoToHome(arg_14_0)
	return not arg_14_0.is_no_home
end

function var_0_0.GetStarTime(arg_15_0)
	return arg_15_0._starTime
end

function var_0_0.AddNextStep(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.id
	local var_16_1 = arg_16_0:ProduceStep(var_16_0)

	if var_16_1 then
		table.insert(arg_16_0._steps, 2, var_16_1)
	end
end

function var_0_0.RemoveStep(arg_17_0)
	table.remove(arg_17_0._steps, 2)
end

function var_0_0.Click(arg_18_0)
	local var_18_0 = arg_18_0._steps[1]

	if var_18_0 ~= nil then
		var_18_0:Click()
	end
end

function var_0_0.EventTrigger(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._steps[1]

	if var_19_0 ~= nil then
		var_19_0:EventTrigger(arg_19_1, arg_19_2)
	end
end

function var_0_0.BattleFinish(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._steps[1]

	if var_20_0 ~= nil then
		var_20_0:BattleFinish(arg_20_1)
	end
end

function var_0_0.FinishCurrentStep(arg_21_0)
	local var_21_0 = arg_21_0._steps[1]

	if var_21_0 ~= nil then
		var_21_0:OnStepEnd()
	end
end

function var_0_0.ClearSteps(arg_22_0)
	arg_22_0._steps = nil
end

function var_0_0.Dispose(arg_23_0)
	return
end

return var_0_0
