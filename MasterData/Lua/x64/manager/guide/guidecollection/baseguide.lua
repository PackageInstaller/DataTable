local BaseGuide = class("BaseGuide")

function BaseGuide:Ctor(arg_1_1)
	self:Init(arg_1_1)
end

function BaseGuide:Init(arg_2_1)
	self._starTime = 0
	self._guideId = arg_2_1
	self._cfg = GuideBaseCfg[arg_2_1]
	self.open_condition = self._cfg.open_condition
	self.is_no_home = self._cfg.is_no_home
	self.narrator_name = self._cfg.narrator_name or ""
	self.narrator_icon = self._cfg.narrator_icon or ""
	self.talk_item_path = self._cfg.talk_format or ""
	self.talk_icon_path = self._cfg.icon_path or ""
	self.group = self._cfg.group or 0
	self.ignore_group_condition = self._cfg.ignore_group_condition
end

function BaseGuide:ProduceStep(arg_3_1)
	if GuideStepCfg[arg_3_1] then
		if GuideStepCfg[arg_3_1].type == "EnterStage" then
			return EnterStageStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "WaitBattleResult" then
			return WaitBattleResultStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "ClickButton" then
			return ClickButtonStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "ClickCToggle" then
			return ClickCToggleStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "EventTrigger" then
			return EventTriggerStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "ClickButtonNoMask" then
			return ClickButtonNoMaskStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "HighLight" then
			return HighLightStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "JumpTo" then
			return JumpToStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "SetTeam" then
			return SetTeamStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "CombineGameStep" then
			return CombineGameStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "BloodCardGameStep" then
			return BloodCardGameStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "TetrisGameStep" then
			return TetrisGameStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "BilliardGameDragStep" then
			return BilliardGameDragStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "CivilizationGameStep" then
			return CivilizationGameStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "AutoChessDragStep" then
			return AutoChessDragStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "RogueCardGameStep" then
			return RogueCardGameStep.New(self, arg_3_1)
		elseif GuideStepCfg[arg_3_1].type == "RogueCardEmptyStep" then
			return RogueCardEmptyStep.New(self, arg_3_1)
		end
	end

	error("Guide Produce Step Error by Id : " .. arg_3_1)

	return nil
end

function BaseGuide:InitSteps()
	self._steps = {}

	self:OnGuideStart()

	local var_4_0 = 1

	for iter_4_0, iter_4_1 in ipairs(self._cfg.leaps) do
		if GuideTool.SatisfyCondition({
			{
				"uiName",
				iter_4_1[1]
			}
		}) then
			var_4_0 = iter_4_1[2]
		end
	end

	for iter_4_2 = var_4_0, #self._cfg.steps do
		local var_4_1 = self:ProduceStep(self._cfg.steps[iter_4_2])

		if var_4_1 then
			table.insert(self._steps, var_4_1)
		end
	end
end

function BaseGuide:OnGuideStart()
	self._starTime = Time.realtimeSinceStartup
end

function BaseGuide:CheckGuide()
	return GuideTool.SatisfyCondition(self.open_condition)
end

function BaseGuide:Check()
	if self:IsPlaying() then
		return self._steps[1]:Check()
	else
		if self:CheckGuide() and (manager.guide:CheckGroupLastTime(self.group) or #self.ignore_group_condition > 0 and GuideTool.SatisfyCondition(self.ignore_group_condition)) then
			return true
		end

		return false
	end
end

function BaseGuide:Play()
	self._steps[1]:UpdateStarTime()
	GuideTool.Log("Guide Start Step :" .. self._steps[1]:GetStepId())
	self._steps[1]:Play()
end

function BaseGuide:OnStepEnd(arg_9_1)
	local var_9_0 = arg_9_1:GetStepId()

	SDKTools.SendMessageToSDK("guide_complete", {
		guide_id = var_9_0,
		use_time = Time.realtimeSinceStartup - arg_9_1:GetStarTime()
	})
	GuideTool.Log("Guide End Step :" .. var_9_0)

	local var_9_1 = table.indexof(self._steps, arg_9_1)

	if var_9_1 then
		table.remove(self._steps, var_9_1)
	end

	manager.guide:OnStepEnd(self, not (table.length(self._steps) > 0) or self._steps[1]:GetShowMask() ~= true)

	if arg_9_1:IsFinish() then
		manager.guide:OnGuideFinish(self)
	end
end

function BaseGuide:AddSteps(arg_10_1)
	for iter_10_0 = #arg_10_1, 1, -1 do
		local var_10_0 = self:ProduceStep(arg_10_1[iter_10_0])

		if var_10_0 then
			table.insert(self._steps, 2, var_10_0)
		end
	end
end

function BaseGuide:IsPlaying()
	return self._steps ~= nil and table.length(self._steps) > 0
end

function BaseGuide:GetNarratorInfo()
	return self.narrator_name, self.narrator_icon
end

function BaseGuide:GetId()
	return self._guideId
end

function BaseGuide:IsGoToHome()
	return not self.is_no_home
end

function BaseGuide:GetStarTime()
	return self._starTime
end

function BaseGuide:AddNextStep(arg_16_1)
	local var_16_0 = self:ProduceStep(arg_16_1.id)

	if var_16_0 then
		table.insert(self._steps, 2, var_16_0)
	end
end

function BaseGuide:RemoveStep()
	table.remove(self._steps, 2)
end

function BaseGuide:Click()
	if self._steps[1] ~= nil then
		self._steps[1]:Click()
	end
end

function BaseGuide:EventTrigger(arg_19_1, arg_19_2)
	if self._steps[1] ~= nil then
		self._steps[1]:EventTrigger(arg_19_1, arg_19_2)
	end
end

function BaseGuide:BattleFinish(arg_20_1)
	if self._steps[1] ~= nil then
		self._steps[1]:BattleFinish(arg_20_1)
	end
end

function BaseGuide:FinishCurrentStep()
	if self._steps[1] ~= nil then
		self._steps[1]:OnStepEnd()
	end
end

function BaseGuide:ClearSteps()
	self._steps = nil
end

function BaseGuide:Dispose()
	return
end

return BaseGuide
