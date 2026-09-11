local ColorPuzzleGameView = class("ColorPuzzleGameView", ReduxView)
local var_0_1 = 53100

function ColorPuzzleGameView:GetLevelRoot()
	return "Widget/System/SPHeroChallenge/ColorPuzzle/Levels/"
end

function ColorPuzzleGameView:UIName()
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleGameView"
end

function ColorPuzzleGameView:UIParent()
	return manager.ui.uiMain.transform
end

function ColorPuzzleGameView:OnCtor()
	self.level = nil
	self.letMeTry, self.totalTry = nil
	self.gameLevel = nil
	self.useAutoComplete = nil
	self.time = nil
end

function ColorPuzzleGameView:Init()
	self:BindCfgUI()
	self:InitUI()
end

local function var_0_2()
	return nullable(GameSetting, "activity_hero_challenge_color_cost", "value", 1) or 0
end

local function var_0_3(arg_7_0)
	if var_0_2() <= ItemTools.getItemNum(var_0_1) then
		return true
	elseif arg_7_0 then
		ShowTips("ACTIVITY_HERO_CHALLENGE_COIN_LACK")
	end

	return false
end

function ColorPuzzleGameView:InitUI()
	self.costItemIcon_.sprite = ItemTools.getItemLittleSprite(var_0_1)

	local var_8_0 = var_0_2()

	if not var_0_3() then
		var_8_0 = "<color=#FF0000>" .. var_8_0 .. "</color>"
	end

	self.costAmount_.text = var_8_0
	self.autoCompleteController = self.controllers_:GetController("autoComplete")
	self.completeHighlightController = self.controllers_:GetController("complete")

	self:AddBtnListenerScale(self.autoCompleteBtn_, nil, function()
		if self.gameLevel and not self.gameLevel:CheckComplete() and self.autoCompleteController:GetSelectedState() == "ready" and var_0_3(true) then
			self.gameLevel:AutoComplete()

			self.useAutoComplete = true

			self.completeHighlightController:SetSelectedState("true")
		end
	end)
	self:AddBtnListenerScale(self.clearAllBtn_, nil, function()
		if self.gameLevel then
			self.gameLevel:ClearNodes()

			if not self.reset then
				self.reset = true

				self:ReportClear()
			end
		end
	end)
	self:AddBtnListenerScale(self.checkCompleteBtn_, nil, function()
		if self.gameLevel and self.gameLevel:CheckComplete(true) then
			self:StopTimeWatch()
			self:EndGame()
		end
	end)
end

function ColorPuzzleGameView:OnEnter()
	self.level = self.params_.level

	self:DisposeGame()

	self.gameLevel = Object.Instantiate(Asset.Load(self:GetLevelRoot() .. ActivityHeroChallengeColor[self.level].level_asset_name), self.levelContainer_):GetComponent("ColorPuzzle")

	self.autoCompleteController:SetSelectedState("lock")

	self.letMeTry, self.totalTry = ActivityHeroChallengeColor[self.level].attempt, ActivityHeroChallengeColor[self.level].attempt

	self:SetupGameCallbacks()
	self:ResetGame()

	self.pause = false

	self:StartTimeWatch()
	self:SetTips(ActivityHeroChallengeColor[self.level])
end

function ColorPuzzleGameView:OnExit()
	self:StopTimeWatch()
	self:DisposeGame()
end

local function var_0_4(arg_14_0)
	if not arg_14_0.pause then
		arg_14_0.pause = true

		ShowMessageBox({
			content = GetTips("ACTIVITY_HERO_COLOR_EXIT"),
			OkCallback = function()
				arg_14_0.pause = false

				arg_14_0:EndGame(true)
			end,
			CancelCallback = function()
				arg_14_0.pause = false
			end
		})
	end
end

function ColorPuzzleGameView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		var_0_1
	})
	manager.windowBar:RegistBackCallBack(handler(self, var_0_4))
end

function ColorPuzzleGameView:OnBehind()
	manager.windowBar:HideBar()
end

function ColorPuzzleGameView:OnExit()
	manager.windowBar:HideBar()
end

function ColorPuzzleGameView:DisposeGame()
	if self.gameLevel then
		Object.Destroy(self.gameLevel.gameObject)

		self.gameLevel = nil
	end
end

function ColorPuzzleGameView:SetupGameCallbacks()
	self.gameLevel:SetBeforeApplyValueCallback(function(arg_22_0, arg_22_1)
		if arg_22_0 ~= arg_22_1 then
			self.letMeTry = self.letMeTry - 1

			self:UpdateAutoComplete()
		end
	end)
	self.gameLevel:SetOnNodeClickCallback(function(arg_23_0)
		self.completeHighlightController:SetSelectedState(arg_23_0 and "true" or "false")
	end)
end

function ColorPuzzleGameView:UpdateAutoComplete()
	if self.letMeTry > 0 then
		self.autoCompleteProgress_.fillAmount = 1 - self.letMeTry / self.totalTry

		self.autoCompleteController:SetSelectedState("lock")
	else
		self.autoCompleteProgress_.fillAmount = 1

		if not self.gameLevel:CheckComplete() then
			self.autoCompleteController:SetSelectedState("ready")
		else
			self.autoCompleteController:SetSelectedState("lock")
		end
	end
end

function ColorPuzzleGameView:StartTimeWatch()
	self:StopTimeWatch()

	self.time = 0
	self.updateTicker = FuncTimerManager.inst:CreateFuncFrameTimer(handler(self, self.Update), -1, true)
end

function ColorPuzzleGameView:StopTimeWatch()
	if self.updateTicker then
		FuncTimerManager.inst:RemoveFuncTimer(self.updateTicker)

		self.updateTicker = nil
	end
end

function ColorPuzzleGameView:Update()
	self.time = ((not self.time or nil) and 0) + (self.pause and 0 or Time.unscaledDeltaTime)
end

function ColorPuzzleGameView:EndGame(arg_28_1)
	local var_28_0 = {
		stage_id = self.level,
		result = arg_28_1 and 3 or 1,
		useseconds = self.time,
		auto_completed = self.useAutoComplete and 1 or 0
	}

	self:ResetGame()

	if not arg_28_1 then
		ColorPuzzleAction.LevelClearAction(var_28_0, function(arg_29_0, arg_29_1)
			JumpTools.OpenPageByJump("colorPuzzleResultPopup", {
				level = arg_29_0.stage_id,
				time = arg_29_0.useseconds,
				autoComplete = arg_29_0.auto_completed == 1,
				rewards = arg_29_1.reward_list,
				okCallback = JumpTools.Back
			})
		end)
	else
		JumpTools.Back()
	end

	self:SendSdkMsg(var_28_0)
end

function ColorPuzzleGameView:ResetGame()
	self.time = 0
	self.useAutoComplete = false

	self.gameLevel:ClearNodes()
	self:UpdateAutoComplete()
	self.completeHighlightController:SetSelectedState("false")
end

function ColorPuzzleGameView:ReportClear()
	self:SendSdkMsg({
		auto_completed = 0,
		result = 4,
		stage_id = self.level,
		useseconds = self.time
	})
end

function ColorPuzzleGameView:SendSdkMsg(arg_32_1)
	local var_32_0 = SPHeroChallengeData:GetActivityID()
	local var_32_1 = {
		activity_id = ActivityTools.GetAllSubActivityByTemplate(var_32_0, SPHeroChallengeData.activityCfg[var_32_0].colorPuzzleActiVityTemplate)[1],
		stage_id = arg_32_1.stage_id,
		result = arg_32_1.result,
		use_seconds = arg_32_1.useseconds
	}

	var_32_1.is_help = self.useAutoComplete or false

	SDKTools.SendMessageToSDK("activity_combat_over", var_32_1)
end

function ColorPuzzleGameView:SetTips(arg_33_1)
	local var_33_0 = nullable(arg_33_1, "tips_icon")

	if var_33_0 == "" then
		SetActive(self.tipsIcon_, false)
	else
		SetActive(self.tipsIcon_, true)

		self.tipsIcon_.sprite = pureGetSpriteWithoutAtlas(var_33_0)
	end

	self.tipsContent_.text = GetI18NText(arg_33_1.tips)
end

return ColorPuzzleGameView
